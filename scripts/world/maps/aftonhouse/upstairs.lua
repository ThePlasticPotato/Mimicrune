return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 36,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 28,
  properties = {
    ["light"] = true
  },
  tilesets = {},
  layers = {
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/rooms/aftonhouse_upstairs.png",
      id = 3,
      name = "aftonhouse_upstairs",
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
      id = 6,
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
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 285.5,
          y = 78,
          width = 680.5,
          height = 179.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "polygon",
          x = 1028,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0.5, y = -240 },
            { x = -62.5, y = -240 },
            { x = -62, y = -63 }
          },
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "polygon",
          x = 1177,
          y = 322,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 78.5, y = 79 },
            { x = 79.5, y = -166.5 },
            { x = 3, y = -242.5 }
          },
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1028,
          y = 78.5,
          width = 44,
          height = 242.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1138.5,
          y = 77.5,
          width = 41,
          height = 244,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1071.5,
          y = 50.5,
          width = 67,
          height = 236.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 556.667,
          y = 242,
          width = 136.333,
          height = 37,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "polygon",
          x = 285.667,
          y = 257,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -143.667, y = 143.333 },
            { x = -143.333, y = -100.333 },
            { x = -67.6667, y = -177 },
            { x = 0.333333, y = -179 }
          },
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 142,
          y = 400,
          width = 1113.33,
          height = 32.6667,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 1,
          name = "couch",
          type = "",
          shape = "rectangle",
          x = 483,
          y = 346,
          width = 282,
          height = 54,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "props/aftonhouse/aftonhouse_upstairs_couch"
          }
        },
        {
          id = 2,
          name = "interactable",
          type = "",
          shape = "point",
          x = 748,
          y = 241.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's abstract art.\n* It's like some king of... portal..."
          }
        },
        {
          id = 3,
          name = "interactable",
          type = "",
          shape = "point",
          x = 507,
          y = 241.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's abstract art.\n* It's like some king of... nortal..."
          }
        },
        {
          id = 10,
          name = "aftonhouse/door",
          type = "",
          shape = "point",
          x = 396.167,
          y = 260.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["lock"] = false,
            ["target_dir"] = "down",
            ["target_map"] = "aftonhouse/evanroom",
            ["target_marker"] = "entry"
          }
        },
        {
          id = 11,
          name = "aftonhouse/door",
          type = "",
          shape = "point",
          x = 852.5,
          y = 263.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["lock"] = true,
            ["lock_text"] = "* Elizabeth's room. It's locked.",
            ["target_dir"] = "down",
            ["target_map"] = "aftonhouse/elizaroom",
            ["target_marker"] = "entry"
          }
        },
        {
          id = 20,
          name = "aftonhouse/door",
          type = "",
          shape = "point",
          x = 264,
          y = 288.833,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["lock"] = true,
            ["lock_text"] = "* The bathroom. It's locked.",
            ["target_dir"] = "left",
            ["target_map"] = "aftonhouse/bathup",
            ["target_marker"] = "entry"
          }
        },
        {
          id = 25,
          name = "aftonhouse/door",
          type = "",
          shape = "point",
          x = 188.833,
          y = 366,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["lock"] = true,
            ["lock_text"] = "* Michael's room. It's locked.",
            ["target_dir"] = "left",
            ["target_map"] = "aftonhouse/mikeroom",
            ["target_marker"] = "entry"
          }
        },
        {
          id = 26,
          name = "aftonhouse/door",
          type = "",
          shape = "point",
          x = 1207.83,
          y = 362.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["lock"] = true,
            ["lock_text"] = "* Mom and Dad's room. It's locked.",
            ["target_dir"] = "right",
            ["target_map"] = "aftonhouse/masterroom",
            ["target_marker"] = "entry"
          }
        },
        {
          id = 27,
          name = "interactable",
          type = "",
          shape = "point",
          x = 984.33,
          y = 291.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's a painting of a purple guy."
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
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
          id = 12,
          name = "entry_evanroom",
          type = "",
          shape = "point",
          x = 395.667,
          y = 281.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "entry_elizaroom",
          type = "",
          shape = "point",
          x = 851.333,
          y = 280.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "entry_bathroom",
          type = "",
          shape = "point",
          x = 286.333,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "entry_mikeroom",
          type = "",
          shape = "point",
          x = 214,
          y = 370,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "entry_masterroom",
          type = "",
          shape = "point",
          x = 1189.33,
          y = 364.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "entry_stairs",
          type = "",
          shape = "point",
          x = 1114,
          y = 339.667,
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
