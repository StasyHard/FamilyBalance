
import UIKit

//Базовый координатор от которого наследуются все координаторы
class BaseCoordirator: Coordinator {
    
    weak var parentCoordinator: BaseCoordirator?
    var childCoordinators: [BaseCoordirator] = []
    
    func start() {
        print("Will be redefined in childrens")
    }
}



extension BaseCoordirator {
    
    func didFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
    
    func findHandler<T>() -> T? {
        guard let parent = parentCoordinator else {
            return nil
        }
        
        var currentParent: Coordinator? = parent
        var found: T? = nil
        
        while true {
            guard let current = currentParent else {
                return nil
            }
            
            if(current is T) {
                found = current as? T
                break
            } else {
                currentParent = current.parentCoordinator
            }
        }
        return found
    }
    
    func findListener<T>(parent: Coordinator?) -> T? {
        guard let parent = parent
            else { return nil }
        
        if parent is T {
            let listener = parent as! T
            return listener
        }
        else {
            let parent = parent.parentCoordinator
            return findListener(parent: parent)
        }
    }
}

