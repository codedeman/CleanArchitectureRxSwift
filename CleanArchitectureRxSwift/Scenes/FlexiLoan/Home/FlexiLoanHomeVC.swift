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
//import RxO

class FlexiLoanHomeVC: BaseViewController {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lblAvailable: UILabel!
    @IBOutlet weak var lblInterestRate: UILabel!
    @IBOutlet weak var btnBrower: UIButton!
    private let disposeBag = DisposeBag()
    var viewModel: FlexiHomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBinding()
        self.navigationItem.title = "GSX FlexiLoan"
        self.vBackground.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.sub.subscribe { [weak self] text in
            self?.lblAvailable.text = text
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        sub.asDriverOnErrorJustComplete().drive(lblAvailable.rx.text).disposed(by: disposeBag)
    }
    
    private func setUpBinding() {
        let viewDidLoad = rx
            .sentMessage(#selector(UIViewController.viewDidLayoutSubviews))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = FlexiHomeViewModel.Input(browerTrigger:btnBrower.rx.tap.asDriver().asDriver(), trigger: viewDidLoad.asDriver())
        let output = viewModel.transform(input: input)
        
        output.available
            .drive(lblAvailable.rx.text)
            .disposed(by: disposeBag)
        
        output.description
            .drive(lblInterestRate.rx.text)
            .disposed(by: disposeBag)
        
        output.selectedBorrow
            .drive()
            .disposed(by: disposeBag)
        
        output.available
            .drive(lblAvailable.rx.text)
            .disposed(by: disposeBag)
        
    }
    
}
