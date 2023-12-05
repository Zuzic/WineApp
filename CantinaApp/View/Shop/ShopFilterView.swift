import CantinaAssets
import CantinaClient
import SwiftUI

struct ShopFilterView: View {
    @ObservedObject private var viewModel: ShopFilterViewModel

    init(viewModel: ShopFilterViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack {
                Text(L10n.Filter.Header.title)
                    .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .font(Fonts.body1)

                Spacer()

                if viewModel.country != nil {
                    Button {
                        viewModel.reset()
                    } label: {
                        Text(L10n.Filter.Header.clear)
                            .foregroundStyle(Asset.Colors.accents.swiftUIColor)
                            .font(Fonts.body1)
                    }
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 32)
            .padding(.bottom, 8)

            ScrollView {
                VStack(spacing: 16) {
                    ShopCountriesFilterView(viewModel: viewModel)
                    ShopStatesFilterView(viewModel: viewModel)
                    ShopCitiesFilterView(viewModel: viewModel)
                }
            }
        }
    }
}

// MARK: -

private struct CheckboxFilterView: View {
    private let checkboxAspectRatio: CGSize = .init(width: 20, height: 20)
    private let condition: Bool

    init(condition: Bool) {
        self.condition = condition
    }

    var body: some View {
        if condition {
            Asset.Icons.Checkbox.checkboxOn.swiftUIImage
                .aspectRatio(checkboxAspectRatio, contentMode: .fit)
                .frame(maxWidth: checkboxAspectRatio.width)
        } else {
            Asset.Icons.Checkbox.checkboxOff.swiftUIImage
                .aspectRatio(checkboxAspectRatio, contentMode: .fit)
                .frame(maxWidth: checkboxAspectRatio.width)
        }
    }
}

// MARK: -

private struct ShopCountriesFilterView: View {
    @ObservedObject private var viewModel: ShopFilterViewModel

    init(viewModel: ShopFilterViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        LazyVGrid(columns: [.init()]) {
            Divider()

            Text(L10n.Shop.Filter.country)
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(viewModel.countries, id: \.name) { country in
                HStack {
                    CheckboxFilterView(condition: country.name == viewModel.country?.name)

                    Text(country.name)
                        .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                        .font(Fonts.body1)

                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    viewModel.select(country: country)
                }
            }
        }
        .padding(.horizontal, 32)
    }
}

// MARK: -

private struct ShopStatesFilterView: View {
    @ObservedObject private var viewModel: ShopFilterViewModel

    init(viewModel: ShopFilterViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if let states = viewModel.country?.states,
               let first = states.first,
               first.type != .other
            {
                Divider()

                Text(L10n.Shop.Filter.state)
                    .frame(maxWidth: .infinity, alignment: .leading)

                LazyVGrid(columns: [.init(), .init(), .init()]) {
                    ForEach(states, id: \.state) { item in
                        HStack {
                            CheckboxFilterView(condition: item.state == viewModel.state?.state)

                            Text(item.state)
                                .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                                .font(Fonts.body1)

                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            viewModel.select(state: item)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 32)
    }
}

// MARK: -

private struct ShopCitiesFilterView: View {
    @ObservedObject private var viewModel: ShopFilterViewModel

    init(viewModel: ShopFilterViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if let cities = viewModel.state?.cities {
                Divider()

                Text(L10n.Shop.Filter.city)
                    .frame(maxWidth: .infinity, alignment: .leading)

                LazyVGrid(columns: [.init()]) {
                    ForEach(cities, id: \.id) { item in
                        HStack {
                            CheckboxFilterView(condition: item.name == viewModel.city?.name)

                            Text(item.name)
                                .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                                .font(Fonts.body1)

                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            viewModel.select(city: item)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 32)
    }
}
