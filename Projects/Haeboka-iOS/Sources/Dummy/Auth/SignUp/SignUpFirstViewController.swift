import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import DesignSystem
import Moya

public class SignUpFirstViewController: BaseSV {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        updateWith(self)
    }
    
    public var checkButton = UIButton().then {
        $0.setTitle("인증번호 받기", for: .normal)
        $0.setTitleColor(UIColor.White, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        $0.backgroundColor = .MainGreen
        $0.layer.cornerRadius = 8.0
    }
    
    
    public override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        view.addSubview(checkButton)
        setLayOut()
        
        
        firstTitle.text = "새로운 계정으로 시작해요"
        secondTitle.text = "이메일 인증을 통해 시작해보세요"
        
        firstTextField.placeholder = "이메일을 입력해 주세요"
        secondTextField.placeholder = "전송된 인증번호를 입력해 주세요"
        
        loginFirstNextButton.rx.tap
            .bind {
                if self.navigationController?.viewControllers.contains(where: { $0 is SignUpRestViewController }) == false {
                    print("Navigating to SignUpFirstViewController")
                    //                    UserInfo.shared.email =
                    self.navigationController?.pushViewController(SignUpRestViewController(), animated: true)
                }
            }.disposed(by: disposeBag)
    }
    
    func api() {
        let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])
        
        provider.request(.sendMail(target: firstTextField.text!)) { res in
            switch res {
            case.success(let result):
                switch result.statusCode {
                case 200...299:
                    print("success")
                default:
                    print("fail")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
        
        func setLayOut() {
            checkButton.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(passwordLine.snp.bottom).offset(32)
                $0.height.equalTo(48)
                $0.leading.trailing.equalToSuperview().inset(16)
            }
        }
        
        public override func attribute() {
            self.view.backgroundColor = .systemBackground
        }
    }

