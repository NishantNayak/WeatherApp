/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct City : Codable {
	let version : Int?
	let key : String?
	let type : String?
	let rank : Int?
	let localizedName : String?
	let englishName : String?
	let primaryPostalCode : String?
	let region : Region?
	let country : Country?
	let administrativeArea : AdministrativeArea?
	let timeZone : TimeZone?
	let geoPosition : GeoPosition?
	let isAlias : Bool?
	let supplementalAdminAreas : [SupplementalAdminAreas]?
	let dataSets : [String]?

	enum CodingKeys: String, CodingKey {

		case version = "Version"
		case key = "Key"
		case type = "Type"
		case rank = "Rank"
		case localizedName = "LocalizedName"
		case englishName = "EnglishName"
		case primaryPostalCode = "PrimaryPostalCode"
		case region = "Region"
		case country = "Country"
		case administrativeArea = "AdministrativeArea"
		case timeZone = "TimeZone"
		case geoPosition = "GeoPosition"
		case isAlias = "IsAlias"
		case supplementalAdminAreas = "SupplementalAdminAreas"
		case dataSets = "DataSets"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		version = try values.decodeIfPresent(Int.self, forKey: .version)
        key = try values.decodeIfPresent(String.self, forKey: .key)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		rank = try values.decodeIfPresent(Int.self, forKey: .rank)
		localizedName = try values.decodeIfPresent(String.self, forKey: .localizedName)
		englishName = try values.decodeIfPresent(String.self, forKey: .englishName)
		primaryPostalCode = try values.decodeIfPresent(String.self, forKey: .primaryPostalCode)
		region = try values.decodeIfPresent(Region.self, forKey: .region)
		country = try values.decodeIfPresent(Country.self, forKey: .country)
		administrativeArea = try values.decodeIfPresent(AdministrativeArea.self, forKey: .administrativeArea)
		timeZone = try values.decodeIfPresent(TimeZone.self, forKey: .timeZone)
		geoPosition = try values.decodeIfPresent(GeoPosition.self, forKey: .geoPosition)
		isAlias = try values.decodeIfPresent(Bool.self, forKey: .isAlias)
		supplementalAdminAreas = try values.decodeIfPresent([SupplementalAdminAreas].self, forKey: .supplementalAdminAreas)
		dataSets = try values.decodeIfPresent([String].self, forKey: .dataSets)
	}

}
