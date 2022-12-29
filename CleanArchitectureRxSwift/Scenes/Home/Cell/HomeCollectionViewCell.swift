//
//  HomeCollectionViewCell.swift
//  covid19
//
//  Created by Kevin on 12/27/22.
//  Copyright © 2022 dk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeCollectionViewCell: UICollectionViewCell {

    static let identifier = "HomeCollectionViewCell"
    private  let vMain: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hexString: "#272037")
        return v
    }()

    private let mainStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    private let ivIconLeft: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "warning")
        return iv
    }()

    private let viewIcLeft: UIView = {
        let v = UIView()
        return v
    }()

    private let vMidTitle: UIView = {
        let v = UIView()
        return v
    }()

    private let btnPay: UIButton = {
        let btn = UIButton()
        btn.setTitle("Pay Due", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()

    private let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "GXS repay your rxs repay"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()

    private let lblSubTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "Banking is just banking, right? Well, we ,Banking is just banking, right? Well, we ,Banking is just banking, right? Well, we  "
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return lbl
    }()

    private let viewRight: UIView = {
        let v = UIView()
        return v
    }()

    private let ivIconRight: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "close_red_ic")
        return iv
    }()

    private let vStackRight: UIStackView = {
        var stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.axis = .horizontal
        return stack
    }()

    private var list = PublishSubject<[SubItems]> ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setUpLayout()
    }


    func binding(data: SubItems) {
        self.lblTitle.text = data.title
        self.lblSubTitle.text = data.subTitle
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vMain.layer.cornerRadius = 10
        self.vMain.clipsToBounds = true
        self.btnPay.layer.cornerRadius = self.btnPay.frame.height/2
        self.btnPay.clipsToBounds = true
    }

    private func setUpLayout() {
        self.addSubview(vMain)
        vMain.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
        
        self.viewIcLeft.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(30)
        }
        self.viewIcLeft.addSubview(ivIconLeft)
        ivIconLeft.snp.makeConstraints { make in
            make.leading.equalTo(self.viewIcLeft.snp.leading).offset(5)
            make.top.equalTo(self.viewIcLeft.snp.top).offset(15)
            make.trailing.equalTo(self.viewIcLeft.snp.trailing).offset(0)
            make.width.equalTo(ivIconLeft.snp.height).multipliedBy(1 / 1)

        }

        self.vMain.addSubview(self.mainStack)
        self.mainStack.snp.makeConstraints { make in
            make.top.equalTo(self.vMain.snp_topMargin)
            make.bottom.equalTo(self.vMain.snp_bottomMargin)
            make.leading.equalTo(self.vMain.snp_leadingMargin)
            make.trailing.equalTo(self.vMain.snp_trailingMargin)
        }
//        vMain.backgroundColor = .blue
        self.vMidTitle.addSubview(btnPay)
        self.vMidTitle.addSubview(lblTitle)
        self.vMidTitle.addSubview(lblSubTitle)

        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(self.vMidTitle.snp.top).offset(0)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }

        lblSubTitle.snp.makeConstraints { make in
            make.top.equalTo(self.lblTitle.snp_bottomMargin).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        self.btnPay.snp.makeConstraints { make in
            make.top.equalTo(self.lblSubTitle.snp.bottom).offset(10)
            make.leading.equalTo(self.vMidTitle.snp.leading).offset(15)
            make.width.equalTo(100)
            make.bottom.lessThanOrEqualTo(10)
        }

        let vWrap = UIView()
        vWrap.addSubview(ivIconRight)
        ivIconRight.snp.makeConstraints { make in
            make.top.equalTo(vWrap.snp.top)
            make.trailing.equalTo(vWrap.snp.trailing)
            make.leading.equalTo(vWrap.snp.leading)
            make.width.equalTo(ivIconRight.snp.height).multipliedBy(1 / 1)

        }

        mainStack.alignment = .fill
        mainStack.axis = .horizontal
        mainStack.distribution = .fill

        self.viewRight.addSubview(vStackRight)
        vStackRight.snp.makeConstraints { make in
            make.top.equalTo(viewRight.snp.top).inset(0)
            make.trailing.equalTo(viewRight.snp.trailing).inset(0)
            make.leading.equalTo(viewRight.snp.leading).offset(0)
            make.bottom.equalTo(viewRight.snp.bottom).offset(0)
        }
        vStackRight.addElement(arrageView: [vWrap])

        self.mainStack.addElement(arrageView: [viewIcLeft, vMidTitle, viewRight] )

    }


    func bindingData(data: [SubItems]) {
        list.onNext(data)
    }

   

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override var safeAreaLayoutGuide: UILayoutGuide {
//        return UILayoutGuide()
//    }

}
