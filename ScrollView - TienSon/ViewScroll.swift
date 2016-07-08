//
//  ViewScroll.swift
//  ScrollView - TienSon
//
//  Created by HoangHai on 7/4/16.
//  Copyright © 2016 Tien Son. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var photo: [UIImageView] = []
    var pageImages: [String] = []
    var frontScrollViews: [UIScrollView] = []
    var first = false
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        pageImages = ["light", "dark1", "droid1"]
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = pageImages.count
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
    }
    
    override func viewDidLayoutSubviews() {
        if (!first)
        {
        first = true
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), 0)
        scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollView.frame.size.width, 0)
        for (var i = 0; i < pageImages.count; i += 1)
        {
            let imgView = UIImageView(image: UIImage(named: pageImages[i]+".jpg"))
            imgView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
            imgView.contentMode = .ScaleAspectFit
            
            imgView.userInteractionEnabled = true
            imgView.multipleTouchEnabled = true
            imgView.contentMode = .ScaleAspectFit
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.tapImg(_:)))
            tap.numberOfTapsRequired = 1
            imgView.addGestureRecognizer(tap)
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.doubleTapImg(_:)))
            doubleTap.numberOfTapsRequired = 2
            tap.requireGestureRecognizerToFail(doubleTap)
            imgView.addGestureRecognizer(doubleTap)
            
            photo.append(imgView)
            let frontScrollView = UIScrollView(frame: CGRectMake(CGFloat(i) * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height))
            frontScrollView.minimumZoomScale = 1
            frontScrollView.maximumZoomScale = 2
            frontScrollView.delegate = self
            frontScrollViews.append(frontScrollView)
            frontScrollView.addSubview(imgView)
            self.scrollView.addSubview(frontScrollView)
        }
        }
    }
    
    
    func tapImg(gesture: UITapGestureRecognizer)
    {
        let position = gesture.locationInView(photo[pageControl.currentPage])
        zoomRectForScale(frontScrollViews[pageControl.currentPage].zoomScale * 1.5, center: position)
    }
    
    func doubleTapImg(gesture: UITapGestureRecognizer)
    {
        if(scrollView.zoomScale == 1)
        {
            return
        }
        let position = gesture.locationInView(photo[pageControl.currentPage])
        zoomRectForScale(frontScrollViews[pageControl.currentPage].zoomScale * 0.5, center: position)
        
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint)
    {
        var zoomRect = CGRect()
        let scrollViewSize = frontScrollViews[pageControl.currentPage].bounds.size
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        frontScrollViews[pageControl.currentPage].zoomToRect(zoomRect, animated: true)
    }

    @IBAction func zoomSlide(sender: UISlider) {
        frontScrollViews[pageControl.currentPage].setZoomScale(CGFloat(sender.value), animated: true)
    }
    
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return photo[pageControl.currentPage]
    }
    
    @IBOutlet weak var change: UIPageControl!
    @IBAction func onChange(sender: AnyObject) {
        let curPage = CGFloat(pageControl.currentPage)
        let width = frontScrollViews[pageControl.currentPage].frame.size.width
        frontScrollViews[pageControl.currentPage].contentOffset = CGPointMake(curPage * width , 0)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
    }
}