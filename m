Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D5C433EF
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 06:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40040604DA
	for <rcu@archiver.kernel.org>; Mon, 25 Oct 2021 06:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhJYGWV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 Oct 2021 02:22:21 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:11637 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230397AbhJYGWU (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 25 Oct 2021 02:22:20 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 02:22:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1635142799; x=1666678799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O7vbfwHAyTl+50yCBNyhKlEh1iPkx6q2oAr920HmcKM=;
  b=wMWmUErC8l2rKVwHznR+jJMvHuKkmba+KvKxVWmVnc1xFgq9PhvhMa1C
   Pj6lOl+QTfqtKQRfU1McxmsWq3Yc0TzGRCq9hgB7QZN+Ndmyf+FcYCUDR
   ICC+wFpmXJl/x4FButPmDeiUVorVNxPv+m2Xddh79SdPF9XypBoM7avIL
   mwtiuxWGEuJcS0RDyqObzr9/sV6Q0OLBEA1PWUmQbwH1O4kibsiVDX0qV
   wJUpHFJ5ZIxNKBlMHMbDPHPv6PyfUfE8Z2FkZDrVAL6V/PFWTsNmBGH0o
   5ImjMpPoAPTqHO7eaivLNWVn3Roy9DUdcHSNNyeb2RlaaT5z+g5pMA5ye
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="50041779"
X-IronPort-AV: E=Sophos;i="5.87,179,1631545200"; 
   d="scan'208";a="50041779"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 15:12:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUifDnRhWs+Y6vRS6B/yDa3KO/bYGefehM8BauDt1DBAkTU26RccOyG0uW5nVZMy/XFRf/4FakiPqmpOi8WE/H1qQmKOzIxwhfNf+hbunedQV4hPxsJ0TX2eXa9jBo3MKwt08iJUfp6K0MpHGAg1KdqNtyqnWqpjEESFm9g+4l0nNbuqlN8vFcNou5tjd88Gd+UYJFbdWHn8UurmdbZ/CksXL0abTKV3xmdNVPnjKB92pm/ISyVVOrQRR1ZIlpvJf2pGEL2oFQPlzio953ZFvgJ2ca6pwer2Zc4lJ7Ukl5CzWZo/g/wh8EA5eL+ZQWF4n8qQcNPN1/CSUnGGwA3NIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7vbfwHAyTl+50yCBNyhKlEh1iPkx6q2oAr920HmcKM=;
 b=ZL44DZhiGjFJxVohUNlKHMvUSDSrMR8JSa8YPdLPE/i7t46nCpSeqsZV9UZcP7msvAugCRKvFsAss4AgNQNAXLP/cW6IROyP99Y+mYazCOqYEUwim/HRE1xwgT77FnEb7aS9f4ftVXQj9TqT0B/CLqCAm8kaWxqchmu0v1KvV1xOBuJ4kwXcjU6Gr4ZikF7cHryDIqUYCpjKWBYe7RtN+S8PASS3HLZaoVLPTiBF/WAVz3mQcgrFg8lDLr8/M3FidBAWI+FHYjvNEk2S+KppJEXgW7kVKehe1kGRkbWHELc06KeVQt9Mhkkb3wvtYRydE8OWNsqD0pZfBj2Mxms1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7vbfwHAyTl+50yCBNyhKlEh1iPkx6q2oAr920HmcKM=;
 b=YKAsxcsnxtnA3sZ8MaJX12jZmWrA8UXg3sb/qyDStAYMbaomUlrzZWh3q7+/VxazqPJo5usw/LhvtbJFaW8p8FXLOOYT16lTmq594vJBqCt/HatRLY5SeNlyZDnVKTZUafr6q+iKEI9IO4MroLnD2xT4s4MuWXEmZaZXoSHD6PU=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OS3PR01MB8601.jpnprd01.prod.outlook.com (2603:1096:604:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 06:12:41 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::9401:db52:496:51]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::9401:db52:496:51%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 06:12:41 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] refscale: always log the error message
Thread-Topic: [PATCH 3/3] refscale: always log the error message
Thread-Index: AQHXyVBk4kxOMAbyS0O7hS7+JBuTPKvjO7yA
Date:   Mon, 25 Oct 2021 06:12:40 +0000
Message-ID: <5f4c53e4-34aa-98f6-343f-0de18df830f2@fujitsu.com>
References: <20211025032658.22889-1-lizhijian@cn.fujitsu.com>
 <20211025032658.22889-3-lizhijian@cn.fujitsu.com>
