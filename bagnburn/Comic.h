// The MIT License (MIT)
//
// Copyright (c) 2013-2014 Scott Wakeling
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Comic : NSManagedObject


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *publisher;
@property (nonatomic, assign) NSNumber *bagOrBurn; // (T/F) Bag,Burn
@property (nonatomic, retain) NSData *coverArt; // PNG
@property (nonatomic, assign) NSNumber *issue;
@property (nonatomic, assign) NSNumber *list; // (0-2) Pull,Collect,Wish
@property (nonatomic, retain) NSNumber *volume;
@property (nonatomic, retain) NSString *writer;
@property (nonatomic, retain) NSString *artist;
@property (nonatomic, retain) NSString *colourist;
@property (nonatomic, retain) NSString *letterer;
@property (nonatomic, retain) NSString *notes;


@end

