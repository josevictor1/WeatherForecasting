//
//  UIViewController+Extensions.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 16/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupTabBar(with title: String) {
        self.tabBarController?.title = title
    }
    
    func showAlert(withTitle title: String, andText text: String) -> Void {
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
