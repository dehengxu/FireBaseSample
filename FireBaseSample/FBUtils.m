//
//  FBUtils.m
//  FireBaseSample
//
//  Created by Deheng.Xu on 13-3-21.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "FBUtils.h"

@implementation FBUtils

@end

static dispatch_queue_t _firebase_worker;

dispatch_queue_t GetFirebaseWorkingQueue()
{
    if (!_firebase_worker) {
        _firebase_worker = dispatch_queue_create("com.cyblion.firebase", NULL);
    }
    return _firebase_worker;
}
