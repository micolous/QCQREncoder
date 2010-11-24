//
//  QRImageOutputProvider.h
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

#import <Cocoa/Cocoa.h>
#include <qrencode.h>

@interface QRImageOutputProvider : NSObject<QCPlugInOutputImageProvider>
{
	@protected
	QRcode* _qrImage;
}
- (id) initWithQRcodeSource:(QRcode*)qr;
@end
