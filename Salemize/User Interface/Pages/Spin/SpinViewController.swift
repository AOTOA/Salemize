//
//  SpinViewController.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/16/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit

class SpinView: UIView {
    var item: SMCaseItem!
}

class SpinViewController: UIViewController {

    var model: SMCase!
    
    var titleLabel: UILabel!
    var titleImage: UIImageView!
    var titleImageInside: UIImageView!
    var scrollView: UIScrollView!
    var startButton: UIButton!
    var indicator: UIImageView!
    var topShadowView: UIView!
    var bottomShadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.model = SMCase(name: "جعبه اسنپ", logo: "box", boxInsideLogo: "snap", price: 300)
        self.model.items = [
            SMCaseItem(title: "۱۰٪", subtitle: "کد تخفیف", odds: 0.6),
            SMCaseItem(title: "۵,۰۰۰", subtitle: "اعتبار", odds: 0.2),
            SMCaseItem(title: "۳۰٪", subtitle: "کد تخفیف", odds: 0.15),
            SMCaseItem(title: "۷۰٪", subtitle: "کد تخفیف", odds: 0.045),
            SMCaseItem(title: "۱۰۰٪", subtitle: "کد تخفیف", odds: 0.005)
        ]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.init(hex: "263643")
        
        self.titleLabel = UILabel()
        self.titleLabel.text = self.model.name
        self.titleLabel.font = SMFont.bold(17)
        self.titleLabel.textColor = UIColor.init(hex: "f2f2f2")
        self.titleLabel.sizeToFit()
        
        self.titleImage = UIImageView()
        self.titleImage.image = UIImage(named: self.model.logo)
        self.titleImage.frame.size = CGSize(width: 65, height: 58)
        titleImage.contentMode = .scaleAspectFit
        
        self.titleImageInside = UIImageView()
        titleImageInside.contentMode = .scaleAspectFit
        titleImageInside.image = UIImage(named: self.model.boxInsideLogo)
        titleImageInside.frame.size = CGSize(width: 35, height: 35)
        
        self.scrollView = UIScrollView()
        self.scrollView.backgroundColor = UIColor.init(hex: "ECEDEE")
        
