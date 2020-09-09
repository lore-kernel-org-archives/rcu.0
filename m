Return-Path: <SRS0=NFG3=CS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F109C43461
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 07:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5515021741
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 07:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="dcYxKeHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIHD6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:03:58 -0400
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:57575
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727880AbgIIHDu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Sep 2020 03:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQgwFluWc+A3SGaDWQ0+cyywz/1ZZe82Av0B4CUPQO2d6agHj3WyO30vXHiahqgkOEEIasLhdxIkmVsF8Ka5uAXcp8vuflCGMvqYX7eocSW4W7yBE1NZp9sqX1cbMMEXr0qBuuXvN0RJborH7Qk6NRmY9l3a+ybBAOvlKFRwO3KgpHNaHTO45pDTL5hmCdvHLA0iBFhE04V3Ux0bhC7KWc7NgKdGnao+cSf0S1KksA0uJkkoIEkunbsmZEo3OQVCKe4da7kom76tsVJGeLLJRrq+4Zxveya8IEz5SYS3adJ61pOlN1g1cH+ZxmYYo68AKVHAxrRYvqGUffigVpnGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFRgvR+yP81dUw2M6bkGlXt3cC97BC3YMUMIZQZ1gfg=;
 b=Aly+FjPR29cDcgRztZNiKQgiQP+nu2nX2yhquMaJbseI8oTsgnZzmGMV9dYNIVg3B374E1XaHryXj9iHRMVoxBsfK1v7y4vT6e+XP+s3lTofNJ9c4xDNJK3yC7d5OxFYYsmQ9FwOtG4bTY6KHmTbCmY9bsPAUu12S4jv++/twKGq2icq+w80qozTfuHXjqfhw7JDYmd7zFKkBPeTXXaVyFiVWFHnSTSdyt5mGzzzRTT8xNW2UsuY2XzAMj59UHhUIQTry43GF/ZrCLV9fU7LYlJaVAJq52E6lpYyyVnDAg2aHISHIwaVjBLjeRzkZWMiWQcWgFgo2luZYNMjatsYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFRgvR+yP81dUw2M6bkGlXt3cC97BC3YMUMIZQZ1gfg=;
 b=dcYxKeHKo8m0mNisB7EGteTR7548oqY+iK5c0sjwmA8JXqYfbX4rH+MpJeNjoGZuwoHm6gFbmOV7nAs2jnPGQQpI2wfUszk7SHWT/AyiNWoumjbkF2PYT2ZpRSRjlWo4+cF4DAZPEP2bj9jSytHIwWSkQHbuwAABdGq6esBNSJY=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3911.namprd11.prod.outlook.com (2603:10b6:a03:18d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 07:03:39 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 07:03:39 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: RCU:  Question   rcu_preempt_blocked_readers_cgp  in  rcu_gp_fqs_loop
 func
Thread-Topic: RCU:  Question   rcu_preempt_blocked_readers_cgp  in
  rcu_gp_fqs_loop func
Thread-Index: AQHWhnNgdtT3KSvnnU6Qd/KLSreZGalf2jJU
Date:   Wed, 9 Sep 2020 07:03:39 +0000
Message-ID: <BYAPR11MB2632FD34F68A89CCE039018BFF260@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72> <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200819135654.GB3875610@google.com>
 <20200819152159.GX27891@paulmck-ThinkPad-P72> <20200819155808.GA8817@pc636>
 <20200820223957.GB120898@google.com>,<20200821153328.GH2855@paulmck-ThinkPad-P72>,<BYAPR11MB263285B19261BE8096D87F65FF260@BYAPR11MB2632.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB263285B19261BE8096D87F65FF260@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: joelfernandes.org; dkim=none (message not signed)
 header.d=none;joelfernandes.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e6b244d-943e-4366-b639-08d8548e7aaf
x-ms-traffictypediagnostic: BY5PR11MB3911:
x-microsoft-antispam-prvs: <BY5PR11MB3911E3876CD657C2FCB7194FFF260@BY5PR11MB3911.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJ4hU7cEEWSe+1e/0Au1/0mL11CYH53R/3W5VGKtU0RkKBnT6pQtbwO7jpYWY9TyeFhEEvBglJBX6U3MRVY+3Qq2nigoa5q4Qtb1rtwRArEngTs51JJ+gBchm70Anr/1cTc8e7vRykuxPyUQTPHjJ3Hs6Y1i/G3u4Ex12ra7X1V2b41AJtXTrSfdqFYEDCc8/z+otYc6OcShp0Wp2uNrzq5OFMDGiO+us/8hqqUB7WzI2eN7hePuay3vdr1JvoEDemSDpVhJrl6WPYbmwqJZkVfFA0BsP5rTigCZvDxqSezeAZyQSlLN1TzCPu5tBRVsQSvk9A9DDSepTuL2uYD9WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39840400004)(136003)(66946007)(316002)(2906002)(2940100002)(8676002)(5660300002)(6506007)(86362001)(8936002)(4326008)(7696005)(478600001)(52536014)(66446008)(110136005)(66556008)(54906003)(71200400001)(66476007)(26005)(186003)(64756008)(91956017)(9686003)(76116006)(55016002)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 16SGaOcT9ObKvYgsIqJXg0o9PQ1MzvyZlPwHoACf3qNwSOb8k/MyFsdpX2hV8SnNKLbNByBzMc3AiTkzDySmsrx3C00YU2XEdumnD0Nq3JdhsSCEh1D1bA5T2UuAOPxQJgf2UxeiFXs+5V8bYKIJ2fnULOCdD5Ly5ZJh2Lgsz7HEPWTMm7UR2QsfYSnuhMbGZE0zHPZtYTjp35iNX1mKzgzlyVe5b4hKmWa5ITMpYJ8FtaxjBWGRRJ0MiLdTPXtuSL6Rcf8ViDrFdHNhduMwKXp35i197lSVF7BkBKkkIUnU0UngsszLDN6K1fl4JA6CHPx0++xT83loA0PmPwGs/CYr86S9vMTxdyfdH3Fnq8tolBFQ4peomOXAVl8/bviYMAiPpMwPLmMDf5hnh4MZmPSmhnMIsNo9OtW/8l541ZagQqYE+p5gWFsUES67AMtMj7IpPOaorNT4ydhAZ/dZOBG9hi7kvcF2+OmIq8za+pumvxJ3yuuhysSmeDHdHLE0xDAK/mM6thos3ws1I1MtjRPEKHXxxkoT9B7VghieprWuXG64cXgHsD4iTGmt2QaeVrWK+bJHfeM8ipQHeDUf6WFwjwgv87CX2Syk4lIl7jvghon3x0USECEGQMrng2UfKHVx79TQhp8eWiOCJz80jw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6b244d-943e-4366-b639-08d8548e7aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 07:03:39.1531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFg7EygqXjRoBv04xwdPsGUQ1YuBTy3tmHhN7DFS7aQxwyG5me9gRCbn78WJK1EynLsnqIASVSeFDLHOwW6B0yOSwSJjo+uQwnkDUjQJ2c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3911
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

