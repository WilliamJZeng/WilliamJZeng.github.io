---
title: "Random Walk Visualizer"
excerpt: "Interactive visualization of random walks with adjustable parameters"
collection: personal_projects
---

## Random Walk Visualizer

An interactive tool to visualize one-dimensional and two-dimensional random walks with customizable parameters.

<style>
  .controls {
    margin: 20px 0;
    padding: 15px;
    background-color: #2a2a2a;
    border: 1px solid #444;
    border-radius: 8px;
    color: #e0e0e0;
  }

  .control-group {
    margin: 10px 0;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .control-group label {
    min-width: 150px;
    font-weight: 500;
    color: #e0e0e0;
  }

  .control-group select {
    padding: 5px 10px;
    background-color: #3a3a3a;
    color: #e0e0e0;
    border: 1px solid #555;
    border-radius: 4px;
  }

  .control-group input[type="range"] {
    flex: 1;
    max-width: 300px;
  }

  .control-group input[type="number"] {
    width: 80px;
    padding: 5px;
    background-color: #3a3a3a;
    color: #e0e0e0;
    border: 1px solid #555;
    border-radius: 4px;
  }

  .button-group {
    margin: 15px 0;
    display: flex;
    gap: 10px;
  }

  button {
    padding: 10px 20px;
    font-size: 14px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    background-color: #4a90e2;
    color: white;
    transition: background-color 0.2s;
  }

  button:hover {
    background-color: #357abd;
  }

  button:disabled {
    background-color: #555;
    color: #999;
    cursor: not-allowed;
  }

  #canvas {
    border: 1px solid #555;
    background-color: #1a1a1a;
    border-radius: 5px;
    display: block;
    margin: 20px auto;
  }

  .stats {
    margin: 20px 0;
    padding: 15px;
    background-color: #2a2a2a;
    border: 1px solid #444;
    border-radius: 8px;
    font-family: monospace;
    color: #e0e0e0;
  }
</style>

<div class="controls">
  <div class="control-group">
    <label for="dimension">Dimension:</label>
    <select id="dimension">
      <option value="1">1D</option>
      <option value="2" selected>2D</option>
    </select>
  </div>

  <div class="control-group">
    <label for="numWalks">Number of Walks:</label>
    <input type="range" id="numWalks" min="1" max="20" value="5">
    <input type="number" id="numWalksValue" min="1" max="20" value="5" readonly>
  </div>

  <div class="control-group">
    <label for="stepSize">Step Size:</label>
    <input type="range" id="stepSize" min="1" max="20" value="10">
    <input type="number" id="stepSizeValue" min="1" max="20" value="10" readonly>
  </div>

  <div class="control-group">
    <label for="speed">Animation Speed:</label>
    <input type="range" id="speed" min="1" max="100" value="75">
    <input type="number" id="speedValue" min="1" max="100" value="75" readonly>
  </div>

  <div class="control-group">
    <label for="maxSteps">Max Steps:</label>
    <input type="range" id="maxSteps" min="10" max="1000" step="10" value="200">
    <input type="number" id="maxStepsValue" min="10" max="1000" step="10" value="200" readonly>
  </div>

  <div class="button-group">
    <button id="startBtn">Start</button>
    <button id="pauseBtn" disabled>Pause</button>
    <button id="resetBtn">Reset</button>
  </div>
</div>

<canvas id="canvas" width="1000" height="800"></canvas>

<div class="stats">
  <div id="stats">Steps: 0 | Status: Ready</div>
</div>

<script src="{{ '/assets/js/random-walk.js' | relative_url }}"></script>

### About Random Walks
A random walk is a mathematical process that describes a path consisting of a succession of random steps.

#### 1D Random Walk
In a one-dimensional random walk, each step moves either left or right along a line with equal probability.

#### 2D Random Walk
In a two-dimensional random walk, each step moves in a random direction in the plane. The direction is uniformly distributed over all angles.

### Features

- **Adjustable Parameters**: Control the number of simultaneous walks, step size, animation speed, and maximum steps
- **Multiple Dimensions**: Switch between 1D and 2D random walks
- **Visual Grid**: Reference grid to help track displacement from the starting point
- **Color Coding**: Each walk has a unique color for easy identification
- **Interactive Controls**: Start, pause, and reset the simulation at any time
