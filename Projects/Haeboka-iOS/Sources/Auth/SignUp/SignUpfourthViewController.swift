import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import DesignSystem

class SignUpfourthViewController: BaseSV {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateWith(self)
    }

    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)

        firstTitle.text = "새로운 계정으로 시작해요"
        secondTitle.text = "비밀번호를 입력하여 시작해 보세요"

        firstTextField.placeholder = "비밀번호를 입력해 주세요"
        secondTextField.placeholder = "비밀번호를 한 번 더 입력해 주세요"

    }

    override func attribute() {
        self.view.backgroundColor = .systemBackground
    }

    override func touchEvent() {
        super.touchEvent()

        loginFirstNextButton.rx.tap
            .bind {
                if self.navigationController?.viewControllers.contains(where: { $0 is SignUpRestSixthViewController }) == false {
                    print("Navigating to SignUpFirstViewController")
                    self.navigationController?.pushViewController(SignUpRestSixthViewController(), animated: true)
                }
            }.disposed(by: disposeBag)
    }
}
