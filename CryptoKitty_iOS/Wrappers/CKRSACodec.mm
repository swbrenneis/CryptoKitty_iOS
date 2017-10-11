//
//  CKRSACodec.m
//  CryptoKitty_iOS
//
//  Created by Steve Brenneis on 10/10/17.
//  Copyright © 2017 CryptoKitty. All rights reserved.
//

#import "CKRSACodec.h"
#import "RSACodec.h"
#import <coder_iOS/ByteArray.h>

@interface CKRSACodec ()
{
    RSACodec *rsaCodec;
}
@end

@implementation CKRSACodec

- (instancetype)init {
    self = [super init];

    rsaCodec = new RSACodec;
    return self;

}

-(instancetype)initWithData:(NSData *)data {
    self = [super init];

    coder::ByteArray bytes(reinterpret_cast<const uint8_t*>(data.bytes), data.length);
    rsaCodec = new RSACodec(bytes);
    return self;

}

- (void)dealloc {
    delete rsaCodec;
}

- (void)decrypt:(CKRSAPrivateKey *)key {

    rsaCodec->decrypt(*reinterpret_cast<RSAPrivateKey*>(key.privateKey));

}

- (NSData*)encrypt:(CKRSAPublicKey *)key {

    rsaCodec->encrypt(*reinterpret_cast<RSAPublicKey*>(key.publicKey));
    coder::ByteArray encrypted(rsaCodec->toArray());
    return [[NSMutableData alloc] initWithBytesNoCopy:encrypted.asArray()
                                               length:encrypted.length()
                                         freeWhenDone:YES];

}

- (NSData*)getBlock {

    coder::ByteArray block;
    *rsaCodec >> block;
    return [[NSMutableData alloc] initWithBytesNoCopy:block.asArray()
                                               length:block.length()
                                         freeWhenDone:YES];

}

- (void)putBlock:(NSData *)block {

    coder::ByteArray bytes(reinterpret_cast<const uint8_t*>(block.bytes), block.length);
    *rsaCodec << bytes;

}

@end
