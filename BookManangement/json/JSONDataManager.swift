//
//  JSONDataManager.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/11/27.
//

import Foundation

enum FileName:String {
    case book_data
    case rental_state
    case user_data
}

struct User:Codable {
    var user: [String:[UserValue]]
}

struct UserValue: Codable {
//    var name:String
    var age:String
    var memberId:String
    var phoneNumber:String
    var bookRented: String
}

struct Book: Codable {
    var book:[String:[BookValue]]
}

struct BookValue: Codable {
//    var bookTitle:String
    var bookNumber:String
    var rentalStatus:String
    var borrower:String
}

struct Rental: Codable {
    var rental: [String:[RentalValue]]
}

struct RentalValue:Codable {
//    var bookTitle:String
    var memberId:String
    var bookId:String
    var name:String
    var rentalDate:String
    var returnDate:String
    var isReturn:String
}

class JSONDataManager {
    static let instance = JSONDataManager()
    
    var users:User
    var books:Book
    var rentals:Rental
    
    init() {
        loadAllFiles()
    }
    
    private func loadAllFiles() {
        loadFile(JsonfileName: .user_data, into: &users)
        loadFile(JsonfileName: .book_data, into: &books)
        loadFile(JsonfileName: .rental_state, into: &rentals)
    }
    
    private func loadFile<T: Codable>(JsonfileName: FileName, into dict: inout T) {
        guard let filePath = getFilePath(JsonFileName: JsonfileName) else {return}
        do {
            let data = try Data(contentsOf: filePath)
            dict = try JSONDecoder().decode(T.self, from: data)
//            dict = try JSONSerialization.jsonObject(with: data) as! [String : [T]]
        } catch {
            print("Error loading \(JsonfileName): \(error)")
        }
    }
    
    private func getFilePath(JsonFileName:FileName) -> URL? {
        let filePath = Bundle.main.url(forResource: JsonFileName.rawValue, withExtension:  "json")
        return filePath
    }
    
    func loadCurrentItems<T: Codable>(JsonFileName: FileName) -> T? {
        guard let filePath = getFilePath(JsonFileName: JsonFileName), FileManager.default.fileExists(atPath: filePath.path) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: filePath)
            let items = try JSONDecoder().decode(T.self, from: data)
            return items
        } catch {
            print("Error loading \(JsonFileName): \(error)")
            return nil
        }
    }
    
    private func updateArray<T:Codable> (value newItem: T,key: String, JsonFileName: FileName) {
//        guard var currentItems = loadCurrentItems(JsonFileName: JsonFileName) as? T else {return}
        currentItems.updateValue(newItem, forKey: key)
        updateArray(currentItems, JsonFileName: JsonFileName)
    }
    
    func updateArray<T: Codable>(_ array:T, JsonFileName: FileName) {
        guard let filePath = getFilePath(JsonFileName: JsonFileName) else {
            return
        }
        
        do {
            let data = try JSONEncoder().encode(array)
            try data.write(to: filePath, options: .atomic)
        } catch {
            print("Error saving \(JsonFileName): \(error)")
        }
    }
    func readUsers() -> User {
        return users
    }
    
    func readBooks() -> Book {
        return books
    }
    
    func readRentals() -> Rental {
        return rentals
    }
    func deleteItem(JsonFileName:FileName, key: String) {
        switch JsonFileName {
        case .user_data:
            users.user.removeValue(forKey: key)
            updateArray(users, JsonFileName: JsonFileName)
        case .book_data:
            books.book.removeValue(forKey: key)
            updateArray(books, JsonFileName: JsonFileName)
        case .rental_state:
            rentals.rental.removeValue(forKey: key)
            updateArray(rentals, JsonFileName: JsonFileName)
        }
    }
}
