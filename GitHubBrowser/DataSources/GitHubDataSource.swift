//
//  GitHubDataSource.swift
//  GitHubBrowser
//
//  Created by Sye Boddeus on 13/08/2017.
//  Copyright © 2017 Boddeus. All rights reserved.
//

import Alamofire

protocol RepoDataSource {
    func fetchPublicRepos(since: String?, completion: @escaping ([Repo]?, Error?) -> ())
    func fetchRepoDetails(url: URL, completion: @escaping(RepoDetailed?, Error?) -> ())
}

struct GitHubRepoDataSource: RepoDataSource {
    let baseUrlString = "https://api.github.com"

    func fetchPublicRepos(since: String?, completion: @escaping ([Repo]?, Error?) -> ()) {
        var request = "\(baseUrlString)/repositories"

        if let since = since {
            request += "?\(since)"
        }

        Alamofire.request(request).responseJSON { (response) in
            if let json = response.result.value {
                do {
                    let repos = try [Repo].decode(json)
                    completion(repos, nil)
                } catch (let e ) {
                    completion(nil, e)
                }
            }
        }
    }

    func fetchRepoDetails(url: URL, completion: @escaping (RepoDetailed?, Error?) -> ()) {
        Alamofire.request(url).responseJSON { (response) in
            if let json = response.result.value {
                do {
                    let repos = try RepoDetailed.decodeValue(json)
                    completion(repos, nil)
                } catch (let e) {
                    completion(nil, e)
                }
            }
        }
    }
}
