//
//  AppViewModel.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/28/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import RxFlow
import RxRelay
import Domain

class AppStepper: Stepper {
    
    let steps = PublishRelay<Step>()
    private let services: UseCaseProvider

    init(services: UseCaseProvider) {
        self.services = services
    }

    func readyToEmitSteps() {
    }

}
