//
//  CKRSACodec.h
//  CryptoKitty_iOS
//
//  Created by Steve Brenneis on 10/10/17.
//  Copyright © 2017 CryptoKitty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKRSAPrivateKey.h"
#import "CKRSAPublicKey.h"

@interface CKRSACodec : NSObject

- (instancetype)initWithData:(NSData*)data;

- (void)decrypt:(CKRSAPrivateKey*)key;

- (NSData*)encrypt:(CKRSAPublicKey*)key;

- (NSData*)getBlock;

- (void)putBlock:(NSData*)block;

@end
