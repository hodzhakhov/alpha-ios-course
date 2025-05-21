struct Feature {
    let type: FeatureType
    
    var id: String {
        return type.rawValue
    }
    
    var title: String {
        return type.title
    }
    
    var description: String {
        return type.description
    }
}
