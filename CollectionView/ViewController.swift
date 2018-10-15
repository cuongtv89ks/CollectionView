//
//  ViewController.swift
//  CollectionView
//
//  Created by Olive Union on 14/10/2018.
//  Copyright © 2018 Olive Union. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView : UICollectionView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var CollectionData = ["1 🏆", "2 🐸", "3 🍩", "4 😸", "5 🤡", "6 👾", "7 👻", "8 🍖",
                          "9 🎸", "10 🐯", "11 🐷", "12 🌋"]
    
    @IBAction func addItem() {
        collectionView.performBatchUpdates({
            for _ in 0..<2 {
                let text = "\(CollectionData.count + 1) 🏓"
                CollectionData.append(text)
                let indexPath = IndexPath(row: CollectionData.count - 1, section: 0)
                collectionView.insertItems(at: [indexPath])
            }
            }, completion: nil)
    }
    
    @IBAction func deleteItem() {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map { $0.item }.sorted().reversed()
            for item in items {
                CollectionData.remove(at: item)
            }
            collectionView.deleteItems(at: selected)
        }
        navigationController?.isToolbarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width - 20 ) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        collectionView.refreshControl = refresh
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        navigationController?.isToolbarHidden = true
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addButton.isEnabled = !editing
        deleteButton.isEnabled = editing
        if !editing {
            navigationController?.isToolbarHidden = true
        }
        
        collectionView.indexPathsForSelectedItems?.forEach {
            collectionView.deselectItem(at: $0, animated: false)
        }
        
        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isEditing = editing
        }
    }
    
    @objc func refresh() {
        addItem()
        collectionView.refreshControl?.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let dest = segue.destination as? DetailViewController,
                let index = sender as? IndexPath {
                dest.selection = CollectionData[index.row]
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.titleLabel.text = CollectionData[indexPath.row]
        cell.isEditing = isEditing
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing {
            navigationController?.isToolbarHidden = false
            return
        }
        performSegue(withIdentifier: "DetailSegue", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0 {
            navigationController?.isToolbarHidden = true
        }
    }
    
    
}
