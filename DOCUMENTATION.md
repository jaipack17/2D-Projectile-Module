# Documentation

## Default Parameters: 

```lua
tweenEasingStyle = Enum.EasingStyle.Linear, -- easing style of the tween
tweenLength = 1, -- time length of the tween
destroy = true, -- destoy after the bullet reaches the end point
rayLength = 5, -- relative to shooterFrame's size
bullet = nil, -- custom bullet instance
bulletSize = UDim2.new(.1, 0, 5, 0), -- size of the bullet
bulletColor = Color3.new(255, 255, 0), -- color of the bullet
rayVisible = false, -- visibility of the formed ray,
callback = nil, -- callback function
```

## `.new()` - initializing our weapon

* parameters - rotatingFrame: instance, shooterFrame: instance
* returns - metatable

`.new()` takes two parameters, "rotatingFrame" whos Rotation will be used to define the rotation of the Rays. "shooterFrame" the rays will be parented to this frame. (these will affect the size of the rays and bullets)

```lua
local module = require(path.to.module)
local weapon = module.new(script.Parent.Parent.Bulk, script.Parent.Parent.Bulk)
```

## `:SetDestroy()` - destroy projectiles when they reach the end point of the rays

* parameters - destroy: boolean
* returns - nil

```lua
weapon:SetDestroy(false) -- does not destroy projectiles when they reach their destination
```

Passing `true` to this function will destrtoy the projectiles after they reach their destination!

## `:SetRayLength()` - set length of the rays formed

* parameters - length: number
* returns - nil

This function sets the length of the rays formed. (relative to the shooterFrame's size, set the ray size accordingly!)

```lua
weapon:SetRayLength(10) 
```

## `:SetTweenLength()` - projectile tween time/length

* parameters - time: number
* returns - nil

This functions sets the time taken by the projectile to move from its start point to the ray's end point

```lua
weapon:SetTweenLength(1) -- length of the tween is set to 1 second
```

## `:SetTweenEasingStyle()` - set the EasingStyle of the projectile's tween

* parameters - EasingStyle: EnumItem 
* returns - nil

```lua
weapon:SetTweenEasingStyle(Enum.EasingStyle.Sine) -- sets the tween's easing style to Sine
```

## `:SetBullet()` - set a custom bullet instance to be the primary projectile

* parameters - guiObject: instance
* returns - nil

This function is used to set custom bullet instances, these will be the projectiles! (this function is only needed for formatting the bullet and such purposes.)

```lua
weapon:SetBullet(guiObject)
```

## `:SetBulletSize()` - set the projectile's size

* parameters - size: UDim2
* returns - nil

This function sets the size of the projectile. **THIS SIZE DEPENDS ON THE SIZE OF THE THIN RAYS THAT ARE FORMED, IT IS ADVISED TO SET ITS SIZE TO ABOUT `UDim2.new(0.1, 0, 6, 0)` OR SO!**

```lua
weapon:SetBulletSize(UDim2.new(0.05, 0, 7, 0))
```

## `:SetBulletColor()` - set the projectile's color

* parameters - color: Color3
* returns - nil

```lua
weapon:SetBulletColor(Color3.new(255,255,0)) -- sets the background color of the projectile to Yellow
```

## `:SetRayVisibility()` - set visibility of the rays that are formed on shot!

* parameters - visible: boolean
* returns - nil

```lua
weapon:SetRayVisibility(true) -- rays that are formed when projectiles are shot will now be visible on your screen!
```
## `:SetCallbackFunction()` - callback functions that are called when the projectile reaches its destination!

* parameters - callback: function
* returns - nil

```lua
weapon:SetCallbackFunction(function()
	print("Bullet has reached the end point!") 
end)
```

## `:Shoot()` -- shoot the projectiles!

* parameters - none
* returns - nil

This function is used to shoot the projectiles along the path of the rays formed!

```lua
game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		weapon:Shoot() -- projectile will be shot when Left Mouse Button is clicked!
	end
end)
```

## `.OnShot` - Event 

The .OnShot event is fired when a projectile is shot using the `:Shoot()` function!

```lua
weapon.OnShot.Event:Connect(function()
	print("Projectile has been shot!")
end)
```

<hr/>
