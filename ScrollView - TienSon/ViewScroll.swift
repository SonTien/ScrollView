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
    var color = UIColor.yellowColor()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollView.delegate = self
//Mang chua cac UIImage
        pageImages = ["light", "light1", "light2", "dark1", "dark2", "dark3", "dark4", "droid1", "droid2", "droid3"]
        pageControl.numberOfPages = pageImages.count
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
        self.navigationController!.navigationBar.tintColor = color
    }
    
    override func viewDidLayoutSubviews()
    {
        
//Su dung contentOffSet de di chuyen cac anh
        if (!first)
        {
        first = true
        let pagesScrollViewSize = scrollView.frame.size
        pageControl.currentPage = currentPage
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), 0)
        scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollView.frame.size.width, 0)

//Khai bao cac UIImage va dat vi tri trong pageview
            for (var i = 0; i < pageImages.count; i += 1)
            {
            let imgView = UIImageView(image: UIImage(named: pageImages[i]+".jpg"))
            imgView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
            imgView.contentMode = .ScaleAspectFit
            
            imgView.userInteractionEnabled = true
            imgView.multipleTouchEnabled = true
            imgView.contentMode = .ScaleAspectFit
            
//Lenh Zoom in va Zoom out bang chuot
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.tapImg(_:)))
            tap.numberOfTapsRequired = 1
            imgView.addGestureRecognizer(tap)
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewScroll.doubleTapImg(_:)))
            doubleTap.numberOfTapsRequired = 2
            tap.requireGestureRecognizerToFail(doubleTap)
            imgView.addGestureRecognizer(doubleTap)
            
//Day anh va scrollview len view chinh
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
    

//Zoom in va Zoom out bang bam chuot
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
  
//Ham dieu chinh Zoom
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

//Slider dieu chinh kich co cua UIImage
    @IBAction func zoomSlide(sender: UISlider) {
        frontScrollViews[pageControl.currentPage].setZoomScale(CGFloat(sender.value), animated: true)
    }
    

//Ham tra ve hinh anh da Zoom in hoac Zoom out
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return photo[pageControl.currentPage]
    }
 
//Page Control hien thi thay doi khi anh thay doi
    @IBOutlet weak var change: UIPageControl!
    @IBAction func onChange(sender: AnyObject)
    {
        let curPage = CGFloat(pageControl.currentPage)
        let width = frontScrollViews[pageControl.currentPage].frame.size.width
        frontScrollViews[pageControl.currentPage].contentOffset = CGPointMake(curPage * width , 0)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
    }


    @IBAction func movPicRight(sender: AnyObject) {
        
    }






















}