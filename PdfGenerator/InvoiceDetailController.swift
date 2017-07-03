//
//  InvoiceDetailController.swift
//  PdfGenerator
//
//  Created by Mahender Reddy on 30/06/17.
//  Copyright © 2017 Mahender Reddy. All rights reserved.
//

import UIKit
import MessageUI

class InvoiceDetailController: UIViewController {

    var items123: [[String: String]]!
    var invoiceComposer: InvoiceComposer!
    var HTMLContent: String!
    

        
    @IBOutlet var webview_Invoice: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      self.items123 = [[String: String]]()
            
      self.items123 = self.getItems()

        createInvoiceAsHTML()
        

        // Do any additional setup after loading the view.
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
    //MARK:- Action Methods

    @IBAction func action_ExportInvoice(_ sender: UIButton) {
        
        invoiceComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
        showOptionsAlert()
    }
    
    //MARK:- Custom Methods
    func createInvoiceAsHTML() {
        invoiceComposer = InvoiceComposer()
        if let invoiceHTML = invoiceComposer.renderInvoice(invoiceNumber: "Invoice_001",
                                                           invoiceDate: "30-Jun-2017",
                                                           recipientInfo: "By doing so, the printing to PDF will take place, and when everything has finished, you’ll see the path to the output file to the console",
                                                           items: self.items123,
                                                           totalAmount: "6000") {
            
            webview_Invoice.loadHTMLString(invoiceHTML, baseURL: NSURL(string: invoiceComposer.pathToInvoiceHTMLTemplate!)! as URL)
            HTMLContent = invoiceHTML
        }
    }
    
    
    
    
    
    func showOptionsAlert() {
        let alertController = UIAlertController(title: "Yeah!", message: "Your invoice has been successfully printed to a PDF file.\n\nWhat do you want to do now?", preferredStyle: UIAlertControllerStyle.alert)
        
        let actionPreview = UIAlertAction(title: "Preview it", style: UIAlertActionStyle.default) { (action) in
            if let filename = self.invoiceComposer.pdfFilename, let url = URL(string: filename) {
                let request = URLRequest(url: url)
                self.webview_Invoice.loadRequest(request)
            }
        }
        
        let actionEmail = UIAlertAction(title: "Send by Email", style: UIAlertActionStyle.default) { (action) in
            DispatchQueue.main.async {
                self.sendEmail()
            }
        }
        
        let actionNothing = UIAlertAction(title: "Nothing", style: UIAlertActionStyle.default) { (action) in
            
        }
        
        alertController.addAction(actionPreview)
        alertController.addAction(actionEmail)
        alertController.addAction(actionNothing)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.setSubject("Invoice")
            mailComposeViewController.addAttachmentData(NSData(contentsOfFile: invoiceComposer.pdfFilename)! as Data, mimeType: "application/pdf", fileName: "Invoice")
            present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    


}
