//
//  Dependency+SPM.swift
//  MyPlugin
//
//  Created by 박준하 on 2023/07/03.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let Then = TargetDependency.external(name: "Then")
    static let Moya = TargetDependency.external(name: "Moya")
    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let RxDataSources = TargetDependency.external(name: "RxDataSources")
    static let KeychainSwift = TargetDependency.external(name: "KeychainSwift")
}
