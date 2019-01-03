//
//  UINavigationController+Extensions.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 16/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    override open func viewDidLoad() {
         super.viewDidLoad()
        setupRainbowBorderImage()
    }
        
    private func setupRainbowBorderImage() {
        let shadow = UIImage(named: "RainbowLine")?.scaleImage(toWidth: UIScreen.main.bounds.width)
        navigationBar.shadowImage = shadow
    }
}
