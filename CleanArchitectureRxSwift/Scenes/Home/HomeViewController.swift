//
//  HomeViewController.swift
//  CleanArchitectureRxSwift
//
//  Created Kevin on 12/25/22.
//  Copyright © 2022 sergdort. All rights reserved.
//
//

import UIKit
import SnapKit
import RxFlow
import RxSwift
import RxCocoa
import RxDataSources
import Domain

class HomeViewController: BaseViewController {
    

    private let bag = DisposeBag()
    private var viewModel: HomeViewModel

    // MARK: IBOutlet
    let naviView: HomNaviView = {
        let navi = HomNaviView()
        navi.backgroundColor = .clear
        return navi
    }()

    private var listFilm: [HomeData] = []

    private let tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.backgroundColor = .clear
        return tableview
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeTopBannerCollectionViewCell.self, forCellWithReuseIdentifier: HomeTopBannerCollectionViewCell.cellIdentifier)
        collectionView.register(FoodCategoryCollectionViewCell.self, forCellWithReuseIdentifier: FoodCategoryCollectionViewCell.cellIdentifier)
        collectionView.register(RestaurantListCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantListCollectionViewCell.cellIdentifier)


        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setUpViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: SetupUI
    private func setupView() {
        self.view.addSubview(collectionView)
        self.collectionView.register(HomeTopBannerCollectionViewCell.self, forCellWithReuseIdentifier: HomeTopBannerCollectionViewCell.cellIdentifier)

        collectionView.snp.makeConstraints { make  in
            make.leading.trailing.equalToSuperview()
            make.bottom.top.equalToSuperview()
        }
        configureCompositionalLayout()

    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setUpViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid().asDriverOnErrorJustComplete()

        let input = HomeViewModel.Input(
            paydue: tableView.rx.itemSelected.mapToVoid().asObservable(),
            loadTrigger: viewWillAppear.asDriver()
        )
        let output = self.viewModel.transform(input: input)

        output.loadTrigger.drive(onNext: { [weak self] home in
            guard let list = home?.listFilms else {return}
            self?.listFilm = list
            self?.collectionView.reloadSections(IndexSet.init(integer: 0))
        }).disposed(by: bag)

        output.paydueNavigate
            .drive().disposed(by: bag)

    }
    
    // MARK: IBAction
}


extension HomeViewController {

    func configureCompositionalLayout(){
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return AppLayouts.shared.foodBannerSection()
            case 1 :
                return AppLayouts.shared.foodCategorySection()
            case 2 :
                return AppLayouts.shared.restaurantsListSection()
            default:
                return AppLayouts.shared.foodBannerSection()

//                return AppLayouts.shared.VeganSectionLayout()
            }
        }
//        layout.register(SectionDecorationView.self, forDecorationViewOfKind: "SectionBackground")
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {

}

extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {
        case 0:
            return listFilm.count
        case 1:
            return foodCategoryMockData.count
        case 2:
            return restaurantListMockData.count
        default:
            return 10
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTopBannerCollectionViewCell.cellIdentifier, for: indexPath) as? HomeTopBannerCollectionViewCell  else {return UICollectionViewCell()}
             let data = listFilm[indexPath.row]
            cell.binding(data: data)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCategoryCollectionViewCell.cellIdentifier, for: indexPath) as? FoodCategoryCollectionViewCell else {return UICollectionViewCell()}
            cell.cellData = foodCategoryMockData[indexPath.row]
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantListCollectionViewCell.cellIdentifier, for: indexPath) as? RestaurantListCollectionViewCell  else {return UICollectionViewCell()}
            cell.cellData = restaurantListMockData[indexPath.row]
            return cell
        }
    }


}
