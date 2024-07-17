import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import DesignSystem
import Moya

class SignUpSecondViewController: BaseSV {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateWith(self)
    }

    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)

        lazy var textFields = [firstTextField, secondTextField]
        let placeholders = ["실명을 입력해 주세요", "아이디를 입력해 주세요"]

        var index = 0
        for textField in textFields {
            textField.attributedPlaceholder = NSAttributedString(string: placeholders[index],
                                                                 attributes: attributes)
            textField.delegate = self
            index += 1
        }

        firstTitle.text = "새로운 계정으로 시작해요"
        secondTitle.text = "정보를 입력하여 시작해 보세요"

        loginFirstNextButton.rx.tap
            .bind {
                if self.navigationController?.viewControllers.contains(where: { $0 is SignUpfourthViewController }) == false {
                    print("Navigating to SignUpFirstViewController")
                    self.navigationController?.pushViewController(SignUpfourthViewController(), animated: true)
                }
            }.disposed(by: disposeBag)
        

    }

    override func attribute() {
        self.view.backgroundColor = .systemBackground
    }
}

extension SignUpSecondViewController {
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case firstTextField: animate(line: usernameLine, color: .black)
        case secondTextField: animate(line: passwordLine, color: .black)
        default: return
        }
    }
}
