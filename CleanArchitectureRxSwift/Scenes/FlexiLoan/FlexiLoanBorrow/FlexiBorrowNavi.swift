//
//  FlexiBorrowNavi.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/21/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
import UIKit

protocol FlexiBorrowNaviProcol: AnyObject {
    func toFlexiGXSHome()
}

class FlexiBorrowNavi: FlexiBorrowNaviProcol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toFlexiGXSHome() {
        self.navigationController.popViewController(animated: true)
    }
}
