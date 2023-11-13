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
    private var okayList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardNotification()
        setConsole()
    }
    
    
    @IBAction func tapBackgroundView(_ sender: Any) {
          view.endEditing(true)
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
               명령을 번호로 입력하십시오:
               """
        consoleTextView.text = consoleText
    }
    
    @IBAction func okayAction(_ sender: Any) {
        if (okayList[0].isEmpty) {
            if let text = userTextField.text {
                okayList[0] = text
            }
        }
        switch okayList[0] {
        case "1":
            memberManageAction()
        case "2":
            print("gkgk")
        case "3":
            print("gkgk")
        case "4":
            print("gkgk")
        case "5":
            print("gkgk")
        case "6":
            print("gkgk")
        default:
            print("gkgk")
        }
    }
    
    private func memberManageAction() {
        let text = """
        1. 회원관리
        /////////////////////////
        1. 회원등록
        2. 회원검색
        3. 회원 목록(전체보기)
        4. 저장하기
        5. 상위메뉴 이동
        """
        consoleTextView.text += text
    }
}

