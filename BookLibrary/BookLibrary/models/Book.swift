import Foundation

struct Book: BookProtocol {
    var id: UUID
    var title: String
    var author: String
    var publicationYear: Int?
    var genre: Genre
    
    func printInfo() {
        print("Book:", id, title, author, publicationYear ?? 0, genre)
    }
    
    func matchesCriteria(criteria: Criteria) -> Bool {
        switch criteria {
        case .title(let title):
            return self.title == title
        case .author(let author):
            return self.author == author
        case .publicationYear(let year):
            return self.publicationYear == year
        case .genre(let genre):
            return self.genre == genre
        default:
            return false
        }
    }
}
