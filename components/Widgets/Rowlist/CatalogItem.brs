sub init()
    bindBaseComponents()
end sub

sub bindBaseComponents()
    m.focusedBackground = m.top.findNode("focusedBackground")
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.poster = m.top.findNode("poster")
    m.title = m.top.findNode("title")
    m.title.font = getFont("pkg:/components/fonts/Book.ttf", 20)        
end sub

sub onItemContentChanged()
    m.item = m.top.itemContent
    m.title.text = m.item.TITLE
    m.poster.uri = m.item.HDPOSTERURL
end sub

