//
//  HomeBannerCell.swift
//  CleanArchitectureRxSwift
//
//  Created by Kevin on 12/29/22.
//  Copyright © 2022 sergdort. All rights reserved.
//


import UIKit
import SnapKit
import RxSwift

class HomeBannerCell: UITableViewCell {

    static let identifier = "HomeBannerCell"

    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width-15/2, height: 200)
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: viewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private let viewIcLeft: UIView = {
        let v = UIView()
        return v
    }()

    private let ivIconLeft: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "1.jpg")
        return iv
    }()


    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.backgroundColor = .clear
        return page
    }()

    private let list = PublishSubject<[SubItems]> ()
    private let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.setUpLayout()
        self.setUpObser()
    }

    private func setUpLayout() {
        self.contentView.addSubview(collectionView)
        self.addSubview(pageControl)
        self.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.height.equalTo(200)
        }

        pageControl.snp.makeConstraints { make in
            make.bottom.greaterThanOrEqualTo(self.snp.bottom).offset(0)
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(self.collectionView.snp_bottomMargin).offset(0)
        }

    }

    private func setUpObser() {
        list.asObserver().bind(to:  collectionView.rx.items) {(collection,index, model) in
            let indexPath = IndexPath(item: index, section: 0)
             guard let cell = collection.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {return UICollectionViewCell()}
            cell.binding(data: model)
            return cell
        }.disposed(by: disposeBag)
    }

    func bindingData(data: [SubItems]) {
        list.onNext(data)
        self.pageControl.numberOfPages = data.count
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        collectionView.alwaysBounceHorizontal = true
//        collectionView.isScrollEnabled = true
//        collectionView.isUserInteractionEnabled = true
        collectionView.bounces = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension HomeBannerCell: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }

}
