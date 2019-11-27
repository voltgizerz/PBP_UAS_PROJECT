//
//  EditOrderViewController.swift
//  CustomLoginDemo
//
//  Created by Lab PK 29 on 23/11/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class EditOrderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var txtNamaPemesan: UITextField!
    
    @IBOutlet weak var txtAlamat: UITextField!
    
    @IBOutlet weak var txtNoHP: UITextField!
    
    @IBOutlet weak var txtPickerOrder: UIPickerView!
    
    @IBOutlet weak var txtJumlahPesanan: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var btnUpdateOrder:         UIButton!
    
    let db = Firestore.firestore()
    var index: String?
   var data = ["Pilih Paket","Paket Silver (+1 Lauk)", "Paket Gold (+2 Lauk)", "Paket Paltinum (+3 Lauk +1 Buah)"]
    
    var passedValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtPickerOrder.dataSource = self
        self.txtPickerOrder.delegate = self
        errorLabel.alpha = 0
        db.collection("order").document(passedValue).getDocument { (document, error) in
            if let document = document, document.exists {
                self.txtNamaPemesan.text=document.get("namapemesan") as? String
                self.txtAlamat.text=document.get("alamat") as? String
                self.txtNoHP.text=document.get("nomorhp") as? String
                self.txtJumlahPesanan.text=document.get("jumlahpesanan") as? String
                
                if (document.get("paket") as? String == "Paket Gold (+2 Lauk)")  {
                    self.txtPickerOrder.selectRow(2, inComponent: 0, animated: true)
                } else if (document.get("paket") as? String == "Paket Silver (+1 Lauk)"){
                    self.txtPickerOrder.selectRow(1, inComponent: 0, animated: true)
                } else {
                    self.txtPickerOrder.selectRow(3, inComponent: 0, animated: true)
                }
            }
             else {
                print("Anda Siapa bisa disini? data anda tidak ada!")
            }
        }
        // Do any additional setup after loading the view.
    }
    
        
        
    @IBAction func btnUpdateOrder(_ sender: Any) {
        let changeName: String = txtNamaPemesan.text!
        let changeJumlah: String = txtJumlahPesanan.text!
        let changeAlamat: String = txtAlamat.text!
        let changeNoHP: String = txtNoHP.text!
        let paket: String? = index
        let convertJumlah: Int? = Int(changeJumlah)
            if (paket == "Paket Buffet Mantap")  {
           
                if (paket ?? "").isEmpty || (paket == "Pilih Paket")  {
                            self.showError("Please Choose Your Packet!")
                        }else{
                         let harga = 20000*convertJumlah!;
                db.collection("buffet").document(passedValue).updateData([
                   "alamat": changeAlamat,
                   "jumlahpesanan": changeJumlah,
                   "namapemesan": changeName,
                   "nomorhp": changeNoHP ,
                   "paket": index as Any ,
                   "totalHarga" : harga ]) { err in
                   if err != nil {
                        self.showError("Error Edit Data Cathering")
                     } else {
                         self.showError("Success Edit")
                         self.performSegue(withIdentifier: "backToOrderTable", sender: (Any).self)
                     }
                 }
              }
        } else if (paket == "Paket Buffet Santai") {
          
                if (paket ?? "").isEmpty || (paket == "Pilih Paket")  {
                            self.showError("Please Choose Your Packet!")
                    }else{
                          let harga = 25000*convertJumlah!;
                        db.collection("oreder").document(passedValue).updateData([
                           "alamat": changeAlamat,
                           "jumlahpesanan": changeJumlah,
                           "namapemesan": changeName,
                           "nomorhp": changeNoHP ,
                           "paket": index as Any ,
                           "totalHarga" : harga ]) { err in
                            if err != nil {
                               self.showError("Error Edit Data Cathering")
                           } else {
                                 self.showError("Success Edit")
                               self.performSegue(withIdentifier: "backToOrderTable", sender: (Any).self)
                           }
                       }
                    }
                
            }else{
                if (paket ?? "").isEmpty || (paket == "Pilih Paket")  {
                        self.showError("Please Choose Your Packet!")
                }else{
                         let harga = 30000*convertJumlah!;
                db.collection("order").document(passedValue).updateData([
                   "alamat": changeAlamat,
                   "jumlahpesanan": changeJumlah,
                   "namapemesan": changeName,
                   "nomorhp": changeNoHP ,
                   "paket": index as Any ,
                   "totalHarga" : harga ]) { err in
                   if err != nil {
                              self.showError("Error Edit Data Cathering")
                          } else {
                             self.showError("Success Edit")
                              self.performSegue(withIdentifier: "backToOrderTable", sender: (Any).self)
                          }
                      }
                   }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }

    func pickerView(_ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {

            // Row count: rows equals array length.
            return data.count
    }

    func pickerView(_ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int) -> String? {
            // Return a string from the array for this row.
            return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       index = String(data[row])
    }

    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func btnHomeEditO(_ sender: Any) {
        performSegue(withIdentifier: "toHomeFromEdit", sender: (Any).self)    }
    
}
