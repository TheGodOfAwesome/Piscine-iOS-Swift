//
//  Article+CoreDataProperties.swift
//  
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/12.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: NSData?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var modificationDate: NSDate?

    override var description: String {
        return "Title:\(title), Content: \(content), Language: \(language), Image: \(image), Creation Date: \(creationDate), Modification Date: \(modificationDate)"
    }
}
