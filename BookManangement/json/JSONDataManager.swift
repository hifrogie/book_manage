//
//  JSONDataManager.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/11/27.
//

import Foundation

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

enum FileName:String {
    case book_data = "book_data.json"
    case rental_state = "rental_state.json"
    case user_data = "user_data.json"
}

class JSONDataManager {
    static let instance = JSONDataManager()
    
    static var users:[String:[String]]? = nil
    static var books:[String:[String]]? = nil
    static var rentals:[String:[String]]? = nil
    
    init() {
        loadAllFiles()
    }
    
    private func loadAllFiles() {
        initFile(JsonfileName: .book_data)
        initFile(JsonfileName: .rental_state)
        initFile(JsonfileName: .user_data)
        JSONDataManager.users = loadJsonFile(JsonFileName: .user_data)
        JSONDataManager.books = loadJsonFile(JsonFileName: .book_data)
        JSONDataManager.rentals = loadJsonFile(JsonFileName: .rental_state)
        
    }
    
    private func initFile(JsonfileName:FileName) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent(JsonfileName.rawValue)
            if !(FileManager.default.fileExists(atPath: fileURL.path)) {
                creatFile(JsonFileName: JsonfileName)
            }
        }
    }

    private func getBundleFilePath(JsonFileName:FileName) -> URL? {
        guard let fileURL = Bundle.main.url(forResource: JsonFileName.rawValue, withExtension: nil) else {return nil}
        return fileURL
    }
    private func getFilePath(JsonFileName:FileName) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let fileURL = documentsDirectory.appendingPathComponent(JsonFileName.rawValue)
        return fileURL
    }
    func getType(type:FileName) -> Codable.Type {
        switch type {
        case .user_data: return User.self
        case .rental_state: return Rental.self
        case .book_data: return Book.self
        }
    }
    
    func getValueType(type:FileName) -> Codable.Type {
        switch type {
        case .user_data: return UserValue.self
        case .rental_state: return RentalValue.self
        case .book_data: return BookValue.self
        }
    }
    
    //file, 번들에 있던 json 딕셔너리로 가져오는 것
    func loadFile(filePath:URL) -> [String:[String]]? {
        do {
            let data = try Data(contentsOf: filePath)
            let returnDict = try JSONSerialization.jsonObject(with: data) as? [String:[String]]
            return returnDict
        } catch {
            print("Error loading: \(error)")
            return nil
        }
    }
    //파일의 json 가져오는 거
    func loadJsonFile(JsonFileName: FileName) -> [String:[String]]? {
        guard let filePath = getFilePath(JsonFileName: JsonFileName) else {return nil}
        return loadFile(filePath: filePath)
    }
    //번들의 json 가져오는 것
    func loadBundleJson(JsonFileName:FileName) -> [String:[String]]? {
        guard let filePath = getBundleFilePath(JsonFileName: JsonFileName) else {return nil}
        return loadFile(filePath: filePath)
    }
    // 딕셔너리 자체를 dict로 다시 씀
    func updateDict(dict:[String:[String]], JsonFileName: FileName) {
        guard let filePath = getFilePath(JsonFileName: JsonFileName) else {return}
        do {
            let data = try JSONEncoder().encode(dict)
            try data.write(to: filePath)
        } catch {
            print("Error saving \(JsonFileName): \(error)")
        }
    }
    //파일에 키와 밸류 추가하기
    func updateDict(key:String, valueArray:[String], JsonFileName: FileName,_ dict: inout [String:[String]]) {
        var fileName = JsonFileName
        guard let filePath = getFilePath(JsonFileName: JsonFileName) else {return}
        
        do {
            dict[key] = valueArray
            let data = try JSONEncoder().encode(dict)
            try data.write(to: filePath, options: [])
        } catch {
            print("Error saving \(JsonFileName): \(error)")
        }
    }
    //번들에 있는 정보 파일에 다시 쓰기
    func creatFile(JsonFileName: FileName) {
        guard let fileURL = getBundleFilePath(JsonFileName: JsonFileName), var dict = loadFile(filePath: fileURL) else {return}
        
        do {
            let data = try JSONEncoder().encode(dict)
            try data.write(to: fileURL)
        } catch {
            print("Error saving \(JsonFileName): \(error)")
        }
    }
    func readUsers() -> [String:[String]]? {
        return loadJsonFile(JsonFileName: .user_data)
    }
    
    func readBooks() -> [String:[String]]? {
        return loadJsonFile(JsonFileName: .book_data)
    }
    
    func readRentals() -> [String:[String]]? {
        return loadJsonFile(JsonFileName: .rental_state)
    }
    func deleteItem(JsonFileName:FileName, key: String, _ dict: inout [String:[String]]) {
        
            dict.removeValue(forKey: key)
            updateDict(dict: dict, JsonFileName: JsonFileName)
        
    }
}
