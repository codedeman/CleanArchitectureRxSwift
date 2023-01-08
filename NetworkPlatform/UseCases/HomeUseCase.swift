//
//  HomeUseCase.swift
//  NetworkPlatform
//
//  Created by Kevin on 6/2/23.
//  Copyright © 2023 sergdort. All rights reserved.
//

import UIKit
import Domain
import RxSwift

final class HomeUseCase: Domain.HomeUseCase {

    private let network: HomeNetWork

    init(network: HomeNetWork) {
        self.network = network
    }

    func getFilm() -> RxSwift.Observable<Domain.Home?> {
        network.getFilm()
    }
}
