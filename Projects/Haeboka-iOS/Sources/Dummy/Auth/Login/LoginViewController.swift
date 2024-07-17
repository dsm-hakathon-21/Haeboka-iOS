import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Moya
import DesignSystem

import Core

class LoginViewController: BaseSV {

    override func viewDidLoad() {
        updateWith(self)
    }

    override func attribute() {
        view.backgroundColor = .White
    }

    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
    }
    
    override func bind() {
        buttonTap.bind(onNext: { [weak self] in
            self?.api()
        }).disposed(by: disposeBag)
    }
    
    func api() {
        let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])
        
        provider.request(.login(nickName: firstTextField.text!, password: secondTextField.text!)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...299:
                    if let data = try? JSONDecoder().decode(LoginResponse.self, from: result.data) {
                        print(data.message)
                        TokenStorage.shared.accessToken = data.tokenResponse.accessToken
                        TokenStorage.shared.refreshToken = data.tokenResponse.refreshToken
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


