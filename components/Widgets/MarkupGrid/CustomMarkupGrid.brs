
sub init()
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if (press = true) then
        if (key = "right")
            if (m.top.itemFocused = m.top.content.getChildCount() - 1)
                m.top.jumpToItem = 0
                handled = true
            end if
        else if (key = "left")
            if (m.top.itemFocused = 0)
                m.top.jumpToItem = m.top.content.getChildCount() - 1
                handled = true
            end if
        end if
    end if
    return handled
end function
