#= require Shaderling

Shaderling.Utils = {
  generateUUID: (length) ->
    text = "";
    possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for i in [0...length]
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;

  shortTypeName: (type) ->
    switch type.type
      when 'int' then 'i'
      when 'float' then 'f'
      when 'vec2' then 'v2'
      when 'vec3' then 'v3'
      when 'vec4' then 'v4'
      when 'mat4' then 'm4'
}

