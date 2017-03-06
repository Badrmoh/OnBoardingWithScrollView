//
//  ViewController.swift
//  scrollview(onboarding)
//
//  Created by Badr Moh on 06/03/2017.
//  Copyright © 2017 Badr Moh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imgArr = [UIImage]()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        imgArr = [#imageLiteral(resourceName: "page1"),#imageLiteral(resourceName: "page2"),#imageLiteral(resourceName: "page3")]
        
        //Set attribute of UIScrollView
        scrollView.contentSize.width = CGFloat(imgArr.count) * self.view.frame.width
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.frame.size = self.view.frame.size
        
        //Crreate and customize UIButton
        let btnWidth = CGFloat(200)
        let btnHeight = CGFloat(50)
        button = UIButton(frame: CGRect(x: (self.view.frame.width/2) - (btnWidth/2), y: self.view.frame.height - 5, width: btnWidth, height: btnHeight))
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 25.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5.0
        button.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        button.setTitle("Let's go!", for: .normal)
        button.isUserInteractionEnabled = true
        
        button.addTarget(self, action: #selector(showApp(sender:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        self.view.bringSubview(toFront: button)
        
        
        //Loop to set the images to each page 
        for n in 0..<imgArr.count {
            
            let imageView = UIImageView()
            imageView.image = imgArr[n]
            let xPosition = self.view.frame.width * CGFloat(n)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            scrollView.addSubview(imageView)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(page)
        
        if page == 2 {
            UIView.animate(withDuration: 0.2, animations: {self.button.frame.origin.y = self.view.frame.height - 120})
        } else if page == 1 {
            UIView.animate(withDuration: 0.2, animations: {self.button.frame.origin.y = self.view.frame.height - 15})
        } else if page == 0 {
            UIView.animate(withDuration: 0.2, animations: {self.button.frame.origin.y = self.view.frame.height - 5})
        }
    }

    func showApp (sender:UIButton) {
        
        //Change flag
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: "onBoardingComplete")
        userDefault.synchronize()
        
        //present the new view controller
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "app")
        present(vc, animated: true, completion: nil)
    }
    
}

