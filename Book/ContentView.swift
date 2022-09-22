//
//  ContentView.swift
//  Book
//
//  Created by Ahmed Sharabi on 14/09/2022.
//

import SwiftUI



struct ContentView: View {
    var books = Library()
    @State private var selection = 0
    var body: some View {
        
        TabView(selection: $selection) {
            NavigationStack {
                HomeView()
            }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            SearchView()
                .tabItem {
                    Label("Add Book", systemImage: "plus")
                }
                .tag(0)
            NavigationStack {
                BookView(filter: .all)
            }
                .tabItem {
                    Label("Books", systemImage: "books.vertical")
                }
                .tag(1)
        }
        .tint(.purple)
        .environmentObject(books)
        
    }
}

