import Foundation

//1. შევქმნათ Class Book.
// Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
// Designated Init.
// Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
// Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს.

class Book {
    let bookID: Int
    let title: String
    let author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String, isBorrowed: Bool) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    
    func borrowed() {
        isBorrowed = true
    }
    
    func isReturned() {
        isBorrowed = false
    }
}

// 2. შევქმნათ Class Owner
// Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
// Designated Init.
// Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
// Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი.

class Owner {
    var ownerID: Int
    var name: String
    var borrowedBooks: [Book] = []
    
    init(ownerID: Int, name: String, borrowedBooks: [Book]) {
        self.ownerID = ownerID
        self.name = name
        self.borrowedBooks = borrowedBooks
}
    
    func borrow(book: Book) {
        borrowedBooks.append(book)
    }
    
    func returnBook(id: Int) {
        borrowedBooks.removeAll(where: { $0.bookID == id } )
    }
}

// 3. შევქმნათ Class Library
// Properties: Books Array, Owners Array.
// Designated Init.
// Method 1. წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნებით.
// Method 2. რომელიც ბიბლიოთეკაში ამატებს Owner-ს.
// Method 3. რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს.
// Method 4. რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს.
// Method 5. რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს.
// Method 6. რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ.
// Method 7. რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია.

class Library {
    var books: [Book]
    var owners: [Owner]
    
    init(books: [Book], owners: [Owner]) {
        self.books = books
        self.owners = owners
    }
    //MARK: Method 1
    func addBook(book: Book) {
        books.append(book)
    }
    //MARK: Method 2
    func addOwner(owner: Owner) {
        owners.append(owner)
    }
    //MARK: Method 3
    func allAvailableBooks() -> [Book] {
        books.filter( { $0.isBorrowed == false } )
    }
    //MARK: Method 4
    func allBorrowedBooks() -> [Book] {
        books.filter( { $0.isBorrowed == true } )
    }
    //MARK: Method 5
    func owner(id: Int) -> Owner? {
        owners.first (where: { $0.ownerID == id } )
    }
    //MARK: Method 6
    func bookByOwner(id: Int) {
        if let owner = owners.first(where: { $0.ownerID == id }) {
            for book in owner.borrowedBooks {
                print(book.title, book.author)
            }
        }
    }
    //MARK: Method 7
    func canBorrowBook(id: Int) -> Bool {
        
        if let book = books.first(where: { $0.bookID == id && $0.isBorrowed == false } ) {
            return true
        }
        return false
    }
}

// 4. გავაკეთოთ ბიბლიოთეკის სიმულაცია.
// შევქმნათ რამოდენიმე წიგნი და რამოდენიმე Owner-ი, შევქმნათ ბიბლიოთეკა.
// დავამატოთ წიგნები და Owner-ები ბიბლიოთეკაში
// წავაღებინოთ Owner-ებს წიგნები და დავაბრუნებინოთ რაღაც ნაწილი.
// დავბეჭდოთ ინფორმაცია ბიბლიოთეკიდან წაღებულ წიგნებზე, ხელმისაწვდომ წიგნებზე და გამოვიტანოთ წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ.

//MARK: წიგნების შექმნა
let book1 = Book(bookID: 01, title: "Book 1", author: "Author 1", isBorrowed: false)
let book2 = Book(bookID: 02, title: "Book 2", author: "Author 2", isBorrowed: false)
let book3 = Book(bookID: 03, title: "Book 3", author: "Author 3", isBorrowed: false)

//MARK: owner-ების შექმნა
let owner1 = Owner(ownerID: 11, name: "name 1", borrowedBooks: [])
let owner2 = Owner(ownerID: 22, name: "name 2", borrowedBooks: [])

//MARK: ბიბლიოთეკის შექმნა
var library = Library(books: [], owners: [])

//MARK: წიგნების დამატება ბიბლიოთეკაში
library.addBook(book: book1)
library.addBook(book: book2)
library.addBook(book: book3)

//MARK: owner-ების დამატება ბიბლიოთეკაში
library.addOwner(owner: owner1)
library.addOwner(owner: owner2)

//MARK: წავაღებინე owner-ებს წიგნები
if library.canBorrowBook(id: 01) {
    owner1.borrowedBooks.append(book1)
    book1.borrowed()
}
if library.canBorrowBook(id: 02) {
    owner1.borrowedBooks.append(book2)
    book2.borrowed()
}
if library.canBorrowBook(id: 03) {
    owner2.borrowedBooks.append(book3)
    book3.borrowed()
}
//MARK: წიგნების ნაწილის დაბრუნება
owner1.returnBook(id: 01)
book1.isReturned()
owner2.returnBook(id: 03)
book2.isReturned()

//MARK: ბიბლიოთეკიდან წაღებული წიგნები
for book in library.allBorrowedBooks() {
    print(book.title, book.author)
}
library.allBorrowedBooks()

//MARK: ხელმისაწვდომი წიგნები ბიბლიოთეკაში
for book in library.allAvailableBooks() {
    print(book.title, book.author)
}
library.allAvailableBooks()

//MARK: owner-ის მიერ წაღებული წიგნები
library.bookByOwner(id: 11)

