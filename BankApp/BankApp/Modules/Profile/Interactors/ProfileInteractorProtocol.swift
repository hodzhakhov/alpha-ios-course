import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    func fetchProfile(userId: String, completion: @escaping (Result<User, Error>) -> Void)
    func updateProfile(userId: String, name: String?, completion: @escaping (Result<User, Error>) -> Void)
}
