//
//  MainViewController.swift
//  CopaAmericav2
//
//  Created by Herman on 7/23/19.
//  Copyright © 2019 Apimovil. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,URLSessionDelegate {
    
   
    @IBOutlet var CollectionViewMain: UICollectionView!
    let jsonUrlString = "https://api.myjson.com/bins/gaenp"
    
    var partidosServices:PartidoServiceProtocol = PartidoService()
    lazy var partidos:[Partido] = []
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        floatButtonScanner.layer.cornerRadius = floatButtonScanner.frame.height/2
        loadPartidos()
    }*/
    
    func loadPartidos() {
        partidosServices.getPartido(with: jsonUrlString) {
            (listPartidos, error) in
            if error != nil { // Deal with error here
                print("error")
                return
            }else if let listPartidos = listPartidos{
                //print("=======================================")
                //print(listPartidos)
                self.partidos = listPartidos
                self.agregarImg()
            }
        }
    }
    
    func agregarImg() {
        for index in 0...(partidos.count-1){
            partidosServices.getImagePartido(with: partidos[index].urlFlagTeam1!)  {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.partidos[index].flagTeam1 = img
                }
                //self.collectionViewMain.reloadData()
            }
            partidosServices.getImagePartido(with: partidos[index].urlFlagTeam2!) {
                (img, error) in
                if error != nil { // Deal with error here
                    print("error")
                    return
                }else if let img = img{
                    self.partidos[index].flagTeam2 = img
                }
                self.CollectionViewMain.reloadData()
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partidos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewMain.dequeueReusableCell(withReuseIdentifier: "CeldaMain", for: indexPath) as! MainCollectionViewCell
        cell.team1.text = partidos[indexPath.item].team1
        cell.team2.text = partidos[indexPath.item].team2
        cell.score.text = partidos[indexPath.item].score
        cell.imgTeam1.image = partidos[indexPath.item].flagTeam1
        cell.imgTeam2.image = partidos[indexPath.item].flagTeam2
        print("para cada imagen",partidos[indexPath.item].flagTeam1)
        return cell
    }
    
    
    
    
    
    
}




