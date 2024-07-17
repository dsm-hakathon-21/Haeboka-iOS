//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 박준하 on 2023/07/03.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.mainModule(
    name: "Haeboka-iOS",
    platform: .iOS,
    product: .app,
    dependencies: [
        .Project.Core,
        .Project.DesignSystem
    ],
    resources: ["Resources/**"],
    infoPlist: .extendingDefault(with: Project.baseinfoPlist),
    coreDataModels: [.init("Sources/Service/Model/JAGIJUDO.xcdatamodeld")]
)
