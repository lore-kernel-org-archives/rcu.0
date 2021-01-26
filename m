Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79C2C433DB
	for <rcu@archiver.kernel.org>; Tue, 26 Jan 2021 14:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6E7230FD
	for <rcu@archiver.kernel.org>; Tue, 26 Jan 2021 14:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbhAZO72 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:59:28 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:18144
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390792AbhAZJea (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 Jan 2021 04:34:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaMBbjVxV57nK+SK9LoL0cvbzYnxr6ot/5Xt90r3h710kGqE5NJJwJLv4MSb/zTI15Pf3gbUq2/ojrHvvFoMq/uLe1Nv6wquhRdlmu8NaVqJoo+i8HimRftRNgiaoYauMDH1UWVb3/iN2CPhb4FELoxEKPqzIC5qZpnaijM34UDLV9wPpKm0TKeAR7yQkn7B0Gey9HuWgJivWlSicj58XLdCP6UHkgxFV2lE0Lc06b6j2X+nJymtqzDKNqDKeUT/2cknZeyUotGCiwijY8aq2yBAB8OMKsqH4HKM3Zk1I5YTN+D/85EHtqx8/RY4Cy8gzyZcPU1RB2psdbz4cOo8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Fr/9LVuoCz7acfX59ZRHmD6RTlJEnKCtqC+/DNjag=;
 b=a2cwQusrmMfJqS+2bCp2Il+xzTNummlbDvRAQSJrpM8i65xUyzFZmjPvNNdqY7ECZa5lIvVZxYcfHPlU9MyYQ088DCFEnQ8IWMOgClWMSoOvHVMSfURLe0EbH4bLLkyTeP7ag6gvknDX8Qt3k50Es0eCrKWF4AyXx8+MTak5Nib5HdVFunZFL+dg4fWOJ+9xf31kpvAUH190XFTKbMkEtQea2mwfUJycxDvlnjPKg7R1fgFesOHjnxoeWbdtKgQB5ma7oojrzOZkFsAFrJo+T88U39LefsRq3PCsTmstW1QbW5QAk5onLtvRF6U/Pk0u0tiEe/yyaPI5WiJR/3QzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Fr/9LVuoCz7acfX59ZRHmD6RTlJEnKCtqC+/DNjag=;
 b=qFyi+v9pp7ysxiiwjWLE4lF8MkMZ3UTpOTL44B7/67DNWUhYzb1NufSprzN4bUgQSoXuM4Py0Po4CrJYUe4z4uSR8Jv8B1k18SMthkWJpGLhqqsix/pn7byEjsYwid87Jxdw530VdvGL6+Zcn95tufd2XTXSGBfMVAFsQ/evWvI=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3192.namprd11.prod.outlook.com (2603:10b6:a03:7a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Tue, 26 Jan
 2021 09:33:40 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 09:33:40 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: =?gb2312?B?u9i4tDogu9i4tDogu9i4tDogW1BBVENIIDMvM10ga3ZmcmVlX3JjdTogdXNl?=
 =?gb2312?Q?_migrate=5Fdisable/enable()?=
Thread-Topic: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIDMvM10ga3ZmcmVlX3JjdTogdXNlIG1pZ3Jh?=
 =?gb2312?Q?te=5Fdisable/enable()?=
Thread-Index: AQHW70jTxon3D/CQOEadHLsdcTdvhao00RgBgAKIBACAADuklYAABkd8gADINgCAAUns1A==
Date:   Tue, 26 Jan 2021 09:33:40 +0000
Message-ID: <BYAPR11MB2632016E5622E83656CF805BFFBC9@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120162148.1973-3-urezki@gmail.com>
 <BYAPR11MB263252B1BD73A38DD8C0AF4EFFBF0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210124215700.GB1076@pc636>
 <BYAPR11MB2632939DA9FB6AC1B25FA847FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632ACF42A88E65F1C164021FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>,<20210125134930.GA1869@pc638.lan>
In-Reply-To: <20210125134930.GA1869@pc638.lan>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abd2e9a5-d312-42a4-badc-08d8c1dd7732
x-ms-traffictypediagnostic: BYAPR11MB3192:
x-microsoft-antispam-prvs: <BYAPR11MB31928EDEBEFB91DC84C59919FFBC9@BYAPR11MB3192.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: knsamIIR3R0xjU1rlNudS4R/NSabJUdqjNoDjxQYbcqrZCJtBt4bl8HQhBh/9/9jAQm4TPgQLYf80UIpWCcgfhDw+pGrfCmyyZpZjJRVAU0y4nbB5HRw+ZgOLcTh8ckbjL6aDCF7Cie/L/6EAIy4PF8PhUTqTPuLdSivrb68emThcWNgbNrzR7Qlme5ycB1zEtjanIQ9zM07AbLNdSEjVDQNuULCdxpcH7vdAhV+1XMsBD83kxFtMObQajjmXm4dAS8MWXShDKtG9f9Yll9ACi9e2Yw9s6+vSC7g5Oo3rPZRISot1VcUnBI/F2zH9bYAXYxLuEwwAOgnkg7+IiZs2cUx3FwU/xVqMKm0nfpfGHbvj8FZcuBQlJ0yEJ0HKQXUrWcx+wQoBaU0pei3nRGorxiUV6j6/Hbh/g9TsJ83+NJj7qokGTiHnjBh1BFQFPG1eWl2TAiPEHBQuThrEiUJfj3pZDnB8OuE+gyKWOoqIovX6V80CB00OR58PBm4ljY2xZJFvpwYaIH4qIp0gZmIqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39850400004)(136003)(396003)(33656002)(55016002)(71200400001)(316002)(6916009)(2906002)(7416002)(4326008)(52536014)(5660300002)(186003)(26005)(224303003)(91956017)(66946007)(478600001)(9686003)(6506007)(54906003)(86362001)(66446008)(7696005)(76116006)(83380400001)(66556008)(8936002)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?RWRhR2NwZ0x1WVBUeno1YjA4VVNwcWM2eDlOUjYyVzRvNFREZVFTYTVTUW1Z?=
 =?gb2312?B?OTI0RGVETXdSOWxLUGdPYWIrT0FhTEFKZENGaXR5dGYwVXl0QzZoOHVzbXIy?=
 =?gb2312?B?MXUwc2kxdVEzUFJNeGVJL1JoSitEN0I5MDJCaXZQMXdzRFRyTUR5MmRJcWdV?=
 =?gb2312?B?UDlsY09OOUZsa2hkWmtLT2sxN1B4RHo1NUpZb3FKQkhVc0NUZXNNdkxEb2tK?=
 =?gb2312?B?Z1lXamJRNlNrS1A2RkgrODU0RzlHQTlmMitmbk1uU0czMXF1ZDVMRmpxbjJn?=
 =?gb2312?B?aWtLQm9neFA1U2J6ODVxZ2szUUtpOXZOcnhyNFJOMW1JVm5aeW9EL1Q2YzU0?=
 =?gb2312?B?YW1YaHRyVWc2SDNKT0tmQlgvY0E0T1k4WnRZQzg5NWh5Q1VyNkYwRklqVzJj?=
 =?gb2312?B?VjBKTUI2Rk85dWU1SFg1K3p2dTgwV0JMcnd5SmRoS0xKY0xJbHQyVnBzSTlu?=
 =?gb2312?B?cGRtMmhsVmJEcUN5ai9pOTFHdHRFZnNuREp2Tkk1Yk1IT2dKSzN5REQxNmZo?=
 =?gb2312?B?V0pVNzJnQzNDTndDYmVCKzN3QWlIY1I5cy8yeVRqMHE0M0gwY2o2ZmZaYWdE?=
 =?gb2312?B?eFBuZ2gveWgyQmw2R0Ryam5Ceml1YjliRm9MUCtLSm5tVkJQVkhXdWFKbEpK?=
 =?gb2312?B?R3VySWZFdHFSQllpc3Z2a3htT2IzVHdaSU1ISWFhZ25Gc3ZFK2ltdGtsaUhW?=
 =?gb2312?B?dDhLcEVUeGV5TEtRUkV1eFFMdXJXWjgwLzdhKzRJOHdvZkdrVTJrMDRnWGJQ?=
 =?gb2312?B?VzdkYjY0cHMvR0gvWCtvajdVbDJ2c2YzM3phK244eEVubUlWL2xnc3ZBMTJw?=
 =?gb2312?B?bnM2Zlh6WXI4QllMWnBodHpSQXl5QUI5bS9QeTJzM2ZFT2ptN20reWtyTk1C?=
 =?gb2312?B?TWRHdFhmczhoL0JsMUxDODBlNGhhR09JRFR2V0xNa3I3dFhNZXFpVjJ0eElG?=
 =?gb2312?B?OEwzS2Y0aFpRSUdNZ3FoMCtDbWd1bjN0anhFU0RNRU9rdWpHSnZoSkhwWitI?=
 =?gb2312?B?ZVdqenBWZ0lRc05aU1FySEJ3MHdESDFiTmdFQ2NmOGV0c0ErS21rZzJZQkpQ?=
 =?gb2312?B?ZlplblBrQ1RpZDVmZkd2aUpvUEpsU3VldG9PWEdtOVY4c3g2RC8wSnlYaFpG?=
 =?gb2312?B?WkJudFN3cnl4UXVabVBIQmxuT1NNei9jWnJIUXg0MzkxdVFPc3BLbnBpUS91?=
 =?gb2312?B?SmNmNnZYZjVUVTBDQVBmRnNkR0xIOVovcDZWNS9TSmQvaStQblFUNWFaOGpm?=
 =?gb2312?B?dFBPckpoTVgwNndacWFhdUVsdzkvK3A2Nlk0Q1daaWM3bUFtZ2RDKzRyeWVJ?=
 =?gb2312?B?RkhrOUJBV2VBV3M3MzRtMUVaMlJVb01pTHVlcWcrMGs5YjYrTGo4ZmZDVFEx?=
 =?gb2312?Q?uDlLARq1ZLv8/EWdvDd6DB+Zsid9IMr8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd2e9a5-d312-42a4-badc-08d8c1dd7732
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 09:33:40.3302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxkciD4iuUGla7hz/wEO6NUDbGMqa+nYV8RHue2ovt8MF3lBUf81h+uiTRCWTCtZdqE+jSmX8wHu47yfIUaDnKLMBXJKM2auG2NV2Ylndfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3192
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogVWxhZHpp
c2xhdSBSZXpraSA8dXJlemtpQGdtYWlsLmNvbT4Kt6LLzcqxvOQ6IDIwMjHE6jHUwjI1yNUgMjE6
NDkKytW8/sjLOiBaaGFuZywgUWlhbmcKs63LzTogVWxhZHppc2xhdSBSZXpraTsgTEtNTDsgUkNV
OyBQYXVsIEUgLiBNY0tlbm5leTsgTWljaGFlbCBFbGxlcm1hbjsgQW5kcmV3IE1vcnRvbjsgRGFu
aWVsIEF4dGVuczsgRnJlZGVyaWMgV2Vpc2JlY2tlcjsgTmVlcmFqIFVwYWRoeWF5OyBKb2VsIEZl
cm5hbmRlczsgUGV0ZXIgWmlqbHN0cmE7IE1pY2hhbCBIb2NrbzsgVGhvbWFzIEdsZWl4bmVyOyBU
aGVvZG9yZSBZIC4gVHMnbzsgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcjsgT2xla3NpeSBBdnJh
bWNoZW5rbwrW98ziOiBSZTogu9i4tDogu9i4tDogW1BBVENIIDMvM10ga3ZmcmVlX3JjdTogdXNl
IG1pZ3JhdGVfZGlzYWJsZS9lbmFibGUoKQoKPiA+SGVsbG8sIFpoYW5nLgo+Cj4gPiA+X19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gPreivP7IyzogVWxhZHppc2xh
dSBSZXpraSAoU29ueSkgPHVyZXpraUBnbWFpbC5jb20+Cj4gPiA+t6LLzcqxvOQ6IDIwMjHE6jHU
wjIxyNUgMDoyMQo+ID4gPsrVvP7IyzogTEtNTDsgUkNVOyBQYXVsIEUgLiBNY0tlbm5leTsgTWlj
aGFlbCBFbGxlcm1hbgo+ID4gPrOty806IEFuZHJldyBNb3J0b247IERhbmllbCBBeHRlbnM7IEZy
ZWRlcmljIFdlaXNiZWNrZXI7IE5lZXJhaiA+VXBhZGh5YXk7IEpvZWwgRmVybmFuZGVzOyBQZXRl
ciBaaWpsc3RyYTsgTWljaGFsIEhvY2tvOyBUaG9tYXMgPkdsZWl4bmVyOyBUaGVvZG9yZSBZIC4g
VHMnbzsgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcjsgVWxhZHppc2xhdSA+UmV6a2k7IE9sZWtz
aXkgQXZyYW1jaGVua28KPiA+ID7W98ziOiBbUEFUQ0ggMy8zXSBrdmZyZWVfcmN1OiB1c2UgbWln
cmF0ZV9kaXNhYmxlL2VuYWJsZSgpCj4gPiA+Cj4gPiA+U2luY2UgdGhlIHBhZ2UgaXMgb2J0YWlu
ZWQgaW4gYSBmdWxseSBwcmVlbXB0aWJsZSBjb250ZXh0LCBkcm9wcGluZwo+ID4gPnRoZSBsb2Nr
IGNhbiBsZWFkIHRvIG1pZ3JhdGlvbiBvbnRvIGFub3RoZXIgQ1BVLiBBcyBhIHJlc3VsdCBhIHBy
ZXYuCj4gPiA+Ym5vZGUgb2YgdGhhdCBDUFUgbWF5IGJlIHVuZGVydXRpbGlzZWQsIGJlY2F1c2Ug
YSBkZWNpc2lvbiBoYXMgYmVlbgo+ID4gPm1hZGUgZm9yIGEgQ1BVIHRoYXQgd2FzIHJ1biBvdXQg
b2YgZnJlZSBzbG90cyB0byBzdG9yZSBhIHBvaW50ZXIuCj4gPiA+Cj4gPiA+bWlncmF0ZV9kaXNh
YmxlL2VuYWJsZSgpIGFyZSBub3cgaW5kZXBlbmRlbnQgb2YgUlQsIHVzZSBpdCBpbiBvcmRlcgo+
ID4gPnRvIHByZXZlbnQgYW55IG1pZ3JhdGlvbiBkdXJpbmcgYSBwYWdlIHJlcXVlc3QgZm9yIGEg
c3BlY2lmaWMgQ1BVIGl0Cj4gPiA+aXMgcmVxdWVzdGVkIGZvci4KPiA+Cj4gPgo+ID4gSGVsbG8g
UmV6a2kKPiA+Cj4gPiBUaGUgY3JpdGljYWwgbWlncmF0ZV9kaXNhYmxlL2VuYWJsZSgpIGFyZWEg
aXMgbm90IGFsbG93ZWQgdG8gYmxvY2ssIHVuZGVyIFJUIGFuZCBub24gUlQuCj4gPiBUaGVyZSBp
cyBzdWNoIGEgZGVzY3JpcHRpb24gaW4gcHJlZW1wdC5oCj4gPgo+ID4KPiA+ICogTm90ZXMgb24g
dGhlIGltcGxlbWVudGF0aW9uLgo+ID4gICoKPiA+ICAqIFRoZSBpbXBsZW1lbnRhdGlvbiBpcyBw
YXJ0aWN1bGFybHkgdHJpY2t5IHNpbmNlIGV4aXN0aW5nIGNvZGUgcGF0dGVybnMKPiA+ICAqIGRp
Y3RhdGUgbmVpdGhlciBtaWdyYXRlX2Rpc2FibGUoKSBub3IgbWlncmF0ZV9lbmFibGUoKSBpcyBh
bGxvd2VkIHRvIGJsb2NrLgo+ID4gICogVGhpcyBtZWFucyB0aGF0IGl0IGNhbm5vdCB1c2UgY3B1
c19yZWFkX2xvY2soKSB0byBzZXJpYWxpemUgYWdhaW5zdCBob3RwbHVnLAo+ID4gICogbm9yIGNh
biBpdCBlYXNpbHkgbWlncmF0ZSBpdHNlbGYgaW50byBhIHBlbmRpbmcgYWZmaW5pdHkgbWFzayBj
aGFuZ2Ugb24KPiA+ICAqIG1pZ3JhdGVfZW5hYmxlKCkuCj4gPgo+ID5Ib3cgaSBpbnRlcnByZXQg
aXQgaXMgbWlncmF0ZV9lbmFibGUoKS9taWdyYXRlX2Rpc2FibGUoKSBhcmUgbm90IGFsbG93ZWQg
dG8KPiA+dXNlIGFueSBibG9ja2luZyBwcmltaXRpdmVzLCBzdWNoIGFzIHJ3c2VtL211dGV4ZXMv
ZXRjLiBpbiBvcmRlciB0byBtYXJrIGEKPiA+Y3VycmVudCBjb250ZXh0IGFzIG5vbi1taWdyYXRh
YmxlLgo+ID4KPiA+dm9pZCBtaWdyYXRlX2Rpc2FibGUodm9pZCkKPiA+ewo+ID4gc3RydWN0IHRh
c2tfc3RydWN0ICpwID0gY3VycmVudDsKPiA+Cj4gPiBpZiAocC0+bWlncmF0aW9uX2Rpc2FibGVk
KSB7Cj4gPiAgcC0+bWlncmF0aW9uX2Rpc2FibGVkKys7Cj4gPiAgcmV0dXJuOwo+ID4gfQo+Cj4g
PiBwcmVlbXB0X2Rpc2FibGUoKTsKPiA+IHRoaXNfcnEoKS0+bnJfcGlubmVkKys7Cj4gPiBwLT5t
aWdyYXRpb25fZGlzYWJsZWQgPSAxOwo+ID4gcHJlZW1wdF9lbmFibGUoKTsKPiA+fQo+ID4KPiA+
SXQgZG9lcyBub3RoaW5nIHRoYXQgcHJldmVudHMgeW91IGZyb20gZG9pbmcgc2NoZWR1bGUoKSBv
ciBldmVuIHdhaXQgZm9yIGFueQo+ID5ldmVudChtdXRleCBzbG93IHBhdGggYmVoYXZpb3VyKSwg
d2hlbiB0aGUgcHJvY2VzcyBpcyByZW1vdmVkIGZyb20gdGhlIHJ1bi1xdWV1ZS4KPiA+SSBtZWFu
IGFmdGVyIHRoZSBtaWdyYXRlX2Rpc2FibGUoKSBpcyBpbnZva2VkLiBPciBpIG1pc3Mgc29tZXRo
aW5nPwo+Cj4gSGVsbG8gUmV6a2kKPgo+IFNvcnJ5LCB0aGVyZSdzIHNvbWV0aGluZyB3cm9uZyB3
aXRoIHRoZSBwcmV2aW91cyBkZXNjcmlwdGlvbi4KPiBUaGVyZSBhcmUgdGhlIGZvbGxvd2luZyBz
Y2VuYXJpb3MKPgo+IER1ZSB0byBtaWdyYXRlX2Rpc2FibGUgd2lsbCBpbmNyZWFzZSAgdGhpc19y
cSgpLT5ucl9waW5uZWQgLCBhZnRlciB0aGF0Cj4gaWYgZ2V0X2ZyZWVfcGFnZSBiZSBibG9ja2Vk
LCBhbmQgdGhpcyB0aW1lLCBDUFUgZ29pbmcgb2ZmbGluZSwKPiB0aGUgc2NoZWRfY3B1X3dhaXRf
ZW1wdHkoKSBiZSBjYWxsZWQgaW4gcGVyLWNwdSAiY3B1aHAvJWQiIHRhc2ssCj4gYW5kIGJlIGJs
b2NrZWQuCj4KPkJ1dCBhZnRlciB0aGUgbWlncmF0ZV9kaXNhYmxlKCkgaXMgaW52b2tlZCBhIENQ
VSBjYW4gbm90IGJlIGJyb3VnaHQgZG93bi4KPklmIHRoZXJlIGFyZSBwaW5uZWQgdGFza3MgYSAi
aG90cGx1ZyBwYXRoIiB3aWxsIGJlIGJsb2NrZWQgb24gYmFsYW5jZV9ob3RwbHVnX3dhaXQoKQo+
Y2FsbC4KCj4gYmxvY2tlZDoKPiBzY2hlZF9jcHVfd2FpdF9lbXB0eSgpCj4gewo+ICAgICAgIHN0
cnVjdCBycSAqcnEgPSB0aGlzX3JxKCk7Cj4gICAgICAgIHJjdXdhaXRfd2FpdF9ldmVudCgmcnEt
PmhvdHBsdWdfd2FpdCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBycS0+bnJfcnVubmlu
ZyA9PSAxICYmICFycV9oYXNfcGlubmVkX3Rhc2tzKHJxKSwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBUQVNLX1VOSU5URVJSVVBUSUJMRSk7Cj4gfQo+Cj5FeGFjdGx5LgoKPiB3YWtldXA6
Cj4gYmFsYW5jZV9wdXNoKCkKPiB7Cj4gICAgICAgICBpZiAoaXNfcGVyX2NwdV9rdGhyZWFkKHB1
c2hfdGFzaykgfHwgaXNfbWlncmF0aW9uX2Rpc2FibGVkKHB1c2hfdGFzaykpIHsKPgo+ICAgICAg
ICAgICAgICAgICBpZiAoIXJxLT5ucl9ydW5uaW5nICYmICFycV9oYXNfcGlubmVkX3Rhc2tzKHJx
KSAmJgo+ICAgICAgICAgICAgICAgICAgICAgcmN1d2FpdF9hY3RpdmUoJnJxLT5ob3RwbHVnX3dh
aXQpKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmF3X3NwaW5fdW5sb2NrKCZycS0+bG9j
ayk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmN1d2FpdF93YWtlX3VwKCZycS0+aG90cGx1
Z193YWl0KTsKPiAgICAgICAgICAgICAgICAgICAgICAgICByYXdfc3Bpbl9sb2NrKCZycS0+bG9j
ayk7Cj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+ICAgICAg
ICAgfQo+IH0KPgo+IE9uZSBvZiB0aGUgY29uZGl0aW9ucyBmb3IgdGhpcyBmdW5jdGlvbiB0byB3
YWtlIHVwIGlzICJycS0+bnJfcGlubmVkICA9PSAwIgo+IHRoYXQgaXMgdG8gc2F5IGJldHdlZW4g
bWlncmF0ZV9kaXNhYmxlL2VuYWJsZSwgaWYgYmxvY2tlZCB3aWxsIGRlZmVjdCBDUFUgZ29pbmcK
PiBvZmZsaW5lIGxvbmdlciBibG9ja2luZyB0aW1lLgo+Cj5JbmRlZWQsIHRoZSBob3RwbHVnIHRp
bWUgaXMgYWZmZWN0ZWQuIEZvciBleGFtcGxlIGluIGNhc2Ugb2Ygd2FpdGluZyBmb3IKPmEgbXV0
ZXggdG8gYmUgcmVsZWFzZWQsIGFuIG93bmVyIHdpbGwgd2FrZXVwIHdhaXRlcnMuIEJ1dCB0aGlz
IGlzIGV4cGVjdGFibGUuCgo+Cj4gSSdtIG5vdCBzdXJlIHRoYXQncyBhIHByb2JsZW2jrGFuZCBJ
IGRpZG4ndCBmaW5kIGl0IGluIHRoZSBrZXJuZWwgY29kZSAgYmV0d2Vlbgo+ICBtaWdyYXRlX2Rp
c2FibGUvZW5hYmxlIHBvc3NpYmxlIHNsZWVwIGNhbGxzLgo+Cj5Gb3IgZXhhbXBsZSB6M2ZvbGQu
YzoKCj4vKiBBZGQgdG8gdGhlIGFwcHJvcHJpYXRlIHVuYnVkZGllZCBsaXN0ICovCj5zdGF0aWMg
aW5saW5lIHZvaWQgYWRkX3RvX3VuYnVkZGllZChzdHJ1Y3QgejNmb2xkX3Bvb2wgKnBvb2wsCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB6M2ZvbGRfaGVhZGVyICp6aGRy
KQo+ewo+ICAgICAgIGlmICh6aGRyLT5maXJzdF9jaHVua3MgPT0gMCB8fCB6aGRyLT5sYXN0X2No
dW5rcyA9PSAwIHx8Cj4gICAgICAgICAgICAgICAgICAgICAgICB6aGRyLT5taWRkbGVfY2h1bmtz
ID09IDApIHsKPiAgICAgICAgICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICp1bmJ1ZGRpZWQ7Cj4g
ICAgICAgICAgICAgIGludCBmcmVlY2h1bmtzID0gbnVtX2ZyZWVfY2h1bmtzKHpoZHIpOwo+Cj4g
ICAgICAgICAgICAgICAgbWlncmF0ZV9kaXNhYmxlKCk7Cj4gICAgICAgICAgICAgICAgdW5idWRk
aWVkID0gdGhpc19jcHVfcHRyKHBvb2wtPnVuYnVkZGllZCk7Cj4gICAgICAgICAgICAgICAgc3Bp
bl9sb2NrKCZwb29sLT5sb2NrKTsKPiAgICAgICAgICAgICAgICBsaXN0X2FkZCgmemhkci0+YnVk
ZHksICZ1bmJ1ZGRpZWRbZnJlZWNodW5rc10pOwo+ICAgICAgICAgICAgICAgIHNwaW5fdW5sb2Nr
KCZwb29sLT5sb2NrKTsKPiAgICAgICAgICAgICAgICB6aGRyLT5jcHUgPSBzbXBfcHJvY2Vzc29y
X2lkKCk7Cj4gICAgICAgICAgICAgICAgbWlncmF0ZV9lbmFibGUoKTsKPiAgICAgICAgfQo+fQoK
PmZvciBQUkVFTVBUX1JUIGtlcm5lbCBhIHNwaW5sb2NrIGlzIGNvbnZlcnRlZCB0byBydC1tdXRl
eCwgdGh1cyBpdCBjYW4gc2xlZXAuCgogSSBmb3Jnb3QgdGhhdC4gVGhhbmsgeW91IGZvciB5b3Vy
IGV4cGxhbmF0aW9uLgoKIAo+LS0KPlZsYWQgUmV6a2kK
