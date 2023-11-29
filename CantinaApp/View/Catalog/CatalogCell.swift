import CantinaAssets
import CantinaClient
import SwiftUI

private enum Constants {
    static let aspectRatio: CGSize = .init(width: 106, height: 160)
}

struct CatalogCell: View {
    private let wine: WineOutputModel

    var body: some View {
        HStack(spacing: 16) {
            VStack {
                AsyncImage(url: wine.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                } placeholder: {
                    Asset.Icons.Tmp.bottleWineTMP.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .aspectRatio(Constants.aspectRatio, contentMode: .fit)
            .frame(maxWidth: Constants.aspectRatio.width, alignment: .top)

            VStack(spacing: 8) {
                Text(wine.name)
                    .font(Fonts.header3)
                    .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let subname = wine.subname {
                    Text(subname)
                        .font(Fonts.body1)
                        .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Text("\(wine.region) \n\(wine.brand)")
                    .font(Fonts.caption1)
                    .foregroundColor(Asset.Colors.elementsSecondary.swiftUIColor)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(L10n.Catalog.Item.status(wine.status.uppercased()))
                    .font(Fonts.body1)
                    .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Asset.Icons.grape.swiftUIImage

                    Text(wine.grape.capitalized)
                        .font(Fonts.body1)
                        .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Asset.Icons.glassWine.swiftUIImage

                    Text(wine.sweetness.capitalized)
                        .font(Fonts.body1)
                        .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Asset.Colors.surface.swiftUIColor)
        .padding(.top)
    }

    init(wine: WineOutputModel) {
        self.wine = wine
    }
}
