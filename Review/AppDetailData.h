//
//  AppDetailData.h
//  Review
//
//  Created by KentarOu on 2014/08/21.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDetailData : NSObject

@property (strong,nonatomic) NSString *author_name_label;
@property (strong,nonatomic) NSString *author_uri_label;

@property (strong,nonatomic) NSMutableArray *entry;
@property (strong,nonatomic) NSString *entry_imname_label;
@property (strong,nonatomic) NSString *entry_rights_label;
@property (strong,nonatomic) NSString *entry_imprice_label;
@property (strong,nonatomic) NSString *entry_imprice_attributes_amount;
@property (strong,nonatomic) NSString *entry_imprice_attributes_currency;
@property (strong,nonatomic) NSMutableArray *entry_imimage;
@property (strong,nonatomic) NSString *entry_imartist_label;
@property (strong,nonatomic) NSString *entry_imartist_attributes_href;
@property (strong,nonatomic) NSString *entry_title_label;
@property (strong,nonatomic) NSString *entry_link_attributes_rel;
@property (strong,nonatomic) NSString *entry_link_attributes_type;
@property (strong,nonatomic) NSString *entry_link_attributes_href;
@property (strong,nonatomic) NSString *entry_id_label;
@property (strong,nonatomic) NSString *entry_id_attributes_imid;
@property (strong,nonatomic) NSString *entry_id_attributes_imbundleId;
@property (strong,nonatomic) NSString *entry_imcontentType_attributes_term;
@property (strong,nonatomic) NSString *entry_imcontentType_attributes_label;
@property (strong,nonatomic) NSString *entry_category_attributes_imid;
@property (strong,nonatomic) NSString *entry_category_attributes_term;
@property (strong,nonatomic) NSString *entry_category_attributes_scheme;
@property (strong,nonatomic) NSString *entry_category_attributes_label;
@property (strong,nonatomic) NSString *entry_imreleaseDate_label;
@property (strong,nonatomic) NSString *entry_imreleaseDate_attributes_label;
@property (strong,nonatomic) NSString *updated_label;
@property (strong,nonatomic) NSString *rights_label;
@property (strong,nonatomic) NSString *title_label;
@property (strong,nonatomic) NSString *icon_label;
@property (strong,nonatomic) NSMutableArray *link;
@property (strong,nonatomic) NSString *id_label;

- (void)setAppDetailData:(NSDictionary*)data;
+ (NSArray*)getKeysArray;

@end


@interface AppEntryData : NSObject

@property (strong,nonatomic) NSString *author_uri_label;
@property (strong,nonatomic) NSString *author_name_label;
@property (strong,nonatomic) NSString *imversion_label;
@property (strong,nonatomic) NSString *imrating_label;
@property (strong,nonatomic) NSString *id_label;
@property (strong,nonatomic) NSString *title_label;
@property (strong,nonatomic) NSString *content_label;
@property (strong,nonatomic) NSString *content_attributes_type;
@property (strong,nonatomic) NSString *attributes_rel;
@property (strong,nonatomic) NSString *attributes_href;
@property (strong,nonatomic) NSString *imvoteSum_label;
@property (strong,nonatomic) NSString *imcontentType_attributes_term;
@property (strong,nonatomic) NSString *imcontentType_attributes_label;
@property (strong,nonatomic) NSString *imvoteCount_label;

+ (NSMutableArray*)setAppEntryData:(NSDictionary*)data;
+ (NSArray*)getKeysArray;

@end

@interface AppEntryImageData : NSObject

@property (strong,nonatomic) NSString *imimage_label;
@property (strong,nonatomic) NSString *imimage_attributes_height;

+ (NSMutableArray*)setAppEntryImagekData:(NSDictionary*)data;

@end


@interface AppLinkData : NSObject

@property (strong,nonatomic) NSString *attributes_rel;
@property (strong,nonatomic) NSString *attributes_type;
@property (strong,nonatomic) NSString *attributes_href;

+ (NSMutableArray*)setAppLinkData:(NSDictionary*)data;

@end


