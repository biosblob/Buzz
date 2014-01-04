# Buzz 
A application that ties both ends of the iBeacons project into one. It is built on a MVVM architecture which allows better efficiency for processes in the view controller.  I also utilized CocoaPods as a dependency manager.

# Explain it
Using BLE (Bluetooth Low Energy) technology in iOS 7, Buzz is able to communicate with other devices. Using this application  only allows you to send a vibration command to a device that is paired with another device, but I am allowing it to be open source so others can expand on this concept. 

# Background
During one of the WWDC 2013 sessions, an engineer did a whole presentation over their example project iBeacon. It consisted of two project files, the beacon and the receiver, to communicate with each other–using the CoreBluetooth and CoreLocation frameworks. Buzz essentially combines the two.

# How is this different from GameKit?
As GameKit framework does have a peer-to-peer functionality, the code is too buggy and in a sense unsupported for iOS 7. 

#  Setup
Install [CocoaPods](http://cocoapods.org/) if you already don’t have it

        sudo gem install cocoapods
        pod setup
        
Clone this repository.

		git clone git@github.com:biosblob/Buzz.git

Install it's dependencies
		
		cd Buzz
		pod install

Open the workspace (not the project)
		
		open Buzz.xcworkspace
		
Run the project
		
		Select ‘Buzz’ target
		Run

# Thanks
Thanks to Matthew York for providing [MYBlurIntroductionViewBlur](https://github.com/MatthewYork/MYBlurIntroductionView), an open sourced powerful platform to build introductions.

# Future
Planning on releasing it to the App Store as the application can be used in a multitude of situation.