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
                Picker("Select", selection: $bookFilter) {
                    Text("All").tag(Library.FilterType.all)
                    Text("TBR").tag(Library.FilterType.tbr)
                    Text("Reading").tag(Library.FilterType.reading)
                    Text("Read").tag(Library.FilterType.read)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .foregroundColor(.purple)
                
            }
            
            List {
                ForEach(filteredBooks){ book in
                    NavigationLink {
                        Text(book.readingState)
                    } label: {
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
                                    .font(.caption.bold())
                                Text(book.info.volumeInfo.authors?[0] ??  "Unknown Author")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                HStack(alignment: .center) {
                                    Text("Read")
                                        .font(.caption.bold())
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 10, weight: .light))
                                       
                                        
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(.black)
                                .cornerRadius(10)
                            }
                            }
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                            
                          
                            
//                        .contextMenu {
//                                Button {
//                                    print(book)
//                                } label:{
//                                    Label("Mark as Read", systemImage: "book.closed")
//                            }
//                                Button {
//                                    print(book)
//                                } label: {
//                                    Label("Mark as Currently Reading", systemImage: "book")
//                                }
//                                Button {
//                                    print(book)
//                                } label: {
//                                    Label("Mark as TBR", systemImage: "bookmark")
//                                }

//                        }

                    }
                } .onDelete(perform: books.removeBook)
                   
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
