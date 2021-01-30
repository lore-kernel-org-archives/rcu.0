Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D910C433E9
	for <rcu@archiver.kernel.org>; Sat, 30 Jan 2021 09:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061B164DE2
	for <rcu@archiver.kernel.org>; Sat, 30 Jan 2021 09:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhA3JYC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:24:02 -0500
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com ([40.107.243.87]:6304
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhA3JR4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 Jan 2021 04:17:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMvpXnAlz/NRnhKuwJnVP5eu4Uv2JksIx/ULBHZWZFGXlv699hjVpSOAFrqJBzEZ7RxrnmUF6R6nDAOwy89dsM7qppcwCULziGEcSv2ryrbloNT7qV7qE4Y/nygsn1+hgsHO/3/Qw1zEqVV/cvcfHwFk5fgOXM6BGsxPb8LvpuF5ItmAY+NpB82EbLXVQmcaJPkLK2/FB2UqYIfhUR5Ojyw3jEHMf1LYsPPVYhbm33LAHZurjpGR93DMAGSmviVOy+Ca+u6P0a+2au0P/BblFscXVIQqtTb6S8BW/J8u73FzcStZf+l9GpFLDa2Lkkdz38b89tRRQO1wwEB7y0fkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYhC+hG2SBLECmfEzsxf41gbTTqrnRJqwAc243VBIdw=;
 b=izRYL7d3Qm2346FEj1eFE54ZTu7xcouELR0NYDlxTVeOxuzNs8IzC57lUa/t3S/LZl73RyJG39wf48eqQxzKIAs2EJMEc851v39EbR1umeaZxH+robB12nMrEabWC4YzFwYXUcNxg/tgevaotoDbhfg4yrPCtL6xwd+ixyqL/mAoArJRs2/LvACx0CwItFYdL01i4qFcGtChZRZ7J9JoklDcfYsxLamW6sF+kIA9g/FycBLPF0HSf6T37IJndFIixOt1ePpMg9hVwYCm/NmltxAzb59H3bF+J+4wIuPZXUXxJtx7grdoF3dIr97cyl5oh+EEELVQtJGhYsGAcLfT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYhC+hG2SBLECmfEzsxf41gbTTqrnRJqwAc243VBIdw=;
 b=MDP/1woeU6peZBzieuL4R+1LniN8xeDtLnkBGSEXZDRGP96GF46Of/3f5YZUgbFCARYsyda88D1lJSkUzrP7CAwqVUkbzmqZpk/hYokC9+h3KqGs9syHAFYrN3Yfj1owkXGoraow7VXED4q4GJOI3G24jcHryjHgEymMlZca/k8=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3400.namprd11.prod.outlook.com (2603:10b6:a03:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Sat, 30 Jan
 2021 06:47:32 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Sat, 30 Jan 2021
 06:47:31 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBrdmZyZWVfcmN1OiBSZWxlYXNlIHBhZ2UgY2Fj?=
 =?gb2312?Q?he_under_memory_pressure?=
Thread-Topic: [PATCH v2] kvfree_rcu: Release page cache under memory pressure
Thread-Index: AQHW9hLlXYBj+iJ6XEG7XRGYj2BG4ao+p3mAgAEF68E=
Date:   Sat, 30 Jan 2021 06:47:31 +0000
Message-ID: <BYAPR11MB2632B16DBD0A3EBEA5EA2FAFFFB89@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210129080442.16055-1-qiang.zhang@windriver.com>,<20210129141953.GA29827@pc638.lan>
In-Reply-To: <20210129141953.GA29827@pc638.lan>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [106.39.148.97]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a938f58-571b-4891-1c7c-08d8c4eaeb1e
x-ms-traffictypediagnostic: BYAPR11MB3400:
x-microsoft-antispam-prvs: <BYAPR11MB34001AC5D2EA49C5A0F29E2EFFB89@BYAPR11MB3400.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dOjzNi/yA3KWAVGBfY5SxY311fjiMAxZP6A8wXJQKZ9RtQTyEG1n98XPwBymQIf0MqxWdjNVS9A+mYlQZHmZVga8x/XbPlfgHKUcZ3zF90rE0uRWxHY3KHZ0dvQsWfMd3r2XXe4Zc6RvRp5sO23giRH00lS7YHRGrYfTz99QeO26O9sqI30fUkzvfMrIm63aRDE64SzjTS/5wkzAPE2jNmtPJJDmg8xG6oGouYak1r8kX8m1gQAI9DtH1tlEsN2HzE1dHY7AX9tSudd/p8exQ4/gnb9sW4ce0LrYa0BbFz8JwFmRrVpCOo2R1IU6f3fDKsGQk914/zNo1TtCnnN/ZDBOoWR1VYXPP5ZG1oLEghmEwItFZT8eRYipLbWTMCrEB+otz5GAgXM5c6A/TguzXorfd7YAbUjQdbgNQxaQ1CcOtxgSiypdrcL0PYuvUAUbePRxivYm5NXxagQfPNjWHDmyGJpjKjWZUpjLdQLpzCfzfYO1nxYK4xVmGC3hRGA9vGin4VZTeJhUFiu/H0eM+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(6916009)(224303003)(8936002)(7696005)(33656002)(64756008)(55016002)(52536014)(9686003)(54906003)(26005)(83380400001)(478600001)(76116006)(66476007)(86362001)(66446008)(4326008)(6506007)(186003)(2906002)(5660300002)(71200400001)(66946007)(91956017)(66556008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?V01hZ3NVYWNIbVhZMTJuWGtodTV4STd3SVlQUHlyTzdrSDJ6SzlNbEVrNm5N?=
 =?gb2312?B?UVVrMVBKT01VY1JRZGVmWkZ6clNvWlhhUWpkLzRVZWZQTzJvMEo1SzQ5VU9V?=
 =?gb2312?B?SDBRNHh0K1VCRjhvRmdZdDBoRDB0cGs5WEtOcC92NStWLzBUOG95eGRtbDJK?=
 =?gb2312?B?MFYvRGNLS2lXMXkxZ1p2cEJuL1lZOEt3Y0FWOEk1NEI0WkJTUCt5bUlJL1Nv?=
 =?gb2312?B?ZmlFb1Z1bmdhNGlieDJ1ZHV4MlVNa3BYQjNEckZYSTdmTmFoVHBRdXZlUjVS?=
 =?gb2312?B?bjVaOS91TWJBY2xSeG9KaTdWRlFIMWUzSWRrUW95cnF2dEhhakdqY1Nsa3k1?=
 =?gb2312?B?ZHJBWDRTWUEyOUZtcnRRNUtzUkFtYWNSZ0Z4eHkxZVJtZm83VXRlK0dvdTlG?=
 =?gb2312?B?SE50Y1pSZElRTUw3WlNlSy9zcEVuMitUUTN1dzJoeHBUMi90ZGRacXVhZVVQ?=
 =?gb2312?B?ZGs2U2xuMjRFd2hseU5mTjVVb1RjYXoxdWh0OFFOYUdmZWYrVkVZbXgwVjlJ?=
 =?gb2312?B?a280M2w4UFZTM3VNdTFIV3ZQNzhQZUZ5bnVkS1VoZXhFMW9ET3Y1eXhmUGtq?=
 =?gb2312?B?bXNZRjFaeDVVdTJGT0VQTURSSGs2OTVHbUVvVVVvS25xMlRvV2NNM2JUdlJ1?=
 =?gb2312?B?ZEpSY09tRW5QSVVuOXhOLzkwODhvb2NDSmZINGEyWGp1T0x3bnJVc0Y2VVdU?=
 =?gb2312?B?eHdCdG9id0toekp5ZjV0ZGE1TUFKanR4WGZZYldpZlF3TkY5cnVKS0Z4VGF3?=
 =?gb2312?B?UTVoYktwdFpFZG1zVERaOVVyS0NjSysyVEtBdWk4VkRkWGp4YVBFMytQU0lh?=
 =?gb2312?B?UEVRWTFWQlozOTNmRXRIUkY4WHdjcVZlamh3cnVtNjhMMVF0bTh5U3hyTHFB?=
 =?gb2312?B?alFvMFJNRit0MG5sRkY1c1ErclRwcVQydGxFVktjYWRvTVFUUlM2K2ZoaVJP?=
 =?gb2312?B?S0pVckRwektYU3p3dkI2T2djdHNOOGZidHZzUHJ2WmR1WWs2QWlQVllEOWF2?=
 =?gb2312?B?dkNRYWVhWFIxUVFvU2dHOHJabjk4RkdCcDFVTGNlSHovMG5xb2w3K1FDZVBl?=
 =?gb2312?B?RmNpMzk5QXhVcGZ5eWxWc01HaG4rMGduVzZiVzZzQVdIV3BwdXhQeGk2bzBy?=
 =?gb2312?B?YlJla3ljYVIyOHkxNldsRG5OZUVJSXdrbkVvVVBMbXVmcXdWT2RsSFVtR0hx?=
 =?gb2312?B?T0srT2JxSEZ6eTgvQndWaStLUVpHNFFyTTZ4M0hUZGpLL20vTnpnMy8vSis0?=
 =?gb2312?B?NWUwM0N3UnZGSVAvd3JNY2xsMEdqVElpcGZ3L00xMXE0VWU5UzUrK2xDZ1dL?=
 =?gb2312?B?aWpRclJsKyt6SjVIV2Q5QkJXRTlGekkxVittam9iVkd6U01STGVwa0s2KzlZ?=
 =?gb2312?Q?aeHOEqAxRluftnZjen2lI/eEkG9upC2w=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a938f58-571b-4891-1c7c-08d8c4eaeb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2021 06:47:31.6876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DSu80aVQxKn67w1vr88SQYwH5voip/NboVKNpAM7w0c7sv/DsCquWkVU22Zgtw2NFpmY3t1aVHTXZy9P/FHOeL3yQ7C0pPlWBriySzZmKyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3400
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogVWxhZHpp
c2xhdSBSZXpraSA8dXJlemtpQGdtYWlsLmNvbT4Kt6LLzcqxvOQ6IDIwMjHE6jHUwjI5yNUgMjI6
MTkKytW8/sjLOiBaaGFuZywgUWlhbmcKs63LzTogdXJlemtpQGdtYWlsLmNvbTsgcGF1bG1ja0Br
ZXJuZWwub3JnOyBqb2VsQGpvZWxmZXJuYW5kZXMub3JnOyByY3VAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCtb3zOI6IFJlOiBbUEFUQ0ggdjJdIGt2ZnJlZV9y
Y3U6IFJlbGVhc2UgcGFnZSBjYWNoZSB1bmRlciBtZW1vcnkgcHJlc3N1cmUKCltQbGVhc2Ugbm90
ZTogVGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRkcmVzc10KCk9uIEZy
aSwgSmFuIDI5LCAyMDIxIGF0IDA0OjA0OjQyUE0gKzA4MDAsIHFpYW5nLnpoYW5nQHdpbmRyaXZl
ci5jb20gd3JvdGU6Cj4gRnJvbTogWnFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPgo+
Cj4gQWRkIGZyZWUgcGVyLWNwdSBleGlzdGluZyBrcmNwJ3MgcGFnZSBjYWNoZSBvcGVyYXRpb24s
IHdoZW4KPiB0aGUgc3lzdGVtIGlzIHVuZGVyIG1lbW9yeSBwcmVzc3VyZS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPiAtLS0KPiAga2VybmVs
L3JjdS90cmVlLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyNSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMg
Yi9rZXJuZWwvcmN1L3RyZWUuYwo+IGluZGV4IGMxYWUxZTUyZjYzOC4uZWMwOTg5MTBkODBiIDEw
MDY0NAo+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jCj4gKysrIGIva2VybmVsL3JjdS90cmVlLmMK
PiBAQCAtMzU3MSwxNyArMzU3MSw0MCBAQCB2b2lkIGt2ZnJlZV9jYWxsX3JjdShzdHJ1Y3QgcmN1
X2hlYWQgKmhlYWQsIHJjdV9jYWxsYmFja190IGZ1bmMpCj4gIH0KPiAgRVhQT1JUX1NZTUJPTF9H
UEwoa3ZmcmVlX2NhbGxfcmN1KTsKPgo+ICtzdGF0aWMgaW50IGZyZWVfa3JjX3BhZ2VfY2FjaGUo
c3RydWN0IGtmcmVlX3JjdV9jcHUgKmtyY3ApCj4gK3sKPiArICAgICB1bnNpZ25lZCBsb25nIGZs
YWdzOwo+ICsgICAgIHN0cnVjdCBrdmZyZWVfcmN1X2J1bGtfZGF0YSAqYm5vZGU7Cj4gKyAgICAg
aW50IGk7Cj4gKwo+ICsgICAgIGZvciAoaSA9IDA7IGkgPCByY3VfbWluX2NhY2hlZF9vYmpzOyBp
KyspIHsKPiArICAgICAgICAgICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgma3JjcC0+bG9jaywg
ZmxhZ3MpOwo+SSBhbSBub3Qgc3VyZSB3aHkgd2Ugc2hvdWxkIGRpc2FibGUgSVJRcy4gSSB0aGlu
ayBpdCBjYW4gYmUgPmF2b2lkZWQuCgpTdXBwb3NlIGluIG11bHRpIENQVSBzeXN0ZW0sIHRoZSBr
ZnJlZV9yY3Vfc2hyaW5rX3NjYW4gZnVuY3Rpb24gaXMgcnVuaW5nIG9uIENQVTIsCmFuZCB3ZSBq
dXN0IHRyYXZlcnNlIHRvIENQVTIsIGFuZCB0aGVuIGNhbGwgZnJlZV9rcmNfcGFnZV9jYWNoZSBm
dW5jdGlvbiwKaWYgbm90IGRpc2FibGUgaXJxLCBhIGludGVycnVwdCBtYXkgYmUgb2NjdXJzIG9u
IENQVTIgYWZ0ZXIgdGhlIENQVTIgY29ycmVzcG9uZHMgdG8ga3JjcCB2YXJpYWJsZSAncyBsb2Nr
IGJlIGFjcXVpcmVkLCAgaWYgdGhlIGludGVycnVwdCBvciBzb2Z0aXJxIGhhbmRsZXIgZnVuY3Rp
b24gdG8gY2FsbCBrdmZyZWVfcmN1IGZ1bmN0aW9uLCBpbiB0aGlzIGZ1bmN0aW9uICwgYWNxdWly
ZSBDUFUyIGNvcnJlc3BvbmRzIHRvIGtyY3AgdmFyaWFibGUgJ3MgbG9jayAsIHdpbGwgaGFwcGVu
IGRlYWRsb2NrLgpPciBpbiBzaW5nbGUgQ1BVIHNjZW5hcmlvLgoKPiArICAgICAgICAgICAgIGJu
b2RlID0gZ2V0X2NhY2hlZF9ibm9kZShrcmNwKTsKPiArICAgICAgICAgICAgIHJhd19zcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZrcmNwLT5sb2NrLCBmbGFncyk7Cj4gKyAgICAgICAgICAgICBpZiAo
IWJub2RlKQo+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiArICAgICAgICAgICAgIGZy
ZWVfcGFnZSgodW5zaWduZWQgbG9uZylibm9kZSk7Cj4gKyAgICAgfQo+ICsKPiArICAgICByZXR1
cm4gaTsKPiArfQo+QWxzbyBpIGZvcmdvdCB0byBhZGQgaW4gbXkgcHJldmlvdXMgY29tbWVudCB0
byB0aGlzIHBhdGguIENhbiB3ZSA+YWNjZXNzCj50byBwYWdlIGNhY2hlIG9uY2UgYW5kIHRoZW4g
ZG8gdGhlIGRyYWluIHdvcms/IEkgbWVhbiBpZiB3ZSBoYWQgPjEwMCBvYmplY3RzCj5pbiB0aGUg
Y2FjaGUgd2Ugd291bGQgbmVlZCB0byBhY2Nlc3MgdG8gYSBrcmNwLT5sb2NrIDEwMCB0aW1lcy4K
Pgo+V2hhdCBhYm91dCBzb21ldGhpbmcgbGlrZSBiZWxvdzoKPgo+PHNuaXA+Cj5zdGF0aWMgaW50
IGZyZWVfa3JjX3BhZ2VfY2FjaGUoc3RydWN0IGtmcmVlX3JjdV9jcHUgKmtyY3ApCj57Cj4gICAg
ICAgIHN0cnVjdCBsbGlzdF9ub2RlICpwYWdlX2xpc3QsICpwb3MsICpuOwo+ICAgICAgICBpbnQg
ZnJlZWQgPSAwOwo+Cj4gICAgICAgIHJhd19zcGluX2xvY2soJmtyY3AtPmxvY2spOwo+ICAgICAg
ICBwYWdlX2xpc3QgPSBsbGlzdF9kZWxfYWxsKCZrcmNwLT5ia3ZjYWNoZSk7Cj4gICAgICAgIGty
Y3AtPm5yX2Jrdl9vYmpzID0gMDsKPiAgICAgICAgcmF3X3NwaW5fdW5sb2NrKCZrcmNwLT5sb2Nr
KTsKPgo+ICAgICAgICBsbGlzdF9mb3JfZWFjaF9zYWZlKHBvcywgbiwgcGFnZV9saXN0KSB7Cj4g
ICAgICAgICAgICAgICAgZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKSBwb3MpOwo+ICAgICAgICAg
ICAgICAgIGZyZWVkKys7Cj4gICAgICAgIH0KPgo+ICAgICAgICByZXR1cm4gZnJlZWQ7Cj59Cj48
c25pcD4KCiAgdGhpcyBjaGFuZ2UgbG9va3MgYmV0dGVyLgogIFRoYW5rcyAKICBRaWFuZwo+ICsK
PiAgc3RhdGljIHVuc2lnbmVkIGxvbmcKPiAga2ZyZWVfcmN1X3Nocmlua19jb3VudChzdHJ1Y3Qg
c2hyaW5rZXIgKnNocmluaywgc3RydWN0IHNocmlua19jb250cm9sICpzYykKPiAgewo+ICAgICAg
IGludCBjcHU7Cj4gICAgICAgdW5zaWduZWQgbG9uZyBjb3VudCA9IDA7Cj4gKyAgICAgdW5zaWdu
ZWQgbG9uZyBmbGFnczsKPgo+ICAgICAgIC8qIFNuYXBzaG90IGNvdW50IG9mIGFsbCBDUFVzICov
Cj4gICAgICAgZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkgewo+ICAgICAgICAgICAgICAgc3Ry
dWN0IGtmcmVlX3JjdV9jcHUgKmtyY3AgPSBwZXJfY3B1X3B0cigma3JjLCBjcHUpOwo+Cj4gICAg
ICAgICAgICAgICBjb3VudCArPSBSRUFEX09OQ0Uoa3JjcC0+Y291bnQpOwo+ICsKPiArICAgICAg
ICAgICAgIHJhd19zcGluX2xvY2tfaXJxc2F2ZSgma3JjcC0+bG9jaywgZmxhZ3MpOwo+ICsgICAg
ICAgICAgICAgY291bnQgKz0ga3JjcC0+bnJfYmt2X29ianM7Cj4gKyAgICAgICAgICAgICByYXdf
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgma3JjcC0+bG9jaywgZmxhZ3MpOwo+U2hvdWxkIHdlIGRp
c2FibGUgaXJxcz8KCj4KPiAgICAgICByZXR1cm4gY291bnQ7Cj4gQEAgLTM1OTgsNiArMzYyMSw4
IEBAIGtmcmVlX3JjdV9zaHJpbmtfc2NhbihzdHJ1Y3Qgc2hyaW5rZXIgKnNocmluaywgc3RydWN0
IHNocmlua19jb250cm9sICpzYykKPiAgICAgICAgICAgICAgIHN0cnVjdCBrZnJlZV9yY3VfY3B1
ICprcmNwID0gcGVyX2NwdV9wdHIoJmtyYywgY3B1KTsKPgo+ICAgICAgICAgICAgICAgY291bnQg
PSBrcmNwLT5jb3VudDsKPiArICAgICAgICAgICAgIGNvdW50ICs9IGZyZWVfa3JjX3BhZ2VfY2Fj
aGUoa3JjcCk7Cj4gKwo+ICAgICAgICAgICAgICAgcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZrcmNw
LT5sb2NrLCBmbGFncyk7Cj4gICAgICAgICAgICAgICBpZiAoa3JjcC0+bW9uaXRvcl90b2RvKQo+
ICAgICAgICAgICAgICAgICAgICAgICBrZnJlZV9yY3VfZHJhaW5fdW5sb2NrKGtyY3AsIGZsYWdz
KTsKPiAtLQo+IDIuMTcuMQoKVGhhbmtzIQoKLS0KVmxhZCBSZXpraQo=
