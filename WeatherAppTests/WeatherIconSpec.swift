//
//  WeatherIconSpec.swift
//  WeatherApp
//
//  Created by Mohamed on 06/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Quick
import Nimble
@testable import WeatherApp

class WeatherIconSpec: QuickSpec {
    override func spec() {
        describe("init") { 
            it("Should instantiate weather icon class with dict", closure: {
                do {
                    let weatherIcon = try WeatherIcon(json: ["id":500,"main":"Rain","description":"light rain","icon":"10n"])
                    expect(weatherIcon.icon).to(equal("10n"))
                    expect(weatherIcon.iconDescription).to(equal("light rain"))
                } catch {
                    
                }
            })
            
            it("Should be nil", closure: { 
                do {
                    let weatherIcon = try WeatherIcon(json: nil)
                    expect(weatherIcon).to(beNil())
                } catch {
                    
                }
            })
            
            it("should instance of WeatherIcon by core data to be nil", closure: {
                let weatherIcon = WeatherIcon(cdWeatherIcon: nil)
                expect(weatherIcon).to(beNil())
            })
        }
    }
}