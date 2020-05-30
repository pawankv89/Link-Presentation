//
//  ViewController.swift
//  LinkPresentation Demo
//
//  Created by Pawan kumar on 09/05/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import UIKit
import LinkPresentation

class ViewController: UIViewController {
    
    private var provider = LPMetadataProvider()
    private var linkView = LPLinkView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
        addURLPreview1()
    }

    
    func addURLPreview1() {
        
        // Re-create the provider
        provider = LPMetadataProvider()
        // 1
        linkView.removeFromSuperview()

        let link = "https://apple.com"
        //let link = "https://youtube.com"
        
        guard let url = URL(string: link) else { return }
        
        // 2
        linkView = LPLinkView(url: url)
        
        // Start fetching metadata
        provider.startFetchingMetadata(for: url) { (metadata, error) in
            
            print("Error:- ", error?.localizedDescription as Any)
            
            // 3
            DispatchQueue.main.async { [weak self] in
              // 4
              guard let self = self else { return }

                if let metaData =  metadata {
                    
                    self.linkView.metadata = metaData
                    
                    // Use ideal size
                    self.linkView.sizeToFit()
                    
                    // Work with the metadata:
                    // URL, title, icon, images, video and remote video URL data.
                    
                    // Use the metadata
                    print(metaData.title ?? "No Title")
                    
                }
            }
        }
        
        // Use ideal frame
        linkView.frame = CGRect.init(x: 20, y: 150, width: 300, height: 300)
        
        // Use ideal size
        linkView.sizeToFit()
        
        self.view.addSubview(linkView)
    }

}

