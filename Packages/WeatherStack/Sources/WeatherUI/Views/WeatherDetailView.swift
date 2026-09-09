import SwiftUI
import WeatherCore

public struct WeatherDetailView: View {
    public let query: LocationQuery
    public let cityName: String
    @State var vm: WeatherViewModel

    public init(query: LocationQuery, cityName: String, repository: WeatherRepository) {
        self.query = query
        self.cityName = cityName
        _vm = State(initialValue: WeatherViewModel(repository: repository))
    }
    
    private var palette: WeatherPalette {
            guard let weather = vm.weather else {
                return .clearDay
            }
            return WeatherPalette.forCondition(
                code: weather.current.condition.code,
                isDay: weather.current.isDay
            )
        }
        
        public var body: some View {
            ZStack {
                WeatherBackdrop(palette: palette)
                
                if let weather = vm.weather {
                    WeatherScene(
                        kind: weather.current.scene,
                        isDay: weather.current.isDay
                    )
                    .transition(.opacity)
                }
                
                ScrollView {
                    VStack(spacing: 24) {
                        if vm.isLoading {
                            ProgressView()
                                .tint(.white)
                                .padding(.top, 120)
                        } else if let error = vm.errorMessage {
                            errorView(error)
                        } else if let weather = vm.weather {
                            heroSection(weather)
                            statGrid(weather)
                            forecastSection(weather)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 40)
                }
                .scrollIndicators(.hidden)
            }
            .animation(.easeInOut(duration: 0.5), value: vm.weather?.current.condition.code)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationTitle(cityName)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await vm.loadWeather(for: query)
            }
            .refreshable {
                await vm.loadWeather(for: query)
            }
        }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.white.opacity(0.85))
                    
                    Text("Couldn't load weather")
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text(message)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.75))
                        .multilineTextAlignment(.center)
                    
                    Button {
                        Task { await vm.loadWeather(for: query) }
                    } label: {
                        Text("Try Again")
                            .font(.subheadline.weight(.semibold))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(.white.opacity(0.2), in: Capsule())
                            .foregroundStyle(.white)
                            .overlay {
                                Capsule().strokeBorder(.white.opacity(0.3), lineWidth: 0.5)
                            }
                    }
                    .padding(.top, 4)
                }
                .padding(.top, 120)
                .padding(.horizontal, 24)
            }
    
    private func heroSection(_ weather: Weather) -> some View {
            VStack(spacing: 6) {
                Text(weather.location.name)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(.white)
                
                Text(weather.location.country)
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.78))
                
                Text("\(Int(weather.current.tempC.rounded()))°")
                    .font(.system(size: 96, weight: .thin, design: .default))
                    .foregroundStyle(.white)
                    .padding(.top, 8)
                
                Text(weather.current.condition.text)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.white)
                
                if let forecast = weather.forecast?.forecastdays.first {
                    Text("H: \(Int(forecast.day.maxtempC.rounded()))°   L: \(Int(forecast.day.mintempC.rounded()))°")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.78))
                        .padding(.top, 2)
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 24)
            .shadow(color: .black.opacity(0.18), radius: 8, y: 2)
        }
    
    private func statGrid(_ weather: Weather) -> some View {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 10),
                GridItem(.flexible(), spacing: 10)
            ], spacing: 10) {
                WeatherStatCard(
                    icon: "thermometer.medium",
                    label: "Feels Like",
                    value: "\(Int(weather.current.feelslikeC.rounded()))°"
                )
                WeatherStatCard(
                    icon: "humidity.fill",
                    label: "Humidity",
                    value: "\(weather.current.humidity)%"
                )
                WeatherStatCard(
                    icon: "wind",
                    label: "Wind",
                    value: "\(Int(weather.current.windKph)) km/h"
                )
                WeatherStatCard(
                    icon: "sun.max.fill",
                    label: "UV Index",
                    value: "\(Int(weather.current.uv))"
                )
            }
        }
        
    
    @ViewBuilder
    private func forecastSection(_ weather: Weather) -> some View {
        if let forecast = weather.forecast {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .font(.caption)
                    Text("3-DAY FORECAST")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .tracking(0.5)
                }
                .foregroundStyle(.white.opacity(0.75))
                .padding(.horizontal, 4)
                
                VStack(spacing: 0) {
                    ForEach(Array(forecast.forecastdays.enumerated()), id: \.element.id) { index, day in
                        ForecastView(day: day)
                        if index < forecast.forecastdays.count - 1 {
                            Divider()
                                .overlay(Color.white.opacity(0.12))
                                .padding(.leading, 16)
                        }
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .strokeBorder(.white.opacity(0.18), lineWidth: 0.5)
                        }
                }
                .environment(\.colorScheme, .dark)
            }
        }
    }
}

struct MetricView: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.tint)
            
            Text(value)
                .font(.headline)
            
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

struct ForecastView: View {
    let day: ForecastDay
    
    var body: some View {
        HStack(spacing: 12) {
            Text(day.date)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 110, alignment: .leading)
            
            AsyncImage(url: day.day.condition.iconURL) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Color.clear
            }
            .frame(width: 32, height: 32)
            
            Spacer()
            
            Text("\(Int(day.day.mintempC.rounded()))°")
                .foregroundStyle(.white.opacity(0.65))
                .font(.system(size: 15))
            
            Text("\(Int(day.day.maxtempC.rounded()))°")
                .foregroundStyle(.white)
                .font(.system(size: 15, weight: .medium))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}
