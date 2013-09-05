//
//  ComicDetailView.m
//  bagnburn
//
//  Created by Scott Wakeling on 05/09/2013.
//  Copyright (c) Codometry 2013. Cambridge, UK. All rights reserved.
//

#import "ComicDetailView.h"
#import "ComicData.h"

@interface ComicDetailView ()
- (void)drawText:(NSString *)text withFont:(UIFont *)font atYPos:(int) yPos;
@end


@implementation ComicDetailView

//
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = YES;
        self.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}

//
- (void)drawRect:(CGRect)rect {
    
    CGFloat yPos = 10.f;
    CGFloat padding = 10.f;
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    NSString *text = nil;
    UIImage *coverImage = [self.comicData coverImage];
    
    //  Wallpaper
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM( context, 0.5f * self.bounds.size.width, 0.5f * self.bounds.size.height ) ;
    CGContextRotateCTM( context, M_PI_4 ) ;
    CGContextScaleCTM(context, 1.6f, 1.6f);
    CGContextTranslateCTM( context, -0.5f * self.bounds.size.width, -0.5f * self.bounds.size.height ) ;
    [coverImage drawInRect:self.bounds blendMode:kCGBlendModeNormal alpha:0.3f];
    CGContextRestoreGState(context);
    
    //  Cover
	CGRect coverRect = CGRectMake((self.bounds.size.width - 76) / 2, yPos, 76, 102.f);
	[coverImage drawInRect:coverRect];
    yPos += 102.f + padding;
    
    [[UIColor whiteColor] set];
	
	// Title
    if (self.comicData.issue) {
        text = [NSString stringWithFormat:@"%@ #%@", self.comicData.title, self.comicData.issue];
    } else {
        text = self.comicData.title;
    }
    [self drawText:text withFont:font atYPos:yPos];
    yPos += [text sizeWithFont:font].height + padding;
    
    //  font--
    font = [UIFont systemFontOfSize:16];
    
    // Volume
    if (self.comicData.volume) {
        text = [NSString stringWithFormat:@"Volume %@", self.comicData.volume];
        [self drawText:text withFont:font atYPos:yPos];
        yPos += [text sizeWithFont:font].height + padding;
    }

    // Publisher
    if (self.comicData.publisher.length) {
        text = [NSString stringWithFormat:@"Published by %@", self.comicData.publisher];
        [self drawText:text withFont:font atYPos:yPos];
        yPos += [text sizeWithFont:font].height + padding;
    }

    //  font--
    font = [UIFont systemFontOfSize:14];

    // Writer
    if (self.comicData.writer.length) {
        text = [NSString stringWithFormat:@"Written by %@", self.comicData.writer];
        [self drawText:text withFont:font atYPos:yPos];
        yPos += [text sizeWithFont:font].height + padding;
    }
    
    // Art
    if (self.comicData.artist.length) {
        text = [NSString stringWithFormat:@"Art by %@", self.comicData.artist];
        [self drawText:text withFont:font atYPos:yPos];
        yPos += [text sizeWithFont:font].height + padding;
    }
    
    // Colours
    if (self.comicData.colourist.length) {
        text = [NSString stringWithFormat:@"Colours by %@", self.comicData.colourist];
        [self drawText:text withFont:font atYPos:yPos];
        yPos += [text sizeWithFont:font].height + padding;
    }
    
    // Letters
    if (self.comicData.letterer.length) {
        text = [NSString stringWithFormat:@"Letters by %@", self.comicData.letterer];
        [self drawText:text withFont:font atYPos:yPos];
        yPos += [text sizeWithFont:font].height + padding;
    }
    
    //  font--
    font = [UIFont systemFontOfSize:12];

    // Notes
    if (self.comicData.notes.length) {
        CGFloat notesHeight = self.bounds.size.height - yPos;
        CGRect notesRect = CGRectMake(0.f, yPos, self.bounds.size.width, notesHeight);
        [self.comicData.notes drawInRect:notesRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    }
    
    
}

//
- (void)drawText:(NSString *)text withFont:(UIFont *)font atYPos:(int) yPos {
    CGPoint drawPos = CGPointMake((self.bounds.size.width-[text sizeWithFont:font].width)/2, yPos);
    [text drawAtPoint:drawPos withFont:font];
}

@end
