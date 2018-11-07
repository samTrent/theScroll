//
//  ViewController.swift
//  theScroll
//
//  Created by Sam Trent on 11/6/18.
//  Copyright © 2018 Sam Trent. All rights reserved.
//

import UIKit

//This viewController will serve as the "Home page"
//It will display the last 10 posts that have been made
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //set the status bar to the light theme
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent // .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateColorOfNavbar(color: UIColor.red)
        updateNavbarTitleColor(color: UIColor.white)
        
        JSONParser.getFrontPageContent()
        
        
        
        
    }
    
  
   //TABLE VIEW PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! postTableViewCell
        
        return cell
    }
    

}

extension ViewController
{
    
    func updateColorOfNavbar(color: UIColor)
    {
        if let navBar = self.navigationController?.navigationBar
        {
            navBar.barTintColor = color
            
        }
        
    }
    
    func updateNavbarTitleColor(color: UIColor)
    {
        if let navBar = self.navigationController?.navigationBar
        {
            let textAttributes = [NSAttributedString.Key.foregroundColor:color]
            navBar.titleTextAttributes = textAttributes
        }
    }
    
}
