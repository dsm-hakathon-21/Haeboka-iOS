//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 2023/07/03.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ThirdPartyLib",
    product: .framework,
    packages: [],
    dependencies: [
        .SPM.SnapKit,
        .SPM.Then,
//        .SPM.Moya,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxDataSources,
        .SPM.KeychainSwift
    ]
)
