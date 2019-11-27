//
//  PemesananController.swift
//  CustomLoginDemo
//
//  Created by Lab PK 29 on 22/11/19.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PemesananController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let pickerView = UIPickerView()
    let db = Firestore.firestore()
    var data = ["Pilih Paket","Paket Buffet Mantap", "Paket Buffet Santai", "Paket Buffet Halilintar"]
    var index: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        errorLabel.alpha = 0
        self.pickerBuffet.delegate?.pickerView?(self.pickerBuffet, didSelectRow: 1, inComponent: 0)
        self.pickerBuffet.dataSource = self
        self.pickerBuffet.delegate = self
        pickerBuffet.selectRow(0, inComponent: 0, animated: true)
    }
    
    
    
    @IBOutlet weak var txtNamaPemesanBufffet: UITextField!
    
    @IBOutlet weak var txtAlamatPemesan: UITextField!
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    @IBOutlet weak var pickerBuffet: UIPickerView!
    
    @IBOutlet weak var txtJumlahPesanan: UITextField!
    
    @IBOutlet weak var btnTambah: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
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
    
    
    @IBAction func btnTambah(_ sender: Any) {
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        
        let namaPemesan = txtNamaPemesanBufffet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let alamat = txtAlamatPemesan.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let nomorhp = txtPhoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let jumlah = txtJumlahPesanan.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let paket: String? = index
        let convertJumlah: Int? = Int(txtJumlahPesanan.text!)
        if (paket == "Paket Buffet Mantap")  {
             
             if (paket ?? "").isEmpty || (paket == "Pilih Paket") || (paket == "Pilih Paket") || (txtNamaPemesanBufffet.text == "" ) || (txtAlamatPemesan.text == "") || (txtPhoneNumber.text == "" ) || (txtJumlahPesanan.text == "" )   {
                                  self.showError("Please Choose Your Packet! and Fill all Data ")
                   }else{
                let harga = 20000*convertJumlah!;
                   db.collection("buffet").addDocument( data: ["namapemesan":namaPemesan, "alamat":alamat, "uid": currentUser!.uid ,"nomorhp":nomorhp,"jumlahpesanan":jumlah, "paket":paket as Any, "totalHarga":harga]) { (error) in
                      
                          if error != nil {
                              // Show error message
                               self.showError("Error tambah paket!")
                          }
                        self.showError("Success Added Paket!")
                    self.performSegue(withIdentifier: "addToView", sender: (Any).self)
                      }
                   }
            
        }else if (paket == "Paket Buffet Santai") {

             if (paket ?? "").isEmpty || (paket == "Pilih Paket") || (paket == "Pilih Paket") || (txtNamaPemesanBufffet.text == "" ) || (txtAlamatPemesan.text == "") || (txtPhoneNumber.text == "" ) || (txtJumlahPesanan.text == "" )   {
                                  self.showError("Please Choose Your Packet! and Fill all Data ")
                   }else{
                let harga = 40000*convertJumlah!;
                   db.collection("buffet").addDocument( data: ["namapemesan":namaPemesan, "alamat":alamat, "uid": currentUser!.uid ,"nomorhp":nomorhp,"jumlahpesanan":jumlah, "paket":paket as Any, "totalHarga":harga]) { (error) in
                      
                          if error != nil {
                              // Show error message
                               self.showError("Error tambah paket!")
                          }
                        self.showError("Success Added Paket!")
                    self.performSegue(withIdentifier: "addToView", sender: (Any).self)
                    
                }
    
            }
            
        } else {

            if (paket ?? "").isEmpty || (paket == "Pilih Paket") || (paket == "Pilih Paket") || (txtNamaPemesanBufffet.text == "" ) || (txtAlamatPemesan.text == "") || (txtPhoneNumber.text == "" ) || (txtJumlahPesanan.text == "" )     {
                                  self.showError("Please Choose Your Packet! and Fill all Data ")
                   }else{
                   let harga = 80000*convertJumlah!;
                   db.collection("buffet").addDocument( data: ["namapemesan":namaPemesan, "alamat":alamat, "uid": currentUser!.uid ,"nomorhp":nomorhp,"jumlahpesanan":jumlah, "paket":paket as Any, "totalHarga":harga]) { (error) in
                      
                          if error != nil {
                              // Show error message
                               self.showError("Error tambah paket!")
                          }
                        self.showError("Success Added Paket!")
                   self.performSegue(withIdentifier: "addToView", sender: (Any).self)
                    
                }
            }
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       index = String(data[row])
    }
    
    @IBAction func btnBack(_ sender: Any) {
          performSegue(withIdentifier: "backToDashboard", sender: (Any).self)

    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
}

