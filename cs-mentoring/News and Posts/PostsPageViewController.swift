//
//  PostsPageViewController.swift
//  cs-mentoring
//
//  Created by Patricia on 10/1/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

//POST: https://csmentoring.herokuapp.com/api/posts

class PostsPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderOfViewControllers.index(of:viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        //if user is on the first view controller and swipes left , loop to the last view controller
        guard previousIndex >= 0 else{
            return orderOfViewControllers.last
        }
        
        return orderOfViewControllers[previousIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderOfViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
  
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderOfViewControllers.index(of:viewController) else{
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderOfViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderOfViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderOfViewControllers[nextIndex]
    }
    
    
    func newViewController(viewController: String) -> UIViewController{
        return UIStoryboard(name: "NewsandPostsFeed", bundle: nil).instantiateViewController(withIdentifier: viewController )
        }
    
    lazy var orderOfViewControllers:  [UIViewController] = {
        return [self.newViewController(viewController: "sb1"),
                self.newViewController(viewController: "sb2")]
    }()
    
    func configurePageControl() {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 338, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderOfViewControllers.count
        pageControl.currentPage = 0
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        //configurePageControl()
        
        if let firstViewController = orderOfViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = UIColor(red: 38.0/255.0, green: 153.0/255.0, blue: 251.0/255.0, alpha: 0.25)
        appearance.currentPageIndicatorTintColor = .SkyBlue
    }
}
