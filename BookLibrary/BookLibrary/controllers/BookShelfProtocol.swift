import Foundation

protocol BookShelfProtocol {
    func addBook(book: BookProtocol)
    func deleteBook(by id: UUID) throws
    func getAllBooks() -> [BookProtocol]
    func findBookByCriteria(criteria: Criteria) -> [BookProtocol]
}
