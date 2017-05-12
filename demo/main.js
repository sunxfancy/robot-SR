const { app, BrowserWindow } = require("electron");
const os = require('os')
const path = require('path')
const url = require('url')

function createWindow() {
    var win = new BrowserWindow({
        width: 800, height: 600,
        autoHideMenuBar: true, frame: true,
        show: true, transparent: false,
        resizable: true, skipTaskbar: false,
        alwaysOnTop: false,
        hasShadow: true
    })
    win.loadURL(url.format({
        pathname: path.join(__dirname, "demo/index.html"),
        protocol: 'file:',
        slashes: true,
    }))
    win.on('closed', function() {
        win = null
    })
}


app.on('ready', createWindow)

app.on('window-all-closed', function() {
    if (process.platform !== 'darwin') {
        app.quit()
    }
})

