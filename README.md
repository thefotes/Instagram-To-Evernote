Instagram-To-Evernote
=====================

Save all of your Instagram photos to Evernote.

![Imgur](http://i.imgur.com/4tsuDaw.png?2)

### Why did I make this?
Great question! I use a service called [IFTTT](http://ifttt.com) (which some of you may have heard of), and with it I have all of my Instagram photos sent to my Evernote automatically. While this is great, there was no way to account for all of the photos that I had taken before integrating with IFTTT. Thus, I needed a good way to export my Instagram pictures and save them to my Evernote.

### Usage instructions
1. You're going to need an Instagram app. To make one [go here](http://instagram.com/developer/clients/manage/) 
2. Once you've made your Instagram app edit the Evernote-info.plist with your new URL Scheme and Identifier
3. Next update the `PFInstagramCommunicator.m` file with your client id, and redirectURI
4. At this point you can test the app and you should be able to authenticate and fetch your photos
5. Next up is Evernote. First, go get a developer token [here](https://www.evernote.com/api/DeveloperToken.action)
6. In the `AppDelegate.m` update the developer token, and note store url to use your own
7. Update the Evernote-info.plist URL types[0] with your Evernote scheme
8. In the `PFViewController.m`'s `evernoteTakeAction:` method update the tags and notebook you'd like these images saved to.
9. ???
10. Enjoy having your Instagram photos backed up to Evernote.

### Contact
E-mail me pjfoti [at] gmail [dot] com

Twitter [@peterjfoti](http://twitter.com/peterjfoti)