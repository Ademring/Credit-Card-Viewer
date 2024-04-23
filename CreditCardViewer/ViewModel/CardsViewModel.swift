//
//  CardsViewModel.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import Foundation
import Combine

class CardsViewModel: ObservableObject {
	
	enum SortType {
		case byType
		case byDefault
	}
	
	@Published var cards = [CreditCard]()
	@Published var isLoading = false
	@Published var errorMessage = ""
	@Published var currentSortType: SortType = .byDefault
	
	private var currentPage = 0
	private var cancellables = Set<AnyCancellable>()
	
	var sortedCards: [CreditCard] {
		switch currentSortType {
		case .byType:
			return cards.sorted { $0.creditCardType < $1.creditCardType }
		case .byDefault:
			return cards
		}
	}
	
	func fetchNextPage() {
		guard !isLoading else { return }
		isLoading = true
		
		guard let url = URL(string: "https://random-data-api.com/api/v2/credit_cards?size=20&page=\(currentPage)") else {
			isLoading = false
			errorMessage = "Invalid URL"
			return
		}
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
		
		URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.subscribe(on: DispatchQueue.global())
			.decode(type: [CreditCard].self, decoder: decoder)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				self?.isLoading = false
				if case let .failure(error) = completion {
					self?.errorMessage = error.localizedDescription
				}
			}, receiveValue: { [weak self] newCards in
				self?.cards += newCards
				self?.currentPage += 1
			})
			.store(in: &cancellables)
	}
	
}
