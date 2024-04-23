//
//  CreditCardViewerApp.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import SwiftUI

@main
struct CreditCardViewerApp: App {
	
	@StateObject var viewModel = CardsViewModel()
	@StateObject var bookmarkManager = BookmarkManager()
	
	var body: some Scene {
		WindowGroup {
			TabView {
				CardsView(viewModel: viewModel, bookmarkManager: bookmarkManager)
					.tabItem {
						Label("All Cards", systemImage: "creditcard")
					}
				SavedCardsView(viewModel: viewModel, bookmarkManager: bookmarkManager)
					.tabItem {
						Label("Saved Cards", systemImage: "bookmark.fill")
					}
			}
		}
	}
	
}
