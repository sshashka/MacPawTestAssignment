import Foundation

struct PersonnelLosses: Codable {
    let date: String
    let day, personnel: Int
    let pow: Int

    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case pow = "POW"
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

extension PersonnelLosses {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date) ?? "No data"
        day = try values.decode(Int.self, forKey: .day)
        personnel = try values.decodeIfPresent(Int.self, forKey: .personnel)  ?? 0
        pow = try values.decodeIfPresent(Int.self, forKey: .pow)  ?? 0
    }
}
