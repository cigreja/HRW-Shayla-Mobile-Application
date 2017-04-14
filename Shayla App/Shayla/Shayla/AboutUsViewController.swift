//
//  AboutUsViewController.swift
//  Shayla
//
//  Created by Yu Chen on 4/2/17.
//  Copyright © 2017 HRW Music Group LLC. All rights reserved.
//

import UIKit
import YouTubePlayer

class AboutUsViewController: UIViewController {
    
    var videoURL: URL! = URL(string:"https://www.youtube.com/watch?v=5VrNplHvbTg")

    @IBOutlet var ytbPlayer: YouTubePlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let videoURL = videoURL {
            print("Video loading")
            ytbPlayer.loadVideoURL(videoURL)
            print("Video loaded")
        }else{
            let alertController = UIAlertController(title: "Shayla App Video Load Error",
                                                    message: "The video could not be loaded. Please email hrwllc@gmail.com",
                                                    preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        }
        
  

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
