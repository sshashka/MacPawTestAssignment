protocol MainScreenViewPresenterProtocol: AnyObject {
    func show()
}

protocol MainScreenPresenterProtocol: AnyObject {
    init (view: MainScreenViewPresenterProtocol, dataManager: DataManagerProtocol, router: RouterProtocol)
    var data: [PersonnelLosses]? {get set}
    func getData()
    func tapOnDay(selectedDay: Int)
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    var data: [PersonnelLosses]?
    weak var view: MainScreenViewPresenterProtocol?
    let dataManager: DataManagerProtocol!
    var router: RouterProtocol?
    
    required init(view: MainScreenViewPresenterProtocol, dataManager: DataManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.dataManager = dataManager
        self.router = router
        getData()
    }
    
    func getData() {
        data = dataManager.getPersonnelLosses()
        view?.show()
    }
    
    func tapOnDay(selectedDay: Int) {
        router?.detailsViewController(selectedDay: selectedDay)
    }
}
