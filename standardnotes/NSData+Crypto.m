//
//  NSData+Crypto.m
//  standardnotes
//
//  Created by Mo Bitar on 12/20/16.
//  Copyright © 2016 Standard Notes. All rights reserved.
//

#import "NSData+Crypto.h"
#import <CommonCrypto/CommonCrypto.h>

extern NSData * AES128CBC(NSString *op, NSData * data, NSData * key) {
    CCCryptorStatus    err;
    NSMutableData *    result;
    size_t              resultLength;
    
    //    NSLog(@"Key length is: %lu Should be: %i", (unsigned long)key.length, kCCKeySizeAES256);
    
    NSCParameterAssert(key.length == kCCKeySizeAES256);
    //    NSCParameterAssert(iv.length == kCCBlockSizeAES128);
    
    // Padding can expand the data, so we have to allocate space for that.  The rule for block
    // cyphers, like AES, is that the padding only adds space on encryption (on decryption it
    // can reduce space, obviously, but we don't need to account for that) and it will only add
    // at most one block size worth of space.
    
    result = [[NSMutableData alloc] initWithLength:[data length] + kCCBlockSizeAES128];
    
    err = CCCrypt(
                  [op isEqualToString:@"encrypt"] ? kCCEncrypt : kCCDecrypt,
                  kCCAlgorithmAES128,
                  kCCOptionPKCS7Padding,
                  key.bytes, key.length,
                  nil,
                  data.bytes, data.length,
                  result.mutableBytes,  result.length,
                  &resultLength
                  );
    assert(err == kCCSuccess);
    
    // Set the output length to the value returned by CCCrypt.  This is necessary because
    // we have padding enabled, meaning that we might have allocated more space than we needed.
    
    [result setLength:resultLength];  
    
    return result;  
}

extern NSData *HMAC256(NSData *messageData, NSData *keyData) {
    NSMutableData *result = [[NSMutableData alloc] initWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, result.mutableBytes);
    return result;
}

