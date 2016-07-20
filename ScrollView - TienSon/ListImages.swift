//
//  ListImages.swift
//  ScrollView - TienSon
//
//  Created by HoangHai on 7/7/16.
//  Copyright © 2016 Tien Son. All rights reserved.
//

import UIKit

class ListImages: UIViewController {

    @IBAction func onTouch(sender: AnyObject) {
        switch (sender.tag)
        {
            case 101: pushView(0)
            case 102: pushView(1)
            case 103: pushView(2)
            case 201: pushView(3)
            case 202: pushView(4)
            case 203: pushView(5)
            case 204: pushView(6)
            case 301: pushView(7)
            case 302: pushView(8)
            case 303: pushView(9)
            default: break
        }
    }
    
    func pushView(index: Int)
    {
        let listView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewScroll") as? ViewScroll
        listView?.currentPage = index
        self.navigationController?.pushViewController(listView!, animated: true)
    }
}
