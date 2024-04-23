//
//  CardsViewModel.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import Foundation
import Combine

class CardService: CardServiceProtocol {
	
	private let repository: GenericRepositoryProtocol
	private let baseURL: URL = URL(string: "https://random-data-api.com")!
	
	init(repository: GenericRepositoryProtocol = GenericRepository()) {
		self.repository = repository
	}
	
	func fetchCreditCards(on page: Int) -> AnyPublisher<[CreditCard], Error> {
		guard let url = URL(string: "api/v2/credit_cards?size=20&page=\(page)", relativeTo: baseURL) else {
			return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
		}
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
		return repository.fetchData(url: url, decoder: decoder)
	}
	
}
