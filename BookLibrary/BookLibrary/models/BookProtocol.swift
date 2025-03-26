import Foundation

protocol BookProtocol {
    var id: UUID { get }
    var title: String { get }
    var author: String { get }
    var publicationYear: Int? { get }
    
    func printInfo()
    func matchesCriteria(criteria: Criteria) -> Bool
}
