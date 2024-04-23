//
//  CardServiceProtocol.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import Combine

protocol CardServiceProtocol {
	
	func fetchCreditCards(on page: Int) -> AnyPublisher<[CreditCard], Error>
	
}
