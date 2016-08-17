//
//  AFBaseRefreshHeader.swift
//  AFPullRefresh
//
//  Created by 口贷网 on 16/8/17.
//  Copyright © 2016年 Afer. All rights reserved.
//

import UIKit

class AFBaseRefreshHeader: UIView {

    var handle: dispatch_block_t?
    var scrollView: UIScrollView?
    var animationIng: Bool = false
    var provar: CGFloat = 0.0
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        self.backgroundColor = UIColor.redColor()
        if (newSuperview != nil) {
            self.scrollView = newSuperview as? UIScrollView
            self.scrollView?.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
        } else {
            self.superview?.removeObserver(self, forKeyPath: "contentOffset")
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentOffset" {
            self.progress = -((self.scrollView?.contentOffset.y)! + 64)
            print(self.progress)

        }
    }
    
    var progress: CGFloat {
        get {
            return self.provar
        }
        set {
            provar = newValue
            self.actionWithProgress(provar)
        }
    }

    func actionWithProgress(pro: CGFloat) {
        
        let headerHeight = self.frame.size.height
        
        if pro < 0.0 {
            // end and hidden 
            
        } else if pro > 0 && pro <= headerHeight {
            
        } else if (pro > headerHeight) {
            
        }
        
        if pro >= headerHeight && !animationIng && !((self.scrollView?.dragging)!) {
            self.startAnimation()
        }
    }
    
    func startAnimation() {
        self.animationIng = true
        UIView.animateWithDuration(0.24) {
            var inset = self.scrollView?.contentInset
            inset?.top = 120
            self.scrollView?.contentInset = inset!
        }
    }
    
    
}
