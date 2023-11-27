//
//  TextManageClass.swift
//  BookManangement
//
//  Created by uniwiz on 11/27/23.
//

import Foundation

class TextManageClass {
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
    
    func setConsole() -> String {
        return """
               Lv.1
               1. 회원 관리
               2. 도서 관리
               3. 도서 대여/반납 관리
               4. 검색
               5. 저장 & 종료
               6. 종료
               명령을 번호로 입력하십시오:\n
               """
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
                let textBody = MemberClass(isMemeber: isMember, keyword: keyword).memberPrint(key: key, dataValue: dataValue)
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
}
