//
//  MemberClass.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/11/20.
//

import Foundation

class MemberClass {
    
    private var keyword = ""
    private var indexArray:[String]
    private var valueArray = Array(repeating: "", count: 5)
    private var dictKey = ""
    var searchMember = ""
    var editMemberNumber = ""
    var isMember:Bool
    
    init(isMemeber:Bool, keyword:String) {
        if isMemeber {
            indexArray = ["이름","나이","회원번호","폰번호","대여도서"]
            dictKey = "userDict"
        } else {
            indexArray = ["도서제목", "도서번호","대여상태", "대여자",""]
            dictKey = "bookDict"
        }
        self.keyword = keyword
        self.isMember = isMemeber
    }
    
    func firstLevelText(type:String, completeHandler: (String) -> Void) {
        var text = ""
        switch type{
        case "1":
            text = """
            1. 회원관리
            /////////////////////////
            1. 회원등록
            2. 회원검색
            3. 회원 목록(전체보기)
            4. 저장하기
            5. 상위메뉴 이동
            명령을 번호로 입력하십시오:\n
            """
        case "2":
            text = """
            2. 도서관리
            ////////////////
            1. 도서등록
            2. 도서검색
            3. 도서 목록(전체보기)
            4. 저장하기
            5. 상위메뉴 이동
            명령을 번호로 입력하십시오:\n
            """
        case "3":
            text = """
            3. 도서 대여/반남 관리
            //////////////////
            1. 대여하기
            2. 반납하기
            3. 대여현황
            4. 상위메뉴 이동
            명령을 번호로 입력하십시오:\n
            """
        case "4":
            text = """
            4. 검색
            //////////////////
            1. 회원검색
            2. 도서검색
            3. 회원 및 도서 전체 검색
            4. 상위 메뉴 이동
            명령을 번호로 입력하십시오:\n
            """
        case "5":
            text = """
            5. 저장&종료
            """
        case "6":
            text = """
            6. 종료
            """
        default:
            text = "다시 선택해 주세요."
        }
        //        consoleTextView.text += text
        completeHandler(text)
    }
    
