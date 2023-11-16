//
//  DataTable.swift
//  BookManangement
//
//  Created by 하고 싶은 걸 하고 살자 on 2023/11/14.
//

import Foundation

class DataTable {
    static let instance = DataTable()
    typealias UserTuple = (age: String, memberId: String, phoneNumber: String, bookRented: String)
    
    var userDataDictionary: [String:Array] = ["김지수" : ["25", "1001", "01012345678", "3"],
                                                  "이민호" : ["32", "1002", "01012345678", "5"],
                                                  "박찬열" : ["28", "1003", "01034567890", "2"],
                                                  "최시원": ["35", "1004", "01045678901", "4"],
                                                  "강슬기" : ["26", "1005", "01056789012", "6"],
                                                  "임윤아" : ["30", "1006", "01067890123", "1"],
                                                  "정호석" : ["27", "1007", "01078901234", "2"],
                                                  "김태형" : ["29", "1008", "01089012345", "2"],
                                                  "송혜교" : ["38", "1009", "01090123456", "5"],
                                                  "전정국" : ["24", "1010", "01001234567", "3"]]
}
