//
//  DetailedBookView.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 18/09/2022.
//

import SwiftUI

struct DetailedBookView: View {
    @State private var descripSeeMoreTog = false
    @Environment(\.dismiss) var dismiss
    @State var books: SavedBook
    @EnvironmentObject var book: Library
    @State private var editNotesSheet = false
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
                            
                        Text(books.info.volumeInfo.authors?[0] ?? "Unknown")
                            .font(.system( .caption, design: .serif))
                            .foregroundColor(.secondary)
                            .offset(x: 5)
                        if books.readingState == "read" {
                            Label( "Read", systemImage: "checkmark")
                                .foregroundColor(.secondary)
                                .font(.system( .caption, design: .serif))
                                .offset(x: 20)

                        }
                        if books.readingState == "reading" {
                            Label( "Reading", systemImage: "book")
                                .foregroundColor(.secondary)
                                .font(.system( .caption, design: .serif))
                                .padding(.vertical, 10)
                                .offset(x: 20)

                        }
                        if books.readingState == "tbr" {
                            Label( "TBR", systemImage: "bookmark")
                                .foregroundColor(.secondary)
                                .font(.system( .caption, design: .serif))
                                .padding(.vertical, 10)
                                .offset(x: 20)

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
                        
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                descripSeeMoreTog.toggle()
                            }
                        }
                    
                } else {
                    VStack(alignment: .leading) {
                        Text(books.info.volumeInfo.description ?? "This book has no description..." )
                            .BookText()
                            
                        if books.info.volumeInfo.pageCount == nil {
                            Text("Unknown Page Count")
                                .BookText()
                               
                        } else {
                            Text("\(books.info.volumeInfo.pageCount ?? 0) Pages ")
                                .BookText()
                               
                        }
                    }
                    Label( "" ,systemImage: "chevron.up")
                        .BookText()
                        
                        .onTapGesture {
                            withAnimation {
                                descripSeeMoreTog.toggle()
                            }
                        }
                }
                
                HStack {
                    Text("My Notes:")
                        .padding(.horizontal)
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .foregroundColor(.secondary)
                    Spacer()
                    Button {
                        editNotesSheet = true
                    } label: {
                        Text("Edit")
                            .font(.system(size: 15, weight: .light, design: .serif))
                    }
                    .disabled(books.notes.isEmpty)
                    .padding(.horizontal, 30)
                }
                
                if !books.notes.isEmpty {
                    LazyVGrid(columns: columns) {
                        if !editNotesSheet {
                            ForEach(books.notes, id: \.self) { note in
                                Text(note)
                                    .padding()
                                    .font(.system(size: 12, weight: .light, design: .serif))
                                   
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 350,alignment: .leading)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.secondary, lineWidth: 0.1)
                                            .shadow(radius: 3)
                                    )
                            }
                        }
                    }
                }
                else {
                    Text("No Notes")
                        .font(.system(size: 16, weight: .light, design: .serif))
                        .foregroundColor(.secondary)
                        .offset(y: 100)
                }
                
              
            }
            
            .sheet(isPresented: $editNotesSheet) {
                NavigationStack {
                    List {
                        ForEach (books.notes, id: \.self) { note in
                            Text(note)
                                .font(.system(size: 14, weight: .light, design: .serif))
                            
                        }
                        .onDelete(perform: deleteNote)
                    }
                    .navigationTitle("Edit Note")
                    .toolbar {
                        ToolbarItem {
                            Button {
                                dismiss()
                            } label: {
                                Text("Dismiss")
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
        book.save()
    }
}


