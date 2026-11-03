local LH=require('UI.LH')
local px,tex,tx=LH.px,LH.tex,LH.tx
local function _h1(a0,a1,a2,a3,a4,a5,a6,a7) return {key=a0,type=a1,pos=a2,text=a3,style=a4,rect=a5,hAlign=a6,color=a7} end
local Gui = require('UI.Gui')
local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local LEFT_BOX_X = -425
local RIGHT_BOX_X = 25
local TWO_BOX_WIDTH = 400
local SPACER = 150
local LINE_HEIGHT = 40
local function col(t) return table.concat(t,'\n')..'\n', #t*LINE_HEIGHT end
local SPACEBASE_Y, SPACEBASE_HEIGHT = 50, 0
local SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = 'Project Lead\n', 'JP LeBreton\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Senior Producer\n', SB_TEAM_RIGHT..'Gabe Miller\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Lead Programmer\n', SB_TEAM_RIGHT..'Matt Franklin\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Lead Artist\n', SB_TEAM_RIGHT..'Jeremy Mitchell\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Graphics Programmer\n', SB_TEAM_RIGHT..'Ben Burbank\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Programming\n', SB_TEAM_RIGHT..'Kee Chi\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'\n', SB_TEAM_RIGHT..'Patrick Connor\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'\n', SB_TEAM_RIGHT..'Nathan Martz\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'\n', SB_TEAM_RIGHT..'Ben Peck\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Character Modeler\n', SB_TEAM_RIGHT..'Jeremy Natividad\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Interface Design\n', SB_TEAM_RIGHT..'Jake Rodkin\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Animators\n', SB_TEAM_RIGHT..'Elliott Roberts\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'\n', SB_TEAM_RIGHT..'Ray Crook\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'\n', SB_TEAM_RIGHT..'Chris Lam\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Materials\n', SB_TEAM_RIGHT..'Kristen Russell\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Additional Art\n', SB_TEAM_RIGHT..'Derek Brand\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'\n', SB_TEAM_RIGHT..'Razmig Mavlian\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'\n', SB_TEAM_RIGHT..'Geoff Soulis\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'\n', SB_TEAM_RIGHT..'Frederik Storm\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Sound Designers\n', SB_TEAM_RIGHT..'Brian Correia\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'\n', SB_TEAM_RIGHT..'Camden Stoddard\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Music\n', SB_TEAM_RIGHT..'Chris Remo\n', SPACEBASE_HEIGHT + LINE_HEIGHT
SB_TEAM_LEFT, SB_TEAM_RIGHT, SPACEBASE_HEIGHT = SB_TEAM_LEFT..'Lead Tester\n', SB_TEAM_RIGHT..'Tony Lo\n', SPACEBASE_HEIGHT + LINE_HEIGHT
local DF_Y, DF_HEIGHT = SPACEBASE_Y - SPACEBASE_HEIGHT - SPACER, 0
local DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = 'CEO and Studio Creative Director\n', 'Tim Schafer\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'COO\n', DF_TEAM_RIGHT..'Justin Bailey\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'VP of Development\n', DF_TEAM_RIGHT..'Isa Anne Stamos\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'Audio Director\n', DF_TEAM_RIGHT..'Brian Min\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'Senior Publishing Manager\n', DF_TEAM_RIGHT..'Greg Rice\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'Web Development\n', DF_TEAM_RIGHT..'Chris Remo\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'QA Manager\n', DF_TEAM_RIGHT..'Daniel Pangelina\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'Tech Ops Manager\n', DF_TEAM_RIGHT..'Aaron Hayes\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'Desktop Technician\n', DF_TEAM_RIGHT..'Justin Honegger\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'Studio Tech\n', DF_TEAM_RIGHT..'Adrian Melian\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'\n', DF_TEAM_RIGHT..'Anna Kipnis\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'\n', DF_TEAM_RIGHT..'Brandon Dillon\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'\n', DF_TEAM_RIGHT..'Oliver Franzke\n', DF_HEIGHT + LINE_HEIGHT
DF_TEAM_LEFT, DF_TEAM_RIGHT, DF_HEIGHT = DF_TEAM_LEFT..'\n', DF_TEAM_RIGHT..'Paul Du Bois\n', DF_HEIGHT + LINE_HEIGHT
local INDIEFUND_Y, INDIEFUND_HEIGHT = DF_Y - DF_HEIGHT - SPACER, 0
local INDIEFUND_TEXT, INDIEFUND_HEIGHT = col{'Indie Fund','Humble Bundle','Hemisphere Games','make all LLC','AppAbove Games','Adam and Rebekah Saltsman','The Behemoth','Morgan Webb','Rob Reid'}
local SPECIALTHANKS_Y, SPECIALTHANKS_HEIGHT = INDIEFUND_Y - INDIEFUND_HEIGHT - SPACER, 0
local SPECIALTHANKS_TEXT, SPECIALTHANKS_HEIGHT = col{'Mom, Dad, and Elise','Katrina Tilds & Truman','Ruth, Violet, and Valencia','Jess, Jho, Margot and Jack Fields','Amanda, Lana, Oliver ','Mighty','Kayla Stead','Nick Breckon','Keri, Tia (Cake), Terra (Kicks) Bailey, and Jack C. Bailey'}
local DFTHANKS_Y, DFTHANKS_HEIGHT = SPECIALTHANKS_Y - SPECIALTHANKS_HEIGHT - SPACER, 0
local DFTHANKS_TEXT, DFTHANKS_HEIGHT = col{'bobsayshilol','Dingobloo','Zak McClendon','Coldrice','Tynan Sylvester','Ray Yetka','Tynan Wales',"Jason O'Connell",'Jack Fields','Kent Hudson','Aubrey Hesselgren','Rich Wilson','David Pittman','Scott LaGrasta','L Stiger','Will Armstrong','twoflower','Korbei83','postfish','MichaelM','clydebink','pianobadger','dvdhaus','Robon','liorean','Acorino','nulian','SirDregan','DaveKap','AlexCovic','SlothOnFire','spacebug','marcus','centax'}
local CITIZENS_Y, CITIZENS_HEIGHT = DFTHANKS_Y - DFTHANKS_HEIGHT - SPACER, 0
local CITIZENS_TEXT, CITIZENS_HEIGHT = col{'Juuso Haimilahti','Mark Kalinic','Stefan Gagne','Rox_Out','Brendan Sinclair','ZOP','Finis Kalan','Cheeseness','Jes Golka','Jeffrey Rosen','Vicente Emmanuel Toppington',"Frank 'Aetheria' Wentink",'Dustin Noah Brady','James Feister','Will Hudson','TLM3101','Ross "TorpedoBeetle" Dexter','João Carlos Bastos','Harrison G. Pink','Steve Gaynor','Richard Porczak','Torbjørn Grønnevik Dahle','Ortwyn Regal','Sghoul','Nicholas "Mongo" Malfatti','Matthew Waegelin','Benjamin Kantor','Peter Silk',"Michiel 'elmuerte' Hendriks",'Markus Bachler','Patrick Kirkner','Steve Stone','Colin Marc','Julian Schmid','Claire Blackshaw','Edmond Tran','Dave Kellaway','Dinnerbone','Jim Fasoline','Adam Heslop','Donato "ricin" Sinicco, III','Brock Wilbur','Andrew (Kayrack) Chapman','Corey Van Meekeren','Mikhail Popov','Craig Alexander Dolan','Michael Klamerus','Dominique Dubois','Brian Krenrich','Noel Nacion','Timothy M. Lewis','Paul Mach','Sam Courtney','Malek Annabi','Matthew Jacques','Matthew Blaine Smith','Jon Caldwell','Fang-Kai Hsieh','Jason Christensen','Mike Weldon','Angelo "Peps" Pepe','Matthew S. Turvey','Doug Tabacco','Dimitri Roche','Heidi Hokka','Ryan Corathers','Zhang JingQI','Tom Grundy','Yegor Myronenko a.k.a. YogiTheWise','Jesse Clark','Matthew Casebeer','Joseph M Bascetta','Casey Young','Nicholas Wogberg','Jenn Sandercock','Luke Jennings','Lovisa Hansén','Charlie Hoyt','Brenton D I Dick','Justin "NeoWulf" Smith','Jonathon Bowyer','Bryce Whitty','Arne Roomann-Kurrik','Brian Haucke','Lennart Kessler','James Mitchell','Maarten Degenhart','Wolfram Riedel','zer0her0','Andreas Sammer','Duane Bekaert','Glenn','Max Zettlmeißl','Nicholas Paul Finuf','Kel Cecil','Johan Hansén','Ryan Tornell','Maik Erhard','Joe Shipley','Solemklanen','Terry Walker','Peter Leyshan','Frantisek Bauer','Izzdin Tan','Michael Beemer','Karsing Fung','Austin Coccia','Steve Tranby','Charles Banas','Nick Orlowski','Gary Marshall','Michele Colombo','Alain Labranche','Wesley Ng-A-Fook','Colum Linnane','Brodman','Adam Kamrad','Richard Symons aka Udders','"Copesetic" Matt Kaplan','J Hammarström','Richard Kyte','Joshua W Reeves','Massimo Crea','Axel Baxarias Fontaine','Dennis Hillmann','Mycroft Geek','Ben Jackson','LC NOoSE IV','Thomas Dollahon','Robert Campbell','Jeremy Minx','Gemini Wong','Dead Videos','Connor Richman','Eduardo Reyes Álvarez (Lalo)','Charlie Nordlund','Nicholas Bomford','Randy Flagg','Peri (Arunion) Holm','Lachlan Cooper','Ashley White','Steve Etherington','Gabriel Psarros','Chris Blackmore','Dominick Allen','JohnHeroHD','Dominik Johann','Lann Cowman','Carlos M Gomez','Stefan Correa','Bob-Colin Balkenhol','Kati Graham','Tory Netherton','Andrew Dennison','Jay Furman','Patrix Devitt','Florian Hirt (Spelaea)','Luca Frigerio','Byron Lunau','Fierre Mallow','Sunit Das','Dan P','Nate "Obs" Smalley','Adrian Eccles','James A York','John Cruickshanks','Ian Corcoran','Alexander A. Young','Todd Kolbuck','Matthias Grunwald','Nikita Samoylov','J.A. Dalley','Paul Jickling','Florian Maunier','Daniel Harmsworth','Heiko Müller','Johan "Skörk" Björk','Jeff "Golg0than" Jankowski','Brandon Traffanstedt','Caleb McCarty','Jesse Coppel','Kai Weutzing','J.D. Cohen','Lisa Shearman','Norleif Slettebø','Tommy Kjær Mikkelsen','Sascha Lipiec','William Brockie','Alexander Simmons','Joseph Milazzo','Steve Wilman','Piotr Michalczyk','Mecheil Shiflett','Michael Glen Fuller Jr','usoda','Jeremy Moody','Timothy Allen Gray','Tom "Remirol" Lorimer','Isaac Blum','Jeff Tarpy','Andy Causon','Dennis S. H.','David "DHeth" Heth','Thomas Adam Madigan','Christopher Hartley Fratz','Jacques MIchelet','Bleualtoids','Caro Ilott','Nathan Lubinski','Andrew "Ace" Campbell','Derek Gore','Shawnee Camu Altmann','Cameron Tingley (ultrapwner45)','Whittle','Sean Pelkey','Nathan Taylor','SZPYTMA Cyril','David L. Heth','Maximilian Marx','Sebastian Bieler','Bastian Meissner','Patrick Vöhrs','Volker Andres','Seth Brush','Axel Woermann','Lars -harlequin- Meyer','Stefan Weber','Leon Roman Schindler',"Sascha 'Drakon Drakunov' Möller",'Carl "Carlius" Gillblad','Michael','Brian Levinsen','Roland Veen','Jason Scrivens',"TV's Adam Taliercio",'Pawel Kolek','Trent Petronaitis','Marcel (matzsystem) Matz','Jarred Brown','Steph Gibbs','Lukas Sarnowski','Larry Hong','Nick Pitino','Alex Dunlevie','Timothy Bridges','Koen De Couck','spynet1966','Aidan Coxon','Gatewayy','Jarred Leverton','Stefan "Prince Metal" Weber','Chase Miles','Michael D. Hoyle','Eric Amsler','Jeremy Blake','Undead.Potato','Justin Ouellette','Matthew Daly','Engin Ünsal',"Tim 'Bales' Bridges",'Chris Klugewicz','Scott Wood',"Phillip 'Palnai' Kinsella",'Michael Brewer','Travis Q Goodwin','PanMocny','Reptarella','X Myth aka Mark Saunders','Kris Lantzy','Frank "The Tank" Messier','Albert G.','Krister "Probeus" Berntsen','YamiCaleb SoulSlayer','L. Long','David Elton','Jose Biosca Martin','Steve Gauthier','Matt Falzone','Scott Stevenson','Michael J. Rice','Mr. J.P. Drum','Andrew Simpson','Tyler Rielly','Riaan Jonker','Brumley Daniel Pritchett, Jr','Daniel "Curumim" Cruz Lopez','Steve Olic','Atahan','Dave Mongoose','Thomas Wyndham','Sunit Das','John McDaris','Heather Quinnell','Robert A Vick, V','BrainlessKing','Pascal (Sev)  Vogler','Tyler Cooke','Christopher Grimm','Michael Barrell','Logan Mac','Alexis Levan',"Timothy 'Bales' Bridges",'Mimness','György Somorjai','Malcolm J. MacDonald','alexthekok','GOODYBOY','Lewis Emmas','Will Woods','Michael Harris','Dave Sherman','Daniel JW Ellis','Jennifer McMurray','Andreas Sjursen','Joey Fowler','Trevor Cobbett','Jennifer McMurray'}
local AFTHANKS_Y, AFTHANKS_HEIGHT = CITIZENS_Y - CITIZENS_HEIGHT - SPACER, 0
local AFTHANKS_TEXT, AFTHANKS_HEIGHT = col{'JP LeBreton','Matt Franklin','Anna Kipnis','Joe Kowalski','Nathan Martz','Jeremy Mitchell','Say Oh','Chris Remo','Nathan Stapley'}
return
{
    posInfo =
        {
        alignX = 'center',
        alignY = 'center',
        offsetX = 0,
        offsetY = 0,
        scale = { 1, 1 },
    },
    tElements =
    {
        px('Background',{ -0, 0 },{ 2568, 1444 },{ 0, 0, 0, 0.83 },false),
        tex('Logo','logo','UI/StartMenu',{ -1920/2, 1152/2 + 50 },Gui.WHITE,{ 1.5, 1.5 },false),
        tx('SpaceTeamHeader',{ -200, SPACEBASE_Y },"Spacebase Team",'dosissemibold48',{ 0, 0, 400, 200 },Gui.AMBER,'C','C'),
        _h1('SpaceTeamLeft', 'textBox', { LEFT_BOX_X, SPACEBASE_Y - SPACEBASE_HEIGHT + 50}, SB_TEAM_LEFT, 'dosissemibold30', { 0, 0, TWO_BOX_WIDTH, SPACEBASE_HEIGHT }, MOAITextBox.RIGHT_JUSTIFY, Gui.WHITE),
        _h1('SpaceTeamRight', 'textBox', { RIGHT_BOX_X, SPACEBASE_Y - SPACEBASE_HEIGHT + 50 }, SB_TEAM_RIGHT, 'dosissemibold30', { 0, 0, TWO_BOX_WIDTH, SPACEBASE_HEIGHT }, MOAITextBox.LEFT_JUSTIFY, Gui.WHITE),
        tx('DoubleFineHeader',{ -150, DF_Y },"Double Fine",'dosissemibold48',{ 0, 0, 300, 200 },Gui.AMBER,'C','C'),
        _h1('DoubleFineLeft', 'textBox', { LEFT_BOX_X, DF_Y - DF_HEIGHT + 50 }, DF_TEAM_LEFT, 'dosissemibold30', { 0, 0, TWO_BOX_WIDTH, DF_HEIGHT }, MOAITextBox.RIGHT_JUSTIFY, Gui.WHITE),
        _h1('DoubleFineRight', 'textBox', { RIGHT_BOX_X, DF_Y - DF_HEIGHT + 50 }, DF_TEAM_RIGHT, 'dosissemibold30', { 0, 0, TWO_BOX_WIDTH, DF_HEIGHT }, MOAITextBox.LEFT_JUSTIFY, Gui.WHITE),
        tx('IndiefundHeader',{ -500, INDIEFUND_Y },"Spacebase Was Made Possible By",'dosissemibold48',{ 0, 0, 1000, 200 },Gui.AMBER,'C','C'),
        tx('Indiefund',{ -250, INDIEFUND_Y - INDIEFUND_HEIGHT + 50 },INDIEFUND_TEXT,'dosissemibold30',{ 0, 0, 500, INDIEFUND_HEIGHT },Gui.WHITE,'C','C'),
        tx('SpecialThanksHeader',{ -150, SPECIALTHANKS_Y },"Special Thanks",'dosissemibold48',{ 0, 0, 300, 200 },Gui.AMBER,'C','C'),
        tx('SpecialThanks',{ -350, SPECIALTHANKS_Y - SPECIALTHANKS_HEIGHT + 50 },SPECIALTHANKS_TEXT,'dosissemibold30',{ 0, 0, 700, SPECIALTHANKS_HEIGHT },Gui.WHITE,'C','C'),
		tx('FamousCitizensHeader',{ -500, CITIZENS_Y },"Famous Citizens",'dosissemibold48',{ 0, 0, 1000, 200 },Gui.AMBER,'C','C'),
        tx('FamousCitizens',{ -350, CITIZENS_Y - CITIZENS_HEIGHT + 50 },CITIZENS_TEXT,'dosissemibold30',{ 0, 0, 700, CITIZENS_HEIGHT },Gui.WHITE,'C','C'),
        tx('DFThanksHeader',{ -500, DFTHANKS_Y },"Double Fine Would Also Like To Thank",'dosissemibold48',{ 0, 0, 1000, 200 },Gui.AMBER,'C','C'),
        tx('DFThanks',{ -350, DFTHANKS_Y - DFTHANKS_HEIGHT + 50 },DFTHANKS_TEXT,'dosissemibold30',{ 0, 0, 700, DFTHANKS_HEIGHT },Gui.WHITE,'C','C'),
                tx('AFThanksHeader',{ -500, AFTHANKS_Y },"Original Amnesia Fortnight Spacebase Team",'dosissemibold48',{ 0, 0, 1000, 200 },Gui.AMBER,'C','C'),
        tx('AFThanks',{ -350, AFTHANKS_Y - AFTHANKS_HEIGHT + 50 },AFTHANKS_TEXT,'dosissemibold30',{ 0, 0, 700, AFTHANKS_HEIGHT },Gui.WHITE,'C','C'),
    },
}
