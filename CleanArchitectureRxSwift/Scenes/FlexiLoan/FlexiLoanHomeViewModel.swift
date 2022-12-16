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

final class HomeViewModel {
    private let useCase: PostsUseCase
    private let navigator: HomeRouterProtocol
    
    init(useCase: PostsUseCase, navigator: HomeRouterProtocol) {
        self.useCase = useCase
        self.navigator = navigator
    }
}

extension HomeViewModel: ViewModelType {
    
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
        
        let flexiModel = input.trigger.flatMapLatest {
            return self.useCase
                .getFlexiLoan()
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        
        let description = flexiModel
            .map {String.init("Interest @ \($0.offeredInterestRate ?? 0.0) % p.a (\($0.offeredEIR ?? 0.0) p.a")}
            .asDriver()
        
        let available = flexiModel
            .map {String.init("$S \($0.availableLOC?.val ?? 0.0)")}
            .asDriver()
        
        let objSelect = flexiModel.asDriver()
        
        let borrowSelected = input
            .browerTrigger
            .withLatestFrom(objSelect).do { obj in
            self.navigator.routerToInputBorrow(flex: obj)
        }
        
        return Output.init(flexiModel: flexiModel, selectedBorrow: borrowSelected, description: description , available: available)
    }

    
}
