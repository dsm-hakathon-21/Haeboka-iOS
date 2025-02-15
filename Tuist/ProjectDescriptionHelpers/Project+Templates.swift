import ProjectDescription
import UtilityPlugin

public extension Project {
    static func makeModule(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "Haeboka-iOS",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default
    ) -> Project {
        
        let settings: Settings = .settings(
            base:
                product == .app ? .init().setCodeSignManualForApp() : .init().setCodeSignManual(),
            debug: .init()
                .setProvisioningDevelopment(),
            release: .init()
                .setProvisioningAppstore(),
            defaultSettings: .recommended)
        
        let bundleId = (name == "Haeboka-iOS") ? "com.haeboka-iOS.release" : "\(organizationName).\(name)"
        
        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: bundleId,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
//            scripts: [.SwiftLintString],
            dependencies: dependencies
            
        )
        
        let targets: [Target] = [appTarget]
        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
    
    static func mainModule(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "Haeboka-iOS",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        coreDataModels: [CoreDataModel?] = []
    ) -> Project {
        
        let settings: Settings = .settings(
            base:
                product == .app ? .init().setCodeSignManualForApp() : .init().setCodeSignManual(),
            debug: .init()
                .setProvisioningDevelopment(),
            release: .init()
                .setProvisioningAppstore(),
            defaultSettings: .recommended)
        
        let bundleId = (name == "Haeboka-iOS") ? "com.haeboka-iOS.release" : "\(organizationName).\(name)"
        
        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: bundleId,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            coreDataModels: [
                CoreDataModel("Sources/Service/Model/JAGIJUDO.xcdatamodeld"),
            ]
        )
        
        let targets: [Target] = [appTarget]
        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
    
    static let baseinfoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0.0",
            "CFBundleVersion": "1",
            "CFBundleIdentifier": "com.app-iOS.release",
            "CFBundleDisplayName": "APP",
            "UILaunchStoryboardName": "LaunchScreen",
            "UIApplicationSceneManifest": [
                "UIApplicationSupportsMultipleScenes": false,
                "UISceneConfigurations": [
                    "UIWindowSceneSessionRoleApplication": [
                        [
                            "UISceneConfigurationName": "Default Configuration",
                            "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                        ],
                    ]
                ]
            ],
            "UIAppFonts": [
                // FIXME: - 폰트 추가 후 수정
//                "Item 0": "폰트이름.otf",
            ],
            "App Transport Security Settings": ["Allow Arbitrary Loads": true],
            "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
            "ITSAppUsesNonExemptEncryption": false,
            "UIBackgroundModes": ["fetch", "remote-notification"],
            "UIUserInterfaceStyle": "Light"
        ]
}

extension Scheme {

    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
