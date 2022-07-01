//
//  Bundle+Decodable.swift
//  AppStore
//
//  Created by Vladimir Fibe on 01.07.2022.
//

import UIKit

extension Bundle {
  func decode<T: Decodable>(_ type: T.Type, frome file: String) -> T {
    guard let url = self.url(forResource: file, withExtension: nil)
    else { fatalError("Failed to locate \(file) in bundle.") }
    
    guard let data = try? Data(contentsOf: url)
    else { fatalError("Failed to load \(file) from bundle.")}
    
    let decoder = JSONDecoder()
    
    guard let loaded = try? decoder.decode(T.self, from: data) else
    { fatalError("Failed to decode \(file) from bundle.")}
    
    return loaded
  }
}
