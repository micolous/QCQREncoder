//
//  QCQREncoderPlugIn.h
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

#import <Quartz/Quartz.h>
#include <qrencode.h>
#include "QRImageOutputProvider.h"

@interface QCQREncoderPlugIn : QCPlugIn
{
	
}

/*
Declare here the Obj-C 2.0 properties to be used as input and output ports for the plug-in e.g.
@property double inputFoo;
@property(assign) NSString* outputBar;
You can access their values in the appropriate plug-in methods using self.inputFoo or self.inputBar
*/

@property(assign) NSUInteger inputErrorCorrectionLevel;
@property(assign) NSString* inputText;
@property(assign) id<QCPlugInOutputImageProvider> outputImage;


@end
