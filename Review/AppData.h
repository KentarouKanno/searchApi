//
//  AppData.h
//  Review
//
//  Created by KentarOu on 2014/08/20.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppData : NSObject

@property (strong,nonatomic) NSString *artistId;                   // NSNumber
@property (strong,nonatomic) NSString *artistName;
@property (strong,nonatomic) NSString *artistViewUrl;
@property (strong,nonatomic) NSString *artworkUrl100;
@property (strong,nonatomic) NSString *artworkUrl512;
@property (strong,nonatomic) NSString *artworkUrl60;
@property (strong,nonatomic) NSString *averageUserRating;          // NSNumber
@property (strong,nonatomic) NSString *averageUserRatingForCurrentVersion;  // NSNumber
@property (strong,nonatomic) NSString *bundleId;
@property (strong,nonatomic) NSString *contentAdvisoryRating;

@property (strong,nonatomic) NSString *currency;
@property (strong,nonatomic) NSString *descriptions;
@property (strong,nonatomic) NSString *fileSizeBytes;
@property (strong,nonatomic) NSString *formattedPrice;
@property (strong,nonatomic) NSString *genres;                     // NSMutableArray
@property (strong,nonatomic) NSString *genreIds;                   // NSMutableArray
@property (strong,nonatomic) NSString *ipadScreenshotUrls;         // NSMutableArray
@property (strong,nonatomic) NSString *isGameCenterEnabled;        // NSNumber
@property (strong,nonatomic) NSString *kind;
@property (strong,nonatomic) NSString *languageCodesISO2A;         // NSMutableArray

@property (strong,nonatomic) NSString *minimumOsVersion;
@property (strong,nonatomic) NSString *price;                      // NSNumber
@property (strong,nonatomic) NSString *primaryGenreId;             // NSNumber
@property (strong,nonatomic) NSString *primaryGenreName;
@property (strong,nonatomic) NSString *releaseDate;
@property (strong,nonatomic) NSString *releaseNotes;
@property (strong,nonatomic) NSString *screenshotUrls;             // NSMutableArray
@property (strong,nonatomic) NSString *sellerName;
@property (strong,nonatomic) NSString *supportedDevices;           // NSMutableArray
@property (strong,nonatomic) NSString *trackCensoredName;

@property (strong,nonatomic) NSString *trackContentRating;
@property (strong,nonatomic) NSString *trackId;                     // NSNumber
@property (strong,nonatomic) NSString *trackName;
@property (strong,nonatomic) NSString *trackViewUrl;
@property (strong,nonatomic) NSString *userRatingCount;             // NSNumber
@property (strong,nonatomic) NSString *userRatingCountForCurrentVersion;   // NSNumber
@property (strong,nonatomic) NSString *version;
@property (strong,nonatomic) NSString *wrapperType;
@property (strong,nonatomic) NSString *features;                    // NSMutableArray

@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *screenShot;


@property (assign,readwrite) BOOL      artworkUrl100OpenFlg;
@property (assign,readwrite) BOOL      artworkUrl512OpenFlg;
@property (assign,readwrite) BOOL      artworkUrl60OpenFlg;
@property (assign,readwrite) BOOL      screenShotOpenFlg;

// URL image
@property (strong,nonatomic) UIImage *artworkUrl100Image;
@property (strong,nonatomic) UIImage *artworkUrl512Image;
@property (strong,nonatomic) UIImage *artworkUrl60Image;

@property (strong,nonatomic) UIImage *screenShot1;
@property (strong,nonatomic) UIImage *screenShot2;
@property (strong,nonatomic) UIImage *screenShot3;
@property (strong,nonatomic) UIImage *screenShot4;
@property (strong,nonatomic) UIImage *screenShot5;

@property (assign,nonatomic) NSInteger imageCount;

- (void)setAppData:(NSDictionary*)data;
- (NSArray*)getKeysArray;

@end
