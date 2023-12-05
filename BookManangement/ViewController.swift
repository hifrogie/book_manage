//
//  ViewController.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/11/12.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
   
    @IBOutlet var consolLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var btnOkay: UIButton!
    private var okayList: [String] = Array(repeating: "0", count: 3)
    static let publishSubject = PublishSubject<String>()
    private var memberClass = MemberClass(isMemeber: true, keyword: "회원")
    private var bookClass = MemberClass(isMemeber: false, keyword: "도서")
    private var textManageClass = TextManageClass(isMemeber: true, keyword: "회원")
    private lazy var userClass = User(handler:handler)
    private lazy var handler: (String) -> Void = { text in
            self.consolLabel.text! += text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JSONDataManager.instance
        setKeyboardNotification()
        setupGestureRecognizer()
        consolLabel.text = textManageClass.setConsole()
    }
    //1. user, books 객체로 바꾸기
    //2. rx로 okayAction 바꾸기 구독하는 방식으로 새로운 클래스에 만들어보기 
    
    @IBAction func okayAction(_ sender: Any) {
        guard let text = userTextField.text, let _ = consolLabel.text else {return}
        
        
        
//        firstTryOkay(text: text)
        secondTryOkay(text: text)
    }
    
    func firstTryOkay(text:String) {
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
    
    func secondTryOkay(text:String) {
        switch okayList[0] {
        case "0":
            okayList[0] = text
            textManageClass.firstLevelText(type: okayList[0]) { textValue in
                consolLabel.text! += textValue
            }
        case "1":
            okayList[1] = text
            ViewController.publishSubject.onNext(text)
//        case "2":
//        case "3":
//        case "4":
//        case "5":
//        case "6":
        default:
            consolLabel.text! += "선택지에 있는 값을 넣어주세요."
        }
    }
}
