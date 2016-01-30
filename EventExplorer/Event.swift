//
//  Event.swift
//  EventExplorer
//
//  Created by Sjoerd Beentjes on 11-11-15.
//  Copyright © 2015 Sjoerd Beentjes. All rights reserved.
//

import UIKit

class Event: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var detail: String
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let detailKey = "detail"
    }
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, detail: String) {
        self.name = name
        self.photo = photo
        self.detail = detail
        
        super.init()
        
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(detail, forKey: PropertyKey.detailKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        let detail = aDecoder.decodeObjectForKey(PropertyKey.detailKey) as! String
        
        self.init(name: name, photo: photo, detail: detail)
    }
    
}