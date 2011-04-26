# QCQREncoder #

A Quartz Composer patch that encodes QR codes using libqrencode.

Copyright 2010 Michael Farrell.  <http://micolous.id.au/>

## License ##

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>

## Building ##

You'll need Xcode (3) installed in order to build this software.  The software builds cleanly on Intel systems on Mac OS X 10.6.  It should also work on Mac OS X 10.5, and on PowerPC systems, however that has not been tested.  Because Macports builds only i386 and x86_64 binaries, PowerPC entries have been removed from the build configuration.  You'll need to re-add them (Project > Edit Project Settings > Build > Architectures > Valid Architectures > Gear Icon > Delete Definition At This Level), and play around with the settings.

You will need to install the 'qrencode' package from Macports, and build the +universal variant.  (sudo port install qrencode +universal)  This may potentially rebuild some of your packages in the process to be universal binaries, however they're fairly small dependencies anyway.

The rest of the software just builds cleanly in Xcode, use the "Build and Copy" target.  This will place the compiled plugin in ~/Library/Graphics/Quartz Composer Plug-Ins/

This plugin was developed against Mac OS X 10.6.5 on x86_64.

## Using ##

This plugin will generate a QR code based on the input text.

It also takes an input parameter specifying an error correction level, which map to the numbers 0 - 3, with 0 being Level L correction (lowest), and 3 being Level H correction (highest).  These error correction levels correspond directly to the levels in the QR code standard.  The greater the level of error correction employed, the more resistant your QR code is to errors, and also in some cases the bigger your QR code will be.  You'll need to strike a balance.

The patch will then output an image, at 1:1 zoom level of the QR code, so it will be very small.  With some clever use of patches, you can force Quartz Composer to set the scaling method to "nearest neighbour", which will prevent subpixel interpolation and make the scaled QR codes sharp rather than blurry.

Specifically, you want a Core Image Filter patch, with wrapping set to Transperant, and Filtering set to Nearest, with the following kernel:

	kernel vec4 passThrough(sampler image)
	{
		return sample(image, samplerTransform(image, destCoord()));
	}
	
You can then patch this through to either an Image Transform or Billboard patch to scale the image appropriately.

## Tips ##

- Don't rotate or move the QR code around too much.  Some screens have slow white-to-black times and will have trails, and many phones have very slow processors and cannot decode QR codes quickly, especially when they're moving.  Some goes for low light levels, the shutter speed will be low making trails worse.

- Make sure here is some white/light space around your QR code in order for the reader to detect where the edge of the code is.

## libqrencode ##

Binary builds of this package will include libqrencode automatically.  A copy of the license file is included in LICENSE-libqrencode.

libqrencode copyright (C) 2006, 2007, 2008, 2009 Kentaro Fukuchi

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

