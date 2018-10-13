//
//  ViewController.swift
//  Pictures
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/05.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit


var image: UIImage! = nil;

class CollectionViewController: UICollectionViewController {

    let reUseIdentity: String = "cell";
    @IBOutlet weak var loadImageIndicator: UIActivityIndicatorView!
    
    /*let ImageUrlArray: [String] = [
        "https://dw9to29mmj727.cloudfront.net/promo/2016/5248-SeriesHeaders_NARSHP_2000x800.jpg",
        "https://cdn-images-1.medium.com/max/1600/1*EpBnwzNlVcbmPnPgjhQ-rw.jpeg",
        "https://i0.wp.com/ticgamesnetwork.com/wp-content/uploads/2018/09/Black-Clover-TICGN.jpg?fit=1920%2C1080&ssl=1",
        "https://otakukart.com/wp-content/uploads/2018/02/C_116_fotogallery_1949_lstFoto_foto_1_upiFoto.jpg"]*/
    
    /*let ImageUrlArray: [String] = [
        "http://www.jpl.nasa.gov/spaceimages/images/mediumsize/PIA14417_ip.jpg",
        "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA22768_hires.jpg",
        "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA22652_hires.jpg",
        "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA22721_hires.jpg"]*/
    
    let ImageUrlArray: [String] = [
        "http://www.jpl.nasa.gov/spaceimages/images/mediumsize/PIA14417_ip.jpg",
        "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA22768_hires.jpg",
        "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA22652_hires.jpg",
        "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA22721_hires.jpg"]
    
    let Number = 4;
    var count = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Number;
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reUseIdentity, for: indexPath) as! ImageCell;
        
        cell.imageLoadingIndicator.startAnimating();
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        if count != Number {
            print(count);
            var data2: Data?;
            guard let url = URL(string: ImageUrlArray[count]) else { return cell }
            DispatchQueue.global(qos:.background).async {
                do {
                    let data = try Data(contentsOf: url)
                    data2 = data;
                } catch {
                    let alert = UIAlertController(title: "Error", message: "Cannot Access to \(url)", preferredStyle: .alert);
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
                    self.present(alert, animated: true);
                    cell.imageLoadingIndicator.isHidden = true;
                    cell.imageLoadingIndicator.stopAnimating();
                }
                
                DispatchQueue.main.async {
                    if let data = data2, let image = UIImage(data: data) {
                        cell.ImageView.image = image;
                        cell.imageLoadingIndicator.stopAnimating();
                        if self.count == 4
                        {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                        }
                    }
                }
            }
            count = count + 1;
        }
        
        return cell;
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        image = cell.ImageView.image;
        performSegue(withIdentifier: "imageViewerSegue", sender: self)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : FullImageViewController = segue.destination as! FullImageViewController
        destViewController.myImage = image
    }*/
    
}

