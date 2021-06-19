//
//  Design.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 18.06.2021.
//

import UIKit

enum Design {
    
    enum Colors {
        static let background = #colorLiteral(red: 0.4941176471, green: 0.737254902, blue: 0.3490196078, alpha: 1)
        static let fieldBackground = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        static let fieldBorderAndText = #colorLiteral(red: 0.2, green: 0.2117647059, blue: 0.231372549, alpha: 1)
        static let fieldPlaceholder = #colorLiteral(red: 0.2, green: 0.2117647059, blue: 0.231372549, alpha: 0.6522099743)
        static let applyButtonBackground = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        static let applyButtonBorder = #colorLiteral(red: 0.2, green: 0.2117647059, blue: 0.231372549, alpha: 1)
    }
    
    enum ImageNames {
        
    }
    
    enum Fonts {
        enum BigHeader {
            static let font = UIFont.boldSystemFont(ofSize: 30)
            static let color = #colorLiteral(red: 0.2, green: 0.2117647059, blue: 0.231372549, alpha: 1)
        }
        enum MiniHeader {
            static let font = UIFont.boldSystemFont(ofSize: 20)
            static let color = #colorLiteral(red: 0.2, green: 0.2117647059, blue: 0.231372549, alpha: 1)
        }
        enum RegularText {
            static let font = UIFont.systemFont(ofSize: 20)
            static let color = #colorLiteral(red: 0.2, green: 0.2117647059, blue: 0.231372549, alpha: 1)
        }
    }
}
