sub init()
    getConfig()
    bindBaseComponents()
    buildNavigationHandler()
end sub

sub bindBaseComponents()
    m.spinner = m.top.findNode("spinner")
    setApiKey()
    setConfigSpinner()
end sub

sub getConfig()
    configObj = parseJson(ReadAsciiFile("pkg:/components/config/config.json"))
    m.global.addFields({
        "config": configObj.config
    })
end sub

sub buildNavigationHandler()
    m.navigationHandler = m.top.findNode("navigationHandler")
    m.navigationHandler.callFunc("initialize", m.global.config.navigationMap)
    m.global.addFields({
        navigationHandler: m.navigationHandler
    })
    showHomeScreen()
end sub 

sub showHomeScreen()
    m.global.navigationHandler.callFunc("navigateTo", {
        "viewName": "home"
        "viewParams": {}
    })
end sub

sub setApiKey()
    m.global.addFields({
        apiKey: m.global.config.apiKey
    })
end sub 

sub setConfigSpinner()
    m.spinner.poster.uri = "pkg:/images/loadingImage.png"
    m.spinner.setFields({
        "translation": [
            900,
            500
        ],
        "loadDisplayMode": "scaleToFill"
        "loadWidth": 90,
        "loadHeight": 90,
        "visible": false
    })
    m.global.addFields({
        loading: false
    })
    m.global.observeFieldScoped("loading", "onLoadingChanged")
end sub 

sub onLoadingChanged()
    loading = m.global.loading
    m.spinner.visible = loading
    if (loading) then
        m.spinner.setFocus(true)
    else
        currentScreen = m.global.navigationHandler.callFunc("getCurrentScreen")
        if currentScreen <> invalid
            currentScreen.setFocus(true)
        end if
    end if
end sub