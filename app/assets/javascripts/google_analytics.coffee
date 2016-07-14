class GoogleAnalytics
    constructor: (options) ->
        @[k] = options[k] for k, v of options

        window.GoogleAnalyticsObject ?= "ga"
        window.ga ?= =>
            ga.q ?= []
            ga.q.push arguments
            ga.l = 1 * new Date()

            a = document.createElement('script')
            m = document.getElementsByTagName('script')[0]
            a.async = 1
            a.src = @library_path
            m.parentNode.insertBefore a, m

        ga 'create', 'UA-77209537-1', 'auto'
        ga 'require', 'ec'

    bind_events: ->
        $("[data-analytics-purchase]").on "touchend click", (e) ->
            e.preventDefault()
            alert "Você será agora redirecionado para o PagSeguro onde poderá calcular o frete e efetuar o pagamento"
            ga 'ec:setAction', 'purchase',
                step: 3
                id: session_id

            window.location = $(e.currentTarget).attr "href"

@GoogleAnalytics = GoogleAnalytics