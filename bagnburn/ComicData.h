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

@class Comic;

@interface ComicData : NSObject

@property (strong, nonatomic) UIImage* coverImage;
//@property (strong, nonatomic) NSData* coverData;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* publisher;
@property (strong, nonatomic) NSNumber* issue;
@property (strong, nonatomic) NSNumber* volume;
@property (strong, nonatomic) NSString* writer;
@property (strong, nonatomic) NSString* artist;
@property (strong, nonatomic) NSString* colourist;
@property (strong, nonatomic) NSString* letterer;
@property (strong, nonatomic) NSString* notes;

- (id)initWithManagedComic: (Comic*)managedComic andCoverImage:(UIImage*)initCoverImage;


@end
