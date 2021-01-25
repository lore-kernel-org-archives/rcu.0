Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD20CC433E9
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 02:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E4822252
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 02:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbhAYCUA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Jan 2021 21:20:00 -0500
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com ([40.107.92.62]:55008
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbhAYCTm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Jan 2021 21:19:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lExix08mMhH1VA4fx23Dqi1ecF69NQxVadNufFwHFGqMzpTV7JPeFzIVMrYAWSk04Og45HU/VTICOK1wO6HXC2rIO8Y/Z2/2DzvFKim4hr/tzAzxPID3nI6O6fW/cuUeNPNL/Og9NIQJKUdkgCdrDv9PzAiez66A4RruA2EQgcivYcgAkS5Y0+qmLfsK2Oyhgb/qZ8NqxSFbmJNphg9SLFYWs3QzKs0jud1wqSUlM8GSr15H78UKPvcMcLhB1UBV9aONVMaxCJE5Yrnsc0MQhf5F8t7cMkZr2QeIsqBJ4SKmdVj+hNo2OnKZnQPur732NPok1qcZNTKqj8Ryqljf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9ZXKwNJBaOlgCngn1XAv8Bz/7lWc6a+3zrDvJwt8nw=;
 b=hWZmgnOyEttyfTpzAJGizE15CE5kvJ0fK5SzO5RqZxX/lXPvmYyvYewioYi478AuYIN5/pd1pkcNWOdY6vs0P3TZkmkRY/WBOjduPj5xH94Y9T5+IM9ipbZxmV/cPMnHOa/DdjctCnaHkkbgpqY/LE9mIyletT4WClRlN+pFXvZ+c8GRlk4aXCt53i3XGf7XHfHIIqYQn3vwMgsSnLGSX9YfIOfRpYfH18ej79jPw81RHN8yyTNTyndo69u5ugsltY4Reiha1xmHiTCynksHcH2rZu4f7SoWunPJ6guc/D7OKEdPDIGh07RsSAQ4ikW7WQVn480bnD3jrF0mjfkBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9ZXKwNJBaOlgCngn1XAv8Bz/7lWc6a+3zrDvJwt8nw=;
 b=ZWwNb7P8dXV2m9JbQtSrF+DFUBHy/UytFPrUPo0ozpAHNCHSttzWe8nBgkquMm2pNhdUAXKOzknss7onSEU6AVSrayZRKZWC9myUYSIoFOZ0j9r6FSUeWuybxtSskirjiacutHgftiJVC1g+K1sZtiUCDo622FWo8oZpl+3fy8M=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2598.namprd11.prod.outlook.com (2603:10b6:a02:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 02:18:50 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 02:18:50 +0000
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
Thread-Index: AQHW70jTxon3D/CQOEadHLsdcTdvhao00RgBgAKIBACAADuklYAABkd8
Date:   Mon, 25 Jan 2021 02:18:50 +0000
Message-ID: <BYAPR11MB2632ACF42A88E65F1C164021FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120162148.1973-3-urezki@gmail.com>
 <BYAPR11MB263252B1BD73A38DD8C0AF4EFFBF0@BYAPR11MB2632.namprd11.prod.outlook.com>,<20210124215700.GB1076@pc636>,<BYAPR11MB2632939DA9FB6AC1B25FA847FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB2632939DA9FB6AC1B25FA847FFBD9@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e37fede-d758-4ba4-0b40-08d8c0d78df5
x-ms-traffictypediagnostic: BYAPR11MB2598:
x-microsoft-antispam-prvs: <BYAPR11MB25981A3DC822EFC5388BF974FFBD9@BYAPR11MB2598.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1spq5Bi0T6RZa5tikEvFR2w4HL7HD2cyxZ+LU7Lnc9gVMpgBPsdyE4iqI1E1LqgHnVPX7N+Iokkk1th+awpYxPuSBksdiRLNgADwCxqxY5LUbCnCpDoMX7umjvwueiHxwGY51ToM7OQbhT5V/vMmPnz5IbhLV/TWq+YLpZPRY1y9JV+BlQLc8hcq5JzFI22Of6hC09HHvidNJdlntTYepvoou1IWZklZwQyl/jML1VJQxcUHnsCJFUM+ursmsH86e3SkdjL6xlW8qXbyo2IOAGWn06qkREDY1srG5YcPtvzr6qLtwrijPH5wJmCeCmLAtALBAbD3j8DN8u3K4qcaxfBxJb1PqLsGPAP+CzKfq96N1Y7wVmBooVO09RJM8YkV9qfzXKvyTDCUiA5JuE6AsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39840400004)(136003)(71200400001)(66556008)(6506007)(54906003)(6916009)(4326008)(33656002)(76116006)(91956017)(7416002)(66946007)(66476007)(86362001)(7696005)(9686003)(52536014)(478600001)(224303003)(83380400001)(2906002)(26005)(55016002)(66446008)(5660300002)(8936002)(64756008)(316002)(186003)(2940100002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?ZTJxYnlWU0RqbmpsR0hCWjNHZ1ZEZGtUcndCYUp6S3FvdUxSUU4zRzFCYnJS?=
 =?gb2312?B?aUc2V1djQkx1WW9kdVkvQVNlQmtWVmVRZG1BZGc5bFhUSTBjZ3NiNWhCT0JK?=
 =?gb2312?B?dDFWdHZYNWtoeVVSUTUyTVhZaGNUUUJzVWdZanZ4ZEozbTZtdXZzOFEzWElq?=
 =?gb2312?B?SDA2OWd5eUh1VElCTHdCQ2xzOWxPaWpacmpqNFFFckFGbmVEVVF2VWhpUEJQ?=
 =?gb2312?B?azNtOE9SUXBhSy9FWml5Mmd0eHlxNDlib21PYVpCN2NmeXRPZjA2TjJqcjVs?=
 =?gb2312?B?UndzQTBWK2NCVVJZaVQ3WVpXemhBMzRQeGt6Q2t3c04rSFFxdy9DU2pYeVBY?=
 =?gb2312?B?VmFTakI3Y0E0R3hZWU5VcVBPbXB3Vmg4eU5rK0JHT3haWFNIVVJGdkx0K1Fs?=
 =?gb2312?B?eWJ5bGZyTkgwOERORFdoYWJpa3ljQ2pOY01sazdXZjZqZTY3M1U4d1JMR0o1?=
 =?gb2312?B?bXNZSW9kSlBHZi9mTG1QMzRIR2RaWUo3VGR3YzZlMDRyK21uN2Y1VXk5NklQ?=
 =?gb2312?B?Uk5zL21YOFBjQXJiRUg5dXRteklUODhKY09GZkVDUGtFQWdQTkIxbnNOdUpE?=
 =?gb2312?B?YUNoRUllVGlXcm5ReEtzc0tzZFhRMnNnTnpMdk9WNm9yejBHOGxmY044OHFJ?=
 =?gb2312?B?ditobnArdkYvYXY0Y1BMZzJGL3UvME16djFjQmtSeU9oYXIrSFFlcDBaSWNx?=
 =?gb2312?B?NEw4V1lWUHZIeFlRZVZINlBYSER6WE56dUdTeVhRYmxUMXRUZlhxQjBFNUE0?=
 =?gb2312?B?elh3YWlGTktlS1JCekZBcDZpby9mU0o3OTJYb3J3NC9lcnNhejc5VHc4dmN0?=
 =?gb2312?B?aEtYZUp5b2N1SnRBWWxzdjZBcm5UWXZaVkk1NUREdEpwMWwyM2g2MHZiQVE0?=
 =?gb2312?B?bnc3RnkySXFZdzdEc3k5V2ovdXRXUnpIaFdranF0L2FSY3NSeGkyUWNFRDkw?=
 =?gb2312?B?aWJyNGg4RUUrSTFHczRweXllNlN5NWxOQVo4eUVNazhJZ3dQdC94anVoTkNi?=
 =?gb2312?B?UGxSc2pnb1IwcHFJTmFsdzRBV2pyRnhjbzVGMDU4MnJ2dnZQMEJuOTZmN0Fh?=
 =?gb2312?B?RkZpSGFnQVg3WThYNzByNWNjb00yYnVIQ3RqYVNIeFJhSzFRanZOZ0VqczBX?=
 =?gb2312?B?WDErZm04VkM0M3pVZytZdlRzK2poOW1zRVdCbEZnNjRtWHNGb2V0VE53eW9K?=
 =?gb2312?B?NndzOFRjVzJYY3VTTjNWMDVnbWtBbzBNanZxL3VrYm9BRk9LKzFSa2NvK0dx?=
 =?gb2312?B?bEVjZ1NBcnJhNnpUeFprZVgxVm9qeEV0R2RXL1ZGY1pPcU53ZmRIMHhyRjJh?=
 =?gb2312?Q?lnhoJgMRw+k3I=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e37fede-d758-4ba4-0b40-08d8c0d78df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 02:18:50.4203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBIPlMFeD0bkra/VbmV/PkUSvulhtG4QS4+Lw7zMDJtKczNm2wIJEC51+AXIfnbUeuRDVcvsLW+RW8CMCtioIr1VwSVwX376Nj/lPLA4iU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2598
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Kt6K8/sjLOiBVbGFkemlz
bGF1IFJlemtpIDx1cmV6a2lAZ21haWwuY29tPgq3osvNyrG85DogMjAyMcTqMdTCMjXI1SA1OjU3
CsrVvP7IyzogWmhhbmcsIFFpYW5nCrOty806IFVsYWR6aXNsYXUgUmV6a2kgKFNvbnkpOyBMS01M
OyBSQ1U7IFBhdWwgRSAuIE1jS2VubmV5OyBNaWNoYWVsIEVsbGVybWFuOyBBbmRyZXcgTW9ydG9u
OyBEYW5pZWwgQXh0ZW5zOyBGcmVkZXJpYyBXZWlzYmVja2VyOyBOZWVyYWogVXBhZGh5YXk7IEpv
ZWwgRmVybmFuZGVzOyBQZXRlciBaaWpsc3RyYTsgTWljaGFsIEhvY2tvOyBUaG9tYXMgR2xlaXhu
ZXI7IFRoZW9kb3JlIFkgLiBUcydvOyBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yOyBPbGVrc2l5
IEF2cmFtY2hlbmtvCtb3zOI6IFJlOiC72Li0OiBbUEFUQ0ggMy8zXSBrdmZyZWVfcmN1OiB1c2Ug
bWlncmF0ZV9kaXNhYmxlL2VuYWJsZSgpCgo+SGVsbG8sIFpoYW5nLgoKPiA+X19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID63orz+yMs6IFVsYWR6aXNsYXUgUmV6a2kg
KFNvbnkpIDx1cmV6a2lAZ21haWwuY29tPgo+ID63osvNyrG85DogMjAyMcTqMdTCMjHI1SAwOjIx
Cj4gPsrVvP7IyzogTEtNTDsgUkNVOyBQYXVsIEUgLiBNY0tlbm5leTsgTWljaGFlbCBFbGxlcm1h
bgo+ID6zrcvNOiBBbmRyZXcgTW9ydG9uOyBEYW5pZWwgQXh0ZW5zOyBGcmVkZXJpYyBXZWlzYmVj
a2VyOyBOZWVyYWogPlVwYWRoeWF5OyBKb2VsIEZlcm5hbmRlczsgUGV0ZXIgWmlqbHN0cmE7IE1p
Y2hhbCBIb2NrbzsgVGhvbWFzID5HbGVpeG5lcjsgVGhlb2RvcmUgWSAuIFRzJ287IFNlYmFzdGlh
biBBbmRyemVqIFNpZXdpb3I7IFVsYWR6aXNsYXUgPlJlemtpOyBPbGVrc2l5IEF2cmFtY2hlbmtv
Cj4gPtb3zOI6IFtQQVRDSCAzLzNdIGt2ZnJlZV9yY3U6IHVzZSBtaWdyYXRlX2Rpc2FibGUvZW5h
YmxlKCkKPiA+Cj4gPlNpbmNlIHRoZSBwYWdlIGlzIG9idGFpbmVkIGluIGEgZnVsbHkgcHJlZW1w
dGlibGUgY29udGV4dCwgZHJvcHBpbmcKPiA+dGhlIGxvY2sgY2FuIGxlYWQgdG8gbWlncmF0aW9u
IG9udG8gYW5vdGhlciBDUFUuIEFzIGEgcmVzdWx0IGEgcHJldi4KPiA+Ym5vZGUgb2YgdGhhdCBD
UFUgbWF5IGJlIHVuZGVydXRpbGlzZWQsIGJlY2F1c2UgYSBkZWNpc2lvbiBoYXMgYmVlbgo+ID5t
YWRlIGZvciBhIENQVSB0aGF0IHdhcyBydW4gb3V0IG9mIGZyZWUgc2xvdHMgdG8gc3RvcmUgYSBw
b2ludGVyLgo+ID4KPiA+bWlncmF0ZV9kaXNhYmxlL2VuYWJsZSgpIGFyZSBub3cgaW5kZXBlbmRl
bnQgb2YgUlQsIHVzZSBpdCBpbiBvcmRlcgo+ID50byBwcmV2ZW50IGFueSBtaWdyYXRpb24gZHVy
aW5nIGEgcGFnZSByZXF1ZXN0IGZvciBhIHNwZWNpZmljIENQVSBpdAo+ID5pcyByZXF1ZXN0ZWQg
Zm9yLgo+Cj4KPiBIZWxsbyBSZXpraQo+Cj4gVGhlIGNyaXRpY2FsIG1pZ3JhdGVfZGlzYWJsZS9l
bmFibGUoKSBhcmVhIGlzIG5vdCBhbGxvd2VkIHRvIGJsb2NrLCB1bmRlciBSVCBhbmQgbm9uIFJU
Lgo+IFRoZXJlIGlzIHN1Y2ggYSBkZXNjcmlwdGlvbiBpbiBwcmVlbXB0LmgKPgo+Cj4gKiBOb3Rl
cyBvbiB0aGUgaW1wbGVtZW50YXRpb24uCj4gICoKPiAgKiBUaGUgaW1wbGVtZW50YXRpb24gaXMg
cGFydGljdWxhcmx5IHRyaWNreSBzaW5jZSBleGlzdGluZyBjb2RlIHBhdHRlcm5zCj4gICogZGlj
dGF0ZSBuZWl0aGVyIG1pZ3JhdGVfZGlzYWJsZSgpIG5vciBtaWdyYXRlX2VuYWJsZSgpIGlzIGFs
bG93ZWQgdG8gYmxvY2suCj4gICogVGhpcyBtZWFucyB0aGF0IGl0IGNhbm5vdCB1c2UgY3B1c19y
ZWFkX2xvY2soKSB0byBzZXJpYWxpemUgYWdhaW5zdCBob3RwbHVnLAo+ICAqIG5vciBjYW4gaXQg
ZWFzaWx5IG1pZ3JhdGUgaXRzZWxmIGludG8gYSBwZW5kaW5nIGFmZmluaXR5IG1hc2sgY2hhbmdl
IG9uCj4gICogbWlncmF0ZV9lbmFibGUoKS4KPgo+SG93IGkgaW50ZXJwcmV0IGl0IGlzIG1pZ3Jh
dGVfZW5hYmxlKCkvbWlncmF0ZV9kaXNhYmxlKCkgYXJlIG5vdCBhbGxvd2VkIHRvCj51c2UgYW55
IGJsb2NraW5nIHByaW1pdGl2ZXMsIHN1Y2ggYXMgcndzZW0vbXV0ZXhlcy9ldGMuIGluIG9yZGVy
IHRvIG1hcmsgYQo+Y3VycmVudCBjb250ZXh0IGFzIG5vbi1taWdyYXRhYmxlLgo+Cj52b2lkIG1p
Z3JhdGVfZGlzYWJsZSh2b2lkKQo+ewo+IHN0cnVjdCB0YXNrX3N0cnVjdCAqcCA9IGN1cnJlbnQ7
Cj4KPiBpZiAocC0+bWlncmF0aW9uX2Rpc2FibGVkKSB7Cj4gIHAtPm1pZ3JhdGlvbl9kaXNhYmxl
ZCsrOwo+ICByZXR1cm47Cj4gfQoKPiBwcmVlbXB0X2Rpc2FibGUoKTsKPiB0aGlzX3JxKCktPm5y
X3Bpbm5lZCsrOwo+IHAtPm1pZ3JhdGlvbl9kaXNhYmxlZCA9IDE7Cj4gcHJlZW1wdF9lbmFibGUo
KTsKPn0KPgo+SXQgZG9lcyBub3RoaW5nIHRoYXQgcHJldmVudHMgeW91IGZyb20gZG9pbmcgc2No
ZWR1bGUoKSBvciBldmVuIHdhaXQgZm9yIGFueQo+ZXZlbnQobXV0ZXggc2xvdyBwYXRoIGJlaGF2
aW91ciksIHdoZW4gdGhlIHByb2Nlc3MgaXMgcmVtb3ZlZCBmcm9tIHRoZSBydW4tcXVldWUuCj5J
IG1lYW4gYWZ0ZXIgdGhlIG1pZ3JhdGVfZGlzYWJsZSgpIGlzIGludm9rZWQuIE9yIGkgbWlzcyBz
b21ldGhpbmc/CgpIZWxsbyBSZXpraQoKU29ycnksIHRoZXJlJ3Mgc29tZXRoaW5nIHdyb25nIHdp
dGggdGhlIHByZXZpb3VzIGRlc2NyaXB0aW9uLgpUaGVyZSBhcmUgdGhlIGZvbGxvd2luZyBzY2Vu
YXJpb3MKCkR1ZSB0byBtaWdyYXRlX2Rpc2FibGUgd2lsbCBpbmNyZWFzZSAgdGhpc19ycSgpLT5u
cl9waW5uZWQgLCBhZnRlciB0aGF0CmlmIGdldF9mcmVlX3BhZ2UgYmUgYmxvY2tlZCwgYW5kIHRo
aXMgdGltZSwgQ1BVIGdvaW5nIG9mZmxpbmUsCnRoZSBzY2hlZF9jcHVfd2FpdF9lbXB0eSgpIGJl
IGNhbGxlZCBpbiBwZXItY3B1ICJjcHVocC8lZCIgdGFzaywKYW5kIGJlIGJsb2NrZWQuCgpibG9j
a2VkOgpzY2hlZF9jcHVfd2FpdF9lbXB0eSgpCnsKICAgICAgc3RydWN0IHJxICpycSA9IHRoaXNf
cnEoKTsKICAgICAgIHJjdXdhaXRfd2FpdF9ldmVudCgmcnEtPmhvdHBsdWdfd2FpdCwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcnEtPm5yX3J1bm5pbmcgPT0gMSAmJiAhcnFfaGFzX3Bpbm5l
ZF90YXNrcyhycSksCiAgICAgICAgICAgICAgICAgICAgICAgICAgIFRBU0tfVU5JTlRFUlJVUFRJ
QkxFKTsKfQp3YWtldXA6CmJhbGFuY2VfcHVzaCgpCnsKICAgICAgICBpZiAoaXNfcGVyX2NwdV9r
dGhyZWFkKHB1c2hfdGFzaykgfHwgaXNfbWlncmF0aW9uX2Rpc2FibGVkKHB1c2hfdGFzaykpIHsK
ICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgIGlmICghcnEtPm5yX3J1bm5pbmcgJiYgIXJx
X2hhc19waW5uZWRfdGFza3MocnEpICYmCiAgICAgICAgICAgICAgICAgICAgcmN1d2FpdF9hY3Rp
dmUoJnJxLT5ob3RwbHVnX3dhaXQpKSB7CiAgICAgICAgICAgICAgICAgICAgICAgIHJhd19zcGlu
X3VubG9jaygmcnEtPmxvY2spOwogICAgICAgICAgICAgICAgICAgICAgICByY3V3YWl0X3dha2Vf
dXAoJnJxLT5ob3RwbHVnX3dhaXQpOwogICAgICAgICAgICAgICAgICAgICAgICByYXdfc3Bpbl9s
b2NrKCZycS0+bG9jayk7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICByZXR1cm47
CiAgICAgICAgfQp9CgpPbmUgb2YgdGhlIGNvbmRpdGlvbnMgZm9yIHRoaXMgZnVuY3Rpb24gdG8g
d2FrZSB1cCBpcyAicnEtPm5yX3Bpbm5lZCAgPT0gMCIKdGhhdCBpcyB0byBzYXkgYmV0d2VlbiBt
aWdyYXRlX2Rpc2FibGUvZW5hYmxlLCBpZiBibG9ja2VkIHdpbGwgZGVmZWN0IENQVSBnb2luZwpv
ZmZsaW5lIGxvbmdlciBibG9ja2luZyB0aW1lLgoKSSdtIG5vdCBzdXJlIHRoYXQncyBhIHByb2Js
ZW2jrGFuZCBJIGRpZG4ndCBmaW5kIGl0IGluIHRoZSBrZXJuZWwgY29kZSAgYmV0d2VlbiAKIG1p
Z3JhdGVfZGlzYWJsZS9lbmFibGUgcG9zc2libGUgc2xlZXAgY2FsbHMuCgo+Cj4gSG93IGFib3V0
IHRoZSBmb2xsb3dpbmcgY2hhbmdlczoKPgo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUu
YyBiL2tlcm5lbC9yY3UvdHJlZS5jCj4gaW5kZXggZTdhMjI2YWJmZjBkLi4yYWExOTUzN2FjN2Mg
MTAwNjQ0Cj4gLS0tIGEva2VybmVsL3JjdS90cmVlLmMKPiArKysgYi9rZXJuZWwvcmN1L3RyZWUu
Ywo+IEBAIC0zNDg4LDEyICszNDg4LDEwIEBAIGFkZF9wdHJfdG9fYnVsa19rcmNfbG9jayhzdHJ1
Y3Qga2ZyZWVfcmN1X2NwdSAqKmtyY3AsCj4gICAgICAgICAgICAgICAgICAgICAgICAgKCprcmNw
KS0+Ymt2aGVhZFtpZHhdLT5ucl9yZWNvcmRzID09IEtWRlJFRV9CVUxLX01BWF9FTlRSKSB7Cj4g
ICAgICAgICAgICAgICAgIGJub2RlID0gZ2V0X2NhY2hlZF9ibm9kZSgqa3JjcCk7Cj4gICAgICAg
ICAgICAgICAgIGlmICghYm5vZGUgJiYgY2FuX2FsbG9jKSB7Cj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgbWlncmF0ZV9kaXNhYmxlKCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAga3JjX3Ro
aXNfY3B1X3VubG9jaygqa3JjcCwgKmZsYWdzKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBi
bm9kZSA9IChzdHJ1Y3Qga3ZmcmVlX3JjdV9idWxrX2RhdGEgKikKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVMIHwgX19HRlBfUkVUUllf
TUFZRkFJTCB8IF9fR0ZQX05PTUVNQUxMT0MgfCBfX0dGUF9OT1dBUk4pOwo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICprcmNwID0ga3JjX3RoaXNfY3B1X2xvY2soZmxhZ3MpOwo+IC0gICAgICAg
ICAgICAgICAgICAgICAgIG1pZ3JhdGVfZW5hYmxlKCk7Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmF3X3NwaW5fbG9ja19pcnFzYXZlKCYoKmtyY3ApLT5sb2NrLCAqZmxhZ3MpOwo+Cj5IbS4u
IFRha2luZyB0aGUgZm9ybWVyIGxvY2sgY2FuIGxlYWQgdG8gYSBwb2ludGVyIGxlYWtpbmcsIGkg
bWVhbiBhIENQVSBhc3NvY2lhdGVkCj53aXRoICJrcmNwIiBtaWdodCBnbyBvZmZsaW5lIGR1cmlu
ZyBhIHBhZ2UgcmVxdWVzdCBwcm9jZXNzLCBzbyBhIHF1ZXVpbmcgb2NjdXJzIG9uCj5vZmYtbGlu
ZWQgQ1BVLiBBcGF0IG9mIHRoYXQsIGFjcXVpcmluZyBhIGZvcm1lciBsb2NrIHN0aWxsIGRvZXMg
bm90IHNvbHZlOgogCkkgYWdyZWUgd2l0aCB5b3UgaGVyZQoKPi0gQ1BVMSBpbiBwcm9jZXNzIG9m
IHBhZ2UgYWxsb2NhdGlvbjsKPi0gQ1BVMSBnZXRzIG1pZ3JhdGVkIHRvIENQVTI7Cj4tIGFub3Ro
ZXIgdGFzayBydW5uaW5nIG9uIENQVTEgYWxzbyBhbGxvY2F0ZSBhIHBhZ2U7Cj4tIGJvdGggYm5v
ZGVzIGFyZSBhZGRlZCB0byBrcmNwIGFzc29jaWF0ZWQgd2l0aCBDUFUxLgo+Cj5JIGFncmVlIHRo
YXQgc3VjaCBzY2VuYXJpbyBwcm9iYWJseSB3aWxsIG5ldmVyIGhhcHBlbiBvciBpIHdvdWxkIHNh
eSwgY2FuIGJlCj5jb25zaWRlcmVkIGFzIGEgY29ybmVyIGNhc2UuIFdlIGNhbiBkcm9wIHRoZToK
PltQQVRDSCAzLzNdIGt2ZnJlZV9yY3U6IHVzZSBtaWdyYXRlX2Rpc2FibGUvZW5hYmxlKCkKCj5h
bmQgbGl2ZSB3aXRoOiBhbiBhbGxvY2F0ZWQgYm5vZGUgY2FuIGJlIHF1ZXVlZCB0byBhbm90aGVy
IENQVSwgc28gaXRzIHByZXYuCj4iYm5vZGUiIGNhbiBiZSB1bmRlcnV0aWxpemVkLiBXaGF0IGlz
IGFsc28gY2FuIGJlIGNvbnNpZGVyZWQgYXMgYSBjb3JuZXIgY2FzZS4KPkFjY29yZGluZyB0byBt
eSB0ZXN0cywgaXQgaXMgaGFyZCB0byBhY2hpZXZlOgoKPlJ1bm5pbmcga3ZmcmVlX3JjdSgpIHNp
bXVsdGFuZW91c2x5IGluIGEgdGlnaHQgbG9vcCwgMSAwMDAgMDAwIGFsbG9jYXRpb25zL2ZyZWVp
bmc6Cj4KPi0gNjQgQ1BVcyBhbmQgNjQgdGhyZWFkcyBzaG93ZWQgMSBtaWdyYXRpb247Cj4tIDY0
IENQVXMgYW5kIDEyOCB0aHJlYWRzIHNob3dlZCAwIG1pZ3JhdGlvbnM7Cj4tIDY0IENQVXMgYW5k
IDMyIHRocmVhZHMgc2hvd2VkIDAgbWlncmF0aW9uLgoKPlRob3VnaHRzPwo+Cj5UaGFuayB5b3Ug
Zm9yIHlvdXIgY29tbWVudHMhCgpNYXliZSBtaWdyYXRlX2Rpc2FibGUvZW5hYmxlKCkgY2FuIGJl
IHJlbW92ZWQKClRoYW5rcwpRaWFuZwo+LS0KPlZsYWQgUmV6a2kK
