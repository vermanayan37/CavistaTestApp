//
//  ItemCell.swift
//  CavistaApp
//
//  Created by Apple on 09/09/20.
//  Copyright © 2020 NayanV. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
class ItemCell: UITableViewCell {
    var imgView: UIImageView?
    var lblData : UILabel?
    var lblDate: UILabel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.lblData  = UILabel()
        self.addSubview(lblData!)
        self.lblData?.numberOfLines = 0
        self.lblDate = UILabel()
        self.addSubview(lblDate!)
        self.imgView = UIImageView()
        self.addSubview(imgView!)
        self.setupConstraint()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: Render View
    func loadCell(item:Items) {
        self.lblDate?.text = item.date ?? "\(Date())"
        if item.type == .text {
            self.lblData?.text = item.data ?? "-"
            self.imgView?.isHidden = true
            self.lblData?.isHidden = false
            self.imgView?.snp.removeConstraints()
            self.setLblDataConstraint()
        } else if item.type == .image {
            self.imgView?.isHidden = false
            self.lblData?.isHidden = true
            self.imgView?.layer.cornerRadius = 5
            self.imgView?.clipsToBounds = true
            self.imgView?.sd_setImage(with:  URL(string: item.data ?? ""), placeholderImage: UIImage(named: "brokenLink"))
            self.lblData?.snp.removeConstraints()
            self.setImageViewConstraint()
        }
    }
    //MARK: Constraint Setup
    func setupConstraint() {
        self.lblDate?.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }
    }
    func setImageViewConstraint() {
        self.imgView?.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(lblDate!.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    func setLblDataConstraint() {
        self.lblData?.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(lblDate!.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
