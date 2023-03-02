import CantinaAssets
import CantinaClient
import SwiftUI

private struct Constants {
    static let aspectRation: CGSize = .init(width: 360, height: 269)
    static let bottleAspectRation: CGSize = .init(width: 106, height: 160)
}

struct WineDetailsView: View {
    @State private var isPresentedDocg = false
    @Environment(\.presentationMode) var presentation
    @Environment(\.safeAreaEdgeInsets) var safeAreaInsets
    @ObservedObject private var viewModel: WineDetailsViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                Asset.Icons.Tmp.wineDetailsTMP.swiftUIImage
                    .resizable()
                    .aspectRatio(Constants.aspectRation, contentMode: .fit)
                
                HStack(spacing: 16) {
                    VStack {
                        AsyncImage(url: viewModel.wine.image) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        } placeholder: {
                            Asset.Icons.Tmp.bottleWineTMP.swiftUIImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .aspectRatio(Constants.bottleAspectRation, contentMode: .fit)
                    .frame(maxWidth: Constants.bottleAspectRation.width, alignment: .top)
                    
                    VStack(spacing: 4) {
                        Text( viewModel.wine.name)
                            .font(Fonts.header3)
                            .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if let subname = viewModel.wine.subname {
                            Text(subname)
                                .font(Fonts.body1)
                                .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Text("\(viewModel.wine.region) \n\(viewModel.wine.brand)")
                            .font(Fonts.caption1)
                            .foregroundColor(Asset.Colors.elementsSecondary.swiftUIColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(L10n.Catalog.Item.status(viewModel.wine.status.uppercased()))
                            .font(Fonts.body1)
                            .foregroundColor(Asset.Colors.accents.swiftUIColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .underline()
                            .onTapGesture {
                                isPresentedDocg.toggle()
                            }
                        
                        HStack {
                            Asset.Icons.grape.swiftUIImage
                            
                            Text(viewModel.wine.grape.capitalized)
                                .font(Fonts.body1)
                                .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Asset.Icons.glassWine.swiftUIImage
                            
                            Text(viewModel.wine.sweetness.capitalized)
                                .font(Fonts.body1)
                                .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, 32)
                
                ForEach(viewModel.wine.desc, id: \.title) { item in
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
            .padding(.top, safeAreaInsets.top)
        }
        .toolbar(.hidden, for: .tabBar)
        .edgesIgnoringSafeArea([.top])
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .sheet(isPresented: $isPresentedDocg) {
            if let statusDescription = viewModel.statusDescription {
                WineStatusDescriptionView(description: statusDescription)
            }
        }
        .transparentNavigationBar()
        .navigationBarBackButtonHidden()
        .background(Asset.Colors.surface.swiftUIColor)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    Asset.Icons.back.swiftUIImage
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    init(viewModel: WineDetailsViewModel) {
        self.viewModel = viewModel
    }
}

private struct WineStatusDescriptionView: View {
    private let description: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(L10n.Docg.title)
                .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                .font(Fonts.header3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 24)
            
            Text(description)
                .foregroundColor(Asset.Colors.textSecondary.swiftUIColor)
                .font(Fonts.body1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.all, 24)
    }
    
    init(description: String) {
        self.description = description
    }
}
