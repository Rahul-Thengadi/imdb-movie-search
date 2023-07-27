//
//  DetailListViewModel.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import Foundation

struct DetailListViewModel {
    var details = [Detail]()
    
    init(details: [Detail]) {
        self.details = details
    }
}

extension DetailListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return details.count
    }
    
    func detailAtIndexPath(_ index: Int) -> DetailViewModel {
        let detail = details[index]
        return DetailViewModel(detail: detail)
    }
}

struct DetailViewModel {
    let detail: Detail
}
