import Foundation

struct CachedObject<T: Codable>: Codable {
    let object: T
    let timestamp: Date
}

final class CacheService<T: Codable> {
    private let key: String
    private let expirationInterval: TimeInterval

    init(key: String, expiration: TimeInterval = 3600) {
        self.key = key
        self.expirationInterval = expiration
    }

    func save(_ object: T) {
        let cached = CachedObject(object: object, timestamp: Date())
        if let data = try? JSONEncoder().encode(cached) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> T? {
        guard let data = UserDefaults.standard.data(forKey: key),
              let cached = try? JSONDecoder().decode(CachedObject<T>.self, from: data) else {
            return nil
        }

        let now = Date()
        if now.timeIntervalSince(cached.timestamp) < expirationInterval {
            return cached.object
        } else {
            clear()
            return nil
        }
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

