Return-Path: <SRS0=uuXb=B5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC883C433E1
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 03:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DF520657
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 03:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="aIilUakJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgHSDBC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:01:02 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:57441
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbgHSDBA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 23:01:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4Ls2Mgvm+0sAZskHoOHARYODI8jP5lZPY0sw71yXXNfD7UPCw3T//MoVOGbr3aU8LMWZNSj/7rZ4Q+PhqcIiynkW40c8StjiOpu8NU39kctpE4hWgINxBD9WvoLqcVgC3sxBHHXU/9tWb+bDE763GLNfqso4QPUQLhGROM53RWJ8qPacUCppm6HFDvp5BihY6PIg4YjRWXM/UMfE8SxAxUzpjJo+myHlo1V66vM0Mziq4Xnaoq7gPmQB5GXrriPxUTd/+D6Mys6omRC61IhQAB3n8SFaq/mqj8OkA8FIzX4oefUPByHmoiwn0OC4ulWEEW44qThuV4bf4y2ka3zyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4anXAotL0Pcwi5XJ/0+HRNTG+TWvFrSlCxtYY0LBxo=;
 b=TJwIw3nStoZ1ee192HMsRAyfu1PHgaDBQbgoSGDC2KxVFrNCPas6TYd9MEpCRtMJNjGzucfCOGkqZuy8NDfwXIUGXxxx4AO4eliPrww4Dxnx/PX18VJ6YPzMSQEPOI5lQrei9U8btaZqRjfC8VtW+j71ZOj8Dn2a7HbMAlY/NvTnyYt4ZlWsMPo9OpqHtdgwuRUI6Ezx207CVpMdAiBw6iK+wZ+pKGgdX4EWhGYZZu/51AEEmgYEC9IcSQngHF0kZDAoQOWtXq+F60M4+REBmeMGEFLywnrAj0jgACBX90dyGQv7Xa8hd8z8BnIdEJ0R7361cw/QI9DnUY0YZtQjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4anXAotL0Pcwi5XJ/0+HRNTG+TWvFrSlCxtYY0LBxo=;
 b=aIilUakJwsQzVeRwNL2fvVFPGQ99QhQEJbXPlD0SBiW56Pz+VPmoG50kRCwRwRr9b+m/cFh6pjlrEaLUvG4+W2pk76QTGeXazjA/EnizeTXW9uhtA4dvLooZL/HAgRiYitjl4Br1k7tTVfIQ3pqjAzJpefZw9M1OEb26l59j+yY=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 03:00:55 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b%7]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 03:00:55 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSByY3U6IHNocmluayBlYWNoIHBvc3NpYmxlIGNwdSBr?=
 =?gb2312?Q?rcp?=
Thread-Topic: [PATCH] rcu: shrink each possible cpu krcp
Thread-Index: AQHWcga7sO8bq15f3keIlQdVriJj06k388MAgATsxwCAAUJ8gIAAHKGAgAAidYCAAA5TgIAAAh6AgAAh+ACAACseKw==
Date:   Wed, 19 Aug 2020 03:00:55 +0000
Message-ID: <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636>
 <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
 <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72> <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>,<CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
In-Reply-To: <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: joelfernandes.org; dkim=none (message not signed)
 header.d=none;joelfernandes.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5adb7e2-5b46-4e21-a8ec-08d843ec173a
