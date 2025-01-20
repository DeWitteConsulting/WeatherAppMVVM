
import Foundation

struct Weather: Decodable, Identifiable {
    let location: Location
    let current: Current
    
    var id: String {
        "\(location.lat),\(location.lon)"
    }
}
