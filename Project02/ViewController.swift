//
//  ViewController.swift
//  Project02
//
//  Created by Manmohan Singh on 2022-12-02.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController , UITextViewDelegate, CLLocationManagerDelegate, UIToolbarDelegate{
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var list: UITableView!
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        setupMap()
        addAnnotation(location: CLLocation(latitude: 42.983612, longitude: -81.249725))
//        loadWeather(search: title)
        
        
    }
    
    
    @IBAction func button(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    
    private func setupMap() {
        mapView.delegate = self
        let location = CLLocation(latitude: 42.983612, longitude: -81.249725)
        let region = MKCoordinateRegion.init(center: location.coordinate,
                                             latitudinalMeters: 10000,
                                             longitudinalMeters: 10000)
        
        mapView.setRegion(region, animated: true)
        
        
        
    }
    
    private func addAnnotation(location: CLLocation) {
        let annotation = MyAnnotation(coordinate: location.coordinate, title: "My title", glyphtext: "L")
        mapView.addAnnotation(annotation)
       // self.loadWeather(search: St)
        
    }
    

    
    }
//extension ViewController: UITableViewDelegate {
//    func tableView(_tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        return loadWeather(search: )
//    }
//    private func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let weatherObject = loadWeather[indexPath.row]
//    }
//
//}
    extension ViewController: MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "What is this?"
            let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            
            view.calloutOffset = CGPoint(x: 0, y: 10)

            
            let button = UIButton(type: .detailDisclosure)
            view.rightCalloutAccessoryView = button
            
            let image = UIImage(systemName: "graduationcap.circle.fill")
            view.leftCalloutAccessoryView = UIImageView(image: image)
            
            view.markerTintColor = UIColor.brown
            
            if let myAnnotation = annotation as? MyAnnotation {
                view.glyphText = myAnnotation.glyphText
            }
            
            return view
        }
//        private func loadWeather(search: String?){
//            guard let search = search else{
//                return
//            }
//
//            guard  let url = getURL(query: search) else {
//                print("Could not get URL")
//                return
//            }
//            let session = URLSession.shared
//
//            let dataTask = session.dataTask(with: url) {data, response, error in
//                print("Network call completed")
//
//                guard error == nil else{
//                    print("recieved error")
//                    return
//                }
//                guard let data = data else{
//                    print("No data found")
//                    return
//                }
//
//                if let weatherResponse = self.parseJson(data: data) {
//                    print(weatherResponse.location.name)
//                    print(weatherResponse.current.temp_c)
//    //                print(weatherResponse.current.condition.text)
//    //                print(weatherResponse.current.condition.code.image)
//
//                    DispatchQueue.main.sync {
//                        self.title = weatherResponse.current.condition.text
//    //                    self.temprature.text = "\(weatherResponse.current.temp_c)C"
//    //                    self.condition.text = weatherResponse.current.condition.text
//    //                    self.image1.image = weatherResponse.current.condition.code.image
//                    }
//                }
//            }
//
//            dataTask.resume()
//        }
//        private func getURL(query: String) -> URL? {
//            let baseUrl = "https://api.weatherapi.com/v1/"
//            let currentEndpoint = "current.json"
//            let apiKey = "fcf05284ee914501ad775107222511"
//            guard let url = "\(baseUrl)\(currentEndpoint)?key=\(apiKey)&q=\(query)"
//                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//                return nil
//            }
//            print(url)
//            return URL(string: url)
//        }
//        private func parseJson(data: Data) -> weatherResponse? {
//            let decoder = JSONDecoder()
//            var weather: weatherResponse?
//
//            do{
//                weather = try decoder.decode(weatherResponse.self, from: data)
//            }
//            catch{
//                print("Error decoding")
//            }
//            return weather
//        }
//        struct weatherResponse: Decodable {
//            let location: Location
//            let current: weather
//        }
//        struct Location: Decodable {
//            let name: String
//        }
//        struct weather: Decodable {
//            let temp_c: Float
//            let temp_f: Float
//            let condition: Condition
//        }
//        struct Condition: Decodable {
//            let text: String
//        }
        }
        
        class MyAnnotation: NSObject, MKAnnotation {
            var coordinate: CLLocationCoordinate2D
            var title: String?
            var glyphText: String?
            
            init(coordinate: CLLocationCoordinate2D, title: String, glyphtext: String? = nil) {
                self.coordinate = coordinate
                self.title = title
                self.glyphText = glyphtext
                super.init()
            }
        }



    


