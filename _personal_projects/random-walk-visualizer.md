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

<script>
  const canvas = document.getElementById('canvas');
  const ctx = canvas.getContext('2d');

  // Controls
  const dimensionSelect = document.getElementById('dimension');
  const numWalksSlider = document.getElementById('numWalks');
  const numWalksValue = document.getElementById('numWalksValue');
  const stepSizeSlider = document.getElementById('stepSize');
  const stepSizeValue = document.getElementById('stepSizeValue');
  const speedSlider = document.getElementById('speed');
  const speedValue = document.getElementById('speedValue');
  const maxStepsSlider = document.getElementById('maxSteps');
  const maxStepsValue = document.getElementById('maxStepsValue');
  const startBtn = document.getElementById('startBtn');
  const pauseBtn = document.getElementById('pauseBtn');
  const resetBtn = document.getElementById('resetBtn');
  const statsDiv = document.getElementById('stats');

  let walks = [];
  let isRunning = false;
  let animationId = null;
  let currentStep = 0;
  let dimension = 2;

  // Color palette for different walks (bright colors for dark mode)
  const colors = [
    '#ff6b6b', '#4dabf7', '#51cf66', '#ffd43b', '#b197fc',
    '#22b8cf', '#ff8c42', '#ff6b9d', '#91a7ff', '#ffa94d',
    '#fd79a8', '#74b9ff', '#55efc4', '#fdcb6e', '#a29bfe',
    '#00cec9', '#ff7675', '#fd79a8', '#6c5ce7', '#fab1a0'
  ];

  // Sync sliders with number inputs
  numWalksSlider.addEventListener('input', (e) => {
    numWalksValue.value = e.target.value;
  });

  stepSizeSlider.addEventListener('input', (e) => {
    stepSizeValue.value = e.target.value;
  });

  speedSlider.addEventListener('input', (e) => {
    speedValue.value = e.target.value;
  });

  maxStepsSlider.addEventListener('input', (e) => {
    maxStepsValue.value = e.target.value;
  });

  dimensionSelect.addEventListener('change', () => {
    dimension = parseInt(dimensionSelect.value);
    reset();
  });

  class RandomWalk {
    constructor(color, stepSize, dimension) {
      this.color = color;
      this.stepSize = stepSize;
      this.dimension = dimension;
      this.path = [];

      if (dimension === 1) {
        this.path.push({ x: canvas.width / 2, y: canvas.height / 2 });
      } else {
        this.path.push({ x: canvas.width / 2, y: canvas.height / 2 });
      }
    }

    step() {
      const lastPoint = this.path[this.path.length - 1];
      let newPoint;

      if (this.dimension === 1) {
        // 1D random walk (left or right along horizontal axis)
        const direction = Math.random() < 0.5 ? -1 : 1;
        newPoint = {
          x: lastPoint.x + direction * this.stepSize,
          y: lastPoint.y
        };
      } else {
        // 2D random walk
        const angle = Math.random() * 2 * Math.PI;
        newPoint = {
          x: lastPoint.x + Math.cos(angle) * this.stepSize,
          y: lastPoint.y + Math.sin(angle) * this.stepSize
        };
      }

      this.path.push(newPoint);
    }

    draw() {
      if (this.path.length < 2) return;

      ctx.strokeStyle = this.color;
      ctx.lineWidth = 2;
      ctx.lineCap = 'round';
      ctx.lineJoin = 'round';

      ctx.beginPath();
      ctx.moveTo(this.path[0].x, this.path[0].y);

      for (let i = 1; i < this.path.length; i++) {
        ctx.lineTo(this.path[i].x, this.path[i].y);
      }

      ctx.stroke();

      // Draw starting point
      ctx.fillStyle = this.color;
      ctx.beginPath();
      ctx.arc(this.path[0].x, this.path[0].y, 4, 0, 2 * Math.PI);
      ctx.fill();

      // Draw current position
      const current = this.path[this.path.length - 1];
      ctx.fillStyle = this.color;
      ctx.beginPath();
      ctx.arc(current.x, current.y, 3, 0, 2 * Math.PI);
      ctx.fill();
    }
  }

  function initializeWalks() {
    const numWalks = parseInt(numWalksSlider.value);
    const stepSize = parseInt(stepSizeSlider.value);
    dimension = parseInt(dimensionSelect.value);

    walks = [];
    for (let i = 0; i < numWalks; i++) {
      walks.push(new RandomWalk(colors[i % colors.length], stepSize, dimension));
    }
  }

  function drawGrid() {
    ctx.strokeStyle = '#2a2a2a';
    ctx.lineWidth = 0.5;

    // Vertical lines
    for (let x = 0; x <= canvas.width; x += 50) {
      ctx.beginPath();
      ctx.moveTo(x, 0);
      ctx.lineTo(x, canvas.height);
      ctx.stroke();
    }

    // Horizontal lines
    for (let y = 0; y <= canvas.height; y += 50) {
      ctx.beginPath();
      ctx.moveTo(0, y);
      ctx.lineTo(canvas.width, y);
      ctx.stroke();
    }

    // Center lines
    ctx.strokeStyle = '#444444';
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(canvas.width / 2, 0);
    ctx.lineTo(canvas.width / 2, canvas.height);
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(0, canvas.height / 2);
    ctx.lineTo(canvas.width, canvas.height / 2);
    ctx.stroke();
  }

  function clear() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
  }

  function draw() {
    clear();
    drawGrid();

    walks.forEach(walk => walk.draw());
  }

  function animate() {
    if (!isRunning) return;

    const maxSteps = parseInt(maxStepsSlider.value);

    if (currentStep < maxSteps) {
      walks.forEach(walk => walk.step());
      currentStep++;
      draw();
      updateStats();

      const delay = 101 - parseInt(speedSlider.value);
      animationId = setTimeout(() => {
        requestAnimationFrame(animate);
      }, delay);
    } else {
      stop();
      updateStats('Completed');
    }
  }

  function start() {
    if (!isRunning) {
      if (currentStep === 0) {
        initializeWalks();
      }
      isRunning = true;
      startBtn.disabled = true;
      pauseBtn.disabled = false;
      updateStats('Running');
      animate();
    }
  }

  function pause() {
    isRunning = false;
    startBtn.disabled = false;
    pauseBtn.disabled = true;
    if (animationId) {
      clearTimeout(animationId);
    }
    updateStats('Paused');
  }

  function stop() {
    isRunning = false;
    startBtn.disabled = false;
    pauseBtn.disabled = true;
    if (animationId) {
      clearTimeout(animationId);
    }
  }

  function reset() {
    stop();
    currentStep = 0;
    walks = [];
    clear();
    drawGrid();
    updateStats('Ready');
  }

  function updateStats(status = null) {
    const maxSteps = parseInt(maxStepsSlider.value);
    const statusText = status || (isRunning ? 'Running' : 'Paused');
    statsDiv.textContent = `Steps: ${currentStep} / ${maxSteps} | Status: ${statusText}`;
  }

  // Event listeners
  startBtn.addEventListener('click', start);
  pauseBtn.addEventListener('click', pause);
  resetBtn.addEventListener('click', reset);

  // Initialize
  drawGrid();
  updateStats('Ready');
</script>

---

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
