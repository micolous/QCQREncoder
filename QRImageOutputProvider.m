//
//  QRImageOutputProvider.m
//  QCQREncoder
//
//  Created by Michael Farrell on 2010-11-20.
//  Copyright 2010 Michael Farrell. <http://micolous.id.au/>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//  
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#import "QRImageOutputProvider.h"


@implementation QRImageOutputProvider

- (id) initWithQRcodeSource:(QRcode*)qr
{
	// if the qr code input is NULL, fail out.
	if (!qr) {
		return nil;
	}
		
	// store the qr code
	_qrImage = qr;
	
	
	return self;
}

- (void) dealloc
{
	QRcode_free(_qrImage);
}

- (NSRect) imageBounds
{
	// return information about the image bounds
	return NSMakeRect(0.0, 0.0, (CGFloat)_qrImage->width, (CGFloat)_qrImage->width);
}

- (CGColorSpaceRef) imageColorSpace
{
	// what colour space we have
	return CGColorSpaceCreateWithName(kCGColorSpaceGenericGray);
}

- (NSArray*) supportedBufferPixelFormats 
{
	// support a 8-bit value for storing pixels
	return [NSArray arrayWithObjects:QCPlugInPixelFormatI8, nil];
}

- (BOOL) renderToBuffer:(void *)baseAddress withBytesPerRow:(NSUInteger)rowBytes pixelFormat:(NSString *)format forBounds:(NSRect)bounds
{
	// render the image to an output buffer
	if ([format isEqualToString:QCPlugInPixelFormatI8]) {
		// how the image buffer works is that regardless of how wide your image is, each "row" is a multiple of 64.
		// so that's what "rowBytes" is, it's the "actual" width of the texture.
		//
		// whereas libqrencode gives us the data tightly packed to the "actual" size of the image, and only the least
		// significant bit will contain image data
		//
		// so we need to translate that when copying the image across, it's not a simple memcpy operation anymore.
		
		// copy the buffer
		unsigned long offset;
		for (unsigned long y = bounds.origin.y; y < bounds.size.height; y++) {
			offset = (y - (unsigned long)bounds.origin.y) * rowBytes;
			for (unsigned long x = bounds.origin.x; x < bounds.size.width; x++) {
				((char*)baseAddress)[offset + (x - (unsigned long)bounds.origin.x)] = (_qrImage->data[(y * _qrImage->width) + x] & 1) * 0xFF;

			}
		}
		
		return YES;
	} else {
		// this shouldn't happen - unsupported format
		return NO;
	}
		
}


@end
