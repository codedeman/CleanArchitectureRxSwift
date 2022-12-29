//
//  HomeHeader.swift
//  covid19
//
//  Created by Kevin on 12/27/22.
//  Copyright © 2022 dk. All rights reserved.
//

import UIKit
import SnapKit

class HomeHeader: UIView {

    let viewContent: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#272037")
        return view
    }()

    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "GXS repay your rxs repay"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(viewContent)
//        self.backgroundColor = .red
        viewContent.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }

        viewContent.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { make in
            make.leading.equalTo(self.viewContent).offset(15)
            make.centerX.equalTo(self.viewContent)
        }

    }

    func binding(text: String) {
        self.lblTitle.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
