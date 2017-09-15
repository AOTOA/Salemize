//
//  MainViewController.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/14/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit
import GoogleMaps

class MainViewController: UIViewController {
    
//    var mapView: GMSMapView?
    var gradientLayer: CAGradientLayer!
    var shapesImage: UIImageView!
    var appLogo: UIImageView!
    var startButton: UIButton!
    var helpButton: UIButton!
    var storeButton: UIButton!
    var profileButton: UIButton!
    var buttonContainer: BottomSizerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView() {
        super.loadView()
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [SMColor(name: .mainPageGradientTop).cgColor, SMColor(name: .mainPageGradientBottom).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        shapesImage = UIImageView()
        shapesImage.image = UIImage(named: "bg-shapes")
        shapesImage.contentMode = .top
        self.view.addSubview(shapesImage)
        
        appLogo = UIImageView()
        appLogo.image = UIImage(named: "salemizeLogo")
        appLogo.contentMode = .scaleAspectFit
        self.view.addSubview(appLogo)
        
        startButton = UIButton()
        startButton.setImage(UIImage(named: "play-button"), for: .normal)
        startButton.sizeToFit()
        startButton.tag = 1
        startButton.addTarget(self, action: #selector(buttonActions(_:)), for: .touchUpInside)
        self.view.addSubview(startButton)
        
        let centerParagraph = NSMutableParagraphStyle()
        centerParagraph.alignment = .center
        
        helpButton = UIButton()
        helpButton.setBackgroundImage(UIImage(named: "diamond"), for: .normal)
        helpButton.setAttributedTitle(NSAttributedString.init(string: SMLocalized("SM.Main.Buttons.Help"), attributes: [
            NSAttributedStringKey.font: SMFont.medium(12)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.paragraphStyle: centerParagraph
            ]), for: .normal)
        helpButton.titleEdgeInsets.top = 3
        helpButton.sizeToFit()
        
        storeButton = UIButton()
        storeButton.setBackgroundImage(UIImage(named: "diamond"), for: .normal)
        storeButton.setAttributedTitle(NSAttributedString.init(string: SMLocalized("SM.Main.Buttons.Store"), attributes: [
            NSAttributedStringKey.font: SMFont.medium(12)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.paragraphStyle: centerParagraph
            ]), for: .normal)
        storeButton.titleEdgeInsets.top = 3
        storeButton.sizeToFit()
        
        profileButton = UIButton()
        profileButton.setBackgroundImage(UIImage(named: "diamond"), for: .normal)
        profileButton.setAttributedTitle(NSAttributedString.init(string: SMLocalized("SM.Main.Buttons.Profile"), attributes: [
            NSAttributedStringKey.font: SMFont.medium(12)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.paragraphStyle: centerParagraph
            ]), for: .normal)
        profileButton.titleEdgeInsets.top = 3
        profileButton.sizeToFit()
        
        buttonContainer = BottomSizerView()
        buttonContainer.setButtons([helpButton, storeButton, profileButton])
        
        self.view.addSubview(buttonContainer)
    }
    
    @objc func buttonActions(_ sender: UIButton) {
        switch sender.tag {
        case 1: // Start Button
            self.navigationController?.setViewControllers([MapViewController()], animated: true)
            break
        default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
        shapesImage.frame = self.view.bounds
        startButton.center = self.view.center
        let contWidth = 303.0 / 375 * self.view.frame.size.width
        buttonContainer.frame = CGRect(x: (self.view.frame.size.width - contWidth) / 2,
                                       y: self.view.frame.size.height - helpButton.frame.size.height - 23,
                                       width: contWidth,
                                       height: helpButton.frame.size.height)
        print(buttonContainer.frame)
        self.appLogo.frame = CGRect(x: 0,
                                    y: 95 / 667 * self.view.frame.size.height,
                                    width: self.view.frame.size.width,
                                    height: 41 / 667 * self.view.frame.size.height)
    }

}
