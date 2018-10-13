//
//  FullImageViewController.swift
//  Pictures
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/05.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var ImageScrollView: UIScrollView!
    var newImageView: UIImageView?
    var myImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*if let getImage = myImage
        {
            FullImage.image = getImage
        }*/
        myImage = image;
        newImageView = UIImageView(image: myImage);
        ImageScrollView.addSubview(newImageView!);
        ImageScrollView.contentSize = (newImageView?.frame.size)!;
        ImageScrollView.maximumZoomScale = 100;
        ImageScrollView.minimumZoomScale = 0.3;
    }

    func viewForZoomingInScrollView(in ImageScrollView: UIScrollView) -> UIView? {
        return newImageView;
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
