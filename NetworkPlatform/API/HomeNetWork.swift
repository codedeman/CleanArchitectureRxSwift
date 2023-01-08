//
//  HomeNetWork.swift
//  NetworkPlatform
//
//  Created by Kevin on 5/27/23.
//  Copyright © 2023 sergdort. All rights reserved.
//

import UIKit
import Domain
import RxSwift
public final class HomeNetWork {
    
    private var network: Network<Home>

    init(network: Network<Home>) {
        self.network = network
    }

    func getFilm() -> Observable<Home?> {
        guard let request = try? URLRequest(url: URL(string: "https://codedeman.github.io/ssd_api/fakeCinema.json")!, method: .get) else { return .just(nil) }
       return network.send(urlRequest: request)
    }

}
