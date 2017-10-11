//
//  CKSHA256.m
//  CryptoKitty_iOS
//
//  Created by Steve Brenneis on 10/4/17.
//  Copyright © 2017 CryptoKitty. All rights reserved.
//

#import "CKSHA256.h"
#import <CryptoKitty_iOS/SHA256.h>
#import <coder_iOS/ByteArray.h>

@implementation CKSHA256

- (instancetype) init {

    self = [super init];

    _sha256 = new SHA256;
    _accumulator = nil;
    return self;

}

- (void) dealloc {

    SHA256 *sha = reinterpret_cast<SHA256*>(_sha256);
    delete sha;

}

- (NSData*) digest {

    if (_accumulator == nil) {
        return [self digest:[NSData data]]; // Empty digest.
    }
    else {
        NSData *result = [self digest:_accumulator];
        [self reset];
        return result;
    }

}

- (NSData*) digest:(NSData *)data {

    [self reset];
    SHA256 *sha = reinterpret_cast<SHA256*>(_sha256);
    coder::ByteArray bytes;
    if (data.length > 0) {
        const uint8_t *dataBytes = reinterpret_cast<const uint8_t*>(data.bytes);
        bytes = coder::ByteArray(dataBytes, data.length);
    }
    coder::ByteArray result(sha->digest(bytes));
    return [[NSData alloc] initWithBytesNoCopy:result.asArray()
                                        length:result.length()
                                  freeWhenDone:YES];

}

- (void) reset {

    _accumulator = nil;

}

- (void) update:(NSData *)data {

    if (_accumulator == nil) {
        _accumulator = [NSMutableData data];
    }
    [_accumulator appendData:data];

}

@end
