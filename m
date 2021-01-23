Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349EBC433E0
	for <rcu@archiver.kernel.org>; Sat, 23 Jan 2021 09:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA3823358
	for <rcu@archiver.kernel.org>; Sat, 23 Jan 2021 09:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbhAWJcz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 23 Jan 2021 04:32:55 -0500
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:15136
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbhAWJcw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 23 Jan 2021 04:32:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW4daVxWcf+QfrL9ol3A6WtMnEyxxTpsLYsRb5QRRpcnR7DmxGxvPZOTUwyT8M0OQVLkIrXfyLVxCTZNgk4qxQ8GWAFqWeEP3SFrB16hCCOcP+WalYXntz7JP/STh/tkWr4DeEToFggWdrdhMJHC7032IMyS5ak8nYVugF7/PpBxvLnEM9MreqjIMtKeWO43OUzUNhqIHYQfl91qOfCIwji8hxrMNVHR9R81VQdFRLWdwVua+0teY70VhpnwlTm2R9gOKqSG+yMBxtauVD2xYtQQ702CBA/40D/tR3Ecu+BUGNRM7h8NnbP924wct7x/WKMGSNIyVpdtTz6HdUEiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwAxFbN2GBpZaQfUam5ZdL9WZsZcCK0hafHIVk6FEB0=;
 b=LOHb6SYBrpAYDH+9EIaUW4Pbkkn27p6R5eyN6xqn3D3I3YwPda96QzfC9tGWW8BkphReQXmoLdbB6FSYr3GIhowkJO67qyLJhLNSTrJpAtFdIQmu/LdNz+avIns7uRD7nOq7ofhgxK3TsGxi/9mdxjBDyrCWFHSgEuthl/zMxrnwJVTa4HV4caJtlQg7mnKlwk7dk2gd22lWNe8nVJmedtXw1HCFjoF6EcYo9wBjojAAOkWSr/TCiiT1PljLfm2K9CuRLS6FXgnYjdz7BKMLagpK+ZTrIyQm1WqfHwFDOnqY8Ms9+iKu8KQeKlPglJo99W6gSuDStcmomSTwR/4k3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwAxFbN2GBpZaQfUam5ZdL9WZsZcCK0hafHIVk6FEB0=;
 b=VUu1l4yaG1oM2iGcDmx7G20fChb1AbL1UNHua96WCm8YExQSCsXvNH9vuT0Ew8UiKpRgTMmFAxLqs9P75hAR6brVc2lLZA/164ElqpFo/5jRon0LicYK+TbY/swXROhk6NF3xcnWiUXNxN/IoPNWYmxmaFGKJwbjbToFLt386TY=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Sat, 23 Jan
 2021 09:31:30 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3763.014; Sat, 23 Jan 2021
 09:31:30 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIDMvM10ga3ZmcmVlX3JjdTogdXNlIG1pZ3JhdGVfZGlz?=
 =?gb2312?Q?able/enable()?=
