//
//  CardServiceTests.swift
//  CreditCardViewer
//
//  Created by Felix on 24/04/24.
//

import XCTest
import Combine
@testable import CreditCardViewer

class CardServiceTests: XCTestCase {
	var service: CardServiceProtocol!
	var repository: GenericRepositoryProtocol!
	
	override func tearDown() {
		service = nil
		repository = nil
		super.tearDown()
	}
	
	func testFetchCreditCardsSuccess() {
		// Given
		let mockData = [CreditCard(uid: "1", creditCardType: "Visa", creditCardNumber: "1234567890123456", creditCardExpiryDate: "2024-12-31")]
		repository = GenericRepositoryMock(
			mockResult:
				Just(mockData)
				.setFailureType(to: Error.self)
				.eraseToAnyPublisher()
		)
		service = CardService(repository: repository)
		
		// When
		var receivedCards: [CreditCard]?
		let expectation = self.expectation(description: "Fetching credit cards")
		let cancellable = service.fetchCreditCards(on: 0)
			.sink(receiveCompletion: { _ in
				expectation.fulfill()
			}, receiveValue: { cards in
				receivedCards = cards
			})
		
		waitForExpectations(timeout: 1)
		
		// Then
		XCTAssertNotNil(receivedCards)
		XCTAssertEqual(receivedCards!, mockData)
		cancellable.cancel()
	}
	
	func testFetchCreditCardsFailure() {
		// Given
		let expectedError = URLError(.badURL)
		repository = GenericRepositoryMock(
			mockResult:
				Fail(error: expectedError)
				.eraseToAnyPublisher()
		)
		service = CardService(repository: repository)
		
		// When
		var receivedError: Error?
		let expectation = self.expectation(description: "Fetching credit cards")
		let cancellable = service.fetchCreditCards(on: 0)
			.sink(receiveCompletion: { completion in
				switch completion {
				case .failure(let error):
					receivedError = error
				case .finished:
					break
				}
				expectation.fulfill()
			}, receiveValue: { _ in })
		
		waitForExpectations(timeout: 1)
		
		// Then
		XCTAssertNotNil(receivedError)
		XCTAssertEqual(receivedError! as NSError, expectedError as NSError)
		cancellable.cancel()
	}
}

struct GenericRepositoryMock: GenericRepositoryProtocol {
	var mockResult: AnyPublisher<[CreditCard], Error>?
	
	func fetchData<T>(url: URL, decoder: JSONDecoder) -> AnyPublisher<T, Error> where T : Decodable {
		guard let mockResult = mockResult as? AnyPublisher<T, Error> else {
			fatalError("Mock result is not set.")
		}
		return mockResult
	}
}
