//
//  ViewController.swift
//  ScrollViewCustomPaging
//
//  Created by Warif Akhand Rishi on 2/4/16.
//  Copyright © 2016 war. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var categoryScrollView: UIScrollView!
    
    var categoryArr = ["Jack","Mark","Down","Bill","Steve"]
    let itemCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
    }

    func setupScrollView() {
    
        let scrollingView = colorButtonsView(CGSizeMake(150,categoryScrollView.frame.size.height), buttonCount: itemCount)
        categoryScrollView.contentSize = scrollingView.frame.size
        categoryScrollView.addSubview(scrollingView)
        categoryScrollView.showsVerticalScrollIndicator = false
        categoryScrollView.delegate = self
        categoryScrollView.pagingEnabled = true
        categoryScrollView.indicatorStyle = .Default
    }
    
    func colorButtonsView(buttonSize:CGSize, buttonCount:Int) -> UIView {
        let buttonView = UIView()
        buttonView.frame.origin = CGPointMake(0,0)
        let padding = CGSizeMake(10, 10)
        buttonView.frame.size.width = (buttonSize.width + padding.width) * CGFloat(buttonCount)
        var buttonPosition = CGPointMake(padding.width * 0.5, padding.height)
        let buttonIncrement = buttonSize.width + padding.width
        for i in 0...(buttonCount - 1)  {
            let button = UIButton(type: .Custom)
            button.frame.size = buttonSize
            button.frame.origin = buttonPosition
            buttonPosition.x = buttonPosition.x + buttonIncrement
            button.setTitle(categoryArr[i], forState: UIControlState.Normal)
            buttonView.addSubview(button)
            button.backgroundColor = UIColor.redColor()
        }
        return buttonView
    }
    
    func setContentOffset(scrollView: UIScrollView) {
        
        let numOfItems = itemCount
        let stopOver = scrollView.contentSize.width / CGFloat(numOfItems)
        let x = round(scrollView.contentOffset.x / stopOver) * stopOver
        
        guard x >= 0 && x <= scrollView.contentSize.width - scrollView.frame.width else {
            return
        }
        
        scrollView.setContentOffset(CGPointMake(x, scrollView.contentOffset.y), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
        setContentOffset(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        guard !decelerate else {
            return
        }
        
        setContentOffset(scrollView)
    }
}

