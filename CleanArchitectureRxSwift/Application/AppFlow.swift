//
//  AppFlow.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/28/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import RxFlow
import Domain
import RxSwift
import RxCocoa
class AppFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private let services: UseCaseProvider

    private lazy var rootViewController: UINavigationController = {
        let vc = UINavigationController()
        vc.setNavigationBarHidden(false, animated: false)
        return vc
    }()

    // MARK: - Init

    init(services: UseCaseProvider) {
        self.services = services
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return FlowContributors.none }
        switch step {
        case .home: return navigateHome()
        case .paydue: return navigateFlexiLoan()
        }
    }
}

extension AppFlow {

    func navigateHome() -> FlowContributors {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: .main)
        vc.viewModel = .init()
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }

    func navigateFlexiLoan() -> FlowContributors {
        let vc = FlexiLoanHomeVC(nibName: "FlexiLoanHomeVC", bundle: .main)
        vc.viewModel = .init(useCase: services.makePostsUseCase())
        self.rootViewController.pushViewController(vc, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }

}
