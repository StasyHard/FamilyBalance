
import UIKit
import CoreData


class OperationsCoreDataManager: NSObject {
    
    private var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private var operationsFRC: NSFetchedResultsController<Operation>? {
        didSet {
            operationsFRC?.delegate = self
        }
    }
    
    private var getOperationsCompletion: ((NSFetchedResultsController<Operation>) -> Void)?
    
    
    //MARK: - Open metods
    func setDefoltData() {
    
        guard let context = container?.viewContext
            else { return }
        
        createDefoltData(context: context)
        let result = context.saveThrows()
        
        switch result {
        case .success():
            break
        case .failure(let error):
            print(error)
            fatalError("No default data was saved in the database")
        }
    }
    
    func getOperationsFRC(completion: @escaping (NSFetchedResultsController<Operation>) -> Void)
    {
        self.getOperationsCompletion = completion
        
        if operationsFRC == nil {
            let sortDesc = NSSortDescriptor(key: "date", ascending: false)
            
            let controller = createFRC(
                entityName: Operation.className,
                sortDesc: [sortDesc]
            )
            operationsFRC = controller as? NSFetchedResultsController<Operation>
        }
        getOperationsCompletion!(operationsFRC!)
    }
    
    func getCategories(completion: @escaping ([Category]) -> Void) {
        let data: [Category] = getData(entityName: Category.className)
        completion(data)
    }
    
    func getAccounts(completion: @escaping ([Account]) -> Void) {
        let data: [Account] = getData(entityName: Account.className)
        completion(data)
    }
    
    //добавить ообработку ошибок
    func saveOperation(_ operation: OperationModel, completion: @escaping ((Result<Void, Error>) -> Void))
    {
        guard let context = container?.viewContext
            else { return }
        
        let newOperation = Operation(context: context)
        newOperation.sum = operation.sum
        newOperation.date = operation.date
        
        if let updateAccount = self.getAccount(byTitle: operation.account.title) {
            updateAccount.addToOperations(newOperation)
        }
        if let category = operation.category,
            let updateCategory = self.getCategory(byTitle: category.title) {
            updateCategory.addToOperations(newOperation)
        }
        
        let result = context.saveThrows()
        
        switch result {
        case .success():
            completion(.success(()))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    
    //MARK: - Private metods
    private func createDefoltData(context: NSManagedObjectContext) {
        let cash = Account(context: context)
        cash.title = "Наличные"
        let card = Account(context: context)
        card.title = "Карта"
        
        let products = Category(context: context)
        products.title = "Продукты питания"
        let cafe = Category(context: context)
        cafe.title = "Кафе и рестораны"
        let entertainment = Category(context: context)
        entertainment.title = "Развлечения"
        let phone = Category(context: context)
        phone.title = "Телефон"
        let transport = Category(context: context)
        transport.title = "Авто и транспорт"
        let housing = Category(context: context)
        housing.title = "Жилье"
        let clothes = Category(context: context)
        clothes.title = "Одежда и обувь"
        let gadgets = Category(context: context)
        gadgets.title = "Гаджеты"
        let forceMajeure = Category(context: context)
        forceMajeure.title = "Форсмажор"
        let hasty = Category(context: context)
        hasty.title = "Необдуманные траты"
        let remain = Category(context: context)
        remain.title = "Остальное"
    }
    
    private func createFRC(entityName: String, sortDesc: [NSSortDescriptor])
        -> NSFetchedResultsController<NSFetchRequestResult> {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Operation.className)
            request.sortDescriptors = sortDesc
            let controller = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: container!.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            
            do {
                try controller.performFetch()
            } catch {
                print("Fetch failed")
            }
            return controller
    }
    
    private func getData<T>(entityName: String,
                            predicate: NSPredicate? = nil,
                            sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            if let response = try container?.viewContext.fetch(request) as? [T] {
                return response
            }
            else { return [T]() }
        } catch {
            return [T]()
        }
    }
    
    private func getAccount(byTitle title: String) -> Account? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Account.className)
        request.predicate = NSPredicate(format: "title = %@", title)
        do {
            if let result = try container?.viewContext.fetch(request) as? [Account] {
                return result.first
            }
            else { return nil }
        } catch {
            return nil
        }
    }
    
    private func getCategory(byTitle title: String) -> Category? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Category.className)
        request.predicate = NSPredicate(format: "title = %@", title)
        do {
            if let result = try container?.viewContext.fetch(request) as? [Category] {
                return result[0]
            }
            else { return nil }
        } catch {
            return nil
        }
    }
}


extension OperationsCoreDataManager: NSFetchedResultsControllerDelegate {
        
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            getOperationsCompletion!(operationsFRC!)
    }
}


//Удалить все из бд
//let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Operation.className)
//let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//do {
//    try container?.viewContext.execute(deleteRequest)
//    try container?.viewContext.save()
//}
//catch {
//    print ("There was an error")
//}
