Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AD3C433DB
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 02:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFC522C9C
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 02:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbhAYC2n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Jan 2021 21:28:43 -0500
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:38752
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbhAYBv1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Jan 2021 20:51:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmWl6PPiLAV8gec7yNOr6Trzl6uzrnhNyXudQyZXWkDnl0SVH+URktKjohXpA6/V0k4kf4U4qYBZ6rSAO5MXU31393Z7/b8T/5ZY0M3JaiNHr4YIeM0NJPYCi7aZnwht/MhypMC9SpbQhSoMwjzQWE4zbdQpBeHaKLJ8WfAjvck5vFuN45CW8kRJZsXKYNwhPx/KimLDoGgFLpRRhvgQRSAeqnQeLcAxqjt9iHOE0qbpl6Ont9GBwmGDiZuQWbq/4lRHIGBm96msuBpJxdr4A0dmsueJkEdDDusDtK/dr4CkkuALzW1H4V3VwRJC7HqD/7r5G6zA9bVJaHcYk0957A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnP4zBSKTpJ9ib0L/NCRowxQZw354UwxissNoqGvghc=;
 b=k4j1o3iGB/bNyUnhFxddhLN6xtnaMFxuN8KnGNLjkIug7MYRAC18ZRyIYhBJcpwGHRgWj9rT/zSqMWb0l+T8hWzGl2b+UJop+vIIeE4rLhkf8QAuDArGHad14bGIM1vaIjF4VkcRuhLzGcRtSK+8l0iMMq3m+egQaxal7EoN0Wv0ttEHi0mGxtqgMUDamwxTyM2uTxdrk2zggB5XgQTkPuwxjJ1GN761OG1ttFdBRWFd7cFKWVbxRh0rqUwXDk/fMi/YAWpbGP6seENPXSYoPghSrlKfH/Rg0Zgjpy3Sl7ZShIH9c5RIYus7QgBm7Y7G6Sva7B47iuSdEqIyLVTTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnP4zBSKTpJ9ib0L/NCRowxQZw354UwxissNoqGvghc=;
 b=C60jR/uE4J/EzO07GnZ9XkZTcw5HjhasPqF4vM9pVeZKKTpueEa2Bp+A422hYckc2iorc/J7Nn8KgKf7elm6qD/5zkfhszx4fsBW69v1KljR08EVEsGzRJkfm3sh2NDz5XXKXBIgehmK6ZI62lQ4u8R5uVADHafldf8mGO5tWXQ=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Mon, 25 Jan
 2021 01:50:38 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 01:50:38 +0000
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
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIDMvM10ga3ZmcmVlX3JjdTogdXNlIG1pZ3Jh?=
 =?gb2312?Q?te=5Fdisable/enable()?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIIDMvM10ga3ZmcmVlX3JjdTogdXNlIG1pZ3JhdGVfZGlz?=
 =?gb2312?Q?able/enable()?=
Thread-Index: AQHW70jTxon3D/CQOEadHLsdcTdvhao00RgBgAKIBACAADuklQ==
Date:   Mon, 25 Jan 2021 01:50:38 +0000
Message-ID: <BYAPR11MB2632939DA9FB6AC1B25FA847FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120162148.1973-3-urezki@gmail.com>
 <BYAPR11MB263252B1BD73A38DD8C0AF4EFFBF0@BYAPR11MB2632.namprd11.prod.outlook.com>,<20210124215700.GB1076@pc636>
