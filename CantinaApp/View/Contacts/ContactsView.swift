import CantinaAssets
import SwiftUI

private enum Constants {
    static let aspectRation: CGSize = .init(width: 390, height: 264)
    static let horizontalPadding: CGFloat = 24
}

struct ContactsView: View {
    @ObservedObject private var viewModel: ContactsViewModel
    @Environment(\.openURL) var openURL

    @State private var screenWidth: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Asset.Icons.Tmp.contactsTMP.swiftUIImage
                .resizable()
                .frame(height: 264)
                .aspectRatio(Constants.aspectRation, contentMode: .fill)
                .clipped()

            Text(viewModel.contactsInfo?.name ?? "")
                .font(Fonts.header3)
                .foregroundStyle(Asset.Colors.textHeader.swiftUIColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Constants.horizontalPadding)
                .padding(.top, 16)

            Spacer()

            Text(viewModel.contactsInfo?.address ?? "")
                .font(Fonts.body1)
                .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Constants.horizontalPadding)
                .padding(.bottom, 24)

            VStack {
                contactItem(icon: Asset.Icons.Contacts.phone.swiftUIImage,
                            text: viewModel.contactsInfo?.phone)
                    .onTapGesture {
                        guard let call = viewModel.callURL else { return }
                        openURL(call)
                    }

                contactItem(icon: Asset.Icons.Contacts.fax.swiftUIImage,
                            text: viewModel.contactsInfo?.fax)
                    .onTapGesture {
                        guard let call = viewModel.faxURL else { return }
                        openURL(call)
                    }

                contactItem(icon: Asset.Icons.Contacts.email.swiftUIImage,
                            text: viewModel.contactsInfo?.email)
                    .onTapGesture {
                        guard let email = viewModel.mailURL else { return }
                        openURL(email)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.bottom, 24)

            HStack(spacing: 16) {
                Text(L10n.Contacts.followUs)
                    .font(Fonts.body1)
                    .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)

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
            .padding(.horizontal, Constants.horizontalPadding)

            Spacer()

            DevelopedByView()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, Constants.horizontalPadding)
                .padding(.bottom, 8)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Asset.Colors.surface.swiftUIColor)
        .onAppear {
            viewModel.onAppear()
        }
        .refreshable {
            viewModel.onRefresh()
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
                .foregroundStyle(Asset.Colors.accents.swiftUIColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