        self.startButton = UIButton()
        let ps = NSMutableParagraphStyle()
        ps.alignment = .center
        self.startButton.setAttributedTitle(NSAttributedString.init(string: "شروع", attributes: [
            NSAttributedStringKey.font: SMFont.medium(16)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.paragraphStyle: ps
            ]), for: .normal)
        self.startButton.layer.cornerRadius = 4
        self.startButton.backgroundColor = UIColor.clear
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.init(hex: "5E8130").cgColor, UIColor.init(hex: "466323").cgColor]
        gradient.locations = [0, 1]
        gradient.cornerRadius = 4
        self.startButton.frame.size = CGSize(width: 142, height: 44)
        gradient.frame = startButton.bounds
        self.startButton.layer.insertSublayer(gradient, at: 0)
        self.startButton.addTarget(self, action: #selector(startSpin(_:)), for: .touchUpInside)
        
        self.indicator = UIImageView(image: UIImage(named: "spin-indicator"))
        self.indicator.frame.size = indicator.image!.size
        self.indicator.alpha = 0
        
        self.topShadowView = UIView()
        self.bottomShadowView = UIView()
        self.topShadowView.setShadow(UIColor.black, offset: .init(width: 0, height: 2), radius: 15, opacity: 0.35)
        self.bottomShadowView.setShadow(UIColor.black, offset: .init(width: 0, height: -2), radius: 15, opacity: 0.35)
        
        self.topShadowView.clipsToBounds = false
        self.topShadowView.layer.masksToBounds = false
        self.bottomShadowView.clipsToBounds = false
        self.bottomShadowView.layer.masksToBounds = false
        
        self.topShadowView.backgroundColor = self.view.backgroundColor
        self.bottomShadowView.backgroundColor = self.view.backgroundColor
        
        self.view.addSubview(scrollView)
        self.view.addSubview(indicator)
        self.view.addSubview(topShadowView)
        self.view.addSubview(bottomShadowView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(titleImage)
        self.view.addSubview(titleImageInside)
        self.view.addSubview(startButton)
        
    }
    
    @objc func startSpin(_ sender: UIButton){
        UIView.animate(withDuration: 0.1, animations: {
            self.startButton.alpha = 0
            self.titleImageInside.alpha = 0
            self.titleImage.alpha = 0
            self.indicator.alpha = 1
        }) { (myBool) in
            self.scrollView.contentOffset = CGPoint(x: -self.view.frame.size.width / 2, y: 0)
            var all: Float = 0
            let x = Float(arc4random()) / Float(UINT32_MAX)
            var target: SMCaseItem!
            for item in self.model.items {
                all += item.odds
                if x <= all {
                    target = item
                    break
                }
            }
            
            for i in 0...150 {
                let spinView: SpinView = SpinView(frame: CGRect.init(x: i * 78, y: 0, width: 78, height: 91))
                var item: SMCaseItem!
                if i == 60 {
                    item = target
                } else {
                    item = self.model.items[Int(Float(arc4random()) / Float(UINT32_MAX) * 5)]
                }
                spinView.item = item
                let amount: UILabel = UILabel()
                let title: UILabel = UILabel()
                amount.text = item.title
                title.text = item.subtitle
                
                amount.font = SMFont.bold(25)
                title.font = SMFont.medium(10)
                
                let image = UIImageView(image: UIImage(named: "spin-seperator"))
                image.frame.size = image.image!.size
                image.frame.origin.x = 78 - 1
                image.center.y = 91 / 2
                
                if item.odds > 0.55 {
                    amount.textColor = UIColor.init(hex: "41B2BF")
                } else if item.odds > 0.3 {
                    amount.textColor = UIColor.init(hex: "CD1FA5")
                } else if item.odds > 0.1 {
                    amount.textColor = UIColor.init(hex: "4169BF")
                } else if item.odds > 0.03 {
                    amount.textColor = UIColor.init(hex: "D93434")
                } else {
                    amount.textColor = UIColor.init(hex: "FFC72C")
                }
                
                amount.sizeToFit()
                title.sizeToFit()
                spinView.addSubview(amount)
                spinView.addSubview(title)
                spinView.addSubview(image)
                amount.center.x = spinView.frame.size.width / 2
                amount.frame.origin.y = 19
                title.center.x = amount.center.x
                title.frame.origin.y = spinView.frame.size.height - title.frame.size.height - 16
                self.scrollView.addSubview(spinView)
                self.scrollView.isScrollEnabled = false
            }
            UIView.animate(withDuration: 3.5, delay: 0, options: .curveEaseOut, animations: {
                let random: Float = Float(arc4random()) / Float(UINT32_MAX)
                self.scrollView.contentOffset.x += CGFloat(60 * 78 + random * 60 + 10.0)
            }, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.frame.size = CGSize(width: self.view.frame.size.width, height: 91)
        self.scrollView.center = self.view.center
        
        self.titleImage.center = self.view.center
        self.titleImage.center.y += 7.5
        self.titleImageInside.center = self.view.center
        self.titleImageInside.center.y -= 19
        
        self.titleLabel.center.x = self.view.center.x
        self.titleLabel.frame.origin.y = self.scrollView.frame.origin.y - 55 - self.titleLabel.frame.size.height
        
        self.startButton.center.x = self.view.center.x
        self.startButton.frame.origin.y = self.scrollView.frame.size.height + self.scrollView.frame.origin.y + 30
        
        self.indicator.center = self.scrollView.center
        
        self.topShadowView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.origin.y)
        self.bottomShadowView.frame = CGRect(x: 0,
                                             y: self.scrollView.frame.origin.y + self.scrollView.frame.size.height,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height - (self.scrollView.frame.origin.y + self.scrollView.frame.size.height))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
