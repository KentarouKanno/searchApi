//
//  AppDetailData.m
//  Review
//
//  Created by KentarOu on 2014/08/21.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "AppDetailData.h"

@implementation AppDetailData


- (void)setAppDetailData:(NSDictionary*)data
{
    self.author_name_label = [[[data valueForKey:@"author"] valueForKey:@"name"] valueForKey:@"label"];
    self.author_uri_label = [[[data valueForKey:@"author"] valueForKey:@"uri"] valueForKey:@"label"];
    
    
    self.entry = [AppEntryData setAppEntryData:[data valueForKey:@"entry"]];
    
    
    self.entry_imname_label = [[[data valueForKey:@"entry"][0] valueForKey:@"im:name"] valueForKey:@"label"];
    self.entry_rights_label = [[[data valueForKey:@"entry"][0] valueForKey:@"rights"] valueForKey:@"label"];
    self.entry_imprice_label = [[[data valueForKey:@"entry"][0] valueForKey:@"im:price"] valueForKey:@"label"];
    self.entry_imprice_attributes_amount = [[[[data valueForKey:@"entry"][0] valueForKey:@"im:price"] valueForKey:@"attributes"] valueForKey:@"amount"];
    self.entry_imprice_attributes_currency = [[[[data valueForKey:@"entry"][0] valueForKey:@"im:price"] valueForKey:@"attributes"] valueForKey:@"currency"];
    
    
    self.entry_imimage = [AppEntryImageData setAppEntryImagekData:[[data valueForKey:@"entry"][0] valueForKey:@"im:image"]];
    
    
    self.entry_imartist_label = [[[data valueForKey:@"entry"][0] valueForKey:@"im:artist"] valueForKey:@"label"];
    self.entry_imartist_attributes_href = [[[[data valueForKey:@"entry"][0] valueForKey:@"im:artist"] valueForKey:@"attributes"] valueForKey:@"href"];
    self.entry_title_label = [[[data valueForKey:@"entry"][0] valueForKey:@"title"] valueForKey:@"label"];
    self.entry_link_attributes_rel = [[[[data valueForKey:@"entry"][0] valueForKey:@"link"] valueForKey:@"attributes"] valueForKey:@"rel"];
    self.entry_link_attributes_type = [[[[data valueForKey:@"entry"][0] valueForKey:@"link"] valueForKey:@"attributes"] valueForKey:@"type"];
    
    
    self.entry_link_attributes_href = [[[[data valueForKey:@"entry"][0] valueForKey:@"link"] valueForKey:@"attributes"] valueForKey:@"href"];
    self.entry_id_label = [[[data valueForKey:@"entry"][0] valueForKey:@"id"] valueForKey:@"label"];
    self.entry_id_attributes_imid = [[[[data valueForKey:@"entry"][0] valueForKey:@"id"] valueForKey:@"attributes"] valueForKey:@"im:id"];
    self.entry_id_attributes_imbundleId = [[[[data valueForKey:@"entry"][0] valueForKey:@"id"] valueForKey:@"attributes"] valueForKey:@"im:bundleId"];
    self.entry_imcontentType_attributes_term = [[[[data valueForKey:@"entry"][0] valueForKey:@"im:contentType"] valueForKey:@"attributes"] valueForKey:@"term"];
    
    
    self.entry_imcontentType_attributes_label = [[[[data valueForKey:@"entry"][0] valueForKey:@"im:contentType"] valueForKey:@"attributes"] valueForKey:@"label"];
    self.entry_category_attributes_imid = [[[[data valueForKey:@"entry"][0] valueForKey:@"category"] valueForKey:@"attributes"] valueForKey:@"im:id"];
    self.entry_category_attributes_term = [[[[data valueForKey:@"entry"][0] valueForKey:@"category"] valueForKey:@"attributes"] valueForKey:@"term"];
    self.entry_category_attributes_scheme = [[[[data valueForKey:@"entry"][0] valueForKey:@"category"] valueForKey:@"attributes"] valueForKey:@"scheme"];
    self.entry_category_attributes_label = [[[[data valueForKey:@"entry"][0] valueForKey:@"category"] valueForKey:@"attributes"] valueForKey:@"label"];
    self.entry_imreleaseDate_label = [[[data valueForKey:@"entry"][0] valueForKey:@"im:releaseDate"] valueForKey:@"label"];
    self.entry_imreleaseDate_attributes_label = [[[[data valueForKey:@"entry"][0] valueForKey:@"im:releaseDate"] valueForKey:@"attributes"] valueForKey:@"label"];

    
    self.updated_label = [[data valueForKey:@"updated"] valueForKey:@"label"];
    self.rights_label = [[data valueForKey:@"rights"] valueForKey:@"label"];
    self.title_label = [[data valueForKey:@"title"] valueForKey:@"label"];
    self.icon_label = [[data valueForKey:@"icon"] valueForKey:@"label"];
    
    
    self.link = [AppLinkData setAppLinkData:[data valueForKey:@"link"]];
    
    self.id_label = [[data valueForKey:@"id"] valueForKey:@"label"];
}

