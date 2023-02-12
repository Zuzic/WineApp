import CantinaAssets
import SwiftUI

private struct Constants {
    static let aspectRation: CGSize = .init(width: 390, height: 264)
}

struct ContactsView: View {
    @ObservedObject private var viewModel: ContactsViewModel
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Asset.Icons.Tmp.contactsTMP.swiftUIImage
                    .aspectRatio(Constants.aspectRation, contentMode: .fit)
                
                Text(viewModel.contactsInfo?.name ?? "")
                    .font(Fonts.header3)
                    .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                    .padding(.top, 16)
                
                Text(viewModel.contactsInfo?.address ?? "")
                    .font(Fonts.body1)
                    .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                
                VStack {
                    contactItem(icon: Asset.Icons.Contacts.phone.swiftUIImage,
                                text: viewModel.contactsInfo?.phone)
                    .onTapGesture {
                        guard let call = viewModel.callURL else { return }
                        openURL(call)
                    }
                    
                    contactItem(icon: Asset.Icons.Contacts.fax.swiftUIImage,
                                text: viewModel.contactsInfo?.fax)
                    
                    contactItem(icon: Asset.Icons.Contacts.email.swiftUIImage,
                                text: viewModel.contactsInfo?.email)
                    .onTapGesture {
                        guard let email = viewModel.mailURL else { return }
                        openURL(email)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
                
                HStack(spacing: 16) {
                    Text(L10n.Contacts.followUs)
                        .font(Fonts.body1)
                        .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                    
                    HStack(spacing: 16) {
                        Asset.Icons.Contacts.facebook.swiftUIImage
                            .onTapGesture {
                                guard let facebook = viewModel.contactsInfo?.facebook,
                                      let url = URL(string: facebook) else { return }
                                openURL(url)
                            }
                        
                        Asset.Icons.Contacts.instagram.swiftUIImage
                            .onTapGesture {
                                guard let instagram = viewModel.contactsInfo?.instagram,
                                      let url = URL(string: instagram) else { return }
                                openURL(url)
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
            }
            .ignoresSafeArea()
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    init(viewModel: ContactsViewModel) {
        self.viewModel = viewModel
    }
}

private extension ContactsView {
    func contactItem(icon: Image, text: String?) -> some View {
        HStack(spacing: 16) {
            icon
            
            Text(text ?? "")
                .font(Fonts.body1)
                .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
