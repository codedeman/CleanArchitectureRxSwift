//
//  HomeModel.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/29/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import Foundation
import RxFlow
import RxDataSources

struct SubItems {
    var title: String
    var subTitle: String
}
struct Animal {
    var name: String
    var list: [SubItems]?
    var subItem: SubItems
}

struct HomeSectionModel {
    var header: String
    var items: [Item]
}

extension HomeSectionModel: SectionModelType {
    typealias Item = Animal

    init(original: HomeSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

public struct FilmModel: Decodable {
    public var listFilms: [FilmData]
}
public struct FilmData: Decodable {
    public var id: String
    public var filmUrl: String
    public  var name: String
}




struct HomeTopBannerModel {
    let image : String
}

let foodTopBannerMockData = [
    HomeTopBannerModel(image: "ic_food_banner4"),
    HomeTopBannerModel(image: "ic_food_banner1"),
    HomeTopBannerModel(image: "ic_food_banner2"),
    HomeTopBannerModel(image: "ic_food_banner3")
]

struct FoodCategoryModel {
    let categoryName: String
    let categoryImage: String
}

let foodCategoryMockData = [
    FoodCategoryModel(categoryName: "offers near you", categoryImage: "ic_offer"),
    FoodCategoryModel(categoryName: "veg only", categoryImage: "ic_vegonly"),
    FoodCategoryModel(categoryName: "premium", categoryImage: "ic_premium"),
    FoodCategoryModel(categoryName: "top rated", categoryImage: "ic_toprated"),
    FoodCategoryModel(categoryName: "express delivery", categoryImage: "ic_express"),
    FoodCategoryModel(categoryName: "pocket friendly", categoryImage: "ic_pocket"),
    FoodCategoryModel(categoryName: "best sellers", categoryImage: "ic_bestseller"),
    FoodCategoryModel(categoryName: "newly launched", categoryImage: "ic_newlaunch"),
]
