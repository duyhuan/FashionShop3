//
//  ListImage.swift
//  FashionShop3
//
//  Created by techmaster on 2/14/17.
//  Copyright © 2017 techmaster. All rights reserved.
//

import UIKit

class ListImage: UIViewController {

    @IBAction func onTouch(_ sender: UIButton) {
        switch sender.tag {
        case 101:
            pushView(index: 0)
        case 102:
            pushView(index: 1)
        case 103:
            pushView(index: 2)
        default:
            break
        }
    }
    
    func pushView(index: Int) {
        let listImage = storyboard?.instantiateViewController(withIdentifier: "show") as! ViewScroll
        listImage.currentPage = index
        navigationController?.pushViewController(listImage, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
