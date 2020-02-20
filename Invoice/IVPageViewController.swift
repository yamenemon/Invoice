//
//  IVPageViewController.swift
//  Invoice
//
//  Created by Scrupulous on 4/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

protocol IVPageViewControllerDelegate : NSObjectProtocol {
    
    func didSelectedPageController(withType type: IVControllerType)
    
}

class IVPageViewController: UIPageViewController {

    var selectionDelegate : IVPageViewControllerDelegate?
    var subViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        self.showViewController(at: 0)
    }
    
    func setSubViewControllers(controllers:[UIViewController]) {
        subViewControllers.removeAll()
        subViewControllers.append(contentsOf: controllers)
    }
    
    func showViewController(at controllerIndex:Int) {
        self.setViewControllers([subViewControllers[controllerIndex]], direction: .forward, animated: false, completion: nil)
        self.selectionDelegate?.didSelectedPageController(withType: IVControllerType(rawValue: controllerIndex)!)
    }

}

extension IVPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentIndex : Int = subViewControllers.lastIndex(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
        self.selectionDelegate?.didSelectedPageController(withType: IVControllerType(rawValue: currentIndex-1)!)
        return subViewControllers[currentIndex-1]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentIndex : Int = subViewControllers.lastIndex(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count - 1 {
            return nil
        }
        self.selectionDelegate?.didSelectedPageController(withType: IVControllerType(rawValue: currentIndex+1)!)
        return subViewControllers[currentIndex+1]
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
}


extension IVPageViewController : UIPageViewControllerDelegate {
    
    
}

