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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
               명령을 번호로 입력하십시오:
               """
        consoleTextView.text = consoleText
    }
    //진짜 콘솔창을 가져오는게 아니라 textfield를 콘솔창 처럼 사용하는 것이 챗 지피티 내용이어서 이렇게 짰습니다.
    //모든 것을 이 함수에서 처리해야해서 고민하다가 너무 늦어서 자야겠습니다.
    @IBAction func okayAction(_ sender: Any) {
        if consoleText.contains("Lv.1") {
            switch userTextField.text {
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
            case .none:
                print("gkgk")
            case .some(_):
                print("gkgk")
            }
        } else if consoleText.contains("Lv.2") {
        } else if consoleText.contains("Lv.3") {
            
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
    }
}

