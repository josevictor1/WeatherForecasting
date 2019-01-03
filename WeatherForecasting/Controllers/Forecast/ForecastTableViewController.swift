//
//  ForecastTableViewController.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 16/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NVActivityIndicatorView

class ForecastTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    let forecastNetwork = ForecastNetworkDataSource()
    var forecastList: [SectionOfCustomData] = [] {
        didSet {
            if forecastList.count > 0 {
                showData()
            }
        }
    }

    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(
        configureCell: { (_, tableView, indexPath, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as? WeatherTableViewCell else {
                return UITableViewCell()
            }
            cell.fill(with: element)
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].headerTitle
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastNetwork.outputForecastNetwork = self
        requestForecast()
        configureTableViewDataSource()
        showData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar(with: "Forecast")
    }
    
    private func configureTableViewDataSource() {
        setDataSourceAndDelegate()
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func requestForecast() {
        startAnimating(type: .circleStrokeSpin)
        forecastNetwork.requestForecastWeather()
    }
    
    private func showData() {
        setDataSourceAndDelegate()
        let item = Observable.just(forecastList)
        item
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    private func setDataSourceAndDelegate() {
        tableView.dataSource = nil
        tableView.delegate = nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DayHeaderSectionView().loadNib() as! DayHeaderSectionView
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 46)
        headerView.titleDay.text = forecastList[section].headerTitle
        headerView.backgroundColor = .white
        return headerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
}

// MARK: - ForecastNetworkDelegate
extension ForecastTableViewController: ForecastNetworkDelegate {
    func forecastRequest(with result: [SectionOfCustomData]) {
        stopAnimating()
        forecastList = result
    }
    
    func forecastRequest(with error: ErrorType) {
        stopAnimating()
        showAlert(withTitle: "Error", andText: error.rawValue)
    }
}

// MARK: - NVActivityIndicatorViewable
extension ForecastTableViewController: NVActivityIndicatorViewable {}
