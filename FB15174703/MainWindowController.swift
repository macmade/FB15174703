/*******************************************************************************
 * The MIT License (MIT)
 *
 * Copyright (c) 2023, Jean-David Gadina - www.xs-labs.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the Software), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

import Cocoa
import Network

public class MainWindowController: NSWindowController, NetServiceBrowserDelegate, NetServiceDelegate
{
    private let servicesToBrowse  = [ "_companion-link._tcp.", "_rdlink._tcp.", "_airport._tcp.", "_airplay._tcp.", "_device-info._tcp." ]
    private let servicesToMonitor = [ "_device-info._tcp.", "_airplay._tcp." ]

    private var services: [ NetService ]        = []
    private var browsers: [ NetServiceBrowser ] = []

    @IBOutlet private var arrayController: NSArrayController?

    public init()
    {
        super.init( window: nil )
    }

    public required init?( coder: NSCoder )
    {
        nil
    }

    public override var windowNibName: NSNib.Name?
    {
        "MainWindowController"
    }

    public override func windowDidLoad()
    {
        super.windowDidLoad()

        self.browsers = self.servicesToBrowse.map
        {
            let browser      = NetServiceBrowser()
            browser.delegate = self

            browser.searchForServices( ofType: $0, inDomain: "local." )

            return browser
        }
    }

    public func netServiceBrowser( _ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool )
    {
        self.servicesToMonitor.map
        {
            let service      = NetService( domain: "local.", type: $0, name: service.name )
            service.delegate = self

            service.startMonitoring()

            return service
        }
        .forEach
        {
            self.services.append( $0 )
        }
    }

    public func netService( _ sender: NetService, didUpdateTXTRecord data: Data )
    {
        guard let modelData = NetService.dictionary( fromTXTRecord: data )[ "model" ],
              let model     = String( data: modelData, encoding: .utf8 )
        else
        {
            return
        }

        guard let devices = self.arrayController?.content as? [ Device ]
        else
        {
            return
        }

        if devices.contains( where: { $0.serviceName == sender.name } )
        {
            return
        }

        let device = Device( serviceName: sender.name, model: model )

        self.arrayController?.addObject( device )
    }
}
