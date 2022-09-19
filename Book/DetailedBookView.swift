//
//  DetailedBookView.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 18/09/2022.
//

import SwiftUI

struct DetailedBookView: View {
    @State private var descripSeeMoreTog = false
    @State var books: SavedBook
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage (url: URL(string: books.info.volumeInfo.imageLinks?.thumbnail ?? "no-image")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(books.info.volumeInfo.title)
                        .font(.title.bold())
                        .multilineTextAlignment(.center)
                    Text(books.info.volumeInfo.authors?[0] ?? "Unknown")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text("Book Description")
                        .BookText().bold()
                    
                    if !descripSeeMoreTog {
                        Text(books.info.volumeInfo.description ?? "JI" )
                            .BookText()
                            .lineLimit(5)
                        Text("See More")
                            .BookText()
                            .foregroundColor(.blue)
                            .onTapGesture {
                                withAnimation {
                                    descripSeeMoreTog.toggle()
                                }
                            }
                        
                    } else {
                        Text(books.info.volumeInfo.description ?? "JI" )
                            .BookText()
                        Text("See less")
                            .BookText()
                            .foregroundColor(.blue)
                            .onTapGesture {
                                withAnimation {
                                    descripSeeMoreTog.toggle()
                                }
                            }
                    }
                }
                
                Text("\(books.info.volumeInfo.pageCount ?? 0) Pages")
            }
            .navigationTitle(books.info.volumeInfo.authors?[0] ?? "Unknown")
        }
    }
}
    
