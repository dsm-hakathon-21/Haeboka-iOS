import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import DesignSystem

public class SignUpFirstViewController: BaseSV {

    public override func viewDidLoad() {
        super.viewDidLoad()
        updateWith(self)
    }

    public override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)

        firstTitle.text = "새로운 계정으로 시작해요"
        secondTitle.text = "이메일을 입력해 주세요"

        firstTextField.placeholder = "전화번호를 입력해 주세요"
        secondTextField.placeholder = "전송된 인증번호를 입력해 주세요"

        loginFirstNextButton.rx.tap
            .bind {
                if self.navigationController?.viewControllers.contains(where: { $0 is SignUpRestViewController }) == false {
                    print("Navigating to SignUpFirstViewController")
                    self.navigationController?.pushViewController(SignUpRestViewController(), animated: true)
                }
            }.disposed(by: disposeBag)
    }

    public override func attribute() {
        self.view.backgroundColor = .systemBackground
    }
}
