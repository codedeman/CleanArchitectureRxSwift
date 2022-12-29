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

class HomeViewController: BaseViewController {

    private let bag = DisposeBag()
    var viewModel = HomeViewModel()

    // MARK: IBOutlet
    let naviView: HomNaviView = {
        let navi = HomNaviView()
        navi.backgroundColor = .clear
        return navi
    }()

    private let tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.backgroundColor = .clear
        return tableview
    }()

   private let dataSource = RxTableViewSectionedReloadDataSource<HomeSectionModel> (
        // cell
        configureCell: { dataSource, tableView, indexPath, item in
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBannerCell", for: indexPath) as? HomeBannerCell else {return UITableViewCell()}
                if let list = item.list {
                    cell.bindingData(data: list)
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
                let data = item.subItem
                cell.binding(items: data)
                return cell
            }
        }
    )



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
        self.view.addSubview(tableView)
        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        self.tableView.register(HomeBannerCell.self, forCellReuseIdentifier: HomeBannerCell.identifier)
        self.view.addSubview(naviView)
        naviView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.height.equalTo(80)
        }

        tableView.snp.makeConstraints { make in
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.top.equalTo(self.naviView.snp_bottomMargin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

        tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableView.automaticDimension

    }

    private func setUpViewModel() {
        let input = HomeViewModel.Input(paydue: tableView.rx.itemSelected.mapToVoid().asObservable())
        let output = self.viewModel.transform(input: input)
        output.dataSource
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        tableView
          .rx.setDelegate(self)
          .disposed(by: bag)

        output.paydueNavigate
            .drive().disposed(by: bag)
    }
    
    // MARK: IBAction
}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: HomeHeader = HomeHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        let data = dataSource[section].header
        headerView.binding(text: data)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}


