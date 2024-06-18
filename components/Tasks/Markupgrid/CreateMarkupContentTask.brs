sub init()
end sub

sub execute()
    headers = {}
    headers["Authorization"] = "Bearer " + m.global.apiKey
    headers["accept"] = "application/json"
    response = getContent(headers)

    content = createObject("RoSGNode", "ContentNode") 

    for i = 1 to response.genres.count() - 1
        genre = response.genres[i]
        item = content.createChild("ContentNode")
        item.title = genre.name
        item.id = genre.id
    end for

    m.top.output = content 
end sub 

function getContent(headers = invalid)
    request = CreateObject("roUrlTransfer")
    url = m.global.config.endPoints.genre
    request.setUrl(url)
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.initClientCertificates()

    request.setHeaders(headers)
    stringObject = request.getToString()
    response = parseJson(stringObject)
    
    return response
end function