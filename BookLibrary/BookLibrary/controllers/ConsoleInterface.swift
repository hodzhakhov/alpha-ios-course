import Foundation

class ConsoleInterface {
    private var bookShelf = BookShelf()
    
    func start() {
        print("Book shelf")
        while true {
            print("")
            print("1. Add book")
            print("2. Delete book")
            print("3. List books")
            print("4. Find books")
            print("5. Exit")
            print("Choose option:")
            
            guard let choice = readLine(), let option = Int(choice) else {
                print("Wrong input, try again.")
                continue
            }
            
            switch option {
            case 1: addBook()
            case 2: deleteBook()
            case 3: listBooks()
            case 4: findBooks()
            case 5:
                print("Goodbye!")
                return
            default:
                print("Wrong option, try again.")
            }
        }
    }
    
    private func addBook() {
        print("Input book type (1 - Book, 2 - ComicBook, 3 - TextBook):")
        guard let bookType = readLine(), let bookTypeInt = Int(bookType) else {
            print("Inccorect input!")
            return
        }
        
        print("Input title:")
        let title = readLine() ?? "Unknown"
        
        print("Input author:")
        let author = readLine() ?? "Unknown"
        
        print("Input publication year:")
        let publicationYear = Int(readLine() ?? "")
        
        var newBook: BookProtocol?
        
        switch bookTypeInt {
        case 1:
            print("Input genre(fiction, nonFiction, mystery, sciFi, biography, fantasy, history, educational):")
            let genre = Genre(rawValue: readLine() ?? "Unknown") ?? .unknown
            newBook = Book(id: UUID(), title: title, author: author, publicationYear: publicationYear, genre: genre)
            
        case 2:
            print("Input comic number:")
            if let number = Int(readLine() ?? "") {
                newBook = ComicBook(id: UUID(), title: title, author: author, publicationYear: publicationYear, comicNumber: number)
            } else {
                print("Incorrect comic number!")
            }
            
            
        case 3:
            print("Input course number:")
            if let number = Int(readLine() ?? "") {
                newBook = TextBook(id: UUID(), title: title, author: author, publicationYear: publicationYear, courseNumber: number)
            } else {
                print("Incorrect course number!")
            }
            
        default:
            print("Inccorect input!")
        }
        
        if let book = newBook {
            bookShelf.addBook(book: book)
            print("Book added successfully!")
        } else {
            print("Failed to add book!")
        }
    }
    
    private func deleteBook() {
        print("Input ID:")
        let idString = readLine() ?? ""
        guard let id = UUID(uuidString: idString) else {
            print("Inccorect ID!")
            return
        }
        do {
            try bookShelf.deleteBook(by: id)
        } catch {
            print("Book hasn't been found!")
        }
    }
    
    private func listBooks() {
        let books = bookShelf.getAllBooks()
        books.forEach { book in
            book.printInfo()
        }
    }
    
    private func findBooks() {
        print("Input criteria (1 - title, 2 - author, 3 - genre, 4 - publication year, 5 - comic number, 6 - course number):")
        guard let criteria = readLine(), let option = Int(criteria) else {
            print("Inccorect input!")
            return
        }
        
        switch option {
        case 1:
            print("Input title:")
            let title = readLine() ?? "Unknown"
            let books = bookShelf.findBookByCriteria(criteria: Criteria.title(title))
            books.forEach { book in
                book.printInfo()
            }
            
        case 2:
            print("Input author:")
            let author = readLine() ?? "Unknown"
            let books = bookShelf.findBookByCriteria(criteria: Criteria.author(author))
            books.forEach { book in
                book.printInfo()
            }
            
        case 3:
            print("Input genre:")
            let genre = Genre(rawValue: readLine()?.lowercased() ?? "Unknown") ?? .unknown
            let books = bookShelf.findBookByCriteria(criteria: Criteria.genre(genre))
            books.forEach { book in
                book.printInfo()
            }
            
        case 4:
            print("Input publication year:")
            let publicationYear = Int(readLine() ?? "")
            let books = bookShelf.findBookByCriteria(criteria: Criteria.publicationYear(publicationYear))
            books.forEach { book in
                book.printInfo()
            }
            
        case 5:
            print("Input comic number:")
            if let number = Int(readLine() ?? "") {
                let books = bookShelf.findBookByCriteria(criteria: Criteria.comicNumber(number))
                books.forEach { book in
                    book.printInfo()
                }
            } else {
                print("Incorrect comic number!")
            }
            
        case 6:
            print("Input course number:")
            if let number = Int(readLine() ?? "") {
                let books = bookShelf.findBookByCriteria(criteria: Criteria.courseNumber(number))
                books.forEach { book in
                    book.printInfo()
                }
            } else {
                print("Incorrect course number!")
            }
            
        default:
            print("Inccorect input!")
        }
    }
}
