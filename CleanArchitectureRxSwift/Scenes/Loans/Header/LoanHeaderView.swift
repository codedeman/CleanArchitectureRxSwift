//
//  LoanHeaderView.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/30/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import SnapKit
import UIKit
import RxSwift
import RxCocoa

final class LoanHeaderView: UIView {

    private let vMain: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#272037")
        return view
    }()

    private let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#272037")
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()

    private let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white.withAlphaComponent(0.8)
        lbl.text = "Due on 15"
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()

    private let lblSubTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "$3000"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return lbl
    }()

    private let ivLeft: UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    private let ivRight: UIImageView = {
        let iv = UIImageView()
        return iv
    }()


    private let viewLineLeft: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#3D3552")
        return view
    }()

    let btnClick: UIButton = {
        let btn = UIButton()
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(vMain)

        self.vMain.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(40)
            make.trailing.equalTo(self).offset(-67)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }

        self.vMain.addSubview(ivLeft)
        self.ivLeft.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(3)
            make.top.equalTo(self.vMain.snp.top).offset(15)
            make.width.equalTo(self.ivLeft.snp.height)
        }
        ivLeft.image = UIImage(named: "warning")

        self.vMain.addSubview(viewLineLeft)
        self.viewLineLeft.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(self.ivLeft.snp_bottomMargin)
            make.bottom.equalToSuperview().offset(0)
            make.width.equalTo(2)
        }

        
        self.vMain.addSubview(vContent)
        self.vMain.addSubview(lblTitle)
        self.vMain.addSubview(lblSubTitle)

        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.leading.equalTo(self.viewLineLeft.snp.trailing).offset(15)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
        }

        lblSubTitle.snp.makeConstraints { make in
            make.top.equalTo(self.lblTitle.snp.bottom).offset(0)
            make.leading.equalTo(self.viewLineLeft.snp.trailing).offset(15)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.bottom.greaterThanOrEqualTo(self.snp.bottom).offset(-15)
        }

        self.vMain.addSubview(ivRight)
        self.ivRight.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(self.vMain.snp.top).offset(20)
            make.width.equalTo(self.ivLeft.snp.height)
        }
        self.ivRight.image = UIImage(named: "drop")
        self.vMain.addSubview(btnClick)
        self.btnClick.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        btnClick.addTarget(self, action:#selector(dropDownBtnWasTapped) , for: .touchUpInside)

    }

    @objc func dropDownBtnWasTapped() {
        
    }
    func binding(data: LoanSectionModel) {
        self.lblTitle.text = data.dateStr
        self.lblSubTitle.text = data.price
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: LoanHeaderView {
    var expandTap: ControlEvent<Void> {base.btnClick.rx.tap}
}
