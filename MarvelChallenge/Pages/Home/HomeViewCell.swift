//
//  HomeViewCell.swift
//  MarvelChallenge
//
//  Created by DIOGO OLIVEIRA NEISS on 22/12/21.
//

import SwiftUI
import Kingfisher

struct CellInLineView: View {
     let event: EventModel

    var body: some View {
        HStack {
            AvatarView(image: event.thumbnail)
                .scaledToFit()
                .frame(maxWidth: 100)

            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 2) {
                    Spacer()
                    Text(event.title ?? "")
                        .font(.body)
                        .bold()
                        .textCase(.uppercase)
                        .lineLimit(1)
                    if
                        let start = event.start,
                        let end = event.end {
                        Text("\(start.asLocalFormat(date: .short)) - \(end.asLocalFormat(date: .short))")
                    } else {
                        Spacer()
                    }
                    HStack {
                        if let comics = event.comics?.available {
                            Image(systemName: "book")
                            Text(String(comics))
                        }
                    }
                    .padding(.bottom)
                }
            }
            Spacer()
        }
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.horizontal, 8)
    }
 }

struct CellCardView: View {
    let event: EventModel

    var body: some View {
        VStack {
            AvatarView(image: event.thumbnail)
            Text(event.title ?? "")
                .font(.body)
                .bold()
                .multilineTextAlignment(.center)
                .textCase(.uppercase)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
            if
                let start = event.start,
                let end = event.end {
                Text("\(start.asLocalFormat(date: .short)) - \(end.asLocalFormat(date: .short))")
                    .padding(.bottom)
            }

            Spacer()

        }
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.horizontal, 4)
        .frame(width: 200, height: 300)
    }
}

struct AvatarView: View {
    let urlAdress: String?

    init(image: ImageModel?) {
        if
            let path = image?.path,
            let ext = image?.thumbnailExtension {
            let safePath = path.replacingOccurrences(of: "http://",
                                                     with: "https://")
            urlAdress = safePath + "." + ext
        } else {
            urlAdress = nil
        }
    }

    var body: some View {
        if let urlAdress = urlAdress,
           let url = URL(string: urlAdress) {
            KFImage(url).placeholder { paceHolder }
                .resizable()
                .scaledToFit()
        } else {
            paceHolder
        }
    }

    var paceHolder: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .colorMultiply(Color(.sRGB, white: 1, opacity: 0.3))
    }
}

extension Date {
    func asLocalFormat(date: DateFormatter.Style = .none, time: DateFormatter.Style = .none) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = date
        formatter.timeStyle = time

        return formatter.string(from: self)
    }
}
