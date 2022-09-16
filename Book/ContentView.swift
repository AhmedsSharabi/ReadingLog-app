//
//  ContentView.swift
//  Book
//
//  Created by Ahmed Sharabi on 14/09/2022.
//

import SwiftUI



struct ContentView: View {
    var books = Library()
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Add Book", systemImage: "plus")
                }
            BookView(filter: .tbr)
                .tabItem {
                    Label("Books", systemImage: "plus")
                }
        }
        .environmentObject(books)
    }
}

