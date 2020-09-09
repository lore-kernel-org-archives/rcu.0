Return-Path: <SRS0=NFG3=CS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09216C433E2
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A285E20936
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 06:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="V8gp7+Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIIGfV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:35:21 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:51332
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbgIIGfT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Sep 2020 02:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnJsPekNsIRIfPsg8GVj+H1gqbwm4d7QmPXsc5H9anFYWBrlHhztu101oFyhvMGpX+B6T7DO/0t5wp35wXJrB0McZ8RaVWd5PUvIcaRvxkAzZF0Y8L9IP4CmA0OXlMzeP77Lz4ZbZ90eNYOQLZXafwFsG9kmRtsl1XfjnLR37t96pUuHlNoqE4z5XV+QMqAiQQwLQfvj/uqbnFs87Hgxac7TlhbKaUNO8KIywoTOuBbW9GjklG1wO/e8S01SssSM8YeEHY3BBBmeJOVWUu0+0B7RHD60rAbI5aNx2CKvcbzZywjcACotieXEgYC8AN0wAswLlpp1EqeC+vyE4YxkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXJwQd38f+IHVl577VmS/wGUJR59m9LWT0KYwlDj+OU=;
 b=e112pPIOFRs9qcO8mFJsXbkGj3zKTL59i+KWEJBJHi30SWwwly4YlKOwuwI4h2lzvtppQnTf16i+exHELyUbNx3xR2TMmA0z2hZLZTq7d/XtklCAJYCCXavEV2czrLmc/spXt8y9oLvgI0l5Vw3xgW10DzoQJS0ppiQiUyIYmS/bPEuY1jjbASQNm5T5WEmkx5nj3I69Hm56zWEovtv18bPwRZ9Z2hqR2qSfq++kuKO2joov1gnX1X6h9ULSjq0wKGN5Gql1XO1VT09pabhPFUClNRTmrxO86vuarkW35vn5TnCgUTh3k8m767tnox/dstrcJSAENg8s2FnOrYea8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXJwQd38f+IHVl577VmS/wGUJR59m9LWT0KYwlDj+OU=;
 b=V8gp7+UfLvfEm3wPlE6RbkM3wrH2ZBkD6niEPAUI7YYn6pqwmrf8sMe70WyT2oIGIgFxZwwHZ607AHHjvuDgQIJN/U9alFqU/1ProJzB2CgPxQspF9tAqIT4TPfPCl+pp4wnpKrwNzKd7UjYgZRIafGpYl3Ubo8co89d2xA12ok=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3111.namprd11.prod.outlook.com (2603:10b6:a03:90::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 06:35:16 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 06:35:15 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 
Thread-Index: AQHWhnNgdtT3KSvnnU6Qd/KLSreZGQ==
Date:   Wed, 9 Sep 2020 06:35:15 +0000
Message-ID: <BYAPR11MB263285B19261BE8096D87F65FF260@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72> <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200819135654.GB3875610@google.com>
 <20200819152159.GX27891@paulmck-ThinkPad-P72> <20200819155808.GA8817@pc636>
 <20200820223957.GB120898@google.com>,<20200821153328.GH2855@paulmck-ThinkPad-P72>
In-Reply-To: <20200821153328.GH2855@paulmck-ThinkPad-P72>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: joelfernandes.org; dkim=none (message not signed)
 header.d=none;joelfernandes.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f32c344a-ed2a-4e11-834a-08d8548a8353
x-ms-traffictypediagnostic: BYAPR11MB3111:
x-microsoft-antispam-prvs: <BYAPR11MB3111BABF7B22873A77BD6BC8FF260@BYAPR11MB3111.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9WWb7SobxDYpBWvMXUksFebWB4HmtR6+E6bOYhOTYpIrp6zr1ncUG9u7wXSKVa8yCpVP8fMexNpzo21HjDlRCOfzCcS5pJLgwvWz4Js+F92+OnDyuljFsoBr45U7Tp2MAOTOW8DJzgI2M/8pHHAK1V751+zkpZMBlMH4gFJY7oYBSAgms7zEt04nr3sBQJl5Vgzu8FL0pIEpdAVGEuFzb/KeQHCoro+/Y+puxzlxxwF3Ig9g3LxBKKZwJ51h+SHB47yjOxf/1scdrvrWlna0hHeH5GwEMHhBG+pdgEMo4ELKj7wUBDkY5mBbRE0Z1NGa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39840400004)(346002)(136003)(366004)(6506007)(558084003)(2906002)(8936002)(478600001)(7696005)(316002)(33656002)(54906003)(86362001)(110136005)(9686003)(5660300002)(66446008)(71200400001)(66556008)(64756008)(66476007)(66946007)(76116006)(91956017)(55016002)(186003)(26005)(4326008)(5406001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RbFNcc/IWaPtNjRKq/MPlihLsy5KwzpeHoGlOHKWcNdlRqJoJVJJIgcAX5Ng6/1Vdalk8LliAxC4TDID/PPRMdjLZv4qM6msbC7YDWZIwm9z0yn0qUTwF1WmzZIKBLIBHuJXbTQTOgiRe8SkwleDBPWXiExceT4XeO99+I4cJNJCV5r+u2YwQyWrDKIuQHjzsMvdqTn+LImWK2gol/RkVKhhZOkjTu7euvib0UaFGAJ35I9h2GLKQBx/s6q+CCDefi+BopiT/pETzDzJeDuw+H9ii6GQzaC5+u67OhN9R7/H7x2TGxL39jbChlscfWkFa7KiTvbstOQd7+Qw7+ZAXIb85kHZEEAgvWss5QrD1vd+xWdPZ2oHTPVd+r9x23Twfvkqcsw89WE0Gxjpl3WGqpNMLoC9mUKC0XNX3Bk17TJpBeJrAZqxX8pUWHFWNnkpNgR5pQ4wLnOLpJbHmtTA7QuCO1fs2KqZWb9NwOPBvpQ9xvJWJNQR1YdCHwLRg8ii8T6IpCiSz8RGfz8ljxAwUrJGkjTkVLFQWkIyvvbAOo4zMVgIzMOmOc7DFmBAc0JKbpFU5RhgJZxlIIGyFm6UaiJtPhcK739bpKonBTE1dLoAXMmriE8adK0xEpdshFfVVC0EU4RGP9Ae0ZgIoJCz1Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32c344a-ed2a-4e11-834a-08d8548a8353
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 06:35:15.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gt5G/gHSdwaWZpDTeFoKfHWIgGJxAiM9QUDn12egN4JBoDdZvpvsxpt3GrPnFOEIs6edbgXcdxpAqQpDxJirm+9GUelz61nAC+Khs7Ofx90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3111
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

IFdoZW4gY29uZmlnIHByZWVtcHQgUkNVLCAgaWYgdGFzayBzd2l0Y2ggaGFwcGVuZWQgaW4gcmN1
ICByZWFkIGNyaXRpY2FsIHJlZ2lvbi4KIHRoZSBjdXJyZW50IHRhc2sgYmUgYWRkIHRvICJybnAt
PmJsa2RfdGFza3MiIGxpbmsgbGlzdCwgIHRoZXNlIHJucCBpcyBsZWFmIG5vZGUgaW4gUkNVICAg
IHRyZWUuCiBJbiAicmN1X2dwX2Zxc19sb29wIiBmdW5jLCAKCnN0YXRpYyB2b2lkIHJjdV9ncF9m
cXNfbG9vcCh2b2lkKQogewoKICAgICAgICAgICAgc3RydWN0IHJjdV9ub2RlICpybnAgPSByY3Vf
Z2V0X3Jvb3QoKTsKfQo=
