//
//  ViewController.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 15/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class TodayViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let forecastNetwork = ForecastNetworkDataSource()
    let locationService = LocationService.shared
    var weatherShare: String = ""
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    @IBOutlet weak var humidityImageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitationImageView: UIImageView!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var pressureImageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windImageView: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windDirectionImageView: UIImageView!
    @IBOutlet weak var windDirectionLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        forecastNetwork.outputTodayNetwork = self
        requestForecastWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar(with: "Today")
    }
    
    private func requestForecastWeather() {
        startAnimating(type: .circleStrokeSpin)
        forecastNetwork.requestTodayWeather()
    }
    
    fileprivate func fillScreen(with model: TodayViewModel) {
        locationLabel.text = model.location
        descriptionWeatherLabel.text = model.descriptionWeather
        humidityLabel.text = model.humidity
        precipitationLabel.text = model.precipitation
        pressureLabel.text = model.pressure
        windLabel.text = model.wind
        windDirectionLabel.text = model.windDirection
        weatherImageView.image = UIImage(named: model.icon)
        weatherShare = String(format: "WeatherForecast Location %@: %@", model.location, model.descriptionWeather )
    }

}

// MARK: - Actions
extension TodayViewController {
    @IBAction func buttonShareTapped(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [self.weatherShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - TodayNetworkDelegate
extension TodayViewController: TodayNetworkDelegate {
    func weatherRequest(with result: TodayViewModel) {
        stopAnimating()
        fillScreen(with: result)
    }
    
    func weatherRequest(with error: ErrorType) {
        stopAnimating()
        showAlert(withTitle: "Error", andText: error.rawValue)
    }
}

// MARK: - NVActivityIndicatorViewable
extension TodayViewController: NVActivityIndicatorViewable {}

