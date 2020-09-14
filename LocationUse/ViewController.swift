//
//  ViewController.swift
//  LocationUse
//
//  Created by 김현수 on 2020/09/14.
//  Copyright © 2020 Hyun Soo Kim. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    //위치 정보를 사용을 위한 객체를 생성
    var locationManager: CLLocationManager = CLLocationManager()
    //시작 위치를 저장할 변수를 선언
    var startLocation: CLLocation!

    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblAltitude: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    @IBAction func locationInfo(_ sender: Any) {
        //이벤트가 발생한 객체 찾아오기
        let btn = sender as! UIButton
        
        //버튼의 타이틀에 따라 다른 동작
        if btn.title(for: .normal) == "위치정보수집시작" {
            //위치정보 수집 시작
            locationManager.startUpdatingLocation()
            
            btn.setTitle("위치정보 수집종료", for: .normal)
        } else {
            //위치정보 수집 종료
            locationManager.stopUpdatingLocation()
            
            btn.setTitle("위치정보 수집시작", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //정밀도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //delegate 설정
        locationManager.delegate = self
        //위치정보 사용 여부 설정 - 실행 중에만 사용
        locationManager.requestWhenInUseAuthorization()
    }
}

extension ViewController: CLLocationManagerDelegate {
    //위치정보가 갱신되었을 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //가장 마지막에 저장된 위치 정보 가져오기
        let latestLocation = locations[locations.count - 1]
        //위치 정보를 가져와서 출력
        lblLatitude.text = String(format: "%.4f", latestLocation.coordinate.latitude)
        lblLatitude.text = String(format: "%.4f", latestLocation.coordinate.longitude)
        lblLatitude.text = String(format: "%.4f", latestLocation.altitude)
        
        //첫번째 위치 정보를 저장
        if startLocation == nil {
            startLocation = latestLocation
        }
        
        //거리 계산
        let distanceBetween = latestLocation.distance(from: startLocation)
        lblDistance.text = String(format: "%.2f", distanceBetween)
    }
}
