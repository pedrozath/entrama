class FacebookAPI
    constructor: ->
        window.fbAsyncInit = ->
            FB.init
                appId      : '760929640709861'
                xfbml      : true
                version    : 'v2.6'

        fjs = document.getElementsByTagName('script')[0]
        if (document.getElementById('facebook-jssdk')) 
            return

        js = document.createElement('script')
        js.id = 'facebook-jssdk'
        js.src = "//connect.facebook.net/en_US/sdk.js"
        fjs.parentNode.insertBefore(js, fjs)

@FacebookAPI = FacebookAPI