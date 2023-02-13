import CantinaAssets
import CantinaClient
import SwiftUI

private struct Constants {
    static let aspectRation: CGSize = .init(width: 81, height: 196)
}

struct CatalogCell: View {
    private let wine: WineOutputModel
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: wine.image) { image in
                image
                    .resizable()
                    .aspectRatio(Constants.aspectRation, contentMode: .fit)
                    .frame(maxWidth: Constants.aspectRation.width, alignment: .top)
            } placeholder: {
                Asset.Icons.Tmp.bottleWineTMP.swiftUIImage
                    .resizable()
                    .aspectRatio(Constants.aspectRation, contentMode: .fit)
                    .frame(maxWidth: Constants.aspectRation.width, alignment: .top)
            }
            
            VStack(spacing: 8) {
                Text(wine.name)
                    .font(Fonts.header3)
                    .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(wine.region) \n\(wine.brand)")
                    .font(Fonts.caption)
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
    }
    
    init(wine: WineOutputModel) {
        self.wine = wine
    }
}
