//
//  BookView.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 15/09/2022.
//

import SwiftUI

struct BookView: View {
    @EnvironmentObject var books: Library
    @State private var bookFilter: Library.FilterType = .all
    
    
    let filter: Library.FilterType
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("Filter by:")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                
                
                Picker("Select", selection: $bookFilter) {
                    Text("All").tag(Library.FilterType.all)
                    Text("Read").tag(Library.FilterType.read)
                    Text("TBR").tag(Library.FilterType.tbr)
                    Text("Currently Reading").tag(Library.FilterType.reading)
                }
                .padding(.horizontal)
                .foregroundColor(.purple)

            }
                List {
                    ForEach(filteredBooks){ book in
                        HStack {
                            AsyncImage (url: URL(string: book.info.volumeInfo.imageLinks?.thumbnail ?? "no-image")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            VStack(alignment: .leading) {
                                Text(book.info.volumeInfo.title)
                                Text(book.info.volumeInfo.authors?[0] ??  "Unknown Author")
                            }
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                }
                    .onDelete(perform: books.removeBook)
                }
                .navigationTitle("My Books")
                .navigationBarTitleDisplayMode(.inline)

            
            }
        }
    
    var filteredBooks: [SavedBook] {
        switch bookFilter {
        case .all:
            return books.books
        case .read:
            return books.books.filter{ $0.readingState == "read" }
        case .reading:
            return books.books.filter{ $0.readingState == "reading" }
        case .tbr :
            return books.books.filter{ $0.readingState == "tbr" }
        }
    }
    }
