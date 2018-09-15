--OptionsMenu.lua
--A class for the main Just Rain options menu

module(..., package.seeall)
local translations;
-- local language =  userDefinedLanguage or system.getPreference("ui", "language")
local language;
local store_string;
-- local extendedPurchased = false;
local OptionsMenu = {}
 
function OptionsMenu.new(analytics, the_language, the_translations, the_store_string)
  -- local extendedPurchased = extended;
  local optionsMenu = display.newGroup();
  local bg = display.newRect(600,400,display.actualContentWidth,display.actualContentHeight)
  local minTextAlpha = 1;
  local minToggleBoxAlpha = 0.1;
  local textYStart = 80;
  local textYSpacing = 70;
  local textXStart = 50;
  store_string = the_store_string;
  language = the_language;
  translations = the_translations
  -- googleAnalytics = analytics
  bg:setReferencePoint(display.centerReferencePoint);
  bg.x = display.contentCenterX
  bg.y = display.contentCenterY;
  bg:setFillColor(0,0,0,255)
  bg.alpha = 0.8;
  optionsMenu:insert(bg);
  optionsMenu.alpha = 0;
  optionsMenu.activated = false;
  optionsMenu.selection = 1;

local function onToggleTouch(self, event)
  if (extendedPurchased or optionsMenu.options[self.id].extended == false) then
    if (event.phase == "began") then
      if (optionsMenu.options[self.id].toggle == "off") then
        -- googleAnalytics.logEvent( "userAction", "toggle on", optionsMenu.options[self.id].label  )
            if (self.id == 6) then
          timeSleepTimerSet = os.time();
          print("SETTING TIME SLEEP TIMER SET")
        end
        optionsMenu.options[self.id].toggle = "on"
        optionsMenu.options[self.id].toggleBox.alpha = 1.0;

    
       
      else
        optionsMenu.options[self.id].toggle = "off"
        optionsMenu.options[self.id].toggleBox.alpha = minToggleBoxAlpha;
        -- googleAnalytics.logEvent( "userAction", "toggle off", optionsMenu.options[self.id].label  )
       

      end
    end
  end
end

local backPrompt = display.newGroup();

    -- backPrompt.alpha = 1.0;
    local backHotZone = display.newRect(display.screenOriginX, display.contentHeight - 200, 200, 200);
    backHotZone:setFillColor(255,0,255);
    backHotZone.alpha = 0;
    backHotZone.isHitTestable = true;

    -- local selectIcon = display.newImage("ouyaselect.png", 150,800)
    -- local selectText = display.newText("SELECT",200,789, "Knockout-HTF29-JuniorLiteweight", 40)
    local backIcon = display.newImage("amazonback.png",display.screenOriginX + 50,650)
    local backText = display.newText(translations["Back"][language], display.screenOriginX + 100, 649, "Knockout-HTF29-JuniorLiteweight", 40)
  

 -- backPrompt.alpha = 1.0;
    local purchaseHotZone = display.newRect(display.actualContentWidth-600, display.contentHeight - 200, 600, 200);
    purchaseHotZone:setFillColor(255,255,255);
    purchaseHotZone.alpha = 0;
    -- purchaseHotZone.isHitTestable = true;
    
    purchaseHotZone.isHitTestable = true;

       local restoreHotZone = display.newRect(display.actualContentWidth/2, display.contentHeight - 150, 400, 150);
    restoreHotZone:setFillColor(255,255,255);

    restoreHotZone.x = display.screenOriginX + display.actualContentWidth/2 
      restoreHotZone:setReferencePoint(display.TopCenterReferencePoint)
    restoreHotZone.alpha = 0;
    -- restoreHotZone.isHitTestable = true;
    
    restoreHotZone.isHitTestable = true;


    -- local selectIcon = display.newImage("ouyaselect.png", 150,800)
    -- local selectText = display.newText("SELECT",200,789, "Knockout-HTF29-JuniorLiteweight", 40)
    -- local purchaseIcon = display.newImage("amazonback.png",display.pixelHeight,650)
    -- purchaseIcon:setReferencePoint(display.CenterRightReferencePoint);
    -- purchaseIcon.x = display.screenOriginX + display.actualContentWidth;


    local purchaseText = display.newText("Purchase Extended Features", display.actualContentWidth - 560, 649, "Knockout-HTF29-JuniorLiteweight", 40)
    purchaseText:setReferencePoint(display.TopRightReferencePoint)
    purchaseText.x = display.screenOriginX + display.actualContentWidth - 50;

      local restoreText = display.newText("Restore Extended Features", display.actualContentWidth - 560, 649, "Knockout-HTF29-JuniorLiteweight", 40)
    restoreText:setReferencePoint(display.TopCenterReferencePoint)
    restoreText.x = display.screenOriginX + display.actualContentWidth/2 
    
    if (system.getInfo("platform") == "android") then
      restoreText.alpha = 0;
      restoreHotZone.isHitTestable = false;
    end

 if (extendedPurchased == true) then
