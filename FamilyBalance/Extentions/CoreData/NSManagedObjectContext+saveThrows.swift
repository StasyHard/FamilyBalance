
import Foundation
import CoreData


extension NSManagedObjectContext {
    
    func saveThrows() -> Result<Void, Error> {
        if self.hasChanges{
            do {
                try save()
                return .success(())
            } catch {
                //добавить обработку ошибок
                let nserror = error as NSError
                print(nserror.localizedDescription)
                return .failure(nserror)
            }
        }
        return .failure(NSError())
    }
}
