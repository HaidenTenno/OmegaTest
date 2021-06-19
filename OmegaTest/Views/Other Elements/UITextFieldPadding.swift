//
//  UITextFieldPadding.swift
//  timeSheetApp
//
//  Created by Петр Тартынских on 06.04.2020.
//  Copyright © 2020 Петр Тартынских. All rights reserved.
//

import UIKit

class UITextFieldPadding : UITextField {
    
    private var padding: UIEdgeInsets!
    
    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
