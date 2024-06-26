//
//  CardsView.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import SwiftUI

struct CardsView: View {
	
	@ObservedObject var viewModel: CardsViewModel
	@ObservedObject var bookmarkManager: BookmarkManager
	@State private var isFirstAppearance = true
	
	var body: some View {
		NavigationView {
			GeometryReader { _ in
				VStack {
					Picker(selection: $viewModel.currentSortType, label: Text("Sort by")) {
						Text("Default").tag(CardsViewModel.SortType.byDefault)
						Text("Type").tag(CardsViewModel.SortType.byType)
					}
					.pickerStyle(SegmentedPickerStyle())
					.padding()
					
					if viewModel.isLoading && viewModel.cards.isEmpty {
						ProgressView()
							.progressViewStyle(DefaultProgressViewStyle())
							.padding()
					} else if !viewModel.cards.isEmpty {
						List {
							ForEach(viewModel.sortedCards) { card in
								NavigationLink(destination: CardDetailView(card: card)) {
									CardRowView(card: card, bookmarkManager: bookmarkManager)
								}
								.onAppear {
									if viewModel.currentSortType == .byDefault,
									   card == viewModel.cards.last {
										viewModel.fetchNextPageThrottled()
									}
								}
							}
						}
					} else {
						Text(viewModel.errorMessage)
							.foregroundColor(.red)
					}
				}
				.navigationTitle("Credit Cards")
			}
			.alignmentGuide(.top) { _ in
				0
			}
			.task {
				if isFirstAppearance {
					isFirstAppearance = false
					viewModel.fetchNextPageThrottled()
				}
			}
		}
	}
	
}

struct CardsView_Previews: PreviewProvider {
	static var previews: some View {
		CardsView(viewModel: CardsViewModel(),
				  bookmarkManager: BookmarkManager())
	}
}
