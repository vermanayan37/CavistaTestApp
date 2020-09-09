//
//  DetailVC.swift
//  CavistaApp
//
//  Created by Apple on 07/09/20.
//  Copyright © 2020 NayanV. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    var item:Items?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    func setupView() {
        self.title = "Item Details"
        edgesForExtendedLayout = []
        self.view.backgroundColor = .white
        if let item = self.item {
            let lblDate = UILabel()
            self.view.addSubview(lblDate)
            lblDate.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-15)
                make.top.equalToSuperview().offset(20)
                make.height.equalTo(30)
            }
            lblDate.text = item.date ?? "\(Date())"
            if item.type == .text {
                let txtData = UITextView()
                txtData.isEditable = false
                txtData.isSelectable = false
                txtData.font = .systemFont(ofSize: 17, weight: .regular)
                self.view.addSubview(txtData)
                txtData.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(20)
                    make.top.equalTo(lblDate.snp.bottom).offset(5)
                    make.right.equalToSuperview().offset(-10)
                    make.bottom.equalToSuperview().offset(10)
                }
                txtData.text = item.data ?? "-"
            } else if item.type == .image {
                let imgView = UIImageView()
                self.view.addSubview(imgView)
                imgView.layer.cornerRadius = 5
                imgView.clipsToBounds = true
                imgView.snp.makeConstraints { (make) in
                    make.width.equalTo(120)
                    make.height.equalTo(120)
                    make.left.equalToSuperview().offset(20)
                    make.top.equalTo(lblDate.snp.bottom).offset(10)
                }
                imgView.sd_setImage(with:  URL(string: item.data ?? ""), placeholderImage: UIImage(named: "brokenLink"))
            }
            
        }
    }
}
