//
//  ViewController.swift
//  EncodeDecodeDemo
//
//  Created by shailesh parkhi on 4/4/19.
//  Copyright © 2019 Shailesh Parkhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let employee = Employee(name: "shailesh", number: 20, favoriteGift: Toy(toyName: "train"))
        
        let encoder = JSONEncoder()
        let encodedData = try? encoder.encode(employee)
        let encodedString = String(data: encodedData!, encoding: .utf8)
        print(encodedData!)
        print(encodedString!)
       let decoder = JSONDecoder()
       let decodedData = try! decoder.decode(Employee.self, from: encodedData!)
       print(decodedData)
        
    }


}

struct Employee{
    let name : String
    let number :Int
    let favoriteGift : Toy
    
    enum CodingKeys:String,CodingKey {
        case name
        case number = "employeeNumber"
        case gift
    }
}

struct Toy : Codable{
    let toyName : String
}

extension Employee : Encodable {
    
    func encode(to encoder: Encoder){
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(name, forKey: .name)
        try? container.encode(number, forKey: .number)
        try? container.encode(favoriteGift.toyName, forKey: .gift)
    }

}

extension Employee :Decodable {
    init(from decoder: Decoder){
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        name = try! values!.decode(String.self, forKey:.name)
        number = try! (values?.decode(Int.self, forKey: .number))!
        let gift = try! values?.decode(String.self, forKey: .gift)
        favoriteGift = Toy(toyName: gift!)
        
    }
}
