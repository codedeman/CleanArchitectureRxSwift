//
//  HomeModel.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/29/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
import RxFlow
import RxDataSources

struct SubItems {
    var title: String
    var subTitle: String
}
struct Animal {
    var name: String
    var list: [SubItems]?
    var subItem: SubItems
}

struct HomeSectionModel {
    var header: String
    var items: [Item]
}

extension HomeSectionModel: SectionModelType {
    typealias Item = Animal

    init(original: HomeSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
