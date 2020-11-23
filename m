Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7310C5519F
	for <rcu@archiver.kernel.org>; Mon, 23 Nov 2020 02:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E513208B8
	for <rcu@archiver.kernel.org>; Mon, 23 Nov 2020 02:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="SApBtxze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgKWB7m (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 22 Nov 2020 20:59:42 -0500
Received: from mail-bn8nam08on2083.outbound.protection.outlook.com ([40.107.100.83]:16544
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726854AbgKWB7m (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 22 Nov 2020 20:59:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ+oDvsZm8p4BE9nNaRptZcs2ryEGr1uDSNN3eJibgyj2XrlZfCMqR8AM8g+qdzPus8wNNQfj9JieD7dPoc2QvDBWG9Z2Wq7CUU90ksn3nB+Vsddhkl5+urPtEuB8NTrwDj3+0FQXfCbQrgT7TUcxmxSIk1q336EwglncYyjT6HeZKUx2rF/1i0Vr8aiz2+zQoY4iO/XYvwTaC7diJnPdTsLLr1UGOVcWhWzGYcmIcCkj21KpxBjA1DxlEmg8xIBHeY9J68dR6QKxeWkS4TO8I8KY7rypS95HPS1afQOItGNeeXFKrAvUqFvZeHDdkk+x6s9pf4kH+4bu7sVwMmlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+1NC6K5ajugf+xc7/IpwHgbGgkX46hPWd7V3qEbWWE=;
 b=ZxtGUrp3UZqni6v1zPLeVgGxCxa9KtCk9bu1nI5eO2malNsfrwyBo74wnKj7Ipx6gezDyXeXcMF42jbe9NaxvdEz/indQcPEzm9kyxrnEr9EUrhohlQIKqTxrVN4MXCgY4AcaCHa+Dzu4G6YGZs0q87LyPvK3WleCStgifnXwBYpQRM/Fsa9Sp4GEZifm+RrMvCONjimWxo7B27+KGxul7OpjTFSEMo6Y2639UKeqk+R7lt8t3UK/4VDhJ4JQZLUmYvihTEEj17O4zXc4zJ5WySyPWhRXLUqwvGh9U7iDsaY+lNAG/Oe+CfcMbv7xSQhyns1ENObnMV+8y8CPo+yxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+1NC6K5ajugf+xc7/IpwHgbGgkX46hPWd7V3qEbWWE=;
 b=SApBtxzeiu9Folmeiw40lzOBpTVvQ9ncTE4dXVR/Hj91TtRkeP1BZwA1/Fo1c3zktnuQ+uKnJF17nDubQgZqgUh59ZeFmC30wdL5bBcZMhTRt/qMUk5RMpH+s6iSa+FA75ac7GencVDqJ4/9i+dnS6B+dfxel3ganwkGV38uPyo=
Received: from DM6PR11MB2635.namprd11.prod.outlook.com (2603:10b6:5:c5::29) by
 DM5PR1101MB2089.namprd11.prod.outlook.com (2603:10b6:4:54::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Mon, 23 Nov 2020 01:59:38 +0000
Received: from DM6PR11MB2635.namprd11.prod.outlook.com
 ([fe80::4412:b254:d3c4:57f4]) by DM6PR11MB2635.namprd11.prod.outlook.com
 ([fe80::4412:b254:d3c4:57f4%2]) with mapi id 15.20.3589.028; Mon, 23 Nov 2020
 01:59:38 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: =?gb2312?B?u9i4tDogU1JDVTogUXVlc3Rpb24gb24gc3JjdV9hZHZhbmNlX3N0YXRl?=
Thread-Topic: SRCU: Question on srcu_advance_state
Thread-Index: AQHWvxdjXdvwsm4YoUaIwer37zsYs6nRyFAAgAMw8GU=
Date:   Mon, 23 Nov 2020 01:59:37 +0000
Message-ID: <DM6PR11MB2635EF8668163B77B073C096FFFC0@DM6PR11MB2635.namprd11.prod.outlook.com>
References: <7fc7b6b9-bcf2-fa78-1931-415d04a5ac1a@windriver.com>,<20201121011132.GR1437@paulmck-ThinkPad-P72>
In-Reply-To: <20201121011132.GR1437@paulmck-ThinkPad-P72>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eead1c71-cc73-4485-9a64-08d88f536f11
x-ms-traffictypediagnostic: DM5PR1101MB2089:
x-microsoft-antispam-prvs: <DM5PR1101MB2089E394E7181F28E1FBFBBCFFFC0@DM5PR1101MB2089.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRAMceCgiGM3KqVW854xpSGpMLjBsadZzeKKlLhvpfcHmCbnvW+I5q8QWSwClznuxByQcY2OlU7fBgZqEiSjhFSdfPHO3iAYuKLZNH9X5dvy+4lW8r522sCAW9FH27MZKW/h4sUxs+pIE6zyH+/JOGOgLk+WhvwpVz21YWOKKegaOEm/iUkVqzLaJnNy6KF63rxOx47jyGHxi2yaG5ENXrmXZlifVGSsTATtsARON/Xg3J4IpWESpk2rH6vkqH+5le4rcbgRGVraXTpJNNBCZ/1GmFKPLYXSx/E78LFmHWtmGExFP31M62tJhPWPJGqxWxgIlqhXF/7A5SOjoYovcZePsMl7t8U5zgmZDytw/zAQkJ7SmB3x+aN/wFQDzJ9+EkbdzST1JOhVuRVnO1E+QQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(39840400004)(376002)(83380400001)(4326008)(8936002)(71200400001)(316002)(33656002)(478600001)(86362001)(6916009)(66946007)(91956017)(76116006)(66446008)(66556008)(66476007)(224303003)(54906003)(64756008)(6506007)(26005)(52536014)(55016002)(9686003)(966005)(5660300002)(186003)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6UmHj4nioXELKmfwz+9xE50EnhkES7V5AIDIwGvxWuxfsFAEi0pObi2DM7UXC9OaSDgs0O1+doejgj9Arktq2P9ofqpuIhePWP8/zeQRMjffQ5DfwkwUagByrjnCvPnAxIppXIXVMdAmbUmJVG6n1P+gQuD+7kuwNB8jTtz193pMsmxCkflefldHI8Lw0cuzNztCUveOCw366kZZLeQ/HUtDrR5Q1CzEB0JBMjpXj7ltSF4E/1U8L36TSwsGYfpju5M8hzYFDbxmyLz82ebq7R7CA1yAaVgf69RJTeLFXna7OGxYcmxOEyqkXN5BbOaRo4hdyuEaOlj9iBUOO98b+jlWgXWmAVX2oEUlw2S1lg5JBYn88qw2t4y/UenJoRnGcaykcBbgIysKTdhuCNOpRRTpePsINZXU0B+9qnXys1HHUApyZ8bjj0wxqBwcTibRaq70IOWG0FiTUw9lANeA6hubxj1fVn8nli/K3O05NgluvtrNHtGyY+225iV2uv5t3UWfFYwdfTtIg9MwMS9kj+u6Wuir559rlka3irr0pb3wfpvsWEiCTiHGz+VCVzOVAz1npua90MhPBh85+RqClkivu+NKbK/C/vllufVRgt4K5x5cR1c7uLKj13v/1ME+X520jJLjmNnZyhHLqTWOmA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eead1c71-cc73-4485-9a64-08d88f536f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 01:59:37.9888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: In4mlUbHiKUPU2AvLtWNQnszItO4ZdDvKu4cSXTkIIqvF7YjikP72rfngUpomBFpOK7wzYVeviVjpsoHawW0VcFjfHvvZMAMKrcRntTpWgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2089
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUGF1bCBF
LiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPgq3osvNyrG85DogMjAyMMTqMTHUwjIxyNUg
OToxMQrK1bz+yMs6IFpoYW5nLCBRaWFuZwqzrcvNOiByY3VAdmdlci5rZXJuZWwub3JnOyBKb2Vs
IEZlcm5hbmRlcwrW98ziOiBSZTogU1JDVTogUXVlc3Rpb24gb24gc3JjdV9hZHZhbmNlX3N0YXRl
CgpbUGxlYXNlIG5vdGUgdGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRk
cmVzc10KCk9uIEZyaSwgTm92IDIwLCAyMDIwIGF0IDA0OjMwOjE1UE0gKzA4MDAsIFpoYW5nLFFp
YW5nIHdyb3RlOgo+IEhlbGxvIFB1YWwKPgo+IHNvcnJ5IHRvIGRpc3R1cmIgeW91LCBJIGFsc28g
aGF2ZSBzb21lIHF1ZXNldGlvbiBmb3IgeW91Ogo+Cj4gaW4gc3JjdV9hZHZhbmNlX3N0YXRlIGZ1
bmN0aW9uLCB3aGVuIHNlcSBzdGF0ZSA9PSBTUkNVX1NUQVRFX1NDQU4xLCB3ZSB3aWxsCj4gY2hl
Y2ssIGlmIHRoZSBwcmV2aW91cyByZWFkZXJzIGNyaXRpY2FsIHJlZ2lvbiBleGl0cywgd2lsbCBi
ZSByZXR1cm5lZAo+IGRpcmVjdGx5Lgo+Cj4gSSdkIGxpa2UgdG8ga25vdyB1bmRlciB3aGF0IHNj
ZW5hcmlvIHRoaXMgd2lsbCBoYXBwZW4/Cgo+U3VwcG9zZSB0aGF0IGEgcmVhZGVyIGdldHMgcHJl
ZW1wdGVkIGZvciBhIHZlcnkgbG9uZyB0aW1lIGluIHRoZQo+bWlkZGxlIG9mIF9fc3JjdV9yZWFk
X2xvY2soKToKPgo+ICAgICAgIGludCBfX3NyY3VfcmVhZF9sb2NrKHN0cnVjdCBzcmN1X3N0cnVj
dCAqc3NwKQo+ICAgICAgICB7Cj4gICAgICAgICAgICAgICBpbnQgaWR4Owo+Cj4gICAgICAgICAg
ICAgIGlkeCA9IFJFQURfT05DRShzc3AtPnNyY3VfaWR4KSAmIDB4MTsKPiAgICAgICAgICAgICAg
Ly8gUFJFRU1QVEVEIFJJR0hUIEhFUkUKPiAgICAgICAgICAgICAgdGhpc19jcHVfaW5jKHNzcC0+
c2RhLT5zcmN1X2xvY2tfY291bnRbaWR4XSk7Cj4gICAgICAgICAgICAgIHNtcF9tYigpOyAvKiBC
ICovICAvKiBBdm9pZCBsZWFraW5nIHRoZSBjcml0aWNhbCBzZWN0aW9uLiAqLwo+ICAgICAgICAg
ICAgICAgIHJldHVybiBpZHg7Cj4gICAgICAgfQoKPlN1cHBvc2UgdGhhdCBzZXZlcmFsIFNSQ1Ug
Z3JhY2UgcGVyaW9kcyBlbGFwc2UgZHVyaW5nIHRoYXQgcHJlZW1wdGlvbi4KPgo+RG8geW91IHNl
ZSBob3cgdGhhdCBjYW4gbGVhZCB0byB5b3VyIFNSQ1VfU1RBVEVfU0NBTjEgZWFybHkgZXhpdD8K
Ckkgc2VlLCAgdGhhbmsgeW91IGZvciB5b3VyIGV4cGxhbmF0aW9uLgoKVGhhbmtzClFpYW5nCj4K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
VGhhbngsIFBhdWwKPgo+Cj5QUzogIFRoZSBwYXBlciBiZWxvdyBvdXRsaW5lcyBhIHNpbWlsYXIg
c2l0dWF0aW9uIGluIHVzZXJzcGFjZSBSQ1UsCj4gICAgIHNvIGZlZWwgZnJlZSB0byB1c2UgdGhp
cyBwYXBlciBhcyBhIGhpbnQuICBUaGUgcGFwZXIgaXMgaW4gdHdvCj4gICAgcGllY2VzLCB3aXRo
IHRoZSBmaXJzdCBwaWVjZSBpbiB0aGUgZmlyc3QgVVJMIGFuZCB0aGUgc2Vjb25kIGluCj4gICAg
IGVpdGhlciBvZiB0aGUgbGFzdCB0d28gVVJMcy4KPgo+QGFydGljbGV7TWF0aGlldURlc25veWVy
czIwMTJVUkNVLAo+IEF1dGhvcj0iTWF0aGlldSBEZXNub3llcnMgYW5kIFBhdWwgRS4gTWNLZW5u
ZXkgYW5kIEFsYW4gU3Rlcm4gYW5kIE1pY2hlbCA+Ui4gRGFnZW5haXMgYW5kIEpvbmF0aGFuIFdh
bHBvbGUiLAo+IFRpdGxlPSJVc2VyLUxldmVsIEltcGxlbWVudGF0aW9ucyBvZiBSZWFkLUNvcHkg
VXBkYXRlIiwKPmpvdXJuYWw9IklFRUUgVHJhbnNhY3Rpb25zIG9uIFBhcmFsbGVsIGFuZCBEaXN0
cmlidXRlZCBTeXN0ZW1zIiwKPnZvbHVtZT17MjN9LAo+IHllYXI9IjIwMTIiLAo+aXNzbj0iMTA0
NS05MjE5IiwKPiBwYWdlcz0iMzc1LTM4MiIsCj4gZG9pPSIxMC4xMTA5L1RQRFMuMjAxMS4xNTki
LAo+cHVibGlzaGVyPSJJRUVFIENvbXB1dGVyIFNvY2lldHkiLAo+IGFkZHJlc3M9IkxvcyBBbGFt
aXRvcywgQ0EsIFVTQSIsCj4gYW5ub3RhdGlvbj17Cj4gICAgICAgUkNVIG92ZXJ2aWV3LCBkZXNp
ZGVyYXRhLCBzZW1pLWZvcm1hbCBzZW1hbnRpY3MsIHVzZXItbGV2ZWwgUkNVCj4gICAgICAgdXNh
Z2Ugc2NlbmFyaW9zLCB0aHJlZSBjbGFzc2VzIG9mIFJDVSBpbXBsZW1lbnRhdGlvbiwgd2FpdC1m
cmVlCj4gICAgICAgIFJDVSB1cGRhdGVzLCBSQ1UgZ3JhY2UtcGVyaW9kIGJhdGNoaW5nLCB1cGRh
dGUgb3ZlcmhlYWQsCj4gICAgICAgIGh0dHA6Ly93d3cucmRyb3AuY29tL3VzZXJzL3BhdWxtY2sv
UkNVL3VyY3UtbWFpbi1hY2NlcHRlZC4yMDExLjA4LjMwYS5wZGYKPiAgICAgICAgaHR0cDovL3d3
dy5yZHJvcC5jb20vdXNlcnMvcGF1bG1jay9SQ1UvdXJjdS1zdXBwLWFjY2VwdGVkLjIwMTEuMDgu
MzBhLnBkZgo+ICAgICAgICBodHRwOi8vd3d3LmNvbXB1dGVyLm9yZy9jbXMvQ29tcHV0ZXIub3Jn
L2RsL3RyYW5zL3RkLzIwMTIvMDIvZXh0cmFzL3R0ZDIwMTIwMjAzNzVzLnBkZgo+fSwKPn0K
