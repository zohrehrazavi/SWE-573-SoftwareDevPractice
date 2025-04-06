let nodeCount = 1;
let isAddingNode = false;
let isAddingEdge = false;
let isRemovingEdge = false;
let isRemovingNode = false;
let selectedNode = null;
let isDragging = false;
let draggedNode = null;
let lastNodePosition = { x: 50, y: 50 }; // Starting position for nodes
const NODE_SPACING = 200; // Space between nodes
const BOARD_WIDTH = 800; // Assuming board width is 800px

const board = document.getElementById('board');

// Add the Wikidata endpoint constant
const WIKIDATA_ENDPOINT = 'https://query.wikidata.org/sparql';

// Add the queryWikidata function
async function queryWikidata(query) {
    const url = `${WIKIDATA_ENDPOINT}?query=${encodeURIComponent(query)}&format=json`;
    const response = await fetch(url, {
        headers: {
            'Accept': 'application/sparql-results+json',
            'User-Agent': 'GraphVisualization/1.0'
        }
    });
    return await response.json();
}

// Add the searchWikidata function
async function searchWikidata(searchTerm) {
    const query = `
    SELECT DISTINCT ?item ?itemLabel ?description WHERE {
        SERVICE wikibase:mwapi {
            bd:serviceParam wikibase:api "EntitySearch";
                           wikibase:endpoint "www.wikidata.org";
                           mwapi:search "${searchTerm}";
                           mwapi:language "en".
            ?item wikibase:apiOutputItem mwapi:item.
        }
        SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
        OPTIONAL { ?item schema:description ?description. FILTER(LANG(?description) = "en") }
    }
    LIMIT 5
    `;

    try {
        const data = await queryWikidata(query);
        return data.results.bindings;
    } catch (error) {
        console.error('Error searching Wikidata:', error);
        return [];
    }
}

// Add the getRelatedInfo function
async function getRelatedInfo(wikidataId) {
    const query = `
    SELECT DISTINCT ?property ?propertyLabel ?value ?valueLabel WHERE {
        wd:${wikidataId} ?prop ?value .
        ?property wikibase:directClaim ?prop .
        FILTER(STRSTARTS(STR(?property), "http://www.wikidata.org/entity/"))
        SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
    }
    LIMIT 20
    `;

    try {
        const data = await queryWikidata(query);
        return data.results.bindings;
    } catch (error) {
        console.error('Error fetching related info:', error);
        return [];
    }
}

const searchInput = document.getElementById('searchInput');
const searchDropdown = document.getElementById('searchDropdown');

let debounceTimeout;
let nodeCounter = 1;  // Make sure this is at the top of your file

// Update the Wikidata search event listener
document.getElementById('searchInput').addEventListener('input', async (e) => {
    const searchTerm = e.target.value.trim();
    const dropdown = document.querySelector('.search-dropdown');
    
    if (searchTerm.length < 2) {
        dropdown.classList.remove('active');
        dropdown.innerHTML = '';
        return;
    }

    const url = `https://www.wikidata.org/w/api.php?` + 
        `action=wbsearchentities&` +
        `search=${encodeURIComponent(searchTerm)}&` +
        `language=en&` +
        `limit=10&` +
        `format=json&` +
        `origin=*`;
    
    try {
        const response = await fetch(url);
        const data = await response.json();
        
        dropdown.innerHTML = '';
        
        if (data.search && data.search.length > 0) {
            data.search.forEach(item => {
                const div = document.createElement('div');
                div.className = 'dropdown-item';
                div.textContent = `${item.label}${item.description ? ` - ${item.description}` : ''}`;
                div.addEventListener('click', () => {
                    const node = createNodeWithIcons(item.label, `node${nodeCounter}`);
                    document.getElementById('board').appendChild(node);
                    
                    // Position node with some offset from the last one
                    const board = document.getElementById('board');
                    const boardRect = board.getBoundingClientRect();
                    
                    // Calculate position to avoid edges
                    const xPos = Math.min(50 + (nodeCounter * 50), boardRect.width - 150);
                    const yPos = Math.min(50 + (nodeCounter * 30), boardRect.height - 150);
                    
                    node.style.left = `${xPos}px`;
                    node.style.top = `${yPos}px`;
                    
                    nodeCounter++;
                    
                    // Clear search
                    dropdown.classList.remove('active');
                    e.target.value = '';
                });
                dropdown.appendChild(div);
            });
            dropdown.classList.add('active');
        } else {
            dropdown.classList.remove('active');
        }
    } catch (error) {
        console.error('Error fetching Wikidata:', error);
        dropdown.classList.remove('active');
    }
});

