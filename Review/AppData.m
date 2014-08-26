//
//  AppData.m
//  Review
//
//  Created by KentarOu on 2014/08/20.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "AppData.h"

@implementation AppData


- (void)setAppData:(NSDictionary*)data
{
    self.artistId = [[data valueForKey:@"artistId"] stringValue];
    self.artistName = [data valueForKey:@"artistName"];
    self.artistViewUrl = [data valueForKey:@"artistViewUrl"];
    self.artworkUrl100 = [data valueForKey:@"artworkUrl100"];
    self.artworkUrl512 = [data valueForKey:@"artworkUrl512"];
    self.artworkUrl60 = [data valueForKey:@"artworkUrl60"];
    self.averageUserRating = [[data valueForKey:@"averageUserRating"] stringValue];
    self.averageUserRatingForCurrentVersion = [[data valueForKey:@"averageUserRatingForCurrentVersion"] stringValue];
    self.bundleId = [data valueForKey:@"bundleId"];
    self.contentAdvisoryRating = [data valueForKey:@"contentAdvisoryRating"];
    
    self.currency = [data valueForKey:@"currency"];
    self.descriptions = [data valueForKey:@"description"];
    self.fileSizeBytes = [data valueForKey:@"fileSizeBytes"];
    self.formattedPrice = [data valueForKey:@"formattedPrice"];
    self.genres = [self arrayChangeString:[NSMutableArray arrayWithArray:[data valueForKey:@"genres"]]];
    self.genreIds = [self arrayChangeString:[NSMutableArray arrayWithArray:[data valueForKey:@"genreIds"]]];
    self.ipadScreenshotUrls = [self arrayChangeString:[NSMutableArray arrayWithArray:[data valueForKey:@"ipadScreenshotUrls"]]];
    self.isGameCenterEnabled = [[data valueForKey:@"isGameCenterEnabled"] stringValue];
    self.kind = [data valueForKey:@"kind"];
    self.languageCodesISO2A = [self arrayChangeString:[NSMutableArray arrayWithArray:[data valueForKey:@"languageCodesISO2A"]]];
    
    self.minimumOsVersion = [data valueForKey:@"minimumOsVersion"];
    self.price = [[data valueForKey:@"price"] stringValue];
    self.primaryGenreId = [[data valueForKey:@"primaryGenreId"] stringValue];
    self.primaryGenreName = [data valueForKey:@"primaryGenreName"];
    self.releaseDate = [data valueForKey:@"releaseDate"];
    self.releaseNotes = [data valueForKey:@"releaseNotes"];
    self.screenshotUrls = [self arrayChangeString:[NSMutableArray arrayWithArray:[data valueForKey:@"screenshotUrls"]]];
    self.sellerName = [data valueForKey:@"sellerName"];
    self.supportedDevices = [self arrayChangeString:[NSMutableArray arrayWithArray:[data valueForKey:@"supportedDevices"]]];
    self.trackCensoredName = [data valueForKey:@"trackCensoredName"];
    
    self.trackContentRating = [data valueForKey:@"trackContentRating"];
    self.trackId = [[data valueForKey:@"trackId"] stringValue];
    self.trackName = [data valueForKey:@"trackName"];
    self.trackViewUrl = [data valueForKey:@"trackViewUrl"];
    self.userRatingCount = [[data valueForKey:@"userRatingCount"] stringValue];
    self.userRatingCountForCurrentVersion = [[data valueForKey:@"userRatingCountForCurrentVersion"] stringValue];
    self.version = [data valueForKey:@"version"];
    self.wrapperType = [data valueForKey:@"wrapperType"];
    self.features = [self arrayChangeString:[NSMutableArray arrayWithArray:[data valueForKey:@"features"]]];
    
    self.image = @"image";
    self.screenShot = @"screenShot";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Sub Thread
        
        NSString *imageURL1 = _artworkUrl100;
        self.artworkUrl100Image = [self getAppImage:imageURL1];
        NSString *imageURL2 = _artworkUrl512;
        self.artworkUrl512Image = [self getAppImage:imageURL2];
        NSString *imageURL3 = _artworkUrl60;
        self.artworkUrl60Image = [self getAppImage:imageURL3];
        
        
        
        if ([data valueForKey:@"screenshotUrls"][0]) {
            self.screenShot1 = [self getAppImage:[data valueForKey:@"screenshotUrls"][0]];
        }
        if ([data valueForKey:@"screenshotUrls"][1]) {
            self.screenShot2 = [self getAppImage:[data valueForKey:@"screenshotUrls"][1]];
        }
        if ([data valueForKey:@"screenshotUrls"][2]) {
            self.screenShot3 = [self getAppImage:[data valueForKey:@"screenshotUrls"][2]];
        }
        if ([data valueForKey:@"screenshotUrls"][3]) {
            self.screenShot4 = [self getAppImage:[data valueForKey:@"screenshotUrls"][3]];
        }
        if ([data valueForKey:@"screenshotUrls"][4]) {
            self.screenShot5 = [self getAppImage:[data valueForKey:@"screenshotUrls"][4]];
        }
    });
    
    self.artworkUrl100OpenFlg = NO;
    self.artworkUrl512OpenFlg = NO;
    self.artworkUrl60OpenFlg = NO;
    self.screenShotOpenFlg = NO;

    
    self.imageCount = [(NSArray*)[data valueForKey:@"screenshotUrls"] count];
}

