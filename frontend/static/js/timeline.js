// Timeline functionality

export function getNodeDate(node) {
  const dateProps = [
    'point_in_time',
    'report_date',
    'event_date',
    'media_date',
    'discovery_date'
  ]
  for (const prop of dateProps) {
    if (node.properties?.[prop]) {
      return {
        date: node.properties[prop],
        type: prop
      }
    }
  }
  return null
}

export function formatDate(dateStr) {
  const date = new Date(dateStr)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

export function renderTimeline(cy, timelineContent) {
  if (!cy) return

  const timelineEntries = []
  cy.nodes().forEach((node) => {
    const nodeData = node.data()
    const dateInfo = getNodeDate(nodeData)

    if (dateInfo) {
      timelineEntries.push({
        id: nodeData.id,
        date: dateInfo.date,
        type: dateInfo.type,
        label: nodeData.label,
        description: nodeData.description,
        properties: nodeData.properties,
        nodeType: nodeData.properties?.type || 'default'
      })
    }
  })

  // Sort entries by date
  timelineEntries.sort((a, b) => new Date(a.date) - new Date(b.date))

  // Clear and render timeline
  timelineContent.innerHTML = ''
  timelineEntries.forEach((entry) => {
    console.log('Timeline entry:', entry); // Debug log
    const entryDiv = document.createElement('div')
    entryDiv.className = 'timeline-entry'

    const formattedDate = formatDate(entry.date)

    entryDiv.innerHTML = `
      <div class="date">${formattedDate}</div>
      <div class="summary">${entry.label}</div>
      ${entry.description ? `<div class="description">${entry.description}</div>` : ''}
    `

    // Add click handler to show node details (do NOT switch to graph view)
    entryDiv.addEventListener('click', () => {
      const node = cy.getElementById(entry.id)
      if (node.length) {
        node.trigger('tap')
      }
    })

    timelineContent.appendChild(entryDiv)
  })
} 