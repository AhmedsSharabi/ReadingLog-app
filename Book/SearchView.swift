//
//  SwiftUIView.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 15/09/2022.
//

import SwiftUI

struct SearchView: View {
    @State private var pages = [Item]()
    @StateObject var searchQuery = DebounceState(initialValue: "")
    @State private var readingSatuts = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(pages, id: \.id){ page in
                    HStack {
                        if page.volumeInfo.imageLinks?.smallThumbnail != nil {
                            AsyncImage (url: URL(string: page.volumeInfo.imageLinks?.smallThumbnail ?? "no-image")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 64)
                            } placeholder: {
                                ProgressView()
                            }
                            
                        } else {
                            Image("no-image")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40 , height: 64)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(page.volumeInfo.title)
                                .font(.headline)
                            Text(page.volumeInfo.authors?[0] ?? "Unknown")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Button {
                            readingSatuts = true
                        } label: {
                            Image(systemName: "plus.circle")
                                .imageScale(.large)
                        }
                        
                    }
                    
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchQuery.currentValue)
            .onChange(of: searchQuery.debouncedValue){ new in
                searchQuery.debouncedValue = new
                if !searchQuery.debouncedValue.isEmpty {
                    getData()
                } else {
                    pages.removeAll()
                }
            }
            .confirmationDialog("Add to:", isPresented: $readingSatuts, titleVisibility: .visible) {
                Button("TBR pile") {}
                Button("Read Pile") {}
                Button("Currently reading pile") {}
            }
        }
    }
    
    func getData() {
        let newString = searchQuery.debouncedValue.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(newString)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("error getting data", error as Any)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("error getting data", response as Any)
                return
            }
            
            guard let data = data else {
                print("couldn't get data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(Book.self, from: data)
                pages = data.items
                
            } catch {
                print("couldn't decode data", error)
            }
            
        }
        task.resume()
        
        
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
