//
//  FlexiRouterMock.swift
//  CleanArchitectureRxSwiftTests
//
//  Created by Kevin on 12/16/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
@testable import CleanArchitectureRxSwift
import Domain

class FlexiRouterMock: HomeNaviProtocol {
    func toInputBorrow(flex: Domain.FlexiLoanModel, replaySb: RxSwift.PublishSubject<String>) {
        <#code#>
    }

    
    var toBorrow_Called = false
    var toBorrow_ReceivedArguments: FlexiLoanModel?

    func toGSXHome() {
        toBorrow_Called = true
    }
    
    func toInputBorrow(flex: FlexiLoanModel) {
        toBorrow_ReceivedArguments = flex
        toBorrow_Called = true
    }
    
}
