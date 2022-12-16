//
//  GSXFlexiBorrowViewModel.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/14/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class FlexBorrowViewModel {
    private var flexiModel: FlexiLoanModel
    public  var subject = PublishSubject<FlexiLoanModel>()
    private let navigator: FlexiBorrowNavi
    
    init(flexiModel: FlexiLoanModel,
         navigator: FlexiBorrowNavi) {
        self.flexiModel = flexiModel
        self.navigator = navigator
    }
}

extension FlexBorrowViewModel: ViewModelType {
  
    func transform(input: Input) -> Output {
        
        let decs = input.trigger
            .flatMapLatest  { [unowned self] in
                return PublishSubject<String>.just("Enter an amount between S$\(flexiModel.min?.val ?? 0.0) and S$ \(flexiModel.max?.val ?? 0.0)").asDriverOnErrorJustComplete()
            }
        
        let condition = input.amount.map { [weak self] text -> Bool in
            guard let wSelf = self else {return false}
            if text.isEmpty {
                return true
            } else {
                if Double(text) ?? 0.0 > wSelf.flexiModel.min?.val ?? 0.0
                    && Double(text) ?? 0.0 < wSelf.flexiModel.max?.val ?? 0.0 {
                    
                    wSelf.flexiModel.availableLOC?.setVal(val: Double(text) ?? 0.0)
                    wSelf.subject.onNext(wSelf.flexiModel)
                    return true
                } else {
                    return false
                }
            }
        }
        
        let trigger = input.backTrigger
            .withLatestFrom(subject.asDriverOnErrorJustComplete())
            .do {  [weak self]  obj in
            guard let self = self else {return}
            self.navigator.toFlexiGXSHome(flexiObj: obj)
        }
        return Output.init(valid: condition, desc: decs, flexiModel: trigger.asDriverOnErrorJustComplete())
    }
    
    struct Input {
        var trigger: Driver<Void>
        var amount: Driver<String>
        var backTrigger: Observable<Void>
    }
    
    struct Output {
        let valid: Driver<Bool>
        var desc: Driver<String>
        var flexiModel: Driver<FlexiLoanModel>
    }
}
