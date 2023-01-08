import Foundation
import Domain
import NetworkPlatform
import CoreDataPlatform
import RealmPlatform
import RxFlow
import RxSwift
final class Application {
    static let shared = Application()

    private let coreDataUseCaseProvider: Domain.UseCaseProvider
    private let realmUseCaseProvider: Domain.UseCaseProvider
    private let networkUseCaseProvider: Domain.UseCaseProvider
    private let homeNetWorkProvider: Domain.HomeUseCaseProvider
    var coordinator = FlowCoordinator()
    let disposeBag = DisposeBag()
    var homeViewModel: HomeViewModel {
        return HomeViewModel.init(
            userCase: homeNetWorkProvider.makeUseCase()
        )
    }

    lazy var appFlow = {
        return AppFlow(
            services: networkUseCaseProvider,
            services2: homeNetWorkProvider
        )
    }()

    private init() {
        self.coreDataUseCaseProvider = CoreDataPlatform.UseCaseProvider()
        self.realmUseCaseProvider = RealmPlatform.UseCaseProvider()
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
        self.homeNetWorkProvider = NetworkPlatform.DBHomeUseCaseProvider()
    }

    func configureMainInterface(in window: UIWindow) {

        coordinator.rx.didNavigate.subscribe { (flow, step) in
            print("Did navigate to flow=\(flow) and step=\(step)")

        }.disposed(by: disposeBag)

        self.coordinator.coordinate(flow: appFlow, with: self.homeViewModel)

        Flows.use(self.appFlow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }

    }

    func setUpFlow() {


    }
}
