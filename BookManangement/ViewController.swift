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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardNotification()
        setConsole()
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
    
    @IBAction func okayAction(_ sender: Any) {
        guard let text = userTextField.text else {return}
        if (okayList[0] == "0") {
                okayList[0] = text
                firstLevelText(type: text)
        } else if (okayList[1] == "0") {
            okayList.append(text)
            
            switch okayList[0]{
            case "1": memberSecondLevelText(type: okayList[1])
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
            ///////////////
            """
            consoleTextView.text += text
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
}

