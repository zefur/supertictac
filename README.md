# README

## SuperTicTac
### *Notice* ### 

After speaking with a friend and talking through the code with her I have decided to leave this project at V1 (MVP). Its basic functionality for a two player game is there and does work playable here [supertictac.herokuapp.com](supertictac.herokuapp.com). But due to my future plans for this and my current code set up (namely the doing all changes in the database), I realised it would be better to start again from scratch to build all the implementable features properly. So this notice is to say Look out for V2.

### Things in V1 ###

- ~~make it two player only (more people can watch but only two can interact)~~
- ~~finish the move logic (activating and deactivating cells) you should only be able to play in the highlighted cells~~
- ~~implement the game logic (the basics are already there in Game.rb and Board.rb)~~
- ~~Add stupid Ai~~
- ~~Add login and profile pages(implemented basic)~~
- ~~Stat tracking capabilities(wins and losses implemented)~~
- ~~Allow the destruction of rooms(guest's rooms /should/ delete on log out)~~

### Moved to V2 plans ###
- Chat functionality
- STYLING
- Chat capabilities 
- Add login and profile pages(implemented basic)
- Advanced Stat tracking capabilities
- Add powerups
- Different game modes
- Add smart AI
- Allow for options in the room build method

Probably a lot more to do

### Rules ###

Rules of the game are when you place a mark in a cell that highlights the quadrant the player has to play in next you can not play anywhere.
To win the game you need to win 3 of the smaller games in a row, so its more strategy and technical thinking than basic tictac

Its better playing against a human opponent rather than ai

### Usage ###

A basic version is playable at [supertictac.herokuapp.com](supertictac.herokuapp.com) please click guest to log you in with a burner account and then go to start game to create a game room. You can play against a dumb ai by adding clicking the play against the computer. Otherwise if you send the browser link to another player they should automatically be given a guest login. if you want to test out against yourself using the same browser open the second window in incognito mode otherwise another browser should work (chome vs safari). Please leave the game only by clicking the leave game link 

This is a beta so there will be bugs
