#= require jquery
#= require jquery_ujs
#= require mustache.min
#= require turbolinks
#= require product_crud
#= require icon_manager
#= require product_interface

# class BasketInterface
#     constructor: (options) ->
#         for key, value of options 
#             this[key] = options[key]

#         @data = @main_element.data()
#         for key, value of @data
#             this[key] = @data[key]

#         @main_element.find("[data-increase-quantity]").click (e) =>
#             product_id = $(e.currentTarget).closest("tr").attr "data-product-id"
#             $.get url: "basket/add_product/#{product_id}"
#             location.reload()

#         @main_element.find("[data-decrease-quantity]").click (e) =>
#             product_id = $(e.currentTarget).closest("tr").attr "data-product-id"
#             $.get url: "basket/remove_product/#{product_id}"
#             location.reload()

$ -> 
    $(".product-crud").each -> new ProductCRUD main_element: $(this)
    $("[data-icon-manager]").each -> new IconManager main_element: $(this)
    $("[data-product-interface]").each -> new ProductInterface main_element: $(this)
    $("[data-basket-interface]").each -> new BasketInterface main_element: $(this)