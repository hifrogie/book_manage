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
    private var memberClass = MemberClass(isMemeber: true, keyword: "회원")
    private var bookClass = MemberClass(isMemeber: false, keyword: "도서")
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardNotification()
        setConsole()
        initDict()
        UserDefaults.standard.set(DataTable.instance.bookDataDictionary, forKey: "bookDict")
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
    
    private func initDict() {
        if UserDefaults.standard.dictionary(forKey: "userDict") == nil {
            UserDefaults.standard.set(DataTable.instance.userDataDictionary,forKey: "userDict")
        }
        if UserDefaults.standard.dictionary(forKey: "bookDict") == nil {
            UserDefaults.standard.set(DataTable.instance.bookDataDictionary, forKey: "bookDict")
        }
    }
    @IBAction func okayAction(_ sender: Any) {
        guard let text = userTextField.text else {return}
        if (okayList[0] == "0") {
            okayList[0] = text
            memberClass.firstLevelText(type: text, completeHandler:{ text in
                consoleTextView.text += text
            })
        } else if okayList[1] == "0" {
            okayList[1] = text
            
            switch okayList[0]{
            case "1":
                memberClass.memberSecondLevelText(type: okayList[1], completeHandler:{ text in
                    if text.contains("상위 메뉴 이동") {
                        okayList[0] = "0"
                        okayList[1] = "0"
                        setConsole()
                    } else if text.contains("다시") {
                        okayList[1] = "0"
                    }
                    consoleTextView.text += text
                })
            case "2":
                bookClass.memberSecondLevelText(type: okayList[1], completeHandler: { text in
                    if text.contains("상위 메뉴 이동") {
                        okayList[0] = "0"
                        okayList[1] = "0"
                        setConsole()
                    }
                    consoleTextView.text += text
                })
            default:
                consoleTextView.text += text
            }
        } else {
            switch okayList[0] {
            case "1":
                memberClass.memberThirdAction(type2: okayList[1], userText: text, completion: { text in
                    if text == "상위 메뉴 이동" {
                        okayList[1] = "0"
                        memberClass.firstLevelText(type: "1", completeHandler: {text in
                            consoleTextView.text += text
                            return
                        })
                    }
                    consoleTextView.text += text
                })
            case "2":
                bookClass.memberThirdAction(type2: okayList[1], userText: text, completion:  { text in
                    if text == "상위 메뉴 이동" {
                        okayList[1] = "0"
                        memberClass.firstLevelText(type: "1", completeHandler: {text in
                            consoleTextView.text += text
                            return
                        })
                    }
                    consoleTextView.text += text
                })
            default:
                print("")
            }
            
        }
    }
    
}
