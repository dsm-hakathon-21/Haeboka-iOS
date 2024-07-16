import UIKit
import Core

open class BaseNC: UINavigationController {

    private var backButtonImage: UIImage? {
        return UIImage(systemName: "chevron.backward")!
            .withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -12.0, bottom: 0.0, right: 0.0))
    }

    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        return backButtonAppearance
    }

    public static func makeNavigationController(rootViewController: UIViewController) -> BaseNC {
        let navigationController = BaseNC(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
    }

    open func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        let appearance2 = UINavigationBarAppearance()
        navigationBar.tintColor = UIColor.MainGreen
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance2.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backgroundColor = UIColor.clear

        appearance.configureWithTransparentBackground()
        appearance2.configureWithDefaultBackground()
        appearance.backButtonAppearance = backButtonAppearance
        appearance2.backButtonAppearance = backButtonAppearance
        navigationBar.standardAppearance = appearance2
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.backItem?.title = nil
    }
}
