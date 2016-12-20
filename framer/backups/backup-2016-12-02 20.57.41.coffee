###
Layer filter effect

@auther threeword (dev@threeword.com)
@since 2016.07.08
###

# Constant
DEFINED = 
	COLORS: { DEFAULT: "rgba(85,85,85,1.0)", ACCENT: "rgba(51,176,247,1.0)" }
	STATES: { SHOW: "show", DISMISS: "dismiss", DEFAULT: "default"}
	FONT: Utils.deviceFont()
	
# See the filter value as possible in the Layers
filtersRefer = new Layer visible: false
# Filters
Filters =
	Brightness: { default: filtersRefer.brightness, min:0 ,max: 1000 }
	, Saturate: { default: filtersRefer.saturate, min:0 ,max: 100 }
	, HueRotate: { default: filtersRefer.hueRotate, min:0 ,max: 360 }
	, Contrast: { default: filtersRefer.contrast, min:0 ,max: 100 }
	, Invert: { default: filtersRefer.invert, min:0 ,max: 100 }
	, Grayscale: { default: filtersRefer.grayscale, min:0 ,max: 100 }
	, Sepia: { default: filtersRefer.sepia, min:0 ,max: 100 }
	
# Background
new BackgroundLayer	color: 'white'

# Flexable body
canvasWidth = 750; canvasHeight = 1334; ratio= Screen.width / canvasWidth
ratioWidth = canvasWidth; ratioHeight = canvasHeight - (Math.abs((canvasHeight * ratio) - Screen.height))/ratio
body = new Layer width: ratioWidth, height: ratioHeight, scale: ratio, originX: 0, originY: 0, backgroundColor: ''

# Image Area box
box = new Layer name: 'box', parent: body
	, x: Align.center
	, width: body.width, height: body.height-700
	
# Image
image = new Layer name: 'image', parent: box
	, x: Align.center, y: Align.center
	, width: 192, height: 192
	, image: "images/complication-ring-image.png"
	, backgroundColor: '', color: 'white'
		
# Button : Set default value
defaultBtn = new Layer name: 'defaultBtn', parent: body
	, x: Align.left(20), y: Align.top(20)
	, width: 200, height: 80
	, borderRadius: 20
	, backgroundColor: DEFINED.COLORS.ACCENT
	, html: "Set default", style: { color:"#fff", textAlign:"center", font: "bolder 30px/80px #{DEFINED.FONT}", letterSpacing:"-1px"}
defaultBtn.onClick -> slider.animateToValue Filters[slider.name.split("_")[1]].default, curve: "spring(500,50,0)" for slider in sliders

# Bubble : Animation : End
bubbleAnimationEnd = (animation, layer) -> layer.animate properties: { rotation: 0 }, curve: "spring(100,10,10)"
		
count = 0; sliders = []
for key, value of Filters
	labelNslider = new Layer name: 'labelNslider', parent: body
		, y: Align.bottom(100 * (count++) - (100 * 6))
		, width: body.width, height: 100
		, backgroundColor: ''
		
	# Label
	new Layer name: "label_#{key}", parent: labelNslider
		, x: Align.right(-540), y: Align.center
		, width: 210, height: 50
		, backgroundColor: ''
		, html: "#{key}", style: { color: DEFINED.COLORS.DEFAULT, textAlign:"right", font: "500 32px/50px #{DEFINED.FONT}", letterSpacing:"-1px"}
		
	# Slider
	slider = new SliderComponent name: "slider_#{key}", parent: labelNslider
		, x: Align.right(-50), y: Align.center
		, width: 430, height: 6
		, knobSize: 60
		, backgroundColor: "rgba(0,0,0,0.1)"
		, min: value.min, max: value.max, value: 0
	sliders.push(slider)
	slider.animateToValue value.default, curve: "spring(500,50,0)"
	
	# Slider : Knob
	slider.knob.props = 
		scale: .8, borderRadius: "100%"
		, borderColor: DEFINED.COLORS.DEFAULT
		, borderWidth: 5
		, boxShadow: "0 2px 0 rgba(0,0,0,0.1), 0 2px 5px rgba(0,0,0,0.3)"
		, backgroundColor: 'white'
	slider.knob.draggable.momentum = false
	
	# Slider : Fill
	slider.fill.props = { backgroundColor: DEFINED.COLORS.DEFAULT }
	slider.fill.states.add "#{DEFINED.STATES.SHOW}": { backgroundColor: DEFINED.COLORS.ACCENT }, "#{DEFINED.STATES.DISMISS}": { backgroundColor: DEFINED.COLORS.DEFAULT }
		
	# Value bubble
	bubble = new Layer name: 'bubble'
		, x: Align.center, maxY: slider.knob.y + 25
		, width: 100, height: 120
		, parent: slider.knob
		, image: "images/bubble.png"
		, scale: 0, originX:.5, originY: 1
		, style: { color: "#fff", textAlign: "center", font: "bold 38px/100px #{DEFINED.FONT}", letterSpacing:"-2px"}
		, rotation: 0
		
	# Value bubble : States
	bubble.states.add "#{DEFINED.STATES.SHOW}": { scale: 1 }, "#{DEFINED.STATES.DISMISS}": { scale: 0 }
	
	# Slider : Event : Drag knob
	slider.knob.onDragStart -> 
		this.animate properties: { scale: 1, borderColor: DEFINED.COLORS.ACCENT, borderWidth: 8 }, curve: "spring(400,30,0)"
		this.children[0].states.switch DEFINED.STATES.SHOW, curve: "spring(100,10,10)"
		this.parent.fill.states.switchInstant DEFINED.STATES.SHOW
		this.parent.parent.children[0].color = DEFINED.COLORS.ACCENT
	slider.knob.onMove ->
		this.children[0].animate properties: { rotation: Utils.modulate(this.draggable.velocity.x, [-2.0, 2.0], [60, -60], true) }
			, curve: "ease", time: .1
		this.children[0].off Events.AnimationEnd, bubbleAnimationEnd
		this.children[0].on Events.AnimationEnd, bubbleAnimationEnd
	slider.knob.onDragEnd -> 
		this.animate properties: { scale: .8, borderColor: DEFINED.COLORS.DEFAULT, borderWidth: 5}, curve: "spring(400,30,0)"
		this.children[0].states.switch DEFINED.STATES.DISMISS, curve: "spring(500,50,0)"
		this.parent.fill.states.switchInstant DEFINED.STATES.DISMISS
		this.parent.parent.children[0].color = DEFINED.COLORS.DEFAULT
		
	# Silder : Event : Change value
	slider.onValueChange -> 
		filter = this.name.split("_")[1].toLowerCase()
		image[filter] = this.value
		this.knob.children[0].html = parseInt(this.value)