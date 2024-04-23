//
//  CardsViewModelTests.swift
//  CreditCardViewer
//
//  Created by Felix on 24/04/24.
//

import XCTest
import Combine
@testable import CreditCardViewer

class CardsViewModelTests: XCTestCase {
	var viewModel: CardsViewModel!
	var service: CardServiceMock!
	
	override func setUp() {
		super.setUp()
		service = CardServiceMock()
		viewModel = CardsViewModel(service: service)
	}
	
	override func tearDown() {
		service = nil
		viewModel = nil
		super.tearDown()
	}
	
	func testFetchNextPageSuccess() {
		// Given
		let mockData = [CreditCard(uid: "1", creditCardType: "Visa", creditCardNumber: "1234567890123456", creditCardExpiryDate: "2024-12-31")]
		service.mockResult = Just(mockData)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
		
		// When
		let expectation = self.expectation(description: "Fetching next page")
		viewModel.fetchNextPageThrottled()
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			expectation.fulfill()
		}
		waitForExpectations(timeout: 2)
		
		// Then
		XCTAssertEqual(viewModel.cards.count, 1)
		XCTAssertEqual(viewModel.cards.first?.uid, "1")
		XCTAssertFalse(viewModel.isLoading)
		XCTAssertTrue(viewModel.errorMessage.isEmpty)
	}
	
	func testFetchNextPageFailure() {
		// Given
		let expectedError = URLError(.badURL)
		service.mockResult = Fail(error: expectedError)
			.eraseToAnyPublisher()
		
		// When
		let expectation = self.expectation(description: "Fetching next page")
		viewModel.fetchNextPageThrottled()
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			expectation.fulfill()
		}
		waitForExpectations(timeout: 2)
		
		// Then
		XCTAssertTrue(viewModel.cards.isEmpty)
		XCTAssertFalse(viewModel.isLoading)
		XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
	}
	
	func testThrottle() {
		// Given
		let mockData = [CreditCard(uid: "1", creditCardType: "Visa", creditCardNumber: "1234567890123456", creditCardExpiryDate: "2024-12-31")]
		service.mockResult = Just(mockData)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
		
		// When
		let expectation = self.expectation(description: "Fetching next page")
		
		// Fire the fetchNextPageThrottled method multiple times in a short period
		for _ in 0..<5 {
			viewModel.fetchNextPageThrottled()
		}
		
		// We expect only one actual fetch to occur because of the throttle
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			expectation.fulfill()
		}
		waitForExpectations(timeout: 2)
		
		// Then
		XCTAssertEqual(viewModel.cards.count, 1)
		XCTAssertFalse(viewModel.isLoading)
		XCTAssertTrue(viewModel.errorMessage.isEmpty)
	}
}

class CardServiceMock: CardServiceProtocol {
	var mockResult: AnyPublisher<[CreditCard], Error>?
	
	func fetchCreditCards(on page: Int) -> AnyPublisher<[CreditCard], Error> {
		guard let mockResult = mockResult else {
			fatalError("Mock result is not set.")
		}
		return mockResult
	}
}