In-Reply-To: <20211025032658.22889-3-lizhijian@cn.fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6a8cd1d-1068-4d09-be3f-08d9977e7390
x-ms-traffictypediagnostic: OS3PR01MB8601:
x-microsoft-antispam-prvs: <OS3PR01MB8601B61A87EDE3A332AFA843A5839@OS3PR01MB8601.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:308;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HmTzW/707+zp1MI6R//WGW0JZJrts4mbAGMcqFNtrz3eRf39rVCvk395gRv503vjLv1Ixy/Dnk5/IdU+Bexn5+TulX2s0gRN+pfPnMmZMBuaV7u05o3NjcT6MO0tXt4/GYpS5fXDoZ9EKc4pd1U4F0QIAsKVFr2W9ovmwRl0gJ30xoXy8NKp9ZHz8zega6X7aG4Q6NrvWnGlxzgTTH2ThxsZ1Im3a9ReGPlwZJtBW94/FXd6/lOu7/OsRLlTmCD4nfqf/sMUYcr391TLtJ2j3Q2k1Yi1UWJYyVAiDgHCtr9oyODeIDQlHKjOgkvQD93k6eOcnvPXBpYlTbemzQ+49w8LZXUvrb0n5A5Dl+6ycUHFrchs5PIpNkRbiXCqsUIfvDxDedzvgNlqQhqcsGJzNxhcjK4jDBl9nclx6o8WENYggR0cpQCk1hAcrCKSwAAdYqB448mNtPsP+lcnmabJxrw+BvzJxAd4pZkivy43Ub+IkmA2wUkG5rqManhWSZutvDI1AF05WtSyo0l36X9JgsvNfLSYl/G1RDAtDgJnxSkm/QuBaVp0SiMiRtXqloHUru3vbYALTF8Ma6pgMvxVcSsIcHTFNvcVQL1z8D6FZPLhSupAShumFw4ip7EChUBbVgKRawW12tDzMohCIKoin+mDbdmqzUgIoxjX/DIECmm6t/jEZ85FzWuk4WjoM7loaZRrc7CNpiPcEGQespoP40QTLeRCJdUnUBlh5dM5iYFJdcxClGWlDmsHTXjC237Ql3JzMd9sIMWR6Lmd9nrBeGLxkOVh/siOFcMYGq3uqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(122000001)(36756003)(4326008)(66556008)(66476007)(86362001)(31696002)(31686004)(82960400001)(76116006)(91956017)(921005)(66946007)(6512007)(2906002)(85182001)(38100700002)(38070700005)(64756008)(110136005)(66446008)(316002)(71200400001)(53546011)(6506007)(6486002)(8936002)(2616005)(508600001)(15650500001)(26005)(5660300002)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHVUZklha3NGbmMzd1AzejZzVEpJSjQ2MnFDdWFyUHh0TzdOM3RqNFNYQU5T?=
 =?utf-8?B?bU1FSlVRUmhlWlVmWGJCOVZ0Z1dZV285VEltcUNMZmN1OWdDRGJMOHNWRGY4?=
 =?utf-8?B?d3pOV0c2UFhJcXFsLzZ1MDF3WnV1TmJiR1FVT1paRHZ6cVY0aUxwTWNrWU1T?=
 =?utf-8?B?QWd3cGk1eVkzbWJXbVlaN2xreTVQckpjZ2RBK3ZWc1cvT0ovWkNOeHNCcEZ2?=
 =?utf-8?B?N0lNZ0hSbDVGTzJKVkxVWG5NWWY2QmY0YmFGK3FkMkRXSnpPVDBZTXVFUGxq?=
 =?utf-8?B?dXpQLzdUQTRHVFBXdm9QbHV5TzFwV3loaUlFcjRjcnA0eW8ya1FJUFhpay9t?=
 =?utf-8?B?L1lQMU1mQ3RRdHBJeHNENWYwRnlGVzAwY3JQS0tTUGVQTG8waXB2RnZMdTFa?=
 =?utf-8?B?aFA0LzhzT0kyVGs2bjd2TUFLRmx6TWtXNlRZMFhiQkgrVmJ5K0gvaU9lQXBy?=
 =?utf-8?B?SUJ4WjRTRzZJRzU4VFRSOXd2VE9IUkM2NXFXNlYyZjBZOWp2dnB5QjhWcWNF?=
 =?utf-8?B?bmFYWkhZQ2hZZWhOenprYlhzeVVxVnJzWWM2alptQzZKbGlqRmdiTGF5N3d1?=
 =?utf-8?B?Qkl5QnVUT2xRRGRnZHFmL0d2c3RpTUVSbjA0Q0lHWGIyZ2FTUnV1WnkzM1FT?=
 =?utf-8?B?eWVaUnpHYmxpVjduTys1UWtscDBSV0wwSTZZVE11enhGMFJlaXNsdXlKc0o3?=
 =?utf-8?B?TktKajVrZCtFMHdrRFRVSFZvK1JHaHF4dDUybmlTalhxSnZpVlRLYmdlMGxO?=
 =?utf-8?B?ZVR5VmNXTlZRN3ZaL3VzWGNzMGRQZzZ6enQwaTlQdURkMVEwSSsrK2FiNHhH?=
 =?utf-8?B?Sk9leTVaMDZob2E3Q25GejZyWjl0U1JYekRuazZMUWR1Y0JZb2Y3Y2lhS2VH?=
 =?utf-8?B?cGowL0NWaU5UcmNDTzdUb05WSHdlTDRLYUtwMWNCSUg4U1BEanRYaHZkUngv?=
 =?utf-8?B?d3JYK3NwNGExd0toNlkvSXAvaDRTajBTdyszWnZDN09IUEYxMmhicENMMnRs?=
 =?utf-8?B?aE1zb2NiWDdZb3kxTm4wZHlnMVc0YVdaaHlrK1hNUndrc0duTFhIN21FR09O?=
 =?utf-8?B?bFlHd0M2RWJtSGFxNWNyYnVuSmZpT3RGZktjb2ZRbmxGTm9kR2JBQXVUajhV?=
 =?utf-8?B?VXFkUU9JdXFRWDRidU5ZMEtwQ0FBVmU1UEkvbWRmN3NXUDk1TjhvcFFxcDdK?=
 =?utf-8?B?ejlUckxLOHM0UXRVUjBJUGxkakp6YVY2Y2FBNDRMTVpMNmczdW4wcEhUbTZw?=
 =?utf-8?B?TlV1TjhpL25YSENqcjNENGFCR2g3aEhIMm5MRkhMdnFyRzFSMms2d2d5REJt?=
 =?utf-8?B?Nm00UUFFT3BibmJiTXhLT1F1TkFYaGVOd0t4VTRFa09kUENOSkh2bFhYc0Vh?=
 =?utf-8?B?L1VRVnlvT01wWkNTbm0xcDk0amt0SitaTjhQMEVEdzZGWlJ1R2tsa3FPcDA3?=
 =?utf-8?B?WVJBOStYZitxMnNIODJ1clcxOE43bEhkR2hSMjZickExMkhBaWk0bFRwUENY?=
 =?utf-8?B?SnkxUWlkZnRoOTlUNFFCaHVvZmg0d2l5c2Fjei94RTh6YnZhYmw4Q1RPQXJz?=
 =?utf-8?B?c21GbWZLRDVMMlRFMVRmN2ZVaWlzbnVnaHJKRU5VcU1qYWp2WDRweWl3cnpG?=
 =?utf-8?B?SDk2NGFmV3hsTFFWWjM2ODJEZmJjWjN5YUhNeWZjQ3ZFTlpjWnJDcG5hVzUz?=
 =?utf-8?B?YTNjQUdaSW9qRWJZU3gweU5WYXVjM1IvdlV3bjJvbUJZWU9KbjVRMjJHcjV5?=
 =?utf-8?B?Rm1obCtjVGwxV1FSUkFIOWIrMllMdUdvaGRwb092ZkVtcXFqQnJtbVhaeU1B?=
 =?utf-8?B?SnVUckxXOFVOQUhXNmYvaVI5MDJZMzVvcGFZM2RVZmNKcmVDY1l4ZkdDL2pI?=
 =?utf-8?B?OG83a2dmdWE3NDZmcHNhVExCeG5WbllwaFlJUmQ0Vm05QytQRVZwaFh5Qjdo?=
 =?utf-8?B?ZldNdTRVQnVOZkVrejRxYlpqU1YwWkhuZVFPVFh2R2hyUGZOL3dLQU5PZ1J2?=
 =?utf-8?B?N2ZQMFdYZmdQT1FrTENKTGJjelZNeFNwR2owd1ZsMnFoUG95VnJzd2lyZUJl?=
 =?utf-8?B?KzloWVBtUWJ0Q1V6QlA4RGRBQk9ydzdtaFBKTlJUbVF3emVTUU51M2Z1YjJl?=
 =?utf-8?B?encwNGx1NnltVGRIeHlXaUxnNGZXVW9vT05VOVpFYVc0c3hNaGtJMTBqa0hp?=
 =?utf-8?Q?8DAJ260lf5+Na3Gly9t2DH8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2EEC214B128984ABC1CA62029CA5D43@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a8cd1d-1068-4d09-be3f-08d9977e7390
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 06:12:40.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHhJPC9wjkVwszSHlCum1qIRnQXfXH7f/DwzmUlexwFsabhB/fKIsfYFYQrn+httH7trsnporEzpViQjgyRnCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8601
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