// 表示する順番でKeyソート
+ (NSArray*)getKeysArray
{
    NSMutableArray *keysArray = [NSMutableArray array];
    
    [keysArray addObject:@"author_name_label"];
    [keysArray addObject:@"author_uri_label"];
    
  //  [keysArray addObject:@"entry"];
    
    [keysArray addObject:@"entry_imname_label"];
    [keysArray addObject:@"entry_rights_label"];
    [keysArray addObject:@"entry_imprice_label"];
    [keysArray addObject:@"entry_imprice_attributes_amount"];
    [keysArray addObject:@"entry_imprice_attributes_currency"];
    
  //  [keysArray addObject:@"entry_imimage"];
    
    [keysArray addObject:@"entry_imartist_label"];
    [keysArray addObject:@"entry_imartist_attributes_href"];
    [keysArray addObject:@"entry_title_label"];
    [keysArray addObject:@"entry_link_attributes_rel"];
    [keysArray addObject:@"entry_link_attributes_type"];
    [keysArray addObject:@"entry_link_attributes_href"];
    [keysArray addObject:@"entry_id_label"];
    [keysArray addObject:@"entry_id_attributes_imid"];
    [keysArray addObject:@"entry_id_attributes_imbundleId"];
    [keysArray addObject:@"entry_imcontentType_attributes_term"];
    [keysArray addObject:@"entry_imcontentType_attributes_label"];
    [keysArray addObject:@"entry_category_attributes_imid"];
    [keysArray addObject:@"entry_category_attributes_term"];
    [keysArray addObject:@"entry_category_attributes_scheme"];
    [keysArray addObject:@"entry_category_attributes_label"];
    [keysArray addObject:@"entry_imreleaseDate_label"];
    [keysArray addObject:@"entry_imreleaseDate_attributes_label"];
    [keysArray addObject:@"updated_label"];
    [keysArray addObject:@"rights_label"];
    [keysArray addObject:@"title_label"];
    [keysArray addObject:@"icon_label"];
    
   // [keysArray addObject:@"link"];
    
    [keysArray addObject:@"id_label"];
    
    return keysArray;
}


@end


@implementation AppEntryData

+ (NSMutableArray*)setAppEntryData:(NSArray*)data
{
    NSMutableArray *entryDataArray = [NSMutableArray array];
    
    for (int i = 1; i < [data count]; i++) {
        
        NSDictionary *entryDict = data[i];
        
        AppEntryData *entryData = [AppEntryData new];
        
        entryData.author_uri_label = [[[entryDict valueForKey:@"author"] valueForKey:@"uri"] valueForKey:@"label"];
        entryData.author_name_label = [[[entryDict valueForKey:@"author"] valueForKey:@"name"] valueForKey:@"label"];
        entryData.imversion_label = [[entryDict valueForKey:@"im:version"] valueForKey:@"label"];
        entryData.imrating_label = [[entryDict valueForKey:@"im:rating"] valueForKey:@"label"];
        entryData.id_label = [[entryDict valueForKey:@"id"] valueForKey:@"label"];
        entryData.title_label = [[entryDict valueForKey:@"title"] valueForKey:@"label"];
        entryData.content_label = [[entryDict valueForKey:@"content"] valueForKey:@"label"];
        entryData.content_attributes_type = [[[entryDict valueForKey:@"content"] valueForKey:@"attributes"] valueForKey:@"type"];
        entryData.attributes_rel = [[[entryDict valueForKey:@"link"] valueForKey:@"attributes"] valueForKey:@"rel"];
        entryData.attributes_href = [[[entryDict valueForKey:@"link"] valueForKey:@"attributes"] valueForKey:@"href"];
        entryData.imvoteSum_label = [[entryDict valueForKey:@"im:voteSum"] valueForKey:@"label"];
        entryData.imcontentType_attributes_term = [[[entryDict valueForKey:@"im:contentType"] valueForKey:@"attributes"] valueForKey:@"term"];
        entryData.imcontentType_attributes_label = [[[entryDict valueForKey:@"im:contentType"] valueForKey:@"attributes"] valueForKey:@"label"];
        entryData.imvoteCount_label = [[entryDict valueForKey:@"im:voteCount"] valueForKey:@"label"];
        
        [entryDataArray addObject:entryData];
    }
    
    return entryDataArray;
}
@end

@implementation AppEntryImageData

+ (NSMutableArray*)setAppEntryImagekData:(NSArray *)data
{
    
    NSMutableArray *entryImageArray = [NSMutableArray array];
    
    for (int i = 0; i < [data count]; i++) {
        
        NSDictionary *imageDict = data[i];
        
        AppEntryImageData *imageData = [AppEntryImageData new];
        
        imageData.imimage_label = [imageDict valueForKey:@"label"];
        imageData.imimage_attributes_height = [[imageDict valueForKey:@"attributes"] valueForKey:@"height"];
        
        [entryImageArray addObject:imageData];
    }
    return entryImageArray;
}


@end


@implementation AppLinkData

+ (NSMutableArray*)setAppLinkData:(NSArray*)data
{
    
    NSMutableArray *linkDataArray = [NSMutableArray array];
    
    for (int i = 0; i < [data count]; i++) {
        
        NSDictionary *linkDict = [data[i] valueForKey:@"attributes"];
        
        AppLinkData *linkData = [AppLinkData new];
        
        linkData.attributes_rel = [linkDict valueForKey:@"rel"];
        linkData.attributes_type = [linkDict valueForKey:@"type"];
        linkData.attributes_href = [linkDict valueForKey:@"href"];
        
        [linkDataArray addObject:linkData];
    }
    return linkDataArray;
}


@end


