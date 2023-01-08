//
//  DBHomeUseCase.swift
//  NetworkPlatform
//
//  Created by Kevin on 5/27/23.
//  Copyright © 2023 sergdort. All rights reserved.
//

import UIKit
import Domain
public final class DBHomeUseCaseProvider: HomeUseCaseProvider {
    let networkProvider: NetworkProvider

    public init() {
        self.networkProvider = NetworkProvider()
    }

    public func makeUseCase() -> Domain.HomeUseCase {
        return HomeUseCase(network: networkProvider.makeHomeUseCase())
    }


}
