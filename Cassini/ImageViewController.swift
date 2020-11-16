//
//  ImageViewController.swift
//  Cassini
//
//  Created by qiurong chen on 11/16/20.
//  Copyright © 2020 Xujuan Chen. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL?{
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return ImageView.image
        }
        set {
            ImageView.image = newValue
            ImageView.sizeToFit()
            scrollView?.contentSize = ImageView.frame.size
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ImageView.image == nil {
            fetchImage()
        }
    }

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(ImageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ImageView
    }
    var ImageView = UIImageView()
    
    private func fetchImage() {
        if let url = imageURL {
            let urlContents = try?Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.lehman
        }
    }
}
