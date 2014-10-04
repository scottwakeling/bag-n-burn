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

#import "ComicData.h"
#import "Comic.h"


@implementation ComicData

@synthesize coverImage;
@synthesize title;
@synthesize publisher;
@synthesize issue;
@synthesize volume;
@synthesize writer;
@synthesize artist;
@synthesize colourist;
@synthesize letterer;
@synthesize notes;

//
- (id)initWithManagedComic: (Comic*)managedComic andCoverImage:(UIImage*)initCoverImage {
    
    if (self = [super init]) {
        title = [managedComic.title copy];
        publisher = [managedComic.publisher copy];
        issue = [managedComic.issue copy];
        volume = [managedComic.volume copy];
        writer =[managedComic.writer copy];
        artist =[managedComic.artist copy];
        colourist =[managedComic.colourist copy];
        letterer =[managedComic.letterer copy];
        notes =[managedComic.notes copy];
        coverImage = [initCoverImage copy];
        return self;
    } else {
        return nil;
    }
}

@end
