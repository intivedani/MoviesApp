function getFont(uri as String, size as Integer) as Object
    font = createObject("roSGNode", "Font")
    font.size = size
    font.uri = uri

    return font
end function