DQoNCk9uIDI1LzEwLzIwMjEgMTE6MjYsIExpIFpoaWppYW4gd3JvdGU6DQo+IEdlbmVyYWxseSwg
ZXJyb3IgbWVzc2FnZSBzaG91bGQgYmUgbG9nZ2VkIGFueWhvdy4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPg0KPiAtLS0NCj4gICBrZXJu
ZWwvcmN1L3JlZnNjYWxlLmMgfCA4ICsrKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3Uv
cmVmc2NhbGUuYyBiL2tlcm5lbC9yY3UvcmVmc2NhbGUuYw0KPiBpbmRleCBhNDQ3OWYwMGRjZGMu
LmYwNTVkMTY4MzY1YSAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3JjdS9yZWZzY2FsZS5jDQo+ICsr
KyBiL2tlcm5lbC9yY3UvcmVmc2NhbGUuYw0KPiBAQCAtNTgsOCArNTgsOCBAQCBkbyB7CQkJCQkJ
CQkJCQlcDQo+ICAgCX0JCQkJCQkJCQkJXA0KPiAgIH0gd2hpbGUgKDApDQo+ICAgDQo+IC0jZGVm
aW5lIFZFUkJPU0VfU0NBTEVPVVRfRVJSU1RSSU5HKHMsIHguLi4pIFwNCj4gLQlkbyB7IGlmICh2
ZXJib3NlKSBwcl9hbGVydCgiJXMiIFNDQUxFX0ZMQUcgIiEhISAiIHMsIHNjYWxlX3R5cGUsICMj
IHgpOyB9IHdoaWxlICgwKQ0KPiArI2RlZmluZSBTQ0FMRU9VVF9FUlJTVFJJTkcocywgeC4uLikg
XA0KPiArCWRvIHsgcHJfYWxlcnQoIiVzIiBTQ0FMRV9GTEFHICIhISEgIiBzLCBzY2FsZV90eXBl
LCAjIyB4KTsgfSB3aGlsZSAoMCkNCj4gICANCj4gICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+
ICAgTU9EVUxFX0FVVEhPUigiSm9lbCBGZXJuYW5kZXMgKEdvb2dsZSkgPGpvZWxAam9lbGZlcm5h
bmRlcy5vcmc+Iik7DQo+IEBAIC02NTEsNyArNjUxLDcgQEAgc3RhdGljIGludCBtYWluX2Z1bmMo
dm9pZCAqYXJnKQ0KPiAgIAlyZXN1bHRfYXZnID0ga3phbGxvYyhucnVucyAqIHNpemVvZigqcmVz
dWx0X2F2ZyksIEdGUF9LRVJORUwpOw0KPiAgIAlidWYgPSBremFsbG9jKDgwMCArIDY0LCBHRlBf
S0VSTkVMKTsNCj4gICAJaWYgKCFyZXN1bHRfYXZnIHx8ICFidWYpIHsNCj4gLQkJVkVSQk9TRV9T
Q0FMRU9VVF9FUlJTVFJJTkcoIm91dCBvZiBtZW1vcnkiKTsNCj4gKwkJU0NBTEVPVVRfRVJSU1RS
SU5HKCJvdXQgb2YgbWVtb3J5Iik7DQoNCidcbicgc2hvdWxkIGJlIGFkZGVkIHRvIHRoZSBsYXN0
IHRvIGZsdXNoIGl0Lg0KDQoNCg0KPiAgIAkJZ290byBvb21fZXhpdDsNCj4gICAJfQ0KPiAgIAlp
ZiAoaG9sZG9mZikNCj4gQEAgLTgzNyw3ICs4MzcsNyBAQCByZWZfc2NhbGVfaW5pdCh2b2lkKQ0K
PiAgIAlyZWFkZXJfdGFza3MgPSBrY2FsbG9jKG5yZWFkZXJzLCBzaXplb2YocmVhZGVyX3Rhc2tz
WzBdKSwNCj4gICAJCQkgICAgICAgR0ZQX0tFUk5FTCk7DQo+ICAgCWlmICghcmVhZGVyX3Rhc2tz
KSB7DQo+IC0JCVZFUkJPU0VfU0NBTEVPVVRfRVJSU1RSSU5HKCJvdXQgb2YgbWVtb3J5Iik7DQo+
ICsJCVNDQUxFT1VUX0VSUlNUUklORygib3V0IG9mIG1lbW9yeSIpOw0KZGl0dG8NCg0KVGhhbmtz
DQpaaGlqaWFuDQo+ICAgCQlmaXJzdGVyciA9IC1FTk9NRU07DQo+ICAgCQlnb3RvIHVud2luZDsN
Cj4gICAJfQ0K
