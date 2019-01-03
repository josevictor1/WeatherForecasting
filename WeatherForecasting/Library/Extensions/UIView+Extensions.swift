//
//  UIView+Extensions.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 19/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
