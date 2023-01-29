//
//  MyConstants.swift
//  SwiftUI-Weather
//
//  Created by Daniel Karath on 1/27/23.
//

import Foundation
import SwiftUI

final class MyConstants {
    
    static let shared = MyConstants()
    
    let basicFontSize: CGFloat = UIScreen.main.bounds.width/18
    let largeFontSize: CGFloat = UIScreen.main.bounds.width/12
    let ultraLargeFontSize: CGFloat = UIScreen.main.bounds.width/6
    
    let backgroundDarkBlue: Color = Color(red: 48/255, green: 70/255, blue: 140/220)
    let backgroundLightBlue: Color = Color(red: 157/255, green: 202/255, blue: 240/220)
    let backgroundNightDarkBlue: Color = Color(red: 8/255, green: 30/255, blue: 100/220)
    let backgroundNightLightBlue: Color = Color(red: 77/255, green: 122/255, blue: 170/220)
}
