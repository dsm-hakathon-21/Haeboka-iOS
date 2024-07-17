//
//  signupModel.swift
//  Haeboka-iOS
//
//  Created by 현석의 맥북 on 7/16/24.
//  Copyright © 2024 Haeboka-iOS. All rights reserved.
//

import Foundation


class UserInfo {
    static let shared = UserInfo()
    
    var nickname: String?
    var password: String?
    var email: String?
    
    private init() {}
}
