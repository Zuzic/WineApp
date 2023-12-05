import CantinaClient

extension Array where ArrayLiteralElement: CountryOutputModel {
    func shopFilters() -> [ShopFilterModel] {
        return reduce([ShopFilterModel]()) { partialResult, item in
            var resultItems = partialResult
            resultItems.append(.init(countryName: item.nameAndFlag, cities: item.cities))
            return resultItems
        }
    }
}
