import Foundation

final class UserDefaultService {
    let storage = UserDefaults.standard
    
    func setBoolForKey(value: Bool, key: String) {
        storage.set(value, forKey: key)
    }
    
    func readBoolForKey(key: String) -> Bool {
        storage.bool(forKey: key)
    }
    
    func removeObjectWith(key: String) {
        storage.removeObject(forKey: key)
    }
}
