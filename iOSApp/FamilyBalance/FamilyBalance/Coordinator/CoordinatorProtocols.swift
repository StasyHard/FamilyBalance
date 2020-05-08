
import Foundation

//Общий протокол для всех координаторов
protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

protocol SignInListener {
    func didSignIn()
}
