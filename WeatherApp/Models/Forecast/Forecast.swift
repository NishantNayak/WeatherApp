/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Forecast : Codable {
	let localObservationDateTime : String?
	let epochTime : Double?
	let weatherText : String?
	let weatherIcon : Int?
	let hasPrecipitation : Bool?
	let precipitationType : String?
	let isDayTime : Bool?
	let temperature : Temperature?
	let mobileLink : String?
	let link : String?

	enum CodingKeys: String, CodingKey {

		case localObservationDateTime = "LocalObservationDateTime"
		case epochTime = "EpochTime"
		case weatherText = "WeatherText"
		case weatherIcon = "WeatherIcon"
		case hasPrecipitation = "HasPrecipitation"
		case precipitationType = "PrecipitationType"
		case isDayTime = "IsDayTime"
		case temperature = "Temperature"
		case mobileLink = "MobileLink"
		case link = "Link"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		localObservationDateTime = try values.decodeIfPresent(String.self, forKey: .localObservationDateTime)
		epochTime = try values.decodeIfPresent(Double.self, forKey: .epochTime)
		weatherText = try values.decodeIfPresent(String.self, forKey: .weatherText)
		weatherIcon = try values.decodeIfPresent(Int.self, forKey: .weatherIcon)
		hasPrecipitation = try values.decodeIfPresent(Bool.self, forKey: .hasPrecipitation)
		precipitationType = try values.decodeIfPresent(String.self, forKey: .precipitationType)
		isDayTime = try values.decodeIfPresent(Bool.self, forKey: .isDayTime)
		temperature = try values.decodeIfPresent(Temperature.self, forKey: .temperature)
		mobileLink = try values.decodeIfPresent(String.self, forKey: .mobileLink)
		link = try values.decodeIfPresent(String.self, forKey: .link)
	}

}
