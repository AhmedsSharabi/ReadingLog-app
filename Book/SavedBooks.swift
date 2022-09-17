//
//  SavedBooks.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 15/09/2022.
//

import SwiftUI

class SavedBook: Identifiable, Codable {
    var id = UUID()
    var info: Item = Item(id: "", volumeInfo: Volume(title: "", subtitle: "", authors: [], imageLinks: Images(smallThumbnail: "", thumbnail: "")))
    var notes = ""
    var readingState = ""
}



class Library: ObservableObject {
    @Published var books: [SavedBook]
     
    init() {
        do {
            let data = try Data(contentsOf: FileManager.documentsDirectory.appendingPathComponent("SaveBooks"))
            books = try JSONDecoder().decode([SavedBook].self, from: data)
        } catch {
            books = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(books)
            try data.write(to: FileManager.documentsDirectory.appendingPathComponent("SaveBooks"), options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func add(_ book: SavedBook, mark: String) {
        books.append(book)
        book.readingState = mark
        save()
    }
    
    func removeBook(at offsets: IndexSet) {
        books.remove(atOffsets: offsets)
        save()
    }
    
    enum FilterType {
        case all, read, tbr, reading
    }
    
    
    
    
}

    
   


