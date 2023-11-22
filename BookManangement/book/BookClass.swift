//
//  BookClass.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/11/20.
//

import Foundation

class BookClass {
    static let instance = BookClass()
    private var bookAddDict: [String:String] = ["bookTitle":"", "bookNumber":"","rentalStatus":"", "borrower":""]
    private init(){}
    
    func bookSecondLevelText(type:String, completeHandler: (String) -> Void) {
        switch type {
        case "1":
            let text = """
            1. 도서 등록
            ///////////////
            1. 도서명을 입력하세요\n
            """
            completeHandler(text)
        case "2":
            let text = """
            2. 도서검색
            //////////
            도서명을 입력해주세요.\n
            """
            completeHandler(text)
        case "3":
            let text = """
            3. 도서 목록(전체보기)
            ////////////////////// start /////////////////////////
            도서제목               도서번호          대여상태          대여자\n
            """
            completeHandler(text)
            
            guard let userDict = UserDefaults.standard.dictionary(forKey: "bookDict") else {return}
            for (key, value ) in userDict{
                let dataValue:Array<String> = value as! Array<String>
                let textBody = """
                \(key)                       \(dataValue[0]) \(dataValue[1]) \(dataValue[2])\n
                """
                completeHandler(textBody)
            }
            
            let endText = """
            ////////////////////// end ////////////////////////////
            """
            
            completeHandler(endText)
        case "4":
            let text = """
            4. 저장하기
            ///////////////
            """
            completeHandler(text)
        case "5":
            let text = """
            5. 상위 메뉴 이동
            ///////////////
            """
            completeHandler(text)
        default:
            let text = "다시 선택해 주세요."
            completeHandler(text)
        }
    }
    
    func addBook(text:String, completeHandler:(String) ->Void) {
        
        if bookAddDict["bookTitle"]?.isEmpty == true {
            bookAddDict["bookTitle"] = text
            
            let userText = "\(text)\n2. 도서번호를 입력하세요\n"
            completeHandler(userText)
        } else if bookAddDict["bookNumber"]?.isEmpty == true {
            bookAddDict["bookNumber"] = text
            
            let userText = "\(text)\n3. 대여가능 / 대여중\n"
            completeHandler(userText)
        } else if bookAddDict["rentalStatus"]?.isEmpty == true {
            bookAddDict["rentalStatus"] = text
            
            let userText = "\(text)\n4. 대여자를 입력하세요. 대여상태가 아닐 때 -\n"
            completeHandler(userText)
        } else if bookAddDict["borrower"]?.isEmpty == true {
            bookAddDict["borrower"] = text
            
            guard let bookTitle = bookAddDict["bookTitle"], let bookNumber = bookAddDict["bookNumber"], let rentalStatus = bookAddDict["rentalStatus"], let borrower = bookAddDict["borrower"] else {return}
            let bookArray = [bookNumber, rentalStatus, borrower]
            guard var bookDict = UserDefaults.standard.dictionary(forKey: "bookDict") else {return}
            bookDict[bookTitle] = bookArray as Any
            UserDefaults.standard.set(bookDict, forKey: "bookDict")
            bookSecondLevelText(type: "3", completeHandler:{ text in
                completeHandler(text)
            })
            bookAddDict = ["bookTitle":"", "bookNumber":"","rentalStatus":"", "borrower":""]
        }
    }
    
    func memberThirdAction(type2:String, userText:String, completion:(String) -> Void) {
        switch type2 {
        case "1":
            addBook(text: userText) { text in
                completion(text)
            }
//        case "2":
//            if editMemberNumber == "1" {
//                editMember(userText: userText, completion: {text in
//                    completion(text)
//                })
//            }else if userText == "1" {
//                editMemberNumber = "1"
//                let text = """
//                수정할 정보를 번호와 바뀐 값으로 입력해주세요.
//                1. 이름 -> 1.개구리
//                2. 나이 -> 2.45
//                3. 회원번호 -> 3.1045
//                4. 폰번호 -> 4.010-0101-0101
//                5. 대여도서 -> 5.2\n
//                """
//                completion(text)
//            } else if userText == "2" {
//                removeMember(completion: { text in
//                    completion(text)
//                })
//            } else if userText == "3" {
//                completion("상위 메뉴 이동")
//            } else {
//                memberSearch(userText: userText, completion: { text in
//                    completion(text)
//                })
//            }
        default:
            print("실패")
        }
    }
}
