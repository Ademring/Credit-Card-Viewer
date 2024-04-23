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
	private let fetchSubject = PassthroughSubject<Void, Never>()
	private let service: CardServiceProtocol
	
	var sortedCards: [CreditCard] {
		switch currentSortType {
		case .byType:
			cards.sorted { $0.creditCardType < $1.creditCardType }
		case .byDefault:
			cards
		}
	}
	
	init(service: CardServiceProtocol = CardService()) {
		self.service = service
		fetchSubject
			.throttle(for: .seconds(1), scheduler: RunLoop.main, latest: false)
			.sink { [weak self] _ in
				self?.fetchNextPage()
			}
			.store(in: &cancellables)
	}
	
	func fetchNextPageThrottled() {
		fetchSubject.send()
	}
	
	private func fetchNextPage() {
		guard !isLoading else { return }
		isLoading = true
		
		service.fetchCreditCards(on: currentPage)
			.sink(receiveCompletion: { [weak self] completion in
				guard let self else { return }
				self.isLoading = false
				if case let .failure(error) = completion {
					self.errorMessage = error.localizedDescription
				}
			}, receiveValue: { [weak self] newCards in
				guard let self else { return }
				self.cards += newCards
				self.currentPage += 1
			})
			.store(in: &cancellables)
	}
	
}
