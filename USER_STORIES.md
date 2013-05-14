User Stories for Freedom Registry CLI
==================================================

<hr />

As a non-profit working in prevention of human trafficking<br />
In order to collaborate with other NPOs in my state for an event<br />
I want to look-up a list of similar non-profits in my state.

  - User runs `find state <current state>`
  - User is given a list of the ID#s, Names, City/State Locations, and Websites (if applicable) of all the NPOs in the User's state.

<hr />

As a donor<br/>
In order to support quality aftercare<br />
I want to find a NPO that provides aftercare to victims of sex-trafficking.

  - User runs `find keyword <aftercare>`
  - User is shown a list of organizations in the US that mention aftercare in their mission statement, as a key area of work, or elsewhere in their profile.

<hr />

As a social entrepreneur<br />
In order to find out more information about an organization I recently heard about<br />
I want to search for that organization by name.

  - User runs `find name <organization name>`
  - User is shown a list of organizations in the US that match the name entered.
  - User can then run `ls <ID# of organization` to view more information.

<hr />

As a person who recently learned about modern-day slavery<br />
In order to familiarize myself with names of relevant organizations<br />
I want to browse a long list of organizations in the US involved in combatting human trafficking.

  - User runs `ls all` to see a list of all organizations in the Freedom Registry.

<hr />

As a volunteer<br/>
In order to find out more information about a specific organization I see listed<br/>
I want to view that organizations' extended profile:

  - User (who is already viewing a list of organizations or knows the ID# by heart) runs `ls 31` (list <ID# of organization>)
  - User can now see a formatted profile of the name, location, website, mission statement, whether or not the organization accepts volunteers, and the primary contact information of the selected organization.