// Close dropdown when clicking outside
document.addEventListener('click', (e) => {
    if (!searchInput.contains(e.target) && !searchDropdown.contains(e.target)) {
        searchDropdown.classList.remove('active');
    }
});

// Add all button-related variables at the top
let scale = 1;
const ZOOM_SPEED = 0.1;
const MIN_SCALE = 0.2;
const MAX_SCALE = 2;
let panX = 0;
let panY = 0;

// Wait for DOM to load before adding event listeners
document.addEventListener('DOMContentLoaded', () => {
    // Get all buttons
    const removeNodeBtn = document.getElementById('removeNodeBtn');
    const addEdgeBtn = document.getElementById('addEdgeBtn');
    const removeEdgeBtn = document.getElementById('removeEdgeBtn');
    const zoomIn = document.getElementById('zoomIn');
    const zoomOut = document.getElementById('zoomOut');
    const zoomReset = document.getElementById('zoomReset');
    const board = document.getElementById('board');

    // Remove Node button
    removeNodeBtn.addEventListener('click', () => {
        const nodes = document.querySelectorAll('.node');
        if (nodes.length === 0) {
            alert('No nodes to remove!');
            return;
        }
        
        const nodeList = Array.from(nodes)
            .map(node => node.querySelector('.node-title').textContent)
            .join(', ');
        
        const nodeToRemove = prompt(`Enter the name of the node to remove (Available nodes: ${nodeList})`);
        
        if (nodeToRemove) {
            const nodeElement = Array.from(nodes).find(
                node => node.querySelector('.node-title').textContent.toLowerCase() === nodeToRemove.toLowerCase()
            );
            if (nodeElement) {
                removeNode(nodeElement);
            } else {
                alert('Node not found!');
            }
        }
    });

    // Add Edge button
    addEdgeBtn.addEventListener('click', () => {
        const nodes = document.querySelectorAll('.node');
        if (nodes.length < 2) {
            alert('Need at least 2 nodes to create an edge!');
            return;
        }
        
        const nodeList = Array.from(nodes)
            .map(node => node.querySelector('.node-title').textContent)
            .join(', ');
        
        const fromNodeName = prompt(`Enter the first node name (Available nodes: ${nodeList})`);
        if (!fromNodeName) return;
        
        const toNodeName = prompt(`Enter the second node name (Available nodes: ${nodeList})`);
        if (!toNodeName) return;
        
        const fromNode = Array.from(nodes).find(
            node => node.querySelector('.node-title').textContent.toLowerCase() === fromNodeName.toLowerCase()
        );
        const toNode = Array.from(nodes).find(
            node => node.querySelector('.node-title').textContent.toLowerCase() === toNodeName.toLowerCase()
        );
        
        if (fromNode && toNode) {
            addEdge(fromNode.id, toNode.id);
        } else {
            alert('One or both nodes not found!');
        }
    });

    // Remove Edge button
    removeEdgeBtn.addEventListener('click', () => {
        const edges = document.querySelectorAll('.edge');
        if (edges.length === 0) {
            alert('No edges to remove!');
            return;
        }
        
        const nodes = document.querySelectorAll('.node');
        const nodeList = Array.from(nodes)
            .map(node => node.querySelector('.node-title').textContent)
            .join(', ');
        
        const fromNodeName = prompt(`Enter the first node name (Available nodes: ${nodeList})`);
        if (!fromNodeName) return;
        
        const toNodeName = prompt(`Enter the second node name (Available nodes: ${nodeList})`);
        if (!toNodeName) return;
        
        const fromNode = Array.from(nodes).find(
            node => node.querySelector('.node-title').textContent.toLowerCase() === fromNodeName.toLowerCase()
        );
        const toNode = Array.from(nodes).find(
            node => node.querySelector('.node-title').textContent.toLowerCase() === toNodeName.toLowerCase()
        );
        
        if (fromNode && toNode) {
            removeEdgeBetweenNodes(fromNode.id, toNode.id);
        } else {
            alert('One or both nodes not found!');
        }
    });

    // Zoom controls
    zoomIn.addEventListener('click', () => {
        if (scale < MAX_SCALE) {
            scale += ZOOM_SPEED;
            updateZoom();
        }
    });

    zoomOut.addEventListener('click', () => {
        if (scale > MIN_SCALE) {
            scale -= ZOOM_SPEED;
            updateZoom();
        }
    });

    zoomReset.addEventListener('click', () => {
        scale = 1;
        panX = 0;
        panY = 0;
        updateZoom();
    });

    // Mouse wheel zoom
    board.addEventListener('wheel', (e) => {
        if (e.ctrlKey) {
            e.preventDefault();
            updateZoom(e);
        }
    });

    // Remove zoom controls from HTML if they exist
    const zoomControls = document.querySelector('.zoom-controls');
    if (zoomControls) {
        zoomControls.remove();
    }
});

