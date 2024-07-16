import UIKit
import SnapKit
import Then
import Core

open class BaseSV: BaseVC {
    
    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray,
                      .font : UIFont.systemFont(ofSize: 14, weight: .bold)]

    public var firstTitle = UILabel().then {
        $0.text = "기존의 계정으로 계속해요"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.numberOfLines = 1
        $0.textColor = UIColor.Black
    }

    public var secondTitle = UILabel().then {
        $0.text = "계정 정보를 입력하여 시작해 보세요"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.numberOfLines = 1
        $0.textColor = .Gray600
    }

    public var firstTextField = UITextField().then {
        $0.borderStyle = UITextField.BorderStyle.none
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.leftViewMode = .always
        $0.textColor = .Black
    }

    public var secondTextField = UITextField().then {
        $0.borderStyle = UITextField.BorderStyle.none
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.leftViewMode = .always
        $0.textColor = .Black
    }

    public var usernameLine = UIView().then {
        $0.backgroundColor = .Gray400
    }

    public var passwordLine = UIView().then {
        $0.backgroundColor = .Gray400
    }

    public var loginFirstNextButton = UIButton().then {
        $0.setTitle("계속", for: .normal)
        $0.setTitleColor(UIColor.White, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        $0.backgroundColor = .Primary
        $0.layer.cornerRadius = 8.0
    }

    open override func viewDidLoad() {
        updateWith(self)
    }

    public func updateWith(_ controller: UIViewController) {

        view.backgroundColor = .White

        lazy var textFields = [firstTextField, secondTextField]
        let placeholders = ["이름을 입력해 주세요.", "비밀번호를 입력해 주세요."]

        var index = 0
        for textField in textFields {
            textField.attributedPlaceholder = NSAttributedString(string: placeholders[index],
                                                                 attributes: attributes)
            textField.delegate = self
            index += 1
        }
        [
            firstTitle,
            secondTitle,
            firstTextField,
            secondTextField,
            usernameLine,
            passwordLine,
            loginFirstNextButton
        ].forEach { controller.view.addSubview($0) }

        let width = controller.view.frame.width / 430.0
        let height = controller.view.frame.height / 932.0

        firstTitle.snp.makeConstraints {
            $0.top.equalTo(controller.view.safeAreaLayoutGuide).offset(60.0)
            $0.leading.equalToSuperview().inset(24.0)
        }

        secondTitle.snp.makeConstraints {
            $0.top.equalTo(firstTitle.snp.bottom).offset(10.0)
            $0.leading.equalTo(firstTitle.snp.leading)
        }

        firstTextField.snp.makeConstraints {
            $0.top.equalTo(secondTitle.snp.bottom).offset(60.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(382.0 * width)
            $0.height.equalTo(46.0 * height)
        }

        secondTextField.snp.makeConstraints {
            $0.top.equalTo(firstTextField.snp.bottom).offset(16.0)
            $0.centerX.equalTo(firstTextField.snp.centerX)
            $0.width.equalTo(firstTextField.snp.width)
            $0.height.equalTo(firstTextField.snp.height)
        }

        usernameLine.snp.makeConstraints {
            $0.top.equalTo(firstTextField.snp.bottom)
            $0.leading.equalTo(firstTextField.snp.leading)
            $0.height.equalTo(2.0)
            $0.width.equalTo(382)
        }

        passwordLine.snp.makeConstraints {
            $0.top.equalTo(secondTextField.snp.bottom)
            $0.leading.equalTo(secondTextField.snp.leading)
            $0.height.equalTo(2.0)
            $0.width.equalTo(382)
        }

        loginFirstNextButton.snp.makeConstraints {
            $0.height.equalTo(48.0)
            $0.width.equalTo(398.0)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordLine.snp.bottom).offset(405)
        }
    }
    func animate(line: UIView) {
        line.alpha = 0.3
        UIView.animate(withDuration: 1) {
            line.alpha = 1
        }
    }
}

extension BaseSV: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case firstTextField: animate(line: usernameLine)
        case secondTextField: animate(line: passwordLine)
        default: return
        }
    }
}
