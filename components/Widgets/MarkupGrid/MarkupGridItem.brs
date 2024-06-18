sub init()
    bindBaseComponents()
end sub

sub bindBaseComponents()
    m.focusedBackground = m.top.findNode("focusedBackground")
    m.rectangle = m.top.findNode("rectangle")
    m.genre = m.top.findNode("genre")
    m.genre.font = getFont("pkg:/components/fonts/coolvetica.otf", 28)    
end sub

sub onItemContentChanged()
    m.item = m.top.itemContent
    m.genre.text = m.item.title
end sub

sub onUserHasFocus()
    if m.top.focusPercent > 0.5 then
        m.focusedBackground.visible = true
    else
        m.focusedBackground.visible = false
    end if
end sub