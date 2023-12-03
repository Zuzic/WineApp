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
                ScrollView(.vertical) {
                    LazyVGrid(columns: [.init()]) {
                        ForEach(viewModel.filters, id: \.countryName) { filter in
                            Text(filter.countryName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .font(Fonts.header2)
                                .foregroundStyle(Asset.Colors.textSecondary.swiftUIColor)

                            if filter.cities.count > 1 {
                                LazyVGrid(columns: [.init()]) {
                                    ForEach(filter.cities, id: \.id) { city in
                                        Text(city.name)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(Fonts.body1)
                                            .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                                            .onTapGesture {
                                                viewModel.onSelect(city: city)
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            } else if let city = filter.cities.first {
                                shopAddresses(at: city)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 20)
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

    func shopAddresses(at city: CityOutputModel) -> some View {
        LazyVGrid(columns: [.init()]) {
            ForEach(city.addresses, id: \.companyName) { address in
                VStack {
                    Divider()

                    Text(address.companyName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Fonts.body1)
                        .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)

                    Text(address.address)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Fonts.body1)
                        .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)

                    if let zip = address.zip {
                        Text(zip)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Fonts.body1)
                            .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                    }
                }
            }
        }
    }
}
