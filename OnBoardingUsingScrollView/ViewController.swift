//
//  ViewController.swift
//  OnBoardingUsingScrollView
//
//  Created by Badr Moh on 03/03/2017.
//  Copyright © 2017 Badr Moh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var goBtn: UIButton!
    
    var button = UIButton()
    var lable = UILabel()
    
    var imageArr = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myScrollView.delegate = self
        imageArr = [#imageLiteral(resourceName: "page1"),#imageLiteral(resourceName: "page2"),#imageLiteral(resourceName: "page3")]
        myScrollView.isPagingEnabled = true
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.contentSize.width = self.view.frame.width * CGFloat(imageArr.count)
        myScrollView.frame.size = self.view.frame.size
        
        //Create the button
        lable.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        lable.text = "Let's go!"
        lable.textColor = UIColor.white
        lable.font = UIFont(name: "Avenir Next", size: 17.0)
        lable.textAlignment = NSTextAlignment.center
        
        button = UIButton(frame: CGRect(x: (self.view.frame.width / 2) - 100, y: self.view.frame.height - 5, width: 200, height: 50))
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 25.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        
        
        
        //Addin' pages
        for n in 0..<imageArr.count {
            
            let imageView = UIImageView()
            imageView.image = imageArr[n]
            let xPosition = self.view.frame.width * CGFloat(n)
            
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.myScrollView.frame.width, height: self.myScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            myScrollView.addSubview(imageView)
            imageView.addSubview(button)
            button.addSubview(lable)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
        if page == 2 {
            UIView.animate(withDuration: 0.4, animations: {self.button.frame.origin.y = self.view.frame.height - 130})
        } else {
            UIView.animate(withDuration: 0.4, animations: {self.button.frame.origin.y = self.view.frame.height + 130})
        }
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        let currentPage = scrollView.contentOffset
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

