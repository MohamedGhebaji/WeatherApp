//
//  WindSpec.swift
//  WeatherApp
//
//  Created by Mohamed on 06/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import Quick
import Nimble
@testable import WeatherApp

class WindSpec: QuickSpec {
    override func spec() {
        describe("Init") {
            it("should be nil when json is nil", closure: { 
                do {
                    let wind = try Wind(json: nil)
                    expect(wind).to(beNil())
                } catch {
                }
            })
            it("should be nil when core data is nil", closure: {
                do {
                    let wind = try Wind(cdWind: nil)
                    expect(wind).to(beNil())
                } catch {
                }
            })
            it("Should params be equal values in json", closure: {
                do {
                    let wind = try Wind(json: ["speed": 2.98,"deg":295.505])
                    expect(wind.speed).to(equal(2.98))
                    expect(wind.deg).to(equal(295.505))
                } catch {
                }
            })
        }
    }
}