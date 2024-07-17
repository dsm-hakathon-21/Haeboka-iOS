import UIKit
import DesignSystem
import Then
import SnapKit

class SignUpRestViewController: BaseVC {
    
    private lazy var restImage = UIImageView().then {
        let imageName = "RestImage"
        $0.image = UIImage(named: imageName)
    }
    
    private lazy var firstTitle = UILabel().then {
        $0.text = "거의 다 왔어요!"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.numberOfLines = 1
        $0.textColor = .Black
    }
    
    private lazy var secondTitle = UILabel().then {
        $0.text = "이제, 사용하실 정보를 입력하고\n해보카를 이용해 보세요"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 2
        $0.textColor = .Gray600
        $0.textAlignment = .center
    }
    
    private lazy var nextButton = UIButton().then {
        $0.setTitle("계속", for: .normal)
        $0.setTitleColor(UIColor.White, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        $0.backgroundColor = .MainGreen
        $0.layer.cornerRadius = 8.0
    }
    
    override func layout() {
        [
            restImage,
            firstTitle,
            secondTitle,
            nextButton
        ].forEach { view.addSubview($0) }
        
        restImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(183.0)
            $0.height.width.equalTo(300.0)
        }
        
        firstTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(restImage.snp.bottom).offset(40.0)
        }
        
        secondTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(firstTitle.snp.bottom).offset(10.0)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(secondTitle.snp.bottom).offset(189.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48.0)
            $0.width.equalTo(398.0)
        }
    }
    
    override func touchEvent() {
        super.touchEvent()
        
        nextButton.rx.tap
            .bind {
                if self.navigationController?.viewControllers.contains(where: { $0 is SignUpSecondViewController }) == false {
                    print("Navigating to SignUpFirstViewController")
                    self.navigationController?.pushViewController(SignUpSecondViewController(), animated: true)
                }
            }.disposed(by: disposeBag)
    }
}
