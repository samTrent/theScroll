//
//  ViewController.swift
//  theScroll
//
//  Created by Sam Trent on 11/6/18.
//  Copyright © 2018 Sam Trent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var jsonParser = JSONParser()
        
        JSONParser.getFrontPageContent()
        
    }

    

}

