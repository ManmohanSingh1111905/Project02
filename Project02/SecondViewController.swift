//
//  SecondViewController.swift
//  Project02
//
//  Created by Manmohan Singh on 2022-12-04.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var loaction: UILabel!
    @IBOutlet weak var searchLocation: UITextField!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var imageCond: UIImageView!
    @IBOutlet weak var temp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
     @IBAction func addLocation(_ sender: Any) {
         loadWeather(search: searchLocation.text)
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    private func loadWeather(search: String?){
    guard let search = search else{
        return
    }
    
    guard  let url = getURL(query: search) else {
        print("Could not get URL")
        return
    }
    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: url) {data, response, error in
        print("Network call completed")
        
        guard error == nil else{
            print("recieved error")
            return
        }
        guard let data = data else{
            print("No data found")
            return
        }
        
        if let weatherResponse = self.parseJson(data: data) {
            print(weatherResponse.location.name)
            print(weatherResponse.current.temp_c)
            print(weatherResponse.current.condition.text)
           
            
            DispatchQueue.main.sync {
                self.loaction.text = weatherResponse.location.name
                self.temp.text = "\(weatherResponse.current.temp_c)C"
                self.condition.text = weatherResponse.current.condition.text
               

            }
        }
    }
    
    dataTask.resume()
}

private func getURL(query: String) -> URL? {
    let baseUrl = "https://api.weatherapi.com/v1/"
    let currentEndpoint = "current.json"
    let apiKey = "fcf05284ee914501ad775107222511"
    guard let url = "\(baseUrl)\(currentEndpoint)?key=\(apiKey)&q=\(query)"
        .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        return nil
    }
    print(url)
    return URL(string: url)
}
private func parseJson(data: Data) -> weatherResponse? {
    let decoder = JSONDecoder()
    var weather: weatherResponse?
    
    do{
        weather = try decoder.decode(weatherResponse.self, from: data)
    }
    catch{
        print("Error decoding")
    }
    return weather
}
}
struct weatherResponse: Decodable {
    let location: Location
    let current: weather
}
struct Location: Decodable {
    let name: String
}
struct weather: Decodable {
    let temp_c: Float
    let temp_f: Float
    let condition: weatherCondition
}
struct weatherCondition: Decodable {
let text: String
let code: Int
    }

//enum Code: String, Decodable {
//case partlyCloud = "1003"
//
//var image: UIImage {
//    switch self {
//    case .partlyCloud:
//        return UIImage(systemName: "cloud.fill") ?? self.image
//
//    }
//}
//}

    


