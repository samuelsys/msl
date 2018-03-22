//
//  MemberAccess.swift
//  MosyleFamily
//
//  Created by Samuel Furtado on 21/03/2018.
//  Copyright © 2018 Samuel Furtado. All rights reserved.
//

import UIKit
import CoreData

class MemberAccess {
    
    static let kMembersEntityIdentifier = "MemberDO"
    
    static var managedContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
  
    static func saveMembers(members: [Member]) {
      
        let entity = NSEntityDescription.entity(forEntityName: kMembersEntityIdentifier, in: managedContext)!
        
        for member in members {
            let memberObject = NSManagedObject(entity: entity, insertInto: managedContext)
            
            memberObject.setValue(member.memberName, forKeyPath: "member_name")
            memberObject.setValue(member.urlPhoto, forKeyPath: "url_photo")
            memberObject.setValue(member.type, forKeyPath: "type")
            memberObject.setValue(member.countDevices, forKeyPath: "count_devices")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func listMembers (filter: String) -> [NSManagedObject] {
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: kMembersEntityIdentifier)

        let predicate = NSPredicate(format: "type = %@", filter)
        
        if (!filter.isEmpty){
            fetchRequest.predicate = predicate
        }
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    static func removeAll () {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: kMembersEntityIdentifier)
        fetchRequest.includesPropertyValues = false
        
        let sectionSortDescriptor = NSSortDescriptor(key: "type", ascending: false)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let items = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            
            for item in items {
                managedContext.delete(item)
            }
            
            try managedContext.save()
            
        } catch {
            print("Could not delete. \(error)")
        }
    }
    
}
