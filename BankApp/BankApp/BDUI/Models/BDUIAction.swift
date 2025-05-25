enum BDUIActionType: String {
    case print
    case navigate
    case reload
}

struct BDUIAction: Decodable {
    let type: BDUIActionType
    let context: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case context
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let typeString = try container.decode(String.self, forKey: .type)
        guard let actionType = BDUIActionType(rawValue: typeString) else {
            throw BDUIError.invalidActionType
        }
        self.type = actionType
        
        self.context = try container.decodeIfPresent([String: String].self, forKey: .context)
    }
}
