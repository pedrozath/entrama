class Product < ActiveRecord::Base
    extend FriendlyId
    belongs_to :collection, counter_cache: true
    has_one :icon
    has_many :photos
    has_many :order_products
    has_many :orders, through: :order_products
    friendly_id :slug_candidates, use: [:slugged, :finders]

    attr_accessor :use_existing_image, :image
    attr_accessor :icon_image

    def slug_candidates
        [
            [:garb_type, :collection_title, :color, :fabric, :size]
        ]
    end

    def collection_title
        self.collection.title
    end

    # validates :size, :garb_type, :fabric, :color,
    # :quantity, :price, presence: true

    # # validates :icon, presence: true, unless: -> (p){p.use_existing_image.present?}
    # validates :use_existing_image, presence: true, if: "image.nil?"

    default_scope { where('quantity > 0')}

    scope :by_icon, -> do
        @products_by_icon = Icon.order(:image_id).collect(&:product).compact
        @stray_products = Product.all - @products_by_icon
        @products = @products_by_icon + @stray_products
    end

    scope :by_collection, -> do
        all.joins(:collection).order("title")
    end

    scope :unique, -> do
        all.includes(icon:[:image]).inject([]) do |memo, p|
            if !memo.map{|m|m.icon_image}.include?(p.icon_image)
                memo << p
            end
            memo
        end
    end

    before_destroy :destroy_associated

    def icon_image(version=nil)
        if self.icon
            self.icon.image.file.url version
        else
            ActionController::Base.helpers.asset_path("product-fallback.jpg")
        end
    end

    def icon_image_big
        icon_image :big
    end

    def thumb
        icon_image :thumb
    end

    def formatted_price
        ActionController::Base.helpers.number_to_currency price
    end

    def title
        ["##{id} ",collection.title,garb_type,fabric,size].join " "
    end

    def size_index size
        %w[p m g gg].each_with_index.map{|s,i| {s => i}}.reduce({},:merge)[size]
    end

    def available_sizes
        if icon
            available_sizes = similar_products.reduce([]) do |memo, p|
                memo << {size:p.size,id:p.id} unless memo.map{|m|m[:size]}.include? p.size
                memo
            end

            available_sizes.sort { |a,b|
                size_index(a[:size]) <=> size_index(b[:size])
            }

        else
            [{size: size, id: id}]
        end
    end

    def similar_products
        if icon
            Icon.where(image_id: icon.image.id).includes(:product).map{|i|i.product}.compact
        else
            []
        end
    end

    private

    def destroy_associated
        self.icon.delete if self.icon
        self.photos.delete_all
    end


end
