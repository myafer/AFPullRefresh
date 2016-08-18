//
//  UIScrollView+AFPullRefresh.swift
//  AFPullRefresh
//
//  Created by 口贷网 on 16/4/13.
//  Copyright © 2016年 Afer. All rights reserved.
//

import UIKit

extension NSObject {
    
    static func exchangeInstance(method1: Selector, method2: Selector) {
        method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2))
    }
    
    static func exchangeClassMethod(method1: Selector, method2: Selector) {
        method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2))
    }

}


extension UIScrollView {
    
    private struct AssociatedKeys {
        static var Af_header = "af_header"
    }
    
    var af_header: AFBaseRefreshHeader? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.Af_header) as? AFBaseRefreshHeader
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.Af_header,
                    newValue,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    func addRefreshHeaderWithHandle(handle: dispatch_block_t) {
        let header = AFBaseRefreshHeader.init(frame: CGRectMake(0, -60, UIScreen.mainScreen().bounds.size.width, 60))
        header.handle = handle
        self.af_header = header
        self.insertSubview(header, atIndex: 0)
        
    }
   
    func endRefresh() {
        self.af_header?.stopAnimation()
    }
    
    

}
