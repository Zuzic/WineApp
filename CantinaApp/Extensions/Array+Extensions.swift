import CantinaClient

extension Array where ArrayLiteralElement: CountryOutputModel {
    func shopFilters() -> [ShopFilterModel] {
        return reduce([ShopFilterModel]()) { partialResult, item in
            var resultItems = partialResult
            resultItems.append(.init(countryName: item.name, cities: item.cities))
            return resultItems
        }
    }
}
