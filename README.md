FB15174703
==========

[![Build Status](https://img.shields.io/github/actions/workflow/status/macmade/FB15174703/ci-mac.yaml?label=macOS&logo=apple)](https://github.com/macmade/FB15174703/actions/workflows/ci-mac.yaml)
[![Issues](http://img.shields.io/github/issues/macmade/FB15174703.svg?logo=github)](https://github.com/macmade/FB15174703/issues)
![Status](https://img.shields.io/badge/status-open-brightgreen.svg?logo=git)
![License](https://img.shields.io/badge/license-mit-brightgreen.svg?logo=open-source-initiative)  
[![Contact](https://img.shields.io/badge/follow-@macmade-blue.svg?logo=twitter&style=social)](https://twitter.com/macmade)
[![Sponsor](https://img.shields.io/badge/sponsor-macmade-pink.svg?logo=github-sponsors&style=social)](https://github.com/sponsors/macmade)

### Local Network Permissions are Ignored

macOS 15 introduces new Local Network permissions.  
However, the permission prompt is only presented to the user for applications in the /Applications directory.

Any app located elsewhere can completely bypass these permissions and access the local network without prompting.  
This is a severe privacy issue and completely defeats the purpose of these new permissions.

Attached is a demo Xcode project demonstrating the issue.  
Build and run the app. It will display a list of all devices in the local network.  
No prompt is presented to the user. The app has full access to the local network.

It doesn't matter if you run the app attached to Xcode or not.  
The privacy prompt is never shown.

Now place the app in the /Applications directory and run it.  
The privacy prompt is now displayed.

License
-------

Project is released under the terms of the MIT License.

Repository Infos
----------------

    Owner:          Jean-David Gadina - XS-Labs
    Web:            www.xs-labs.com
    Blog:           www.noxeos.com
    Twitter:        @macmade
    GitHub:         github.com/macmade
    LinkedIn:       ch.linkedin.com/in/macmade/
    StackOverflow:  stackoverflow.com/users/182676/macmade
