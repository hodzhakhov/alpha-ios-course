import Foundation

final class CacheService<T: Codable> {
    private let key: String
    private let expirationInterval: TimeInterval
    private let cache: NSCache<NSString, CacheItem>
    
    private class CacheItem {
        let object: Data
        let timestamp: Date
        
        init(object: Data, timestamp: Date) {
            self.object = object
            self.timestamp = timestamp
        }
    }
    
    init(key: String, expiration: TimeInterval = 3600) {
        self.key = key
        self.expirationInterval = expiration
        self.cache = NSCache<NSString, CacheItem>()
        self.cache.name = "CacheService_\(key)"
    }
    
    func save(_ object: T) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        let item = CacheItem(object: data, timestamp: Date())
        cache.setObject(item, forKey: key as NSString)
    }
    
    func load() -> T? {
        guard let item = cache.object(forKey: key as NSString) else { return nil }
        
        let now = Date()
        if now.timeIntervalSince(item.timestamp) < expirationInterval {
            if let object = try? JSONDecoder().decode(T.self, from: item.object) {
                return object
            }
        } else {
            clear()
        }
        
        return nil
    }
    
    func clear() {
        cache.removeObject(forKey: key as NSString)
    }
}

