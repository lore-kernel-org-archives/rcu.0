Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500B2C433E0
	for <rcu@archiver.kernel.org>; Sun, 24 Jan 2021 02:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F4D22581
	for <rcu@archiver.kernel.org>; Sun, 24 Jan 2021 02:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAXCWX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:22:23 -0500
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:29345
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbhAXCWW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 23 Jan 2021 21:22:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3G5JQPa4b9ww0J4muU8Fm+2cflJJcZcxeol7CvHcyoSSipT3/QvRL44mI65s0ZPNQlWmsUdk5uzuorpOHhE+fKX30t7GHKeUHkOCjaATwB/8+zLUrlg6FeuCiZkoodQ4wd7C3X2btlN5zO/vBD0a0C0z9yTk2hy2bl0TGvTSLbCcXfrylo3ZjrJOdsl/MaDjKJsCQ5pXwhgl98gI+hOuCIV5VRm/ARmqYLZjqWoVRzXpSQSUCvSWmRWtLRVMrIm78AbG2rtYxB+rMLYzNbec9smflpJ+0cXKCVAic1prlSCkzUcmAx6TZHXf0ehl5fm7qy9jDsRgWnfTNDmqAa0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpY2otwPaFrD7nrtBDV6kWjKkloVebRk/eatHB1py1A=;
 b=iI460NosafHFHkulxpsbDRovhNnsE0SFizOzTPECOpYBoRmco8uAGVyDxC7xpm/2gxGqBbUF3n0alDCtBzUMf1JIV7NguObFPtfudhLXoNUiaHoZbhRgme2WVEw1Y4AC34fMgGPfmR5/qOAGZfNaJaBjZJ3WyFdRU9t+DeZcurCcwOnQLu4q3x60F5viJBAq5IgKzup9Ff6u5ZCPrWf8L52Vj2ZBUj7aBqUQLUZLQI6vVbcgCZKGSiLzL2GFgS1hOBNT8/5LJWpZ/Pv7CZmWQc92h3WgVhXTYPUZ4Gg04ZRYH5bkJgZl/2nqqRbKiZmpkf3cX8b4w4e6fuxvWnGikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpY2otwPaFrD7nrtBDV6kWjKkloVebRk/eatHB1py1A=;
 b=kgnvlYykE7cLKiJ/z2XeCl34mvf3BJyC5yJZHFj4QNhTWlhDVkHxI1os1/SP2pemzhrRtFZRq9PK3G/IDI/aHWAVecaQ3HhevQK+X+ae1RRk6Ql8SB43IJub3QbxBz7bYhVEt2cjooRtkv0kOYlK/EZhPYHnNZx23vVDHGPdNGg=
