//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Karath on 1/22/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    @State private var temperature: String = "Loading..."
    
    let days: [String] = ["TUE", "WED", "THU", "FRI", "SAT"]
    let temperatures: [Int] = [3, -2, -8, -14, -9]
    let symbols: [String] = ["wind", "snowflake", "snowflake", "thermometer.snowflake", "cloud.fill"]
        
    var body: some View {
        ZStack {
            BackgroundView(backgroundDarkBlue: MyConstants.shared.backgroundDarkBlue, backgroundLightBlue: MyConstants.shared.backgroundLightBlue, backgroundNightDarkBlue: MyConstants.shared.backgroundNightDarkBlue, backgroundNightLightBlue: MyConstants.shared.backgroundNightLightBlue, isNightMode: isNight)
            VStack(spacing: 4) {
                CityTextView(cityName: "Stockholm")
                MainWeatherStatusView(imageName: isNight ? "cloud.sun.fill" : "cloud.moon.fill", temperature: temperature)
                ForecastDayView(days: days, temperatures: temperatures, symbols: symbols)
                Spacer()
                //WeatherButton(title: "Change day time", backgroundColor: .white, textColor: .blue)
                Button {
                    print("tapped button to toggle apperance ")
                    //@Environment(\.colorScheme) var colorScheme
                    isNight.toggle()
                } label: {
                    Text("Change day time")
                        .frame(width: UIScreen.main.bounds.width-64, height: (UIScreen.main.bounds.width-64)/6)
                        .font(.system(size: MyConstants.shared.basicFontSize, weight: .bold, design: .default))
                        .foregroundColor(.blue)
                        .background(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 16)
                }
                
            }
            
        }.onAppear {
            fetchTemperature()
        }
    }
    
    func fetchTemperature() {
        print("fetchTemperature 1")
            let API_KEY = INSERT API KEY HERE
            let city = "Stockholm"
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API_KEY)&units=metric")!
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    print("fetchTemperature 2")
                    let weather = try? JSONDecoder().decode(WeatherData.self, from: data)
                    if let weather = weather {
                        print("fetchTemperature 3")
                        let temperature = Int(floor(weather.main.temp))
                        DispatchQueue.main.async {
                            self.temperature = "\(temperature)°C"
                            print("temperature: \(self.temperature)")
                        }
                    } else {
                        print("Failed to decode weather data.")
                    }
                }
            }.resume()
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ForecastDayView: View {
    var days: [String]
    var temperatures: [Int]
    var symbols: [String]
    var body: some View {
        HStack(alignment: .center) {
            ForEach(0..<days.count, id: \.self) { index in
                VStack(spacing: 2) {
                    Text(days[index])
                        .font(.system(size: MyConstants.shared.basicFontSize, weight: .regular, design: .default))
                        .frame(width: UIScreen.main.bounds.width*0.16, height: UIScreen.main.bounds.width*0.16, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top, 2)
                    Image(systemName: symbols[index])
                        .symbolRenderingMode(.palette)
                        .resizable()
                        .foregroundStyle(.white, .cyan, .gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width*0.12, height: UIScreen.main.bounds.width*0.12)
                        .padding(.top, 4)
                    Text("\(temperatures[index])°")
                        .font(.system(size: MyConstants.shared.basicFontSize, weight: .regular, design: .default))
                        .frame(width: UIScreen.main.bounds.width*0.16, height: UIScreen.main.bounds.width*0.16, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top, 8)
                }
            }
            .padding(.top, 45)
        }
    }
}

struct BackgroundView: View {
    let backgroundDarkBlue: Color
    let backgroundLightBlue: Color
    let backgroundNightDarkBlue: Color
    let backgroundNightLightBlue: Color
    var isNightMode: Bool
    
    //@Environment(\.colorScheme) var colorScheme

    var body: some View {
        LinearGradient(gradient: Gradient(colors: isNightMode ? [backgroundDarkBlue, backgroundLightBlue] : [backgroundNightDarkBlue, backgroundNightLightBlue]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CityTextView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .frame(width: UIScreen.main.bounds.width-64, height: 50, alignment: .center)
            .font(.system(size: MyConstants.shared.largeFontSize, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding(.top, 32)
    }
}

struct MainWeatherStatusView: View {
    var imageName: String
    var temperature: String
    
    var body: some View {
        Image(systemName: imageName)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width*0.40, height: UIScreen.main.bounds.width*0.40)
            .padding(.top, 4)
        Text("\(temperature)")
            .frame(width: UIScreen.main.bounds.width-64, height: 50, alignment: .center)
            .font(.system(size: MyConstants.shared.ultraLargeFontSize, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding(.top, 32)
    }
}

struct WeatherData: Codable {
    
    struct Main: Codable {
        let temp: Double
    }
    let main: Main
}