function updateEdge(edgeContainer) {
    const edge = edgeContainer.querySelector('.edge');
    const label = edgeContainer.querySelector('.edge-label');
    const fromNode = document.getElementById(edge.dataset.from);
    const toNode = document.getElementById(edge.dataset.to);
    
    if (!fromNode || !toNode) return;
    
    const fromRect = fromNode.getBoundingClientRect();
    const toRect = toNode.getBoundingClientRect();
    
    const fromX = fromRect.left + fromRect.width / 2;
    const fromY = fromRect.top + fromRect.height / 2;
    const toX = toRect.left + toRect.width / 2;
    const toY = toRect.top + toRect.height / 2;
    
    const angle = Math.atan2(toY - fromY, toX - fromX);
    const length = Math.sqrt(
        Math.pow(toX - fromX, 2) + 
        Math.pow(toY - fromY, 2)
    );
    
    const boardRect = document.getElementById('board').getBoundingClientRect();
    edge.style.width = `${length}px`;
    edgeContainer.style.left = `${fromX - boardRect.left}px`;
    edgeContainer.style.top = `${fromY - boardRect.top}px`;
    edge.style.transform = `rotate(${angle}rad)`;
    
    // Position the label
    label.style.transform = `rotate(${angle}rad) translate(${length/2}px, -10px)`;
}

function updateZoom(e) {
    const board = document.getElementById('board');
    const oldScale = scale;
    
    if (e) {
        const rect = board.getBoundingClientRect();
        const mouseX = e.clientX - rect.left;
        const mouseY = e.clientY - rect.top;
        
        // Calculate new scale
        const delta = e.deltaY > 0 ? -ZOOM_SPEED : ZOOM_SPEED;
        const newScale = Math.min(Math.max(MIN_SCALE, scale + delta), MAX_SCALE);
        
        // Only update if scale actually changes
        if (newScale !== scale) {
            // Adjust pan to zoom toward mouse position
            const scaleFactor = newScale / scale;
            panX -= (mouseX * (scaleFactor - 1));
            panY -= (mouseY * (scaleFactor - 1));
            scale = newScale;
        }
    }
    
    // Apply transforms
    board.style.transform = `translate(${panX}px, ${panY}px) scale(${scale})`;
    
    // Update node appearance based on zoom level
    const nodes = document.querySelectorAll('.node');
    nodes.forEach(node => {
        // Scale node size inversely to maintain apparent size
        node.style.transform = `scale(${1/scale})`;
        
        // Show/hide text based on zoom level
        if (scale < 0.5) {
            node.classList.add('zoomed-out');
        } else {
            node.classList.remove('zoomed-out');
        }
    });
    
    // Update edges
    document.querySelectorAll('.edge-container').forEach(container => {
        const edge = container.querySelector('.edge');
        if (edge.dataset.from === node.id || edge.dataset.to === node.id) {
            updateEdge(container);
        }
    });
}

// Keep your existing helper functions
function addEdge(fromId, toId, label) {
    if (fromId === toId) {
        alert("Can't create an edge to the same node!");
        return;
    }
    
    const existingEdge = document.querySelector(
        `.edge[data-from="${fromId}"][data-to="${toId}"], .edge[data-from="${toId}"][data-to="${fromId}"]`
    );
    
    if (existingEdge) {
        alert('Edge already exists between these nodes!');
        return;
    }
    
    const edgeContainer = document.createElement('div');
    edgeContainer.className = 'edge-container';
    
    const edge = document.createElement('div');
    edge.className = 'edge';
    edge.dataset.from = fromId;
    edge.dataset.to = toId;
    
    const labelDiv = document.createElement('div');
    labelDiv.className = 'edge-label';
    labelDiv.textContent = label;
    
    edgeContainer.appendChild(edge);
    edgeContainer.appendChild(labelDiv);
    document.getElementById('board').appendChild(edgeContainer);
    
    updateEdge(edgeContainer);
}

