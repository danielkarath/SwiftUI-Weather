//
//  WeatherButton.swift
//  SwiftUI-Weather
//
//  Created by Daniel Karath on 1/27/23.
//

import Foundation
import SwiftUI

struct WeatherButton: View {
    var title: String
    var backgroundColor: Color
    var textColor: Color
    var body: some View {
        Button {
            print("tapped")
        } label: {
            Text("Change day time")
                .frame(width: UIScreen.main.bounds.width-64, height: (UIScreen.main.bounds.width-64)/6)
                .font(.system(size: MyConstants.shared.basicFontSize, weight: .bold, design: .default))
                .foregroundColor(textColor)
                .background(backgroundColor)
                .cornerRadius(8)
                .padding(.bottom, 16)
        }
    }
}
