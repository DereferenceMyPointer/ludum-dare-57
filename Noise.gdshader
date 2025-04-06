shader_type canvas_item;

uniform float x_offset;
uniform sampler2D noise: repeat_enable;
uniform sampler2D noise2: repeat_enable;
uniform vec3 color : source_color;
uniform float intensity;
uniform float intensity2;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	//noise.x = TIME;
	vec4 textureColor = texture(noise, UV + vec2(0.1 * TIME, 0.1)) * intensity;
	vec4 textureColor2 = texture(noise2, UV + vec2(-0.01 * TIME, 0.1)) * intensity2;
	vec3 baseColor = texture(TEXTURE, UV).rgb;
	COLOR.rgb = baseColor;
	COLOR.a = textureColor.r + textureColor2.r;
}