function removeEdgeBetweenNodes(fromId, toId) {
    const edge = document.querySelector(
        `.edge[data-from="${fromId}"][data-to="${toId}"], .edge[data-from="${toId}"][data-to="${fromId}"]`
    );
    if (edge) edge.remove();
}

// Keep all other existing functions (updateEdge, updateEdges, removeNode, etc.)

// Node dragging
board.addEventListener('mousedown', (e) => {
    const node = e.target.closest('.node');
    if (!node) return;
    
    e.preventDefault(); // Prevent text selection while dragging
    
    const rect = node.getBoundingClientRect();
    const boardRect = board.getBoundingClientRect();
    
    const offsetX = e.clientX - rect.left;
    const offsetY = e.clientY - rect.top;
    
    function moveNode(moveEvent) {
        const x = moveEvent.clientX - boardRect.left - offsetX;
        const y = moveEvent.clientY - boardRect.top - offsetY;
        
        // Keep node within board boundaries
        const maxX = boardRect.width - rect.width;
        const maxY = boardRect.height - rect.height;
        
        node.style.left = `${Math.min(Math.max(0, x), maxX)}px`;
        node.style.top = `${Math.min(Math.max(0, y), maxY)}px`;
        
        // Update any connected edges
        updateEdges(node);
    }
    
    function stopDragging() {
        document.removeEventListener('mousemove', moveNode);
        document.removeEventListener('mouseup', stopDragging);
    }
    
    document.addEventListener('mousemove', moveNode);
    document.addEventListener('mouseup', stopDragging);
});

// Update the node creation function
function createNodeWithIcons(label, id) {
    const node = document.createElement('div');
    node.className = 'node';
    node.id = id;
    
    // Create icons container
    const icons = document.createElement('div');
    icons.className = 'node-icons';
    
    // Delete icon
    const deleteIcon = document.createElement('div');
    deleteIcon.className = 'node-icon delete-icon';
    deleteIcon.innerHTML = '×';
    deleteIcon.title = 'Delete node';
    deleteIcon.addEventListener('click', (e) => {
        e.stopPropagation();
        removeNode(node);
    });
    
    // Add edge icon
    const edgeIcon = document.createElement('div');
    edgeIcon.className = 'node-icon edge-icon';
    edgeIcon.innerHTML = '→';
    edgeIcon.title = 'Add edge';
    edgeIcon.addEventListener('click', (e) => {
        e.stopPropagation();
        promptAndAddEdge(id);
    });
    
    // Remove edge icon
    const removeEdgeIcon = document.createElement('div');
    removeEdgeIcon.className = 'node-icon remove-edge-icon';
    removeEdgeIcon.innerHTML = '−';
    removeEdgeIcon.title = 'Remove edge';
    removeEdgeIcon.addEventListener('click', (e) => {
        e.stopPropagation();
        promptAndRemoveEdge(id);
    });
    
    icons.appendChild(deleteIcon);
    icons.appendChild(edgeIcon);
    icons.appendChild(removeEdgeIcon);
    
    const number = document.createElement('div');
    number.className = 'node-number';
    number.textContent = `Node ${id.replace('node', '')}`;
    
    const title = document.createElement('div');
    title.className = 'node-title';
    title.textContent = label;
    
    node.appendChild(icons);
    node.appendChild(number);
    node.appendChild(title);
    
    makeDraggable(node);
    return node;
}

function promptAndAddEdge(fromId) {
    const nodes = Array.from(document.querySelectorAll('.node'))
        .filter(n => n.id !== fromId);
    
    if (nodes.length === 0) {
        alert('No other nodes available to connect to!');
        return;
    }
    
    const nodeList = nodes
        .map(n => `Node ${n.id.replace('node', '')}: ${n.querySelector('.node-title').textContent}`)
        .join('\n');
    
    const targetNodeNum = prompt(
        `Enter the node number to connect to:\n\nAvailable nodes:\n${nodeList}`
    );
    
    if (targetNodeNum) {
        const targetNode = document.getElementById(`node${targetNodeNum}`);
        if (targetNode) {
            const edgeLabel = prompt('Enter a label for this edge:');
            if (edgeLabel) {
                addEdge(fromId, targetNode.id, edgeLabel);
            }
        } else {
            alert('Invalid node number!');
        }
    }
}

