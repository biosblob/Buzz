# Buzz 
A application that ties both ends of the iBeacons project into one. It is built on a MVVM architecture which allows better efficiency for processes in the view controller.  I also utilized CocoaPods as a dependency manager.

# Explain it
Using BLE (Bluetooth Low Energy) technology in iOS 7, Buzz is able to communicate with other devices. Using this application only allows you to send a vibration command to a device that is paired with another device, but I am allowing it to be open source so others can expand on this concept. 

# Background
During one of the WWDC 2013 sessions, an engineer did a presentation over their example project iBeacon. It consisted of two project files, the beacon and the receiver, which communicates with each other using the CoreBluetooth and CoreLocation frameworks. Buzz essentially combines the two.

# How is this different from GameKit?
As GameKit framework does have a peer-to-peer functionality, the code is too buggy and, in a sense, unsupported for iOS 7. 
# What is left to do?
+ Fill out how to use in intro
+ Put in relevant pics (remove placeholders) in intro
+ Once Bluetooth is on (but was off originally), exit out of that .xib file
+ fade out of .xib file


# Setup
Install [CocoaPods](http://cocoapods.org/) if you don’t have it already

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
A big shoutout to  Matthew York for providing [MYBlurIntroductionViewBlur](https://github.com/MatthewYork/MYBlurIntroductionView), an open sourced powerful platform to build introductions. I used it at the beginning to explain how to use Buzz for consumers.

# Future
Planning on releasing it to the App Store *some day* as the application can be used in a multitude of situation.
