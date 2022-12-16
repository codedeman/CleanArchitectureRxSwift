//
//  GSXFlexiBorrowViewController.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/14/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class FlexiBorrowViewController: BaseViewController {

    @IBOutlet weak private var txtInputAmount: UITextField!
    @IBOutlet weak private var lblDescription: UILabel!
    
    var flexiModel: FlexiLoanModel?
    var viewModel =  FlexBorrowViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUi()
        self.setUpBindModel()
        // Do any additional setup after loading the view.
    }
    
    private func setUpUi() {
        self.txtInputAmount.keyboardType = .numberPad
        self.lblDescription.text = "Enter an amount between S$\(flexiModel?.min?.val ?? 0.0) and S$ \(flexiModel?.max?.val ?? 0.0)"
    }
    
    private func setUpBindModel() {
        let input =  FlexBorrowViewModel.Input(amount: txtInputAmount.rx.text.orEmpty.asDriver(),min: flexiModel?.min?.val ?? 0.0, max: flexiModel?.max?.val ?? 0.0)
        
        let output = viewModel.transform(input: input)
        
        output.valid
            .asObservable()
            .subscribe { isValid in
            self.lblDescription.textColor =  isValid ? .white : .red
        }.disposed(by: disposeBag)
    }

}