CldoZW4gY29uZmlnIHByZWVtcHQgUkNVLCAgYW5kIHRoZW4gIHRoZXJlIGFyZSBtdWx0aXBsZSBs
ZXZlbHMgIG5vZGUsICB0aGUgY3VycmVudCB0YXNrIGlzIHByZWVtcHRlZCAgaW4gcmN1ICByZWFk
IGNyaXRpY2FsIHJlZ2lvbi4KdGhlIGN1cnJlbnQgdGFzayBiZSBhZGQgdG8gInJucC0+YmxrZF90
YXNrcyIgbGluayBsaXN0LCAgYW5kIHRoZSAicm5wLT5ncF90YXNrcyIgIG1heSBiZSBhc3NpZ25l
ZCBhIHZhbHVlIC4gIHRoZXNlIHJucCBpcyBsZWFmIG5vZGUgaW4gUkNVIHRyZWUuCgpCdXQgaW4g
InJjdV9ncF9mcXNfbG9vcCIgZnVuYywgd2UgY2hlY2sgYmxvY2tlZCByZWFkZXJzIGluIHJvb3Qg
bm9kZS4gCgpzdGF0aWMgdm9pZCByY3VfZ3BfZnFzX2xvb3Aodm9pZCkKIHsKICAgICAgICAgICAg
Li4uLi4KICAgICAgICAgICAgc3RydWN0IHJjdV9ub2RlICpybnAgPSByY3VfZ2V0X3Jvb3QoKTsK
ICAgICAgICAgICAgLi4uLi4KICAgICAgICAgICAgaWYgKCFSRUFEX09OQ0Uocm5wLT5xc21hc2sp
ICYmCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhcmN1X3ByZWVtcHRfYmxvY2tlZF9y
ZWFkZXJzX2NncChybnApKSAgICAtLS0tLS0+IHJucCBpcyByb290IG5vZGUKICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgIC4uLi4KfQoKdGhlIHJvb3Qgbm9kZSdzIGJsa2Rf
dGFza3MgbmV2ZXIgYWRkIHRhc2ssIHRoZSAicm5wLT5ncF90YXNrcyIgaXMgbmV2ZXIgYmUgYXNz
aWduZWQgdmFsdWUsICB0aGlzIGNoZWNrIGlzIGludmFpbGVkLgogU2hvdWxkIHdlIGNoZWNrIGxl
YWYgbm9kZXMgbGlrZSB0aGlzIAoKLS0tIGEva2VybmVsL3JjdS90cmVlLmMKKysrIGIva2VybmVs
L3JjdS90cmVlLmMKQEAgLTE4NDYsNiArMTg0NiwyNSBAQCBzdGF0aWMgYm9vbCByY3VfZ3BfaW5p
dCh2b2lkKQogCXJldHVybiB0cnVlOwogfQogCitzdGF0aWMgYm9vbCByY3VfcHJlZW1wdF9ibG9j
a2VkX3JlYWRlcnModm9pZCkKK3sKKwlzdHJ1Y3QgcmN1X25vZGUgKnJucDsKKwl1bnNpZ25lZCBs
b25nIGZsYWdzOworCWJvb2wgcmV0ID0gZmFsc2U7CisKKwlyY3VfZm9yX2VhY2hfbGVhZl9ub2Rl
KHJucCkgeworCQlyYXdfc3Bpbl9sb2NrX2lycXNhdmVfcmN1X25vZGUocm5wLCBmbGFncyk7CisJ
CWlmIChyY3VfcHJlZW1wdF9ibG9ja2VkX3JlYWRlcnNfY2dwKHJucCkpIHsKKwkJCXJldCA9IHRy
dWU7CisJCQlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZV9yY3Vfbm9kZShybnAsIGZsYWdzKTsK
KwkJCWJyZWFrOworCQl9CisJCXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlX3JjdV9ub2RlKHJu
cCwgZmxhZ3MpOworCX0KKworCXJldHVybiByZXQ7Cit9CisKIC8qCiAgKiBIZWxwZXIgZnVuY3Rp
b24gZm9yIHN3YWl0X2V2ZW50X2lkbGVfZXhjbHVzaXZlKCkgd2FrZXVwIGF0IGZvcmNlLXF1aWVz
Y2VudC1zdGF0ZQogICogdGltZS4KQEAgLTE4NjQsNyArMTg4Myw3IEBAIHN0YXRpYyBib29sIHJj
dV9ncF9mcXNfY2hlY2tfd2FrZShpbnQgKmdmcCkKIAkJcmV0dXJuIHRydWU7CiAKIAkvLyBUaGUg
Y3VycmVudCBncmFjZSBwZXJpb2QgaGFzIGNvbXBsZXRlZC4KLQlpZiAoIVJFQURfT05DRShybnAt
PnFzbWFzaykgJiYgIXJjdV9wcmVlbXB0X2Jsb2NrZWRfcmVhZGVyc19jZ3Aocm5wKSkKKwlpZiAo
IVJFQURfT05DRShybnAtPnFzbWFzaykgJiYgIXJjdV9wcmVlbXB0X2Jsb2NrZWRfcmVhZGVycygp
KQogCQlyZXR1cm4gdHJ1ZTsKIAogCXJldHVybiBmYWxzZTsKQEAgLTE5MjcsNyArMTk0Niw3IEBA
IHN0YXRpYyB2b2lkIHJjdV9ncF9mcXNfbG9vcCh2b2lkKQogCQkvKiBMb2NraW5nIHByb3ZpZGVz
IG5lZWRlZCBtZW1vcnkgYmFycmllcnMuICovCiAJCS8qIElmIGdyYWNlIHBlcmlvZCBkb25lLCBs
ZWF2ZSBsb29wLiAqLwogCQlpZiAoIVJFQURfT05DRShybnAtPnFzbWFzaykgJiYKLQkJICAgICFy
Y3VfcHJlZW1wdF9ibG9ja2VkX3JlYWRlcnNfY2dwKHJucCkpCisJCSAgICAhcmN1X3ByZWVtcHRf
YmxvY2tlZF9yZWFkZXJzKCkpCiAJCQlicmVhazsKIAkJLyogSWYgdGltZSBmb3IgcXVpZXNjZW50
LXN0YXRlIGZvcmNpbmcsIGRvIGl0LiAqLwogCQlpZiAoIXRpbWVfYWZ0ZXIocmN1X3N0YXRlLmpp
ZmZpZXNfZm9yY2VfcXMsIGppZmZpZXMpIHx8Ci0tIAoKCnRoYW5rcwpRaWFuZwo=
