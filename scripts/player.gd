extends Node3D

@export var maxSpeed = 50
@export var pitchSpeed = 3
@export var yawSpeed = 3
@export var rollSpeed = 3


var speed=0
var pitch_up=0
var pitch_down=0
var yaw_left=0
var yaw_right=0
var roll_left=0
var roll_right=0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# move forward
	position+=global_transform.basis.z * speed*delta
	
	# pitch
	rotate_object_local(Vector3(1, 0, 0), pitchSpeed*delta * (pitch_up-pitch_down))

	# yaw
	rotate_object_local(Vector3(0, 1, 0),yawSpeed*delta * (yaw_left-yaw_right))
	
	# roll
	rotate_object_local(Vector3(0, 0, 1),rollSpeed*delta * (roll_right-roll_left))


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
	
	
		