-- purchaseIcon.alpha = 0;
purchaseText.alpha = 0;
purchaseHotZone.alpha = 0;
purchaseHotZone.isHitTestable = false;

restoreText.alpha = 0
restoreHotZone.alpha = 0
restoreHotZone.isHitTestable = false;

end


   backPrompt:insert(backIcon);
    backPrompt:insert(backText);
    backPrompt:insert(backHotZone);
    backPrompt:insert(purchaseHotZone);
    backPrompt:insert(purchaseText)
    backPrompt:insert(restoreHotZone);
    backPrompt:insert(restoreText)
   -- Handler that gets notified when the alert closes
local function purchaseAlertComplete( event )
    if ( event.action == "clicked" ) then
        local i = event.index
        if ( i == 1 ) then
          purchaseItem();
            -- Do nothing; dialog will simply dismiss
        elseif ( i == 2 ) then
            -- Open URL if "Learn More" (second button) was clicked
           store.restore();
        end
    end
end
  
-- Show alert with two buttons


local function purchaseTouch(self, event)
  print("HAPPENED")
  if (event.phase == "began") then
    purchaseItem();
    -- local alert = native.showAlert( "Just Rain", "Would you like to purchase or restore Just Rain Extended Features?", { "Purchase", "Restore" }, purchaseAlertComplete )
  end
end

purchaseHotZone.touch = purchaseTouch;
purchaseHotZone:addEventListener( "touch",  purchaseHotZone )

local function restoreTouch(self, event)
  print("HAPPENED")
  if (event.phase == "began") then
     print("is store active?")
      print(store.isActive);
      if (store.isActive) then
         store.restore();
         local alert = native.showAlert( "Purchases restored", "Your purchases have successfully been restored.", { "OK"}, onComplete )
      else 
        print("no network connection, we guess")
        local alert = native.showAlert( "No network connection", "Couldn't connect to " .. store_string .. ". Please check your internet connection.", { "OK"}, onComplete )
      end
        
   


  end
end

restoreHotZone.touch = restoreTouch;
restoreHotZone:addEventListener( "touch",  restoreHotZone )

   local function backTouch(self, event)
    if (event.phase == "began") then
