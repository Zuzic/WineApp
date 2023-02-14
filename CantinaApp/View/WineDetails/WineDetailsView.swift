import CantinaAssets
import CantinaClient
import SwiftUI

private struct Constants {
    static let aspectRation: CGSize = .init(width: 360, height: 269)
    static let bottleAspectRation: CGSize = .init(width: 81, height: 196)
}

struct WineDetailsView: View {
    @State private var isPresentedDocg = false
    @Environment(\.presentationMode) var presentation
    
    private let wine: WineOutputModel
    
    var body: some View {
        ScrollView {
            Asset.Icons.Tmp.wineDetailsTMP.swiftUIImage
                .aspectRatio(Constants.aspectRation, contentMode: .fit)
            
            HStack(spacing: 16) {
                AsyncImage(url: wine.image) { image in
                    image
                        .resizable()
                        .aspectRatio(Constants.bottleAspectRation, contentMode: .fit)
                        .frame(maxWidth: Constants.bottleAspectRation.width, alignment: .top)
                } placeholder: {
                    Asset.Icons.Tmp.bottleWineTMP.swiftUIImage
                        .resizable()
                        .aspectRatio(Constants.bottleAspectRation, contentMode: .fit)
                        .frame(maxWidth: Constants.bottleAspectRation.width, alignment: .top)
                }
                
                VStack(spacing: 4) {
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
                        .font(Fonts.caption)
                        .foregroundColor(Asset.Colors.elementsSecondary.swiftUIColor)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(L10n.Catalog.Item.status(wine.status.uppercased()))
                        .font(Fonts.body1)
                        .foregroundColor(Asset.Colors.accents.swiftUIColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .underline()
                        .onTapGesture {
                            isPresentedDocg.toggle()
                        }

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
            }
            .padding(.horizontal, 32)
            
            ForEach(wine.desc, id: \.title) { item in
                Text(item.title)
                    .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                    .font(Fonts.header3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(item.value)
                    .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .font(Fonts.body1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)
            }
            .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea([.top])
        .sheet(isPresented: $isPresentedDocg, content: DocgView.init)
        .transparentNavigationBar()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    Asset.Icons.back.swiftUIImage
                }

            }
        }
    }
    
    init(wine: WineOutputModel) {
        self.wine = wine
    }
}

struct DocgView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(L10n.Docg.title)
                .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                .font(Fonts.header3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 24)
            
            Text(L10n.Docg.desc)
                .foregroundColor(Asset.Colors.textSecondary.swiftUIColor)
                .font(Fonts.body1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.all, 24)
    }
}