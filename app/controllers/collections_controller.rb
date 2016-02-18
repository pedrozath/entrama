class CollectionsController < ApplicationController
    def index
    end

    def show
        @collection ||= Collection.find params[:id]
        @product ||= @collection.products.new
    end

    def update
        @collection = Collection.find params[:id]
        @collection.update_attribute params[:field], params[:value]
        render text: params
        # @collection.update_attributes params
    end

    def create
        collection = Collection.create params[:collection].permit(:title,:price,:description)
        redirect_to :back
    end

    def destroy
        Collection.find(params[:id]).destroy
        redirect_to :back
    end
end
