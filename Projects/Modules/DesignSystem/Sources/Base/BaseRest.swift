import UIKit
import Then
import SnapKit

open class BaseRest: BaseVC {

    public var goodImage = UIImageView().then {
//        let imageName = "GoodIcon"
//        $0.image = UIImage(named: imageName)
        $0.backgroundColor = .red
    }

    public var firstTitle = UILabel().then {
        $0.text = "축하드립니다!"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.numberOfLines = 1
        $0.textColor = .Black
    }

    public var secondTitle = UILabel().then {
        $0.text = "새로운 계정을 등록했어요\n이제 Import를 시작해 보세요!"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 2
        $0.textColor = .Gray600
        $0.textAlignment = .center
    }

    public var nextButton = UIButton().then {
        $0.setTitle("계속", for: .normal)
        $0.setTitleColor(UIColor.White, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        $0.backgroundColor = .Primary
        $0.layer.cornerRadius = 8.0
    }

    func updateWith(_ controller: UIViewController) {
        [
            goodImage,
            firstTitle,
            secondTitle,
            nextButton
        ].forEach { view.addSubview($0) }

        goodImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(263.0)
            $0.height.width.equalTo(200.0)
        }

        firstTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(goodImage.snp.bottom).offset(60.0)
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
}
