//
//  EditBuffetController.swift
//  CustomLoginDemo
//
//  Created by Lab PK 29 on 22/11/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class EditBuffetController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var txtNamaEdit: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var txtAlamatEdit: UITextField!
    
    @IBOutlet weak var txtNomorHP: UITextField!
    
    @IBOutlet weak var pickerBuffetEdit: UIPickerView!
    
    @IBOutlet weak var txtJumlahEdit: UITextField!
    let db = Firestore.firestore()
    var index: String?
    var data = ["Pilih Paket","Paket Buffet Mantap", "Paket Buffet Santai", "Paket Buffet Halilintar"]
    
    var passedValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerBuffetEdit.dataSource = self
        self.pickerBuffetEdit.delegate = self
        errorLabel.alpha = 0
        db.collection("buffet").document(passedValue).getDocument { (document, error) in
            if let document = document, document.exists {
                self.txtNamaEdit.text=document.get("namapemesan") as? String
                self.txtAlamatEdit.text=document.get("alamat") as? String
                self.txtNomorHP.text=document.get("nomorhp") as? String
                self.txtJumlahEdit.text=document.get("jumlahpesanan") as? String
                
                if (document.get("paket") as? String == "Paket Buffet Santai")  {
                    self.pickerBuffetEdit.selectRow(2, inComponent: 0, animated: true)
                } else if (document.get("paket") as? String == "Paket Buffet Mantap"){
                    self.pickerBuffetEdit.selectRow(1, inComponent: 0, animated: true)
                } else {
                    self.pickerBuffetEdit.selectRow(3, inComponent: 0, animated: true)
                }
            }
             else {
                print("Anda Siapa bisa disini? data anda tidak ada!")
            }
        }
        
        // Do any additional setup after loading the view.
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
    
    
    @IBAction func btnUpdateData(_ sender: Any) {
        let changeName: String = txtNamaEdit.text!
        let changeJumlah: String = txtJumlahEdit.text!
        let changeAlamat: String = txtAlamatEdit.text!
        let changeNoHP: String = txtNomorHP.text!
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
                        self.showError("Error Edit Data Buffet")
                     } else {
                         self.showError("Success Edit")
                         self.performSegue(withIdentifier: "backToTable", sender: (Any).self)
                     }
                 }
              }
        } else if (paket == "Paket Buffet Santai") {
            
                if (paket ?? "").isEmpty || (paket == "Pilih Paket")  {
                            self.showError("Please Choose Your Packet!")
                    }else{
                        let harga = 40000*convertJumlah!;
                        db.collection("buffet").document(passedValue).updateData([
                           "alamat": changeAlamat,
                           "jumlahpesanan": changeJumlah,
                           "namapemesan": changeName,
                           "nomorhp": changeNoHP ,
                           "paket": index as Any ,
                           "totalHarga" : harga ]) { err in
                            if err != nil {
                               self.showError("Error Edit Data Buffet")
                           } else {
                                 self.showError("Success Edit")
                               self.performSegue(withIdentifier: "backToTable", sender: (Any).self)
                           }
                       }
                    }
                
            }else{
               
                if (paket ?? "").isEmpty || (paket == "Pilih Paket")  {
                        self.showError("Please Choose Your Packet!")
                }else{
                     let harga = 80000*convertJumlah!;
                db.collection("buffet").document(passedValue).updateData([
                   "alamat": changeAlamat,
                   "jumlahpesanan": changeJumlah,
                   "namapemesan": changeName,
                   "nomorhp": changeNoHP ,
                   "paket": index as Any ,
                   "totalHarga" : harga ]) { err in
                   if err != nil {
                              self.showError("Error Edit Data Buffet")
                          } else {
                             self.showError("Success Edit")
                              self.performSegue(withIdentifier: "backToTable", sender: (Any).self)
                          }
                      }
                   }
        }
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
           self.performSegue(withIdentifier: "editToHome", sender: (Any).self)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       index = String(data[row])
    }

    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
