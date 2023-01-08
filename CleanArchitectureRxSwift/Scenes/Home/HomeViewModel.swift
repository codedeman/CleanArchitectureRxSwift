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
    private var userCase: HomeUseCase
    var initialStep: Step {
        return AppStep.home
    }

    init(userCase: HomeUseCase) {
        self.userCase = userCase
    }

}

extension HomeViewModel: ViewModelType {

    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()

        let loadTriger = input
            .loadTrigger
            .flatMapLatest {
                return self.userCase
                    .getFilm()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }.asDriver(onErrorJustReturn: nil)


        let navigate = input.paydue
            .do(onNext: { [weak  self] in
                guard let wSelf = self else {return}
                wSelf.steps.accept(AppStep.loan)
            })

        return Output.init(
            paydueNavigate: navigate.asDriverOnErrorJustComplete(),
            loadTrigger: loadTriger.asDriver()
        )

    }

    struct Input {
        let paydue: Observable<Void>
        let loadTrigger: Driver<Void>
    }

    struct Output {
        let paydueNavigate: Driver<Void>
        let loadTrigger: Driver<Home?>
    }

}

