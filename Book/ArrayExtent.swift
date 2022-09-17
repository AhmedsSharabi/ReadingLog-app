//
//  ArrayExtent.swift
//  ReadingLog
//
//  Created by Ahmed Sharabi on 16/09/2022.
//

import Foundation


extension Array {
    func sliceArray(upTo maxInt: Int) -> Self {
        
        guard !self.isEmpty, self.count > maxInt else { return self }
        
        let slicedArray = self.prefix(upTo: maxInt)
        
        return Array(slicedArray)
        
    }
}

extension String {
    func fixStringURL() -> Self {
        
        let fixedURL = self.replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: "'", with: "%27")
        
        return String(fixedURL)
        
    }
}

