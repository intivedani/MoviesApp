sub init()
    bindBaseComponents()
    bindObservers()
end sub

sub bindBaseComponents()
    m.mainLayoutGroup = m.top.findNode("mainLayoutGroup")
    m.detailInformation = m.top.findNode("detailInformation")
    m.title = m.top.findNode("title")
    m.subtitle = m.top.findNode("subtitle")
    m.description = m.top.findNode("description")
    m.profileImage = m.top.findNode("profileImage")
    setStyles()
end sub

sub bindObservers()
end sub

sub onViewParamsChanged(event as Object)
    viewParams = event.getData()
    m.title.text = viewParams.contentInfo.TITLE
    m.profileImage.uri = viewParams.contentInfo.detailImage
    m.subtitle.text = "Release date: " + viewParams.contentInfo.date
    m.description.text = viewParams.contentInfo.description
end sub

sub setStyles()
    m.title.font = getFont("pkg:/components/fonts/coolvetica.otf", 45)    
    m.subtitle.font = getFont("pkg:/components/fonts/Black.ttf", 30)  
    m.description.font = getFont("pkg:/components/fonts/Book.ttf", 28)  
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if (press = true)
        if (key = "back")
            m.global.navigationHandler.callFunc("goToPrevious")
            handled = true
        end if
    end if

    return handled
end function
