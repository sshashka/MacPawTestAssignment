import Foundation

protocol DataManagerProtocol: AnyObject {
    func getEquipmentLosses() -> [EquipmentLosses]?
    func getPersonnelLosses() -> [PersonnelLosses]?
}

final class DataManager : DataManagerProtocol {
    
    func getEquipmentLosses() -> [EquipmentLosses]? {
        if let path = Bundle.main.url(forResource: "russia_losses_equipment", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let result = try JSONDecoder().decode([EquipmentLosses].self, from: data)
                return result
            } catch {
                print("error \(error)")
            }
        }
        return nil
    }
    
    func getPersonnelLosses() -> [PersonnelLosses]? {
        if let path = Bundle.main.url(forResource: "russia_losses_personnel", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let result = try JSONDecoder().decode([PersonnelLosses].self, from: data)
                return result
            } catch {
                print("error \(error)")
            }
        }
        return nil
    }
}
