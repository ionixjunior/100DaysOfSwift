extension Folder {
    enum CodingKeys: String, CodingKey {
        case name
        case totalNotes = "total_notes"
        case type
        case location
    }
}
