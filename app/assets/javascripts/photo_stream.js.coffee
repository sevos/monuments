$ ->
  alert('ready')
  $('#photo-stream').coverflow
    easing:     'easeOutElastic',
    duration:   'slow',
    index:      0,
    width:      400,
    height:     400,
    visible:    'density',
    selectedCss:  { opacity: 1  },
    outerCss:   { opacity: .1 },