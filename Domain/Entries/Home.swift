//
//  Home.swift
//  Domain
//
//  Created by Kevin on 5/27/23.
//  Copyright © 2023 sergdort. All rights reserved.
//

import UIKit

public struct Home: Codable {
    public var listFilms: [HomeData]
}

public struct HomeData: Codable {
    public var id: String
    public var filmUrl: String
    public  var name: String
}
