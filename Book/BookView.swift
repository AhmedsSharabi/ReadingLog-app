//
//  BookView.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 15/09/2022.
//

import SwiftUI

struct BookView: View {
    @EnvironmentObject var books: Library
    
    enum FilterType {
        case read, tbr, reading
    }
    
    let filter: FilterType
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredBooks){ book in
                    Text(book.info.volumeInfo.title)
                }
            }
            }
        }
    
    var filteredBooks: [SavedBook] {
        switch filter {
        case .read:
            return books.books
        case .reading:
            return books.books
        case .tbr :
            return books.books
        }
    }
    }
