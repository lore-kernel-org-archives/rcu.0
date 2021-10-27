Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2EC433F5
	for <rcu@archiver.kernel.org>; Wed, 27 Oct 2021 05:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C46B61073
	for <rcu@archiver.kernel.org>; Wed, 27 Oct 2021 05:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbhJ0F2A (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 27 Oct 2021 01:28:00 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:30228 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239443AbhJ0F17 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 27 Oct 2021 01:27:59 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 01:27:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1635312335; x=1666848335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eLt2ph1XJMMi5DJci2fRwt+0kjtwkRWr8M32Re7wcjE=;
  b=c9rwR5zQUcXZZMyl/SuVMtcPu3I7++pHEjzcER2e9E1QP+3Q77Bq+yVs
   bVdPE564tYTD6D9JHHGuflbKsVCU8dxvaFVegXMuSYaZWjY3Z66Kheoy0
   3CcZLVmqtcBcOHfDcG12hAVrzQ1CnsflmcziNTw/gg3BBAuyZMErdbceF
   FIKBmqT0aR+PQxTr1x3p8W8BWhROTYhZ4rHG/nMd2mGAhG0qHHG84322y
   6GijL5Xd+j5vzzlUFRWCdaUKSdmSkCrJh5usi+3FE8EBPrlHuaKNPL3hW
   RCn4IiwQs4alqrDRnCxpyrlF3ddNV3mJpXrJWJ9J0jfPTvmwYXowG6Tnq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="50472357"
X-IronPort-AV: E=Sophos;i="5.87,186,1631545200"; 
   d="scan'208";a="50472357"
Received: from mail-ty1jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 14:18:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1GAglhAqFEszhzAfT7mPaFofl5Y4mCs6tY7SpsM8Ak3fHdQU68NOHnl5DocIz6TWlkH8AiFeBe7U1faNgylw3qcK9Xa2BRuEC49499G/J5hZI7nBR0pj/Bw1yeKDNVzSt5NoJqPT+xQyF+0kB3WT+o/Qv3ZWotvR3Z0JWju3RzcD2CPlq6QwlgOD95aWo0rHy7FF62yQKbYAEoTW31K4yfLUkeQzhyBE2VxfaX+c0wPANw6j8kYdCUjRMvXQVf/3OaFviHfHBT8+cNmzLH+hHquhwAxZ9N26ig/geUrGGB62S51HZbGlXNVecetCDo+fcp5YbMX2X/hVXxPmIFAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLt2ph1XJMMi5DJci2fRwt+0kjtwkRWr8M32Re7wcjE=;
 b=NIzdC1hkRQC6JidnkFW0AoBToSYVrYUeSxGyLn/nki9FOuhduxTr1rkI+0svPJG54HjdqB4VkzsanU7H/G7Hqqbf2GhM+xOn1tVa+mw/SHK66Rs1pt3mvHAm4HqufS0+YIGM8XcwaNQabYnsYKOmic3hJ9bUaDWLmQIo70fSDnW+Vfc9oWh1YcOduh3c0zAG2LPx1R325ZywQ8SW+CgOV05gTVOBim1K4dMI08SnXV8SrA/PqC1jdPIElx47O7oqcX9t7ipirjZcNp1zyFlNCyenR3dtZF1abRjEOWUNpEhAQJNdPsej5UbHT/1P9hCUf3AQJtL+DlS6vWX3+hyczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLt2ph1XJMMi5DJci2fRwt+0kjtwkRWr8M32Re7wcjE=;
 b=Qrju+SOX1GBb46K7Q+Ao1xcK8XqV79fSWrX9QOde3xbPszOZFMaEN8pVboJzy0JfBNBIkb+ZArl/Ade/R5CdmZ7ckJ0AekWJOIwwfIuwms5HNil925YnZlbwGRD1f40Ucba6EFJnwHhqAkJd7YiMcxS+2GhKLqqazNCJsJgklvM=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OS3PR01MB7708.jpnprd01.prod.outlook.com (2603:1096:604:179::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 05:18:18 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::9401:db52:496:51]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::9401:db52:496:51%8]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 05:18:18 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] refscale: always log the error message
