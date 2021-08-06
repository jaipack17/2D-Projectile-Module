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

## `.new` - initializing our weapon

* parameters - rotatingFrame: instance, shooterFrame: instance
* returns - metatable

`.new()` takes two parameters, "rotatingFrame" whos Rotation will be used to define the rotation of the Rays. "shooterFrame" the rays will be parented to this frame. (these will affect the size of the rays and bullets)

```lua
local module = require(path.to.module)
local weapon = module.new(script.Parent.Parent.Bulk, script.Parent.Parent.Bulk)
```

