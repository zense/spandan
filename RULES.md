Introduction
--------------
This document gives a brief overview of the rules we have to keep in mind while designing the registration system. 
If you point out any flaws or have any changes in your mind, please comment on this link: https://github.com/zense/spandan/issues/22
<br> Please note that this is just a draft and can have many flaws. 

Information Related to Events
------------------------------------------------

There are three type of events 
* INDIVIDUAL - A person can register for these events only as Individuals, not as a team. 
* TEAM - The number of registrations for these events depends on the "maximum_team_size" and "minimum_team_size" attributes of Team Model.
* CUSTOM - These are only for management purpose and they should not be displayed on the website anywhere. Admin will not upload any rules or descriptions regarding these events and do make sure that you don't display it on the website. 

Please note that there is a field called "parent_event" in events table which by default is NULL. 
In case if an event is a sub-event then that field will have the id of parent event. 

### Registrations table
This table is used to store registrations for all the events. TEAM and INDIVIDUAL both. 
* For a team event, the team_id: not null, user_id: null 
* For a individual event registration, team_id: null, user_id: not null

### How to register? 
Registration code should follow these rules: 
* Based on the event name, check if the event type is TEAM or INDIVIDUAL. If the event is a team event, then open a page
which has team registration form else open an Indivdual registration form which can just be a button since we have all 
the information we want. 

### When to not allow registration?
For Individual Event, If user_id A is trying to register for an event_id E:
* If an entry for user_id=A and event_id=E exists in registrations table with status=VALID then user should not be allowed
to register for the Individual event. 

For TEAM Event. Note that in this case a single person will register for many people so validation will be a bit different. 
For each member whose "email id" is there in the registration form do the following check. 
* Check if that email id exists in our Users table or not. If not deny registration. 
* Search in team_members with params (You can obtain user_id by querying Users table using email): user_id=A and event_id=E. If you find any such entry then get the "team_id" of that entry.
After that check in the registrations table.
  * If that team_id exists and status=VALID for that registration entry then deny registration for the whole team stating reason
  that X member is already registered in some team. 
  
Please note that while registering for a team event, following entries should be made simultaneously to prevent redundant 
entries in db. If all the conditions for team event registration are met, then:
*  create a new team entry in "teams" table. 
*  take team_id obtained from above to create subsequent "team_members" entries. There will be one entry per team_member in the team_members table
*  create a entry in registrations table with the team id obtained above. 
* Please bundle all these in a DB transaction so as to prevent failure. 

### Validity of a Team
For any event, any person can create a team and register if the following conditions are met.
* The event for which the given person is trying to register is a team event. 
* The person is not a part of some team which has already registered for that particular event 
for which the given person is trying to create a team.
  * For example: If person1 is already a part of some team which is registered for football then that person
should not be allowed to be a part of any other football team.
* The size of team created by the given person is in range of "minimum_team_size" to "maximum_team_size" of the team event.
* Once a person creates a team for some event and registers, if the conditions above are met then that team will be automatically
approved and their registration will become valid. 
* All the members will get a notification about their addition and registration and they don't have to approve anything
but if they want to opt out or they have been added by mistake then they have to reject the change for which they will get
an option in the notification itself. If they reject the "team addition" then the registration for that entire team will be
cancelled and they will have to register again. 