Thread-Topic: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
Thread-Index: AQHW70jTxon3D/CQOEadHLsdcTdvhao00RgB
Date:   Sat, 23 Jan 2021 09:31:30 +0000
Message-ID: <BYAPR11MB263252B1BD73A38DD8C0AF4EFFBF0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210120162148.1973-1-urezki@gmail.com>,<20210120162148.1973-3-urezki@gmail.com>
In-Reply-To: <20210120162148.1973-3-urezki@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [106.39.148.97]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16968858-db5e-4231-6186-08d8bf81aa5d
x-ms-traffictypediagnostic: SJ0PR11MB4864:
x-microsoft-antispam-prvs: <SJ0PR11MB4864DD13B1BEF5AF91A570EDFFBF9@SJ0PR11MB4864.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92CEQLTUfkz0jr2BxdmCzZ4vxA7OAeUFrPN8Sw9R7BiNDCPfQOLhBw+4YUESJ1okc3/apE445B/GlXerJdyFk4wxYBdYZ3hsYbzFDno/ns/hdu0D35z9Yxop2VJ9cTZ/78c3zDhUNKL8oXDrjnZKYJy6tyHQAPKT/eJg6RNIJ7OAHEYUIe2KdBHAlyzK9/vHucPnFvca4m4zu573iafn7hzXzXi/UI5iVKPJ4knIWdABGF2IQOpuSWzIboYnnorml+bBlDmHnPAMqaJn61ypMjK69x4ga9ukwVaN9rr/G9uEhS/lx64tPbgdIFDVziT8SXXciFSdpkVWOxofyfvrDbfez7Xx57JLOGnfaUa2vmWPvt94MOlk38yW+uL8RCVn2ZmDt9zCHv0+Tj6ZIcCxHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39850400004)(76116006)(91956017)(66446008)(52536014)(7416002)(66556008)(64756008)(7696005)(5660300002)(66946007)(66476007)(86362001)(83380400001)(71200400001)(54906003)(8936002)(110136005)(2906002)(4326008)(33656002)(478600001)(224303003)(9686003)(316002)(6506007)(186003)(26005)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?VVNWVlpuVmtnTStiVm5zRkdJUXhua2JFY3FOTENQdyt2WEU1Ykx2TlpvL0xw?=
 =?gb2312?B?dlgwNXpHc0JkSFFJb2t0aVNRVHBaOG12NmdrdWZWbTJEeEJBS2VBcFNxaE9H?=
 =?gb2312?B?K2JqY2J3TTZONElGL3N5cTBwelRuTWlVSE9hWk9DU0pkdm00NHprL0YvNllo?=
 =?gb2312?B?RGlySUdZYzdxMXNwNlZjZHY4V1JOWllXMExvSzFKOGExZ0ZKaDRaVU41Y2pC?=
 =?gb2312?B?MythNkVuVWk1cGxFczFpd3MwQWVGVlJxYnJmOVRneFNibmpZcjh4cGRDZ05N?=
 =?gb2312?B?Y3I5dnBoTjFuUmFMQWFhdktsV2E0ek9uanVXaHVIdTNGZ3BJcG1kOUFvWExl?=
 =?gb2312?B?eHFDZ3FjVHVoQXJnT0o0OStmN3NxTHNGMDA0Q2FrZ0VpZlNYSDljdHU0VitC?=
 =?gb2312?B?Mi8vV3hZM1lNQzd4Yjk5YkZ6TmJYSW13TUFXVkNzRklmd1RYTGlkeWZPeFNU?=
 =?gb2312?B?c2k4bjVIQVE0VExRbmkzRVhBUG0rUGcyaDh1WVp4TzNMS2tBOHhFR0hLYVBw?=
 =?gb2312?B?d2d0VzB0T1NNanBRNlRDcHIvL1E5RlpZaURSZ0srYTgza0pZQSswRnlBS25h?=
 =?gb2312?B?VWhXNjRkTnp2VW85UjErU3hFZzY2S0N5Uk9BSWoyRE1SNkVRMGFvMHQ3eE9X?=
 =?gb2312?B?QTZvSXJFSmgyZzhJa21rcS9xTU5uU2twYkhZbGtOcSs5Q29ibWU4eU1ZSEpE?=
 =?gb2312?B?a3FkNWtuWS96Y2g0dzNpSmR0YVdaSjhHNkdkRDJZTzRKMFB1L1NwNzBZeHNN?=
 =?gb2312?B?R0Z4ak5HdHljY00yWlJzVXJRbTNHcDhyZ0JRV3JyaUFna3hMNXFLUEFOcGda?=
 =?gb2312?B?elJVMDQ2WHdkMHpjZ29CdUVrZ3lmZHZuQUQrUnJXL1hGY3lpWElpSHRibDkw?=
 =?gb2312?B?U21UcGtMcmptSXJ1N3kyTFB1WFNnQks0V0w4dVo2ZWo0MXByMjZrUzZybGsw?=
 =?gb2312?B?Rnh4Ym43UnN2eXJVUk04WnBXYTVTdlAvaVdKT1d4QytjYi9SeFZPZ1NKK2hC?=
 =?gb2312?B?ZDljdkRnMG1WT0FlSUZuL3VTc0lFWU9Dang4b1lGNE5jZ0xlZm5HUVE2bkVm?=
 =?gb2312?B?K2dXVldEc3cwNTdXWnE5QXB2NEg0ZEFGZGt3aXRjeGhFWE5rNGdEOXo3TWh1?=
 =?gb2312?B?UHFrN2M3dlBqYTlrZm9HYmx1d0JpaWxzUzl4eWRLNFBtQTE3SEhvdm9DMGsw?=
 =?gb2312?B?WHcvTVZyc0dpSTlaWE54dHJjeEZXTWZMZndjVEZGd1ZHTFN6amYvR0IyM0pK?=
 =?gb2312?B?TGJza25RWUZhZzg2bFFqbFVoK0R6VlRDQldvRHljM3l2RlpvbXYrUlIzYWZ3?=
 =?gb2312?Q?Fgxf7f1fmqQpE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16968858-db5e-4231-6186-08d8bf81aa5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 09:31:30.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKO/u/tnxp7Zi2AatfmVYOeEBJ96txuIvDC/L2AGVvThoUskBiFdx38U0ZxOtZOIyIbNg6A/PXGrIcd5gNZZYyfuewfjLDcgiZy29n2zYds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Cgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+t6K8/sjLOiBVbGFk
