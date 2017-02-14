//
//  ViewScroll.swift
//  FashionShop3
//
//  Created by techmaster on 1/17/17.
//  Copyright © 2017 techmaster. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageImages: [String] = []
    var first = false
    var photos: [UIImageView] = []
    var frontScrollViews: [UIScrollView] = []
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageImages = ["shop1-0", "shop1-1", "shop1-2"]
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = pageImages.count
    }
    
    override func viewDidLayoutSubviews() {
        if !first {
            first = true
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: 0.0)
            scrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * scrollView.frame.size.width, y: 0.0)
            for i in 0..<pageImages.count {
                let imgView = UIImageView(image: UIImage(named: pageImages[i] + ".jpg"))
                imgView.frame = CGRect(x: 0.0, y: 0.0, width: pagesScrollViewSize.width, height: pagesScrollViewSize.height)
                imgView.contentMode = .scaleAspectFit
                imgView.isUserInteractionEnabled = true
                imgView.isMultipleTouchEnabled = true
                
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapImg(_:)))
                singleTap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(singleTap)
                
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapImg(_:)))
                doubleTap.numberOfTapsRequired = 2
                imgView.addGestureRecognizer(doubleTap)
                singleTap.require(toFail: doubleTap)
                
                photos.append(imgView)
                
                let frontScrollView = UIScrollView(frame: CGRect(x: pagesScrollViewSize.width * CGFloat(i), y: 0.0, width: pagesScrollViewSize.width, height: pagesScrollViewSize.height))
                frontScrollView.minimumZoomScale = 0.5
                frontScrollView.maximumZoomScale = 2.0
                frontScrollView.delegate = self
                frontScrollView.contentSize = imgView.bounds.size
                frontScrollView.addSubview(imgView)
                
                frontScrollViews.append(frontScrollView)
                
                scrollView.addSubview(frontScrollView)
                scrollView.delegate = self
//                scrollView.minimumZoomScale = 0.5
//                scrollView.maximumZoomScale = 2.0
            }
        }
    }
    
    func singleTapImg(_ singleTapGesture: UITapGestureRecognizer) {
        let position = singleTapGesture.location(in: photos[pageControl.currentPage])
        zoomRectForScale(scale: frontScrollViews[pageControl.currentPage].zoomScale * 2.0, center: position)
    }
    
    func doubleTapImg(_ doubleTapGesture: UITapGestureRecognizer) {
        let position = doubleTapGesture.location(in: photos[pageControl.currentPage])
        zoomRectForScale(scale: frontScrollViews[pageControl.currentPage].zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        frontScrollViews[pageControl.currentPage].zoom(to: zoomRect, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let fractionalPage = scrollView.contentOffset.x / scrollView.frame.size.width
//        let page = lround(Double(fractionalPage))
//        pageControl.currentPage = page
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((self.scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        if pageControl.currentPage != page {
            frontScrollViews[pageControl.currentPage].zoomScale = 1
            pageControl.currentPage = page
        }
    }
    
    @IBAction func onChange(_ sender: UIPageControl) {
        scrollView.contentOffset = CGPoint(x: CGFloat(pageControl.currentPage) * scrollView.frame.size.width, y: 0.0)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photos[pageControl.currentPage]
    }
    
    @IBAction func buttonControl(_ sender: UIButton) {
        if sender.tag == 110 {
            if currentPage > 0 {
                currentPage = currentPage - 1
            }
            pageControl.currentPage = pageControl.currentPage - 1
        } else {
            if currentPage < 2 {
                currentPage = currentPage + 1
            }
            pageControl.currentPage = pageControl.currentPage + 1
        }
        scrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * scrollView.frame.size.width, y: 0.0)
    }
    
}
