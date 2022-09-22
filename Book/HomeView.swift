//
//  HomeView.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 21/09/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var books: Library
    var body: some View {
        NavigationStack {
                      List {
                    ForEach(books.books.filter{ $0.readingState == "reading"}, id: \.id) { book in
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
                        }
                    }
                }
                      .navigationTitle("Currently Reading")
                      .navigationBarTitleDisplayMode(.automatic)
                      
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
