//
//  HomNaviView.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/25/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import UIKit
import SnapKit

class HomNaviView: UIView {

    let lblTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return title
    }()

    let lblSubTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        return title
    }()

    let viewContent: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(viewContent)

        lblTitle.text = "GXS Bank"
        lblSubTitle.text = "Well come to Kevin"
//        lblSubTitle.t
        viewContent.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.trailing.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        self.viewContent.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.top.equalTo(15)
        }

        self.viewContent.addSubview(lblSubTitle)
        lblSubTitle.snp.makeConstraints { make in
            make.top.equalTo(self.lblTitle).offset(30)
            make.leading.equalTo(15)
            make.bottom.lessThanOrEqualTo(15)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}
