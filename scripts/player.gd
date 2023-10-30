extends Node3D

@export var maxSpeed = 50
@export var maxPitchSpeed = 3
@export var pitchAcceleration = 3
@export var maxYawSpeed = 3
@export var yawAcceleration = 3
@export var maxRollSpeed = 3
@export var rollAcceleration = 3



# velocity 
var speed=0
var pitchV=0
var yawV=0
var rollV=0

# input tracking
var pitch_up=0
var pitch_down=0
var yaw_left=0
var yaw_right=0
var roll_left=0
var roll_right=0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	pitchV+=pitchAcceleration*delta * (pitch_up-pitch_down)
	pitchV=clamp(pitchV,-maxPitchSpeed,maxPitchSpeed)
	
	yawV+=yawAcceleration*delta * (yaw_left-yaw_right)
	yawV=clamp(yawV,-maxYawSpeed,maxYawSpeed)
	
	rollV+=rollAcceleration*delta * (roll_right-roll_left)
	rollV=clamp(rollV,-maxRollSpeed,maxRollSpeed)
	
	# drag
	pitchV*=.99-delta
	yawV*=.99-delta
	rollV*=.99-delta
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# move forward
	position+=global_transform.basis.z * speed*delta
	
	# pitch
	rotate_object_local(Vector3(1, 0, 0), pitchV*delta)

	# yaw
	rotate_object_local(Vector3(0, 1, 0),yawV*delta)
	
	# roll
	rotate_object_local(Vector3(0, 0, 1),rollV*delta)


func _input(event):
	# throttle
	if event.is_action_pressed("throttle_up"):
		speed+=1
		speed=clampf(speed,0,maxSpeed)
	if event.is_action_pressed("throttle_down"):
		speed-=1
		speed=clampf(speed,0,maxSpeed)
		
	# pitch
	if event.is_action_pressed("pitch_up"):
		pitch_up=1
	if event.is_action_released("pitch_up"):
		pitch_up=0
	if event.is_action_pressed("pitch_down"):
		pitch_down=1
	if event.is_action_released("pitch_down"):
		pitch_down=0
		
	# yaw
	if event.is_action_pressed("yaw_left"):
		yaw_left=1
	if event.is_action_released("yaw_left"):
		yaw_left=0
	if event.is_action_pressed("yaw_right"):
		yaw_right=1
	if event.is_action_released("yaw_right"):
		yaw_right=0
		
	# roll
	if event.is_action_pressed("roll_left"):
		roll_left=1
	if event.is_action_released("roll_left"):
		roll_left=0
	if event.is_action_pressed("roll_right"):
		roll_right=1
	if event.is_action_released("roll_right"):
		roll_right=0
	
	
		
