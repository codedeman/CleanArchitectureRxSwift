//
//  GSXFlexiLoanHomeVC.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/14/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Domain

class FlexiLoanHomeVC: BaseViewController {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lblAvailable: UILabel!
    @IBOutlet weak var lblInterestRate: UILabel!
    @IBOutlet weak var btnBrower: UIButton!
    private let disposeBag = DisposeBag()
    
    var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBinding()
        self.navigationItem.title = "GSX FlexiLoan"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vBackground.backgroundColor = .clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setUpBinding() {
        let viewDidLoad = rx.sentMessage(#selector(UIViewController.viewDidLayoutSubviews))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = HomeViewModel.Input(browerTrigger:btnBrower.rx.tap.asDriver().asDriver() , trigger: viewDidLoad.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.flexiModel.asObservable().subscribe { event in
            switch event {
            case .next(let flex):
                if let val = flex.availableLOC?.val {
                    self.lblAvailable.text = "$S \(val)"
                    self.lblInterestRate.text = "Interest @ \(String(describing: flex.offeredInterestRate ?? 0.0)) % p.a (\(flex.offeredEIR ?? 0) p.a .EIR)"
                }
            case .error(_):
                break
            case .completed:
                break
            }
        }.disposed(by: disposeBag)
        
        output.selectedBorrow.drive().disposed(by: disposeBag)
    }
}
