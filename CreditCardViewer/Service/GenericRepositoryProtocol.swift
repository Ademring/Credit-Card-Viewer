//
//  CardsViewModel.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import Foundation
import Combine

protocol GenericRepositoryProtocol {
	
	func fetchData<T: Decodable>(url: URL, decoder: JSONDecoder) -> AnyPublisher<T, Error>
	
}
