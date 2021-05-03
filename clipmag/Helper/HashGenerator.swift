//
//  HashGenerator.swift
//  clipmag
//
//  Created by Nitesh Kumar on 24/04/21.
//

import Foundation
import CommonCrypto
 
var str = "Agnostic Development"
 
/**
 * Example SHA 256 Hash using CommonCrypto
 * CC_SHA256 API exposed from from CommonCrypto-60118.50.1:
 * https://opensource.apple.com/source/CommonCrypto/CommonCrypto-60118.50.1/include/CommonDigest.h.auto.html
 **/
func SHA256(str: String) -> String {
 
    if let strData = str.data(using: String.Encoding.utf8) {
        /// #define CC_SHA256_DIGEST_LENGTH     32
        /// Creates an array of unsigned 8 bit integers that contains 32 zeros
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
 
        /// CC_SHA256 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
        /// Takes the strData referenced value (const unsigned char *d) and hashes it into a reference to the digest parameter.
        _ = strData.withUnsafeBytes {
            // CommonCrypto
            // extern unsigned char *CC_SHA256(const void *data, CC_LONG len, unsigned char *md)  -|
            // OpenSSL                                                                             |
            // unsigned char *SHA256(const unsigned char *d, size_t n, unsigned char *md)        <-|
            CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
        }
 
        var sha256String = ""
        /// Unpack each byte in the digest array and add them to the sha256String
        for byte in digest {
            sha256String += String(format:"%02x", UInt8(byte))
        }
 
        return sha256String
    }
    return ""
}
