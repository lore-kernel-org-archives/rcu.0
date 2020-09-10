Return-Path: <SRS0=F17Q=CT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4DC2BB84
	for <rcu@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501A32053B
	for <rcu@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="TtAS9CXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgIJDZs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:25:48 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:33473
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729622AbgIJDZb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Sep 2020 23:25:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfQyFtk/MFur9sQv9npVk0YfBJs2IFhEVsAh8m18BgyrMlORSla5v0ad4PqD6LW4YmjSa8ZeryVnN+0Elzs5I3AxPeVR0SOk1dnwbrubqHwK6qfcUzmhSkbkwb+ElRLw5rKACEiYn4T79aSYpPfetoMgH0bArZ7H3qsCReBVvNhnEOjHqddboCfcYhSeQMF6zZ+BTXrM+ZPaFlhhwocdc/l/KgPHxNeBGicmqBGq6QzCkjZvh57HR+1WzoFGyqo3/5/lGpC1oqJEzzVLtDXuCo06XpNYJsh6vVJaOZ3OiZTOd6nAOmDpnmJyUb+8/IbZgork0L563wwI//ZyfSJkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a0pLtH3FMtmYY8qhLGOrzYTOrxVfCp+1WruXjFAsMY=;
 b=VJkdZeRZbjdhuKBcLJTbFhdK8raPjkK4n6h3KRVRDR1jFturpCAdfw29pDH0Y/Q2nB04Zl87mxXz1QeTqbUgHWilj5f8ur/oNEbs8QQK65F3+CxC2W6t0dzcOEMO/UoWY6xT8bjZEyDgSGxNcS2x7TSm1XrDV+B/v+OAO0bnEaorZ713xunlaivPykPipmfS3b3GojTXdlWLzTchCA4JjV9MVdHXRXpames6H+LPp4gGffQZ4pYSm3OZX2BTsg3774MKSBNjsvvTTMymOwOyUcbX/re2EvwLkSU6ysDwL6a1Q/nqNYR8VekU+PIskosBBagcOQuhw4YGBByfF7VUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a0pLtH3FMtmYY8qhLGOrzYTOrxVfCp+1WruXjFAsMY=;
 b=TtAS9CXBKpmYdmKjhmBXVLb0x9/Y0LvhODjY6Vy6VSsSbBBoXOnCx8dCdaWopspZQNKkiWj04DfqWdSNlcmL/u9sKy5GqrdHNiiQu+62lsELnLIMiNbC7pHRGVkhLQmfX0VTCouZAHWsGqleLZWDwcO/QMuqXil06RcUblPtHC0=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2840.namprd11.prod.outlook.com (2603:10b6:a02:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 03:25:28 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 03:25:28 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogUkNVOiAgUXVlc3Rpb24gICByY3VfcHJlZW1wdF9ibG9ja2VkX3Jl?=
 =?gb2312?B?YWRlcnNfY2dwICBpbiAgcmN1X2dwX2Zxc19sb29wIGZ1bmM=?=
Thread-Topic: RCU:  Question   rcu_preempt_blocked_readers_cgp  in
  rcu_gp_fqs_loop func
Thread-Index: AQHWhnNgdtT3KSvnnU6Qd/KLSreZGalf2jJUgABP9oCAAQtz+g==
Date:   Thu, 10 Sep 2020 03:25:27 +0000
Message-ID: <BYAPR11MB2632658A901238BB518A53F4FF270@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200819135654.GB3875610@google.com>
 <20200819152159.GX27891@paulmck-ThinkPad-P72> <20200819155808.GA8817@pc636>
 <20200820223957.GB120898@google.com>
 <20200821153328.GH2855@paulmck-ThinkPad-P72>
 <BYAPR11MB263285B19261BE8096D87F65FF260@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632FD34F68A89CCE039018BFF260@BYAPR11MB2632.namprd11.prod.outlook.com>,<20200909112241.GE29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200909112241.GE29330@paulmck-ThinkPad-P72>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bcd49ba-355d-4692-a2e8-08d855392a18
x-ms-traffictypediagnostic: BYAPR11MB2840:
x-microsoft-antispam-prvs: <BYAPR11MB2840817EA2BA907E984DBADFFF270@BYAPR11MB2840.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mh/LynNVM0yS261uxtTlvpuaoRNA8ngFSw2G3FLxtEHSn1KWCW7xCbiOYt9cQuJegs3jQQ0LpI9HDjK4YW6eZ4KWB4RHMEBzUu6wPxx8haaBsOLzUlcnLZRHb+UigIO1qeGi0uR4Nblptifv8iQdH7JlLv0GVwJgsjY1MvHPKs1upQ04SA5qOxPiIVD+0Q/U0+CLT5W0HFCaqVHk87pi+5e9sbYSYLUtuaujq9FZ1vR/pOYMbsZ/0hNIqTmCDut3ZRMDpWmiu46LDSfaMbL749R9kvHWT0wrCxeT7BhTr76LFMNEh3EelVcYEC6+Alz8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39850400004)(396003)(136003)(64756008)(66476007)(83380400001)(6506007)(55016002)(54906003)(91956017)(2906002)(7696005)(316002)(86362001)(4326008)(224303003)(76116006)(66446008)(66556008)(66946007)(9686003)(478600001)(52536014)(186003)(71200400001)(26005)(8936002)(33656002)(5660300002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uHYWqpji8Q31iUUNAQxYfgaHf08OuznVEmYRXv0453epyFiDmS7d7yFAZwvHCxnZJQosGeNnmOZ6/4LvMUQoBv/LKoWiEkEPnrV3+YBuj0M+IkA5PLBgJZfEPsRrX7SfwTasOcL+d8ziRwAtWjOH2AFLiph2ok1k/PMEDbEl/tgtDwmH/xPBGptSSpCG/iVAe2gWyHwcpM4R9B06LbeHbKOLBSigG/N8COBK8dhJy9mTXzzPTT32sJ1V/41DHKRnOnF9MNMiYlehrQdzlAeedElNTHo3Dq3wmGFurjgbQcCYzNkzVjteWSlQiyJPtKNyEjYUuLHAqOh8hdCCRkQrEmvZQ9NMdRYDoZAeqtbP8NMO2nA/97wYogw4HRFv5o4i63Jakfwp0hWmTqIr+hD9jBXFIctEAzce/Uf8oyWoiqly3gN7Qom2AYgUVYlbpbXVbuicLd3WDZMjVcImprRVrmtiABecAR9Xgkd5Jltenq4pAfMT58XerMItVzHOv1+kXSPhEh5fxnz30ZZxF5l4/BR5pwCUKd9uTGkLuNY2s2h/vdm4PmZ2T+yT5G0GJBG/HSVlv204ERxH6TNxMCxGYsNptrIhaJF5ptRe1Hok+OerhbGsvF1bdyOfRTHSO2pNjiWr2K+4ZEE666djdcP43A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcd49ba-355d-4692-a2e8-08d855392a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 03:25:27.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QR+jSxG4d+OGWYMQlp9251IyG5audR7hEapfr2uFAu0KwGIK6KCmviFWG+gVTXhKzlMfKB3m7A0/SFso85ac1KJwhI3Q/krHbFqLhoe7qeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2840
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUGF1bCBF
LiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPgq3osvNyrG85DogMjAyMMTqOdTCOcjVIDE5
OjIyCsrVvP7IyzogWmhhbmcsIFFpYW5nCrOty806IEpvZWwgRmVybmFuZGVzOyBVbGFkemlzbGF1
IFJlemtpOyBKb3NoIFRyaXBsZXR0OyBTdGV2ZW4gUm9zdGVkdDsgTWF0aGlldSBEZXNub3llcnM7
IExhaSBKaWFuZ3NoYW47IHJjdTsgTEtNTArW98ziOiBSZTogUkNVOiAgUXVlc3Rpb24gICByY3Vf
cHJlZW1wdF9ibG9ja2VkX3JlYWRlcnNfY2dwICBpbiAgcmN1X2dwX2Zxc19sb29wIGZ1bmMKCk9u
IFdlZCwgU2VwIDA5LCAyMDIwIGF0IDA3OjAzOjM5QU0gKzAwMDAsIFpoYW5nLCBRaWFuZyB3cm90
ZToKPgo+IFdoZW4gY29uZmlnIHByZWVtcHQgUkNVLCAgYW5kIHRoZW4gIHRoZXJlIGFyZSBtdWx0
aXBsZSBsZXZlbHMgIG5vZGUsICB0aGUgY3VycmVudCB0YXNrIGlzIHByZWVtcHRlZCAgaW4gcmN1
ICByZWFkIGNyaXRpY2FsIHJlZ2lvbi4KPiB0aGUgY3VycmVudCB0YXNrIGJlIGFkZCB0byAicm5w
LT5ibGtkX3Rhc2tzIiBsaW5rIGxpc3QsICBhbmQgdGhlICJybnAtPmdwX3Rhc2tzIiAgbWF5IGJl
IGFzc2lnbmVkIGEgdmFsdWUgLiAgdGhlc2Ugcm5wIGlzIGxlYWYgbm9kZSBpbiBSQ1UgdHJlZS4K
Pgo+IEJ1dCBpbiAicmN1X2dwX2Zxc19sb29wIiBmdW5jLCB3ZSBjaGVjayBibG9ja2VkIHJlYWRl
cnMgaW4gcm9vdCBub2RlLgo+Cj4gc3RhdGljIHZvaWQgcmN1X2dwX2Zxc19sb29wKHZvaWQpCj4g
IHsKPiAgICAgICAgICAgICAuLi4uLgo+ICAgICAgICAgICAgIHN0cnVjdCByY3Vfbm9kZSAqcm5w
ID0gcmN1X2dldF9yb290KCk7Cj4gICAgICAgICAgICAgLi4uLi4KPiAgICAgICAgICAgICBpZiAo
IVJFQURfT05DRShybnAtPnFzbWFzaykgJiYKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIXJjdV9wcmVlbXB0X2Jsb2NrZWRfcmVhZGVyc19jZ3Aocm5wKSkgICAgLS0tLS0tPiBybnAg
aXMgcm9vdCBub2RlCj4gICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICAgICAg
Li4uLgo+IH0KPgo+IHRoZSByb290IG5vZGUncyBibGtkX3Rhc2tzIG5ldmVyIGFkZCB0YXNrLCB0
aGUgInJucC0+Z3BfdGFza3MiIGlzIG5ldmVyIGJlIGFzc2lnbmVkIHZhbHVlLCAgdGhpcyBjaGVj
ayBpcyBpbnZhaWxlZC4KPiAgU2hvdWxkIHdlIGNoZWNrIGxlYWYgbm9kZXMgbGlrZSB0aGlzCgo+
VGhlcmUgYXJlIHR3byBjYXNlczoKCj4xLiAgICAgIFRoZXJlIGlzIG9ubHkgYSBzaW5nbGUgcmN1
X25vZGUgc3RydWN0dXJlLCB3aGljaCBpcyBib3RoIHJvb3QKPiAgICAgICBhbmQgbGVhZi4gIElu
IHRoaXMgY2FzZSwgdGhlIGN1cnJlbnQgY2hlY2sgaXMgcmVxdWlyZWQ6ICBCb3RoCj4gICAgICAg
LT5xc21hc2sgYW5kIHRoZSAtPmJsa2RfdGFza3MgbGlzdCBtdXN0IGJlIGNoZWNrZWQuICBZb3Vy
Cj4gICAgICAgIHJjdV9wcmVlbXB0X2Jsb2NrZWRfcmVhZGVycygpIHdvdWxkIHdvcmsgaW4gdGhp
cyBjYXNlLCBidXQKPiAgICAgICAgdGhlIGN1cnJlbnQgY29kZSBpcyBhIGJpdCBmYXN0ZXIgYmVj
YXVzZSBpdCBkb2VzIG5vdCBuZWVkCj4gICAgICAgIHRvIGFjcXVpcmUgdGhlIC0+bG9jayBub3Ig
ZG9lcyBpdCBuZWVkIHRoZSBsb29wIG92ZXJoZWFkLgoKPjIuICAgICAgVGhlcmUgYXJlIG11bHRp
cGxlIGxldmVscy4gIEluIHRoaXMgY2FzZSwgYXMgeW91IHNheSwgdGhlIHJvb3QKPiAgICAgICAg
cmN1X25vZGUgc3RydWN0dXJlJ3MgLT5ibGtkX3Rhc2tzIGxpc3Qgd2lsbCBhbHdheXMgYmUgZW1w
dHkuCj4gICAgICAgIEJ1dCBhbHNvIGluIHRoaXMgY2FzZSwgdGhlIHJvb3QgcmN1X25vZGUgc3Ry
dWN0dXJlJ3MgLT5xc21hc2sKPiAgICAgICAgY2Fubm90IGJlIHplcm8gdW50aWwgYWxsIHRoZSBs
ZWFmIHJjdV9ub2RlIHN0cnVjdHVyZXMnIC0+cXNtYXNrCj4gICAgICAgIGZpZWxkcyBhcmUgemVy
byBhbmQgdGhlaXIgLT5ibGtkX3Rhc2tzIGxpc3RzIG5vIGxvbmdlciBoYXZlCj4gICAgICAgIHRh
c2tzIGJsb2NraW5nIHRoZSBjdXJyZW50IGdyYWNlIHBlcmlvZC4gIFRoaXMgbWVhbnMgdGhhdCB5
b3VyCiA+ICAgICAgIHJjdV9wcmVlbXB0X2Jsb2NrZWRfcmVhZGVycygpIGZ1bmN0aW9uIHdvdWxk
IG5ldmVyIHJldHVybgogPiAgICAgICB0cnVlIGluIHRoaXMgY2FzZS4KCj5TbyB0aGUgY3VycmVu
dCBjb2RlIGlzIGZpbmUuCgo+QXJlIHlvdSBzZWVpbmcgZmFpbHVyZXMgb24gbWFpbmxpbmUga2Vy
bmVscz8gIElmIHNvLCB3aGF0IGlzIHRoZSBmYWlsdXJlCj5tb2RlPwoKIFllcyBpdCdzIHJpZ2h0
LCB0aGFuayB5b3UgZm9yIHlvdXIgZXhwbGFuYXRpb24uCiAgCiAgdGhhbmtzCiAgUWlhbmcKCiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRo
YW54LCBQYXVsCgo+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jCj4gKysrIGIva2VybmVsL3JjdS90
cmVlLmMKPiBAQCAtMTg0Niw2ICsxODQ2LDI1IEBAIHN0YXRpYyBib29sIHJjdV9ncF9pbml0KHZv
aWQpCj4gICAgICAgcmV0dXJuIHRydWU7Cj4gIH0KPgo+ICtzdGF0aWMgYm9vbCByY3VfcHJlZW1w
dF9ibG9ja2VkX3JlYWRlcnModm9pZCkKPiArewo+ICsgICAgIHN0cnVjdCByY3Vfbm9kZSAqcm5w
Owo+ICsgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gKyAgICAgYm9vbCByZXQgPSBmYWxzZTsK
PiArCj4gKyAgICAgcmN1X2Zvcl9lYWNoX2xlYWZfbm9kZShybnApIHsKPiArICAgICAgICAgICAg
IHJhd19zcGluX2xvY2tfaXJxc2F2ZV9yY3Vfbm9kZShybnAsIGZsYWdzKTsKPiArICAgICAgICAg
ICAgIGlmIChyY3VfcHJlZW1wdF9ibG9ja2VkX3JlYWRlcnNfY2dwKHJucCkpIHsKPiArICAgICAg
ICAgICAgICAgICAgICAgcmV0ID0gdHJ1ZTsKPiArICAgICAgICAgICAgICAgICAgICAgcmF3X3Nw
aW5fdW5sb2NrX2lycXJlc3RvcmVfcmN1X25vZGUocm5wLCBmbGFncyk7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgcmF3X3Nw
aW5fdW5sb2NrX2lycXJlc3RvcmVfcmN1X25vZGUocm5wLCBmbGFncyk7Cj4gKyAgICAgfQo+ICsK
PiArICAgICByZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICAvKgo+ICAgKiBIZWxwZXIgZnVuY3Rpb24g
Zm9yIHN3YWl0X2V2ZW50X2lkbGVfZXhjbHVzaXZlKCkgd2FrZXVwIGF0IGZvcmNlLXF1aWVzY2Vu
dC1zdGF0ZQo+ICAgKiB0aW1lLgo+IEBAIC0xODY0LDcgKzE4ODMsNyBAQCBzdGF0aWMgYm9vbCBy
Y3VfZ3BfZnFzX2NoZWNrX3dha2UoaW50ICpnZnApCj4gICAgICAgICAgICAgICByZXR1cm4gdHJ1
ZTsKPgo+ICAgICAgIC8vIFRoZSBjdXJyZW50IGdyYWNlIHBlcmlvZCBoYXMgY29tcGxldGVkLgo+
IC0gICAgIGlmICghUkVBRF9PTkNFKHJucC0+cXNtYXNrKSAmJiAhcmN1X3ByZWVtcHRfYmxvY2tl
ZF9yZWFkZXJzX2NncChybnApKQo+ICsgICAgIGlmICghUkVBRF9PTkNFKHJucC0+cXNtYXNrKSAm
JiAhcmN1X3ByZWVtcHRfYmxvY2tlZF9yZWFkZXJzKCkpCj4gICAgICAgICAgICAgICByZXR1cm4g
dHJ1ZTsKPgo+ICAgICAgIHJldHVybiBmYWxzZTsKPiBAQCAtMTkyNyw3ICsxOTQ2LDcgQEAgc3Rh
dGljIHZvaWQgcmN1X2dwX2Zxc19sb29wKHZvaWQpCj4gICAgICAgICAgICAgICAvKiBMb2NraW5n
IHByb3ZpZGVzIG5lZWRlZCBtZW1vcnkgYmFycmllcnMuICovCj4gICAgICAgICAgICAgICAvKiBJ
ZiBncmFjZSBwZXJpb2QgZG9uZSwgbGVhdmUgbG9vcC4gKi8KPiAgICAgICAgICAgICAgIGlmICgh
UkVBRF9PTkNFKHJucC0+cXNtYXNrKSAmJgo+IC0gICAgICAgICAgICAgICAgICFyY3VfcHJlZW1w
dF9ibG9ja2VkX3JlYWRlcnNfY2dwKHJucCkpCj4gKyAgICAgICAgICAgICAgICAgIXJjdV9wcmVl
bXB0X2Jsb2NrZWRfcmVhZGVycygpKQo+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAg
ICAgICAgICAgICAgIC8qIElmIHRpbWUgZm9yIHF1aWVzY2VudC1zdGF0ZSBmb3JjaW5nLCBkbyBp
dC4gKi8KPiAgICAgICAgICAgICAgIGlmICghdGltZV9hZnRlcihyY3Vfc3RhdGUuamlmZmllc19m
b3JjZV9xcywgamlmZmllcykgfHwKPiAtLQo+Cj4KPiB0aGFua3MKPiBRaWFuZwo=
