//
//  CreditCardViewerApp.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import SwiftUI

@main
struct CreditCardViewerApp: App {
	
	var body: some Scene {
		WindowGroup {
			TabView {
				CardsView()
					.tabItem {
						Label("All Cards", systemImage: "creditcard")
					}
				SavedCardsView()
					.tabItem {
						Label("Saved Cards", systemImage: "bookmark.fill")
					}
			}
		}
	}
	
}
