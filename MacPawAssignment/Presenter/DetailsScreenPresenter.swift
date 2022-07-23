import Foundation

protocol DetailsScreenViewProtocol: AnyObject {
    func show()
}

protocol DetailsScreenPresenterProtocol: AnyObject {
    init (view: DetailsScreenViewProtocol, dataManager: DataManagerProtocol, selectedDay: Int, router: RouterProtocol)
    var data: [String]? {get set}
    func getData(with index: Int)
}

class DetailsScreenPresenter: DetailsScreenPresenterProtocol {
    
    var data: [String]?
    var selectedDay: Int?
    weak var view: DetailsScreenViewProtocol?
    let dataManager: DataManagerProtocol!
    var router: RouterProtocol?
    
    required init(view: DetailsScreenViewProtocol, dataManager: DataManagerProtocol, selectedDay: Int, router: RouterProtocol) {
        self.dataManager = dataManager
        self.view = view
        self.selectedDay = selectedDay
        self.router = router
    }
    
    func getData(with index: Int) {
        switch index {
        case 0:
            let model = DataManager().getPersonnelLosses()?[selectedDay ?? 0].asDictionary
            data = model?.keys.map{ "\($0) : \(model![$0]!)" }
        case 1:
            let model = DataManager().getEquipmentLosses()?[selectedDay ?? 0].asDictionary
            data = model?.keys.map{ "\($0) : \(model![$0]!)"}
        default:
            break
        }
        view?.show()
    }
}

