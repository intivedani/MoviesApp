sub init()
    bindBaseComponents()
    bindObservers()
end sub

sub bindBaseComponents()
    m.homeRowList = m.top.findNode("homeRowList")
    m.genresSelection = m.top.findNode("genresSelection")
    m.genresStack = {}
    m.defaultFocusId =  m.genresSelection.id
    createGenresTask()
end sub

sub bindObservers()
    m.genresSelection.observeField("itemSelected", "loadCategoryContent")
    m.homeRowList.observeField("rowItemSelected", "onMovieSelected")
    m.genresSelection.observeField("itemFocused", "onItemFocusedChanged")
end sub

sub onViewParamsChanged(event as Object)
    viewParams = event.getData()
    m.pageConfig = viewParams.pageConfig
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if (press = true)
        if (key = "down" and m.genresSelection.isInFocusChain())
            m.homeRowList.setFocus(true)
            handled = true
        else if (key = "up" and m.homeRowList.isInFocusChain())
            m.genresSelection.setFocus(true)
            handled = true
        end if
    end if
    return handled
end function

sub createGenresTask()
    m.generesTask = CreateObject("roSGNode", "CreateMarkupContentTask")
    m.generesTask.observeField("output", "onGenresReceived")
    m.generesTask.control = "RUN"
end sub

sub onGenresReceived()
    m.genresSelection.content = m.generesTask.output
    m.generesTask.control = "STOP"
    m.generesTask.unobserveField("output")
    m.generesTask = invalid
end sub

sub createRowlistContentTask(genreId)
    m.contentTask = CreateObject("roSGNode", "CreateRowlistContentTask")
    m.contentTask.genreId =  genreId
    m.contentTask.observeField("output", "onContentReceived")
    m.contentTask.control = "RUN"
end sub

sub onContentReceived()
    m.homeRowList.content = m.contentTask.output
    m.genresStack[m.contentTask.genreId] = m.contentTask.output
    m.contentTask.control = "STOP"
    m.contentTask.unobserveField("output")
    m.contentTask = invalid
    m.global.loading = false
end sub

sub onItemFocusedChanged(event as object)
    if event.getData() <> -1 
        m.genresSelection.unobserveField("itemFocused")
        loadCategoryContent(m.genresSelection.itemFocused)
    end if
end sub

sub loadCategoryContent(index = -1 as integer)
    m.global.loading = true
    if index = -1 then index = m.genresSelection.itemSelected
    genre = m.genresSelection.content.getChild(index)
    if m.genresStack.doesExist(genre.id)
        m.homeRowList.content = m.genresStack[genre.id]
        m.global.loading = false
    else
        createRowlistContentTask(genre.id)
    end if
end sub

sub onMovieSelected()
    rowIndex = m.homeRowList.rowItemFocused[0]
    itemIndex = m.homeRowList.rowItemFocused[1]
    itemContent = m.homeRowList.content.getChild(rowIndex).getChild(itemIndex)
    displayDetailsView(itemContent)
end sub

sub  displayDetailsView(itemContent)
    m.global.navigationHandler.callFunc("navigateTo", {
        "viewName": "detail"
        "viewParams": {contentInfo: itemContent}
    })
end sub
