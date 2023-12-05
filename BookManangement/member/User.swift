//
//  User.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/12/03.
//

import Foundation
import RxSwift

class User {
    var name:String? = nil
    var age:String? = nil
    var memberId:String? = nil
    var phoneNumber:String? = nil
    var boodRented:String? = nil
    var handler: ((String) -> Void)? = nil
    var disposable: Disposable? = nil
    
    init(name: String? = nil, age: String? = nil, memberId: String? = nil, phoneNumber: String? = nil, boodRented: String? = nil, handler:@escaping (String) -> Void) {
        self.name = name
        self.age = age
        self.memberId = memberId
        self.phoneNumber = phoneNumber
        self.boodRented = boodRented
        self.handler = handler
        
        disposable = ViewController.publishSubject.subscribe(onNext:{ self.subscribeAction(value:$0)})
    }
    
    deinit{
        disposable?.dispose()
    }
//    1. 회원등록
//    2. 회원검색
//    3. 회원 목록(전체보기)
//    4. 저장하기
//    5. 상위메뉴 이동
    func subscribeAction(value:String) {
        guard let handler = handler else {return}
        switch value {
        case "1":
            addMember()
        default:
            handler("해당하는 항목이 없습니다.")
        }
    }
    
    func addMember() {
        
    }
    
}
