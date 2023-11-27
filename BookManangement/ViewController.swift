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
    private var textManageClass = TextManageClass(isMemeber: true, keyword: "회원")
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardNotification()
        setupGestureRecognizer()
        consolLabel.text = textManageClass.setConsole()
        initDict()
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
            textManageClass.firstLevelText(type: text, completeHandler:{ text in
                consolLabel.text! += text
            })
        } else if okayList[1] == "0" {
            okayList[1] = text
            
            switch okayList[0]{
            case "1":
                textManageClass = TextManageClass(isMemeber: true, keyword: "회원")
                textManageClass.memberSecondLevelText(type: okayList[1], completeHandler:{ text in
                    if text.contains("상위 메뉴 이동") {
                        okayList[0] = "0"
                        okayList[1] = "0"
                        consolLabel.text = textManageClass.setConsole()
                    } else if text.contains("다시") {
                        okayList[1] = "0"
                    }
                    consolLabel.text! += text
                })
            case "2":
                textManageClass = TextManageClass(isMemeber: false, keyword: "도서")
                textManageClass.memberSecondLevelText(type: okayList[1], completeHandler: { text in
                    if text.contains("상위 메뉴 이동") {
                        okayList[0] = "0"
                        okayList[1] = "0"
                        consolLabel.text = textManageClass.setConsole()
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
                        textManageClass.firstLevelText(type: "1", completeHandler: {text in
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
                        textManageClass.firstLevelText(type: "1", completeHandler: {text in
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
        userTextField.text = ""
    }
    
}
