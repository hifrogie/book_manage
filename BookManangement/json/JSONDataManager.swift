//
//  JSONDataManager.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/11/27.
//

import Foundation

enum FileName:String {
    case book_data = "book_data.json"
    case rental_state = "rental_state.json"
    case user_data = "user_data.json"
}

class JSONDataManager {
    static let instance = JSONDataManager()
    
    static var users:[String:[String]]? = nil
    static var books:[String:[String]]? = nil
    static var rentals:[String:[[String]]]? = nil
    
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
        guard let fileURL = getFilePath(JsonFileName: JsonfileName), FileManager.default.fileExists(atPath: fileURL.path) else {
            creatFile(JsonFileName: JsonfileName)
            return
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
    func loadFile<T>(filePath:URL) -> [String:T]? {
        do {
            let data = try Data(contentsOf: filePath)
            let returnDict = try JSONSerialization.jsonObject(with: data) as? [String:T]
            return returnDict
        } catch {
            print("Error loading: \(error)")
            return nil
        }
    }
    //파일의 json 가져오는 거
    func loadJsonFile<T>(JsonFileName: FileName) -> [String:T]? {
        guard let filePath = getFilePath(JsonFileName: JsonFileName) else {return nil}
        return loadFile(filePath: filePath)
    }
    //번들의 json 가져오는 것
    func loadBundleJson<T>(JsonFileName:FileName) -> [String:T]? {
        guard let filePath = getBundleFilePath(JsonFileName: JsonFileName) else {return nil}
        return loadFile(filePath: filePath)
    }
    // 딕셔너리 자체를 dict로 다시 씀
    func updateDict<T:Encodable>(dict:[String:T], JsonFileName: FileName) {
        guard let filePath = getFilePath(JsonFileName: JsonFileName) else {return}
        do {
            let data = try JSONEncoder().encode(dict)
            try data.write(to: filePath)
            saveToProperty(dict: dict, JsonFileName: JsonFileName)
        }catch {
            print("Error update \(JsonFileName): \(error)")
        }
    }

    //파일에 키와 밸류 추가하기
    func updateDict<T:Encodable>(key:String, valueArray:T, JsonFileName: FileName) {
        guard let filePath = getFilePath(JsonFileName: JsonFileName),
                var newDict = readProperty(JsonFileName: JsonFileName) as? [String:T] else {return}
            do {
                newDict[key] = valueArray
                let data = try JSONEncoder().encode(newDict)
                try data.write(to: filePath, options: [])
                saveToProperty(dict: newDict, JsonFileName: JsonFileName)
            } catch {
                print("Error saving \(JsonFileName): \(error)")
            }
        }
    
    //번들에 있는 정보 파일에 다시 쓰기
    func creatFile(JsonFileName: FileName) {
        guard let fileBundleURL = getBundleFilePath(JsonFileName: JsonFileName),
              let fileURL = getFilePath(JsonFileName: JsonFileName), let dict:[String:Any] = loadFile(filePath: fileBundleURL) else {return}
        
        if JsonFileName == .user_data && JsonFileName == .book_data {
            guard var updatedDict = dict as? [String:[String]] else {return}
            do {
                let data = try JSONEncoder().encode(updatedDict)
                try data.write(to: fileURL)
            } catch {
                print("Error saving \(JsonFileName): \(error)")
            }
        } else {
            guard var updatedDict = dict as? [String:[[String]]] else {return}
            do {
                let data = try JSONEncoder().encode(updatedDict)
                try data.write(to: fileURL)
            } catch {
                print("Error saving \(JsonFileName): \(error)")
            }
        }
    }
    
    private func saveToProperty(dict: Any, JsonFileName: FileName) {
        switch JsonFileName {
        case .user_data:
            JSONDataManager.users = dict as? [String:[String]]
        case .book_data:
            JSONDataManager.books = dict as? [String:[String]]
        case .rental_state:
            JSONDataManager.rentals = dict as? [String:[[String]]]
        }
    }
    
    func readProperty(JsonFileName:FileName) -> Any?{
        switch JsonFileName {
        case .user_data: return JSONDataManager.users
        case .book_data: return JSONDataManager.books
        case .rental_state: return JSONDataManager.rentals
        }
    }
    
    func deleteItem(JsonFileName:FileName, key: String, _ dict: Any) {
     if JsonFileName == .user_data && JsonFileName == .book_data {
         if var deletedDict = dict as? [String:[String]] {
             deletedDict.removeValue(forKey: key)
             updateDict(dict: deletedDict, JsonFileName: JsonFileName)
         }
     } else {
         if var deletedDict = dict as? [String:[[String]]] {
             deletedDict.removeValue(forKey: key)
             updateDict(dict: deletedDict, JsonFileName: JsonFileName)
         }
     }
    }
}
