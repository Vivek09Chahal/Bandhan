//
//  dataFetch.swift
//  Bandhan
//
//  Created by Vivek on 7/1/25.
//

import Foundation

@Observable
class DataFetch {
    
    var profiles: [ProfilesData] = []
    
    init(){
        self.profiles = load("ProfilesData")
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
        else {
            fatalError("Couldn't find \(filename) in main bundle")
        }
        
        
        do {
            let data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
    }
}

//import Foundation
//import SwiftUI
//
//func loadMedicineJSONData() -> [Medicine] {
//    guard let url = Bundle.main.url(forResource: "medicineData", withExtension: "json")
//    else {
//        fatalError("Failed to locate medicineData.json in bundle.")
//    }
//    
//    guard let data = try? Data(contentsOf: url)
//    else {
//        fatalError("Failed to load medical.json from bundle.")
//    }
//    
//    let decoder = JSONDecoder()
//    
//    do{
//        return try decoder.decode([Medicine].self, from: data)
//    } catch DecodingError.keyNotFound(let key, let context){
//        fatalError("Failed to decode \(#file) from bundle: \(key.stringValue), \(context.debugDescription)")
//    } catch DecodingError.typeMismatch(_ , let context){
//        fatalError("Failed to decode \(#file) from bundle: \(context.debugDescription)")
//    } catch DecodingError.valueNotFound(let type, let context){
//        fatalError("Fai;ed to decode \(#file) from bundle: \(type), \(context.debugDescription)")
//    } catch DecodingError.dataCorrupted(let context){
//        fatalError("Failed to decode \(#file) from bundle: \(context.debugDescription)")
//    } catch{
//        fatalError("Failed to decode \(#file) from bundle \(error.localizedDescription)")
//    }
    
//    guard let descriptions = try? decoder.decode([Medicine].self, from: data)
//    else {
//        fatalError("Failed to decode medical.json from bundle.")
//    }
    
//    return descriptions
//}
