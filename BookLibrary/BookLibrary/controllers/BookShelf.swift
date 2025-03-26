import Foundation


class BookShelf: BookShelfProtocol {
    private var books: [UUID: BookProtocol] = [:]
    
    func addBook(book: BookProtocol) {
        books[book.id] = book
    }
    
    func deleteBook(by id: UUID) throws {
        guard books.removeValue(forKey: id) != nil else {
            throw BookError.NotFound
        }
    }
    
    func getAllBooks() -> [BookProtocol] {
        return Array(books.values)
    }
    
    func findBookByCriteria(criteria: Criteria) -> [BookProtocol] {
        return books.values.filter { $0.matchesCriteria(criteria: criteria)}
    }
}
