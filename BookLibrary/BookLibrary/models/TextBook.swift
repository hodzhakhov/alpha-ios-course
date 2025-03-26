import Foundation

struct TextBook: BookProtocol {
    var id: UUID
    var title: String
    var author: String
    var publicationYear: Int?
    var courseNumber: Int
    
    func printInfo() {
        print("TextBook:", id, title, author, publicationYear ?? 0, courseNumber)
    }
    
    func matchesCriteria(criteria: Criteria) -> Bool {
        switch criteria {
        case .title(let title):
            return self.title == title
        case .author(let author):
            return self.author == author
        case .publicationYear(let year):
            return self.publicationYear == year
        case .courseNumber(let number):
            return self.courseNumber == number
        default:
            return false
        }
    }
}
