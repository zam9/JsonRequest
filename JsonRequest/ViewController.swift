//
//  ViewController.swift
//  JsonRequest
//
//  Created by Zam on 18.09.2022.
//

import UIKit

class ViewController: UIViewController {

    let urlString = "https://jsonplaceholder.typicode.com/comments?postId="
    
    @IBOutlet weak var postView: UITextView!
    @IBOutlet weak var postNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func getPostBtnAction(_ sender: UIButton) {
        if let number = Int(postNumberField.text ?? "0"), number >= 1 && number <= 100 {
            let postNumber = String(number)
            getPost(postNumber)
        } else {
            postView.text = "Please enter number from 1 to 100"
        }
    }
    
    func getPost(_ postNumber: String) {
        guard let requestUrl = URL(string: urlString + postNumber) else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                  let dataString = String(data: data, encoding: .utf8),
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else { return }
            DispatchQueue.main.async {
                self.postView.text = dataString
            }
        }
        task.resume()
    }
}

