import UIKit

public enum HTTPStatusCodes: Int {
    // 100 Informational
    case `continue` = 100
    case switchingProtocols = 101
    case processing = 102
    // 200 Success
    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multiStatus = 207
    case alreadyReported = 208
    case iMUsed = 226
    // 300 Redirection
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case switchProxy = 306
    case temporaryRedirect = 307
    case permanentRedirect = 308
    // 400 Client Error
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case payloadTooLarge = 413
    case uriTooLong = 414
    case unsupportedMediaType = 415
    case rangeNotSatisfiable = 416
    case expectationFailed = 417
    case imATeapot = 418
    case misdirectedRequest = 421
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case unavailableForLegalReasons = 451
    case clientClosedRequest = 499
    // 500 Server Error
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case notExtended = 510
    case networkAuthenticationRequired = 511
    
    var responseTitle: String {
        switch self {
        case .`continue`: return "Continue"
        case .switchingProtocols: return "Switching Protocols"
        case .processing: return "Processing"
        case .ok: return "OK"
        case .created: return "Created"
        case .accepted: return "Accepted"
        case .nonAuthoritativeInformation: return "Non-Authoritative Information"
        case .noContent: return "No Content"
        case .resetContent: return "Reset Content"
        case .partialContent: return "Partial Content"
        case .multiStatus: return "Multi-Status"
        case .alreadyReported: return "Already Reported"
        case .iMUsed: return "IM Used"
        case .multipleChoices: return "Multiple Choices"
        case .movedPermanently: return "Moved Permanently"
        case .found: return "Found"
        case .seeOther: return "See Other"
        case .notModified: return "Not Modified"
        case .useProxy: return "Use Proxy"
        case .switchProxy: return "Switch Proxy"
        case .temporaryRedirect: return "Temporary Redirect"
        case .permanentRedirect: return "Permanent Redirect"
        case .badRequest: return "Bad Request"
        case .unauthorized: return "Unauthorized"
        case .paymentRequired: return "Payment Required"
        case .forbidden: return "Forbidden"
        case .notFound: return "Not Found"
        case .methodNotAllowed: return "Method Not Allowed"
        case .notAcceptable: return "Not Acceptable"
        case .proxyAuthenticationRequired: return "Proxy Authentication Required"
        case .requestTimeout: return "Request Timeout"
        case .conflict: return "Conflict"
        case .gone: return "Gone"
        case .lengthRequired: return "Length Required"
        case .preconditionFailed: return "Precondition Failed"
        case .payloadTooLarge: return "Payload Too Large"
        case .uriTooLong: return "URI Too Long"
        case .unsupportedMediaType: return "Unsupported Media Type"
        case .rangeNotSatisfiable: return "Range Not Satisfiable"
        case .expectationFailed: return "Expectation Failed"
        case .imATeapot: return "I'm a teapot"
        case .misdirectedRequest: return "Misdirected Request"
        case .unprocessableEntity: return "Unprocessable Entity"
        case .locked: return "Locked"
        case .failedDependency: return "Failed Dependency"
        case .upgradeRequired: return "Upgrade Required"
        case .preconditionRequired: return "Precondition Required"
        case .tooManyRequests: return "Too Many Requests"
        case .requestHeaderFieldsTooLarge: return "Request Header Fields Too Large"
        case .unavailableForLegalReasons: return "Unavailabe For Legal Reasons"
        case .clientClosedRequest: return "Client Closed Request"
        case .internalServerError: return "Internal Server Error"
        case .notImplemented: return "Not Implemented"
        case .badGateway: return "Bad Gateway"
        case .serviceUnavailable: return "Service Unavailable"
        case .gatewayTimeout: return "Gateway Timeout"
        case .httpVersionNotSupported: return "HTTP Version Not Supported"
        case .variantAlsoNegotiates: return "Variant Also Negotiates"
        case .insufficientStorage: return "Insufficient Storage"
        case .loopDetected: return "Loop Detected"
        case .notExtended: return "Not Extended"
        case .networkAuthenticationRequired: return "Network Authentication Required"
        }
    }
    
