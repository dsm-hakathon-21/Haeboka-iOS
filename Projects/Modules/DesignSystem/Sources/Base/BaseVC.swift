import UIKit

import Then
import SnapKit

//import Moya

import RxSwift
import RxCocoa

open class BaseVC: UIViewController {
    public let bound = UIScreen.main.bounds
    public let disposeBag = DisposeBag()

    open override func viewDidLayoutSubviews() { self.layout() }

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.bind()
        self.configure()
        self.view.setNeedsUpdateConstraints()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.attribute()
        self.touchEvent()
    }

    open func touchEvent() { }
    open func configure() { }
    open func bind() { }
    open func layout() { }
    open func attribute() { }
}
