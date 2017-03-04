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
    
    
    var button = UIButton()
    var lable = UILabel()
    
    var imageArr = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configuring ScrollView
        myScrollView.delegate = self
        imageArr = [#imageLiteral(resourceName: "page1"),#imageLiteral(resourceName: "page2"),#imageLiteral(resourceName: "page3")]
        myScrollView.isPagingEnabled = true
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.contentSize.width = self.view.frame.width * CGFloat(imageArr.count)
        myScrollView.frame.size = self.view.frame.size
        
        //Create the Let's go button
        button = UIButton(frame: CGRect(x: (self.view.frame.width / 2) - 100, y: self.view.frame.height - 5, width: 200, height: 50))
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 25.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        button.setTitle("Let's go!", for: .normal)
        button.isUserInteractionEnabled = true
        button.tag = 1
        button.addTarget(self, action: #selector(ViewController.showApp(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        self.view.bringSubview(toFront: button)
        
        //Addin' pages
        for n in 0..<imageArr.count {
            
            let imageView = UIImageView()
            imageView.image = imageArr[n]
            let xPosition = self.view.frame.width * CGFloat(n)
            
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.myScrollView.frame.width, height: self.myScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            myScrollView.addSubview(imageView)
            
            //button.addSubview(lable)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
        if page == 2 {
            UIView.animate(withDuration: 0.2, animations: {self.button.frame.origin.y = self.view.frame.height - 120})
        } else if page == 1{
            UIView.animate(withDuration: 0.2, animations: {self.button.frame.origin.y = self.view.frame.height - 15})
        } else if page == 0 {
            UIView.animate(withDuration: 0.2, animations: {self.button.frame.origin.y = self.view.frame.height - 5})
        }
    }
    

    func showApp(sender:UIButton){
        
        //change user rootViewController default
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
        
        //present the App VC
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "master")
        present(vc, animated: true, completion: nil)
        
        
    }
}

