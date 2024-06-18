sub init()
    m.name = m.top.subtype()
    m.viewGroup = m.top.findNode("viewGroup")
    m.viewStack = [] 
end sub

'''''''''
' initialize: Set viewMap
' 
' @param {dynamic} navigationMap: Views in the app
'''''''''
sub initialize(navigationMap)
    m.viewMap = navigationMap
end sub

'''''''''
' navigateTo: Transitions to the next screen
' 
' @param {object} params
'''''''''
sub navigateTo(params as Object)
    view = createView(params)
    if (view <> invalid)
        m.viewStack.push(view)
        appentToViewGroup(view)
    end if
end sub

'''''''''
' appentToViewGroup: Adds a view to the viewport
' 
' @param {object} view
'''''''''
sub appentToViewGroup(view as Object)
    if (m.viewGroup.getChildCount() > 0)
        m.viewGroup.replaceChild(view, 0) '(newChild as Node, index)
    else
        m.viewGroup.appendChild(view)
    end if
    view.setFocus(true)
end sub


'''''''''
' getCurrentScreen: Obtains the current screen shown in the viewport
' 
' @return {dynamic}
'''''''''
function getCurrentScreen()
    currentScreen = invalid
    if (m.viewGroup.getChildCount() > 0) 'The number of child nodes in the tree
        currentScreen = m.viewGroup.getChild(0)
    end if

    return currentScreen
end function

'''''''''
' goToPrevious: Go to the previous view on the stackViews
' 
'''''''''
sub goToPrevious() as Boolean
    if m.viewStack.count() <= 1
        return false
    else
        m.viewStack.pop()
        previousView = m.viewStack.peek()
        appentToViewGroup(previousView)
        previousView.callFunc("update")
        return true
    end if
end sub

'''''''''
' createView: Create and returns a view 
' @param {object} params: Contains viewName: name of the view to be created
'''''''''
sub createView(params as Object) as Object
    if (params <> invalid AND params.viewName <> invalid)
        viewNode = m.viewMap[params.viewName].node
        if (viewNode <> invalid)
            view = createObject("roSGNode", viewNode)
            if (view <> invalid)
                view.id = params.viewName
                pageConfig = readPageConfig(params.viewName)
                if (pageConfig <> invalid) then params.viewParams.addReplace("pageConfig", pageConfig)
                view.callFunc("initialize", params.viewParams) 
                return view
            end if
        end if
    end if
    return invalid
end sub

'''''''''
' readPageConfig: Relate each json to its own view
' 
' @param {string} viewName
' @return {object}
'''''''''
function readPageConfig(viewName as String) as Object
    pageConfigPath = m.viewMap[viewName].pageConfig
    if (pageConfigPath = invalid OR pageConfigPath.len() = 0) then return invalid

    stringConfig = readAsciiFile("pkg:/components/config/pages/" + pageConfigPath)

    return parseJson(stringConfig)
end function
