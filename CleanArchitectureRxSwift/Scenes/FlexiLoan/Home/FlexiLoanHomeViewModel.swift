//
//  GSXFlexiLoanHomeViewModel.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/14/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa
import RxFlow

final class FlexiHomeViewModel: Stepper {
    var steps = PublishRelay<Step>()
    private let useCase: PostsUseCase
    var sub = PublishSubject<String>()

    init(
        useCase: PostsUseCase
    ) {
        self.useCase = useCase
    }
}

extension FlexiHomeViewModel: ViewModelType {
    
    struct Input {
        let browerTrigger: Driver<Void>
        let trigger: Driver<Void>
    }
    
    struct Output {
        let flexiModel: Driver<FlexiLoanModel>
        let selectedBorrow: Driver<FlexiLoanModel>
        let description: Driver<String>
        let available: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
            let flexiModel =  useCase
                .getFlexiLoan()
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        
        let description = flexiModel
            .map {String.init("Interest @ \($0.offeredInterestRate ?? 0.0) % p.a (\($0.offeredEIR ?? 0.0) p.a")}
            .asDriver()
        
        let available = flexiModel
            .map {
                String.init("$S \($0.availableLOC?.val ?? 0.0)")}
            .asDriver()

        let objSelect = flexiModel.asDriver()
    
        let borrowSelected = input
            .browerTrigger
            .withLatestFrom(objSelect).do { [weak self] obj in
                guard let self = self else {return }
                self.steps.accept(AppStep.loan)

        }
        
        return Output.init(flexiModel: flexiModel,
                           selectedBorrow: borrowSelected,
                           description: description ,
                           available: available)
    }
    
}
