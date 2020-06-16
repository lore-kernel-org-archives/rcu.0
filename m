Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30F3C433E0
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9833B208B3
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 20:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gqlmT8ms";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mvYu4ToS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbgFPUSD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:18:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27200 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbgFPUR6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 16:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592338678; x=1623874678;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=q5YUnXpJRFK9h/vMesJoCH3Bdy3v87GHPNoDG4epJwU=;
  b=gqlmT8msEyijFX2xVaPJM0VUa42zlWB5kxV4ZbmAxHsH56MBLk73wDOu
   fUw3UQplRtxMLu0ncHKDFPeD0p1SsPkefvB0o6MtvtQerIVdJfNy7eAYp
   RG/iwMCShoh89zVD8G6glYK7o0Oa59aay51krGrfKTnmxEvh/CdmqHdTe
   MovNJa+xgaD5dLJkikriVK1jgtKybxVbeqV3iYansKxY9a4KuEgsJqG1F
   WNtxrcvjD6ugNjptChuG9CeYlOqx7MjCUpPU+6BxIU3aooXKZ0ooXWu6T
   jCKSZhqvW3QipUcHPlJ/8Jrww71aU5K7i3+aVlzIyhGU7fLrNdlcBSq2v
   A==;
IronPort-SDR: KmaFvdoA8fyxEzO6BVh0y1poO4a/mTpj/qQA/9eo5lxRtgYilbqZX6XBwyIMZYKKj2o1HJl79q
 Oztlnp/XJdiMJP7qmfTw/P/RH2Y+ljRH//2TZk2NZKZf+VJqbbdESs39RfTWeGlztH5VBMHFXR
 rQlSixLjn9T3tO6jSZ0oNItL6P1ezL+EmmEKuorZOyvxKjuWhYZ8A6Pd+EalJT2cFm5BYQBqpC
 04xoC5ng/WnWLcmBWocIDQfdRwsptw8vB0zlZa8NV3iSlYJkTHQRSvU5jXRISs7+WtmPr5y1tZ
 c7w=
