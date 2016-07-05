//
//  ViewScroll.swift
//  ScrollView - TienSon
//
//  Created by HoangHai on 7/4/16.
//  Copyright © 2016 Tien Son. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var photo = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgView = UIImageView(image: UIImage(named: "Vader.png"))
        imgView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
        imgView.userInteractionEnabled = true
        imgView.multipleTouchEnabled = true
        imgView.contentMode = .ScaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapImg:"))
        tap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(tap)
        let doubleTap = UITapGestureRecognizer(target: self, action: Selector("doubleTapImg:"))
        doubleTap.numberOfTapsRequired = 2
        tap.requireGestureRecognizerToFail(doubleTap)
        imgView.addGestureRecognizer(doubleTap)
        photo = imgView
        scrollView.contentSize = CGSizeMake(imgView.bounds.width, imgView.bounds.height)
        scrollView.minimumZoomScale = 0.7
        scrollView.maximumZoomScale = 2
        self.scrollView.addSubview(imgView)
       }
    
    func tapImg(gesture: UITapGestureRecognizer)
    {
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 1.5, center: position)
    }
    
    func doubleTapImg(gesture: UITapGestureRecognizer)
    {
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint)
    {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        scrollView.zoomToRect(zoomRect, animated: true)
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return photo
    }
}