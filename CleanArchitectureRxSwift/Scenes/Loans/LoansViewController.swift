//
//  LoansViewController.swift
//  CleanArchitectureRxSwift
//
//  Created Kevin on 12/30/22.
//  Copyright © 2022 sergdort. All rights reserved.
//
//

import UIKit
import RxDataSources
import RxSwift

class LoansViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    public var viewModel = LoansViewModel()
    private let bag = DisposeBag()
//    private let indexObserable: = ObservedObject<Ind>
    private let tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.backgroundColor = .clear
        return tableview
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setUpViewModel()
    }

    private let dataSource = RxTableViewSectionedReloadDataSource<LoanSectionModel>  { dataSource, tableView, indexPath, items in
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoanCellTableViewCell", for: indexPath) as? LoanCellTableViewCell else {return UITableViewCell()}
        return cell
    }


    
    private func setUpViewModel () {
        let input = LoansViewModel.Input()
        let output = viewModel.transform(input: input)
        output.dataSources
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        tableView
          .rx.setDelegate(self)
          .disposed(by: bag)

    }




    // MARK: Fetch Loans
    private func fetchDataOnLoad() {
        // NOTE: Ask the Interactor to do some work
        
    }

    
    // MARK: SetupUI
    private func setupView() {
        self.view.addSubview(tableView)
        self.tableView.register(LoanCellTableViewCell.self, forCellReuseIdentifier: LoanCellTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableView.automaticDimension
    }


    // MARK: IBAction

    enum TableViewEditingCommand {
        case SelectItem(IndexPath)

    }

}


extension LoansViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView: LoanHeaderView = LoanHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}