- (NSString*)arrayChangeString:(NSMutableArray*)dataArray
{
    if ([dataArray count] == 0) {
        return @"";
    }
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSString *str in dataArray) {
        [string appendString:[NSString stringWithFormat:@"%@\n",str]];
    }
    
    NSString *s = [string substringWithRange:NSMakeRange(0, string.length - 1)];
    string = [NSMutableString stringWithString:s];
    
    return string;
}

- (UIImage*)getAppImage:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSData * imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}


// 表示する順番でKeyソート
- (NSArray*)getKeysArray
{
    NSMutableArray *keysArray = [NSMutableArray array];
    
    [keysArray addObject:@"artistId"];
    [keysArray addObject:@"artistName"];
    [keysArray addObject:@"artistViewUrl"];
    [keysArray addObject:@"artworkUrl100"];
    [keysArray addObject:@"artworkUrl512"];
    [keysArray addObject:@"artworkUrl60"];
    [keysArray addObject:@"averageUserRating"];
    [keysArray addObject:@"averageUserRatingForCurrentVersion"];
    [keysArray addObject:@"bundleId"];
    [keysArray addObject:@"contentAdvisoryRating"];

    [keysArray addObject:@"currency"];
    [keysArray addObject:@"descriptions"];
    [keysArray addObject:@"fileSizeBytes"];
    [keysArray addObject:@"formattedPrice"];
    [keysArray addObject:@"genres"];
    [keysArray addObject:@"genreIds"];
    [keysArray addObject:@"ipadScreenshotUrls"];
    [keysArray addObject:@"isGameCenterEnabled"];
    [keysArray addObject:@"kind"];
    [keysArray addObject:@"languageCodesISO2A"];
    
    [keysArray addObject:@"minimumOsVersion"];
    [keysArray addObject:@"price"];
    [keysArray addObject:@"primaryGenreId"];
    [keysArray addObject:@"primaryGenreName"];
    [keysArray addObject:@"releaseDate"];
    [keysArray addObject:@"releaseNotes"];
    [keysArray addObject:@"screenshotUrls"];
    [keysArray addObject:@"sellerName"];
    [keysArray addObject:@"supportedDevices"];
    [keysArray addObject:@"trackCensoredName"];
    
    [keysArray addObject:@"trackContentRating"];
    [keysArray addObject:@"trackId"];
    [keysArray addObject:@"trackName"];
    [keysArray addObject:@"trackViewUrl"];
    [keysArray addObject:@"userRatingCount"];
    [keysArray addObject:@"userRatingCountForCurrentVersion"];
    [keysArray addObject:@"version"];
    [keysArray addObject:@"wrapperType"];
    [keysArray addObject:@"features"];

    return keysArray;
}


@end
