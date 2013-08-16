WSearch

Installation:

using pathogen.vim :
download folder into your bundle folder.

else:
You can allways source autoload/WSearch.vim
In your vimrc append to file 
	 source [PATHTHEPLUGIN]/WSearch/autoload/WSearch.vim
Or from the command line
	 :source [PATHTHEPLUGIN]/WSearch/autoload/WSearch.vim



Commands:

* Pressing tab when intreducing tag name will autocomplete.
* When using search commands search pattern will be copied to clipboard
* Site must start with http:// or https:// in order to be open in the browser else a file will be open.
* Vim Feture Reminder - Functions can be autocomplete you can :wse and then tab in order to get :WSearch.

WSearchInit - 
Start new WSearch repository(folder) in the current (PWD) folder

WSearchSaveTagAndSite [Tag] [Site] - 
Save tag and a site .WSearch folder must exists (WSearchInit) . 
Saving on the same tag will replace the old value.
Url can have {WSearch} in it , this will be replaced when searching.
Example:
:WSearchSaveTagAndSite google https://www.google.com/search?q={WSearch}

WSearchShow [Tag] -
Shows a url ralted for this Tag

WSearchRemoveTag [Tag] -
Removes the specified Tag

SearchCommands:

WSearch [SearchContent] - 
Will get the latesturl (last saved or WSearchATag ) and will reaplce the {WSearch} with SearchContent

WSearchATag [Tag] - 
The same as WSearch except getting the url related to Tag
Example:
:WSearchATag google

WSearchATag [Tag] [SearchConectent] - 
the same as WSearch with SearchContent except getting the url related to Tag
Example:
:WSearchATag google hello WSearch
