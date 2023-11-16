//
//  ViewController.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/11/12.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var consoleTextView: UITextView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var btnOkay: UIButton!
    private var consoleText = ""
    private var okayList: [String] = ["0","0","0"]
    private var memberAddDict: [String: String] = ["name":"","age":"","memberId":"",
                                                   "phoneNumber":"","bookRented":""]
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardNotification()
        setConsole()
        initUserDict()
    }
    
    private func setConsole() {
        consoleText = """
               Lv.1
               1. 회원 관리
               2. 도서 관리
               3. 도서 대여/반납 관리
               4. 검색
               5. 저장 & 종료
               6. 종료
               명령을 번호로 입력하십시오:\n
               """
        consoleTextView.text = consoleText
    }
    
    private func initUserDict() {
        if UserDefaults.standard.dictionary(forKey: "userDict") == nil {
            UserDefaults.standard.set(DataTable.instance.userDataDictionary,forKey: "userDict")
        }
    }
    @IBAction func okayAction(_ sender: Any) {
        guard let text = userTextField.text else {return}
        if (okayList[0] == "0") {
                okayList[0] = text
                firstLevelText(type: text)
        } else if (okayList[1] == "0") {
            okayList[1] = text
            
            switch okayList[0]{
            case "1":
                memberSecondLevelText(type: okayList[1])
            default:
                let text = "다시 선택해 주세요."
                consoleTextView.text += text
            }
        } else if (okayList[0] == "1" && okayList[1] == "1") {
            addMember(text: text)
        }
    }
    
    private func dummy() {
        guard let text = userTextField.text else {return}
        if (okayList[0] == "0") {
            okayList[0] = text
            firstLevelText(type: text)
        } else if (okayList[0] == "1") {
            if okayList[1] == "0" {
                okayList[1] = text
            }
            switch okayList[1]{
            case "1":
                memberSecondLevelText(type: okayList[1])
            case "2":
                let searchText = "검색할 회원의 이름을 작성해주세요"
                consoleTextView.text += searchText
            default:
                let text = "다시 선택해 주세요."
                consoleTextView.text += text
            }
            
        }
    }
    private func firstLevelText(type:String) {
        var text = ""
        switch okayList[0] {
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
        consoleTextView.text += text
    }
    
    private func memberSecondLevelText(type:String) {
        switch type {
        case "1":
            let text = """
            1. 회원 등록
            ///////////////
            1. 이름을 입력하세요\n
            """
            consoleTextView.text += text
        case "2":
            let text = """
            2. 회원검색
            //////////
            1. 회원 수정
            2. 회원 삭제
            3. 상위 메뉴 이동
            명령을 번호로 입력하십시오:\n
            """
            consoleTextView.text += text
        case "3":
            let text = """
            3. 회원 목록(전체보기)
            ////////////////////// start /////////////////////////
            이름    나이      회원번호              폰번호        빌린비디오\n
            """
            consoleTextView.text += text
            
            guard let userDict = UserDefaults.standard.dictionary(forKey: "userDict") else {return}
            for (key, value ) in userDict{
                let dataValue:Array<String> = value as! Array<String>
                let textBody = """
                \(key)  \(dataValue[0])       \(dataValue[1])        \(dataValue[2])       \(dataValue[3])\n
                """
                consoleTextView.text += textBody
            }
            
            let endText = """
            ////////////////////// end ////////////////////////////
            """
            
            consoleTextView.text += endText
        case "4":
            let text = """
            4. 저장하기
            ///////////////
            """
            consoleTextView.text += text
        case "5":
            let text = """
            5. 상위메뉴 이동
            ///////////////
            """
            consoleTextView.text += text
        default:
            let text = "다시 선택해 주세요."
            consoleTextView.text += text
        }
    }
    
    private func addMember(text:String) {
        if memberAddDict["name"] == "" {
            memberAddDict["name"] = text
            
            let userText = "2. 나이를 입력하세요\n"
            consoleTextView.text = userText
        } else if memberAddDict["age"] == "" {
            memberAddDict["age"] = text
            
            let userText = "3. 회원번호를 입력하세요\n"
            consoleTextView.text = userText
        } else if memberAddDict["memberId"] == "" {
            memberAddDict["memberId"] = text
            
            let userText = "4. 폰번호를 입력하세요\n"
            consoleTextView.text = userText
        } else if memberAddDict["phoneNumber"] == "" {
            memberAddDict["phoneNumber"] = text
            
            guard let name = memberAddDict["name"], let age = memberAddDict["age"], let memberId = memberAddDict["memberId"], let phoneNumber = memberAddDict["phoneNumber"] else {return}
            let userArray = [age, memberId, phoneNumber, "0"]
            guard var userDict = UserDefaults.standard.dictionary(forKey: "userDict") else {return}
            userDict[name] = userArray as Any
            UserDefaults.standard.set(userDict, forKey: "userDict")
            memberSecondLevelText(type: "3")
        }
    }
}

