
import UIKit


final class AppCoordinator: BaseCoordirator {
    
    // MARK: - Properties
    private let window: UIWindow
    private let navController: UINavigationController
    
    private let appRepository: OperationsRepository
    
    
    // MARK: - Init
     init(window: UIWindow, navController: UINavigationController, appRepository: OperationsRepository) {
        self.window = window
        self.navController = navController
        self.appRepository = appRepository
        
        
    }
    
    
    //MARK: - Open metods
    override func start() {
        window.rootViewController = navController
        navController.isNavigationBarHidden = true
        window.makeKeyAndVisible()
        parentCoordinator = nil
        //TODO: --------------- в зависимости от наличия токена открывается экран
        showMain()
    }
    
    
    // MARK: - Navigation
    private func showMain() {
        let mainCoordinator = MainCoordinator(navController: navController, repo: appRepository)
        childCoordinators.append(mainCoordinator)
        //mainCoordinator.parentCoordinator = self
        mainCoordinator.start()
    }
    
    private func showSignIn() {
        let signInCoordinator = SignInCoordinator(navController: navController, repo: appRepository)
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


