
import Foundation

//Общий протокол для всех координаторов
protocol Coordinator: AnyObject {
    var parentCoordinator: BaseCoordirator? { get set }
    var childCoordinators: [BaseCoordirator] { get set }
    func start()
}

protocol SignInListener {
    func didSignIn()
}
