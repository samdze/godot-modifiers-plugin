![Plugin screenshot](https://i.imgur.com/NtjyHaA.gif)
# Modifiers Plugin

Node that allows the creation of multiple chained modifiers for any node property.

# Installation
- Clone this repository in your addons folder.
- Navigate to Project -> Project Settings -> Plugin and enable the Modifiers plugin.

# Features
- Define any number of property modifiers.
- Every node property and type is supported.
- Chain multiple modifiers to the same property statically or dynamically.
- Change the way two values are combined in the chain thanks to mix modes.
- Add/remove and activate/deactivate modifiers at any time.
- Modifiers (value, mix mode and active state) keyable in the AnimationPlayer node.
- Define custom mix modes for your project.
- Custom editors and inspectors to ease the use of the plugin.

# Usage examples

The examples below are possible even without this plugin, but the Modifiers node allows a flexible, modular and decoupled implementation.

- Set the scale of a node combining several independent vectors:
  - Enlarge 2x your character for a limited amount of time if a power up is picked up.
    More than one of the same power up can be stacked, resulting in 4x, 8x ecc enlargement.
- Set an int or a float value combining several independent values:
  - Increase or decrease your character's jump power or speed based on what terrain he is walking on.
- Set a resource override to a node only when needed:
  - Override the CollisionShape of your character only when he is attacking.

# How to use
Once the plugin has been enabled:


### Modifiers
- Add the Modifiers node to your scene.
- Select a target node in the Modifiers node inspector.
  This node will receive the influence of the modifiers you define.
- Define which property to influence selecting "Add Property" in the inspector.
  A new window will popup showing all the target node's available properties.
- Add a modifier to a property selecting "Add Modifier" at the bottom of each property section.
  A new window will popup asking you to define a name for the modifier.
- Add as much modifiers as you want.
- Reorder modifiers selecting the arrows, change mix mode, or activate/deactivate them.
  Each modifier takes the result of the upper modifiers and combines its value based on its mix mode.
- Key modifiers values, mix modes and active states in AnimationPlayer nodes just like any other property.
 
- Access the modifiers in code using:

  ```
  ModifiersNode.get("<property_name>/<modifier_name>/value")
  ModifiersNode.get("<property_name>/<modifier_name>/mix_mode")
  ModifiersNode.get("<property_name>/<modifier_name>/active")
  
  ModifiersNode.set("<property_name>/<modifier_name>/value", value)
  ModifiersNode.set("<property_name>/<modifier_name>/mix_mode", mix_mode)
  ModifiersNode.set("<property_name>/<modifier_name>/active", active)
  ```
  
  or
  
  ```
  ModifiersNode["<property_name>/<modifier_name>/value"]
  ModifiersNode["<property_name>/<modifier_name>/mix_mode"]
  ModifiersNode["<property_name>/<modifier_name>/active"]
  ```
- Create, remove and move modifiers in code using:

  ```
  # Adds a property group.
  add_property(String property_name)
  
  # Adds a property group and a modifier. <mix_mode> (Resource) and <position> are optional.
  add_modifier(String property_name, String modifier_name, Variant value, MixMode mix_mode = default_mix_mode, int position = -1)
  
  # Removes a property and all its modifiers.
  remove_property(String property_name)
  
  # Removes a specific property modifier.
  remove_modifier(String property_name, String modifier_name)
  
  # Moves the indicated modifier <shift> positions in its modifiers list. 
  move_modifier(String property_name, String modifier_name, int shift)
  
  # Moves the indicated modifiers in position <position> in its modifiers list.
  move_modifier_to(String property_name, String modifier_name, int position)
  ```
- Miscellaneous
  ```
  # Returns the <modifier_name> position in its list of modifiers.
  get_modifier_position(String property_name, String modifier_name)
  
  # Returns the amount of modifiers assigned to <property_name>
  get_modifiers_amount(String property_name)
  
  # Returns the list of defined properties.
  get_properties()
  
  # Returns the list of defined modifier names assigned to <property_name>
  get_modifier_names(property_name)
  ```

### Mix Modes
Mix modes are simple Resources.

To define a custom mix mode:
- Create a new MixMode resource.
- Fill the Name (and Object Class if it's a mix mode intended to be used with resources)
- Fill the Expression needed to calculate the resulting value.
  The inputs are two variables, **a** and **b**.
  Valid expression are:
  
  `a + b`
  
  or
  
  `Vector2(a.x * b.x, a.y * b.y)`
- Add your new MixMode resource to one or more lists of the default_mix_modes resource you can find in the plugin folder.
- Your new mix mode will now be displayed in the modifiers inspector's dropdown button together with the default ones.
