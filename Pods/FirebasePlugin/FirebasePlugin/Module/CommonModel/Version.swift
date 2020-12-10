//	Version.swift


import Foundation

struct Version : Codable {

	let forceUpdate : Bool?
	let maintain : Bool?
	let message : String?
	let packageId : String?
	let version : String?


	enum CodingKeys: String, CodingKey {
		case forceUpdate = "forceUpdate"
		case maintain = "maintain"
		case message = "message"
		case packageId = "packageId"
		case version = "version"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		forceUpdate = try values.decodeIfPresent(Bool.self, forKey: .forceUpdate)
		maintain = try values.decodeIfPresent(Bool.self, forKey: .maintain)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		packageId = try values.decodeIfPresent(String.self, forKey: .packageId)
		version = try values.decodeIfPresent(String.self, forKey: .version)
	}


}
