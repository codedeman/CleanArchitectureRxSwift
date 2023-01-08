//
//  HomeUseCaseProvider.swift
//  Domain
//
//  Created by Kevin on 5/27/23.
//  Copyright © 2023 sergdort. All rights reserved.
//

import UIKit
import RxSwift

public protocol HomeUseCaseProvider {

    func makeUseCase() -> HomeUseCase
}

