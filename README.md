# Inventory Manager
This is the framework of an app created in Swift that was intended to be used to inventory incoming cars in a junkyard/salvage yard.

## Features

  - Clean, polished interface that allows for driver and internal interaction
  - Able to generate cars on the go as long as internet connection is present
  - Specific condition selectors
  - Capable of adding images to specific parts
  - Able to add pictures to the car in general as well as view car info
  - Exchanges information with an SQL server and stores everything there, live.

### Installation

Clone the repository:
```sh
$ git clone https://github.com/Jaymus3/Inventory-Manager
```
(You'll need a Mac for development as it's an iOS app) 
1.  Install XCode.
2.  Create a new project
3.  Add the files.
4.  Set up a web server running apache2
5.  Install php
6.  Install the php mysql addon
7.  Install MySQL community server
8.  Run the server, and create an account on the SQL database named ipodinterface with the password which can be found in the php connector files.
9.  Import the database into the SQL database.
10.  Build and run the app to an iPod touch or iPhone.

### Development

I'm currently not looking to work on this project at all, as I won't be needing it for any particular purpose anymore.  However, if you see something that I messed up, go ahead and make a pull request and I'll take a look at it.  The main thing I'd like to know how to fix, if anyone can figure it out, is if you scroll down in the table view with the parts list, then scroll back up, the switches reset to their previous state if you changed them at all because the condition code is changed on the server end but not re-synced to the client end.  An easy solution would be to have it resync every time you scroll so it is always up to date, but that's extremely taxing on bandwith and I wanted this to work on very slow Internet, so I'd need it to not download the entire update list every time.
