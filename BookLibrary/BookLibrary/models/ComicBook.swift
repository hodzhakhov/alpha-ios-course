import Foundation

struct ComicBook: BookProtocol {
    var id: UUID
    var title: String
    var author: String
    var publicationYear: Int?
    var comicNumber: Int
    
    func printInfo() {
        print("ComicBook:", id, title, author, publicationYear ?? 0, comicNumber)
    }
    
    func matchesCriteria(criteria: Criteria) -> Bool {
        switch criteria {
        case .title(let title):
            return self.title == title
        case .author(let author):
            return self.author == author
        case .publicationYear(let year):
            return self.publicationYear == year
        case .comicNumber(let number):
            return self.comicNumber == number
        default:
            return false
        }
    }
}
