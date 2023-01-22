//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Karath on 1/22/23.
//

import SwiftUI

let basicFontSize: CGFloat = UIScreen.main.bounds.width/18
let largeFontSize: CGFloat = UIScreen.main.bounds.width/12
let ultraLargeFontSize: CGFloat = UIScreen.main.bounds.width/6

struct ContentView: View {
    
    let days: [String] = ["TUE", "WED", "THU", "FRI", "SAT"]
    let temperatures: [Int] = [3, -2, -8, -14, -9]
    let symbols: [String] = ["wind", "snowflake", "snowflake", "thermometer.snowflake", "cloud.fill"]
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 4) {
                Text("Stockholm")
                    .frame(width: UIScreen.main.bounds.width-64, height: 50, alignment: .center)
                    .font(.system(size: largeFontSize, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(.top, 32)
                Image(systemName: "cloud.sun.fill")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width*0.40, height: UIScreen.main.bounds.width*0.40)
                    .padding(.top, 4)
                Text("2°")
                    .frame(width: UIScreen.main.bounds.width-64, height: 50, alignment: .center)
                    .font(.system(size: ultraLargeFontSize, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(.top, 32)
                ForecastDayView(days: days, temperatures: temperatures, symbols: symbols)
                Spacer()
                
                Button {
                    print("tapped")
                } label: {
                    Text("Change day time")
                        .frame(width: UIScreen.main.bounds.width-64, height: (UIScreen.main.bounds.width-64)/6)
                        .font(.system(size: basicFontSize, weight: .bold, design: .default))
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.bottom, 16)
                }
                
            }
            
        }
    }
    
    private func setupDaysOfWeek() {
        
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
                        .font(.system(size: basicFontSize, weight: .regular, design: .default))
                        .frame(width: UIScreen.main.bounds.width*0.16, height: UIScreen.main.bounds.width*0.16, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top, 2)
                    Image(systemName: symbols[index])
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width*0.12, height: UIScreen.main.bounds.width*0.12)
                        .padding(.top, 4)
                    Text("\(temperatures[index])°")
                        .font(.system(size: basicFontSize, weight: .regular, design: .default))
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
    let backgroundDarkBlue: Color = Color(red: 48/255, green: 70/255, blue: 140/220)
    let backgroundLightBlue: Color = Color(red: 157/255, green: 202/255, blue: 240/220)
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [backgroundDarkBlue, backgroundLightBlue]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}
