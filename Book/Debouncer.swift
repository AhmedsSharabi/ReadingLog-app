//
//  Debouncer.swift
//  Book
//
//  Created by Ahmed Sharabi on 14/09/2022.
//

import Foundation
import Combine

class DebounceState: ObservableObject {
    @Published var currentValue: String
    @Published var debouncedValue: String
    
    init(initialValue: String, delay: Double = 1) {
        _currentValue = Published(initialValue: initialValue)
        _debouncedValue = Published(initialValue: initialValue)
        $currentValue
            .throttle(for: .seconds(delay), scheduler: RunLoop.main, latest: true)
            .assign(to: &$debouncedValue)
    }
}
