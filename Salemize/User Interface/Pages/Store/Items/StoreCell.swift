//
//  storeCell.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {

    @IBOutlet weak var itemDescImage: UIImageView!
    @IBOutlet weak var boxImage: UIImageView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var buyLabel: UILabel!
    var action: ((SMCase) -> (Void))?
    
    var model: SMCase?
    
    var selectable: Bool = true {
        didSet {
            if model?.price != 0 {
                self.coinLabel.alpha = selectable ? 1 : 0.5
                self.coinImage.alpha = selectable ? 1 : 0.5
            } else {
                self.coinLabel.alpha = 0
                self.coinImage.alpha = 0
            }
        }
    }
    
    var isLastIndex = false {
        didSet {
            self.seperatorView.alpha = isLastIndex ? 0 : 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setModel(_ caseModel: SMCase) {
        
        self.model = caseModel
        
        itemDescImage.image = UIImage.init(named: caseModel.boxInsideLogo)
        boxImage.image = UIImage.init(named: caseModel.logo)
        boxImage.contentMode = .scaleAspectFit
        itemDescImage.contentMode = .center
        coinImage.image = UIImage.init(named: "coin")
        coinImage.contentMode = .scaleAspectFit
        nameLabel.text = caseModel.name
        nameLabel.font = SMFont.medium(11)
        nameLabel.textColor = UIColor.init(hex: "646464")
        coinLabel.text = SMPersian(caseModel.price)
        coinLabel.font = SMFont.medium(14)
        coinLabel.textColor = UIColor.init(hex: "5A5A5A")
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.init(hex: "FCFCFC").cgColor, UIColor.init(hex: "E2E2E2").cgColor]
        gradient.locations = [0, 1]
        gradient.frame = buyBtn.bounds
        gradient.cornerRadius = buyBtn.frame.size.height / 2
        buyBtn.layer.insertSublayer(gradient, at: 0)
        buyBtn.layer.cornerRadius = buyBtn.frame.size.height / 2
        buyBtn.layer.masksToBounds = true
        buyBtn.setTitle("", for: .normal)
        buyBtn.setBorder(UIColor(hex: "F0F0F0"), width: 1)
        buyBtn.setShadow(UIColor.black, offset: CGSize(width: 0, height: 2), radius: 5, opacity: 0.05)
        buyBtn.layer.masksToBounds = false
        buyBtn.clipsToBounds = false
        
        self.buyLabel.text = "خرید کلید"
        self.buyLabel.font = SMFont.bold(11)
        self.buyLabel.textColor = UIColor.init(hex: "5A5A5A")
        
        self.coinLabel.alpha = caseModel.price == 0 ? 0 : 1
        self.coinImage.alpha = caseModel.price == 0 ? 0 : 1
        self.buyLabel.alpha = caseModel.price == 0 ? 1 : 0
    }
    
}
