//
//  HomeViewModel.swift
//  CleanArchitectureRxSwift
//
//  Created Kevin on 12/25/22.
//  Copyright © 2022 sergdort. All rights reserved.
//
//


import Domain
import RxSwift
import RxCocoa
import RxFlow
class HomeViewModel: Stepper {
    let steps = PublishRelay<Step>()

    var initialStep: Step {
        return AppStep.home
    }

}

extension HomeViewModel: ViewModelType {
    func transform(input: Input) -> Output {

        let navigate = input.paydue
            .do(onNext: { [weak  self] in
                guard let wSelf = self else {return}
                wSelf.steps.accept(AppStep.paydue)
            })
        let sections = [
            // section #1
            HomeSectionModel(header: "For you today",
                             items: [
                                Animal(name: "Cats",
                                       list: [
                                        SubItems.init(title: "Repay your GXS Flexilon", subTitle: "S$512.50 due in 7 days"),
                                        SubItems.init(title: "Repay your GXS Flexilon", subTitle: "S$512.50 due in 7 days"),
                                        SubItems.init(title: "Repay your GXS Flexilon", subTitle: "S$512.50 due in 7 days"),
                                        SubItems.init(title: "Repay your GXS Flexilon", subTitle: "S$512.50 due in 7 days")
                                       ],
                                       subItem: SubItems.init(title: "GSX Felexi Loan", subTitle: "S$512.50 due in 7 days")),

                             ]),
            // section #2
            HomeSectionModel(header: "GXS Flexi Loan",
                             items: [
                                Animal(name: "Sparrows", subItem: SubItems.init(title: "GSX Felexi Loan", subTitle: "S$512.50 due in 7 days")),
                             ]),

            HomeSectionModel(header: "Your might be interested in ",
                             items: [
                                Animal(name: "Sparrows", subItem: SubItems.init(title: "GSX Saving account", subTitle: "S$512.50 due in 7 days")),
                             ]
                            )
            ]

        let obserable: Observable<[HomeSectionModel]> = Observable.just(sections)
        return Output.init(dataSource: obserable.asDriverOnErrorJustComplete(), paydueNavigate: navigate.asDriverOnErrorJustComplete())

    }


    struct Input {
        let paydue: Observable<Void>
    }

    struct Output {
        let dataSource: Driver<[HomeSectionModel]>
        let paydueNavigate: Driver<Void>
    }
}

