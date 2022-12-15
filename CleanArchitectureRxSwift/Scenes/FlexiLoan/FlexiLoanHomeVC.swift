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
    
    var gsxValue = PublishSubject<GSXValue>()
    var flexiModel = PublishSubject<FlexiLoanModel> ()
    var gxsTest = BehaviorSubject<GSXValue>(value: GSXValue.init(currencyCode: "VNS", val: 1110.0))

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
        
        gxsTest.onNext(GSXValue.init(currencyCode: "AU-USD", val: 1001010.0))

        gxsTest.subscribe { print("test --",$0.element?.currencyCode ?? "USD")}

//        Observable.zip(gsxValue, flexiModel,gxsTest).subscribe { gsx, flex, test in
//            print("gsx value \(gsx.currencyCode) fex \(String(describing: flex.availableLOC?.currencyCode)) \(test.currencyCode)")
//        }.disposed(by: disposeBag)
//
        gsxValue.onNext(GSXValue.init(currencyCode: "USD", val: 200.0))
        flexiModel.onNext(FlexiLoanModel.init(availableLOC: GSXValue.init(currencyCode: "VND", val: 400.0)))
        
        let viewDidLoad = rx.sentMessage(#selector(UIViewController.viewDidLayoutSubviews))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = HomeViewModel.Input(browerTrigger:btnBrower.rx.tap.asDriver().asDriver() , trigger: viewDidLoad.asDriver())
        let output = viewModel.transform(input: input)
        output.available.drive(lblAvailable.rx.text).disposed(by: disposeBag)
        output.description.drive(lblInterestRate.rx.text).disposed(by: disposeBag)
        output.selectedBorrow.drive().disposed(by: disposeBag)
    }
}
