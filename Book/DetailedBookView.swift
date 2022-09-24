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
    @EnvironmentObject var book: Library
    let columns = [
        GridItem(.fixed(350))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(alignment: .center) {
                    
                    VStack(alignment: .leading) {
                        Text(books.info.volumeInfo.title)
                            .font(.system(.title, design: .serif))
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 5)
                        Text(books.info.volumeInfo.authors?[0] ?? "Unknown")
                            .font(.system( .caption, design: .serif))
                            .foregroundColor(.secondary)
                        
                        if books.readingState == "read" {
                            Label( "Read", systemImage: "checkmark")
                                .foregroundColor(.secondary)
                                .font(.system( .caption, design: .serif))
                                .padding(.vertical, 10)
                        }
                        if books.readingState == "reading" {
                            Label( "Reading", systemImage: "book")
                                .foregroundColor(.secondary)
                                .font(.system( .caption, design: .serif))
                                .padding(.vertical, 10)
                        }
                        if books.readingState == "tbr" {
                            Label( "TBR", systemImage: "bookmark")
                                .foregroundColor(.secondary)
                                .font(.system( .caption, design: .serif))
                                .padding(.vertical, 10)
                        }
                        
                    }
                    .padding(.horizontal)
                    .frame(width: 160,alignment: .leading)
                    .multilineTextAlignment(.leading)
                    
                    
                    
                    Spacer()
                    
                    AsyncImage (url: URL(string: books.info.volumeInfo.imageLinks?.thumbnail ?? "no-image")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                            .padding()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .padding()
                
                if !descripSeeMoreTog {
                    VStack(alignment: .leading) {
                        Text(books.info.volumeInfo.description ?? "This book has no description..." )
                            .BookText()
                            .lineLimit(5)
                            .foregroundColor(.secondary)
                    }
                    
                    Label( "" ,systemImage: "chevron.down")
                        .BookText()
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                descripSeeMoreTog.toggle()
                            }
                        }
                    
                } else {
                    VStack(alignment: .leading) {
                        Text(books.info.volumeInfo.description ?? "This book has no description..." )
                            .BookText()
                            .foregroundColor(.secondary)
                        if books.info.volumeInfo.pageCount == nil {
                            Text("Unknown Page Count")
                                .BookText()
                                .foregroundColor(.secondary)
                        } else {
                            Text("\(books.info.volumeInfo.pageCount ?? 0) Pages ")
                                .BookText()
                                .foregroundColor(.secondary)
                        }
                    }
                    Label( "" ,systemImage: "chevron.up")
                        .BookText()
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            withAnimation {
                                descripSeeMoreTog.toggle()
                            }
                        }
                }
                
                
                Text("My Notes:")
                    .padding()
                    .font(.system(size: 15, weight: .light, design: .serif))
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: columns) {
                    ForEach(books.notes, id: \.self) { note in
                        Text(note)
                            .padding()
                            .font(.system(size: 12, weight: .light, design: .serif))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                            .frame(width: 350,alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.secondary, lineWidth: 0.1)
                                    .shadow(radius: 3)
                            )
                            .contextMenu {
                                Button ("Delete", role: .destructive) {
                                    
                                }
                            }
                    }
                }
                
              
            }
            
            
            .navigationTitle(books.info.volumeInfo.authors?[0] ?? "Unknown")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func deleteNote(at offsets: IndexSet) {
        books.notes.remove(atOffsets: offsets)
    }
}
