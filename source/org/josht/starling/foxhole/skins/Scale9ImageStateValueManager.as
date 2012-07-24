/*
 Copyright (c) 2012 Josh Tynjala

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
package org.josht.starling.foxhole.skins
{
	import org.josht.starling.display.Scale9Image;
	import org.josht.starling.textures.Scale9Textures;

	/**
	 * Values for each state are Scale9Textures instances, and the manager
	 * attempts to reuse the existing Scale9Image instance that is passed in to
	 * getValueForState() as the old value by swapping the textures.
	 */
	public class Scale9ImageStateValueManager extends StateValueManager
	{
		/**
		 * Constructor.
		 */
		public function Scale9ImageStateValueManager()
		{
		}

		/**
		 * Optional properties to set on the Scale9Image instance.
		 */
		public var imageProperties:Object;

		/**
		 * @private
		 */
		override public function setValueForState(state:Object, value:Object):void
		{
			if(!(value is Scale9Textures))
			{
				throw new ArgumentError("Value for state must be a Scale9Textures instance.");
			}
			super.setValueForState(state, value);
		}

		/**
		 * @private
		 */
		override public function getValueForState(target:Object, state:Object, oldValue:Object = null):Object
		{
			const textures:Scale9Textures = super.getValueForState(target, state) as Scale9Textures;
			if(!textures)
			{
				return null;
			}

			if(oldValue is Scale9Image)
			{
				var image:Scale9Image = Scale9Image(oldValue);
				image.textures = textures;
				image.readjustSize();
			}
			else
			{
				image = new Scale9Image(textures);
			}

			if(this.imageProperties)
			{
				for(var name:String in this.imageProperties)
				{
					if(image.hasOwnProperty(name))
					{
						var value:Object = this.imageProperties[name];
						image[name] = value;
					}
				}
			}

			return image;
		}
	}
}