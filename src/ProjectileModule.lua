-- services

local ts = game:GetService("TweenService")

-- helper functions

local function OffsetToScale(offsets)
	local ViewPortSize = workspace.Camera.ViewportSize
	return UDim2.new(offsets[1] / ViewPortSize.X, 0, offsets[2] / ViewPortSize.Y, 0)
end

local function debugPos(dab, fab, cur)
	if dab.Y ~= fab.Y  then		
		return OffsetToScale({ dab.X, dab.Y }).Y.Scale - OffsetToScale({ fab.X, fab.Y }).Y.Scale
	end
end

local function createDirFrame(Bulk, rayLength)
	local DirectionFrame = Instance.new("Frame")
	DirectionFrame.Name = "DirectionFrame"
	DirectionFrame.Position = UDim2.new(1,0,.5,0)
	DirectionFrame.Size = UDim2.new(Bulk.Size.X.Scale + rayLength, 0, Bulk.Size.Y.Scale/2, 0)
	DirectionFrame.Parent = Bulk
	DirectionFrame.BorderSizePixel = 0
	DirectionFrame.ZIndex = 0
	DirectionFrame.BackgroundColor3 = Color3.new(255, 0, 0)
	DirectionFrame.BackgroundTransparency = 1

	return DirectionFrame
end

local function getPosNSize(dir)
	return OffsetToScale({ dir.AbsolutePosition.X, dir.AbsolutePosition.Y }), OffsetToScale({ dir.AbsoluteSize.X, dir.AbsoluteSize.Y })
end

-- module

local ProjectileModule = {}
ProjectileModule.__index = ProjectileModule

-- init

function ProjectileModule.new(rotationFrame, shooterFrame)	
	local onshot = Instance.new("BindableEvent")
	onshot.Name = "OnShot"
	onshot.Parent = shooterFrame
	
	local self = setmetatable({
		_rotation = rotationFrame, -- ray created according to the rotation of this frame
		_shooter = shooterFrame, -- ray created inside this frame
		_config = {
			_tweenEasingStyle = Enum.EasingStyle.Linear,
			_tweenLength = 1,
			_destroy = true, -- destoy after the bullet reaches the end point
			_rayLength = 5, -- relative to shooterFrame's size
			_bullet = nil, -- custom bullet instance
			_bulletSize = UDim2.new(.1, 0, 5, 0), -- size of the bullet
			_bulletColor = Color3.new(255, 255, 0), -- color of the bullet
			_rayVisible = false, -- visibility of the formed ray,
			_callback = nil, -- callback function
		},
		OnShot = onshot -- bindable event
	}, ProjectileModule)
	
	return self
end

-- configs

function ProjectileModule:SetDestroy(bool)
	assert(typeof(bool) == "boolean", "argument must be a boolean")
	self._config._destroy = bool
end

function ProjectileModule:SetRayLength(num)
	assert(typeof(num) == "number", "argument must be a number")
	self._config._rayLength = num
end

function ProjectileModule:SetTweenLength(num)
	assert(typeof(num) == "number", "argument must be a number")
	self._config._tweenLength = num
end

function ProjectileModule:SetTweenEasingStyle(enum)
	assert(typeof(enum) == "EnumItem", "argument must be an enumitem")
	if tostring(enum.EnumType) == "EasingStyle" then
		self._config._tweenEasingStyle = enum
	end
end

function ProjectileModule:SetBullet(element)
	local instances = {"Frame", "TextLabel", "ScrollingFrame", "ImageLabel", "TextButton", "TextBox", "TextButton", "ImageButton"}
	assert(table.find(instances, element.ClassName), "argument must be a gui instance")
	self._config._bullet = element
end

function ProjectileModule:SetBulletSize(element)
	assert(typeof(element) == "UDim2", "argument must be a UDim2 value")
	self._config._bulletSize = element
end

function ProjectileModule:SetBulletColor(element)
	assert(typeof(element) == "Color3", "argument must be a Color3 value")
	self._config._bulletColor = element
end


function ProjectileModule:SetRayVisibility(bool)
	assert(typeof(bool) == "boolean", "argument must be a boolean")
	self._config._rayVisible = bool
end

function ProjectileModule:SetCallbackFunction(f)
	assert(typeof(f) == "function", "argument must be a function")
	self._config._callback = f
end

-- mechanics

function ProjectileModule:Shoot()
	local DirectionFrame = createDirFrame(self._rotation, self._config._rayLength)
	local position, size = getPosNSize(DirectionFrame)		
	
	-- ray creation
		
	local ray = DirectionFrame:Clone()
	ray.Name = "Ray"
	ray.Position = position
	ray.BorderSizePixel = 0
	ray.Size = size
	ray.Rotation = self._rotation.Rotation
	ray.Parent = self._rotation.Parent
	if self._config._rayVisible then ray.BackgroundTransparency = 0 else ray.BackgroundTransparency = 1 end
	
	-- debugging ray position

	local dif = debugPos(DirectionFrame.AbsolutePosition, ray.AbsolutePosition, ray.Rotation)				
	ray.Position = UDim2.new(position.X.Scale, 0, position.Y.Scale + dif, 0)
	
	-- bullet creation
	
	local bullet = self._config._bullet and self._config._bullet:Clone() or Instance.new("Frame")
	bullet.Name = "Projectile"
	if not self._config._bullet then
		bullet.BackgroundColor3 = self._config._bulletColor
		bullet.BorderSizePixel = 0
	end
	bullet.AnchorPoint = Vector2.new(.5,.5)
	bullet.Position = UDim2.new(0, 0, ray.Position.Y.Scale, 0)
	bullet.Parent = ray
	bullet.Size = self._config._bulletSize

	-- tweening

	local info = TweenInfo.new(self._config._tweenLength, self._config._tweenEasingStyle, Enum.EasingDirection.Out)
	local shoot = ts:Create(bullet, info, { Position = UDim2.new(1, 0, ray.Position.Y.Scale, 0) })
	shoot:Play()
	self._rotation.OnShot:Fire(bullet)
	shoot.Completed:Wait()
	if self._config._callback then self._config._callback() end
	if self._config._destroy then ray:Remove() end
end

return ProjectileModule
