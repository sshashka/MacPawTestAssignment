import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController? {get set}
    var builder: BuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMainProtocol {
    func mainViewController()
    func detailsViewController(selectedDay: Int)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func mainViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.createMainScreen(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func detailsViewController(selectedDay: Int) {
        if let navigationController = navigationController {
            guard let detailsViewController = builder?.createDetailsScreen(selectedDay: selectedDay, router: self) else { return }
            navigationController.pushViewController(detailsViewController, animated: true)
        }
    }
}
