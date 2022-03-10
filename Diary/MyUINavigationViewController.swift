//
//  MyUINavigationViewController.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/07.
//

import UIKit

class MyUINavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .white
        navigationBar.tintColor = UIColor(named: "pink")
        navigationBar.titleTextAttributes = [
                    .foregroundColor: UIColor(named: "navy")
                ]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
