import UIKit

protocol BuilderProtocol: AnyObject {
    func createMainScreen(router: RouterProtocol) -> UIViewController
    func createDetailsScreen(selectedDay: Int, router: RouterProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
    
    /// Function that builds main screen
    /// - Returns: ViewController
    func createMainScreen(router: RouterProtocol) -> UIViewController {
        let view = MainScreen()
        let dataManager = DataManager()
        let presenter = MainScreenPresenter(view: view, dataManager: dataManager, router: router)
        view.presenter = presenter
        return view
    }
    
    /// Function that build details screen
    /// - Parameters:
    ///   - selectedDay: property that says which day info to show
    ///   - router: router
    /// - Returns: ViewController
    func createDetailsScreen(selectedDay: Int, router: RouterProtocol) -> UIViewController {
        let view = DetailsView()
        let dataManager = DataManager()
        let presenter = DetailsScreenPresenter(view: view, dataManager: dataManager, selectedDay: selectedDay, router: router)
        view.presenter = presenter
        return view
    }
}
