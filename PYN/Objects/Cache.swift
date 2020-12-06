//
//  Cache.swift
//  testProject
//
//  Created by awaleh moussa hassan on 10/11/2020.
//

import Foundation
import Combine

final class Cache<Key: Hashable, Value>{
    
    private let wrapper = NSCache<WrapperKey, Entry>()
    let keyTracker = KeyTracker()
    
    init(){
        wrapper.delegate = keyTracker
    }
    
    func insert(value: Value, for key: Key){
        
        let entry = Entry(key: key, value: value)
        let wrapperKey = WrapperKey(key: key)
        wrapper.setObject(entry, forKey: wrapperKey)
        keyTracker.keys.insert(entry.key)
    }
    
    func retrieveEntry(for key: Key) -> Entry?{
        
        let wrapperKey = WrapperKey(key: key)
        guard let entry = wrapper.object(forKey: wrapperKey) else {return nil}
        return entry
    }
    
    func retrieveAll() -> [Entry]{
        keyTracker.keys.compactMap(retrieveEntry)
    }
    
    func remove(key: Key){
        self.wrapper.removeObject(forKey: WrapperKey(key: key))
    }
}

extension Cache{
    
    final class WrapperKey: NSObject{
        
        let key: Key
        
        init(key: Key){
            self.key = key
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let wrapperKey = object as? WrapperKey else {return false}
            return self.key == wrapperKey.key
        }
        
        override var hash: Int {key.hashValue}
    }
}

extension Cache{
    
    final class Entry {
        
        let key: Key
        let value: Value
        
        init(key: Key, value: Value){
            self.key = key
            self.value = value
            
        }
    }
}


extension Cache{
    
    final class KeyTracker: NSObject, NSCacheDelegate, ObservableObject{
       
         var keys = Set<Key>()
         @Published var removedKey: Key?
        
        func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any){
            
            guard let value = obj as? Entry else {return}
            self.keys.remove(value.key)
            self.removedKey = value.key
            print("evicting key:", value.key)
        }
        
  }
}

extension Cache.Entry: Codable where Key: Codable, Value: Codable {}
    
    
extension Cache: Codable where Key: Codable, Value: Codable{

    convenience init(from decoder: Decoder) throws{
        self.init()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let entries = self.retrieveAll()
        try? container.encode(entries)
    }

    func saveToDisc(){
        
        do{
            let data = try JSONEncoder().encode(self)
            try? data.write(to: .cacheFile)
            print("Did write to file successfully!!!!")
        }
        catch let error {
            print("OOPS An Error occured during file writting")
            print(error.localizedDescription)
        }
        
    }
    
    func loadFromDisk(){
        
        guard let data = try? Data(contentsOf: .cacheFile) else {print("reading from file FAILED!!"); return}
        guard let entries = try? JSONDecoder().decode([Entry].self, from: data) else {return}
        entries.forEach{ [weak self] entry in
                         guard let self = self else {return}
                         self.insert(value: entry.value, for: entry.key)
        }
    }

}
