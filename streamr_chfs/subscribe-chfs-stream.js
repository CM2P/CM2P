const StreamrClient = require('streamr-client')

const client = new StreamrClient({
    auth: {
        privateKey: '5db175cc3d1aa8bdb367c58aa928d5e5e8d75f5579a9dc3a26eccfac4e41bd57',
    },
})

// Subscribe to a stream
client.subscribe({
    stream: '0x4ab637f2880fb13fd5d6817eb4ee6981e2002d40/chfs-swiss-stable-coin',
}, (message, metadata) => {
    // Do something with the message here!
    console.log(message)
})