X-IronPort-AV: E=Sophos;i="5.73,519,1583164800"; 
   d="scan'208";a="144481342"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 04:17:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbH6sgLxwAkD9EVu+8mSi07rU4rBPcLqaC9dOMChpQoXOHdy83vmdE7reTMmlfbpEQk7I1gEwFUWRq414PCY7HUSOX4TpTZ9jCAj+/ZUiXz5vyV94Na6EJ+BABJmX/WVjuJiPqanI98s/vjpuDTUGi4EurD4kfuNTInE0kJHDwzgj+ER4NRfKxQchIqpUPqCmlifdS4OuKSRCmKEKCTxQWsmHTSz8rpT29iWYSFUMZ4WBlI/RggvM8xq1iOEuhaOIQnS2cFICXdLy4KYYRs84kdArah8vKgHqoprLgjbH92lZ15ZHcSNEoj7mgEDKz6PpaGy7N39BDyY6jd+9gU7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYsNKDmnDPJiyt0vZWn/KprKkfa2XcsNdG2/PhyYVmo=;
 b=eubiY/URrTB1wkK5gQHs78xgFyVzxAUPVatKLd2GumeBLxYkgHOTnnM943C0aRtZUy6TNQRVXg3hHXUs/Zn5o0QP2ZSNmcsyB3vQydMr66PIH+tk5Ay2YBmva2hCk3EJR5GWnSBuT0m1WswI6yQjH13f5lmFcFXENOQX/Ao5XDoik2Fk3fipxDfQVyhDU0BIR9tG2jP6/tvKgHeqq6LMKlanSPPx/YBJgnGz59u4tnFdoaRj/b/1IZ8m1Nbs6j/TtcQMu1S599/SFULIc4T049mVn4GwrG2vy6TGnl28lqYPyeutVDbfb5q+XKh06fjMKD4ehYg17zcRCWjcz4W2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYsNKDmnDPJiyt0vZWn/KprKkfa2XcsNdG2/PhyYVmo=;
 b=mvYu4ToS7SwVA1ttlHitwpMR+DgDkj7mcbNw/NbkqGF3aMbJ5EaRzquRagJ7ujVJG9mxSbYU3AwZ8sR+miDEQmPfDo6rjZ2LdggofSFniswKgUiUHfONGAk9Wtoe536RS1zE1fdsHRccSZjBoZ1v5qpPECFMkXMnIccMqwFCc9Y=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5832.namprd04.prod.outlook.com (2603:10b6:a03:10f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 20:17:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 20:17:56 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
Subject: Question about list_sort() RCU version.
Thread-Topic: Question about list_sort() RCU version.
Thread-Index: AQHWRBs42t9q8JLtOk6vT+rVgdWIUg==
Date:   Tue, 16 Jun 2020 20:17:56 +0000
Message-ID: <BYAPR04MB4965874567CDA672B704ABCC869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90237c01-b32b-4cd8-9cc7-08d812325b7b
x-ms-traffictypediagnostic: BYAPR04MB5832:
x-microsoft-antispam-prvs: <BYAPR04MB583256612EB6BAC8741D9B8B869D0@BYAPR04MB5832.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VDu8ogjOI+1uCq8zNtMJP32YS+Lv88HdlG3iRlvC8ZS2ieNo5559fHnA0D6p8d/ZafeK/XXU+G8apNvTDkewjDD1jMdaeC3VZvUylEN5FCNdsA9FnvFK05LYpkqjt52v4RNo5goyNKU408wQX1kiKNNGnYTBX3KliIAnTvuhpAR9qESARe8TggwnlXbuHld21S6tOfOO4Qos0hjAK0RhrRHfjZOqIRXgKia+XmLwlVRqwg3sOsZAa3DOzydDDgeH/9hESRku0XGQQaSlpK6IHvg3eqcXlySRDI9Z8X1NxF7cmrrefkaBlpclj1vma8ZEoIq0v/Lfk9d864Vn4OiiiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39840400004)(396003)(376002)(346002)(136003)(54906003)(8676002)(83380400001)(5660300002)(110136005)(478600001)(4744005)(71200400001)(52536014)(8936002)(4326008)(33656002)(6506007)(2906002)(66946007)(316002)(64756008)(26005)(66476007)(76116006)(66446008)(9686003)(55016002)(7696005)(86362001)(66556008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CgPOjJxx+TmsIMt4Nb76x4LSCvmJPfGxa2dLj96Or0QNHzsVdSwSVKNAz72i9B9ctVPYTr11DVDrHXMZZId1Bfbh/WAc/mM4kl2GKln34qQBg0lN/93z9bqEmM4LZuGkJ8MvKiteDpC5bemvJeGGrQC/tWIcItJ5kmqttYSPoDP8hYxN/vhXyP9Gc8cD9ym2+Gv7wzchQH4s5RIO3YiexSuxBIS5YoxYfG+IRXFMlajK7dJmHziI4aRd6DRQO9MJHIVC05wUy+e/rB33l6zuPduuOy4Ln6N0kD0b2pufy4DNsVQxXUKq9JPpy7LxWsF0sNqpzbW/vSTAefsLGMc5Wml1rV1dXS8tZYnHtcCP+BIAkJeENg1RfQ9ogRIE8wAaa1C7Gd/ovLyM00ClGAbdjKysQ01/CgCf9lZZgYnrxMVq8tm22K/bGRG8zu00zVyP9qICT9J9AJYCaFNQ1AqM/6MjL+AejRFYoNDkZmRbwEVYF2ir24Bd2/2b03DupOTe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90237c01-b32b-4cd8-9cc7-08d812325b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 20:17:56.3488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTOS+SZKI0T8CVWyiyNlODiJQ7a6SpSDLSdsax6Da0yCRs5jMEASq+MkmPWS4e7XLDcNK6UPWdibSIvrrnx+xPs1mlCobBxplVqwr7nQDGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5832
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi RCU maintainers and experts,=0A=
=0A=
I'm working on a linux kernel upstream project which is in the tree. =0A=
With the POC I can already see that significant performance improvement =0A=
with RCU in the fast path which are replacing rw semaphore, but not =0A=
having list_sort() rcu variant is blocking the developement and getting =0A=
code upstream.=0A=
=0A=
I was not able to find the such helper implemented for the RCU flavor of =
=0A=
list.=0A=
=0A=
Can someone provide information about :-=0A=
=0A=
1. Is there any plan to have list_sort_rcu() ? if so when can we expect=0A=
    that ? (Also how can I help ?)=0A=
=0A=
2. In case there is no plan what are design considerations if someone=0A=
    wants to implement the code and submit it upstream ?=0A=
    (Also how can I help here ?=0A=
=0A=
Regards,=0A=
-CK=0A=
