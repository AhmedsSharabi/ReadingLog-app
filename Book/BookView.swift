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
                List {
                    HStack {
                        Picker("Select", selection: $bookFilter) {
                            Text("All").tag(Library.FilterType.all)
                            Text("TBR").tag(Library.FilterType.tbr)
                            Text("Reading").tag(Library.FilterType.reading)
                            Text("Read").tag(Library.FilterType.read)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        
                    }
                    
                    ForEach(filteredBooks){ book in
                        NavigationLink {
                            withAnimation(.easeIn) {
                                DetailedBookView(books: book)
                            }
                        } label: {
                            HStack {
                                AsyncImage (url: URL(string: book.info.volumeInfo.imageLinks?.thumbnail ?? "no-image")) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                        .cornerRadius(5)
                                        .offset(x: -25)
                                } placeholder: {
                                    ProgressView()
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(book.info.volumeInfo.title)
                                        .font(.system(size: 18, weight: .light, design: .serif)).bold()
                                        .multilineTextAlignment(.leading)
                                    
                                    Text(book.info.volumeInfo.authors?[0] ??  "Unknown Author")
                                        .font(.system(size: 14, weight: .light, design: .serif))
                                        .foregroundColor(.secondary)
                                
                                }
                                
                                .offset(x: -20, y: -20)
                                
                            }
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                            .swipeActions {
                                
                            }
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

