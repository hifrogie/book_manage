//
//  ViewController.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/11/12.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet var consolLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var btnOkay: UIButton!
    private var consoleText = ""
    private var okayList: [String] = ["0","0","0"]
    private var memberClass = MemberClass(isMemeber: true, keyword: "회원")
    private var bookClass = MemberClass(isMemeber: false, keyword: "도서")
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardNotification()
        setupGestureRecognizer()
        setConsole()
        initDict()
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
        consolLabel.text = consoleText
    }
    
    private func initDict() {
        if UserDefaults.standard.dictionary(forKey: "userDict") == nil {
            UserDefaults.standard.set(DataTable.instance.userDataDictionary,forKey: "userDict")
        }
        if UserDefaults.standard.dictionary(forKey: "bookDict") == nil {
            UserDefaults.standard.set(DataTable.instance.bookDataDictionary, forKey: "bookDict")
        }
        if UserDefaults.standard.dictionary(forKey: "rentalDict") == nil {
            UserDefaults.standard.set(DataTable.instance.rentalStateDictionary, forKey: "rentalDict")
        }
    }
    @IBAction func okayAction(_ sender: Any) {
        guard let text = userTextField.text, let _ = consolLabel.text else {return}
        if (okayList[0] == "0") {
            okayList[0] = text
            memberClass.firstLevelText(type: text, completeHandler:{ text in
                consolLabel.text! += text
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
                    consolLabel.text! += text
                })
            case "2":
                bookClass.memberSecondLevelText(type: okayList[1], completeHandler: { text in
                    if text.contains("상위 메뉴 이동") {
                        okayList[0] = "0"
                        okayList[1] = "0"
                        setConsole()
                    }
                    consolLabel.text! += text
                })
            default:
                consolLabel.text! += text
            }
        } else {
            switch okayList[0] {
            case "1":
                memberClass.memberThirdAction(type2: okayList[1], userText: text, completion: { text in
                    if text == "상위 메뉴 이동" {
                        okayList[1] = "0"
                        memberClass.firstLevelText(type: "1", completeHandler: {text in
                            consolLabel.text! += text
                            return
                        })
                    }
                    consolLabel.text! += text
                })
            case "2":
                bookClass.memberThirdAction(type2: okayList[1], userText: text, completion:  { text in
                    if text == "상위 메뉴 이동" {
                        okayList[1] = "0"
                        memberClass.firstLevelText(type: "1", completeHandler: {text in
                            consolLabel.text! += text
                            return
                        })
                    }
                    consolLabel.text! += text
                })
            default:
                print("okayAction 실패")
            }
            
        }
    }
    
}
