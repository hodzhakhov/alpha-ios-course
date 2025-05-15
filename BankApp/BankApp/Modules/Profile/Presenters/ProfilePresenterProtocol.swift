import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func viewDidLoad(userId: String)
    func updateProfileTapped(userId: String, name: String?)
    func handleAppMovedToBackground()
    func handleAppMovedToForeground()
}
