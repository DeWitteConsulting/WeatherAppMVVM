
import SwiftUI

private enum Constants {
    static let backgroundOpacity: CGFloat = 0.2
    static let backgroundRadius: CGFloat = 15
    static let horizontalPadding: CGFloat = 20
}

// MARK: - Weather Info Card View

struct WeatherInfoCard: View {
    private let weather: Current
    
    init(weather: Current) {
        self.weather = weather
    }
    
    // MARK: - Main View
    
    var body: some View {
        HStack {
            weatherInfoItem(title: "Humidity", value: "\(weather.humidity)%")
            weatherInfoItem(title: "UV Index", value: "\(weather.uv)")
            weatherInfoItem(title: "Feels Like", value: "\(Int(weather.feelslikeC))°")
        }
        .padding()
        .background(
            .gray.opacity(Constants.backgroundOpacity),
            in: .rect(cornerRadius: Constants.backgroundRadius)
        )
        .padding(.horizontal, Constants.horizontalPadding)
    }
    
    // MARK: - UI Components
    
    private func weatherInfoItem(title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(.headline)
            
            Text(value)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
    }
}
