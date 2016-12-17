//
//  ViewController.swift
//  collectionViewHeaderScrollView
//
//  Created by TPCG II on 09/12/16.
//  Copyright © 2016 TPCG II. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    fileprivate var offset_HeaderStop:CGFloat = 200
    private var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    fileprivate let colors = [UIColor.red , UIColor.blue , UIColor.green , UIColor.gray]
    var pageNumber : Int = 0
    
    //
    fileprivate var lastContentOffsetX : CGFloat = 0
    fileprivate var lastContentOffsetY : CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // self.myCollectionView.addSubview(headerView)
        myCollectionView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)//UIEdgeInsetsMake(headerView.frame.height , 0, 0, 0)
        //myCollectionView.setContentOffset(CGPoint.init(x: 0, y: -headerView.frame.height), animated: true)
      //  myCollectionView.setContentOffset(CGPointMake(0, -headerView.frame.height), animated: true)
//        self.myScrollView.frame.width = 320
//        self.myScrollView.frame.height = 200
        self.headerView.layoutIfNeeded()
        print(headerView.frame.height)
        self.addItemsToScrollView()
        self.configurePageControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        print(headerView.frame.height)
    }

    
    func addItemsToScrollView() -> Void {
        myScrollView.delegate = self
       // self.view.addSubview(myScrollView)
        for index in 0..<4 {
            
            frame.origin.x = 320 * CGFloat(index)
            frame.size = self.myScrollView.frame.size
            self.myScrollView.isPagingEnabled = true
            
            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.myScrollView .addSubview(subView)
        }
        
        self.myScrollView.contentSize = CGSize(width: self.myScrollView.frame.size.width * 4, height: self.myScrollView.frame.size.height)
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
//        self.pageControl.numberOfPages = colors.count
//        self.pageControl.currentPage = 0
//        self.pageControl.tintColor = UIColor.red
//        self.pageControl.pageIndicatorTintColor = UIColor.black
//        self.pageControl.currentPageIndicatorTintColor = UIColor.green
//        self.view.addSubview(pageControl)
        
    }
    
}

extension ViewController : UICollectionViewDelegate {

    
}


extension ViewController : UICollectionViewDataSource {


   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    
        return 10
    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.green
        return cell
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
    
        return 1
    }
    
    
}

extension ViewController {

    //MARK: scrollview delegate 
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if lastContentOffsetX > scrollView.contentOffset.x || lastContentOffsetX < scrollView.contentOffset.x{
            //horizontal movement 
            
        
            
        }else {
        
            headerView.layoutIfNeeded()
            let offset = scrollView.contentOffset.y + headerView.frame.height
            print("this is offset \(offset) headerview \(headerView.bounds.height) and content offset \(scrollView.contentOffset.y)")
            
            var headerTransform = CATransform3DIdentity
            
            //        if offset < 0 {
            //
            //             headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            //
            //        }else {
            //            print("this is transform min max \(max(-offset_HeaderStop, -offset))")
            //            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            //        }
            //
            //        headerView.layer.transform = headerTransform
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            headerView.layer.transform = headerTransform
            
        }
        self.lastContentOffsetX = scrollView.contentOffset.x;
        self.lastContentOffsetY = scrollView.contentOffset.y;
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(self.pageControl.currentPage) * myScrollView.frame.size.width
        myScrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
       // self.pageNumber = Int(pageNumber)
        self.pageControl.currentPage = Int(pageNumber)
    }
    
}
