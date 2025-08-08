return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 15,
  properties = {
    ["has_tile_sounds"] = true,
    ["inside"] = true,
    ["light"] = true,
    ["step_sound"] = ""
  },
  tilesets = {
    {
      name = "debug",
      firstgid = 1,
      filename = "../../tilesets/debug.tsx",
      exportfilename = "../../tilesets/debug.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 1,
      name = "stepsounds",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 11, 0, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0,
        0, 11, 0, 0, 11, 11, 16, 11, 11, 11, 11, 11, 11, 11, 0, 0,
        0, 11, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0,
        0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0,
        0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/rooms/aftonhouse_upstairs_bathroom.png",
      id = 2,
      name = "aftonhouse_upstairs_bathroom",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 89.5,
          y = 341.5,
          width = 445.5,
          height = 38.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "polygon",
          x = 95,
          y = 341,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 46.5, y = -49 },
            { x = 144.5, y = -49 },
            { x = 153, y = -78.5 },
            { x = 153, y = -222.5 },
            { x = -4, y = -221.5 },
            { x = -4.5, y = -2 }
          },
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 248,
          y = 104,
          width = 205,
          height = 158,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "polygon",
          x = 453.333,
          y = 261,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 81.6667, y = 81.6667 },
            { x = 81, y = -141 },
            { x = -0.666667, y = -141.333 }
          },
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 535,
          y = 115.333,
          width = 58.6667,
          height = 264.333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72.6667,
          y = 117,
          width = 17,
          height = 263,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "polygon",
          x = 294.667,
          y = 225.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 44 },
            { x = 11.3333, y = 53.6667 },
            { x = 94.3333, y = 53.6667 },
            { x = 98.6667, y = 47 },
            { x = 98.6667, y = -10 }
          },
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "ellipse",
          x = 408,
          y = 239.667,
          width = 41.3333,
          height = 30.3333,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 11,
          name = "aftonhouse/door",
          type = "",
          shape = "point",
          x = 479.333,
          y = 298.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["lock"] = false,
            ["target_dir"] = "right",
            ["target_map"] = "aftonhouse/upstairs",
            ["target_marker"] = "entry_bathroom"
          }
        },
        {
          id = 12,
          name = "aftonhouse/toilet",
          type = "",
          shape = "point",
          x = 431.667,
          y = 270.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "interactable",
          type = "",
          shape = "point",
          x = 362,
          y = 268.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* But your hands were already clean."
          }
        },
        {
          id = 14,
          name = "interactable",
          type = "",
          shape = "point",
          x = 130.333,
          y = 309.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's raining out there."
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 10,
          name = "entry",
          type = "",
          shape = "point",
          x = 448.333,
          y = 303.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
