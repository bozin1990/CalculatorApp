//
//  UINavigationController+Ext.swift
//  CalculatorApp
//
//  Created by 陳博軒 on 2020/9/22.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

extension UINavigationController {
//    控制想要的視圖控制器使用想要的狀態列樣式
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
