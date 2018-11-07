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
                        
                        //turn the JSON result string into an NSArray that we can then loop through if we want
                        let jsonArray = jsonResult as! NSArray
                        
                        //convert a single post into a dictionary
                        let singlePost = jsonArray[0] as! [String: Any]
                        
                        //now we have access to all the key items!
                        print(singlePost["author"]!)

                        
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
