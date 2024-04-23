//
//  CardDetailView.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import SwiftUI

struct CardDetailView: View {
	
	let card: CreditCard
	
	var body: some View {
		VStack {
			Image(systemName: "creditcard")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 100, height: 100)
				.padding()
			
			Text(card.type)
				.font(.title)
				.padding()
			
			Text(card.creditCardNumber)
				.font(.largeTitle)
				.padding()
			
			Text("Expiry: \(card.expiryDateString ?? "Not available")")
				.font(.headline)
				.padding()
			
			Spacer()
		}
		.navigationTitle("Card Details")
	}
	
}

struct CardDetailView_Previews: PreviewProvider {
	static var previews: some View {
		CardDetailView(card:
						CreditCard(uid: "mock",
								   creditCardType: "american_express",
								   creditCardNumber: "1111-1111-1111-1111",
								   creditCardExpiryDate: "2026-04-01"))
	}
}