    func memberSecondLevelText(type:String, completeHandler: (String) -> Void) {
        switch type {
        case "1":
            let text = """
            1. \(keyword) 등록
            ///////////////
            1. \(indexArray[0])을 입력하세요\n
            """
            completeHandler(text)
        case "2":
            let text = """
            2. \(keyword)검색
            //////////
            \(indexArray[0])을 입력해주세요.\n
            """
            completeHandler(text)
        case "3":
            let text = """
            3. \(keyword) 목록(전체보기)
            ////////////////////// start /////////////////////////
            \(indexArray[0])    \(indexArray[1])     \(indexArray[2])              \(indexArray[3])       \(indexArray[4])\n
            """
            completeHandler(text)
            
            guard let userDict = UserDefaults.standard.dictionary(forKey: dictKey) else {return}
            for (key, value ) in userDict{
                let dataValue:Array<String> = value as! Array<String>
                let textBody = memberPrint(key: key, dataValue: dataValue)
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
    
    func addMember(text:String, completeHandler:(String) ->Void) {
        
        if valueArray[0].isEmpty == true {
            valueArray[0] = text
            
            let userText = "\(text)\n2. \(indexArray[1])를 입력하세요\n"
            completeHandler(userText)
        } else if valueArray[1].isEmpty == true {
            valueArray[1] = text
            
            let userText = "\(text)\n3. \(indexArray[2])를 입력하세요\n"
            completeHandler(userText)
        } else if valueArray[2].isEmpty == true {
            valueArray[2] = text
            
            let userText = "\(text)\n4.\(indexArray[3])를 입력하세요\n"
            completeHandler(userText)
        } else if valueArray[3].isEmpty == true {
            valueArray[3] = text
            
            let userArray = [valueArray[1], valueArray[2], valueArray[3], "0"]
            guard var userDict = UserDefaults.standard.dictionary(forKey: dictKey) else {return}
            userDict[valueArray[0]] = userArray as Any
            UserDefaults.standard.set(userDict, forKey: dictKey)
            memberSecondLevelText(type: "3", completeHandler:{ text in
                completeHandler(text)
            })
            valueArray = Array(repeating: "", count: 5)
        }
    }
    
    func memberSearch(userText:String, completion:(String) -> Void) {
        guard let userDict = UserDefaults.standard.dictionary(forKey: dictKey) else {return}
        
        for (key, value) in userDict {
            if (key == userText) {
                searchMember = key
                let dataValue:Array<String> = value as! Array<String>
                
                let text = """
                \(memberPrint(key: key, dataValue: dataValue))
                1. \(keyword) 수정
                2. \(keyword) 삭제
                3. 상위 메뉴 이동
                명령을 번호로 입력하십시오:\n
                """
                completion(text)
                return
            }
        }
        let text = "존재하지 않습니다."
        completion(text)
    }
    
    func editMember(userText:String, completion:(String) -> Void) {
        
        if userText.contains("1.") {
            keyChange(key:userText, completionHandler:{ dict, key in
                let text = memberPrint(key: key, dataValue: dict[key] as! Array<String>)
                completion(text)
            })
        } else {
            valueChange(valueNumber: userText, completionHandler: { dict, key in
                let text = memberPrint(key: key, dataValue: dict[key] as! Array<String>)
                completion(text)
            })
        }
        
        //        let text = """
        //                추가로 수정할 정보를 번호로 입력해주세요.
        //                1. 이름
        //                2. 나이
        //                3. 회원번호
        //                4. 폰번호
        //                5. 대여도서
        //                """
        //        completion(text)
    }
    
    private func keyChange(key:String, completionHandler:(Dictionary<String,Any>, String) -> Void) {
        guard var userDict = UserDefaults.standard.dictionary(forKey: dictKey) else {return}
        let userArray = key.components(separatedBy: ".")
        if let entry = userDict.removeValue(forKey: searchMember) {
            userDict[userArray[1]] = entry
            UserDefaults.standard.set(userDict, forKey: dictKey)
            completionHandler(userDict, userArray[1])
        }
    }
    
    private func valueChange(valueNumber:String, completionHandler: (Dictionary<String,Any>, String) -> Void) {
        let valueArray = valueNumber.components(separatedBy: ".")
        guard let valueInt = Int(valueArray[0]) else {return}
        let valueIndex = valueInt - 2
        guard var userDict = UserDefaults.standard.dictionary(forKey: dictKey) else {return}
        
        if valueIndex < 0 {return}
        var searchArray: [String] = userDict[searchMember] as! [String]
        
        searchArray[valueIndex] = valueArray[1]
        userDict[searchMember] = searchArray
        
        UserDefaults.standard.set(userDict, forKey: dictKey)
        completionHandler(userDict, searchMember)
    }
    
    func memberPrint(key:String, dataValue:Array<String>) -> String{
        if isMember {
            return """
            \(indexArray[0]) : \(key)
            \(indexArray[1]) : \(dataValue[0])
            \(indexArray[2]) : \(dataValue[1])
            \(indexArray[3]) :  \(dataValue[2])
            \(indexArray[4]) :  \(dataValue[3])\n
            """
        } else {
            return """
                \(indexArray[0]) : \(key)
                \(indexArray[1]) : \(dataValue[0])
                \(indexArray[2]) : \(dataValue[1])
                \(indexArray[3]) :  \(dataValue[2])\n
                """
        }
    }
    
    func removeMember(completion:(String) -> Void) {
        guard var userDict = UserDefaults.standard.dictionary(forKey: dictKey) else {return}
        userDict.removeValue(forKey: searchMember)
        
        UserDefaults.standard.set(userDict, forKey: dictKey)
        
        completion("삭제 완료되었습니다.")
    }
    func memberThirdAction(type2:String, userText:String, completion:(String) -> Void) {
        switch type2 {
        case "1":
            addMember(text: userText) { text in
                completion(text)
            }
        case "2":
            if editMemberNumber == "1" {
                editMember(userText: userText, completion: {text in
                    completion(text)
                })
                editMemberNumber = "0"
            }else if userText == "1" {
                editMemberNumber = "1"
                var text = ""
                if isMember {
                    text = """
                수정할 정보를 번호와 바뀐 값으로 입력해주세요.
                1.이름 -> 1.(개구리)
                2.나이 -> 2.(45)
                3.회원번호 -> 3.(1045)
                4.폰번호 -> 4.(010-0101-0101)
                5.대여도서 -> 5.(2)\n
                """
                } else {
                    text = """
                    1.도서제목 -> 1.(해리포터와 마법사의 돌)
                    2.도서번호 -> 2.(B1001)
                    3.대여상태 -> 3.(대여가능)
                    4.대여자 -> 4.(-)
                    4.대여자는 이름 혹은 -\n
                    """
                }
                completion(text)
            } else if userText == "2" {
                removeMember(completion: { text in
                    completion(text)
                })
            } else if userText == "3" {
                completion("상위 메뉴 이동")
            } else {
                memberSearch(userText: userText, completion: { text in
                    completion(text)
                })
            }
        default:
            print("실패")
        }
    }
}