optionsMenu:deactivate();
menuHotZone.isHitTestable = true;
return true
  end
    if (event.phase == "ended") then
    
    end

   end
      backHotZone.touch = backTouch;
 backHotZone:addEventListener( "touch",  backHotZone )
    -- backPrompt:insert(selectIcon);
    -- backPrompt:insert(selectText)
    -- transition.to(backPrompt,{time=1000, delay=1000, alpha=1.0});
  
  optionsMenu:insert(backPrompt);

    local muteSoundText = display.newText(translations["Mute Sounds"][language], 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  muteSoundText:setReferencePoint(display.TopLeftReferencePoint);
  muteSoundText.alpha = 1.0;
  muteSoundText.x = textXStart;
  muteSoundText.y = textYStart;
  
  local muteSoundToggleBox = display.newRect(890,640,50,50);
  muteSoundToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  muteSoundToggleBox.alpha = minToggleBoxAlpha;
  muteSoundToggleBox.y = textYStart;
  muteSoundToggleBox.id = 1;
   muteSoundToggleBox.touch = onToggleTouch
muteSoundToggleBox:addEventListener( "touch", muteSoundToggleBox )


  local optionClockText = display.newText(translations["Clock"][language], 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionClockText:setReferencePoint(display.TopLeftReferencePoint);
  optionClockText.alpha = minTextAlpha;
  optionClockText.x = textXStart;
  optionClockText.y = textYStart + textYSpacing;
  
  local optionClockToggleBox = display.newRect(890,650,50,50);
  optionClockToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionClockToggleBox.alpha = minToggleBoxAlpha;
  optionClockToggleBox.y = textYStart + textYSpacing;
  optionClockToggleBox.id = 2;

  -- optionClockToggleBox:addEventListener()
  

  optionClockToggleBox.touch = onToggleTouch
optionClockToggleBox:addEventListener( "touch", optionClockToggleBox )

   local optionWanderText =  display.newText(translations["Wander Mode"][language], 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionWanderText:setReferencePoint(display.TopLeftReferencePoint);
  optionWanderText.alpha = minTextAlpha;
    optionWanderText.x = textXStart;
  optionWanderText.y = textYStart + textYSpacing * 2


    local optionTwoToggleBox = display.newRect(890,670,50,50);
  optionTwoToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionTwoToggleBox.alpha = minToggleBoxAlpha;
  optionTwoToggleBox.y = textYStart + textYSpacing * 2;
  optionTwoToggleBox.id = 3

   optionTwoToggleBox.touch = onToggleTouch
optionTwoToggleBox:addEventListener( "touch", optionTwoToggleBox )

   local optionAutoDimText = display.newText(translations["Auto-dim"][language], 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionAutoDimText:setReferencePoint(display.TopLeftReferencePoint);
  optionAutoDimText.alpha = minTextAlpha;
  optionAutoDimText.x = textXStart;
  optionAutoDimText.y = textYStart + textYSpacing * 3;

    local optionThreeToggleBox = display.newRect(890,690,50,50);
  optionThreeToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionThreeToggleBox.alpha = minToggleBoxAlpha;
   optionThreeToggleBox.y = textYStart + textYSpacing * 3;
   optionThreeToggleBox.id = 4
    optionThreeToggleBox.touch = onToggleTouch
optionThreeToggleBox:addEventListener( "touch", optionThreeToggleBox )

local optionExtraThunderText = display.newText(translations["Extra Thunder"][language], 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
optionExtraThunderText:setReferencePoint(display.TopLeftReferencePoint);
optionExtraThunderText.alpha = minTextAlpha;
optionExtraThunderText.x = textXStart;
optionExtraThunderText.y = textYStart + textYSpacing * 4

local optionFourToggleBox = display.newRect(890,710,50,50);
optionFourToggleBox:setReferencePoint(display.TopLeftReferencePoint);
optionFourToggleBox.alpha = minToggleBoxAlpha;
optionFourToggleBox.y = textYStart + textYSpacing * 4;
optionFourToggleBox.id = 5;

optionFourToggleBox.touch = onToggleTouch
optionFourToggleBox:addEventListener( "touch", optionFourToggleBox )

local optionSleepTimerText = display.newText(translations["Sleep Timer"][language], 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
optionSleepTimerText:setReferencePoint(display.TopLeftReferencePoint);
optionSleepTimerText.alpha = minTextAlpha;
optionSleepTimerText.x = textXStart;
optionSleepTimerText.y = textYStart + textYSpacing * 5

local optionFiveToggleBox = display.newRect(890,710,50,50);
optionFiveToggleBox:setReferencePoint(display.TopLeftReferencePoint);
optionFiveToggleBox.alpha = minToggleBoxAlpha;
optionFiveToggleBox.y = textYStart + textYSpacing * 5;
optionFiveToggleBox.id = 6;

optionFiveToggleBox.touch = onToggleTouch
optionFiveToggleBox:addEventListener( "touch", optionFiveToggleBox )

local optionBlackAndWhiteText = display.newText(translations["Monochrome mode"][language], 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
optionBlackAndWhiteText:setReferencePoint(display.TopLeftReferencePoint);
optionBlackAndWhiteText.alpha = minTextAlpha;
optionBlackAndWhiteText.x = textXStart;
optionBlackAndWhiteText.y = textYStart + textYSpacing * 6

local optionSixToggleBox = display.newRect(890,710,50,50);
optionSixToggleBox:setReferencePoint(display.TopLeftReferencePoint);
optionSixToggleBox.alpha = minToggleBoxAlpha;
optionSixToggleBox.y = textYStart + textYSpacing * 6;
optionSixToggleBox.id = 7;

optionSixToggleBox.touch = onToggleTouch
optionSixToggleBox:addEventListener( "touch", optionSixToggleBox )


optionsMenu:insert(muteSoundText)
optionsMenu:insert(muteSoundToggleBox)
optionsMenu:insert(optionClockText)
optionsMenu:insert(optionClockToggleBox)
optionsMenu:insert(optionWanderText)
optionsMenu:insert(optionTwoToggleBox)
optionsMenu:insert(optionAutoDimText)
optionsMenu:insert(optionThreeToggleBox)
optionsMenu:insert(optionExtraThunderText)
optionsMenu:insert(optionFourToggleBox)
optionsMenu:insert(optionFiveToggleBox)
optionsMenu:insert(optionSleepTimerText)
optionsMenu:insert(optionSixToggleBox)
optionsMenu:insert(optionBlackAndWhiteText)
  
  optionsMenu.options = {
  {text = muteSoundText, toggle = "off", toggleBox = muteSoundToggleBox, extended = false, label = "mute"},
  {text = optionClockText, toggle = "off", toggleBox = optionClockToggleBox, extended = false, label = "clock"},
  {text = optionWanderText, toggle = "off", toggleBox = optionTwoToggleBox, extended = true, label = "wander"},
  {text = optionAutoDimText, toggle = "off", toggleBox = optionThreeToggleBox, extended = true, label = "auto-dim"},
  {text = optionExtraThunderText, toggle = "off", toggleBox = optionFourToggleBox, extended = true, label = "extra thunder"},
  {text = optionSleepTimerText, toggle = "off", toggleBox = optionFiveToggleBox, extended = true, label = "sleep timer"},
  {text = optionBlackAndWhiteText, toggle = "off", toggleBox = optionSixToggleBox, extended = true, label = "black and white"},

}
  function optionsMenu:activate()
  	-- googleAnalytics.logEvent( "userAction", "button press", "menu activate" )
    if (extendedPurchased == true) then 
      transition.to(self, {time = 500, alpha = 1.0})
    else 
        transition.to(self, {time = 500, alpha = 1.0})
        -- optionClockText.alpha = 0.2;
        -- muteSoundText.alpha = 0.2;
        optionWanderText.alpha = 0.2;
        optionAutoDimText.alpha = 0.2;
        optionExtraThunderText.alpha = 0.2;
        

      for i=1,#self.options do
        if (self.options[i]["extended"]) then
          self.options[i]["text"].alpha =0.2
        end
      end

    end
      self.activated = true;
  end

  function optionsMenu:activateOptions()
    -- transition.to(self, {time = 500, alpha = 1.0})
    for i=1,#self.options do
        if (self.options[i]["extended"]) then
          self.options[i]["text"].alpha =0.8
        end
      end
      purchaseText.alpha = 0;
      purchaseHotZone.isHitTestable = false;
      restoreText.alpha = 0;
      restoreHotZone.isHitTestable = false;
  end
  function optionsMenu:deactivate()
  	transition.to(self, {time = 500, alpha = 0.0})
    -- googleAnalytics.logEvent( "userAction", "button press", "menu deactivated" )
  	self.activated = false;
  end

  function optionsMenu:selectPrev()
  	self.selection = self.selection - 1;

  	if (self.selection < 1) then
  		self.selection = 1;
  	end

  	print(self.options[self.selection][2])
  	for i=1,#self.options do
  		if (i ~= self.selection) then
  			self.options[i]["text"].alpha = minTextAlpha;
  		end
  	end
  	self.options[self.selection]["text"].alpha = 1.0;
  	
  end

  function optionsMenu:selectNext()
  	self.selection = self.selection + 1;

  	if (self.selection > #self.options) then
  		self.selection = #self.options;
  	end

  	print(self.options[self.selection].toggle)
  	for i=1,#self.options do
  		if (i ~= self.selection) then
  			self.options[i]["text"].alpha = minTextAlpha;
  		end
  	end
  	self.options[self.selection]["text"].alpha = 1.0;
  	
  end

  function optionsMenu:toggleOption()
    if (extendedPurchased == true) then
    print('toggle')
    	if (self.options[self.selection].toggle == "off") then
    		self.options[self.selection].toggle = "on"
        -- googleAnalytics.logEvent( "userAction", "toggle on", self.options[self.selection].label  )
        self.options[self.selection].toggleBox.alpha = 1.0;
     	else
     		self.options[self.selection].toggle = "off"
        -- googleAnalytics.logEvent( "userAction", "toggle off", self.options[self.selection].label  )
         self.options[self.selection].toggleBox.alpha = minToggleBoxAlpha;
     	end
    	
     	print(self.options[self.selection].toggle);
      else
        print("toggle blocked")
      end
  end

 
       
  return optionsMenu
        
end
 
return OptionsMenu
