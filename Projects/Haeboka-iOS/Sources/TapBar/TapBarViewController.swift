import UIKit
import Then
import SnapKit

public class TapBarViewController: UITabBarController {
    private lazy var homeViewController: UINavigationController = {
        let viewController = ViewController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), tag: 0)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()

    private lazy var translatorViewController: UIViewController = {
        let viewController = ViewController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Translator"), tag: 1)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()

    private lazy var bookViewController: UIViewController = {
        let viewController = ViewController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Book"), tag: 2)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()

    private lazy var userViewController: UIViewController = {
        let viewController = ViewController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "User"), tag: 2)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [homeViewController, // 0
                           translatorViewController, // 1
                           bookViewController, // 2
                           userViewController] // 3
        configureTabBar()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 90
        tabFrame.origin.y = self.view.frame.size.height - 90
        self.tabBar.frame = tabFrame
    }
}

extension UITabBarController {

    func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = .white

        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }

        self.tabBar.tintColor = .MainGreen
        self.tabBar.layer.cornerRadius = 8
        self.tabBar.layer.backgroundColor = UIColor.systemBackground.cgColor
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 6
    }
}
