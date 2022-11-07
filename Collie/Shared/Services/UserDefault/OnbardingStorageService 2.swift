import Foundation

final class OnboardingStorageService {
    static var shared = OnboardingStorageService()
    
    private let userDefaultsService = UserDefaultService()
    
    func markOnboardingDone(onboardingType: OnboardingType) {
        let key = "Is\(onboardingType.rawValue)OnboardingDone"
        userDefaultsService.setBoolForKey(value: true, key: key)
    }
    
    func isOnboardingDone(onboardingType: OnboardingType) -> Bool {
        let key = "Is\(onboardingType.rawValue)OnboardingDone"
        return userDefaultsService.readBoolForKey(key: key)
    }
}
