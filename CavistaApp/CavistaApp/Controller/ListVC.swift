//
//  ListVC.swift
//  CavistaApp
//
//  Created by Apple on 07/09/20.
//  Copyright © 2020 NayanV. All rights reserved.
//

import UIKit
import SnapKit
class ListVC: UIViewController {
    //MARK: Variables
    var arrItems:[Items] = []
    //MARK: UI Variables
    lazy var btnImage: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 0
        btn.setTitle("Image", for: .normal)
        btn.backgroundColor = .lightGray
        btn.setTitleColor(.black, for: .normal)
        btn.showsTouchWhenHighlighted = true
        btn.addTarget(self, action: #selector(actionSortBy(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnText: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.backgroundColor = .lightGray
        btn.setTitle("Text", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.showsTouchWhenHighlighted = true
        btn.addTarget(self, action: #selector(actionSortBy(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var svButtons: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [btnImage, btnText])
        stackView.alignment = .fill
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .lightGray
        view.addSubview(stackView)
        return stackView
    }()
    var btnSort:UIButton {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "sort"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top:0, left:0, bottom:0, right:40)
        btn.setTitle("Sort By", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top:0, left:-45, bottom:0, right:0)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(actionSort(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
        return btn
    }
    var tableView:UITableView = UITableView()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    //MARK: View Setup
    func setupViews(){
        self.title = "Item List"
        self.view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.svButtons.isHidden = true
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        self.setupConstraints()
        self.getData()
        
    }
    func setupConstraints() {
        edgesForExtendedLayout = []
        self.btnSort.snp.makeConstraints { (make) in
            make.width.equalTo(130)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        self.tableView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(0)
        }
        svButtons.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(70)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(80)
        }
    }
    
    //MARK: Api Call
    func getData() {
        UserListViewModel().getList(completion: {res in
            if let arr = res {
                self.arrItems = arr
                self.tableView.reloadData()
            }
        })
    }
    //MARK: Button Action
    @objc func actionSort(_ sender: UIButton) {
        self.svButtons.isHidden = false
    }
    @objc func actionSortBy(_ sender: UIButton) {
        if sender.tag == 0 {
            self.arrItems = self.arrItems.sorted{$0.sortByOption < $1.sortByOption}
            self.tableView.reloadData()
        } else if sender.tag == 1 {
            self.arrItems = self.arrItems.sorted{$0.sortByOption >
            $1.sortByOption}
            self.tableView.reloadData()
        }
        self.svButtons.isHidden = true
        
    }
    
}
//MARK: TableView Datasource and Delegates
extension ListVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.loadCell(item: arrItems[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = DetailVC()
        detailVc.item = self.arrItems[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
}
