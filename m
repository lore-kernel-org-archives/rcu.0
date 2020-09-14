Return-Path: <SRS0=r7Mw=CX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0319BC43461
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 07:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89E620771
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="YKVeQH62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgINHzZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Sep 2020 03:55:25 -0400
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:35552
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbgINHzW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Sep 2020 03:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBtSUFKuB6F/I/LxUcU3HdfVsfyWxkA58qMNeZIAs970fAdxUIpPJPcV89AOElSVXCe1YRW5g81sChqD0X8KZ5K1RcbEP1GzVPp8qyIetxiQWDUmNflheYk17QvHDy///oZMVPY1s4Zrzdff4qTP1lPWa+oueWfd9RqtAqi9xHVClUCTITqlpKMn5iNO9tHz6sTJvPflKzdWL4yR5ZDAM9QxYITP5Rp0JlX7MariQza1Wt9JrMa8YHAr4ibUEMQcL+O8jSS2HphC84WhGojEDINLmvO6rVfV5bOty2IHn+TMwztKF0uV6zY2/Q0c9TfbQ7fqhrBBIRA3a4Btm7r5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqxo6069iF9cynbC0/ivHWBbGgpKTu99cIsJV04PBZQ=;
 b=Z5J9McNXS7Wy1JkWf2iYEh8TjEi7xUyaOTlGgZ837QxD23u9rdfrqgbntSdWFAiF282cb0JqfcPyCYsc9P285fmkVFmCx2NtulFSdsIeGt2bX4Rh/jgoHQKj2KiPuWADRyO1GCnhaVUz2Gsx/fN9fKhnhkIgX+ZRluoNUfaBxJ3OIW+kZuMfmI2Dztsqg60j/iBMqf+oKTC1Bcritklq2GTBTgFQ3sQGd9097nPYxVNAzKDPLpsjj4IIQCyiq2ptULcGYFIUUaZl5qC1jeHeHW8laPMIQg55wtqnuDT/4h4Aynp16mI7K6EkJ+vh/QXwrau4HP9vIKk7u80PSEbKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqxo6069iF9cynbC0/ivHWBbGgpKTu99cIsJV04PBZQ=;
 b=YKVeQH62nbhkdBKGf8Yz0aQDShtDtDwwrphQAt/3aI6fNTfKwLKPbssm0npGmO4JSE9swteIOBAGS0OcBKXcHlqxXUb6Nr45Ygkvg4gcT4xG22mr5+0MXvJkzq2GqfT4bUZI1sLqVmirfNoKMFmcG6ClKcanMmvmH5oG9TSZv9w=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3896.namprd11.prod.outlook.com (2603:10b6:a03:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Mon, 14 Sep
 2020 07:55:18 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 07:55:18 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RCU: Question on force_qs_rnp
Thread-Topic: RCU: Question on force_qs_rnp
Thread-Index: AQHWimIP0LPCKhgtykWT7yuEklGOuw==
Date:   Mon, 14 Sep 2020 07:55:18 +0000
Message-ID: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65758754-959d-4170-8e9c-08d858838618
x-ms-traffictypediagnostic: BY5PR11MB3896:
x-microsoft-antispam-prvs: <BY5PR11MB38965CF8A19AA12801EE750CFF230@BY5PR11MB3896.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrYpigWq3Qd1kuOFpB/a8+viYwtcnahVGBmJnshVP0kUAAQYBTXIOp1eVUuGkwct9dJ8skzzijnknG8OuYBc8SmerCKDJJNZJAM/0ADnFGEC6CDf3ANLMLap/l4vERiMY4i12Bptlh0OxKGfuY71l70qaA+QTzEXUO3r0uieFSG/ty1nXXHpcL95BhK99DECut35OS8ZhZWbDTaoGE6m8FE1GU2XDziPag89Z68iMo/1fOL7vWWQDn2sGfKwxASqLc74NXQVnqgL2RVxpA42cSS29eK0OaaigxU0DPyfdCrO+BpR68rswsVD3LEhXAju
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(396003)(366004)(136003)(376002)(8676002)(83380400001)(7116003)(4744005)(86362001)(76116006)(52536014)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(8936002)(478600001)(6916009)(33656002)(66574015)(6506007)(2906002)(7696005)(71200400001)(5660300002)(91956017)(4326008)(186003)(55016002)(26005)(54906003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AvWuveNncDrFAAzfj1J0599L4orfq+tjcy6tgkkYl8DXwDRDTUa4tt4v3xuw0OlooPZk9yhqgisEVvcsQrulEHgZWVCKBNF6xoreUuvo5xSBhl0EGdLxmNhDZ8P0E1SuzOrUlGRW8ezWihPVEHFvBDPHjznR923hvujC5las92Qv+pQFYC9G8Y/HNR8XY+J951lycblpkDQNr4EbJ5EoV9kSPjvNZMgVBVeNmaZuasWYuGeYFVzglMUo+pwEjG8l1b8czgpr8QlmkGkqlUc2FEsKzcMLrtohNq2mtxg6x9wjZ4EUr3uRq1+GX7jgfv/MwTRVc3HrX6GjIrIl9ZBHxfJS7r4MN6LoSpmfndD+LbJa64fdA7Gx5pDq+BIoufyhPrCldo0jw/tfJi8KkHaUV2rwWli1m8rfrp9rH5PQRdq64W//uF4++Mky6wxAoyxI0v1SyG5hPlSzvCoPtTYEGu40bUTO6Gg7F4FANgXC3674L0odsUVgaZo9SrBmMdnDH/meQ9/EN+cFP+W7OQDZLClKDIh2WipCTNRtsuD0zwqZ1a0ugu6DkDldosRfgeSLEXnGCQBYQ7forIfJbKsXc8tNbW95M79xB3faqF03Cgq92Lx61CvGKQ/Ie3go8Mn6JpepHeOowWwtTVgS7DoPGw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65758754-959d-4170-8e9c-08d858838618
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 07:55:18.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lhm7YhFqgvPo7hd7AB8O4VBleIsWJFgkfJJPPeJYdFFhsSIduXelln/TkNeNF9DKZ8PvoM9u56Au2BLk7aLYdcCmq5Qlv9MtP+uBVBkh7Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3896
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

SGVsbG8gUGF1bAoKSSBoYXZlIHNvbWUgcXVlc3Rpb25zIGZvciB5b3UgLgppbiBmb3JjZV9xc19y
bnAgZnVuYyAsICBpZiAgImYocmRwKSIgZnVuYyByZXR1cm4gdHJ1ZSB3ZSB3aWxsIGNhbGwgcmN1
X3JlcG9ydF9xc19ybnAgZnVuYwpyZXBvcnQgYSBxdWllc2NlbnQgc3RhdGUgZm9yIHRoaXMgcm5w
IG5vZGUsIGFuZCBjbGVhciBncnBtYXNrIGZvcm0gcm5wLT5xc21hc2suCmFmdGVyIHRoYXQgLCAg
Y2FuIHdlIG1ha2UgYSBjaGVjayBmb3IgdGhpcyBybnAtPnFzbWFzaywgIGlmICBybnAtPnFzbWFz
ayA9PSAwLCAKd2Ugd2lsbCBjaGVjayBibG9ja2VkIHJlYWRlcnMgaW4gdGhpcyBybnAgbm9kZSwg
IGluc3RlYWQgb2YganVtcGluZyBkaXJlY3RseSB0byB0aGUgbmV4dCBub2RlIC4KCgpUaGFua3MK
UWlhbmc=
