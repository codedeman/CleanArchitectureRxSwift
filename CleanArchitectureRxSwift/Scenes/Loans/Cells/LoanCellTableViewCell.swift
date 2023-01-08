//
//  LoanCellTableViewCell.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/30/22.
//  Copyright © 2022 sergdort. All rights reserved.
//

import UIKit
import SnapKit

class VInfor: UIView {

     var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sing"
        lbl.textColor = .white
        return lbl
    }()

    var lblSubtile: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .white
        lbl.textAlignment = .right
        return lbl
    }()

    private let hStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .red
        self.addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        hStack.addElement(arrageView: [lblTitle, lblSubtile])
    }

    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
class LoanCellTableViewCell: UITableViewCell {
    
    static let identifier = "LoanCellTableViewCell"
    private let vMain: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#271F35")
        return view
    }()

    private let viewLineLeft: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#3D3552")
        return view
    }()

    private let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#272037")
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        return view
    }()

    private let vPrice: VInfor =  {
        let v = VInfor()
        v.lblTitle.text = "Europe Trip"
        v.lblTitle.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        v.lblSubtile.text = "$S 12233"
        v.lblSubtile.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return v
    }()

    private var vPrincipal: VInfor = {
        let v = VInfor()
        v.lblTitle.text = "Principal"
        v.lblTitle.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        v.lblTitle.textColor = UIColor.white.withAlphaComponent(0.8)
        v.lblSubtile.text = "$S 12233"
        v.lblSubtile.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        v.lblSubtile.textColor = UIColor.white.withAlphaComponent(0.8)
        return v
    }()

    private let vInterested: VInfor = {
        let v = VInfor(frame: .zero)
        v.lblTitle.text = "Interest"
        v.lblTitle.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        v.lblTitle.textColor = UIColor.white.withAlphaComponent(0.8)
        v.lblSubtile.text = "$S 12233"
        v.lblSubtile.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        v.lblSubtile.textColor = UIColor.white.withAlphaComponent(0.8)
        return v
    }()


    private let vStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        stack.alignment = .fill
        stack.axis = .vertical
        return stack
    }()

    private let hStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(vMain)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.vMain.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(0)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-67)
            make.bottom.equalToSuperview().offset(0)
        }
        self.vMain.addSubview(viewLineLeft)
        self.viewLineLeft.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.width.equalTo(2)
        }

        self.vMain.addSubview(vContent)
        self.vContent.snp.makeConstraints { make in
            make.leading.equalTo(self.viewLineLeft.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
            make.top.equalTo(self.vMain.snp.top).offset(0)
        }

        self.vContent.addSubview(vStack)
//        self.vContent.backgroundColor = .red
        vStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
//        vStack.backgroundColor = .blue
//        self.vPrincipal.backgroundColor = .red
        self.vStack.addArrangedSubview(vPrice)
        self.vStack.addArrangedSubview(vPrincipal)
        self.vStack.addArrangedSubview(vInterested)



    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vContent.layer.cornerRadius = 5
        self.vContent.clipsToBounds = true
    }
    
}