emlzbGF1IFJlemtpIChTb255KSA8dXJlemtpQGdtYWlsLmNvbT4KPreiy83KsbzkOiAyMDIxxOox
1MIyMcjVIDA6MjEKPsrVvP7IyzogTEtNTDsgUkNVOyBQYXVsIEUgLiBNY0tlbm5leTsgTWljaGFl
bCBFbGxlcm1hbgo+s63LzTogQW5kcmV3IE1vcnRvbjsgRGFuaWVsIEF4dGVuczsgRnJlZGVyaWMg
V2Vpc2JlY2tlcjsgTmVlcmFqID5VcGFkaHlheTsgSm9lbCBGZXJuYW5kZXM7IFBldGVyIFppamxz
dHJhOyBNaWNoYWwgSG9ja287IFRob21hcyA+R2xlaXhuZXI7IFRoZW9kb3JlIFkgLiBUcydvOyBT
ZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yOyBVbGFkemlzbGF1ID5SZXpraTsgT2xla3NpeSBBdnJh
bWNoZW5rbwo+1vfM4jogW1BBVENIIDMvM10ga3ZmcmVlX3JjdTogdXNlIG1pZ3JhdGVfZGlzYWJs
ZS9lbmFibGUoKQo+Cj5TaW5jZSB0aGUgcGFnZSBpcyBvYnRhaW5lZCBpbiBhIGZ1bGx5IHByZWVt
cHRpYmxlIGNvbnRleHQsIGRyb3BwaW5nCj50aGUgbG9jayBjYW4gbGVhZCB0byBtaWdyYXRpb24g
b250byBhbm90aGVyIENQVS4gQXMgYSByZXN1bHQgYSBwcmV2Lgo+Ym5vZGUgb2YgdGhhdCBDUFUg
bWF5IGJlIHVuZGVydXRpbGlzZWQsIGJlY2F1c2UgYSBkZWNpc2lvbiBoYXMgYmVlbgo+bWFkZSBm
b3IgYSBDUFUgdGhhdCB3YXMgcnVuIG91dCBvZiBmcmVlIHNsb3RzIHRvIHN0b3JlIGEgcG9pbnRl
ci4KPgo+bWlncmF0ZV9kaXNhYmxlL2VuYWJsZSgpIGFyZSBub3cgaW5kZXBlbmRlbnQgb2YgUlQs
IHVzZSBpdCBpbiBvcmRlcgo+dG8gcHJldmVudCBhbnkgbWlncmF0aW9uIGR1cmluZyBhIHBhZ2Ug
cmVxdWVzdCBmb3IgYSBzcGVjaWZpYyBDUFUgaXQKPmlzIHJlcXVlc3RlZCBmb3IuCgoKSGVsbG8g
UmV6a2kKClRoZSBjcml0aWNhbCBtaWdyYXRlX2Rpc2FibGUvZW5hYmxlKCkgYXJlYSBpcyBub3Qg
YWxsb3dlZCB0byBibG9jaywgdW5kZXIgUlQgYW5kIG5vbiBSVC4gIApUaGVyZSBpcyBzdWNoIGEg
ZGVzY3JpcHRpb24gaW4gcHJlZW1wdC5oIAoKCiogTm90ZXMgb24gdGhlIGltcGxlbWVudGF0aW9u
LgogKgogKiBUaGUgaW1wbGVtZW50YXRpb24gaXMgcGFydGljdWxhcmx5IHRyaWNreSBzaW5jZSBl
eGlzdGluZyBjb2RlIHBhdHRlcm5zCiAqIGRpY3RhdGUgbmVpdGhlciBtaWdyYXRlX2Rpc2FibGUo
KSBub3IgbWlncmF0ZV9lbmFibGUoKSBpcyBhbGxvd2VkIHRvIGJsb2NrLgogKiBUaGlzIG1lYW5z
IHRoYXQgaXQgY2Fubm90IHVzZSBjcHVzX3JlYWRfbG9jaygpIHRvIHNlcmlhbGl6ZSBhZ2FpbnN0
IGhvdHBsdWcsCiAqIG5vciBjYW4gaXQgZWFzaWx5IG1pZ3JhdGUgaXRzZWxmIGludG8gYSBwZW5k
aW5nIGFmZmluaXR5IG1hc2sgY2hhbmdlIG9uCiAqIG1pZ3JhdGVfZW5hYmxlKCkuCgoKSG93IGFi
b3V0IHRoZSBmb2xsb3dpbmcgY2hhbmdlczoKCmRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUu
YyBiL2tlcm5lbC9yY3UvdHJlZS5jCmluZGV4IGU3YTIyNmFiZmYwZC4uMmFhMTk1MzdhYzdjIDEw
MDY0NAotLS0gYS9rZXJuZWwvcmN1L3RyZWUuYworKysgYi9rZXJuZWwvcmN1L3RyZWUuYwpAQCAt
MzQ4OCwxMiArMzQ4OCwxMCBAQCBhZGRfcHRyX3RvX2J1bGtfa3JjX2xvY2soc3RydWN0IGtmcmVl
X3JjdV9jcHUgKiprcmNwLAogICAgICAgICAgICAgICAgICAgICAgICAoKmtyY3ApLT5ia3ZoZWFk
W2lkeF0tPm5yX3JlY29yZHMgPT0gS1ZGUkVFX0JVTEtfTUFYX0VOVFIpIHsKICAgICAgICAgICAg
ICAgIGJub2RlID0gZ2V0X2NhY2hlZF9ibm9kZSgqa3JjcCk7CiAgICAgICAgICAgICAgICBpZiAo
IWJub2RlICYmIGNhbl9hbGxvYykgewotICAgICAgICAgICAgICAgICAgICAgICBtaWdyYXRlX2Rp
c2FibGUoKTsKICAgICAgICAgICAgICAgICAgICAgICAga3JjX3RoaXNfY3B1X3VubG9jaygqa3Jj
cCwgKmZsYWdzKTsKICAgICAgICAgICAgICAgICAgICAgICAgYm5vZGUgPSAoc3RydWN0IGt2ZnJl
ZV9yY3VfYnVsa19kYXRhICopCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19nZXRf
ZnJlZV9wYWdlKEdGUF9LRVJORUwgfCBfX0dGUF9SRVRSWV9NQVlGQUlMIHwgX19HRlBfTk9NRU1B
TExPQyB8IF9fR0ZQX05PV0FSTik7Ci0gICAgICAgICAgICAgICAgICAgICAgICprcmNwID0ga3Jj
X3RoaXNfY3B1X2xvY2soZmxhZ3MpOwotICAgICAgICAgICAgICAgICAgICAgICBtaWdyYXRlX2Vu
YWJsZSgpOworICAgICAgICAgICAgICAgICAgICAgICByYXdfc3Bpbl9sb2NrX2lycXNhdmUoJigq
a3JjcCktPmxvY2ssICpmbGFncyk7CiAgICAgICAgICAgICAgICB9CiAKICAgICAgICAgICAgICAg
IGlmICghYm5vZGUpCgoKVGhhbmtzClFpYW5nCgoKCj4KPlNpZ25lZC1vZmYtYnk6IFVsYWR6aXNs
YXUgUmV6a2kgKFNvbnkpIDx1cmV6a2lAZ21haWwuY29tPgo+LS0tCj4ga2VybmVsL3JjdS90cmVl
LmMgfCAyICsrCj4xIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPmRpZmYgLS1naXQg
YS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9yY3UvdHJlZS5jCj5pbmRleCA0NTQ4MDk1MTRj
OTEuLmNhZDM2MDc0MzY2ZCAxMDA2NDQKPi0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jCj4rKysgYi9r
ZXJuZWwvcmN1L3RyZWUuYwo+QEAgLTM0ODksMTAgKzM0ODksMTIgQEAgYWRkX3B0cl90b19idWxr
X2tyY19sb2NrKHN0cnVjdCA+a2ZyZWVfcmN1X2NwdSAqKmtyY3AsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAoKmtyY3ApLT5ia3ZoZWFkW2lkeF0tPm5yX3JlY29yZHMgPT0gPktWRlJFRV9CVUxL
X01BWF9FTlRSKSB7Cj4gICAgICAgICAgICAgICAgYm5vZGUgPSBnZXRfY2FjaGVkX2Jub2RlKCpr
cmNwKTsKPiAgICAgICAgICAgICAgICBpZiAoIWJub2RlICYmIGNhbl9hbGxvYykgewo+KyAgICAg
ICAgICAgICAgICAgICAgICAgbWlncmF0ZV9kaXNhYmxlKCk7Cj4gICAgICAgICAgICAgICAgICAg
ICAgICBrcmNfdGhpc19jcHVfdW5sb2NrKCprcmNwLCAqZmxhZ3MpOwo+ICAgICAgICAgICAgICAg
ICAgICAgICAgYm5vZGUgPSAoc3RydWN0IGt2ZnJlZV9yY3VfYnVsa19kYXRhICopCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVMIHwgPl9f
R0ZQX1JFVFJZX01BWUZBSUwgfCBfX0dGUF9OT01FTUFMTE9DIHwgX19HRlBfTk9XQVJOKTsKPiAg
ICAgICAgICAgICAgICAgICAgICAgKmtyY3AgPSBrcmNfdGhpc19jcHVfbG9jayhmbGFncyk7Cj4r
ICAgICAgICAgICAgICAgICAgICAgICBtaWdyYXRlX2VuYWJsZSgpOwo+ICAgICAgICAgICAgICAg
IH0KPgo+ICAgICAgICAgICAgICAgIGlmICghYm5vZGUpCj4tLQo+Mi4yMC4xCgo=
