Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C256C63798
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 06:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975CB2237B
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 06:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="dG86ktPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgKTGTJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 01:19:09 -0500
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com ([40.107.223.78]:49440
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbgKTGTI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 01:19:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZID3QI0JpV+yV8Lu06lSZcRsJ+KwR+W+AlBeFgFb2WJZYrz+FNqwb9XLj8NVNJIb8xVIr88oGBI4ZMlOwskQSMyA/LCxJXshfI5YaiCeQ3CGdyQxmShe77SZbX3FTa4hE3l9ZU0MsC9LKe4f9GxihSryfB7KPdSKxhnAYgkSY1H30KLNweO5LaCZEI6DKCKPehUs93FNznZujIquaL9idGH7gygJs3Uptlxid9gPvOjOkybAyipHM7QaSNdRxhBLOFJV/NpoUa8Yb9kQDwG6jcsqAVDO1VBHl2Qk8GHb/HpVucICO8OyUm1O+GCZmYk4fMZMZLLXXrdYi0Bv+6Hq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwEVE/P9dVcZXy2zkGfLlaEnkLQLMfJNolPrkVxA98g=;
 b=lK0//lJNVBexnMp8/c/sFdKbJoo3VgY1xOjTIJ1DaWebV57e+io05zJTe+j1CEngzwmUfgFTeXJVPLpdRuPHnrUMZmpY/Tx16FbxVjVI9Ms/US+R1Kh5nKg7tQH8uHHWm22+p9Nh7PemMJOkkiKvNeFF01C5upN5wpqibTwupW9RRx96nQXOFDEy6W8JVcpUqOSY/g7LvD9ffCx9behO8Y0pNi0Ro7+mZNdUE5n43We5ILbh9AdemBtV5Ypq25k+a8Vni3W929W5oGI6rS+ht6m9dlgY+S23oabsM+7EvxhonizeW1Ys+sv9fRg8GF1PUsR1TSq9zgy1kqXgXMzp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwEVE/P9dVcZXy2zkGfLlaEnkLQLMfJNolPrkVxA98g=;
 b=dG86ktPi9pEdenAXB5zJEd6UniwiKf8fJNbHObko9fTIBG+cwgVOYueP4bPMQ7Y6aFy0x7fdafDVz+DWf570h1xIAnu35HTN1kN0gL82rWMZVGRDY239JM/K9UHsApy6Yw6vwAqcQsVPSPcFcsS1jR0ffkGf68xSB2XZLVKJh20=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4259.namprd11.prod.outlook.com (2603:10b6:a03:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 06:19:04 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7%6]) with mapi id 15.20.3564.031; Fri, 20 Nov 2020
 06:19:03 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBzcmN1OiBSZW1vdmUgc3JjdV9jYmxpc3RfaW52b2tp?=
 =?gb2312?Q?ng_member_from_sdp?=
