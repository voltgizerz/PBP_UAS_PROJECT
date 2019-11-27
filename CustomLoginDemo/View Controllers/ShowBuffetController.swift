//
//  ShowBuffetController.swift
//  CustomLoginDemo
//
//  Created by Lab PK 29 on 22/11/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//



import UIKit
import FirebaseAuth
import Firebase

class ShowBuffetController: UITableViewController {
    
    var db:Firestore!
    var docArray = [String]()
    var nama = [String]()
    var alamat = [String]()
    var jumlahpesanan = [String]()
    var nomorhp = [String]()
    var paket = [String]()
    var harga = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        db = Firestore.firestore()
        loadData()

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func loadData(){
        print("LOAD DATA!")
        let currentUser = Auth.auth().currentUser
        db.collection("buffet").whereField("uid", isEqualTo: currentUser!.uid).getDocuments { (snap, error) in
            for doc in (snap?.documents)! {
                self.docArray.append(doc.documentID)
                self.nama.append(doc.get("namapemesan") as! String)
                self.alamat.append(doc.get("alamat") as! String)
                self.jumlahpesanan.append(doc.get("jumlahpesanan") as! String)
                self.nomorhp.append(doc.get("nomorhp") as! String)
                self.paket.append(doc.get("paket") as! String)
                let x : Int = doc.get("totalHarga") as! Int
                let myString = String(x)
                self.harga.append(myString)
                
                print("LOAD DATA SUCCESS!")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        print(docArray)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Nama Pembeli : " + nama[indexPath.row] + "\n Alamat : " + alamat[indexPath.row] + "\n Jumlah Pesanan : " + jumlahpesanan[indexPath.row] + "\n Nomor HP : " + nomorhp[indexPath.row] + "\n Paket Buffet : " +  paket[indexPath.row] + "\n Total Pembayaran : Rp.  " +  harga[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
              
                db.collection("buffet").document(docArray[indexPath.row]).delete() { err in
                if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Pembelian anda successfully removed!")
                    }
                }
                docArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "editBuffet", sender: indexPath)
    }

    // MARK: UIViewController methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editBuffet" {
            if segue.destination.isKind(of: EditBuffetController.self) {
                let secondVC = segue.destination as! EditBuffetController

                let indexPath = sender as! IndexPath

                secondVC.passedValue = docArray[indexPath.row]
            }
        }
    }
    
    
}

