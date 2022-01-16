//
//  WeatherUpdatesVC.swift
//  Locus's Weather
//
//  Created by vaishnav.chidambar on 16/01/22.
//

import UIKit

private typealias TableViewDelegates = WeatherUpdatesVC
private typealias TableViewDatasource = WeatherUpdatesVC

class WeatherUpdatesVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var customTableView: UITableView!
    
    var weatherData: WeatherResponseModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        customTableView.alwaysBounceVertical = false
    }
    
    //MARK: - Actions
    private func pushToDetailsScreen() {
        let stbd = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let weatherDetailsScreen: WeatherDetailsVC = stbd.instantiateViewController(withIdentifier: "WeatherDetailsVC") as? WeatherDetailsVC {
            weatherDetailsScreen.detailedData = weatherData
            self.navigationController?.pushViewController(weatherDetailsScreen, animated: true)
        }
    }
}


extension TableViewDelegates: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToDetailsScreen()
    }
}

extension TableViewDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Since I want to use only 1 nodes in the response.
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let temp: String = String(weatherData?.main.temp ?? 0.0)
        cell?.textLabel?.text = "Temperature: \(temp)"
        cell?.detailTextLabel?.text = "Click here for the detailed report."
        cell?.selectionStyle = .none
        cell?.backgroundColor = .lightGray
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
