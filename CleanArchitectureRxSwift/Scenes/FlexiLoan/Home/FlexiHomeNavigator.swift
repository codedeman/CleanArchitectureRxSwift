//
//  GSXHomeRouter.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/14/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

protocol HomeNaviProtocol: AnyObject {
    func toGSXHome()
    func toInputBorrow(flex: FlexiLoanModel, replaySb: PublishSubject<String>)
}

class HomeNavigator: HomeNaviProtocol {
    func toInputBorrow(flex: Domain.FlexiLoanModel, replaySb: PublishSubject<String>) {
        let flexNav = FlexiBorrowNavi.init(navigationController: self.navigationController)
        let vc = FlexiBorrowViewController(nibName: "FlexiBorrowViewController", bundle: .main)
        vc.viewModel = FlexBorrowViewModel.init(flexiModel: flex, navigator: flexNav)
        vc.viewModel.subject = replaySb
        navigationController.pushViewController(vc, animated: true)
    }

    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(services: UseCaseProvider,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }
    
    func toGSXHome() {
        let vc = FlexiLoanHomeVC(nibName: "FlexiLoanHomeVC", bundle: .main)
        vc.viewModel = .init(useCase: services.makePostsUseCase())
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func toInputBorrow(flex: FlexiLoanModel) {
        let flexNav = FlexiBorrowNavi.init(navigationController: self.navigationController)
        let vc = FlexiBorrowViewController(nibName: "FlexiBorrowViewController", bundle: .main)
        vc.viewModel = FlexBorrowViewModel.init(flexiModel: flex, navigator: flexNav)
        navigationController.pushViewController(vc, animated: true)
    }
   
}