function promptAndRemoveEdge(nodeId) {
    const connectedEdges = Array.from(document.querySelectorAll('.edge')).filter(
        edge => edge.dataset.from === nodeId || edge.dataset.to === nodeId
    );
    
    if (connectedEdges.length === 0) {
        alert('No edges connected to this node!');
        return;
    }
    
    const connectedNodes = connectedEdges.map(edge => {
        const otherId = edge.dataset.from === nodeId ? edge.dataset.to : edge.dataset.from;
        const otherNode = document.getElementById(otherId);
        const label = edge.parentElement.querySelector('.edge-label').textContent;
        return `Node ${otherId.replace('node', '')}: ${otherNode.querySelector('.node-title').textContent} (Label: ${label})`;
    }).join('\n');
    
    const targetNodeNum = prompt(
        `Enter the node number to remove edge to:\n\nConnected nodes:\n${connectedNodes}`
    );
    
    if (targetNodeNum) {
        const targetId = `node${targetNodeNum}`;
        const edgeContainer = document.querySelector(
            `.edge-container .edge[data-from="${nodeId}"][data-to="${targetId}"], .edge-container .edge[data-from="${targetId}"][data-to="${nodeId}"]`
        )?.parentElement;
        
        if (edgeContainer) {
            edgeContainer.remove();
        } else {
            alert('No edge found to that node!');
        }
    }
}

function makeDraggable(node) {
    let isDragging = false;
    let currentX;
    let currentY;
    let initialX;
    let initialY;

    node.addEventListener('mousedown', (e) => {
        if (e.target.closest('.node-icon')) return;
        
        initialX = e.clientX - node.offsetLeft;
        initialY = e.clientY - node.offsetTop;
        isDragging = true;
    });

    document.addEventListener('mousemove', (e) => {
        if (isDragging) {
            e.preventDefault();
            currentX = e.clientX - initialX;
            currentY = e.clientY - initialY;

            const board = document.getElementById('board');
            const boardRect = board.getBoundingClientRect();
            const nodeRect = node.getBoundingClientRect();

            currentX = Math.min(Math.max(0, currentX), boardRect.width - nodeRect.width);
            currentY = Math.min(Math.max(0, currentY), boardRect.height - nodeRect.height);

            node.style.left = `${currentX}px`;
            node.style.top = `${currentY}px`;
            
            updateEdges(node);
        }
    });

    document.addEventListener('mouseup', () => {
        isDragging = false;
    });
}

function updateEdges(node) {
    document.querySelectorAll('.edge-container').forEach(container => {
        const edge = container.querySelector('.edge');
        if (edge.dataset.from === node.id || edge.dataset.to === node.id) {
            updateEdge(container);
        }
    });
}

function removeNode(node) {
    document.querySelectorAll('.edge-container').forEach(container => {
        const edge = container.querySelector('.edge');
        if (edge.dataset.from === node.id || edge.dataset.to === node.id) {
            container.remove();
        }
    });
    node.remove();
}

// Pan functionality
let isPanning = false;
let startX, startY;

document.querySelector('.board-container').addEventListener('mousedown', (e) => {
    if (e.button === 0 && !e.target.closest('.node')) { // Left click and not on a node
        isPanning = true;
        startX = e.clientX - panX;
        startY = e.clientY - panY;
        e.preventDefault();
    }
});

document.addEventListener('mousemove', (e) => {
    if (isPanning) {
        panX = e.clientX - startX;
        panY = e.clientY - startY;
        document.getElementById('board').style.transform = 
            `translate(${panX}px, ${panY}px) scale(${scale})`;
    }
});

document.addEventListener('mouseup', () => {
    isPanning = false;
});

// Update the CSS for edge labels
const style = document.createElement('style');
style.textContent = `
    .edge-container {
        position: absolute;
        z-index: 1;
    }
    
    .edge {
        height: 2px;
        background-color: #333;
        transform-origin: left center;
        position: absolute;
        width: 100%;
    }
    
    .edge-label {
        position: absolute;
        transform-origin: left center;
        background: white;
        padding: 2px 6px;
        border-radius: 3px;
        font-size: 12px;
        white-space: nowrap;
        text-align: center;
        border: 1px solid #ccc;
    }
`;
document.head.appendChild(style); 