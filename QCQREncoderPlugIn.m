//
//  QCQREncoderPlugIn.m
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
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "QCQREncoderPlugIn.h"

#define	kQCPlugIn_Name				@"QR Encoder"
#define	kQCPlugIn_Description		@"Encodes QR codes based on an input string."
#define kQCPlugIn_Copyright			@"2010 Michael Farrell <http://micolous.id.au/>"

@implementation QCQREncoderPlugIn

/*
Here you need to declare the input / output properties as dynamic as Quartz Composer will handle their implementation
@dynamic inputFoo, outputBar;
*/
@dynamic inputErrorCorrectionLevel, inputText, outputImage;

+ (NSDictionary*) attributes
{
	/*
	Return a dictionary of attributes describing the plug-in (QCPlugInAttributeNameKey, QCPlugInAttributeDescriptionKey...).
	*/
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			kQCPlugIn_Name, QCPlugInAttributeNameKey, 
			kQCPlugIn_Description, QCPlugInAttributeDescriptionKey,
			kQCPlugIn_Copyright, QCPlugInAttributeCopyrightKey,
			nil];
}

+ (NSDictionary*) attributesForPropertyPortWithKey:(NSString*)key
{
	/*
	Specify the optional attributes for property based ports (QCPortAttributeNameKey, QCPortAttributeDefaultValueKey...).
	*/
	
	if ([key isEqualToString:@"inputText"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Text", QCPortAttributeNameKey,
				@"Hello World!", QCPortAttributeDefaultValueKey,
				nil];
	
	if ([key isEqualToString:@"inputErrorCorrectionLevel"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Error Correction Level", QCPortAttributeNameKey,
				[NSNumber numberWithUnsignedInteger:3], QCPortAttributeMaximumValueKey, 
				[NSArray arrayWithObjects: @"Level L (7%)", @"Level M (15%)", @"Level Q (25%)", @"Level H (30%)", nil], QCPortAttributeMenuItemsKey,
				[NSNumber numberWithUnsignedInteger:0], QCPortAttributeDefaultValueKey,
				nil];
	
	if ([key isEqualToString:@"outputImage"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Image", QCPortAttributeNameKey,
				nil];
	
	return nil;
}

+ (QCPlugInExecutionMode) executionMode
{
	/*
	Return the execution mode of the plug-in: kQCPlugInExecutionModeProvider, kQCPlugInExecutionModeProcessor, or kQCPlugInExecutionModeConsumer.
	*/
	
	return kQCPlugInExecutionModeProcessor;
}

+ (QCPlugInTimeMode) timeMode
{
	/*
	Return the time dependency mode of the plug-in: kQCPlugInTimeModeNone, kQCPlugInTimeModeIdle or kQCPlugInTimeModeTimeBase.
	*/
	
	return kQCPlugInTimeModeNone;
}

- (id) init
{
	if(self = [super init]) {
		/*
		Allocate any permanent resource required by the plug-in.
		*/
	}
	
	return self;
}

@end

@implementation QCQREncoderPlugIn (Execution)

- (BOOL) startExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	Return NO in case of fatal failure (this will prevent rendering of the composition to start).
	*/
	
	return YES;
}

- (void) enableExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance starts being used by Quartz Composer.
	*/
}

- (BOOL) execute:(id<QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary*)arguments
{
	/*
	Called by Quartz Composer whenever the plug-in instance needs to execute.
	Only read from the plug-in inputs and produce a result (by writing to the plug-in outputs or rendering to the destination OpenGL context) within that method and nowhere else.
	Return NO in case of failure during the execution (this will prevent rendering of the current frame to complete).
	
	The OpenGL context for rendering can be accessed and defined for CGL macros using:
	CGLContextObj cgl_ctx = [context CGLContextObj];
	*/
	QRcode* qr;
	
	qr = QRcode_encodeString8bit([self.inputText UTF8String], 0, self.inputErrorCorrectionLevel);
	self.outputImage = [[QRImageOutputProvider alloc] initWithQRcodeSource:qr];
	
	return YES;
}

- (void) disableExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance stops being used by Quartz Composer.
	*/
}

- (void) stopExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
	*/
}

@end
