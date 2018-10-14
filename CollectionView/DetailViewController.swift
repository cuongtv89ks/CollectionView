//
//  DetailViewController.swift
//  CollectionView
//
//  Created by Olive Union on 14/10/2018.
//  Copyright © 2018 Olive Union. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var detailsLabel: UILabel!
    var selection: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsLabel.text = selection
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
