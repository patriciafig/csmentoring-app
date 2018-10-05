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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        if let firstViewController = orderOfViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
