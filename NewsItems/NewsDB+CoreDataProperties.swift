//
//  NewsDB+CoreDataProperties.swift
//  
//
//  Created by Тагир Булыков on 17.03.2024.
//
//

import Foundation
import CoreData


extension NewsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsDB> {
        return NSFetchRequest<NewsDB>(entityName: "NewsDB")
    }

    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var desc: String?
    @NSManaged public var title: String?
    @NSManaged public var urlToImage: String?
}
