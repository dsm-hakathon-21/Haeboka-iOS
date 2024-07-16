import ProjectDescription
import ProjectDescriptionHelpers

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.0")),
    .remote(url: "https://github.com/MaeumGaGym/Moya", requirement: .upToNextMajor(from: "15.0.1")), .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2"))
])

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: spm,
    platforms: [.iOS]
)

