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
    var arrow = UIImageView.init(image: UIImage.init(named: "arrow"))
    var activityIndicator = UIActivityIndicatorView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        arrow.frame = CGRectMake(0, 0, 15, 40)
        arrow.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0)
        self.addSubview(arrow)
        
        activityIndicator.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0)
        self.addSubview(activityIndicator)
        activityIndicator.color = UIColor.grayColor()
        activityIndicator.hidden = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
//        self.backgroundColor = UIColor.redColor()
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
            
            if pro < 50  {
                UIView.animateWithDuration(0.4) {
                    self.arrow.transform = CGAffineTransformMakeRotation(CGFloat(2 * M_PI))
                }
            } else  if pro > 50  {
                UIView.animateWithDuration(0.4) {
                    self.arrow.transform = CGAffineTransformMakeRotation(CGFloat( M_PI))
                }
            }
        } else if (pro > headerHeight) {
            
        }
        
        if pro >= headerHeight && !animationIng && !((self.scrollView?.dragging)!) {
            self.startAnimation()
        }
        
    }
    
    func startAnimation() {
        self.animationIng = true
        if (handle != nil) {
            self.handle!()
        }
        UIView.animateWithDuration(0.24) {
            var inset = self.scrollView?.contentInset
            inset?.top = 120
            self.scrollView?.contentInset = inset!
            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()
            self.arrow.hidden = true
        }
    }
    
    func stopAnimation() {
        self.animationIng = false
        UIView.animateWithDuration(0.24) {
            var inset = self.scrollView?.contentInset
            inset?.top = 60
            self.scrollView?.contentInset = inset!
            self.activityIndicator.hidden = true
            self.activityIndicator.stopAnimating()
            self.arrow.hidden = false

        }
    }

    
    
}
