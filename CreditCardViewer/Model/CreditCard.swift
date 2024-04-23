//
//  CreditCard.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import Foundation

struct CreditCard: Codable {
	
	let uid: String
	let creditCardType: String
	let creditCardNumber: String
	let creditCardExpiryDate: String
	
	var dateFormatter: ISO8601DateFormatter = {
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
		return dateFormatter
	}()
	
	var expiryDate: Date? {
		dateFormatter.date(from: creditCardExpiryDate)
	}
	
	var expiryDateString: String? {
		guard let expiryDate = expiryDate else { return nil }
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		return dateFormatter.string(from: expiryDate)
	}
	
	var type: String {
		creditCardType.components(separatedBy: "_")
			.map { $0.capitalized }
			.joined(separator: " ")
	}
	
	enum CodingKeys: String, CodingKey {
		case uid
		case creditCardType
		case creditCardNumber
		case creditCardExpiryDate
	}
	
}