Thread-Topic: [PATCH] srcu: Remove srcu_cblist_invoking member from sdp
Thread-Index: AQHWvjWk1DyQyKrVDUqWS1dUuFjAZKnPwrGAgADJ5EM=
Date:   Fri, 20 Nov 2020 06:19:03 +0000
Message-ID: <BYAPR11MB26320D0BF1B4B58AC38A1538FFFF0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20201119053411.11698-1-qiang.zhang@windriver.com>,<20201119181235.GX1437@paulmck-ThinkPad-P72>
In-Reply-To: <20201119181235.GX1437@paulmck-ThinkPad-P72>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7843be3d-7502-4a9c-13df-08d88d1c2dc7
x-ms-traffictypediagnostic: BY5PR11MB4259:
x-microsoft-antispam-prvs: <BY5PR11MB4259714FB328E0F96D1A806CFFFF0@BY5PR11MB4259.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cX/pBlkXLoZoOF9Hny35DtuXyHISCPTY4Honf73ybSHXbYptc9xTGkNEvjluhROKQ5Xyc8qLJXdMCAk4Tw0jTCbn4MApkG+6v8s3K0phMD/aLE14s7msZRAXWfJzyrU8hNEnTLQgfMvYpu25GEFjgO/s3MwH0Kg0mK0kH9bQAiKaoIKgMpUz//iRVDqsOjMaPO0zbilDt5YytqhQAZzJDTEIUmczIBo6pDRtImylGOQb0QB24gslK5pYswsIuib1Vpd3CmcGRtQ19Rz8y8Wn5YkhKsyfKoKU5+n15P1BcNM6Y40Cnjuh+kirDff+KQqdpvwhr5fgBDfOI0EFNTO5bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39850400004)(346002)(376002)(396003)(316002)(9686003)(55016002)(33656002)(54906003)(86362001)(478600001)(4326008)(26005)(186003)(71200400001)(224303003)(66556008)(66476007)(5660300002)(6506007)(7696005)(91956017)(83380400001)(66946007)(64756008)(6916009)(66446008)(8936002)(2906002)(76116006)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AMzax22plkcJLxEJ1CWWv+thGF2K8bKEWP8pe8UnyZyiZbiQaLB5uYzR8oFOT3lfk3QleOu7EiPV6+kwFzNupUj2ivnC93Z46EHz1EAUzrIqIHPe5HWlLYbTnTXlly75cWBlxnJG1q0s5qZ5EoR3iFErpwlPEXlOuxeHcxpFL7JmWf541GH/40OFXhBhyTURRULeCTnbfQ/Irk/h9fJm+RHZDh5QRhgHBOfZdr+herUKZ0eLORWPjcJFPsVf4SqEfqvhaOU9xDB6NXi4DeoyzBKn5elW/gg5fYFRwdZh0xrvLdBKHp3y+sD684AGV0H/Ez5in6vPrCTJciCQqmt/FatRUil3YfNe7NZ9UXzwaq0lW3TlYP3DaTNKYAJ591n17JtdwKyPi4sQOHYM3ocNyXZYrAa4VLXiNHZUOrwDQR0IdRcXqVSMOPcVInHB7dLZH5s2+MRdvSHnG8iEWs4OV0w9RZzOnuvSHfLQYbVx3qQSIPyLzjKZ24QjYpwUTtpIitavITJk2Xi4AWpnwwZt7u1FNf87VtjveVAxqDVMcZD4W5xIdcBMKNN4Jt46YIn4kVdxCpIzrps4YjbyXNhGs1d9fNwjo12jLxKWCvsEACvfxI5o0FhzPIbFKMG4Q1SEz51HUsQjECJKyNoTDUDSyg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7843be3d-7502-4a9c-13df-08d88d1c2dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 06:19:03.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: my6rGu09tlODrhXbxp8dGXcAQXh8Xuf2VaU8YesJeFPR9GDbB/pgPzm4fd2IkOCsmG9uj8z/Boo34bqB+D/K6dI0C1oO1KX+OD293IJ2Gnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4259
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUGF1bCBF
LiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPgq3osvNyrG85DogMjAyMMTqMTHUwjIwyNUg
MjoxMgrK1bz+yMs6IFpoYW5nLCBRaWFuZwqzrcvNOiBqaWFuZ3NoYW5sYWlAZ21haWwuY29tOyBy
b3N0ZWR0QGdvb2RtaXMub3JnOyBqb3NoQGpvc2h0cmlwbGV0dC5vcmc7IHJjdUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK1vfM4jogUmU6IFtQQVRDSF0gc3Jj
dTogUmVtb3ZlIHNyY3VfY2JsaXN0X2ludm9raW5nIG1lbWJlciBmcm9tIHNkcAoKW1BsZWFzZSBu
b3RlIHRoaXMgZS1tYWlsIGlzIGZyb20gYW4gRVhURVJOQUwgZS1tYWlsIGFkZHJlc3NdCgpPbiBU
aHUsIE5vdiAxOSwgMjAyMCBhdCAwMTozNDoxMVBNICswODAwLCBxaWFuZy56aGFuZ0B3aW5kcml2
ZXIuY29tIHdyb3RlOgo+IEZyb206IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4K
Pgo+IFdvcmtxdWV1ZSBjYW4gZW5zdXJlIHRoZSBtdWx0aXBsZSBzYW1lIHNkcC0+d29yayBzZXF1
ZW50aWFsCj4gZXhlY3V0aW9uIGluIHJjdV9ncF93cSwgbm90IG5lZWQgc3JjdV9jYmxpc3RfaW52
b2tpbmcgdG8KPiBwcmV2ZW50IGNvbmN1cnJlbnQgZXhlY3V0aW9uLCBzbyByZW1vdmUgaXQuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+Cgo+R29v
ZCBqb2IgYW5hbHl6aW5nIHRoZSBjb2RlLCB3aGljaCBpcyB2ZXJ5IGdvb2QgdG8gc2VlISEhCj4K
PkJ1dCB0aGVzZSBkbyBoYXZlIGEgcG90ZW50aWFsIHB1cnBvc2UuICBSaWdodCBub3csIGl0IGlz
IE9LIHRvIGludm9rZQo+c3luY2hyb25pemVfc3JjdSgpIGR1cmluZyBlYXJseSBib290LCB0aGF0
IGlzLCBiZWZvcmUgdGhlIHNjaGVkdWxlcgo+aGFzIHN0YXJ0ZWQuICBCdXQgdGhlcmUgaXMgYSBn
YXAgZnJvbSB0aGUgdGltZSB0aGF0IHRoZSBzY2hlZHVsZXIgaGFzCj5pbml0aWFsaXplZCAoc28g
dGhhdCBwcmVlbXB0aW9uIGFuZCBibG9ja2luZyBhcmUgcG9zc2libGUpIGFuZCB0aGUgdGltZQo+
dGhhdCB3b3JrcXVldWVzIGFyZSBpbml0aWFsaXplZCBhbmQgZnVsbHkgZnVuY3Rpb25hbC4gIE9u
bHkgYWZ0ZXIgdGhhdAo+aXMgaXQgb25jZSBhZ2FpbiBPSyB0byB1c2Ugc3luY2hyb25pemVfc3Jj
dSgpLgo+Cj5JZiBzeW5jaHJvbml6ZV9zcmN1KCkgaXMgZXZlciByZXF1aXJlZCB0byB3b3JrIGNv
cnJlY3RseSBkdXJpbmcgdGhhdAo+dGltZSBwZXJpb2QsIGl0IHdpbGwgbmVlZCB0byBkaXJlY3Rs
eSBpbnZva2UgdGhlIGZ1bmN0aW9ucyB0aGF0IGFyZQo+Y3VycmVudGx5IHJ1biBpbiB3b3JrcXVl
dWUgY29udGV4dC4gIFdoaWNoIG1lYW5zIHRoYXQgdGhlcmUgd2lsbCB0aGVuIGJlCj50aGUgcG9z
c2liaWxpdHkgb2YgdHdvIGluc3RhbmNlcyBvZiB0aGVzZSBmdW5jdGlvbnMgcnVubmluZyBqdXN0
IGFmdGVyCj53b3JrcXVldWVzIGFyZSBhdmFpbGFibGUuCj4KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGFueCwgUGF1bAoKVGhhbmtzIFBh
dWwuCgo+IC0tLQo+ICBpbmNsdWRlL2xpbnV4L3NyY3V0cmVlLmggfCAxIC0KPiAga2VybmVsL3Jj
dS9zcmN1dHJlZS5jICAgIHwgOCArKy0tLS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Ny
Y3V0cmVlLmggYi9pbmNsdWRlL2xpbnV4L3NyY3V0cmVlLmgKPiBpbmRleCA5Y2ZjYzhhNzU2YWUu
LjYyZDgzMTJiNTQ1MSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NyY3V0cmVlLmgKPiAr
KysgYi9pbmNsdWRlL2xpbnV4L3NyY3V0cmVlLmgKPiBAQCAtMzEsNyArMzEsNiBAQCBzdHJ1Y3Qg
c3JjdV9kYXRhIHsKPiAgICAgICBzdHJ1Y3QgcmN1X3NlZ2NibGlzdCBzcmN1X2NibGlzdDsgICAg
ICAgLyogTGlzdCBvZiBjYWxsYmFja3MuKi8KPiAgICAgICB1bnNpZ25lZCBsb25nIHNyY3VfZ3Bf
c2VxX25lZWRlZDsgICAgICAgLyogRnVydGhlc3QgZnV0dXJlIEdQIG5lZWRlZC4gKi8KPiAgICAg
ICB1bnNpZ25lZCBsb25nIHNyY3VfZ3Bfc2VxX25lZWRlZF9leHA7ICAgLyogRnVydGhlc3QgZnV0
dXJlIGV4cCBHUC4gKi8KPiAtICAgICBib29sIHNyY3VfY2JsaXN0X2ludm9raW5nOyAgICAgICAg
ICAgICAgLyogSW52b2tpbmcgdGhlc2UgQ0JzPyAqLwo+ICAgICAgIHN0cnVjdCB0aW1lcl9saXN0
IGRlbGF5X3dvcms7ICAgICAgICAgICAvKiBEZWxheSBmb3IgQ0IgaW52b2tpbmcgKi8KPiAgICAg
ICBzdHJ1Y3Qgd29ya19zdHJ1Y3Qgd29yazsgICAgICAgICAgICAgICAgLyogQ29udGV4dCBmb3Ig
Q0IgaW52b2tpbmcuICovCj4gICAgICAgc3RydWN0IHJjdV9oZWFkIHNyY3VfYmFycmllcl9oZWFk
OyAgICAgIC8qIEZvciBzcmN1X2JhcnJpZXIoKSB1c2UuICovCj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9yY3Uvc3JjdXRyZWUuYyBiL2tlcm5lbC9yY3Uvc3JjdXRyZWUuYwo+IGluZGV4IDNjNWUyODA2
ZTBiOS4uYzRkNWNkMjU2N2E2IDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9yY3Uvc3JjdXRyZWUuYwo+
ICsrKyBiL2tlcm5lbC9yY3Uvc3JjdXRyZWUuYwo+IEBAIC0xMzQsNyArMTM0LDYgQEAgc3RhdGlj
IHZvaWQgaW5pdF9zcmN1X3N0cnVjdF9ub2RlcyhzdHJ1Y3Qgc3JjdV9zdHJ1Y3QgKnNzcCwgYm9v
bCBpc19zdGF0aWMpCj4gICAgICAgICAgICAgICBzZHAgPSBwZXJfY3B1X3B0cihzc3AtPnNkYSwg
Y3B1KTsKPiAgICAgICAgICAgICAgIHNwaW5fbG9ja19pbml0KCZBQ0NFU1NfUFJJVkFURShzZHAs
IGxvY2spKTsKPiAgICAgICAgICAgICAgIHJjdV9zZWdjYmxpc3RfaW5pdCgmc2RwLT5zcmN1X2Ni
bGlzdCk7Cj4gLSAgICAgICAgICAgICBzZHAtPnNyY3VfY2JsaXN0X2ludm9raW5nID0gZmFsc2U7
Cj4gICAgICAgICAgICAgICBzZHAtPnNyY3VfZ3Bfc2VxX25lZWRlZCA9IHNzcC0+c3JjdV9ncF9z
ZXE7Cj4gICAgICAgICAgICAgICBzZHAtPnNyY3VfZ3Bfc2VxX25lZWRlZF9leHAgPSBzc3AtPnNy
Y3VfZ3Bfc2VxOwo+ICAgICAgICAgICAgICAgc2RwLT5teW5vZGUgPSAmc25wX2ZpcnN0W2NwdSAv
IGxldmVsc3ByZWFkW2xldmVsXV07Cj4gQEAgLTEyNTQsMTQgKzEyNTMsMTEgQEAgc3RhdGljIHZv
aWQgc3JjdV9pbnZva2VfY2FsbGJhY2tzKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgICAg
ICBzcGluX2xvY2tfaXJxX3JjdV9ub2RlKHNkcCk7Cj4gICAgICAgcmN1X3NlZ2NibGlzdF9hZHZh
bmNlKCZzZHAtPnNyY3VfY2JsaXN0LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByY3Vf
c2VxX2N1cnJlbnQoJnNzcC0+c3JjdV9ncF9zZXEpKTsKPiAtICAgICBpZiAoc2RwLT5zcmN1X2Ni
bGlzdF9pbnZva2luZyB8fAo+IC0gICAgICAgICAhcmN1X3NlZ2NibGlzdF9yZWFkeV9jYnMoJnNk
cC0+c3JjdV9jYmxpc3QpKSB7Cj4gKyAgICAgaWYgKCFyY3Vfc2VnY2JsaXN0X3JlYWR5X2Nicygm
c2RwLT5zcmN1X2NibGlzdCkpIHsKPiAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycV9yY3Vf
bm9kZShzZHApOwo+ICAgICAgICAgICAgICAgcmV0dXJuOyAgLyogU29tZW9uZSBlbHNlIG9uIHRo
ZSBqb2Igb3Igbm90aGluZyB0byBkby4gKi8KPiAgICAgICB9Cj4KPiAtICAgICAvKiBXZSBhcmUg
b24gdGhlIGpvYiEgIEV4dHJhY3QgYW5kIGludm9rZSByZWFkeSBjYWxsYmFja3MuICovCj4gLSAg
ICAgc2RwLT5zcmN1X2NibGlzdF9pbnZva2luZyA9IHRydWU7Cj4gICAgICAgcmN1X3NlZ2NibGlz
dF9leHRyYWN0X2RvbmVfY2JzKCZzZHAtPnNyY3VfY2JsaXN0LCAmcmVhZHlfY2JzKTsKPiAgICAg
ICBsZW4gPSByZWFkeV9jYnMubGVuOwo+ICAgICAgIHNwaW5fdW5sb2NrX2lycV9yY3Vfbm9kZShz
ZHApOwo+IEBAIC0xMjgyLDcgKzEyNzgsNyBAQCBzdGF0aWMgdm9pZCBzcmN1X2ludm9rZV9jYWxs
YmFja3Moc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgICAgIHJjdV9zZWdjYmxpc3RfYWRk
X2xlbigmc2RwLT5zcmN1X2NibGlzdCwgLWxlbik7Cj4gICAgICAgKHZvaWQpcmN1X3NlZ2NibGlz
dF9hY2NlbGVyYXRlKCZzZHAtPnNyY3VfY2JsaXN0LAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByY3Vfc2VxX3NuYXAoJnNzcC0+c3JjdV9ncF9zZXEpKTsKPiAtICAgICBz
ZHAtPnNyY3VfY2JsaXN0X2ludm9raW5nID0gZmFsc2U7Cj4gKwo+ICAgICAgIG1vcmUgPSByY3Vf
c2VnY2JsaXN0X3JlYWR5X2Nicygmc2RwLT5zcmN1X2NibGlzdCk7Cj4gICAgICAgc3Bpbl91bmxv
Y2tfaXJxX3JjdV9ub2RlKHNkcCk7Cj4gICAgICAgaWYgKG1vcmUpCj4gLS0KPiAyLjE3LjEKPgo=
