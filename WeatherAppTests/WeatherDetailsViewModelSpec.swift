//
//  WeatherDetailsSpec.swift
//  WeatherApp
//
//  Created by Mohamed on 06/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Quick
import Nimble
@testable import WeatherApp

class WeatherDetailsViewModelSpec: QuickSpec {
    override func spec() {
        describe("Init") {
            let weather = try! Weather(json: [
                "dt": 1478390400,
                "main": [
                    "temp": 279.61,
                    "temp_min": 277.903,
                    "temp_max": 279.61,
                    "pressure": 1007.69,
                    "sea_level": 1020.04,
                    "grnd_level": 1007.69,
                    "humidity": 96,
                    "temp_kf": 1.71
                ],
                "weather": [
                    [
                        "id": 500,
                        "main": "Rain",
                        "description": "light rain",
                        "icon": "10n"
                    ]
                ],
                "clouds": [
                    "all": 92
                ],
                "wind": [
                    "speed": 2.98,
                    "deg": 295.505
                ],
                "rain": [
                    "3h": 0.405
                ],
                "sys": [
                    "pod": "n"
                ],
                "dt_txt": "2016-11-06 00:00:00"
                ])
            it("view model attributes match json", closure: {
                let viewModel = WeatherDetailsViewModel(weather :weather)
                expect(viewModel.weatherDescription).to(equal("light rain"))
                expect(viewModel.pression).to(equal("1007.69"))
                expect(viewModel.seaLevel).to(equal("\(1020.04/1000)"))
                expect(viewModel.wind).to(equal("2.98km/h"))
            })
        }
    }
}
