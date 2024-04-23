//
//  BookmarkManager.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import Foundation

class BookmarkManager: ObservableObject {
	
	private var bookmarks = Set<String>()
	
	func toggleBookmark(for card: CreditCard) {
		if isBookmarked(card) {
			bookmarks.remove(card.uid)
		} else {
			bookmarks.insert(card.uid)
		}
	}
	
	func isBookmarked(_ card: CreditCard) -> Bool {
		return bookmarks.contains(card.uid)
	}
	
}
