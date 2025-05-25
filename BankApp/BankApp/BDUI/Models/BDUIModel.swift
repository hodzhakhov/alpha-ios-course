import Foundation

struct BDUIModel: Decodable {
    let type: BDUIComponentType
    let content: BDUIContent
    let subviews: [BDUIModel]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case content
        case subviews
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let typeString = try container.decode(String.self, forKey: .type)
        guard let componentType = BDUIComponentType(rawValue: typeString) else {
            throw BDUIError.invalidComponentType
        }
        self.type = componentType
        
        let contentData = try container.decode(BDUIContent.self, forKey: .content)
        self.content = contentData
        
        self.subviews = try container.decodeIfPresent([BDUIModel].self, forKey: .subviews)
    }
} 