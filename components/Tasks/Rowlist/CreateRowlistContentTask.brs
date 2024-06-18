sub init()
end sub

sub execute()
    headers = {}
    headers["Authorization"] = "Bearer " + m.global.apiKey
    headers["accept"] = "application/json"
    imageConfig = getImageConfig(headers)
    response = getContent(headers)
    num = 0

    content = createObject("RoSGNode", "ContentNode")

    for i = 0 to response.results.count() - 1
        catalog = response.results[i]
        if i mod 8 = 0
            section = content.createChild("ContentNode")
            section.title = "Section " + ((i / 8) + 1 + num).toStr()
        end if
        item = section.createChild("ContentNode")
        item.title = catalog.title
        item.HDPOSTERURL = imageConfig.baseUrl + "/" + imageConfig.rowlistSize + "/" + catalog.poster_path
        item.addFields({"description": catalog.overview})
        item.addFields({"date": catalog.release_date})
        item.addFields({"detailImage":imageConfig.baseUrl + "/" + imageConfig.detailSize + "/" + catalog.poster_path })
    end for
    m.top.output = content 
end sub 

function getImageConfig(headers = invalid)
    url = m.global.config.endPoints.imageConfig
    response = makeHttpRequest(url, headers)

    config = invalid
    if response <> invalid 
        config = {
            baseUrl: response.images.base_url,
            rowlistSize: response.images.poster_sizes[2],
            detailSize: response.images.profile_sizes[2] 'to keep fixed height
        }
    end if 
    
    return config
end function

function getContent(headers = invalid)
    url = m.global.config.endPoints.movieContent
    url += "&with_genres=" + m.top.genreId.toStr()
    response = makeHttpRequest(url, headers)
    
    return response
end function

function makeHttpRequest(url as String, headers = invalid)
    request = CreateObject("roUrlTransfer")
    request.setUrl(url)
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.initClientCertificates()
    request.setHeaders(headers)

    stringObject = request.getToString()
    response = parseJson(stringObject)

    return response
end function