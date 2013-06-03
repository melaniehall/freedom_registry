NSS-freedom_registry
=====================


Purpose
-------

The goal of this project is to create a command line tool that integrates with the <a href="http://www.freedomregistry.org/" target="_blank">Freedom Registry</a>, allowing users to quickly search through the registry and utilize the information that is relevent to them.

Project Status / TODO
---------------------
[![Build Status](https://travis-ci.org/melaniehall/freedom_registry.png)](https://travis-ci.org/melaniehall/freedom_registry)

- Main features working.
- Currently fixing "list all" bug, refactoring, and beginning Phase 2.

<a href="https://codeclimate.com/github/melaniehall/freedom_registry"><img src="https://codeclimate.com/github/melaniehall/freedom_registry.png" /></a>

Features
--------
- List all organizations
- Search organizations by state, by name, by keyword
- List profiles for individual organizations

Usage Instructions
------------------
Planned usage is as follows:

Getting Started:
  On load of freedom_registry, users will see a welcome screen with a brief into to the Freedom Registry and a list of commands to get started:

    1. list all..........................(List all)
    2. by name "name goes here"..........(Search by name)
    3. by state "state"..................(Search by state)
    4. by keyword "keyword"..............(Search by keyword)

  <strong>list all </strong><br/>
  Returns a list of all the organizations in the Freedom Registry 2.0 (paginated for easy searching): list includes id#, name, city/state, and website (if applicable)

  <strong> by name "name" </strong><br/>
  Returns a list of all the organizations that contain the name entered.

  <strong>by state "state"</strong><br/>
  Returns a list of all the organizations in state indicated.<br/>

  <strong> by keyword "keyword"</strong><br/>
  Returns a list of all the organizations that match keyword input.

  <strong>To see more information </strong>on an organization listed, a user can enter the id number of the organization:
  > view 312 <br/>
  This will return a formatted output of the name, location, website, mission statement, and primary contact info.

  <strong>If there are no matches </strong> (or if user enters an invalid input), users will be given the option to:
  1. Start a new Search (new)
  2. Exit


Known Bugs
----------

List all feature terminates the program.

Author
------

Melanie Hall

<hr/>
<strong>Future Features (Phase 2):</strong>
- Organization Info <br/>
In an organization's profile view, a user will have the option to:<br/>
      1) open the organization's website in their browser, <br/>
      2) send an e-mail message to the contact person directly <br/>
      3) Follow the organization on Twitter (or add the org to a UserList)

- Tag Your Favorites <br/>
add "id#" <br/>
will add this organization to a list of your favorites <br/>

<hr/>

License
-------
Copyright (c) 2013 Melanie Hall

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
