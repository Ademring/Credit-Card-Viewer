//
//  SavedCardsView.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import SwiftUI

struct SavedCardsView: View {
	
	@ObservedObject var viewModel: CardsViewModel
	@ObservedObject var bookmarkManager: BookmarkManager
	
	var savedCards: [CreditCard] {
		return viewModel.cards.filter { bookmarkManager.isBookmarked($0) }
	}
	
	var body: some View {
		NavigationView {
			List {
				ForEach(savedCards) { card in
					CardRowView(card: card, bookmarkManager: bookmarkManager)
				}
			}
			.navigationTitle("Saved Cards")
		}
	}
	
}

struct SavedCardsView_Previews: PreviewProvider {
	static var previews: some View {
		SavedCardsView(viewModel: CardsViewModel(),
					   bookmarkManager: BookmarkManager())
	}
}
