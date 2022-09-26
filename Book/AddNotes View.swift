//
//  AddNotes View.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 24/09/2022.
//

import SwiftUI

struct AddNotes_View: View {
    @EnvironmentObject var books: Library
    @Environment(\.dismiss) var dismiss
    @State private var noteheader = ""
    @State private var noteDetails = ""
    @State private var note = ""
    let book: SavedBook
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField ("This Notes is taken from: ", text: $noteheader)
                        .multilineTextAlignment(.leading)
                } header: {
                    Text("Add Header")
                }
                Section {
                    TextEditor(text: $noteDetails)
                        .multilineTextAlignment(.leading)
                } header: {
                    Text("Add Body")
                }
                
            }
            .navigationTitle("Add Note")
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
                ToolbarItem(placement: .bottomBar){
                    Button {
                        note = "FROM \(noteheader)\n\(noteDetails)"
                        books.saveNote(book, note: note)
                        dismiss()

                        
                     
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}
