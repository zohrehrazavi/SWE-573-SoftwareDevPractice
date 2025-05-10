import { getNodeDate, renderTimeline } from '../static/js/timeline.js'

describe('Timeline View Tests', () => {
  // Mock nodes with different time-based properties
  const mockNodes = [
    {
      id: 'node1',
      label: 'First Report',
      properties: {
        type: 'report',
        report_date: '2023-01-15',
        title: 'Initial Investigation'
      }
    },
    {
      id: 'node2',
      label: 'Key Witness',
      properties: {
        type: 'witness',
        point_in_time: '2023-02-20',
        location: 'Downtown'
      }
    },
    {
      id: 'node3',
      label: 'Media Evidence',
      properties: {
        type: 'media',
        media_date: '2023-03-10',
        format: 'photo'
      }
    },
    {
      id: 'node4',
      label: 'Default Node',
      properties: {
        type: 'default',
        point_in_time: '2023-04-01'
      }
    }
  ]

  // Mock Cytoscape instance
  let mockCy
  let mockTimelineContent
  let mockNodeMap

  beforeEach(() => {
    // Setup DOM elements
    document.body.innerHTML = `
      <div id="cy"></div>
      <div id="timeline">
        <div class="timeline-content"></div>
      </div>
    `
    mockTimelineContent = document.querySelector('.timeline-content')

    // Create a map of mock node objects for consistent references
    mockNodeMap = {}
    mockNodes.forEach(node => {
      mockNodeMap[node.id] = {
        length: 1,
        trigger: jest.fn()
      }
    })

    // Mock Cytoscape instance
    mockCy = {
      nodes: () => ({
        forEach: (callback) => {
          mockNodes.forEach(node => {
            callback({
              data: () => node
            })
          })
        }
      }),
      getElementById: (id) => mockNodeMap[id]
    }
  })

  test('getNodeDate extracts correct date from properties', () => {
    const node = { properties: { report_date: '2023-01-15' } }
    const dateInfo = getNodeDate(node)
    expect(dateInfo).toEqual({
      date: '2023-01-15',
      type: 'report_date'
    })
  })

  test('renderTimeline sorts entries chronologically', () => {
    renderTimeline(mockCy, mockTimelineContent)
    const entries = mockTimelineContent.querySelectorAll('.timeline-entry')
    
    // Check if entries are rendered
    expect(entries.length).toBe(4)
    
    // Check if dates are in chronological order
    const dates = Array.from(entries).map(entry => {
      const dateText = entry.querySelector('.date').textContent
      const dateMatch = dateText.match(/(\w+ \d+, \d{4})/)
      return new Date(dateMatch[1])
    })
    
    const isSorted = dates.every((date, i) => 
      i === 0 || date >= dates[i - 1]
    )
    expect(isSorted).toBe(true)
  })

  test('timeline entries show correct information', () => {
    renderTimeline(mockCy, mockTimelineContent)
    const entries = mockTimelineContent.querySelectorAll('.timeline-entry')
    
    // Check first entry (report)
    expect(entries[0].querySelector('.date').textContent).toContain('January 15, 2023')
    expect(entries[0].querySelector('.summary').textContent).toBe('First Report')
    // No type/source field anymore
    expect(entries[0].querySelector('.source')).toBeNull()
    
    // Check last entry (default type)
    expect(entries[3].querySelector('.date').textContent).toContain('April 1, 2023')
    expect(entries[3].querySelector('.summary').textContent).toBe('Default Node')
    expect(entries[3].querySelector('.source')).toBeNull()
  })

  test('clicking timeline entry shows node details (no view switch)', () => {
    // No longer expect switchToGraphView to be called
    window.switchToGraphView = jest.fn()
    renderTimeline(mockCy, mockTimelineContent)
    const firstEntry = mockTimelineContent.querySelector('.timeline-entry')
    const clickEvent = new MouseEvent('click', {
      bubbles: true,
      cancelable: true,
      view: window
    })
    firstEntry.dispatchEvent(clickEvent)
    // Only expect node pop-up trigger
    expect(mockNodeMap['node1'].trigger).toHaveBeenCalledWith('tap')
  })

  test('timeline entry shows description if present', () => {
    const mockCy = {
      nodes: () => [
        {
          data: () => ({
            id: '1',
            label: 'Test Node',
            description: 'This is a test description.',
            properties: { report_date: '2023-01-01' }
          })
        }
      ]
    }
    const container = document.createElement('div')
    renderTimeline(mockCy, container)
    const entry = container.querySelector('.timeline-entry')
    expect(entry.querySelector('.description').textContent).toBe('This is a test description.')
  })
}) 