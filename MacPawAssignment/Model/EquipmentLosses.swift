import Foundation

struct EquipmentLosses: Codable {
    var date: String
    var day, aircraft, helicopter, tank, APC, fieldArtillery, MRL, militaryAuto, fuelTank, drone, navalShip, antiAircraftWarfare, specialEquipment, mobileSRBMSystem, vehiclesAndFuelTanks, cruiseMissiles: Int
    var greatestLossesDirection: String
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case day = "day"
        case aircraft = "aircraft"
        case helicopter = "helicopter"
        case tank = "tank"
        case APC = "APC"
        case fieldArtillery = "field artillery"
        case MRL = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone = "drone"
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
        case greatestLossesDirection = "greatest losses direction"
    }
    
    
    /// Returns result as dictionary
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
        }).compactMap { $0 })
        return dict
    }
}
// MARK: - extension to EquipmentLosses
extension EquipmentLosses {
    // MARK: I used container, because if I used optionals I would have to spend some "great" time unwrapping them
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try values.decodeIfPresent(String.self, forKey: .date) ?? "No data"
        day = try values.decodeIfPresent(Int.self, forKey: .day) ?? 0
        aircraft = try values.decode(Int.self, forKey: .aircraft)
        helicopter = try values.decodeIfPresent(Int.self, forKey: .helicopter)  ?? 0
        tank = try values.decodeIfPresent(Int.self, forKey: .tank)  ?? 0
        APC = try values.decodeIfPresent(Int.self, forKey: .APC)  ?? 0
        fieldArtillery = try values.decodeIfPresent(Int.self, forKey: .fieldArtillery)  ?? 0
        MRL = try values.decodeIfPresent(Int.self, forKey: .MRL)  ?? 0
        militaryAuto = try values.decodeIfPresent(Int.self, forKey: .militaryAuto)  ?? 0
        fuelTank = try values.decodeIfPresent(Int.self, forKey: .fuelTank)  ?? 0
        drone = try values.decodeIfPresent(Int.self, forKey: .drone)  ?? 0
        navalShip = try values.decodeIfPresent(Int.self, forKey: .navalShip)  ?? 0
        antiAircraftWarfare = try values.decodeIfPresent(Int.self, forKey: .antiAircraftWarfare)  ?? 0
        specialEquipment = try values.decodeIfPresent(Int.self, forKey: .specialEquipment)  ?? 0
        mobileSRBMSystem = try values.decodeIfPresent(Int.self, forKey: .mobileSRBMSystem)  ?? 0
        vehiclesAndFuelTanks = try values.decodeIfPresent(Int.self, forKey: .vehiclesAndFuelTanks)  ?? 0
        cruiseMissiles = try values.decodeIfPresent(Int.self, forKey: .cruiseMissiles)  ?? 0
        greatestLossesDirection = try values.decodeIfPresent(String.self, forKey: .greatestLossesDirection)  ?? "No data"
        
    }
}
