--Add Help
--Titel is the text that is shown in Menu
--con is the text, taht you see when clicking on
--the title
table.insert(helpta,{titel="New Help",con="My first Plugin"})

--Add a Command to the Shell
shellcom.example = function() mynaptic.setShellText("My first Command") end

--Add a Item to the Menu

--This function is called when clicked the Menuitem
function mynaptic.newitem()
--Show "Hello World" in the Searchbar
  mynaptic.setShellText("Hello World!")
end

--The Screen of the Turtle is not big enough for
--another menuitem
if not(turtle) then
--Text is the text of the Menuitem
--func is the function, who is called when clicked
  table.insert(mynaptic.menubar,{text="Example",func=mynaptic.newitem})
end
