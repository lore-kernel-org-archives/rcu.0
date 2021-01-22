Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0C7C433DB
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 01:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E11922B43
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 01:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbhAVBp0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:45:26 -0500
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com ([40.107.93.41]:31584
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbhAVBpZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Jan 2021 20:45:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbjEi4T0pofukLcIXZ4PR3EZm/HcmJ6Czeb8l+20ENpcuOVbKO82KVpCWczxqaX4KTPr4DpL341C0g4cZFwT/h8r+WI+WyrIRTZNYO45KT9H1nA//jLMMqz6BUWe0r+VvZJcwS1+H8JuAC4O6fyJ/2VAhuqgmsFC56lgHf4ferm5NAqOsvO+AX45tVpDooS77Jt9mCCvGyvLKi3DS0AhEjy7d2iNb+N/quQGhy8ZMCqw+opWIUkfVOLQsTBdmJxVmX6AgRkGKiQgKYcrIq+YgmmGrruYhMXQrbkBblbPgkIDWp8V5i9ZvKq2Tyct3AXenoqmoVe3YoaCwIpxpvvp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQis/5HkBYa+fmp2fouggish1T0Or8w35rlRkmco4/8=;
 b=eAG9UJxhW24khzXy9SWLfxhgNQu7N7VyMDEeGtZvQUtisGJDqqO/fdYp86piY0TKDW0JGpDS1uRw6F8G05L1fs8FrbbAPL8Lh+VjO9wJErvsHa4icHAEbZrEWx9WqM7ZseM+ggb0kAYm8vkKxDH/phYzNciCpB4h5XJY1W0xq5bxXOmvkxPq7End0+RHId/a6B+SCF8dpFdQqpQKDcr9uYYidBoUmp6W6ursgjwWi/eRrNclWCiS0R5eo0bVfMS/Sn4qtp8rEL5ahdiXbfttvbEdUiN6FuLIDkUHKVaMdQtJxaZTZVesGarPkRwMno172W/KYFTpOkdcXxHC71V52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQis/5HkBYa+fmp2fouggish1T0Or8w35rlRkmco4/8=;
 b=qQ+38nD02TaiRP/aMH32RFdZ1M+APdicO3bYLQI6nBuFvCDH0jvrJ/iyEm//i8JXlJYTe8JM4jYZ45OgJkWkIZT6q6SrH4qqgHbFfSLMCri0zp8loOlED1VgHWYV1+4WcPpN7iwDPq7DXzXtI097S4BTzWUVByu6d8dpLyjD8Gc=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3621.namprd11.prod.outlook.com (2603:10b6:a03:fc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 01:44:36 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 01:44:36 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSByY3U6IFJlbGVhc2UgcGVyLWNwdSBrcmNwIHBhZ2Ug?=
 =?gb2312?Q?cache_when_CPU_going_offline?=
Thread-Topic: [PATCH] rcu: Release per-cpu krcp page cache when CPU going
 offline
Thread-Index: AQHW778g0FRyyea31kCpEHkbjqfL9aoybrGAgAAZPYCAAFXUEQ==
Date:   Fri, 22 Jan 2021 01:44:36 +0000
Message-ID: <BYAPR11MB26324D17B990FC099919CBB7FFA00@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210121064949.16164-1-qiang.zhang@windriver.com>
 <20210121185615.GR2743@paulmck-ThinkPad-P72>,<20210121202635.GB2454@pc638.lan>
In-Reply-To: <20210121202635.GB2454@pc638.lan>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3973fbf6-ea4b-4064-211c-08d8be77468a
x-ms-traffictypediagnostic: BYAPR11MB3621:
x-microsoft-antispam-prvs: <BYAPR11MB36210D3B7F43C451B98C081DFFA09@BYAPR11MB3621.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RTatjYLBb8s866Zj/kismAZFg4xTRKyJNHJl+R30lSeW+SbXVinYAgzKKhwV3hZ5Yw/9EcUqzAec5Nc2IwIcxJB5Ue4eIVGShrjQQy/qltWKfj+h0JfBmfJuavlGTWOHV4eFcB6dj/x7253+HJXzs44fQ9bxI+GOT0FCZufwZn7FQR5s9lkC2jj0T0RWNq7/USqrFllMSizByfc6WdHwjVt5yakbsPFauhvKlh+EYD8xOGOndxJCf5isBVM3v+qHWG3dLsw81FlG0sMfE0qx1ZX1pat26THjeg9OBuJdrjowvkoffrO6GF0fJuSQ5im+H6SztJRE1I7d13ZtsDptQMoceHsFdMzA+g3tqFq3OZMoJ9zNQa48kuhlrasTZ4d1OMl4Acg8chLSUCoQuMOPdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(346002)(366004)(376002)(54906003)(6506007)(2906002)(186003)(6916009)(5660300002)(478600001)(33656002)(224303003)(91956017)(66476007)(316002)(55016002)(71200400001)(66946007)(26005)(86362001)(52536014)(83380400001)(8936002)(9686003)(76116006)(66556008)(7696005)(66446008)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?TnZjN0x3UUNRYWVuRDZFWHc0YmVzTCsxbzhyQ2tEUk1GNkdNTEF6Tm9DVmd0?=
 =?gb2312?B?Rms0TmlUdVR1STZuSCs3cm5aN1pjSUNuL0IyZ2RXdzA0Y08vZ1Z0dlFvN0FB?=
 =?gb2312?B?RWZrY2pjL056dGpMQ0lNYWhBd3VFdmxncDQ5Y0grN0M2ckE0UGFnbjYwb3Vl?=
 =?gb2312?B?NDA2empnOHFGdHJReUhYN2lJdlNBUHZUa1htRkJ4SUhZUWRIWEptVjZFY01X?=
 =?gb2312?B?NGo5N1EwWlZCMWxwVWp0aXJJR2xUT1h2RyswY3pFMExXblplcEMwSFJ1aDF3?=
 =?gb2312?B?Tm5CVVpZSWpWZHVRMmNHMi9hYnFuQ0Y5eWJKVHl1ZHNTUFBMWVB3d3hwL2pp?=
 =?gb2312?B?UXZzWklaTDZCSVdVSDh4L0lIU2h5ZUtjNjJRdUFaR09peVBoQUZGRVIwUzZn?=
 =?gb2312?B?RUNzMmV1cS9LSlFpdDk2czRIaS9FMUFDUzVVZ2pPZVdob3cvUlFWdFI4M2Zq?=
 =?gb2312?B?QUNVamlqZVZ4QlRueUg5VVl3YzNYUzM2clhWZ0hEZnhLdVN5WW9LQ2ZxK1Yy?=
 =?gb2312?B?Q2pZNWx1UGdPOG4zY1JSUXp2R08yOTdOQmY5NE1QNkcrZXpYUjhxU2tDcExV?=
 =?gb2312?B?Y1dDRTNnMjhWOW5ia0U0ZUtWQ1k1OEJobFFFb2ZTdFpIM0FBaEUvRytxbWxD?=
 =?gb2312?B?WmgyS1RJOGplcHIwd0NGQjVoeGFtRlhiNXFGRWhRbkUvVUZGOEZOenZRWmZ6?=
 =?gb2312?B?ZGVYQU5va1c4RzRncUNKTUlIN2FjQUxYZktTbkhMVzZicG4xSTBoQkJnTUNV?=
 =?gb2312?B?ejlaTk5KZTF6bW85OVBFTWxHeE1jL3pORVpYRnhuM0N5Qkt2NHBUSWxva0ty?=
 =?gb2312?B?NjB6S3lyS3E2YXB5U0ErMTU4REZOMXBKRjRuUURlMm9OOGJsSGkzTEtmMm1t?=
 =?gb2312?B?NVZMbTlHK1hRVWFhVmNJSHFncnRoT3BXdzRYL25CTzJ5S2dJcWsvSlF4MDFL?=
 =?gb2312?B?TWRZd0FOeVo2MUNTRGwwMTFhNzliUmJpb2E3NUQyN0ZNZ29xRlFkNDZwZWNL?=
 =?gb2312?B?b3hnZTY3ejFLUlNtMkhIOHRUTSsyZ3VnUWJOazRKRkVudGxJM1VERFZFMTV0?=
 =?gb2312?B?OUNkc20rTWxUV1I5OHhEejgyMHJkdUh0K1pmVkNjNG5VMXFPcnUra3RHdHRv?=
 =?gb2312?B?M3F1blcrM3puTnYyNEUrd0dkWStJVGdES1QxbE5wMFpOZXY2ZCs4QmhaMWlr?=
 =?gb2312?B?L09BU29paGdBeHF1dTkyaENxeURlQXZZQlJkR3VsS3NHbTcwMk1MaWtQV2sw?=
 =?gb2312?B?TzJ0Zm1HUzNVMnRncFJ5Yk52aFdPa2Z5ODlJdDRJYTVKSnJ3THI0RkpYTEN2?=
 =?gb2312?Q?VSsnTyYBYhArw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3973fbf6-ea4b-4064-211c-08d8be77468a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 01:44:36.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwaDpOiYz8aIVOprika6z0vmo8q8o8kFBpfJzOLs6pCgLfAbnaOrDCbzCJ1dnd76aiE62SQlgGRhfFB1F0jDX8YRzF+FyPthNiIsAT3a2yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3621
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogVWxhZHpp
c2xhdSBSZXpraSA8dXJlemtpQGdtYWlsLmNvbT4Kt6LLzcqxvOQ6IDIwMjHE6jHUwjIyyNUgNDoy
NgrK1bz+yMs6IFpoYW5nLCBRaWFuZwqzrcvNOiBQYXVsIEUuIE1jS2VubmV5OyByY3VAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB1cmV6a2lAZ21haWwuY29t
Ctb3zOI6IFJlOiBbUEFUQ0hdIHJjdTogUmVsZWFzZSBwZXItY3B1IGtyY3AgcGFnZSBjYWNoZSB3
aGVuIENQVSBnb2luZyBvZmZsaW5lCj5IZWxsbywgUWlhbmcsCgo+IE9uIFRodSwgSmFuIDIxLCAy
MDIxIGF0IDAyOjQ5OjQ5UE0gKzA4MDAsIHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20gd3JvdGU6
Cj4gPiBGcm9tOiBacWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+Cj4gPgo+ID4gSWYg
Q1BVcyBnbyBvZmZsaW5lLCB0aGUgY29ycmVzcG9uZGluZyBrcmNwJ3MgcGFnZSBjYWNoZSBjYW4K
PiA+IG5vdCBiZSB1c2UgdXRpbCB0aGUgQ1BVIGNvbWUgYmFjayBvbmxpbmUsIG9yIG1heWJlIHRo
ZSBDUFUKPiA+IHdpbGwgbmV2ZXIgZ28gb25saW5lIGFnYWluLCB0aGlzIGNvbW1pdCB0aGVyZWZv
cmUgZnJlZSBrcmNwJ3MKPiA+IHBhZ2UgY2FjaGUgd2hlbiBDUFVzIGdvIG9mZmxpbmUuCj4gPgo+
ID4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPgo+Cj5E
byB5b3UgY29uc2lkZXIgaXQgYXMgYW4gaXNzdWU/IFdlIGhhdmUgNSBwYWdlcyBwZXIgQ1BVLCB0
aGF0IGlzIDIwNDgwIGJ5dGVzLgo+CgpIZWxsbyBSZXpraSAKCkluIGEgbXVsdGkgQ1BVcyBzeXN0
ZW0sIG1vcmUgdGhhbiBvbmUgQ1BVcyBtYXkgYmUgb2ZmbGluZSwgdGhlcmUgYXJlIG1vcmUgdGhh
biA1IHBhZ2VzLCAgYW5kIHRoZXNlIG9mZmxpbmUgQ1BVcyBtYXkgbmV2ZXIgZ28gb25saW5lIGFn
YWluICBvciAgaW4gdGhlIHByb2Nlc3Mgb2YgQ1BVcyBvbmxpbmUsIHRoZXJlIGFyZSBlcnJvcnMs
IHdoaWNoIGxlYWQgdG8gdGhlIGZhaWx1cmUgb2Ygb25saW5lLCB0aGVzZSBzY2VuYXJpb3Mgd2ls
bCBsZWFkIHRvIHRoZSBwZXItY3B1IGtyYyBwYWdlIGNhY2hlIHdpbGwgbmV2ZXIgYmUgcmVsZWFz
ZWQuCgpUaGFua3MKUWlhbmcKCgo+LS0KPlZsYWQgUmV6a2kK
