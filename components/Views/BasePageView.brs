sub init()
    bindBaseObservers()
    m.defaultFocusId = ""
end sub

sub initialize(viewParams as Object)
    pageConfig = viewParams.pageConfig
    if (pageConfig = invalid) then return
    stylePage(pageConfig)
    m.top.viewParams = viewParams
end sub

sub bindBaseObservers()
    m.top.observeField("focusedChild", "saveDefaultFocus")
end sub

'''''''''
' stylePage:
'''''''''
sub stylePage(pageConfig as Object)
    configKeys = pageConfig.keys()
    for i = 0 to configKeys.count() - 1 step 1
        key = configKeys[i]
        if (m[key] <> invalid) 
            m[key].setFields(pageConfig[key])
        end if
    end for
end sub

sub saveDefaultFocus(msg as Object)
    focusNode = getFocusNode(msg.getData())
    if (focusNode <> invalid AND m[focusNode.id] <> invalid AND m.defaultFocusId <> focusNode.id)
        m.defaultFocusId = focusNode.id
    end if
    if (m.top.hasFocus() AND m.defaultFocusId <> "" AND m[m.defaultFocusId] <> invalid)
        m[m.defaultFocusId].setFocus(true)
    end if
end sub

function getFocusNode(node) as Object
    focusNode = invalid
    if (node <> invalid)
        focusNode = node
        if (focusNode.id <> focusNode.focusedChild.id AND m[focusNode.focusedChild.id] <> invalid)
            return getFocusNode(focusNode.focusedChild)
        end if
    end if
    return focusNode
end function
