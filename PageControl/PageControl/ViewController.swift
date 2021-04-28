//
//  ViewController.swift
//  PageControl
//
//  Created by Saher on 2/11/21.
//  Copyright © 2021 Saher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let scrollView = UIScrollView()
    
    private let pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.backgroundColor = .systemBlue
        
        return pageControl } ()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        pageControl.addTarget(self , action: #selector(pageControlDidChange(_:)),
                             for: .valueChanged)
        view.addSubview(scrollView)
        view.addSubview(pageControl)
    }
    
    @objc private func pageControlDidChange(_ sender : UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x:CGFloat(current) * view.frame.size.width , y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 0, y: view.frame.size.height - 100, width: view.frame.size.width, height: 70)
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 100)
        
        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
        
    
    }
    
    private func configureScrollView() {
        
        scrollView.contentSize = CGSize(width: view.frame.size.width*5, height: scrollView.contentSize.height)
        scrollView.isPagingEnabled = true
        let images : [UIImage] = [
UIImage(named: "1.jpg")!,
UIImage(named: "2.jpg")!,
UIImage(named: "3.jpg")!,
UIImage(named: "4.jpg")!,
UIImage(named: "5.jpg")!]
        
        for x in 0..<5 {
            
            let page = UIImageView(frame: CGRect(x: CGFloat(x) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            page.image = images[x]
            scrollView.addSubview(page)
        }
    
    }
}

extension ViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
}
