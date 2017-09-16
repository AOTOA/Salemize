//
//  SMStoreViewController.swift
//  Salemize
//
//  Created by iBahram on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit

class SMStoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var backButton: UIButton!
    var storeTitle: UILabel!
    var userCoinsIcon: UIImageView!
    var userCoinsValue: UILabel!
    var userTreasureIcon: UIImageView!
    var userTreasureValue: UILabel!
    var separator: UIView!
    var storeTableView: UITableView!
    var itemsArray: [SMCase] = []
    
    var currentMoney: Int = 814
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTest(){
        itemsArray.append(SMCase.init(name: "جعبه تصادفی", logo: "box", boxInsideLogo: "question", price: 300))
        itemsArray.append(SMCase.init(name: "جعبه اسنپ", logo: "box", boxInsideLogo: "snap", price: 700))
        itemsArray.append(SMCase.init(name: "جعبه زودفود", logo: "box", boxInsideLogo: "snappFood", price: 1000))
        itemsArray.append(SMCase.init(name: "جعبه دیجیکالا", logo: "box", boxInsideLogo: "digikala", price: 1500))
        itemsArray.append(SMCase.init(name: "جعبه پوشاک", logo: "box", boxInsideLogo: "shoe", price: 3000))
        itemsArray.append(SMCase.init(name: "جعبه شگفت انگیز", logo: "treasure", boxInsideLogo: "", price: 0))
        itemsArray.append(SMCase.init(name: "جعبه شگفت انگیز", logo: "treasure", boxInsideLogo: "", price: 0))
        itemsArray.append(SMCase.init(name: "جعبه شگفت انگیز", logo: "treasure", boxInsideLogo: "", price: 0))
    }
    
    override func loadView() {
        super.loadView()
        
        loadTest()
        
        backButton = UIButton()
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.frame.size = CGSize(width: 16, height: 16)
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        
        storeTitle = UILabel()
        storeTitle.text = SMLocalized("SM.Store.Titles.Shop")
        storeTitle.font = SMFont.medium(15)
        storeTitle.textColor = SMColor(name: .black)
        storeTitle.sizeToFit()
        
        userCoinsIcon = UIImageView()
        userCoinsIcon.image = UIImage(named: "coins")
        userCoinsIcon.frame.size = CGSize(width: 34, height: 30)
        userCoinsIcon.contentMode = .scaleAspectFit
        
        userCoinsValue = UILabel()
        userCoinsValue.text = SMPersian(self.currentMoney)
        userCoinsValue.textColor = SMColor(name: .black)
        userCoinsValue.font = SMFont.medium(17)
        userCoinsValue.sizeToFit()
        userCoinsValue.sizeToFit()
        
        userTreasureIcon = UIImageView()
        userTreasureIcon.image = UIImage(named: "treasure")
        userTreasureIcon.frame.size = CGSize(width: 36, height: 38)
        userTreasureIcon.contentMode = .scaleAspectFit
        
        userTreasureValue = UILabel()
        userTreasureValue.text = "۳"
        userTreasureValue.textColor = SMColor(name: .black)
        userTreasureValue.font = SMFont.medium(17)
        userTreasureValue.sizeToFit()
        
        separator = UIView()
        separator.frame.size = CGSize(width: self.view.frame.size.width, height: 2)
        separator.backgroundColor = SMColor(name: .storeSeparator)
        
        storeTableView = UITableView()
        storeTableView.dataSource = self
        storeTableView.delegate = self
        storeTableView.register(UINib.init(nibName: "StoreCell", bundle: nil), forCellReuseIdentifier: "StoreCellIdent")
        
        
        self.view.addSubview(backButton)
        self.view.addSubview(storeTitle)
        self.view.addSubview(userCoinsIcon)
        self.view.addSubview(userCoinsValue)
        self.view.addSubview(userTreasureIcon)
        self.view.addSubview(userTreasureValue)
        self.view.addSubview(separator)
        self.view.addSubview(storeTableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backButton.frame.origin = .init(x: 20, y: 20)
        storeTitle.frame.origin = .init(x: self.view.frame.size.width - 20 - storeTitle.frame.size.width, y: 20)
        userCoinsIcon.frame.origin = .init(x: self.view.frame.size.width - 22 - userCoinsIcon.frame.size.width, y: 65)
        userCoinsValue.frame.origin = .init(x: self.view.frame.size.width - 71 - userCoinsValue.frame.size.width, y: 70)
        userTreasureIcon.frame.origin = .init(x: self.view.frame.size.width - 133 - userTreasureIcon.frame.size.width, y: 62)
        userTreasureValue.frame.origin = .init(x: self.view.frame.size.width - 183 - userTreasureValue.frame.size.width, y: 70)
        separator.frame.origin = .init(x: 0, y: 112)
        
        storeTableView.frame.size = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - (separator.frame.origin.y + separator.frame.size.height))
        storeTableView.frame.origin = .init(x: 0, y: self.view.frame.size.height - storeTableView.frame.size.height)
        storeTableView.contentInset.top = 10
        storeTableView.separatorStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.goForCase(itemsArray[indexPath.row])
    }
    
    @objc func backPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if itemsArray[indexPath.row].price == 0 || itemsArray[indexPath.row].price <= currentMoney {
            return indexPath
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return itemsArray[indexPath.row].price == 0 || itemsArray[indexPath.row].price <= currentMoney
    }
    
    func goForCase(_ model: SMCase) {
        let vc: SpinViewController = SpinViewController()
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCellIdent", for: indexPath) as! StoreCell
        let caseModel = itemsArray[indexPath.row]
        cell.setModel(caseModel)
        cell.isLastIndex = indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1
        cell.selectable = caseModel.price == 0 || caseModel.price <= currentMoney
        cell.action = { model in
            self.goForCase(model)
        }
        return cell
    }

}
