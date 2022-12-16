//
//  GSXHomeRouter.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/14/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
import Domain

protocol HomeRouterProtocol: AnyObject {
    func routerToGSXHome()
    func routerToInputBorrow(flex: FlexiLoanModel)
}

class HomeRouter: HomeRouterProtocol {
    
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(services: UseCaseProvider,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }
    
    func routerToGSXHome() {
        let vc = FlexiLoanHomeVC(nibName: "FlexiLoanHomeVC", bundle: .main)
        vc.viewModel = .init(useCase: services.makePostsUseCase(), navigator: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func routerToInputBorrow(flex: FlexiLoanModel) {
        let vc = FlexiBorrowViewController(nibName: "FlexiBorrowViewController", bundle: .main)
        vc.flexiModel = flex
        navigationController.pushViewController(vc, animated: true)
    }
   
}
