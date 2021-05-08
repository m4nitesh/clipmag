//
//  Persistence.swift
//  clipmag
//
//  Created by Nitesh Kumar on 24/04/21.
//

import Foundation
import CoreData
import AppKit


struct PersistenceController {
    static let shared = PersistenceController();
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ClipboardList")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("We have unresolved error :\(error)")
            }
        })
    }
    
    public var viewContext: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    
    func saveContext() {
        let context = PersistenceController.shared.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func checkIfItemExist(hashId: String) -> Bool {

        let managedContext = PersistenceController.shared.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "HistoryItem")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "hashId == %@" ,hashId)

        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func updateOrInsertItem(stringData: String, applicationId: String, data: Data?, pType: NSPasteboard.PasteboardType?, urlString: String?) -> Bool {
        
        let hashId = SHA256(str: stringData);
        let managedContext = PersistenceController.shared.viewContext
        let fetchRequest = NSFetchRequest<HistoryItem>(entityName: "HistoryItem")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "hashId == %@" ,hashId)

        do {
            let items = try managedContext.fetch(fetchRequest)
            if items.count == 0 {
                addClipboardItem(hashId: hashId, stringData: stringData, applicationId: applicationId, data: data, pType: pType, urlString: urlString)
            }else {
                var task: HistoryItem = HistoryItem(context: PersistenceController.shared.viewContext)
                task = items.first!;
                task.timestamp = Date()
                PersistenceController.shared.saveContext();
            }
            
            return true
            
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func addClipboardItem(hashId: String, stringData: String, applicationId: String, data: Data?, pType: NSPasteboard.PasteboardType?, urlString: String?) {
        let clipItem = HistoryItem(context: PersistenceController.shared.viewContext)
        clipItem.timestamp = Date()
        clipItem.hashId = hashId
        clipItem.stringData = stringData;
        clipItem.applicationId = applicationId;
        clipItem.binaryData = data
        clipItem.pType = pType?.rawValue
        clipItem.urlString = urlString
        PersistenceController.shared.saveContext()
    }


    
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try PersistenceController.shared.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                PersistenceController.shared.viewContext.delete(objectData)
                PersistenceController.shared.saveContext()
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
//    func migrateToHistoryItem(_ entity:String) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        do {
//            let results = try PersistenceController.shared.viewContext.fetch(fetchRequest)
//            for object in results {
//                guard let objectData = object as? Task else {continue}
//                let clipItem = HistoryItem(context: PersistenceController.shared.viewContext)
//                clipItem.timestamp = objectData.timestamp
//                clipItem.hashId = objectData.hashId
//                clipItem.stringData = objectData.content;
//                clipItem.applicationId = objectData.type;
//                PersistenceController.shared.saveContext()
//            }
//        } catch let error {
//            print("Detele all data in \(entity) error :", error)
//        }
//    }


    
}
