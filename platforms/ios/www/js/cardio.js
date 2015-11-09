/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

var app = {
    // Application Constructor
initialize: function() {
    this.bindEvents();
},
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
bindEvents: function() {
    document.addEventListener('deviceready', this.onDeviceReady, false);
},
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
onDeviceReady: function() {
    //alert("AMI RESTART HOYCHI BOSS");
    app.receivedEvent('deviceready');
},
    // Update DOM on a Received Event
receivedEvent: function(id) {
    var parentElement = document.getElementById(id);
    var listeningElement = parentElement.querySelector('.listening');
    var receivedElement = parentElement.querySelector('.received');
    
    listeningElement.setAttribute('style', 'display:none;');
    receivedElement.setAttribute('style', 'display:block;');
    
    console.log('Received Event: ' + id);
    
    app.example();
},
    
    example : function () {
        var cardIOResponseFields = [
                                    "card_type",
                                    "redacted_card_number",
                                    "card_number",
                                    "expiry_month",
                                    "expiry_year",
                                    "cvv",
                                    "zip"
                                    ];
        
        var onCardIOComplete = function(response) {
            console.log("card.io scan complete");
            for (var i = 0, len = cardIOResponseFields.length; i < len; i++) {
                var field = cardIOResponseFields[i];
                console.log(field + ": " + response[field]);
            }
        };
        
        var onCardIOCancel = function() {
            console.log("card.io scan cancelled");
        };
        var onCardIOCheck = function (canScan) {
            console.log("card.io canScan? " + canScan);
            var scanBtn = document.getElementById("scanBtn");
            if (!canScan) {
                scanBtn.innerHTML = "Manual entry";
            }
            scanBtn.onclick = function (e) {
                
                CardIO.scan({
                            "collect_expiry": true,
                            "collect_cvv": true,
                            "collect_zip": true,
                            "shows_first_use_alert": true,
                            "disable_manual_entry_buttons": false
                            },
                            onCardIOComplete,
                            onCardIOCancel
                            );
            }
        };
        
        CardIO.canScan(onCardIOCheck);
    }
};

app.initialize();