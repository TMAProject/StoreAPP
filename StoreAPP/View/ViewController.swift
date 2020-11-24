//
//  ViewController.swift
//  StoreAPP
//
//  Created by José João Silva Nunes Alves on 24/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    let cview: CategoriesView = {
        let cView = CategoriesView()
        return cView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = cview
        // Do any additional setup after loading the view.
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
