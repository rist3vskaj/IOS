import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EventModel") // Use your actual data model name
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    // MARK: - Save new event
    func saveEvent(title: String, description: String, startDate: String, endDate: String) {
        let context = persistentContainer.viewContext
        let newEvent = WishEvent(context: context)
        newEvent.title = title
        newEvent.descr = description
        newEvent.startDate = startDate
        newEvent.endDate = endDate
        
        do {
            try context.save()
            print("Event saved to CoreData")
        } catch {
            print("Error saving event: \(error)")
        }
    }
    
    func fetchEvents() -> [WishEvent] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WishEvent> = WishEvent.fetchRequest()
        
        do {
            let events = try context.fetch(fetchRequest)
            return events
        } catch {
            print("Error fetching events: \(error)")
            return []
        }
    }
}

