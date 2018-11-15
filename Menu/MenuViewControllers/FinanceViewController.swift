//
//  FinanceViewController.swift
//  Menu
//
//  Created by AVROMIC on 12/12/17.
//  Copyright © 2017 My Mac. All rights reserved.
//

import UIKit
import MobileCoreServices
import Localize_Swift
import Alamofire

class FinanceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var financesTableView: UITableView? {
        didSet {
            financesTableView?.delegate = self
            financesTableView?.dataSource = self
        }
    }
    
    @IBOutlet weak var payedLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var ticketImageView: UIImageView?
    @IBOutlet weak var getTicketLabel: UILabel?
    @IBOutlet weak var sendTicketLabel: UILabel?
    
    var token = UserDefaults.standard.string(forKey: "token")
    var newPic: Bool?
    var refresher: UIRefreshControl!
    var currentInfoContributions = UserRequestService.sharedInstance.currentInfo?.tuitionFeesModel?.contributions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // localization for get and set labels
        let _ = getTicketLabel?.text? = "Get a ticket".localized()
        let _ = sendTicketLabel?.text? = "send a ticket".localized()
        updateDbTableData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // actin for get ticket botton
    @IBAction func getTicketButton(_ sender: Any) {
        let getTicketAlert = UIAlertController(title: "Select the field".localized(), message: "Please choose if you want take picture of ticket or get it from a gallery".localized(), preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Take a ticket".localized(), style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
                self.newPic = true
            }
        }
        
        let takeTicket = UIAlertAction(title: "Get a ticket".localized(), style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        getTicketAlert.addAction(cameraAction)
        getTicketAlert.addAction(takeTicket)
        getTicketAlert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        self.present(getTicketAlert, animated: true, completion: nil)
    }
    
    //  show image getTicketButton func in imageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            ticketImageView?.image = image
            
            if newPic == true {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(ImageError), nil)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //    func for some error during the set image for imageView
    @objc func ImageError(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
        if error != nil {
            let alert = UIAlertController(title: "Save Failed".localized(), message: "Faild to save image".localized(), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK".localized(), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //    action for sent ticket button
    @IBAction func sendTicketButton(_ sender: Any) {
       
//        (endpoint: "schedule.php", param1: nil, param2: nil, succsesBlock: <#(Any) -> Void#>) { (error) in
//        }
    }
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = financesTableView?.dequeueReusableCell(withIdentifier: "financesCell")
//       // cell?.textLabel?.text = currentInfoContributions!?.payment
//       // cell?.detailTextLabel?.text = String(currentInfoContributions!!.date)
//        return cell!
//    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentInfoContributions?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = financesTableView?.dequeueReusableCell(withIdentifier: "financesCell")
        let date = NSDate(timeIntervalSince1970: (TimeInterval(currentInfoContributions![indexPath.row].date)/1000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMMM. yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let dateString = dateFormatter.string(from: date as Date)
        cell?.textLabel?.text = currentInfoContributions![indexPath.row].payment
        cell?.detailTextLabel?.text = String(describing: dateString)
        return cell!
    }
    
    func updateDbTableData() {
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: #selector(FinanceViewController.populate), for: UIControlEvents.valueChanged)
        financesTableView?.addSubview(refresher)
    }
    
    @objc func populate() {
        //let token =  DatabaseManager.sharedInstance.curerntToken?.token
        let editDate = DatabaseManager.sharedInstance.currentInfo?.absenceModel?.editData
        UserRequestService.sharedInstance.updateFeesDb(endpoint: "fee.php", token: token, editDate: editDate, succsesBlock: { (succsea,code) in
            self.currentInfoContributions = UserRequestService.sharedInstance.currentInfo?.tuitionFeesModel?.contributions
            self.financesTableView?.reloadData()
            self.refresher.endRefreshing()
            
        }) { (errorBlock,code) in
            self.refresher.endRefreshing()
        }
    }
}

