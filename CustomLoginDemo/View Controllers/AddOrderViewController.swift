//
//  AddOrderViewController.swift
//  CustomLoginDemo
//
//  Created by Lab PK 29 on 23/11/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AddOrderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let db = Firestore.firestore()
    var data = ["Pilih Paket","Paket Silver (+1 Lauk)", "Paket Gold (+2 Lauk)", "Paket Paltinum (+3 Lauk +1 Buah)"]
    var index: String?
    
    @IBOutlet weak var txtNameOrder: UITextField!
    
    @IBOutlet weak var txtAlamat: UITextField!
    
    @IBOutlet weak var txtNoHP: UITextField!
    
    @IBOutlet weak var pickerOrder: UIPickerView!
    
    @IBOutlet weak var txtJumlahPesanan: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
            self.pickerOrder.delegate?.pickerView?(self.pickerOrder, didSelectRow: 1, inComponent: 0)
            self.pickerOrder.dataSource = self
            self.pickerOrder.delegate = self
            pickerOrder.selectRow(0, inComponent: 0, animated: true)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnAddOrder(_ sender: Any) {
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        
        let namaPemesan = txtNameOrder.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let alamat = txtAlamat.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let nomorhp = txtNoHP.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let jumlah = txtJumlahPesanan.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let paket: String? = index
        let convertJumlah: Int? = Int(txtJumlahPesanan.text!)
        if (paket == "Paket Silver (+1 Lauk)")  {
            if (paket ?? "").isEmpty || (paket == "Pilih Paket") || (paket == "Pilih Paket") || (txtNameOrder.text == "" ) || (txtAlamat.text == "") || (txtNoHP.text == "" ) || (txtJumlahPesanan.text == "" )  {
                       self.showError("Please Choose Your Packet!")
                   }else{
                let harga = 20000*convertJumlah!;
                   db.collection("order").addDocument( data: ["namapemesan":namaPemesan, "alamat":alamat, "uid": currentUser!.uid ,"nomorhp":nomorhp,"jumlahpesanan":jumlah, "paket":paket as Any, "totalHarga":harga]) { (error) in
                      
                          if error != nil {
                              // Show error message
                               self.showError("Error tambah paket!")
                          }
                        self.showError("Success Added Paket!")
                    self.performSegue(withIdentifier: "addToViewOrder", sender: (Any).self)
                      }
                   }
        }else if (paket == "Paket Gold (+2 Lauk)") {
             if (paket ?? "").isEmpty || (paket == "Pilih Paket") || (paket == "Pilih Paket") || (txtNameOrder.text == "" ) || (txtAlamat.text == "") || (txtNoHP.text == "" ) || (txtJumlahPesanan.text == "" )  {
                       self.showError("Please Choose Your Packet!")
                   }else{
                 let harga = 25000*convertJumlah!;
                   db.collection("order").addDocument( data: ["namapemesan":namaPemesan, "alamat":alamat, "uid": currentUser!.uid ,"nomorhp":nomorhp,"jumlahpesanan":jumlah, "paket":paket as Any, "totalHarga":harga]) { (error) in
                      
                          if error != nil {
                              // Show error message
                               self.showError("Error tambah paket!")
                          }
                        self.showError("Success Added Paket!")
                    self.performSegue(withIdentifier: "addToViewOrder", sender: (Any).self)
                    
                }
            }
        } else {

            if (paket ?? "").isEmpty || (paket == "Pilih Paket") || (paket == "Pilih Paket") || (txtNameOrder.text == "" ) || (txtAlamat.text == "") || (txtNoHP.text == "" ) || (txtJumlahPesanan.text == "" )  {
                       self.showError("Please Choose Your Packet!")
                   }else{
                 let harga = 30000*convertJumlah!;
                   db.collection("order").addDocument( data: ["namapemesan":namaPemesan, "alamat":alamat, "uid": currentUser!.uid ,"nomorhp":nomorhp,"jumlahpesanan":jumlah, "paket":paket as Any, "totalHarga":harga]) { (error) in
                      
                          if error != nil {
                              // Show error message
                               self.showError("Error tambah paket!")
                          }
                        self.showError("Success Added Paket!")
                   self.performSegue(withIdentifier: "addToViewOrder", sender: (Any).self)
                    
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
    
    @IBAction func btnToHome(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: (Any).self)    }
    
}
