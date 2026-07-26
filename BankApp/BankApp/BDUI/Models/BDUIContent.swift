struct BDUIContent: Decodable {
    let style: String?
    let backgroundColor: String?
    let text: String?
    let spacing: String?
    let action: BDUIAction?
    
    enum CodingKeys: String, CodingKey {
        case style
        case backgroundColor
        case text
        case spacing
        case action
    }
}
