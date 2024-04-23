//
//  BookmarkManager.swift
//  CreditCardViewer
//
//  Created by Felix on 23/04/24.
//

import SwiftUI

class BookmarkManager: ObservableObject {
	
	@AppStorage("bookmarkedCardIDs") private var bookmarkedCardIDs: String = ""
	
	private var bookmarks: Set<String> {
		get {
			return Set(bookmarkedCardIDs.components(separatedBy: ","))
		}
		set {
			bookmarkedCardIDs = newValue.joined(separator: ",")
		}
	}
	
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
