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

class FlexiBorrowViewController: BaseViewController{

    @IBOutlet weak private var txtInputAmount: UITextField!
    @IBOutlet weak private var lblDescription: UILabel!
    
    var viewModel: FlexBorrowViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUi()
        self.setUpBindModel()
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
//    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setUpUi() {
        self.txtInputAmount.keyboardType = .numberPad
    }
    
    private func setUpBindModel() {
        self.navigationItem.hidesBackButton = true
        var customBackButton = UIBarButtonItem(title: "Back", style: .done,
                                               target: nil, action: nil)
        navigationItem.leftBarButtonItem = customBackButton
        
        
        let backTrigger = customBackButton.rx.tap.asDriver()
        
        backTrigger.asObservable().subscribe { [weak self] event in
            guard let self = self, let vc = self.navigationController?.viewControllers.first as? FlexiLoanHomeVC else {return}
            vc.sub.accept(self.txtInputAmount.text ?? "")
            self.navigationController?.popToViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        
        let viewDidLoad = rx.sentMessage(#selector(UIViewController.viewDidLayoutSubviews))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input =  FlexBorrowViewModel.Input(trigger:viewDidLoad,
                                               amount: txtInputAmount.rx.text.orEmpty.asDriver(), backTrigger: backTrigger)
        let output = viewModel.transform(input: input)
        output.desc.drive(lblDescription.rx.text).disposed(by: disposeBag)

        output.valid.drive { [weak self] isValid in
            guard let self = self else {return}
            self.lblDescription.textColor =  isValid ? .white : .red
        }.disposed(by: disposeBag)
        
    }

}
