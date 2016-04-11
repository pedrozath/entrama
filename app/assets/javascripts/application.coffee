#= require jquery
#= require jquery_ujs
#= require mustache.min
#= require turbolinks
#= require product_crud
#= require icon_manager
#= require art_manager
#= require product_interface

$ -> 
    $(".product-crud").each -> new ProductCRUD main_element: $(this)
    $("[data-icon-manager]").each -> new IconManager main_element: $(this)
    $("[data-art-manager]").each -> new ArtManager main_element: $(this)
    $("[data-product-interface]").each -> new ProductInterface main_element: $(this)
    $("[data-basket-interface]").each -> new BasketInterface main_element: $(this)