//
//  LoansNavigator.swift
//  CleanArchitectureRxSwift
//
//  Created Kevin on 12/30/22.
//  Copyright © 2022 sergdort. All rights reserved.
//
//


import Domain
import RxSwift
import RxCocoa

protocol LoansNaviProtocol: AnyObject {

}

class LoansNavigator: LoansNaviProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }


}
