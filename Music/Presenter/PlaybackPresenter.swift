//
//  PlaybackPresenter.swift
//  Music
//
//  Created by Dalveer singh on 15/07/21.
//
import UIKit
import AVFoundation
protocol PlayerDataSource:AnyObject{
    var songName:String? {get}
    var subtitle:String? {get}
    var imageURL:URL?{get}
}

// one presenter in app to play song so made this class 
final class PlaybackPresenter{
    static let shared = PlaybackPresenter()
    private var track:AudioTrack?
    private var tracks = [AudioTrack]()
    var player:AVPlayer?
    var playerQueue:AVQueuePlayer?
    var currentTrack:AudioTrack?{
        if let track = track, tracks.isEmpty{
            return track
        }
        else if let player = self.playerQueue,!tracks.isEmpty{
            let item = player.currentItem
            let items = player.items()
            guard let index = items.firstIndex(where: {$0==item}) else
            {
                return nil
            }
            return tracks[index]
        }
        return nil
    }
     func startPlaying(from viewController:UIViewController,track:AudioTrack){
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        let vc = PlayerViewController()
        vc.datasouce = self
        vc.delegate = self
        vc.title = track.name
        self.track = track
        self.tracks = []
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: { [weak self] in
            self?.player?.play()
        })
    }
     func startPlaying(from viewController:UIViewController,tracks:[AudioTrack]){
        
        let vc = PlayerViewController()
        self.track = nil
        self.tracks = tracks
        let items:[AVPlayerItem] = tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else {return nil}
            return AVPlayerItem(url: url)
        })
        self.playerQueue?.play()
        self.playerQueue = AVQueuePlayer(items: items)
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
}
extension PlaybackPresenter:PlayerViewControllerDelegate{
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
    
    func didTapPlayAndPause() {
        if let player = player{
            if player.timeControlStatus == .playing{
                player.pause()
            }
            else if player.timeControlStatus == .paused{
                player.play()
            }
        }
        else if let player = playerQueue{
            if player.timeControlStatus == .playing{
                player.pause()
            }
            else if player.timeControlStatus == .paused{
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty{
            // only tracks so it will pauser
            player?.pause()
        }
        else if let player = playerQueue{
            player.advanceToNextItem()
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty{
            // only tracks so it will pauser
            player?.pause()
            player?.play()
        }
        else if let player = playerQueue{
//            let a = player.items()
//            player.pause()
//            player.removeAllItems()
//            playerQueue = AVQueuePlayer(items: a)
//            playerQueue?.play()
            player.pause()
        }

    }
    
    
}
extension PlaybackPresenter:PlayerDataSource{
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
    
}
