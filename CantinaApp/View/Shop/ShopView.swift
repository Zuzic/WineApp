import CantinaAssets
import CantinaClient
import SFSafeSymbols
import SwiftUI

struct ShopView: View {
    @ObservedObject private var viewModel: ShopViewModel
    @State private var canShowFilter: Bool = false

    init(viewModel: ShopViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack {
                if let shopFilterViewModel = viewModel.shopFilterViewModel {
                    ShopFilterTagView(viewModel: shopFilterViewModel)
                        .padding(.top)
                        .padding(.horizontal)
                }

                ScrollView(.vertical) {
                    if viewModel.filters.count > 1 {
                        LazyVGrid(columns: [.init()]) {
                            ForEach(viewModel.filters, id: \.countryName) { filter in
                                Text(filter.countryName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                    .font(Fonts.header2)
                                    .foregroundStyle(Asset.Colors.textSecondary.swiftUIColor)

                                countryCities(atFilter: filter)
                            }
                        }
                        .padding(.top, 20)
                    } else if let filter = viewModel.filters.first {
                        if !viewModel.isCitySelected {
                            Divider()
                            countryCities(atFilter: filter)
                        } else if let city = filter.cities.first {
                            shopAddresses(atCity: city)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .background(Asset.Colors.surface.swiftUIColor)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Asset.Icons.logo.swiftUIImage
                }

                ToolbarItem(placement: .principal) {
                    Text(L10n.Tab.shop)
                        .font(Fonts.header3)
                        .foregroundStyle(Asset.Colors.textHeader.swiftUIColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    filterNavbarIcon
                }
            }
            .adoptNavigationBar()
            .refreshable {
                viewModel.onRefresh()
            }
            .popover(isPresented: $canShowFilter) {
                VStack {
                    HStack {
                        Spacer()

                        Button {
                            canShowFilter.toggle()
                        } label: {
                            Label("", systemSymbol: .xmark)
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Asset.Colors.textHeader.swiftUIColor)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 32)
                    .frame(height: 32)

                    ShopFilterView(viewModel: viewModel.shopFilterViewModel)
                }
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
        .background(Asset.Colors.surface.swiftUIColor)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: -

private extension ShopView {
    var filterNavbarIcon: some View {
        HStack(spacing: 2) {
            Asset.Icons.filter.swiftUIImage

            if viewModel.filters.count == 1 {
                Text("1")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Asset.Colors.surface.swiftUIColor)
                    .font(Fonts.body1)
                    .background(Circle().fill(.black))
            }
        }
        .onTapGesture {
            canShowFilter.toggle()
        }
    }

    func shopAddresses(atCity: CityOutputModel) -> some View {
        LazyVGrid(columns: [.init()]) {
            ForEach(atCity.addresses, id: \.companyName) { address in
                VStack {
                    Divider()

                    Group {
                        Text(address.companyName + "\n")
                            .font(Fonts.button)
                            +
                            Text(address.address + "\n")
                            .font(Fonts.body1)
                            +
                            Text(address.zip ?? "")
                            .font(Fonts.body1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .textSelection(.enabled)
                }
            }
        }
    }

    func cityInfo(atCity: CityOutputModel) -> some View {
        return Text(atCity.name)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(Fonts.body1)
            .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
            .onTapGesture {
                viewModel.onSelect(city: atCity)
            }
    }

    func countryCities(atFilter: ShopFilterModel) -> some View {
        return LazyVGrid(columns: [.init()]) {
            ForEach(atFilter.cities, id: \.id) { city in
                cityInfo(atCity: city)
            }
        }
        .padding(.horizontal)
    }
}
