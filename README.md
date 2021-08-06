<div align="center">
   <img src="https://user-images.githubusercontent.com/74130881/128533807-a1229169-eae5-4062-9c70-154c2d18330d.png" width=200px>
   <h1>2D Projectile Module</h1>
   <a href="https://github.com/jaipack17/2D-Projectile-Module/blob/main/DOCUMENTATION.md">Documentation</a> |
   <a href="https://github.com/jaipack17/2D-Projectile-Module">Source Code</a> | <a href="https://www.roblox.com/library/7212819236/ProjectileModule">Module</a> | <a href="https://www.roblox.com/games/7213035665/2D-Projectiles">Playground</a>
</div>

<hr/>

# About

Using this module, you can create dynamic projectiles for your 2 dimensional GUI-Based Roblox games! No matter what the rotation of the weapon is, you are able to shoot projectiles in the direction the weapon is facing to! This module is really helpful for people trying to make 2 Dimensional games on Roblox!

### [Module](https://www.roblox.com/library/7212819236/ProjectileModule)

https://user-images.githubusercontent.com/74130881/128536235-76583f01-62c1-4a02-9da1-64dd10841b20.mp4

# How does it work?

Whenever a user interacts with their device (Custom Interactions can be scripted), a thin frame (ray) is created in the front face of a given Gui Object according to its rotation and relative to the Gui Object's size. A Projectile (bullet) is then created inside of that ray (relative to the ray's size) and is then tweened along the path of the ray, which you observe as moving projectiles on you screen!

https://user-images.githubusercontent.com/74130881/128538060-980d25d2-008f-4607-b4a7-acf7947dd0f5.mp4

# Examples:

**Our Weapon:**

![image](https://user-images.githubusercontent.com/74130881/128538289-f754d224-3e76-4600-9901-cfc55ce418d0.png)
![image](https://user-images.githubusercontent.com/74130881/128538351-a940d1cb-6dc9-4a7b-8c4f-a32ddd1e5ea9.png)

"Bulk" will be the frame that will be rotated.

![image](https://user-images.githubusercontent.com/74130881/128538526-fa4127e2-119f-416c-a383-8867a79805ab.png)

"Weapon Controller" will be the script we'll be coding in! The code below utilizes all the functions and events of the module!

```lua
local module = require(path.to.module)
local weapon = module.new(script.Parent.Parent.Bulk, script.Parent.Parent.Bulk) -- initializing our weapon. the first argument is the frame that will be rotating, the second argument is the frame, in which the ray will emerge from.

weapon:SetDestroy(true) -- destroy after the projectile has reached the end point? yes
weapon:SetRayLength(5) -- the length of the ray thats formed (relative to the frame it is parented to)
weapon:SetBulletSize(UDim2.new(0.05, 0, 10, 0)) -- set projectile size (relative to the ray's size)
weapon:SetBulletColor(Color3.new(255,255,0)) -- set the color of the bullet
weapon:SetRayVisibility(false) -- should the ray be visible when we shoot the projectile? no
weapon:SetTweenEasingStyle(Enum.EasingStyle.Linear) -- tween easing style
weapon:SetTweenLength(1) -- tween length
-- weapon:SetBullet(customBulletInstance) || used to create custom projectiles, lets say, an imagelabel, (size of the bullet will be affected by :SetBulletSize())
weapon:SetCallbackFunction(function() -- callback function (called when the projectile reaches the end point of the ray)
	print("Bullet has reached the end point!")
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		weapon:Shoot() -- shoot the projectile!
	end
end)

weapon.OnShot.Event:Connect(function() -- OnShot event, fired when the projectile is shot!
	print("OnShot event fired!")
end)
```

To rotate the Weapon, lets try out the following code, this will make the weapon follow the direction of the mouse! (debugging purposes)

In the same script:

```lua
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local WeaponFrame = script.Parent.Parent.Bulk

game:GetService("RunService").Stepped:Connect(function()
	local frameCenter = WeaponFrame.AbsolutePosition + (WeaponFrame.AbsoluteSize/2)
	local x = math.atan2(mouse.Y - frameCenter.Y, mouse.X - frameCenter.X)
	WeaponFrame.Rotation = math.deg(x) + 90
end)
```

**Result:**

https://user-images.githubusercontent.com/74130881/128536235-76583f01-62c1-4a02-9da1-64dd10841b20.mp4


<hr/>

✌️