x-ms-traffictypediagnostic: BY5PR11MB3974:
x-microsoft-antispam-prvs: <BY5PR11MB3974312B7BF2DC853E426744FF5D0@BY5PR11MB3974.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3OkvStO6yADUWzTNi+yLq5ylpcG3wxR6FEFJYReJkYR/8kC2b+xbv00d8qemyd0pYy+WYjdD7EKcZAcDN7pFWsm98b/WbeVOn7ssbVLG3KBWi5dVnfl/Nztsi5Wfflrd70jfUmIdRajO46p0wxSM7LGm2VCJ/fxHQs/QI3eY7UBafZD2Ul5ThtUDgpp4WzQx8dUP51zhnlXa7jThYTTtf+L40zr9gAVophJuTJD+rUA1fpJjjpGTT+HAs76iPakqCn4eRjLpnmwwICgvO3CAO2FQFzA/s/4zPelr8ci4DVfwYmIN5h+5LBVePh9Rdsq1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39840400004)(396003)(346002)(86362001)(55016002)(83380400001)(71200400001)(186003)(7696005)(54906003)(53546011)(6506007)(33656002)(316002)(9686003)(478600001)(66574015)(76116006)(4326008)(8936002)(5660300002)(2906002)(110136005)(224303003)(26005)(66446008)(52536014)(66946007)(64756008)(66556008)(66476007)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xhWwdYZHSk+byCkha1p6ByH/m2Kg+R2OlG637j+nh5Ceig4wqwZ32Bczcijl/I4zKHNCEwk3BgMdXEay+f0F5lJ5oVTyAKk0kMSUzg4iD2n202j+qYCmvFRPz6OkR6dmlR9JNscIr93M7EiV7nxNJLu6C15Rv7RoM5cKz8Chjt3rsbz1+IPGrT1wViBg0oU7JxKyf+CrSn/7FXetLV4bolAl9EFZHxNGRcuFwAtuXr21AyT9QCc43ydbXztXbYey5ACYZLt082XYliPu8mQWLr7DIRsWHyx6AOIFzf/iIr1MI4Dq2AlF1oeO38QCpsZvJ9H/L3N9FCPPLn5ut2p6ltsnYN3d6xrx6TfqszSn7hAUzjwqL1hM50y4QfpNkK2OpLH5VcbfAESXuCKodzaLgvZKbBZNPambn3/LyRICwe8mbzwVQlWjFXLS7zHMkRw/ldD3KHVkRRFELSN04T3kaSYIVzJ/4IU+zEnJqs1uUgphZwTYFPx2NKx1acmjVP/XncXBr/ggN8AYkLjUYYYgYu7vBSW4mCjMGVYzc5FFp/O+429i5DXqOddJd4l9SNFY3EHCP9lbpuD1VXdTgHf9z3RCG2qLPgmgEivQxtBU2pDUcZoBzgdY0xykAvC2VZc0wc0X29MvVIef5VwV4g+tlg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5adb7e2-5b46-4e21-a8ec-08d843ec173a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 03:00:55.2848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdhOTDL4zRqjPRWQQumolP8egV6Oxab3bAmP/182qXD/AeZtsXFJtxCThBRhMi+bwI9M3uxk0SfzIVUhQLQhQxPKVK2MxByolW69yOsNIg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3974
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogbGludXgt
a2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLW93bmVyQHZnZXIua2Vy
bmVsLm9yZz4gtPqx7SBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4Kt6LL
zcqxvOQ6IDIwMjDE6jjUwjE5yNUgODowNArK1bz+yMs6IFBhdWwgRS4gTWNLZW5uZXkKs63LzTog
VWxhZHppc2xhdSBSZXpraTsgWmhhbmcsIFFpYW5nOyBKb3NoIFRyaXBsZXR0OyBTdGV2ZW4gUm9z
dGVkdDsgTWF0aGlldSBEZXNub3llcnM7IExhaSBKaWFuZ3NoYW47IHJjdTsgTEtNTArW98ziOiBS
ZTogW1BBVENIXSByY3U6IHNocmluayBlYWNoIHBvc3NpYmxlIGNwdSBrcmNwCgpPbiBUdWUsIEF1
ZyAxOCwgMjAyMCBhdCA2OjAyIFBNIFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9y
Zz4gd3JvdGU6Cgo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5jIGIva2VybmVsL3Jj
dS90cmVlLmMKPiA+IGluZGV4IGI4Y2NkN2I1YWY4Mi4uNmRlY2I5YWQyNDIxIDEwMDY0NAo+ID4g
LS0tIGEva2VybmVsL3JjdS90cmVlLmMKPiA+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5jCj4gPiBA
QCAtMjMzNiwxMCArMjMzNiwxNSBAQCBpbnQgcmN1dHJlZV9kZWFkX2NwdSh1bnNpZ25lZCBpbnQg
Y3B1KQo+ID4gIHsKPiA+ICAgICAgICAgc3RydWN0IHJjdV9kYXRhICpyZHAgPSBwZXJfY3B1X3B0
cigmcmN1X2RhdGEsIGNwdSk7Cj4gPiAgICAgICAgIHN0cnVjdCByY3Vfbm9kZSAqcm5wID0gcmRw
LT5teW5vZGU7ICAvKiBPdXRnb2luZyBDUFUncyByZHAgJiBybnAuICovCj4gPiArICAgICAgIHN0
cnVjdCBrZnJlZV9yY3VfY3B1ICprcmNwOwo+ID4KPiA+ICAgICAgICAgaWYgKCFJU19FTkFCTEVE
KENPTkZJR19IT1RQTFVHX0NQVSkpCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPgo+
ID4gKyAgICAgICAvKiBEcmFpbiB0aGUga2NycCBvZiB0aGlzIENQVS4gSVJRcyBzaG91bGQgYmUg
ZGlzYWJsZWQ/ICovCj4gPiArICAgICAgIGtyY3AgPSB0aGlzX2NwdV9wdHIoJmtyYykKPiA+ICsg
ICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZrcmNwLT5tb25pdG9yX3dvcmssIDApOwo+ID4g
Kwo+ID4KPiA+IEEgY3B1IGNhbiBiZSBvZmZsaW5lZCBhbmQgaXRzIGtycCB3aWxsIGJlIHN0dWNr
IHVudGlsIGEgc2hyaW5rZXIgaXMgaW52b2x2ZWQuCj4gPiBNYXliZSBiZSBuZXZlci4KPgo+IERv
ZXMgdGhlIHNhbWUgYXBwbHkgdG8gaXRzIGttYWxsb2MoKSBwZXItQ1BVIGNhY2hlcz8gIElmIHNv
LCBJIGhhdmUgYQo+IGhhcmQgdGltZSBnZXR0aW5nIHRvbyB3b3JyaWVkIGFib3V0IGl0LiAgOy0p
Cgo+TG9va2luZyBhdCBzbGFiX29mZmxpbmVfY3B1KCkgLCB0aGF0IGNhbGxzIGNhbmNlbF9kZWxh
eWVkX3dvcmtfc3luYygpCj5vbiB0aGUgY2FjaGUgcmVhcGVyIHdobydzIGpvYiBpcyB0byBmbHVz
aCB0aGUgcGVyLWNwdSBjYWNoZXMuIFNvIEkKPmJlbGlldmUgZHVyaW5nIENQVSBvZmZsaW5pbmcs
IHRoZSBwZXItY3B1IHNsYWIgY2FjaGVzIGFyZSBmbHVzaGVkLgo+Cj50aGFua3MsCj4KID4tIEpv
ZWwKCldoZW4gY3B1IGdvaW5nIG9mZmxpbmUsIHRoZSBzbHViIG9yIHNsYWIgb25seSBmbHVzaCBm
cmVlIG9iamVjdHMgaW4gb2ZmbGluZSBjcHUgY2FjaGUsICBwdXQgdGhlc2UgZnJlZSBvYmplY3Rz
IGluIG5vZGUgbGlzdCAgb3IgcmV0dXJuIGJ1ZGR5IHN5c3RlbSwgIGZvciB0aG9zZSB3aG8gYXJl
IHN0aWxsIGluIHVzZSwgdGhleSBzdGlsbCBzdGF5IG9mZmxpbmUgY3B1IGNhY2hlLgoKSWYgd2Ug
d2FudCBjbGVhbiBwZXItY3B1ICJrcmNwIiBvYmplY3RzIHdoZW4gY3B1IGdvaW5nIG9mZmxpbmUu
CiB3ZSBzaG91bGQgZnJlZSAia3JjcCIgY2FjaGUgb2JqZWN0cyBpbiAicmN1dHJlZV9vZmZsaW5l
X2NwdSIsIHRoaXMgZnVuYyBiZSBjYWxsZWQgYmVmb3JlIG90aGVyIHJjdSBjcHUgb2ZmbGluZSBm
dW5jLiBhbmQgdGhlbiAicmN1dHJlZV9vZmZsaW5lX2NwdSIgd2lsbCBiZSBjYWxsZWQgaW4gImNw
dWhwLyV1IiBwZXItY3B1IHRocmVhZC4KCmRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUuYyBi
L2tlcm5lbC9yY3UvdHJlZS5jCmluZGV4IDhjZTc3ZDlhYzcxNi4uMTgxMmQ0YTFhYzFiIDEwMDY0
NAotLS0gYS9rZXJuZWwvcmN1L3RyZWUuYworKysgYi9rZXJuZWwvcmN1L3RyZWUuYwpAQCAtMzk1
OSw2ICszOTU5LDcgQEAgaW50IHJjdXRyZWVfb2ZmbGluZV9jcHUodW5zaWduZWQgaW50IGNwdSkK
ICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOwogICAgICAgIHN0cnVjdCByY3VfZGF0YSAqcmRw
OwogICAgICAgIHN0cnVjdCByY3Vfbm9kZSAqcm5wOworICAgICAgIHN0cnVjdCBrZnJlZV9yY3Vf
Y3B1ICprcmNwOwogCiAgICAgICAgcmRwID0gcGVyX2NwdV9wdHIoJnJjdV9kYXRhLCBjcHUpOwog
ICAgICAgIHJucCA9IHJkcC0+bXlub2RlOwpAQCAtMzk3MCw2ICszOTcxLDExIEBAIGludCByY3V0
cmVlX29mZmxpbmVfY3B1KHVuc2lnbmVkIGludCBjcHUpCiAKICAgICAgICAvLyBub2h6X2Z1bGwg
Q1BVcyBuZWVkIHRoZSB0aWNrIGZvciBzdG9wLW1hY2hpbmUgdG8gd29yayBxdWlja2x5CiAgICAg
ICAgdGlja19kZXBfc2V0KFRJQ0tfREVQX0JJVF9SQ1UpOworCisgICAgICAga3JjcCA9IHBlcl9j
cHVfcHRyKCZrcmMsIGNwdSk7CisgICAgICAgcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZrcmNwLT5s
b2NrLCBmbGFncyk7CisgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZrcmNwLT5tb25pdG9y
X3dvcmssIDApOworICAgICAgIHJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZrcmNwLT5sb2Nr
LCBmbGFncyk7CiAgICAgICAgcmV0dXJuIDA7CiB9Cgp0aGFua3MsCgpacWlhbmc=
