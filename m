Return-Path: <SRS0=zZsG=CY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BABC43461
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 03:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBB7208DB
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 03:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="EXPOtgDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIODTE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Sep 2020 23:19:04 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:62304
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbgIODS2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tdw+Z9WHXgHy2FqpKHS++XxQqa6qx6hO8YeKJVRisPgpmI8wswp88k0BcMt1+BDM6fRCP03TcsC+OK0W4CUicA3ARmF21LuqtYrq/ZNy4itsvJdCO0g9SjbpqaeSXkU/Q2ifCGKiPg8s2aExquP4QW6EoEgbcD9RCEJmkcW8nwzv7Jd7+5V0F8H3gts/3jpFsFNd/8JBE/fwJVcFpAJpZ8Z35Xx/nfKw7QnmRPtglzHDZU1T7Cxyxpyemm2km5648AGu8krsDd2ZUqQNuZOrZ4hiQ3IDB2Zmt62fI22I5ofQMDGs5fmyWbnEw8osKbnMCZVEmjTh6zg2M5fvFmb6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdHKs6HC+0sfe0Rxk870liWnMB41l/3HASoNmBZkBhw=;
 b=XrxW7ZE9XhTeOM68xn7wAYQYbwd2p4zDNMPTuZoIeF2BrVtmackpGNzByGRE7Pq9iOCrl55QY9UkI76gI7zEH8OApYM9mdPX+oXgiBCxN61vRbKqES/M+I2lcUclBY8eDWXrlA3dEOSG8MehBzVk4A0+LYLMn9m2OW5gideQSmmJwQ2rsDbDwr3BZDw7OnQq9qizqkOgNzVUYK7jUkL7FRo+9R+nbXJKTbOqka6B9KmbTN7YVCV0IoVz1wu5acUBzOvFkhyl5EPXNdbo4Sf3yX5j7N3P0DOUQ/TCdKYSRgOpX+Ma9SKSOnav/hYWWhVc7fZWGRmu2VE6ktGjThl+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdHKs6HC+0sfe0Rxk870liWnMB41l/3HASoNmBZkBhw=;
 b=EXPOtgDAdTFYoz+i/P6yPYbISW2oE3gnBgRB0a/XWJtTVRa73bEOwC9/jHyOJQ+7vh7gO3doaBQwgLS/7byo0DVuKhxNs/axsj8w8JPGe0KfQwEAQRb53XgYS+XOUtp0c72EpMZJ/yDrZFJpJwfG8UjEu0fWZQqnS0QCo2D3vas=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4228.namprd11.prod.outlook.com (2603:10b6:a03:1bd::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 03:18:24 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 03:18:24 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
CC:     Uladzislau Rezki <urezki@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogUkNVOiBRdWVzdGlvbiBvbiBmb3JjZV9xc19ybnA=?=
Thread-Topic: RCU: Question on force_qs_rnp
Thread-Index: AQHWimIP0LPCKhgtykWT7yuEklGOu6loiX8AgAAU1QCAAGeTxQ==
Date:   Tue, 15 Sep 2020 03:18:23 +0000
Message-ID: <BYAPR11MB263207BFF3AFB6A9D1A7A32FFF200@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200914194208.GA2579423@google.com>,<20200914205642.GE29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200914205642.GE29330@paulmck-ThinkPad-P72>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 370f35c7-c0de-4898-8163-08d85926017c
x-ms-traffictypediagnostic: BY5PR11MB4228:
x-microsoft-antispam-prvs: <BY5PR11MB42282295E521B25E0AD3177CFF200@BY5PR11MB4228.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o+cAZC+x9RdhOrHjzo9dmWG9fQ5YkQ0EyXJS7eQ7g7oARHazDV0JYZfl5kwfn4VNoIIE8GvOQhogI7GQ9paehB5rW11e9OAOM07GeNE8w/1w/J+erTwh2ow28R/tqqoZ7a3XJkewa4uWDrtMgca4T141uvJ7htnCXgE43RdeIFU/n3O0ykuQAgZVled6uupL7M0mWeS6Hqh+zQTUtJo0IO+UVT0yd0qZdkzbW06KvnODmUQ3jxznW7L5lrYyNZzlTpeOIEc7l5JGV0ej5ex1GogyX67QkD71hDb7zwFXqNWBIz/fUAXBYU+YVs7lYQRGF/K3jSLKMfLG6GskV0F/fUBAY0+vd2IP2KXGrQ+wds0ejGLLL7Y8OaqTyNx+pFBn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(346002)(396003)(136003)(26005)(478600001)(110136005)(4326008)(9686003)(76116006)(8936002)(91956017)(316002)(66946007)(5660300002)(66476007)(66446008)(55016002)(64756008)(66556008)(186003)(86362001)(7696005)(224303003)(71200400001)(54906003)(33656002)(2906002)(6506007)(52536014)(83380400001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1mtrmlDFY5X8UrZw8u1igSvlJ14Hun58ss+A1ACnFTABaX2uHr8lRjkBjjtRcDhcV7PX9pog5ICDQv7guglF8yWiG6ggrbkQSsnOnuwVm0pzoxT/hYTY4eNw6lPCqUg6F7Sz2u1VJpt7QqI/AGuVLu5hNlhGBk735jIdcMXcxUEvixUjAx+4RcSGZAmkXvL7mHX2YE7DemJcrxRYxOhVf8ooWgRarNFH7SKDClrxLZP/NunBBv48G3MgD8loqQfHDKDedX9q8BZCazwR02KHbyBzfRckrCLGjGjfxsjr62+bACBd8KYaqDd0zcmSU1yvGdd+iL5QOCOILcxCX4TEAfQ56P+AOhCilUU6PwSa7kOdcnZ2yZPQs1zKq6sfdCN2xhHef5RgsiluWOPdGN5chWDNbZa11R+AmIetO9vsiSAadcyBtocXxNLHRTaHa1PsvGaKydAwu/O9C/uO31bFfj/FlJ7s/nVnR2y6xa/Z/UYuI6VDi1pnfYSTQgArYB+sn025HoQo4XJJZGautdfRaAoxFeJt+0Kfc2WK0baK44ij9dCCqJ87cY7+5PCtmVleuIJ+D/MeRYeV9o4lOSQRGEng79cAw6QbhjbqpQOq/LiiL3pGdcsyGqYNR23YpQXzWu8Mzh5tB2F56sNtum4NfA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370f35c7-c0de-4898-8163-08d85926017c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 03:18:23.8592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bF9DXra+KXF66nWckze2ZuRKNpKBJQepL6LSoOwJGdtRxWUGBs3kE3BelZp7mOyjVZa9+7mVgKPsAEtEDREzk2w10OG7bJS7D4ArMS0Fguw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4228
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUGF1bCBF
LiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPgq3osvNyrG85DogMjAyMMTqOdTCMTXI1SA0
OjU2CsrVvP7IyzogSm9lbCBGZXJuYW5kZXMKs63LzTogWmhhbmcsIFFpYW5nOyBVbGFkemlzbGF1
IFJlemtpOyBqb3NoQGpvc2h0cmlwbGV0dC5vcmc7IHJvc3RlZHRAZ29vZG1pcy5vcmc7IG1hdGhp
ZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbTsgTGFpIEppYW5nc2hhbjsgcmN1QHZnZXIua2VybmVs
Lm9yZzsgTEtNTArW98ziOiBSZTogUkNVOiBRdWVzdGlvbiBvbiBmb3JjZV9xc19ybnAKCk9uIE1v
biwgU2VwIDE0LCAyMDIwIGF0IDAzOjQyOjA4UE0gLTA0MDAsIEpvZWwgRmVybmFuZGVzIHdyb3Rl
Ogo+IE9uIE1vbiwgU2VwIDE0LCAyMDIwIGF0IDA3OjU1OjE4QU0gKzAwMDAsIFpoYW5nLCBRaWFu
ZyB3cm90ZToKPiA+IEhlbGxvIFBhdWwKPiA+Cj4gPiBJIGhhdmUgc29tZSBxdWVzdGlvbnMgZm9y
IHlvdSAuCj4gPiBpbiBmb3JjZV9xc19ybnAgZnVuYyAsICBpZiAgImYocmRwKSIgZnVuYyByZXR1
cm4gdHJ1ZSB3ZSB3aWxsIGNhbGwgcmN1X3JlcG9ydF9xc19ybnAgZnVuYwo+ID4gcmVwb3J0IGEg
cXVpZXNjZW50IHN0YXRlIGZvciB0aGlzIHJucCBub2RlLCBhbmQgY2xlYXIgZ3JwbWFzayBmb3Jt
IHJucC0+cXNtYXNrLgo+ID4gYWZ0ZXIgdGhhdCAsICBjYW4gd2UgbWFrZSBhIGNoZWNrIGZvciB0
aGlzIHJucC0+cXNtYXNrLCAgaWYgIHJucC0+cXNtYXNrID09IDAsCj4gPiB3ZSB3aWxsIGNoZWNr
IGJsb2NrZWQgcmVhZGVycyBpbiB0aGlzIHJucCBub2RlLCAgaW5zdGVhZCBvZiBqdW1waW5nIGRp
cmVjdGx5IHRvIHRoZSBuZXh0IG5vZGUgLgo+Cj4gQ291bGQgeW91IGNsYXJpZnkgd2hhdCBnb29k
IGlzIHRoaXMgZ29pbmcgdG8gZG8/IFdoYXQgcHJvYmxlbSBhcmUgeW91IHRyeWluZyB0bwo+IGFk
ZHJlc3M/Cj4KPiBZb3UgY291bGQgaGF2ZSBhIHRhc2sgdGhhdCBpcyBibG9ja2VkIGluIGFuIFJD
VSBsZWFmIG5vZGUsIGJ1dCB0aGUKPiBmb3JjZV9xc19ybnAoKSBkZWNpZGVkIHRvIGNhbGwgcmN1
X3JlcG9ydF9xc19ybnAoKS4gVGhpcyBpcyBwZXJmZWN0bHkgT2suIFRoZQo+IENQVSBjb3VsZCBi
ZSBkeW50aWNrLWlkbGUgYW5kIGEgcXVpZXNjZW50IHN0YXRlIGlzIHJlcG9ydGVkLiBIb3dldmVy
LCB0aGUgR1AKPiBtdXN0IG5vdCBlbmQgYW5kIHRoZSByY3UgbGVhZiBub2RlIHNob3VsZCBzdGls
bCBiZSBwcmVzZW50IGluIGl0cyBwYXJlbnQKPiBpbnRlcm1lZGlhdGUgbm9kZXMgLT5xc21hc2su
IEluIHRoaXMgY2FzZSwgdGhlIC0+cXNtYXNrID09IDAgZG9lcyBub3QgaGF2ZQo+IGFueSByZWxl
dmFuY2UuCj4KPiBPciBhbSBJIG1pc3NpbmcgdGhlIHBvaW50IG9mIHRoZSBxdWVzdGlvbj8KCj5I
ZWxsbywgUWlhbmcsCgo+QW5vdGhlciB3YXkgb2YgbWFraW5nIEpvZWwncyBwb2ludCBpcyB0byBz
YXkgdGhhdCB0aGUgYWRkaXRpb25hbCBjaGVjawo+eW91IGFyZSBhc2tpbmcgZm9yIGlzIGFscmVh
ZHkgYmVpbmcgZG9uZSwgYnV0IGJ5IHJjdV9yZXBvcnRfcXNfcm5wKCkuCgo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGFueCwgUGF1bAoK
SGVsbG8gUHVhbCwgIEpvZWwKCldoYXQgSSB3YW50IHRvIGV4cHJlc3MgaXMgYXMgZm9sbG93cyA6
CgpkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9rZXJuZWwvcmN1L3RyZWUuYwppbmRl
eCA3NjIzMTI4ZDAwMjAuLmJlYjU1NDUzOWYwMSAxMDA2NDQKLS0tIGEva2VybmVsL3JjdS90cmVl
LmMKKysrIGIva2VybmVsL3JjdS90cmVlLmMKQEAgLTI2MjIsNiArMjYyMiwxMSBAQCBzdGF0aWMg
dm9pZCBmb3JjZV9xc19ybnAoaW50ICgqZikoc3RydWN0IHJjdV9kYXRhICpyZHApKQogICAgICAg
ICAgICAgICAgaWYgKG1hc2sgIT0gMCkgewogICAgICAgICAgICAgICAgICAgICAgICAvKiBJZGxl
L29mZmxpbmUgQ1BVcywgcmVwb3J0IChyZWxlYXNlcyBybnAtPmxvY2spLiAqLwogICAgICAgICAg
ICAgICAgICAgICAgICByY3VfcmVwb3J0X3FzX3JucChtYXNrLCBybnAsIHJucC0+Z3Bfc2VxLCBm
bGFncyk7CisgICAgICAgICAgICAgICAgICAgICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZV9yY3Vf
bm9kZShybnAsIGZsYWdzKTsKKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJucC0+cXNtYXNr
ID09IDAgJiYgcmN1X3ByZWVtcHRfYmxvY2tlZF9yZWFkZXJzX2NncChybnApKQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJjdV9pbml0aWF0ZV9ib29zdChybnAsIGZsYWdzKTsKKyAg
ICAgICAgICAgICAgICAgICAgICAgZWxzZQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlX3JjdV9ub2RlKHJucCwgZmxhZ3MpOwogICAgICAg
ICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgICAgICAgICAgLyogTm90aGluZyB0byBk
byBoZXJlLCBzbyBqdXN0IGRyb3AgdGhlIGxvY2suICovCiAgICAgICAgICAgICAgICAgICAgICAg
IHJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlX3JjdV9ub2RlKHJucCwgZmxhZ3MpOwoKClRoYW5r
cwoKUWlhbmc=
