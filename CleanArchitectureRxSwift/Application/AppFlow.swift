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
    private let services2: HomeUseCaseProvider

    private lazy var rootViewController: UINavigationController = {
        let vc = UINavigationController()
        vc.setNavigationBarHidden(false, animated: false)
        return vc
    }()

    // MARK: - Init

    init(
        services: UseCaseProvider,
        services2: HomeUseCaseProvider
    ) {
        self.services = services
        self.services2 = services2
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return FlowContributors.none }
        switch step {
        case .home: return navigateHome()
        case .paydue: return navigateFlexiLoan()
        case .loan: return navigateLoan()
        }
    }

    func  adapt(step: Step) -> Single<Step> {
        guard let step = step as? AppStep else { return .never() }
        return .just(step)
    }


}

extension AppFlow {

    func navigateHome() -> FlowContributors {
        let viewModel = HomeViewModel.init(userCase: services2.makeUseCase())

        let vc = HomeViewController(viewModel: viewModel)

        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,
                                                 withNextStepper: viewModel))
    }

    func navigateFlexiLoan() -> FlowContributors {
        let vc = FlexiLoanHomeVC(nibName: "FlexiLoanHomeVC", bundle: .main)
        vc.viewModel = .init(useCase: services.makePostsUseCase())
        self.rootViewController.pushViewController(vc, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc,
                                                 withNextStepper: vc.viewModel))
    }

    func navigateLoan() -> FlowContributors {
        let vc = LoansViewController(nibName: "LoansViewController", bundle: .main)
        vc.viewModel = .init()
        self.rootViewController.pushViewController(vc, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }

}
