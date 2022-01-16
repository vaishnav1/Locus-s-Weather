//
//  SearchCityVC.swift
//  Locus's Weather
//
//  Created by vaishnav.chidambar on 16/01/22.
//

import UIKit

class SearchCityVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var customSearchBar: UISearchBar!
    @IBOutlet weak var getWeatherButton: UIButton!
    
    var weatherResponse: WeatherResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions & Functions
    @IBAction private func getWeatherButtonClicked(_ sender: Any) {
        let cityName = customSearchBar.text ?? ""
        NetworkService.shared.getWeatherForecast(cityName: cityName, onSuccess: { (response) in
            self.weatherResponse = response
            self.pushToListingScreen()
        }, onError: { (Error) in
            self.presentMessageAlert(Error)
        })
    }
    
    private func pushToListingScreen() {
        let stbd = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let weatherUpdatesScreen: WeatherUpdatesVC = stbd.instantiateViewController(withIdentifier: "WeatherUpdatesVC") as? WeatherUpdatesVC {
            weatherUpdatesScreen.weatherData = weatherResponse
            self.navigationController?.pushViewController(weatherUpdatesScreen, animated: true)
        }
    }
    
    private func presentMessageAlert(_ message: String = "") {
        let alert = UIAlertController(title: "Error Update!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { _ -> Void in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
