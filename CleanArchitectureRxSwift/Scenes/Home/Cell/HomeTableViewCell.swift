//
//  HomeTableCells.swift
//  covid19
//
//  Created by Kevin on 12/26/22.
//  Copyright © 2022 dk. All rights reserved.
//

import UIKit
import SnapKit
class HomeTableViewCell: UITableViewCell {

    static let identifier = "HomeTableViewCell"
    private let viewContent: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#272037")
        return view
    }()

    let mainStack: UIStackView = {
        var stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()

    private let ivIconLeft: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "warning")
        return iv
    }()

    let ivIconRight: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "close_red_ic")
        return iv
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
        lbl.numberOfLines = 0
        return lbl
    }()

    private let lblSubTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "Banking is just banking, right? Well, we "
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return lbl
    }()

    private let viewIcLeft: UIView = {
        let v = UIView()
        return v
    }()

    private let viewRight: UIView = {
        let v = UIView()
        return v
    }()

    private let lblRight: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "$S11111111111"
        lbl.textAlignment = .right
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return lbl
    }()

    private let vStackRight: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.axis = .horizontal
        return stack
    }()

    private let vSubRight: UIView = {
        let view = UIView()
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.viewContent)
        self.selectionStyle = .none
        self.backgroundColor = .clear

        self.viewContent.snp.makeConstraints { make in
            make.top.equalTo(self).offset(0)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-0)
        }

        self.viewIcLeft.addSubview(ivIconLeft)
        ivIconLeft.snp.makeConstraints { make in
            make.leading.equalTo(self.viewIcLeft.snp.leading).offset(0)
            make.top.equalTo(self.viewIcLeft.snp.top).offset(15)
            make.trailing.equalTo(self.viewIcLeft.snp.trailing).offset(0)
            make.width.equalTo(ivIconLeft.snp.height).multipliedBy(1 / 1)
        }

        self.vMidTitle.addSubview(btnPay)
        self.vMidTitle.addSubview(lblTitle)
        self.vMidTitle.addSubview(lblSubTitle)
        lblTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }

        lblSubTitle.snp.makeConstraints { make in
            make.top.equalTo(self.lblTitle.snp_bottomMargin).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        self.btnPay.snp.makeConstraints { make in
            make.top.equalTo(self.lblSubTitle.snp.bottom).offset(15)
            make.leading.equalTo(self.vMidTitle.snp_leadingMargin)
            make.width.equalTo(100)
            make.bottom.equalTo(self.vMidTitle).offset(-15)
        }

        let vWrap = UIView()
        vWrap.addSubview(ivIconRight)
        ivIconRight.snp.makeConstraints { make in
            make.top.equalTo(vWrap.snp.top).offset(15)
            make.trailing.equalTo(vWrap.snp.trailing)
            make.leading.equalTo(vWrap.snp.leading)
        }
        vWrap.snp.makeConstraints { make in
            make.width.equalTo(30)
        }

        self.vSubRight.addSubview(lblRight)
        lblRight.snp.makeConstraints { make in
            make.leading.equalTo(vSubRight.snp.leadingMargin).offset(0)
            make.trailing.equalTo(vSubRight.snp.trailing).offset(0)
            make.top.equalTo(19)
        }
        vSubRight.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(lblRight.snp.width)
        }
        vStackRight.addElement(arrageView: [vSubRight, vWrap])

        self.viewRight.addSubview(vStackRight)
        vStackRight.snp.makeConstraints { make in
            make.top.equalTo(viewRight.snp.top).offset(0)
            make.trailing.equalTo(viewRight.snp.trailing).offset(0)
            make.leading.equalTo(viewRight.snp.leading).offset(0)
            make.bottom.equalTo(viewRight.snp.bottom).offset(0)
        }

        self.mainStack.addElement(arrageView: [viewIcLeft, vMidTitle, viewRight])
        self.viewContent.addSubview(self.mainStack)
        self.mainStack.snp.makeConstraints { make in
            make.top.equalTo(self.viewContent.snp_topMargin)
            make.bottom.equalTo(self.viewContent.snp_bottomMargin)
            make.leading.equalTo(self.viewContent.snp_leadingMargin)
            make.trailing.equalTo(self.viewContent.snp_trailingMargin)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        btnPay.layer.cornerRadius = self.btnPay.frame.height/2
        btnPay.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 10
        self.viewContent.clipsToBounds = true
    }

    func binding(items: SubItems) {
        self.lblTitle.text = items.title
        self.lblSubTitle.text = items.subTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView {
    func addElement(arrageView: [UIView]) {
        arrageView.forEach { v in
            self.addArrangedSubview(v)
        }
    }
}
