//
//  LoansViewModel.swift
//  CleanArchitectureRxSwift
//
//  Created Kevin on 12/30/22.
//  Copyright © 2022 sergdort. All rights reserved.
//
//


import Domain
import RxSwift
import RxCocoa
import RxFlow

class LoansViewModel: Stepper {
    let steps = PublishRelay<Step>()
}

extension LoansViewModel: ViewModelType {
    func transform(input: Input) -> Output {
        let sections = [
            LoanSectionModel.init(dateStr: "Due on 15 Dec 2021", price: "S$512.50", isExpand: false, items: [LoanItems.init(price: "S$512.50", principal: "$4", interest: "$5")]),
            LoanSectionModel.init(dateStr: "Due on 15 Dec 2021", price: "S$512.50", isExpand: false, items: [LoanItems.init(price: "S$512.50", principal: "$4", interest: "$5")]),
            LoanSectionModel.init(dateStr: "Due on 15 Dec 2021", price: "S$512.50", isExpand: false, items: [LoanItems.init(price: "S$512.50", principal: "$4", interest: "$5")]),
        ]
        let obserable: Observable<[LoanSectionModel]> = Observable.just(sections)
        
        return Output.init(dataSources: obserable.asDriverOnErrorJustComplete())
    }


    struct Input {

    }

    struct Output {

        let dataSources: Driver<[LoanSectionModel]>
    }
}

