
import SwiftUI

private enum Constants {
    static let mainSpacing: CGFloat = 15
    static let imageHeight: CGFloat = 150
    static let fontSize: CGFloat = 70
    static let verticalPadding: CGFloat = 20
    static let locationIcon: String = "location.fill"
}

// MARK: - City Weather Content View

struct CityWeatherContent: View {
    private let weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    var body: some View {
        VStack(spacing: Constants.mainSpacing) {
            CacheAsyncImage(url: weather.current.condition.icon)
                .frame(height: Constants.imageHeight)
            
            Label(weather.location.name, systemImage: Constants.locationIcon)
                .labelStyle(.titleWithIcon)
            
            let temperature = "\(Int(weather.current.tempC))°"
            
            Text(temperature)
                .font(.system(size: Constants.fontSize))
            
            WeatherInfoCard(weather: weather.current)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.vertical, Constants.verticalPadding)
    }
}
