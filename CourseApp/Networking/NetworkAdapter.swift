//
//  NetworkAdapter.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//


import Foundation
import Moya
import KVSpinnerView

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

extension TargetType {
    func provider<T: TargetType>() -> MoyaProvider<T> {
        return MoyaProvider<T>(plugins: [(NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter))])
    }
    
    func request(success successCallBack: @escaping (Any?) -> Void, error errorCallBack: ((String?) -> Void)? = nil) {
        KVSpinnerView.settings.spinnerRadius = 32
        KVSpinnerView.settings.linesWidth = 4
        KVSpinnerView.settings.tintColor = R.color.colorAppPrimary() ?? .white
        KVSpinnerView.settings.backgroundOpacity = 1.0
        KVSpinnerView.settings.backgroundRectColor = UIColor.white
        handleLoader()
        provider().request(self) { (result) in
            //Hide Loader after getting response
            UIApplication.shared.endIgnoringInteractionEvents()
            KVSpinnerView.dismiss()
            
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200, 201:
                    let model = self.parseModel(data: response.data)
                    successCallBack(model)
                case 401:
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                        Toast.shared.showAlert(type: .apiFailure, message: /(json?["message"] as? String))
                        errorCallBack?(/(json?["message"] as? String))
                    } catch {
                        Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                    }
                    
                    //perfoem session expired actions
                    
                case 400, 409, 500:
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                        Toast.shared.showAlert(type: .apiFailure, message: /(json?["message"] as? String))
                        errorCallBack?(/(json?["message"] as? String))
                    } catch {
                        Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                    }
                default:
                    Toast.shared.showAlert(type: .apiFailure, message: "Error Default")
                }
            case .failure(let error):
                Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                errorCallBack?(error.localizedDescription)
            }
        }
    }
    
    func handleLoader() {
        switch self {
//        case is HomeEP:
//            UIApplication.shared.beginIgnoringInteractionEvents()
//            if UserPreference.shared.data == nil {
//                
//            }
        default:
            KVSpinnerView.show()
        }
        
    }
}
