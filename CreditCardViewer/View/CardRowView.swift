//
//  CardRowView.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import SwiftUI

struct CardRowView: View {
	
	let card: CreditCard
	@ObservedObject var bookmarkManager: BookmarkManager
	
	var body: some View {
		HStack {
			Image(systemName: "creditcard")
			VStack(alignment: .leading) {
				Text(card.type)
					.font(.headline)
				Text(card.creditCardNumber)
					.font(.subheadline)
			}
			Spacer()
			Button(action: {
				bookmarkManager.toggleBookmark(for: card)
			}) {
				Image(systemName: bookmarkManager.isBookmarked(card) ? "bookmark.fill" : "bookmark")
			}
		}
		.buttonStyle(PlainButtonStyle())
	}
	
}

struct CardRowView_Previews: PreviewProvider {
	static var previews: some View {
		CardRowView(
			card: CreditCard(uid: "mock",
							 creditCardType: "visa",
							 creditCardNumber: "1234-1234-1234-1234",
							 creditCardExpiryDate: "2026-01-01"),
			bookmarkManager: BookmarkManager()
		)
	}
}
