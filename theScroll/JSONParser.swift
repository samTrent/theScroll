//
//  JSONParser.swift
//  theScroll
//
//  Created by Sam Trent on 11/6/18.
//  Copyright © 2018 Sam Trent. All rights reserved.
//

import Foundation

struct ArticlePost
{
    var id: Int
    var title: String
    var authorID: Int
    var fullAuthorName: String
    var date: String
    var content: String
    var excerpt: String
    
}

//list of articlePosts collected from the website

class JSONParser
{
  
    
    //gets the first 10 posts from the scroll
    func getFrontPageContent(completionHandler: @escaping (_ articlePosts: [ArticlePost], _ error: String?) -> Void)
    {
        var lastTenArticlePosts: [ArticlePost] = []
        
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
                        
                        //loop through the JSON array
                        for item in jsonArray
                        {
                            print("looping through post")
                            var singlePost = item as! [String: Any]
                            //some items like "title" are a mini dictionary object
                            var title = singlePost["title"] as! [String: String]
                            var rawContent = singlePost["content"] as! [String: Any]
                            var authorID = singlePost["author"] as! Int
                            var date = singlePost["date"] as! String
                            var excerpt = singlePost["excerpt"] as! [String: Any]
                            
                            //get the author name
                            self.getAuthorByID(authorID: authorID) {
                                fullAuthorName, theError in
                                
                                //create a new article when the author name has been retrived
                                print("finihsed getting user name \(fullAuthorName)")
                                
                                let newArticle = ArticlePost(id: singlePost["id"] as! Int, title: title["rendered"]!, authorID: singlePost["author"] as! Int, fullAuthorName: fullAuthorName, date: date, content: rawContent["rendered"]! as! String, excerpt: excerpt["rendered"] as! String)
                                
                                lastTenArticlePosts.append(newArticle)
                                
                               
                            }
                        }
                        
                        print("Number of articles gathered: \(lastTenArticlePosts.count)")
                        
                        //TODO:: There is a bug here where this function finishs before the articles are created and appended to the lastTenArticlePosts array, Thus the final list of articles never makes it to the main view controller. Possible solution is to add another completion handler
                        
                        //completion handler here
                        //return data & close
                        completionHandler(lastTenArticlePosts, "There was a problem getting the posts")
                        
                        
                        
                        
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
    
    //this function finds the user on the wordpress site and returns the object
    func getAuthorByID(authorID: Int, completionHandler: @escaping (_ result: String, _ error: String) -> Void)
    {
        let authorURL = URL(string: "https://byuiscroll.org/wp-json/wp/v2/users/" + String(describing: authorID))!
        var authorName = ""
        
        let downloadTask = URLSession.shared.dataTask(with: authorURL)
        { (data, responce, error) in
            
            if(error != nil)
            {
                print("there was a problem getting the author: \(String(describing: error?.localizedDescription))")
            }
            else
            {
                if let URLContent = data
                {
                    do
                    {
                        let JSONResult = try JSONSerialization.jsonObject(with: URLContent, options: .mutableContainers)
                        
                        //this JSON needs to be formatted as a dictionary
                        let JSONDictionary = JSONResult as! Dictionary<String,AnyObject>
                        
                        //just get the name of the author
                        authorName = JSONDictionary["name"]! as! String
                        
                         print("THE AUTHOR  NAME \(authorName)")
                        
                        // return data & close
                        completionHandler(authorName, "There was a problem")
                       
                        
                    }
                    catch
                    {
                         print("There was an error processing the JSON for the author")
                    }
                    
                    
                }
                
               
               
            }
            
        }
        
        downloadTask.resume()
       
        
    }
    

    
    func removeHTMLfromString(rawString: String) -> String?
    {
        var cleanString: String? = nil
        
        if let htmlStringData = rawString.data(using: .utf8), let attributedString = try? NSAttributedString(data: htmlStringData, options: [.documentType : NSMutableAttributedString.DocumentType.html], documentAttributes: nil)
        {
            cleanString = attributedString.string.replacingOccurrences(of: "/[\r\n\t ]+/", with: "", options: .regularExpression, range: nil)
        }
        
        return cleanString
    }
    
    
}
