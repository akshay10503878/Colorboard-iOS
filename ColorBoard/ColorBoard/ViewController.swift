//
//  ViewController.swift
//  ColorBoard
//
//  Created by akshay bansal on 11/1/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cells = [String : UIView]()
    
   let numberOfRows = 15
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let width = (view.frame.width) / CGFloat(numberOfRows);
        for i in 0...numberOfRows {
            for j in 0...30{
                let view = UIView()
                view.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                view.layer.borderWidth = 1;
                view.layer.borderColor = UIColor.black.cgColor
                view.backgroundColor=backgroundColor()
                self.view.addSubview(view)
                let key = "\(i),\(j)"
                cells[key] = view;
    
                }
        }
     
        view.addGestureRecognizer(UIPanGestureRecognizer(target:self, action: #selector(fingerTrack)))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func backgroundColor() -> UIColor {
        let red = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let green = CGFloat(drand48())
        return UIColor(red: red, green:green, blue:blue ,alpha: 1)
    }
    
    var selectedCell :UIView?
    
    
    @objc func fingerTrack(sender:UIPanGestureRecognizer) {
        
        let width = (view.frame.width) / CGFloat(numberOfRows);
        let location = sender.location(in: view)
        
        let xLocation = Int(location.x/width)
        let yLocation = Int(location.y/width)
        let key = "\(xLocation),\(yLocation)"
        guard let selectedView =  cells[key] else {
            return
        }
        view.bringSubview(toFront: selectedView)
        
        if selectedView != selectedCell {
       
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: { (Bool) in
                
            })
            
        }
        
       selectedCell = selectedView
          
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }) { (bool) in
           
        }

    
  
        
    }
    
}

