//
//  WeatherDetailsVC.swift
//  Locus's Weather
//
//  Created by vaishnav.chidambar on 16/01/22.
//

import UIKit

class WeatherDetailsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var cloudLable: UILabel!
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var feelsLikeLable: UILabel!
    @IBOutlet weak var humidityLable: UILabel!
    
    var detailedData: WeatherResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    private func setupData() {
        let temp: String = String(detailedData?.main.temp ?? 0.0)
        let feelsLike: String = String(detailedData?.main.feelsLike ?? 0.0)
        let humidity: String = String(detailedData?.main.humidity ?? 0)
        cloudLable.text = detailedData?.weather.first?.weatherDescription
        tempLable.text = temp
        feelsLikeLable.text = feelsLike
        humidityLable.text = humidity
    }
}
