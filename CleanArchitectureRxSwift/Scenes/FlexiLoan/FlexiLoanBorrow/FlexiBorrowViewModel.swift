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
import RxFlow
//import spm_clean

final class FlexBorrowViewModel: Stepper {
    var steps = RxRelay.PublishRelay<Step>()
    private var flexiModel: FlexiLoanModel
    public  var subject = PublishSubject<String>()
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
                    wSelf.subject.onNext(text)
                    wSelf.flexiModel.availableLOC?.setVal(val: Double(text) ?? 0.0)
                    return true
                } else {
                    return false
                }
            }
        }
        let trigger = input.backTrigger.do(onNext: navigator.toFlexiGXSHome).asDriverOnErrorJustComplete()
        return Output.init(valid: condition, desc: decs, flexiModel: trigger)
    }
    
    struct Input {
        var trigger: Driver<Void>
        var amount: Driver<String>
        var backTrigger: Observable<Void>
    }
    
    struct Output {
        let valid: Driver<Bool>
        var desc: Driver<String>
        var flexiModel: Driver<Void>
    }
}
