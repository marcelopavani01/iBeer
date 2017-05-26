//
//  CustomunAcitivity.swift
//  iBeer
//
//  Created by Marcelo Pavani on 25/05/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import UIKit
import Foundation

class ProgressIndicator: UIView {
    
    var indicatorColor:UIColor
    var loadingViewColor:UIColor
    var loadingMessage:String
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    init(inview:UIView,loadingViewColor:UIColor,indicatorColor:UIColor,msg:String){
        
        self.indicatorColor = indicatorColor
        self.loadingViewColor = loadingViewColor
        self.loadingMessage = msg
        super.init(frame: CGRect(x: inview.frame.midX - 150, y: inview.frame.midY - 25 , width: 300, height: 50))
        initalizeCustomIndicator()
        
    }
    convenience init(inview:UIView) {
        
        self.init(inview: inview,loadingViewColor: UIColor.black,indicatorColor:UIColor.black, msg: "Carregando..")
    }
    convenience init(inview:UIView,messsage:String) {
        
        self.init(inview: inview,loadingViewColor: UIColor.black,indicatorColor:UIColor.black, msg: messsage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func initalizeCustomIndicator(){
        
        messageFrame.frame = self.bounds
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicator.tintColor = indicatorColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = CGRect(x: self.bounds.origin.x + 6, y: 0, width: 20, height: 50)
        print(activityIndicator.frame)
        let strLabel = UILabel(frame:CGRect(x: self.bounds.origin.x + 30, y: 0, width: self.bounds.width - (self.bounds.origin.x + 30) , height: 50))
        strLabel.text = loadingMessage
        strLabel.adjustsFontSizeToFitWidth = true
        strLabel.textColor = UIColor.white
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = loadingViewColor
        messageFrame.alpha = 0.8
        messageFrame.addSubview(activityIndicator)
        messageFrame.addSubview(strLabel)
        
        
    }
    
    func  start(){
        //check if view is already there or not..if again started
        if !self.subviews.contains(messageFrame){
            
            activityIndicator.startAnimating()
            self.addSubview(messageFrame)
            
        }
    }
    
    func stop(){
        
        if self.subviews.contains(messageFrame){
            
            activityIndicator.stopAnimating()
            messageFrame.removeFromSuperview()
            
        }
    }
}
