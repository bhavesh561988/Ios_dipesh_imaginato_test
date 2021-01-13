//
//  DairyService.swift
//  RealmDemo
//
//  Created by 46tech on 04/12/20.
//

import Foundation
import UIKit
import RxSwift

protocol SendDairyData {
    func fetchDairyData() -> Observable<[DairyData]>
}

class DairyService: SendDairyData{
    func fetchDairyData() -> Observable<[DairyData]> {
        return Observable.create { (observer) -> Disposable in
            
            let task = URLSession.shared.dataTask(with: URL(string: "https://private-ba0842-gary23.apiary-mock.com/notes")!) {
                data, _, _ in
                guard let data = data else{
                    observer.onError(NSError(domain: "Data not found", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let dairyData = try JSONDecoder().decode([DairyData].self, from: data)
                    observer.onNext(dairyData)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