Received: from DM6PR11MB2635.namprd11.prod.outlook.com (2603:10b6:5:c5::29) by
 DM6PR11MB2633.namprd11.prod.outlook.com (2603:10b6:5:c0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Sun, 24 Jan 2021 02:21:07 +0000
Received: from DM6PR11MB2635.namprd11.prod.outlook.com
 ([fe80::e1af:2b6f:fe87:158f]) by DM6PR11MB2635.namprd11.prod.outlook.com
 ([fe80::e1af:2b6f:fe87:158f%4]) with mapi id 15.20.3763.014; Sun, 24 Jan 2021
 02:21:07 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIXSByY3U6IFJlbGVhc2UgcGVyLWNwdSBrcmNw?=
 =?gb2312?Q?_page_cache_when_CPU_going_offline?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIXSByY3U6IFJlbGVhc2UgcGVyLWNwdSBrcmNwIHBhZ2Ug?=
 =?gb2312?Q?cache_when_CPU_going_offline?=
Thread-Index: AQHW778g0FRyyea31kCpEHkbjqfL9aoybrGAgAAZPYCAAFXUEYAA2UqAgAJSNbI=
Date:   Sun, 24 Jan 2021 02:21:07 +0000
Message-ID: <BYAPR11MB2632BB67FCC17E3B32CEAEA3FFBE0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210121064949.16164-1-qiang.zhang@windriver.com>
 <20210121185615.GR2743@paulmck-ThinkPad-P72>
 <20210121202635.GB2454@pc638.lan>
 <BYAPR11MB26324D17B990FC099919CBB7FFA00@BYAPR11MB2632.namprd11.prod.outlook.com>,<20210122143129.GB1873@pc638.lan>
In-Reply-To: <20210122143129.GB1873@pc638.lan>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [106.39.148.97]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb9b27ae-96dd-47ea-19ad-08d8c00eb527
x-ms-traffictypediagnostic: DM6PR11MB2633:
x-microsoft-antispam-prvs: <DM6PR11MB26330ABE8BE995D776337216FFBE0@DM6PR11MB2633.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YD4ocB1W7GAwE9YsCRp8sYTypmXd8dNVDnaDEMqg4b7nMxA9pPoNiXCEXG1SOvsTjNnZWPB00kXkEQM6oFV5o0CAw2+CwYumHpu5JX13ISRCrP3Q1t7I6ysAMWSZ9Z+mXjo36MsOwhLd1QgKTZCvfihLke8kbjnidL2QSIw3jhZ1NiCGmCGiGQWvlbv8V2IK7iJbXciRTd66egYRrnCpJYxDr61fnMUwaSUgeC/RRb+oWTRQ/mC8FhYff4hVDkrHLcApGbxjrxAVuW/NdNIkRGqmf+mXT+VTN6CaI3kmFX08x4cMROBa9d3nk/hcUTYkW0xgwtCVN+30aILGL7mCndolLTxHN2ncs5uwNNeZd7zAlSkIXmwxw/0Fd8ifICqqLZdYFfY8QxreMuMQp1v+fk5rPatNrVovYQJxHeOswQeSDpBbjWdLUMmNfrWa1TXIqWv1LOW7tBHCs2r90h8SPiNBSsu1VnMbBW14lI911ukPJSy9rcKGImVaCw2KR+EfRw3cU2z4gYVFp7AT/9P/xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39830400003)(224303003)(186003)(64756008)(6512007)(76116006)(2906002)(4326008)(478600001)(6506007)(6486002)(86362001)(316002)(8936002)(33656002)(71200400001)(66556008)(5660300002)(6916009)(66946007)(66446008)(83380400001)(66476007)(9686003)(91956017)(52536014)(26005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?aWZVb3BpcW5iTnpUQjFFSThEVlNnWUF1VHNWeVh1a1A3RGxKOU5POFpMVDN4?=
 =?gb2312?B?OFZRbEFiSTRUYU9ZbG5LQTlPd25uZUhCNytHSTEyYitNeS95bUtndVhaaGV6?=
 =?gb2312?B?NUFBSkR4SWdvYWdJSEUyM21DdndPNXJQUGdYM2ovcmk5T3l5dDF2VlpDQnlm?=
 =?gb2312?B?akg4RmE3RDFBaXIzY0xvUVdXY2E1VkFMQkVDelI5a2Jqd2hxdXdaSGVIajRz?=
 =?gb2312?B?L0Nob0Q3VldWM1I0SWJBSFpJZXdaRDFnVERlZm9waHhrL0ZIZmZ4N0UyWktw?=
 =?gb2312?B?MTdKZ3I1WXlnWWtUNHlzVE9ock5PVXZDaXhxNVFsUlpuOXJVMkxKRTB2djFn?=
 =?gb2312?B?SGdwdStWanh0d2lSTlFpUkpLc2JOZFBFUU1IcUJGTXZnQzgzSnVYNkJJTzBz?=
 =?gb2312?B?Z1o1alVVNzJ6NTFOejZwZ0x4aFpsSkwyUXBPVTc5c1VrODJ3Y1hhSUVmR0d0?=
 =?gb2312?B?bitnNjNIVmd6M2Y4QXRZWUYzQXYwdVI3bTVhUGF6Y2VwMXJnL2lUK3RMZ3ow?=
 =?gb2312?B?ZEVaVmJVdmlMOVRSbWpwcXRWcGR3V0FoTlNNajFSR3FBeDQ1Uituc1kzdXpq?=
 =?gb2312?B?Vm85N0s4dVBJTnJYcnpGc0F5bUdXMm9nSHk4NXJ4MlJxdnVRU3ArQXdpSjR3?=
 =?gb2312?B?NWVhaklXNkMvTHArT2ZCYTZpdkNsYUlPbURrYzNxUTlDOXA1TGw2S2tIYUxm?=
 =?gb2312?B?NWhqUGRMdnZEUzkwaExscTQ5Rng2UEV3anNLSWIvSzNMUkpLSkFjeGxBc0pN?=
 =?gb2312?B?SmxWajc0TFprbHdHazltSjNuS3hWanJKaFl3MUxqUzZMckc1OG1nUjYyUkNH?=
 =?gb2312?B?Vk90dFJtajFWK2tYVC9tWlNjR3pJY0h1ZHcvc01qM3RIc1AvemZCanY4WTEy?=
 =?gb2312?B?WnB5dmxQckUwcmZoWGwwTG40Z0o4WEhRalBYNFQ3a1dkQlo2QkZIWTB6U0s4?=
 =?gb2312?B?OU1RTHlZMWdCQ1pDdzBpQXdSUzJRdEdlclZZR0J4OC95R1pNcHh3amdSRW5G?=
 =?gb2312?B?cCtYUXBDdjhKRWRUQnBsUGVGZE9FV1N4VmhFMHZpRGhONGlxa25xeVBDb1Vz?=
 =?gb2312?B?NFB6K1Z4alc3S0dpZ1ZZUFczTm5MRDB5OElDdXZJNFE5bEYrR2VHTFlnZjEz?=
 =?gb2312?B?NmM2dDhQczZxMHpiMjhPZE8wOTZ4dE5CVVViQnp6Rms3TWg0cjArS05LUmZw?=
 =?gb2312?B?SDZORlJlbW9yWmZFVU1KVkl1OW9Kb3BKQ2FOd1V6OFk2K3pjSVlmZ0Y0eGxt?=
 =?gb2312?B?c0x1UGYyWFRKOTNyRlR1TVhMeVZBNnl1VUtMb2pESURSR2NIbU5SelJEMjFo?=
 =?gb2312?Q?S1D5PTMhP0GsA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9b27ae-96dd-47ea-19ad-08d8c00eb527
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2021 02:21:07.2379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zI8VJ60Zo2MLuiVs2ACQlgFhpROCUeE0GJ80Ni0h72B96BULf37wXx6Ax2g3agS3TiXV5mHu1VEfT4QT9OeEmw2Hx8e5Arcm3d3HKNw/cVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2633
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogVWxhZHpp
c2xhdSBSZXpraSA8dXJlemtpQGdtYWlsLmNvbT4Kt6LLzcqxvOQ6IDIwMjHE6jHUwjIyyNUgMjI6
MzEKytW8/sjLOiBaaGFuZywgUWlhbmcKs63LzTogVWxhZHppc2xhdSBSZXpraTsgUGF1bCBFLiBN
Y0tlbm5leTsgcmN1QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZwrW98ziOiBSZTogu9i4tDogW1BBVENIXSByY3U6IFJlbGVhc2UgcGVyLWNwdSBrcmNwIHBhZ2Ug
Y2FjaGUgd2hlbiBDUFUgZ29pbmcgb2ZmbGluZQoKT24gRnJpLCBKYW4gMjIsIDIwMjEgYXQgMDE6
NDQ6MzZBTSArMDAwMCwgWmhhbmcsIFFpYW5nIHdyb3RlOgo+Cj4KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gt6K8/sjLOiBVbGFkemlzbGF1IFJlemtpIDx1cmV6
a2lAZ21haWwuY29tPgo+ILeiy83KsbzkOiAyMDIxxOox1MIyMsjVIDQ6MjYKPiDK1bz+yMs6IFpo
YW5nLCBRaWFuZwo+ILOty806IFBhdWwgRS4gTWNLZW5uZXk7IHJjdUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHVyZXpraUBnbWFpbC5jb20KPiDW98ziOiBS
ZTogW1BBVENIXSByY3U6IFJlbGVhc2UgcGVyLWNwdSBrcmNwIHBhZ2UgY2FjaGUgd2hlbiBDUFUg
Z29pbmcgb2ZmbGluZQo+ID5IZWxsbywgUWlhbmcsCj4KPiA+IE9uIFRodSwgSmFuIDIxLCAyMDIx
IGF0IDAyOjQ5OjQ5UE0gKzA4MDAsIHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20gd3JvdGU6Cj4g
PiA+IEZyb206IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPiA+ID4KPiA+ID4g
SWYgQ1BVcyBnbyBvZmZsaW5lLCB0aGUgY29ycmVzcG9uZGluZyBrcmNwJ3MgcGFnZSBjYWNoZSBj
YW4KPiA+ID4gbm90IGJlIHVzZSB1dGlsIHRoZSBDUFUgY29tZSBiYWNrIG9ubGluZSwgb3IgbWF5
YmUgdGhlIENQVQo+ID4gPiB3aWxsIG5ldmVyIGdvIG9ubGluZSBhZ2FpbiwgdGhpcyBjb21taXQg
dGhlcmVmb3JlIGZyZWUga3JjcCdzCj4gPiA+IHBhZ2UgY2FjaGUgd2hlbiBDUFVzIGdvIG9mZmxp
bmUuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJp
dmVyLmNvbT4KPiA+Cj4gPkRvIHlvdSBjb25zaWRlciBpdCBhcyBhbiBpc3N1ZT8gV2UgaGF2ZSA1
IHBhZ2VzIHBlciBDUFUsIHRoYXQgaXMgMjA0ODAgYnl0ZXMuCj4gPgo+Cj4gSGVsbG8gUmV6a2kK
Pgo+IEluIGEgbXVsdGkgQ1BVcyBzeXN0ZW0sIG1vcmUgdGhhbiBvbmUgQ1BVcyBtYXkgYmUgb2Zm
bGluZSwgdGhlcmUgYXJlIG1vcmUgdGhhbiA1IHBhZ2VzLCAgYW5kIHRoZXNlIG9mZmxpbmUgQ1BV
cyBtYXkgbmV2ZXIgZ28gb25saW5lIGFnYWluICBvciAgaW4gdGhlIHByb2Nlc3Mgb2YgQ1BVcyBv
bmxpbmUsIHRoZXJlIGFyZSBlcnJvcnMsIHdoaWNoIGxlYWQgdG8gdGhlIGZhaWx1cmUgb2Ygb25s
aW5lLCB0aGVzZSBzY2VuYXJpb3Mgd2lsbCBsZWFkIHRvIHRoZSBwZXItY3B1IGtyYyBwYWdlIGNh
Y2hlIHdpbGwgbmV2ZXIgYmUgcmVsZWFzZWQuCj4KPlRoYW5rcyBmb3IgeW91ciBhbnN3ZXIuIEkg
d2FzIHRoaW5raW5nIG1vcmUgYWJvdXQgaWYgeW91IGtuZXcgc29tZSA+cGxhdGZvcm1zCj53aGlj
aCBzdWZmZXIgZnJvbSBzdWNoIGV4dHJhIHBhZ2UgdXNhZ2Ugd2hlbiBDUFUgZ29lcyBvZmZsaW5l
LiBBbnkgPmlzc3Vlcwo+eW91ciBwbGF0Zm9ybXMgb3IgZGV2aWNlcyBydW4gaW50byBiZWNhdXNl
IG9mIHRoYXQuCj4KPlNvIGkgdW5kZXJzdGFuZCB0aGF0IGlmIENQVSBnb2VzIG9mZmxpbmUgdGhl
IDUgcGFnZXMgYXNzb2NpYXRlZCB3aXRoIGl0ID5hcmUKPnVudXNlZCB1bnRpbCBpdCBnb2VzIG9u
bGluZSBiYWNrLgoKIEkgYWdyZWUgd2l0aCB5b3UsIEJ1dCBJIHN0aWxsIHdhbnQgdG8gdGFsayBh
Ym91dCB3aGF0IEkgdGhpbmsKCiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgd2hlbiB0aGUgQ1BV
IGlzIG9mZmxpbmUsICB0aGUgcGFnZXMgaXMgbm90IAogYWNjZXNzaWJsZSwgIGJlYWN1c2Ugd2Ug
ZG9uJ3Qga25vdyB3aGVuIHRoaXMgQ1BVIHdpbGwgCiBnbyBvbmxpbmUgYWdhaW4sIHNvIHdlIGJl
c3QgdG8gcmV0dXJuIHRoZXNlIHBhZ2UgdG8gdGhlIGJ1ZGR5IHN5c3RlbSwKIHdoZW4gdGhlIENQ
VSBnb2VzIG9ubGluZSBhZ2Fpbiwgd2UgY2FuIGFsbG9jYXRlIHBhZ2UgZnJvbSB0aGUgYnVkZHkg
CiBzeXN0ZW0gdG8gZmlsbCBrcmNwJ3MgcGFnZSBjYWNoZS4gIG1heWJlIHlvdSBtYXkgdGhpbmsg
dGhhdCB0aGlzIG1lbW9yeSAKIGlzIHNtYWxsIGFuZCBkb24ndCBuZWVkIHRvLiAKIAogVGhhbmtz
IAogUWlhbmcKCj4KPi0tCj5WbGFkIFJlemtpCg==
