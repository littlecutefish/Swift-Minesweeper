//
//  ColorExtension.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/4.
//

import Foundation
import SwiftUI

/// 馬卡龍配色主題
struct MacaronColorTheme {
    // 基礎馬卡龍色系
    let mint = Color(hex: "#9AEADC")       // 薄荷綠
    let lavender = Color(hex: "#CBC0D3")   // 薰衣草紫
    let peach = Color(hex: "#FFD7BA")      // 蜜桃色
    let lemon = Color(hex: "#FEEAA1")      // 檸檬黃
    let rose = Color(hex: "#F6BDC0")       // 玫瑰粉
    let skyBlue = Color(hex: "#A1DDFF")    // 天空藍
    let pistachio = Color(hex: "#D8E4B2")  // 開心果綠
    
    // 深色調版本（適用於按鈕、強調等）
    let deepMint = Color(hex: "#5ECDB6")     // 深薄荷綠
    let deepLavender = Color(hex: "#9C8AA5") // 深薰衣草紫
    let deepPeach = Color(hex: "#FFC199")    // 深蜜桃色
    let deepLemon = Color(hex: "#EDD87C")    // 深檸檬黃
    let deepRose = Color(hex: "#EF9EA3")     // 深玫瑰粉
    let deepSkyBlue = Color(hex: "#74BDEC")  // 深天空藍
    let deepPistachio = Color(hex: "#B7C66E") // 深開心果綠
    
    // 遊戲相關顏色
    let boardBackground = Color(hex: "#EFEFEF") // 棋盤背景色
    let cellBackground = Color(hex: "#E1E1E1")  // 棋盤單元格背景色
    let cellBorder = Color(hex: "#A0A0A0")      // 棋盤單元格邊框色
    
    // 掃雷數字顏色（基於馬卡龍風格的調整）
    let number1 = Color(hex: "#5D84B5") // 柔和的藍色
    let number2 = Color(hex: "#6CAA7F") // 柔和的綠色
    let number3 = Color(hex: "#D7816A") // 柔和的紅色
    let number4 = Color(hex: "#8471BD") // 柔和的紫色
    let number5 = Color(hex: "#E6A639") // 柔和的橙色
    let number6 = Color(hex: "#4AABC5") // 柔和的青色
    let number7 = Color(hex: "#383838") // 柔和的黑色
    let number8 = Color(hex: "#737373") // 柔和的灰色
    
    // 狀態顏色
    let success = Color(hex: "#A5D6A7") // 馬卡龍風格的成功綠色
    let warning = Color(hex: "#FFE082") // 馬卡龍風格的警告黃色
    let danger = Color(hex: "#EF9A9A")  // 馬卡龍風格的危險紅色
}

/// 擴展 Color 類別，增加馬卡龍配色主題和 Hex 色碼初始化功能
extension Color {
    static let macaron = MacaronColorTheme()
    
    /// 使用 Hex 色碼初始化顏色
    /// - Parameter hex: 色碼字串（支援 3、6 或 8 位格式）
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // 短格式，例如 "#RGB"
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // 常見格式，例如 "#RRGGBB"
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // 包含透明度的格式，例如 "#AARRGGBB"
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0) // 預設為透明黑色
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
