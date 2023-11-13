//
//  Utility.swift
//  BookManangement
//
//  Created by uniwiz on 11/13/23.
//

import Foundation
import UIKit

class Utility {
    static func getRootViewController(vc:UIViewController? = UIApplication.shared.windows.first?.rootViewController ?? nil) -> UIViewController? {
        if let presentedVc = vc?.presentedViewController {
            return getRootViewController(vc:presentedVc)
        }
        return vc
    }
}