    var responseDefinition: String {
        switch self {
        case .`continue`: return "The server has received the request headers and the client should proceed to send the request body (in the case of a request for which a body needs to be sent; for example, a POST request). Sending a large request body to a server after a request has been rejected for inappropriate headers would be inefficient. To have a server check the request's headers, a client must send Expect: 100-continue as a header in its initial request and receive a 100 Continue status code in response before sending the body. If the client receives an error code such as 403 (Forbidden) or 405 (Method Not Allowed) then it shouldn't send the request's body. The response 417 Expectation Failed indicates that the request should be repeated without the Expect header as it indicates that the server doesn't support expectations (this is the case, for example, of HTTP/1.0 servers)."
        case .switchingProtocols: return "The requester has asked the server to switch protocols and the server has agreed to do so."
        case .processing: return "A WebDAV request may contain many sub-requests involving file operations, requiring a long time to complete the request. This code indicates that the server has received and is processing the request, but no response is available yet. This prevents the client from timing out and assuming the request was lost."
        case .ok: return "Standard response for successful HTTP requests. The actual response will depend on the request method used. In a GET request, the response will contain an entity corresponding to the requested resource. In a POST request, the response will contain an entity describing or containing the result of the action."
        case .created: return "The request has been fulfilled, resulting in the creation of a new resource."
        case .accepted: return "The request has been accepted for processing, but the processing has not been completed. The request might or might not be eventually acted upon, and may be disallowed when processing occurs."
        case .nonAuthoritativeInformation: return "The server is a transforming proxy (e.g. a Web accelerator) that received a 200 OK from its origin, but is returning a modified version of the origin's response."
        case .noContent: return "The server successfully processed the request and is not returning any content."
        case .resetContent: return "The server successfully processed the request, but is not returning any content. Unlike a 204 response, this response requires that the requester reset the document view."
        case .partialContent: return "The server is delivering only part of the resource (byte serving) due to a range header sent by the client. The range header is used by HTTP clients to enable resuming of interrupted downloads, or split a download into multiple simultaneous streams."
        case .multiStatus: return "The message body that follows is by default an XML message and can contain a number of separate response codes, depending on how many sub-requests were made."
        case .alreadyReported: return "The members of a DAV binding have already been enumerated in a preceding part of the (multistatus) response, and are not being included again."
        case .iMUsed: return "The server has fulfilled a request for the resource, and the response is a representation of the result of one or more instance-manipulations applied to the current instance."
        case .multipleChoices: return "Indicates multiple options for the resource from which the client may choose (via agent-driven content negotiation). For example, this code could be used to present multiple video format options, to list files with different filename extensions, or to suggest word-sense disambiguation."
        case .movedPermanently: return "This and all future requests should be directed to the given URI."
        case .found: return "Tells the client to look at (browse to) another url. 302 has been superseded by 303 and 307. This is an example of industry practice contradicting the standard. The HTTP/1.0 specification (RFC 1945) required the client to perform a temporary redirect (the original describing phrase was \"Moved Temporarily\"), but popular browsers implemented 302 with the functionality of a 303 See Other. Therefore, HTTP/1.1 added status codes 303 and 307 to distinguish between the two behaviours. However, some Web applications and frameworks use the 302 status code as if it were the 303"
        case .seeOther: return "The response to the request can be found under another URI using the GET method. When received in response to a POST (or PUT/DELETE), the client should presume that the server has received the data and should issue a new GET request to the given URI."
        case .notModified: return "Indicates that the resource has not been modified since the version specified by the request headers If-Modified-Since or If-None-Match. In such case, there is no need to retransmit the resource since the client still has a previously-downloaded copy."
        case .useProxy: return "The requested resource is available only through a proxy, the address for which is provided in the response. Many HTTP clients (such as Mozilla and Internet Explorer) do not correctly handle responses with this status code, primarily for security reasons."
        case .switchProxy: return "No longer used. Originally meant \"Subsequent requests should use the specified proxy.\""
        case .temporaryRedirect: return "In this case, the request should be repeated with another URI; however, future requests should still use the original URI. In contrast to how 302 was historically implemented, the request method is not allowed to be changed when reissuing the original request. For example, a POST request should be repeated using another POST request."
        case .permanentRedirect: return "The request and all future requests should be repeated using another URI. 307 and 308 parallel the behaviors of 302 and 301, but do not allow the HTTP method to change. So, for example, submitting a form to a permanently redirected resource may continue smoothly."
        case .badRequest: return "The server cannot or will not process the request due to an apparent client error (e.g., malformed request syntax, size too large, invalid request message framing, or deceptive request routing)."
        case .unauthorized: return "Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided. The response must include a WWW-Authenticate header field containing a challenge applicable to the requested resource. 401 semantically means \"unauthenticated\", i.e. the user does not have the necessary credentials."
        case .paymentRequired: return "Reserved for future use. The original intention was that this code might be used as part of some form of digital cash or micropayment scheme, as proposed for example by GNU Taler, but that has not yet happened, and this code is not usually used."
        case .forbidden: return "The request was valid, but the server is refusing action. The user might not have the necessary permissions for a resource, or may need an account of some sort."
        case .notFound: return "The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible."
        case .methodNotAllowed: return "A request method is not supported for the requested resource; for example, a GET request on a form that requires data to be presented via POST, or a PUT request on a read-only resource."
        case .notAcceptable: return "The requested resource is capable of generating only content not acceptable according to the Accept headers sent in the request."
        case .proxyAuthenticationRequired: return "The client must first authenticate itself with the proxy."
        case .requestTimeout: return "The server timed out waiting for the request. According to HTTP specifications: \"The client did not produce a request within the time that the server was prepared to wait. The client MAY repeat the request without modifications at any later time.\""
        case .conflict: return "Indicates that the request could not be processed because of conflict in the current state of the resource, such as an edit conflict between multiple simultaneous updates."
        case .gone: return "Indicates that the resource requested is no longer available and will not be available again. This should be used when a resource has been intentionally removed and the resource should be purged. Upon receiving a 410 status code, the client should not request the resource in the future."
        case .lengthRequired: return "The request did not specify the length of its content, which is required by the requested resource."
        case .preconditionFailed: return "The server does not meet one of the preconditions that the requester put on the request."
        case .payloadTooLarge: return "The request is larger than the server is willing or able to process. Previously called \"Request Entity Too Large\"."
        case .uriTooLong: return "The URI provided was too long for the server to process. Often the result of too much data being encoded as a query-string of a GET request, in which case it should be converted to a POST request. Called \"Request-URI Too Long\" previously."
        case .unsupportedMediaType: return "The request entity has a media type which the server or resource does not support."
        case .rangeNotSatisfiable: return "The client has asked for a portion of the file (byte serving), but the server cannot supply that portion. For example, if the client asked for a part of the file that lies beyond the end of the file. Called \"Requested Range Not Satisfiable\" previously."
        case .expectationFailed: return "The server cannot meet the requirements of the Expect request-header field."
        case .imATeapot: return "This code was defined in 1998 as one of the traditional IETF April Fools' jokes, in RFC 2324, Hyper Text Coffee Pot Control Protocol, and is not expected to be implemented by actual HTTP servers. The RFC specifies this code should be returned by teapots requested to brew coffee. This HTTP status is used as an Easter egg in some websites, including Google.com."
        case .misdirectedRequest: return "The request was directed at a server that is not able to produce a response (for example because of connection reuse)."
        case .unprocessableEntity: return "The request was well-formed but was unable to be followed due to semantic errors."
        case .locked: return "The resource that is being accessed is locked."
        case .failedDependency: return "The request failed because it depended on another request and that request failed (e.g., a PROPPATCH)."
        case .upgradeRequired: return "The client should switch to a different protocol such as TLS/1.0, given in the Upgrade header field."
        case .preconditionRequired: return "The origin server requires the request to be conditional. Intended to prevent the 'lost update' problem, where a client GETs a resource's state, modifies it, and PUTs it back to the server, when meanwhile a third party has modified the state on the server, leading to a conflict."
        case .tooManyRequests: return "The user has sent too many requests in a given amount of time. Intended for use with rate-limiting schemes."
        case .requestHeaderFieldsTooLarge: return "The server is unwilling to process the request because either an individual header field, or all the header fields collectively, are too large."
        case .unavailableForLegalReasons: return "A server operator has received a legal demand to deny access to a resource or to a set of resources that includes the requested resource."
        case .clientClosedRequest: return "A non-standard status code introduced by nginx for the case when a client closes the connection while nginx is processing the request."
        case .internalServerError: return "A generic error message, given when an unexpected condition was encountered and no more specific message is suitable."
        case .notImplemented: return "The server either does not recognize the request method, or it lacks the ability to fulfil the request. Usually this implies future availability (e.g., a new feature of a web-service API)."
        case .badGateway: return "The server was acting as a gateway or proxy and received an invalid response from the upstream server."
        case .serviceUnavailable: return "The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a temporary state."
        case .gatewayTimeout: return "The server was acting as a gateway or proxy and did not receive a timely response from the upstream server."
        case .httpVersionNotSupported: return "The server does not support the HTTP protocol version used in the request."
        case .variantAlsoNegotiates: return "Transparent content negotiation for the request results in a circular reference."
        case .insufficientStorage: return "The server is unable to store the representation needed to complete the request."
        case .loopDetected: return "The server detected an infinite loop while processing the request (sent in lieu of 208 Already Reported)."
        case .notExtended: return "Further extensions to the request are required for the server to fulfill it."
        case .networkAuthenticationRequired: return "The client needs to authenticate to gain network access. Intended for use by intercepting proxies used to control access to the network (e.g., \"captive portals\" used to require agreement to Terms of Service before granting full Internet access via a Wi-Fi hotspot)."
        }
    }
}
