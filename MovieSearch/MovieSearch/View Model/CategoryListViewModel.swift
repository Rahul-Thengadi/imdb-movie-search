//
//  CategoryListViewModel.swift
//  MovieSearch
//
//  Created by Rahul Thengadi on 30/03/22.
//

import Foundation

// MARK: CategoryListViewModel
struct CategoryListViewModel {
    var categories: [Category] = Category.allCases
}

extension CategoryListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return categories.count
    }
    
    func categoryAtIndexPath(_ index: Int) -> CategoryViewModel {
        let category = self.categories[index]
        return CategoryViewModel(category: category)
    }
}

// MARK: CategoryViewModel
struct CategoryViewModel {
    let category: Category
    
    var currentCategory: Category {
        return category
    }
}
