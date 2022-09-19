//
//  DetailedBookView-Modifers.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 20/09/2022.
//

import SwiftUI

struct DescriptionText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .font(.system(size: 12, weight: .light, design: .serif))
        
    }
}

extension View {
    func BookText() -> some View {
        modifier(DescriptionText())
    }
}
