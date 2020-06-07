
import Foundation
import CoreData


extension NSManagedObjectContext {
    
    func saveThrows() {
        if self.hasChanges{
            do {
                try save()
            } catch {
                //добавить обработку ошибок
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
