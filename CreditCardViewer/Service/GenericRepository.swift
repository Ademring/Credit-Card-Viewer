//
//  CardsViewModel.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import Foundation
import Combine

class GenericRepository: GenericRepositoryProtocol {
	
	func fetchData<T: Decodable>(url: URL, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
		return URLSession.shared.dataTaskPublisher(for: url)
			.map(\.data)
			.subscribe(on: DispatchQueue.global())
			.receive(on: DispatchQueue.main)
			.decode(type: T.self, decoder: decoder)
			.eraseToAnyPublisher()
	}
	
}
