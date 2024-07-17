//
//  TestVC.swift
//  Haeboka-iOS
//
//  Created by 현석의 맥북 on 7/17/24.
//  Copyright © 2024 Haeboka-iOS. All rights reserved.
//

import Foundation
import UIKit
import Then
import SnapKit
import Moya

class TestVC: UIViewController {
    
    override func viewDidLoad() {
        let provider = MoyaProvider<GPTAPI>(plugins: [MoyaLoggerPlugin()])
        
        provider.request(.GPT(
            model: "dfskl",
            message: Message(role: "user", content: "fjdskl")
        )) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...299:
                    if let data = try? JSONDecoder().decode(GPTResponse.self, from: result.data) {
                        print(data.choices)
                    }
                default:
                    print("fail")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
