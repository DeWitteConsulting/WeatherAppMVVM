
struct Current: Decodable {
    let tempC: Double
    let tempF: Double
    let condition: Condition
    let humidity: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case condition, humidity, uv
        case tempC = "temp_c"
        case tempF = "temp_f"
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
    }
}
