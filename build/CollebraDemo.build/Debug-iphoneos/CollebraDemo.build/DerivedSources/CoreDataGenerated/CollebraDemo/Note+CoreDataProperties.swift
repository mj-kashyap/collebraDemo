//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Manoj kashyap on 19/06/24.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
