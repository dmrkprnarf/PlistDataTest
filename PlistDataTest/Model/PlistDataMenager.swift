//
//  PlistDataMenager.swift
//  PlistDataTest
//
//  Created by Arif Demirkoparan on 23.02.2023.
//

import Foundation

class PlistDataMenager {
    static var  shared = PlistDataMenager()
    
    var textArray = [PlistDataModel]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("TestData.plist")
    
    func saveData(with text:String = "") {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(textArray)
            if let SData = dataFilePath {
                try data.write(to:SData)
            }
        }catch{
            print("Error encoding data\(error)")
        }
    }
    func loadData() {
        if  let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                textArray = try decoder.decode([PlistDataModel].self, from: data)
            }catch{
                print("Error decoding data \(error)")
            }
        }
    }
    
    func deleteData(text:String){
        if  let plistDict = NSMutableDictionary(contentsOf: dataFilePath!) {
            plistDict.removeObject(forKey: text)
        }
    }
}
