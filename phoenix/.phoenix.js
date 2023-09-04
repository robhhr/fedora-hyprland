Phoenix.set({
  daemon: false,
  openAtLogin: true,
})

const modifier = ['alt', 'shift']

const computeNewFrameFromGrid = (screen, grid) => {
  const screenRect = screen.flippedVisibleFrame()

  if (!screenRect) return
  var unitX = screenRect.width / grid.cols
  var unitY = screenRect.height / grid.rows
  var newFrame = {
    x: screenRect.x + grid.x * unitX,
    y: screenRect.y + grid.y * unitY,
    width: grid.width * unitX,
    height: grid.height * unitY,
  }
  return newFrame
}

const move = grid => {
  const win = Window.focused()
  const screen = win.screen()
  var newFrame = computeNewFrameFromGrid(screen, grid)
  win.setSize({width: newFrame.width, height: newFrame.height})
  win.setTopLeft({x: newFrame.x, y: newFrame.y})
  win.setSize({width: newFrame.width, height: newFrame.height})
}

// move
Key.on('l', modifier, () => {
  move({x: 5.8, y: .1, width: 4.1, height: 5.7, rows: 6, cols: 10})
})

Key.on('j', modifier, () => {
  move({x: .1, y: .1, width: 5.5, height: 4.5, rows: 6, cols: 10})
})

Key.on('z', modifier, () => {
  move({x: 0, y: 1, width: 2.5, height: 1, rows: 2, cols: 9})
})

Key.on('x', modifier, () => {
  move({x: 2.5, y: 1, width: 4, height: 1, rows: 2, cols: 9})
})

Key.on('f', modifier, () => {
  Window.focused().maximize()
})

Key.on('a', modifier, () => {
  move({x: .05, y: .05, width: 4.95, height: 5.8, rows: 6, cols: 10})
})

Key.on('d', modifier, () => {
  move({x: 5.05, y: .05, width: 4.90, height: 5.8, rows: 6, cols: 10})
})

