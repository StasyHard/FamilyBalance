
import UIKit

final class AppCoordinator: Coordinator {
    
    
    // MARK: - Properties
    private let window: UIWindow
    private let navController: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    // MARK: - Init
    init(navController: UINavigationController, window: UIWindow) {
        self.navController = navController
        self.window = window
    }
    
    //MARK: - Open metods
    func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()
        parentCoordinator = nil
        //TODO: --------------- в зависимости от наличия токена открывается экран
        showSignIn()
    }
    
    // MARK: - Navigation
    private func showMain() {
        let mainCoordinator = MainCoordinator(navController: navController)
        childCoordinators.append(mainCoordinator)
        //mainCoordinator.parentCoordinator = self
        mainCoordinator.start()
    }
    
    private func showSignIn() {
        let signInCoordinator = SignInCoordinator(navController: navController)
        childCoordinators.append(signInCoordinator)
        signInCoordinator.parentCoordinator = self
        signInCoordinator.start()
    }
}

//MARK: - SignInListener protocol
extension AppCoordinator: SignInListener {
    func didSignIn() {
        showMain()
    }
    
    
}


