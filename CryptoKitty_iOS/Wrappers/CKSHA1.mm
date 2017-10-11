//
//  CKSHA1.m
//  CryptoKitty_iOS
//
//  Created by Steve Brenneis on 10/4/17.
//  Copyright © 2017 CryptoKitty. All rights reserved.
//

#import "CKSHA1.h"
#import <coder_iOS/ByteArray.h>
#import <CryptoKitty_iOS/SHA1.h>

@implementation CKSHA1

- (instancetype) init {
    
    self = [super init];
    
    _sha1 = new SHA1;
    _accumulator = nil;
    return self;
    
}

- (void) dealloc {
    
    SHA1 *sha = reinterpret_cast<SHA1*>(_sha1);
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
    SHA1 *sha = reinterpret_cast<SHA1*>(_sha1);
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
