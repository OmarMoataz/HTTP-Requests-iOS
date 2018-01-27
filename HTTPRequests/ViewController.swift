//
//  ViewController.swift
//  HTTPRequests
//
//  Created by Omar Moataz Abdel-Wahed Attia on 1/24/18.
//  Copyright © 2018 Omar Moataz Abdel-Wahed Attia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {

    @IBOutlet var downloadProgress: UIProgressView!
    @IBOutlet var imageViewOutlet: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createDownloadSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createBasicSession()
    {
        
    }
    
    
    func createDownloadSession()
    {
        let url = URL(string:"https://orig00.deviantart.net/5868/f/2016/130/8/a/pug_by_slamchops-da22149.jpg")
        if let url = url
        {
            let request = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "id"), delegate: self, delegateQueue: nil)

            let downloadTask = session.downloadTask(with: request)
            
            downloadTask.resume()
        }
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)
    {
        let path = location.path
        
        let data:Data? = FileManager.default.contents(atPath: path)
        
        if let data = data
        {
            print(data.count)
            if let image = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    
                    self.imageViewOutlet.image = image
                }
                
            }
        }
    }
    
     public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)
     {
        
        DispatchQueue.main.async {
            
             self.downloadProgress.progress = (Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
        }
       
    }
    
    
}