Thread-Topic: [PATCH 3/3] refscale: always log the error message
Thread-Index: AQHXyVBk4kxOMAbyS0O7hS7+JBuTPKvjO7yAgAIW/gCAAP54gA==
Date:   Wed, 27 Oct 2021 05:18:18 +0000
Message-ID: <0c9868b6-a143-b098-aa0d-bf525f32ed8c@fujitsu.com>
References: <20211025032658.22889-1-lizhijian@cn.fujitsu.com>
 <20211025032658.22889-3-lizhijian@cn.fujitsu.com>
 <5f4c53e4-34aa-98f6-343f-0de18df830f2@fujitsu.com>
 <20211026140632.GV880162@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211026140632.GV880162@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6d542d6-dacc-48ef-7c83-08d999092fc2
x-ms-traffictypediagnostic: OS3PR01MB7708:
x-microsoft-antispam-prvs: <OS3PR01MB7708A7241CE4961079AA2281A5859@OS3PR01MB7708.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8exxaniL2rk3r+F/hDHo/nFIldO+S13Y2HgjOVn4RIEPHvJJLK/djFguyCYnuM5P5uoF5QnV7fieSVRlv6D956GsYMYE8qRJBs6iR0l7mw6T3EAmwWWmO40cZuYGYfBsJK6rVAx3A3V06aKBXXzuYKYt8yVEr6YOMXplcfc4FFO/UooxaeiOf2A1Sluhfwjkv/RLre/4BLZsaqKgp0PSqq+5PEVImnvVQzVDxekZrsMsVsX9RvWqCwQFwHCaddcYq1ydXpF4I1ueI28PNXRQUSa8waLKuqjMDxbLcZGCBJHyYUCpNimttsyIlJX4cEuWg0Izvvd4BXMBafs4t02wzNFlj15ptkbiTiOUMohTMC8+NCDa2XzGbpwJh63mOQyy5OneLyhqhIEdVf4nmwP0KTUTavzkM7/b+jTPJJ7TajRpSWcSnQHm0hNzsNT5kXl34vxx3ZVnAp35L7EMxSRzDYC+y+oZd7ze+1Ij48Y0BUkYYJ18XEw3y+QENMCT67NEcRMNIxUWBTIjmXLrVXfACP1bDe9uIOzbPg/J0ag2q9+bYgC77WkZAhZXsuhKq/jNCXBCnAzwjelIDu5ALSLSBtLdDNwueAx64jAbVhmH2jdahLbyxbkG7UMiveGSmc5X+0g+b6ur5g9cA7F4xPOuqlQt2cth3zr8vh4JvrDcJQXtXl5Q0uQzI86NqmBhZmNj29kUBov9uure3u1877WAYE5k5XA1LsqCQeJWMjFSh29eAkiiAGcd1XHRGWZGCDctb8eTHrKTB2+SqUXUFsVMGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(66946007)(66446008)(64756008)(2906002)(5660300002)(91956017)(66556008)(83380400001)(8936002)(53546011)(66476007)(8676002)(6512007)(54906003)(4326008)(86362001)(186003)(508600001)(36756003)(15650500001)(31686004)(76116006)(26005)(6486002)(71200400001)(38070700005)(6916009)(82960400001)(2616005)(6506007)(85182001)(38100700002)(316002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3U0M2l3OEdNaWcvN2dJV0xGVnJzdXNSY2tJSjVkUk1aOHNkdmc5N282OE5U?=
 =?utf-8?B?cTM3NWJTMHV3VHhibk4yMUF5eis3dXNqZ3pjQWE3cENDUjMvSTl3VkJROUlV?=
 =?utf-8?B?YVZzUXdoS0NHOHZLeXN3REZFOEhnc3RBUkFqNExJNWs3K3FXTm5VcGtrM1pJ?=
 =?utf-8?B?VENvT3k3RHVJWkpPYWZ0RlBnMm82MGRMRENHTlhoeFBrQ01vUFJILzhFT29t?=
 =?utf-8?B?WnVFOUI4K0Q3VjVZVmdJZGJNZ09PVHAxMVNZUlpSZVJWNG5OSTQ4eDI0ZVoy?=
 =?utf-8?B?V3Z5QzdEb0JtTGxHV2dVcG1CZ0t1alVOc21zSmM0UXV1UlNuVUlVb014YkxQ?=
 =?utf-8?B?ckVIdzlKZUZaSnAxSFlTNjBMZmNkSkNGNnl4Q1BJellPZnlZbkZ3UWxsdFQ4?=
 =?utf-8?B?TGI3M0JGR281YWphNE8wRWUwaG5Vcmw2SGRHT2NyMUdNN205WjU2TVVjcHBC?=
 =?utf-8?B?OVZTdE5ZT1k3NWY5akxuZlhlb0I5TXlBMVFmOGV5YVhuQTYxbktwK3JaNUtj?=
 =?utf-8?B?VWppVGZQSktEMENQSHZXa3FmdlVaOUxoQkdjcnJFeVg3aVBZNHF3cEJqQnZE?=
 =?utf-8?B?Z0RTVjhINWhMQkdaSW1LSG8vWkVJTlNzdklxNWVKUHZySm0xQVlZRGZoaW5X?=
 =?utf-8?B?dGl0Q3drbWc5czNjazkxdFdVa0Z0QmhxWlIvS0JMSU81ZTNvS2o0SXQ4aTVp?=
 =?utf-8?B?cy9TU2R6UTRqYTh3U1B4aEFia2VmcHBhN29Uc3ZzZVZOTmtaOHpiT1ZXbmVG?=
 =?utf-8?B?OUFNQUVDakh4QVZBNkxzekFyY252VjZRRlZ0TjRrOVpLREtXNFN5anZEamkr?=
 =?utf-8?B?SjlRZm5rVVZicmpNb2xQczFTeWZZRks4ZFpBN25KeVc3ajk0dXB0OVBCVWM0?=
 =?utf-8?B?Y2pESGx2ZnRoUFB3Z2F4QU4zeTZvQm93MFJRVWhIOHNBR3h3NWRwTDhEaFR4?=
 =?utf-8?B?SjlsSTZITGpPR1daNVZ0bEVDY1F6NG4rbjdISGhHR2hpckhTa2VYS3BON213?=
 =?utf-8?B?U0liNVJ1aHJnWnNFZDBXZVJsVlRoVmFDNDRiVEVsdXVwaDZ5MkFxZmFKcXMy?=
 =?utf-8?B?TE5wK21lQzdvenR0bjRZc1JLUXNUWnhLcjRSRm52aGhLYUg0MHJoeHc2NEdW?=
 =?utf-8?B?S3pIeVFwV2JhYzR3QjNaVHJXbTBmbGlxVEVrWGlIcFAzUTRNeE52RWRxdk11?=
 =?utf-8?B?UTFqU0hSL2FHc3lKbXBpUlVPbjVjeDN5SmErbWt6aHhnL0x5ODZiWk5Zb0My?=
 =?utf-8?B?ZHR5bXFnQStBVklYb1N3TEtHai9XdWRyRytlVEwyZDVXalZyNnNFMGJ6L0lL?=
 =?utf-8?B?bUYySGlrTVRsQ1VrTTBQUEJxTGR4OFNQN2FJOFpnNnM5ZlFVWU95ZVFMWHJN?=
 =?utf-8?B?bXJQV1V6RWN6NmpOZnBTS2dnYWZpWUg1NWxVRjJEZXdMUEgxdlNHTkFrY1ln?=
 =?utf-8?B?dDVpRkxUUGRBQ21OS1NzMnhlVHBtVlladW9EbE9WQVJsTVZaQkk3ZDZuR28x?=
 =?utf-8?B?K29GZ3E1YWtlWXZINVMyVVVoejhHZElRUmR5YVBkMlpwNWgyNVZiUk5UaStX?=
 =?utf-8?B?cklPdmZrdVlqRE96UzJKNWFqVGF3TG9WTElnRE1GdlVISGVDYjBUdHJXZWlQ?=
 =?utf-8?B?NUFOamRLYlpQS0t1WTlOUm8yYmZQVGQ5dUNDa2htWFVLQzZUYWRkMmNSSnJG?=
 =?utf-8?B?ZE9IMlkxZGZCOTlLdnBUNmFjN1VKdmh3NG9UZHJTbDBnamoyZWxmelE5L0U2?=
 =?utf-8?B?cmtCS3hoUHZOQTF1MHdZcjRmNTRWWVoyKytSMlhpalZnUEhpaER5bEZHY1lK?=
 =?utf-8?B?RkFBTU1YcThPSDB6dnB4d0ZlUnpjZHk2U0N4NmtuZCtiM2VmNEhDbXZic0pR?=
 =?utf-8?B?VHBjUlU5Nm1zOXZSR3FWZ1BVTVZPOWZOWEttV1hEd01aQzVtdHBaZ25RM084?=
 =?utf-8?B?SVcvZFgzVEJGRjBqV2JmcU5XdWNJWkdVV3NSSm16c0EzMEZ4emRhV3dqYVF0?=
 =?utf-8?B?bytvV2JmY0pzVTZjNE1xalVjSC83QUJzTmxtUG9wRlk1Skt4ZGhqTEhVYk5m?=
 =?utf-8?B?VWc3OFc4WWQvRXBBSFZEOVNlNFlMMFo4K2FaSUJqSkFSUVo4dVpUWCtPTGdq?=
 =?utf-8?B?OWdRclY5c0FaaEZyU2VRZnRVN1dHWDBWSHZTRS9FVG5QbG5teSs2clhQSmti?=
 =?utf-8?Q?GSBiigq2G47zJXxjlFDNYCA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63C1B21B17926A4AAF55D70E9A34A347@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d542d6-dacc-48ef-7c83-08d999092fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 05:18:18.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuxS5Xlr8tGJY7Zhv/NiLuenRHGjaKZbrSkAXQfjw5ehV+K5QBbwDMZ1wqleC7gAE+j0tnSVKWIFHQPIG6csxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7708
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

DQoNCk9uIDI2LzEwLzIwMjEgMjI6MDYsIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+IE9uIE1v
biwgT2N0IDI1LCAyMDIxIGF0IDA2OjEyOjQwQU0gKzAwMDAsIGxpemhpamlhbkBmdWppdHN1LmNv
bSB3cm90ZToNCj4+DQo+PiBPbiAyNS8xMC8yMDIxIDExOjI2LCBMaSBaaGlqaWFuIHdyb3RlOg0K
Pj4+IEdlbmVyYWxseSwgZXJyb3IgbWVzc2FnZSBzaG91bGQgYmUgbG9nZ2VkIGFueWhvdy4NCj4+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNv
bT4NCj4+PiAtLS0NCj4+PiAgICBrZXJuZWwvcmN1L3JlZnNjYWxlLmMgfCA4ICsrKystLS0tDQo+
Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3JlZnNjYWxlLmMgYi9rZXJuZWwvcmN1L3Jl
ZnNjYWxlLmMNCj4+PiBpbmRleCBhNDQ3OWYwMGRjZGMuLmYwNTVkMTY4MzY1YSAxMDA2NDQNCj4+
PiAtLS0gYS9rZXJuZWwvcmN1L3JlZnNjYWxlLmMNCj4+PiArKysgYi9rZXJuZWwvcmN1L3JlZnNj
YWxlLmMNCj4+PiBAQCAtNTgsOCArNTgsOCBAQCBkbyB7CQkJCQkJCQkJCQlcDQo+Pj4gICAgCX0J
CQkJCQkJCQkJXA0KPj4+ICAgIH0gd2hpbGUgKDApDQo+Pj4gICAgDQo+Pj4gLSNkZWZpbmUgVkVS
Qk9TRV9TQ0FMRU9VVF9FUlJTVFJJTkcocywgeC4uLikgXA0KPj4+IC0JZG8geyBpZiAodmVyYm9z
ZSkgcHJfYWxlcnQoIiVzIiBTQ0FMRV9GTEFHICIhISEgIiBzLCBzY2FsZV90eXBlLCAjIyB4KTsg
fSB3aGlsZSAoMCkNCj4+PiArI2RlZmluZSBTQ0FMRU9VVF9FUlJTVFJJTkcocywgeC4uLikgXA0K
Pj4+ICsJZG8geyBwcl9hbGVydCgiJXMiIFNDQUxFX0ZMQUcgIiEhISAiIHMsIHNjYWxlX3R5cGUs
ICMjIHgpOyB9IHdoaWxlICgwKQ0KPj4+ICAgIA0KPj4+ICAgIE1PRFVMRV9MSUNFTlNFKCJHUEwi
KTsNCj4+PiAgICBNT0RVTEVfQVVUSE9SKCJKb2VsIEZlcm5hbmRlcyAoR29vZ2xlKSA8am9lbEBq
b2VsZmVybmFuZGVzLm9yZz4iKTsNCj4+PiBAQCAtNjUxLDcgKzY1MSw3IEBAIHN0YXRpYyBpbnQg
bWFpbl9mdW5jKHZvaWQgKmFyZykNCj4+PiAgICAJcmVzdWx0X2F2ZyA9IGt6YWxsb2MobnJ1bnMg
KiBzaXplb2YoKnJlc3VsdF9hdmcpLCBHRlBfS0VSTkVMKTsNCj4+PiAgICAJYnVmID0ga3phbGxv
Yyg4MDAgKyA2NCwgR0ZQX0tFUk5FTCk7DQo+Pj4gICAgCWlmICghcmVzdWx0X2F2ZyB8fCAhYnVm
KSB7DQo+Pj4gLQkJVkVSQk9TRV9TQ0FMRU9VVF9FUlJTVFJJTkcoIm91dCBvZiBtZW1vcnkiKTsN
Cj4+PiArCQlTQ0FMRU9VVF9FUlJTVFJJTkcoIm91dCBvZiBtZW1vcnkiKTsNCj4+ICdcbicgc2hv
dWxkIGJlIGFkZGVkIHRvIHRoZSBsYXN0IHRvIGZsdXNoIGl0Lg0KPiBBbmQgdGhlcmUgbWlnaHQg
d2VsbCBiZSBvdGhlciBtaXNzaW5nICJcbiIgaW5zdGFuY2VzIGluIHNpbWlsYXIgbWVzc2FnZXMN
Cj4gaW4gcmN1c2NhbGUuYywgcmN1dG9ydHVyZS5jLCBzY2Z0b3J0dXJlLmMsIGxvY2t0b3J0dXJl
LmMsIGFuZCB0b3J0dXJlLmMuDQo+IFBsZWFzZSBmZWVsIGZyZWUgdG8gc2VuZCBhIHBhdGNoIGZv
ciBlYWNoIGZpbGUgbmVlZGluZyB0aGlzIGhlbHAuDQoNClN1cmUsIGkgd2lsbCBkbyB0aGF0Lg0K
DQpUaGFua3MNClpoaWppYW4NCg0KPiBJIHF1ZXVlZCB5b3VyIG90aGVyIHRocmVlIHBhdGNoZXMg
Zm9yIHY1LjE3IChub3QgdGhpcyBjb21pbmcgbWVyZ2Ugd2luZG93LA0KPiBidXQgdGhlIG9uZSBh
ZnRlciB0aGF0KSwgdGhhbmsgeW91ISAgSSBkaWQgd29yZHNtaXRoIHRoZSBjb21taXQgbG9ncywN
Cj4gc28gcGxlYXNlIGNoZWNrIHRvIHNlZSBpZiBJIG1lc3NlZCBhbnl0aGluZyB1cC4NCj4NCj4g
CQkJCQkJCVRoYW54LCBQYXVsDQo+DQo+Pj4gICAgCQlnb3RvIG9vbV9leGl0Ow0KPj4+ICAgIAl9
DQo+Pj4gICAgCWlmIChob2xkb2ZmKQ0KPj4+IEBAIC04MzcsNyArODM3LDcgQEAgcmVmX3NjYWxl
X2luaXQodm9pZCkNCj4+PiAgICAJcmVhZGVyX3Rhc2tzID0ga2NhbGxvYyhucmVhZGVycywgc2l6
ZW9mKHJlYWRlcl90YXNrc1swXSksDQo+Pj4gICAgCQkJICAgICAgIEdGUF9LRVJORUwpOw0KPj4+
ICAgIAlpZiAoIXJlYWRlcl90YXNrcykgew0KPj4+IC0JCVZFUkJPU0VfU0NBTEVPVVRfRVJSU1RS
SU5HKCJvdXQgb2YgbWVtb3J5Iik7DQo+Pj4gKwkJU0NBTEVPVVRfRVJSU1RSSU5HKCJvdXQgb2Yg
bWVtb3J5Iik7DQo+PiBkaXR0bw0KPj4NCj4+IFRoYW5rcw0KPj4gWmhpamlhbg0KPj4+ICAgIAkJ
Zmlyc3RlcnIgPSAtRU5PTUVNOw0KPj4+ICAgIAkJZ290byB1bndpbmQ7DQo+Pj4gICAgCX0NCg==