In-Reply-To: <20210124215700.GB1076@pc636>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da6bc1af-a3c1-472d-777e-08d8c0d39d4b
x-ms-traffictypediagnostic: BY5PR11MB4226:
x-microsoft-antispam-prvs: <BY5PR11MB4226DB766108158E28FF030BFFBD0@BY5PR11MB4226.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D70MTXpBqYIkPW+ToYQfpOH1bG5XRG9QBuasdebA9iwOoQgtcvP9EnIfIl5Kb03pMbA0jl5qI4ngfRyBlgnJU3zMYCUcMhjb0ifFm4gDO15QYrwxne9VJF/wLIJFoKtwwwXpicWsHZy145TtC1+XOS5hPxY2ds5OzqkYOqihwxUzpDP4BIx0LiQFxeQWhNzTURehQRWzi9lZiN1buVJLxY4HgobHUpweceTngXRARILwnnbMYFS26MHvpXBl6p1PtBrVDwcFPyxQREC6P41MwhBnE5LTbvXZ8Ob4uI9/r5n8Nr/l1zQ2BfXlWe9DkekEd8WpwWevXZox75hAdkprQs4VE2agCW0utu/go2R6ZhSe4M6awFZ1hGnT5VufRqdFnLMeXb8yDFleOd9aG/yTCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(39830400003)(346002)(6506007)(26005)(186003)(83380400001)(33656002)(4326008)(9686003)(55016002)(7696005)(224303003)(66556008)(66476007)(66946007)(76116006)(6916009)(7416002)(91956017)(66446008)(64756008)(86362001)(52536014)(316002)(5660300002)(2906002)(478600001)(54906003)(8936002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?RCtGRGRhSzQ3ZU5QV2lBR0haeHdVZHd6cFE2ZWNKMEVTbHVrSmg4Ym43bU95?=
 =?gb2312?B?QW95WDJUdi9HdE5PZnE4Z2QvUldVczlNNWRCTGxWdi93dkZOTGtoV2U1WHpU?=
 =?gb2312?B?S29RdkNBL2t2QjQrdExPa0plSnFKOTBEYjQ4cUl0MEo0V3hJdi9Id21lTFZ0?=
 =?gb2312?B?SnVma1ZpdUM2TXFNWXA0bnRqMnRVdXNvU0V2ZmlMenFRRDh3VnhRZ0loZjE3?=
 =?gb2312?B?bFZhYkx2Qy9ZZnArSHBKVEQwQ1JZanUrZzRMblgvbDBqMWhFYkpERW5QejI3?=
 =?gb2312?B?cG1RVkNDZnZEMktBQzZibVlNczdEcEtnbUJEcDA5RmluWENRQWgxZCtWMXYv?=
 =?gb2312?B?SUFEa0V6VkU1VXh1VmVNL0FaajJ5SlF6aGtuaUpnRDYwSmlPcU5BZStzTnI5?=
 =?gb2312?B?b1JWVjBmT1dKYUlzU2ZlZkdVeE50cE9MWjloL0VYUStJdnIvbnFlRHJvQzQx?=
 =?gb2312?B?OHAvSUY0SVIwQW5TRU5kSkF0YTRUb3pzTlJGZTFhN1hYdGs2RE1IR2VTQVJU?=
 =?gb2312?B?QmE3TGxLTEZZRVc3dUNQYjBXems3UWdIS1Bsb2l2cXFxMit2cWxMYitDQzBl?=
 =?gb2312?B?M0ZNdFV3VW1kSWl0SVJmRXFwd05tUkVIWFVadWxxYVFDSEYxbFRvNlFjRTF4?=
 =?gb2312?B?ZEljUmJva2laZHlJN3dDRUtmd1ZLQzBmdDJOZ04xU21mU3VZTnNoTXhCckdq?=
 =?gb2312?B?ZWQrTW5RNTg3WnlCaTlLUDhYa1BySkZ4VWk5TVd3Wm5ZNlRJekZENmlJQVYy?=
 =?gb2312?B?RkpUYjlWdmNVOVY1ZmtnU1BKTW9wOG1US2JNMFhTM1hwMUtYNHdNMkVsbEpp?=
 =?gb2312?B?d25FMSs4U1U1Y0hDcVR4Y3hpS1VoaWhHYnp2N1VYVjdNQlhuOFgyZnhoT2Ni?=
 =?gb2312?B?Vk5maG9xVVN0S09abDVlakZVbng5SDVjSm4wTElGdzJYdFk3MWVIejlqa215?=
 =?gb2312?B?S3RrY0g3S2JhQzlwbHRQc3Qza1hLT21jVE5uNHh5SldiRXU0d0NQOVczL1N0?=
 =?gb2312?B?V0NJUjJ3YUZVYnBzVHZYd2dKMStGaWlEdmlsU1FDRFVsVmJzQkxVM0xDQUVp?=
 =?gb2312?B?cjJ0YmRJM0dzbjlBVkFsOUNaanBhWkY0aHZneTFiSDFidFUxVU9Na25RcW5C?=
 =?gb2312?B?S0ROc0FuTW10eVMzV0phU2c2bE9zQnNCcmx4V1RuQlhJSFBrRTZLdHByMy9Z?=
 =?gb2312?B?WUYzRzl1OCtPOFVwMVVMclVqRjJET0tTK21GaDIzQ1VFR1FMRmpSdUFrekJv?=
 =?gb2312?B?VUdyVmw2eGo2U05JNVM3MjRvODEzYU9vNHJSMEZ4RjJhYnJEVjdqVnUzY2xX?=
 =?gb2312?Q?HHV/usoCA+d90=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6bc1af-a3c1-472d-777e-08d8c0d39d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 01:50:38.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alx8Hz5gx10BhotJE1eAMPSKcLuWCLq33oZyITRq7xtcTaKnnlT/R+bRxwymwLENDk5P6LMCLS13C8SOs5f+t5SqoQo/NQhN39X6sAlKPNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogVWxhZHpp
c2xhdSBSZXpraSA8dXJlemtpQGdtYWlsLmNvbT4Kt6LLzcqxvOQ6IDIwMjHE6jHUwjI1yNUgNTo1
NwrK1bz+yMs6IFpoYW5nLCBRaWFuZwqzrcvNOiBVbGFkemlzbGF1IFJlemtpIChTb255KTsgTEtN
TDsgUkNVOyBQYXVsIEUgLiBNY0tlbm5leTsgTWljaGFlbCBFbGxlcm1hbjsgQW5kcmV3IE1vcnRv
bjsgRGFuaWVsIEF4dGVuczsgRnJlZGVyaWMgV2Vpc2JlY2tlcjsgTmVlcmFqIFVwYWRoeWF5OyBK
b2VsIEZlcm5hbmRlczsgUGV0ZXIgWmlqbHN0cmE7IE1pY2hhbCBIb2NrbzsgVGhvbWFzIEdsZWl4
bmVyOyBUaGVvZG9yZSBZIC4gVHMnbzsgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcjsgT2xla3Np
eSBBdnJhbWNoZW5rbwrW98ziOiBSZTogu9i4tDogW1BBVENIIDMvM10ga3ZmcmVlX3JjdTogdXNl
IG1pZ3JhdGVfZGlzYWJsZS9lbmFibGUoKQoKPkhlbGxvLCBaaGFuZy4KCj4gPl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+t6K8/sjLOiBVbGFkemlzbGF1IFJlemtp
IChTb255KSA8dXJlemtpQGdtYWlsLmNvbT4KPiA+t6LLzcqxvOQ6IDIwMjHE6jHUwjIxyNUgMDoy
MQo+ID7K1bz+yMs6IExLTUw7IFJDVTsgUGF1bCBFIC4gTWNLZW5uZXk7IE1pY2hhZWwgRWxsZXJt
YW4KPiA+s63LzTogQW5kcmV3IE1vcnRvbjsgRGFuaWVsIEF4dGVuczsgRnJlZGVyaWMgV2Vpc2Jl
Y2tlcjsgTmVlcmFqID5VcGFkaHlheTsgSm9lbCBGZXJuYW5kZXM7IFBldGVyIFppamxzdHJhOyBN
aWNoYWwgSG9ja287IFRob21hcyA+R2xlaXhuZXI7IFRoZW9kb3JlIFkgLiBUcydvOyBTZWJhc3Rp
YW4gQW5kcnplaiBTaWV3aW9yOyBVbGFkemlzbGF1ID5SZXpraTsgT2xla3NpeSBBdnJhbWNoZW5r
bwo+ID7W98ziOiBbUEFUQ0ggMy8zXSBrdmZyZWVfcmN1OiB1c2UgbWlncmF0ZV9kaXNhYmxlL2Vu
YWJsZSgpCj4gPgo+ID5TaW5jZSB0aGUgcGFnZSBpcyBvYnRhaW5lZCBpbiBhIGZ1bGx5IHByZWVt
cHRpYmxlIGNvbnRleHQsIGRyb3BwaW5nCj4gPnRoZSBsb2NrIGNhbiBsZWFkIHRvIG1pZ3JhdGlv
biBvbnRvIGFub3RoZXIgQ1BVLiBBcyBhIHJlc3VsdCBhIHByZXYuCj4gPmJub2RlIG9mIHRoYXQg
Q1BVIG1heSBiZSB1bmRlcnV0aWxpc2VkLCBiZWNhdXNlIGEgZGVjaXNpb24gaGFzIGJlZW4KPiA+
bWFkZSBmb3IgYSBDUFUgdGhhdCB3YXMgcnVuIG91dCBvZiBmcmVlIHNsb3RzIHRvIHN0b3JlIGEg
cG9pbnRlci4KPiA+Cj4gPm1pZ3JhdGVfZGlzYWJsZS9lbmFibGUoKSBhcmUgbm93IGluZGVwZW5k
ZW50IG9mIFJULCB1c2UgaXQgaW4gb3JkZXIKPiA+dG8gcHJldmVudCBhbnkgbWlncmF0aW9uIGR1
cmluZyBhIHBhZ2UgcmVxdWVzdCBmb3IgYSBzcGVjaWZpYyBDUFUgaXQKPiA+aXMgcmVxdWVzdGVk
IGZvci4KPgo+Cj4gSGVsbG8gUmV6a2kKPgo+IFRoZSBjcml0aWNhbCBtaWdyYXRlX2Rpc2FibGUv
ZW5hYmxlKCkgYXJlYSBpcyBub3QgYWxsb3dlZCB0byBibG9jaywgdW5kZXIgUlQgYW5kIG5vbiBS
VC4KPiBUaGVyZSBpcyBzdWNoIGEgZGVzY3JpcHRpb24gaW4gcHJlZW1wdC5oCj4KPgo+ICogTm90
ZXMgb24gdGhlIGltcGxlbWVudGF0aW9uLgo+ICAqCj4gICogVGhlIGltcGxlbWVudGF0aW9uIGlz
IHBhcnRpY3VsYXJseSB0cmlja3kgc2luY2UgZXhpc3RpbmcgY29kZSBwYXR0ZXJucwo+ICAqIGRp
Y3RhdGUgbmVpdGhlciBtaWdyYXRlX2Rpc2FibGUoKSBub3IgbWlncmF0ZV9lbmFibGUoKSBpcyBh
bGxvd2VkIHRvIGJsb2NrLgo+ICAqIFRoaXMgbWVhbnMgdGhhdCBpdCBjYW5ub3QgdXNlIGNwdXNf
cmVhZF9sb2NrKCkgdG8gc2VyaWFsaXplIGFnYWluc3QgaG90cGx1ZywKPiAgKiBub3IgY2FuIGl0
IGVhc2lseSBtaWdyYXRlIGl0c2VsZiBpbnRvIGEgcGVuZGluZyBhZmZpbml0eSBtYXNrIGNoYW5n
ZSBvbgo+ICAqIG1pZ3JhdGVfZW5hYmxlKCkuCj4KPkhvdyBpIGludGVycHJldCBpdCBpcyBtaWdy
YXRlX2VuYWJsZSgpL21pZ3JhdGVfZGlzYWJsZSgpIGFyZSBub3QgYWxsb3dlZCB0bwo+dXNlIGFu
eSBibG9ja2luZyBwcmltaXRpdmVzLCBzdWNoIGFzIHJ3c2VtL211dGV4ZXMvZXRjLiBpbiBvcmRl
ciB0byBtYXJrIGEKPmN1cnJlbnQgY29udGV4dCBhcyBub24tbWlncmF0YWJsZS4KPgo+dm9pZCBt
aWdyYXRlX2Rpc2FibGUodm9pZCkKPnsKPiBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAgPSBjdXJyZW50
Owo+Cj4gaWYgKHAtPm1pZ3JhdGlvbl9kaXNhYmxlZCkgewo+ICBwLT5taWdyYXRpb25fZGlzYWJs
ZWQrKzsKPiAgcmV0dXJuOwo+IH0KCj4gcHJlZW1wdF9kaXNhYmxlKCk7Cj4gdGhpc19ycSgpLT5u
cl9waW5uZWQrKzsKPiBwLT5taWdyYXRpb25fZGlzYWJsZWQgPSAxOwo+IHByZWVtcHRfZW5hYmxl
KCk7Cj59Cj4KPkl0IGRvZXMgbm90aGluZyB0aGF0IHByZXZlbnRzIHlvdSBmcm9tIGRvaW5nIHNj
aGVkdWxlKCkgb3IgZXZlbiB3YWl0IGZvciBhbnkKPmV2ZW50KG11dGV4IHNsb3cgcGF0aCBiZWhh
dmlvdXIpLCB3aGVuIHRoZSBwcm9jZXNzIGlzIHJlbW92ZWQgZnJvbSB0aGUgcnVuLXF1ZXVlLgo+
SSBtZWFuIGFmdGVyIHRoZSBtaWdyYXRlX2Rpc2FibGUoKSBpcyBpbnZva2VkLiBPciBpIG1pc3Mg
c29tZXRoaW5nPwoKSGVsbG8gUmV6a2kKClNvcnJ5LCB0aGVyZSdzIHNvbWV0aGluZyB3cm9uZyB3
aXRoIHRoZSBwcmV2aW91cyBkZXNjcmlwdGlvbi4gClRoZXJlIGFyZSB0aGUgZm9sbG93aW5nIHNj
ZW5hcmlvcwogCkR1ZSB0byBtaWdyYXRlX2Rpc2FibGUgd2lsbCBpbmNyZWFzZSBycSdzIG5yX3Bp
bm5lZCwgYWZ0ZXIgdGhhdAppZiBnZXRfZnJlZV9wYWdlIGJlIGJsb2NrZWQsIGFuZCB0aGlzIHRp
bWUsIENQVSBnb2luZyBvZmZsaW5lLCAgCnRoZSBzY2hlZF9jcHVfd2FpdF9lbXB0eSgpIGJlIGNh
bGxlZCBpbiBwZXItY3B1ICJjcHVocC8lZCIgdGFzaywKYW5kIGJlIGJsb2NrZWQuCgpzY2hlZF9j
cHVfd2FpdF9lbXB0eSgpCnsKCiAgICAgICByY3V3YWl0X3dhaXRfZXZlbnQoJnJxLT5ob3RwbHVn
X3dhaXQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgIHJxLT5ucl9ydW5uaW5nID09IDEgJiYg
IXJxX2hhc19waW5uZWRfdGFza3MocnEpLAogICAgICAgICAgICAgICAgICAgICAgICAgICBUQVNL
X1VOSU5URVJSVVBUSUJMRSk7Cn0KCgoKPgo+IEhvdyBhYm91dCB0aGUgZm9sbG93aW5nIGNoYW5n
ZXM6Cj4KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9rZXJuZWwvcmN1L3RyZWUu
Ywo+IGluZGV4IGU3YTIyNmFiZmYwZC4uMmFhMTk1MzdhYzdjIDEwMDY0NAo+IC0tLSBhL2tlcm5l
bC9yY3UvdHJlZS5jCj4gKysrIGIva2VybmVsL3JjdS90cmVlLmMKPiBAQCAtMzQ4OCwxMiArMzQ4
OCwxMCBAQCBhZGRfcHRyX3RvX2J1bGtfa3JjX2xvY2soc3RydWN0IGtmcmVlX3JjdV9jcHUgKipr
cmNwLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICgqa3JjcCktPmJrdmhlYWRbaWR4XS0+bnJf
cmVjb3JkcyA9PSBLVkZSRUVfQlVMS19NQVhfRU5UUikgewo+ICAgICAgICAgICAgICAgICBibm9k
ZSA9IGdldF9jYWNoZWRfYm5vZGUoKmtyY3ApOwo+ICAgICAgICAgICAgICAgICBpZiAoIWJub2Rl
ICYmIGNhbl9hbGxvYykgewo+IC0gICAgICAgICAgICAgICAgICAgICAgIG1pZ3JhdGVfZGlzYWJs
ZSgpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGtyY190aGlzX2NwdV91bmxvY2soKmtyY3As
ICpmbGFncyk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgYm5vZGUgPSAoc3RydWN0IGt2ZnJl
ZV9yY3VfYnVsa19kYXRhICopCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2dl
dF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCB8IF9fR0ZQX1JFVFJZX01BWUZBSUwgfCBfX0dGUF9OT01F
TUFMTE9DIHwgX19HRlBfTk9XQVJOKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICAqa3JjcCA9
IGtyY190aGlzX2NwdV9sb2NrKGZsYWdzKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBtaWdy
YXRlX2VuYWJsZSgpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhd19zcGluX2xvY2tfaXJx
c2F2ZSgmKCprcmNwKS0+bG9jaywgKmZsYWdzKTsKPgpIbS4uIFRha2luZyB0aGUgZm9ybWVyIGxv
Y2sgY2FuIGxlYWQgdG8gYSBwb2ludGVyIGxlYWtpbmcsIGkgbWVhbiBhIENQVSBhc3NvY2lhdGVk
CndpdGggImtyY3AiIG1pZ2h0IGdvIG9mZmxpbmUgZHVyaW5nIGEgcGFnZSByZXF1ZXN0IHByb2Nl
c3MsIHNvIGEgcXVldWluZyBvY2N1cnMgb24Kb2ZmLWxpbmVkIENQVS4gQXBhdCBvZiB0aGF0LCBh
Y3F1aXJpbmcgYSBmb3JtZXIgbG9jayBzdGlsbCBkb2VzIG5vdCBzb2x2ZToKCi0gQ1BVMSBpbiBw
cm9jZXNzIG9mIHBhZ2UgYWxsb2NhdGlvbjsKLSBDUFUxIGdldHMgbWlncmF0ZWQgdG8gQ1BVMjsK
LSBhbm90aGVyIHRhc2sgcnVubmluZyBvbiBDUFUxIGFsc28gYWxsb2NhdGUgYSBwYWdlOwotIGJv
dGggYm5vZGVzIGFyZSBhZGRlZCB0byBrcmNwIGFzc29jaWF0ZWQgd2l0aCBDUFUxLgoKSSBhZ3Jl
ZSB0aGF0IHN1Y2ggc2NlbmFyaW8gcHJvYmFibHkgd2lsbCBuZXZlciBoYXBwZW4gb3IgaSB3b3Vs
ZCBzYXksIGNhbiBiZQpjb25zaWRlcmVkIGFzIGEgY29ybmVyIGNhc2UuIFdlIGNhbiBkcm9wIHRo
ZToKCltQQVRDSCAzLzNdIGt2ZnJlZV9yY3U6IHVzZSBtaWdyYXRlX2Rpc2FibGUvZW5hYmxlKCkK
CmFuZCBsaXZlIHdpdGg6IGFuIGFsbG9jYXRlZCBibm9kZSBjYW4gYmUgcXVldWVkIHRvIGFub3Ro
ZXIgQ1BVLCBzbyBpdHMgcHJldi4KImJub2RlIiBjYW4gYmUgdW5kZXJ1dGlsaXplZC4gV2hhdCBp
cyBhbHNvIGNhbiBiZSBjb25zaWRlcmVkIGFzIGEgY29ybmVyIGNhc2UuCkFjY29yZGluZyB0byBt
eSB0ZXN0cywgaXQgaXMgaGFyZCB0byBhY2hpZXZlOgoKUnVubmluZyBrdmZyZWVfcmN1KCkgc2lt
dWx0YW5lb3VzbHkgaW4gYSB0aWdodCBsb29wLCAxIDAwMCAwMDAgYWxsb2NhdGlvbnMvZnJlZWlu
ZzoKCi0gNjQgQ1BVcyBhbmQgNjQgdGhyZWFkcyBzaG93ZWQgMSBtaWdyYXRpb247Ci0gNjQgQ1BV
cyBhbmQgMTI4IHRocmVhZHMgc2hvd2VkIDAgbWlncmF0aW9uczsKLSA2NCBDUFVzIGFuZCAzMiB0
aHJlYWRzIHNob3dlZCAwIG1pZ3JhdGlvbi4KClRob3VnaHRzPwoKVGhhbmsgeW91IGZvciB5b3Vy
IGNvbW1lbnRzIQoKLS0KVmxhZCBSZXpraQo=
