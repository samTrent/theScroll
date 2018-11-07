//
//  JSONParser.swift
//  theScroll
//
//  Created by Sam Trent on 11/6/18.
//  Copyright © 2018 Sam Trent. All rights reserved.
//

import Foundation

class JSONParser
{
    //gets the first 10 posts from the scroll
    class func getFrontPageContent()
    {
        
        let url = URL(string: "https://byuiscroll.org/wp-json/wp/v2/posts")!
        
        let downloadTask = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            
            if(error != nil)
            {
                print("ERROR:::Problem with downloading front page content: \(String(describing: error?.localizedDescription))")
            }
            else
            {
                if let URLContent = data
                {
                    
                    do
                    {
                        //the JSON
                        let jsonResult = try JSONSerialization.jsonObject(with: URLContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        
                        let result = jsonResult as! NSArray
                        
                        for ids in result as [AnyObject]
                        {
                            print(ids["id"]!)
                        }
                        
                    }
                    catch
                    {
                        print("There was an error processing the JSON)")
                    }
                    
                    
                }
            }
        }
        
        downloadTask.resume()
        
    }
    
    
    func getPostTitle()
    {
        
    }
    
    
}
