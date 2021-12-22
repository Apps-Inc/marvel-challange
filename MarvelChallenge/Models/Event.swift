//
//  Event.swift
//  MarvelChallenge
//
//  Created by DIOGO OLIVEIRA NEISS on 22/12/21.
//
import Foundation

// MARK: - EventsMainRequest
struct EventsMainRequest: Codable {
    let code, status, copyright, attributionText: String
    let attributionHTML: String
    let data: EventsDataWrapper
    let etag: String
}
// MARK: - EventsDataWrapper
struct EventsDataWrapper: Codable {
    let offset, limit, total, count: String
    let results: [Event]
}
// MARK: - Event
struct Event: Codable {
    let id, title, resultDescription, resourceURI: String
    let urls: [URLElement]
    let modified, start, end: String
    let thumbnail: Thumbnail
    let comics: Comics
    let stories: Stories
    let series: Comics
    let characters, creators: Characters
    let next, previous: Next
    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, urls, modified,
             start, end, thumbnail, comics, stories,
             series, characters, creators, next, previous
    }
}
// MARK: - Characters
struct Characters: Codable {
    let available, returned, collectionURI: String
    let items: [CharactersItem]
}
// MARK: - CharactersItem
struct CharactersItem: Codable {
    let resourceURI, name, role: String
}
// MARK: - Comics
struct Comics: Codable {
    let available, returned, collectionURI: String
    let items: [Next]
}
// MARK: - Next
struct Next: Codable {
    let resourceURI, name: String
}
// MARK: - Stories
struct Stories: Codable {
    let available, returned, collectionURI: String
    let items: [StoriesItem]
}
// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI, name, type: String
}
// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path, thumbnailExtension: String
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
// MARK: - URLElement
struct URLElement: Codable {
    let type, url: String
}
