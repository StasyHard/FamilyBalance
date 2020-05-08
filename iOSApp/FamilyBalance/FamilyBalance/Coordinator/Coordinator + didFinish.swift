
import Foundation

extension Coordinator {
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
}

