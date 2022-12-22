//
//  FlexiBorrowNavi.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/21/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol FlexiBorrowNaviProcol: AnyObject {
    func toFlexiGXSHome(flexiObj: FlexiLoanModel)
}

class FlexiBorrowNavi: FlexiBorrowNaviProcol {
   
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toFlexiGXSHome(flexiObj: FlexiLoanModel) {
        let text = "\(flexiObj.availableLOC?.val ?? 0.0)"
        guard let vc = self.navigationController.viewControllers.first as? FlexiLoanHomeVC  else {return}
        vc.viewModel.sub.onNext(text)
        self.navigationController.popToViewController(vc, animated: true)
    }
}
