//
//  FileManger-DocumentDirectory.swift
//  BucketList
//
//  Created by Ahmed Sharabi on 19/08/2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

