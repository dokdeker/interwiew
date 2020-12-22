//
//  SettingViewController.swift
//  Note
//
//  Created by Евгений on 22.12.2020.
//

import UIKit

var appColorTheme = 1

class SettingsViewController: UIViewController {
    
    var newImage = UIImage()
    //MARK: - OUTLETS
    @IBOutlet weak var bgImageTheme: UIImageView!
    
    @IBOutlet weak var firstThemeOutlet: UIButton!
    @IBOutlet weak var secondThemeOutlet: UIButton!
    @IBOutlet weak var thirdThemeOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstThemeOutlet.layer.cornerRadius = 8
        secondThemeOutlet.layer.cornerRadius = 8
        thirdThemeOutlet.layer.cornerRadius = 8
        view.layoutIfNeeded()
        setupPhoto()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        bgImageTheme.image = newImage
    }


    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "viewId" {
//            let dvc = segue.destination as! TodayViewController
//            dvc.newImage = choosedImage
//        }
//    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "sendingToTabBar" {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let tabVC = storyboard.instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
//            self.present(tabVC, animated: true, completion: {
//                let vc = tabVC.selectedViewController as! TodayViewController
//                vc.dataLBL.text = self.dataTF.text!
//            })
//        }
//    }
    
    
    
    var loadPhoto = Photo(url: "")
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var repeatButtonOutlet: UIButton!
    @IBOutlet weak var useButtonOutlet: UIButton!
    
    
    @IBAction func useButton(_ sender: UIButton) {
        bgImageTheme.image = imageView.image

    }
    
    @IBAction func repeatButton(_ sender: UIButton) {
        setupPhoto()
        print("load")
        
    }
    
    
    func setupPhoto() {
        
        
        imageView.downloaded(from: "https://picsum.photos/300")
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "setId" {
//            let dvc = segue.destination as! SettingsViewController
//            dvc.newImage = imageView.image!
//        }
//    }
    
    
    
    




    
    
    @IBAction func chooseFirstTheme(_ sender: UIButton) {
        print("1")
        appColorTheme = 1
        let image = UIImage(named: "imageTheme1")
        bgImageTheme.image = image
        animationButtonTheme()
    }
    
    @IBAction func choseSecondTheme(_ sender: UIButton) {
        print("2")
        appColorTheme = 2
        let image = UIImage(named: "imageTheme2")
        bgImageTheme.image = image
        animationButtonTheme()
        
        
        
        
    }
    
    @IBAction func chooseThirdTheme(_ sender: UIButton) {
        print("3")
        appColorTheme = 3
        let image = UIImage(named: "imageTheme3")
        bgImageTheme.image = image
        animationButtonTheme()
    }
    
    
    func animationButtonTheme() {
        switch appColorTheme {
        case 1:
            UIView.animate(withDuration: 0.4, delay: 0.0,
                           usingSpringWithDamping: 0.3, initialSpringVelocity: 1,
                           options: .curveEaseIn ) { [self] in
                
                firstThemeOutlet.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                firstThemeOutlet.alpha = 0.6
                
                secondThemeOutlet.transform = .identity
                secondThemeOutlet.alpha = 1
                thirdThemeOutlet.transform = .identity
                thirdThemeOutlet.alpha = 1
                view.layoutIfNeeded()
            }
        case 2:
            UIView.animate(withDuration: 0.4, delay: 0.0,
                           usingSpringWithDamping: 0.3, initialSpringVelocity: 1,
                           options: .curveEaseIn ) { [self] in
                
                secondThemeOutlet.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                secondThemeOutlet.alpha = 0.6
               
                
                firstThemeOutlet.transform = .identity
                firstThemeOutlet.alpha = 1
                thirdThemeOutlet.transform = .identity
                thirdThemeOutlet.alpha = 1
                view.layoutIfNeeded()
            }
        case 3:
            UIView.animate(withDuration: 0.4, delay: 0.0,
                           usingSpringWithDamping: 0.3, initialSpringVelocity: 1,
                           options: .curveEaseIn ) { [self] in
                
                thirdThemeOutlet.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                thirdThemeOutlet.alpha = 0.6
                
                firstThemeOutlet.transform = .identity
                firstThemeOutlet.alpha = 1
                secondThemeOutlet.transform = .identity
                secondThemeOutlet.alpha = 1
                view.layoutIfNeeded()
            }
        default:
            break
        }
    }
    
    
    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}






struct Photo {
    let url: String
    var image: UIImage?
    
    init(url:String) {
        self.url = url
    }
}
