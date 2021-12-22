//
//  Event.swift
//  MarvelChallenge
//
//  Created by DIOGO OLIVEIRA NEISS on 22/12/21.
//
import Foundation

// MARK: Models

struct EventModel: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: URL?
    let urls: [UrlModel]?
    let modified: Date?
    let start: Date?
    let end: Date?
    let thumbnail: ImageModel?
    let comics: ComicListModel?
    let stories: StoryListModel?
    let series: SeriesListModel?
    let characters: CharacterListModel?
    let creators: CreatorListModel?
    let next: EventSummaryModel?
    let previous: EventSummaryModel?
}

struct ImageModel: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct UrlModel: Codable {
    let type: String?
    let url: URL?
}

// MARK: Containers

struct EventDataWrapperModel: Codable {
    let code: Int?
    let status: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: EventDataContainerModel?
    let etag: String?
}

struct EventDataContainerModel: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [EventModel]?
}

// MARK: Lists

struct CharacterListModel: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: URL?
    let items: [CharacterSummaryModel]?
}

struct CreatorListModel: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: URL?
    let items: [CreatorSummaryModel]?
}

struct ComicListModel: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: URL?
    let items: [ComicSummaryModel]?
}

struct SeriesListModel: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: URL?
    let items: [SeriesSummaryModel]?
}

struct StoryListModel: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: URL?
    let items: [StorySummaryModel]?
}

// MARK: Summaries

struct CharacterSummaryModel: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?
}

struct CreatorSummaryModel: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?
}

struct ComicSummaryModel: Codable {
    let resourceURI: URL?
    let name: String?
}

struct EventSummaryModel: Codable {
    let resourceURI: URL?
    let name: String?
}

struct SeriesSummaryModel: Codable {
    let resourceURI: URL?
    let name: String?
}

struct StorySummaryModel: Codable {
    let resourceURI: URL?
    let name: String?
    let type: String? // TODO: pode ser um enum (internal, cover)
}
