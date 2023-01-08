//
//  HomeUseCase.swift
//  Domain
//
//  Created by Kevin on 5/27/23.
//  Copyright © 2023 sergdort. All rights reserved.
//

import UIKit
import RxSwift
import Foundation

public protocol HomeUseCase {
    func getFilm() -> Observable<Home?>
}
