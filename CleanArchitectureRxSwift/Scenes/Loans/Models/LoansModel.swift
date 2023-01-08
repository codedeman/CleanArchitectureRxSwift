//
//  LoansModel.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/30/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
import RxDataSources

 struct LoanSectionModel {
    var dateStr: String
    var price: String
    var isExpand: Bool
    var items: [LoanItems]

    mutating func setIsExpand(isExpand: Bool) {
         self.isExpand = isExpand
    }
}

 struct LoanItems {
    let price: String
    let principal: String
    let interest: String
}

extension LoanSectionModel: SectionModelType {

    typealias Item = LoanItems
    init(original: LoanSectionModel, items: [Item]) {
        self = original
        self.items = items
    }

}
