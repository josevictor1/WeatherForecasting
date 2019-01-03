//
//  WeatherTableViewCell.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 16/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fill(with viewModel: ForecastViewModel) {
        timePeriodLabel.text = viewModel.timePeriod
        temperatureLabel.text = viewModel.temperature
        weatherDescriptionLabel.text = viewModel.weather
        weatherImageView.image = UIImage(named: viewModel.icon)
    }

}
