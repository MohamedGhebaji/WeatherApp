//
//  WeatherSpec.swift
//  WeatherApp
//
//  Created by Mohamed on 06/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Quick
import Nimble
@testable import WeatherApp

class WeatherSpec: QuickSpec {
    override func spec() {
        describe("Init") { 
            it("Should be nil when json not contains wind", closure: {
                do {
                    let weather = try Weather(json: [:])
                    expect(weather).to(beNil())
                } catch {
                }
            })
            it("Should be nil when json not contains weather icon", closure: {
                do {
                    let weather = try Weather(json: [:])
                    expect(weather).to(beNil())
                } catch {
                }
            })
            
            it("Should be nil when json not contains weather icon", closure: {
                do {
                    let weather = try Weather(json: [
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
                    expect(weather.dateTimeStamp).to(equal(1478390400))
                    expect(weather.temp).to(equal(279.61))
                    expect(weather.tempMin).to(equal(277.903))
                    expect(weather.wind?.speed).to(equal(2.98))
                    expect(weather.weatherIcon?.icon).to(equal("10n"))
                    expect(weather.weatherIcon?.iconDescription).to(equal("light rain"))
                } catch {
                }
            })
        }
    }
}
