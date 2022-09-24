//
//  HomeView.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 21/09/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var books: Library
    @State private var addNotesSheet = false
    let columns = [
        GridItem(.fixed(160)), GridItem(.fixed(160))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(books.books.filter{ $0.readingState == "reading"}, id: \.id) { book in
                        NavigationLink {
                            DetailedBookView(books: book)
                        } label: {
                            VStack(alignment: .center) {
                                AsyncImage (url: URL(string: book.info.volumeInfo.imageLinks?.thumbnail ?? "no-image")) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(5)
                                        .frame(width: 120, height: 190)
                                        .shadow(radius: 5)
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                                
                                Text(book.info.volumeInfo.title)
                                    .lineLimit(1)
                                    .font(.system(size: 14, weight: .regular, design: .serif))
                                    .foregroundColor(.primary)
                                
                                Button {
                                    addNotesSheet = true
                                } label: {
                                    Text("Add Notes")
                                        .font(.system(size: 15, weight: .semibold, design: .serif))
                                        .padding(.vertical, 3)
                                        .frame(width: 120)
                                        .overlay(
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .stroke(Color.secondary, lineWidth: 1)
                                                        .shadow(radius: 1)
                                                )
                                }
                                
                            }
                            .frame(width: 160, height: 245)
                            .sheet(isPresented: $addNotesSheet) {
                                AddNotes_View(book: book)
                            }
                        }
                    }
                }
              
                .navigationTitle("Currently Reading")
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
