# FSM with Flutter

## 1. Setup Project:

- Flutter: `v3.29.3`
- Fsm2: `v3.2.1`
- Provider: `v6.1.5`
- Mocktail: `v1.0.4`

**Folder Demo Project**: `/research_fsm_flutter/demo_traffic_light`

**Folder Export Fsm Image**: `/research_fsm_flutter/export_fsm_images`

Refer: Fsm2 library https://pub.dev/packages/fsm2

## 2. Demo:

### 2.1. Traffic Light

Create a traffic light demo with requirements:

```
- A Traffic light has 3 colors: Red, Green, and Yellow.

- The initial state of the Traffic lights is Green.

- The light changes state in order: Green -> Yellow -> Red -> Green and repeat.

- The time to change from Green to Yellow is 5 seconds.

- The time to change from Yellow to Red is 2 seconds.

- The time to change from Red to Green is 7 seconds.

- Display countdown time on UI.

- Let's write code that is more maintainable and flexible, so we can easily change the initial state of the traffic light or the time interval between changing from one color to another
```

<details open> <summary>Demo</summary> 

[<img src="/demo/video_trafic_light.gif" height="600"/>](video_trafic_light.gif)

</details> 

<details close> <summary>Visualize</summary> 

[<img src="/demo/img_traffic_light.jpg" height="600"/>](img_traffic_light.jpg)

</details> 

### 2.2. H20 Life Cycle

Create a H20 Life Cycle and Kettle demo with requirements:

```

- H20 Life Cycle has 3 states: Solid (Ice), Liquid (Water), and Gas (Steam)

- Temperature range of states: Solid (from -1000°C to 0°C), Liquid (from 1°C to 100°C) and Gas (from 101°C to 1000°C)

- The Kettle has a heating and cooling temperature range from -200°C to 300°C.

- The initial state of the H20 Life Cycle is Solid and the initial temperature is 0°C. 

- The H20 Life Cycle has the following changing states to another state:

        Solid → Liquid

        Liquid → Gas

        Liquid → Solid

        Gas → Liquid

- On the screen, there are 2 buttons: "Heat up" and "Freeze". When the user presses the "Heat up" button, the temperature will increase by 30°C per second. When the "Freeze" button is pressed, the temperature will decrease by 20°C per second.

- When the device's heating threshold of 300°C is reached, the "Heat up" button will be disabled. Conversely, when the device's cooling threshold (of -200°C) is reached, the "Freeze" button will be disabled.

- If the "Heat up" button is active, it cannot be pressed again. Only after pressing the "Freeze" button can the user activate the "Heat up" button again. The same logic applies to the "Freeze" button.

- The heating or cooling process will commence, and the corresponding status will change based on the temperature.

- Let's write code that is more maintainable and flexible, so we can easily change the initial state of the H20 Life Cycle or the transition temperature to another state.
```

<details open> <summary>Demo</summary> 

[<img src="/demo/video_h20_lifecycle.gif" height="600"/>](video_h20_lifecycle.gif)

</details>

<details close> <summary>Visualize</summary> 

[<img src="/demo/img_h20_lifecycle.jpg" height="600"/>](img_h20_lifecycle.jpg)

</details> 
