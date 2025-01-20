
import SwiftUI

private enum Constants {
    static let fontSize: CGFloat = 50
    static let imageHeight: CGFloat = 120
    static let backgroundOpacity: CGFloat = 0.2
    static let backgroundRadius: CGFloat = 15
}

// MARK: - Weather Search Card View

struct WeatherSearchCardView: View {
    let weather: Weather
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(weather.location.name)
                    .font(.title2)
                    .bold()
                
                Text("(\(weather.location.country))")
                    .font(.caption)
                
                Text("\(Int(weather.current.tempC))°")
                    .font(.system(size: Constants.fontSize))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            CacheAsyncImage(url: weather.current.condition.icon)
                .frame(height: Constants.imageHeight)
        }
        .padding(.horizontal)
        .background(
            .gray.opacity(Constants.backgroundOpacity),
            in: .rect(cornerRadius: Constants.backgroundRadius)
        )
    }
}
