import UIKit
import SnapKit
import Then
import Core
import RxSwift
import RxCocoa

extension UIColor {
    static let Gray400 = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0)
    static let Black = UIColor.black
    static let White = UIColor.white
}

open class BaseSV: BaseVC {
    
    public var buttonTap: ControlEvent<Void> {
        return loginFirstNextButton.rx.tap
    }
    
    public let attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray,
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
        $0.textColor = .Gray400
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
        $0.backgroundColor = .MainGreen
        $0.layer.cornerRadius = 8.0
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        updateWith(self)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        self.view.addGestureRecognizer(tapGesture)
    }

    open func updateWith(_ controller: UIViewController) {
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

    @objc func backgroundTapped() {

    }
}

extension BaseSV: UITextFieldDelegate {
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == firstTextField {
            animate(line: usernameLine, color: .black)
            animate(line: passwordLine, color: .Gray400)
        } else if textField == secondTextField {
            animate(line: passwordLine, color: .black)
            animate(line: usernameLine, color: .Gray400)
        }
    }

    open func textFieldDidEndEditing(_ textField: UITextField) {
        let lineToAnimate = textField == firstTextField ? usernameLine : passwordLine
        let color = textField.text?.isEmpty ?? true ? UIColor.gray : .black
        animate(line: lineToAnimate, color: color)
    }

    public func animate(line: UIView, color: UIColor) {
        UIView.animate(withDuration: 1) {
            line.backgroundColor = color
        }
    }
}
