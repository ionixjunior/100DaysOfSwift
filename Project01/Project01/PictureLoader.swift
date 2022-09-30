struct PictureLoader {
    static func loadPicturesFrom(content: [String]) -> [Picture] {
        var pictures = [Picture]()
        
        var position = 1
        for picture in content {
            if picture.hasPrefix("nssl") {
                pictures.append(Picture(position: position, name: picture))
                position += 1
            }
        }
        
        return pictures
    }
}
