//
//  SampleViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by jack on 2023/09/12.
//

import UIKit

struct User {
    let name: String
    let age: Int
    
    var introduce: String {
        return  "\(name), \(age)살"
    }
}

class SampleViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel = SampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        var number1 = 10
        var number2 = 3
        
        print(number1 - number2) //7
        
        number1 = 3
        number2 = 1
        
        //
        
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        number3.bind { number in
            print("Observable", number3.value - number4.value)
        }
        
        number3.value = 100
        number3.value = 500
        number3.value = 50
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
//        let data = viewModel.cellForRowAt(at: indexPath)
//        cell.textLabel?.text = data.introduce

        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = "테스트" //textLabel
        content.secondaryText = "안녕하세요 \(indexPath.row)" //detailTextLabel
//        UIListContentConfiguration
//        UIContentConfiguration
        cell.contentConfiguration = content //Protocol as Type
        return cell
    }
}

