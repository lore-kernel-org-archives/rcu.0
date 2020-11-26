Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AB2C63798
	for <rcu@archiver.kernel.org>; Thu, 26 Nov 2020 22:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03D22145D
	for <rcu@archiver.kernel.org>; Thu, 26 Nov 2020 22:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KdapkEb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbgKZW7X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:59:23 -0500
Received: from mail-dm6nam12on2105.outbound.protection.outlook.com ([40.107.243.105]:58881
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732858AbgKZW7X (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 26 Nov 2020 17:59:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJn0bihrZlCZE0uFXiIFD0msMqmmNYKFrEf025cGwPcE4ZOyMvid08rPo0Tr8rN8hNoT0PZnAXa/oEQe04Zn2E2oLvN0AIoMFCGDt/2MEvvJyVCU24vLc/50fMvTMbYnK+3UMi6WzLj0DY5X86LNiQSm3PDh3cZI1gIVAqoixjVyeGIeXCPm3iKMhgvpS6jAFJNahCXZJT8rEx5HtJvCucM8uvPUsed+gnmLsqfKaY1wroU9PklfvuioH/Fj8jTro7dYqcNd6JEztjh9A2YKS1ZCpq5J/e8R+cM5Phpm5R6srhT0loSBDhNU4WbcJotLdxrpUwoaYiI2ezxG17q5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE95hY45kX7aX/15ZOdSeDhzXe2LTr/73Jska0kF6yI=;
 b=aeiekS6SNA/wSrx9tgragiJ0Dx7ur8e7FhTeOb+0Vtr74WsW3JwcUDzv5zUfNmRhHOhXxdvUhiupS+QwjaOvdJ3k+yHrg7ADpzACnrY3f+cExBDhuMOuL2EzEZsVD+9SKt2TXb9Wz07dmh6ilkHyKcRRrIEBR4UUg5UB+PEccUJuMOm+ShLW/oJKWerGiHssPuVIzLZKk1vvgcawCy+nzwG6/VyTHuALYOwHAvrgjkNCs+HydV1vJATDTuSPUKMaxR0G6+LwVOrwvlKwzJ3YKD2mlRg0wpgXTFd+tW22+NbWyZSW44YxXrfT4JUS/qM2Z7pmeOb8+Mkq4eD0GfBM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE95hY45kX7aX/15ZOdSeDhzXe2LTr/73Jska0kF6yI=;
 b=KdapkEb/HOBiixNN7IDFD6yyLq+SZ4A1vvniKN+GfJJB1f4eV8yoLoO6WZo4AVksomzFLkZvx7Z1/zIiVTOdJnQIQMZ1R5eb0IC0kKeR6Xgb/a1T4VNPCY/8CknN2UbHoLRx1R/3fciFsFX6jTHsAyToWj1fZr/VWfqyTmGE10o=
Received: from MW2PR2101MB1801.namprd21.prod.outlook.com (2603:10b6:302:5::20)
 by MWHPR21MB0191.namprd21.prod.outlook.com (2603:10b6:300:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.0; Thu, 26 Nov
 2020 22:59:19 +0000
Received: from MW2PR2101MB1801.namprd21.prod.outlook.com
 ([fe80::d8c7:7c95:5325:155a]) by MW2PR2101MB1801.namprd21.prod.outlook.com
 ([fe80::d8c7:7c95:5325:155a%4]) with mapi id 15.20.3632.009; Thu, 26 Nov 2020
 22:59:19 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: kdump always hangs in rcu_barrier() -> wait_for_completion()
Thread-Topic: kdump always hangs in rcu_barrier() -> wait_for_completion()
Thread-Index: AdbC4sELsDFnKKqwSUucudo1Ms9VZwBKI3EAAAtIoWAAASWqAAABOEgg
Date:   Thu, 26 Nov 2020 22:59:19 +0000
Message-ID: <MW2PR2101MB18011DA2FCF66D03BF8BB0CCBFF91@MW2PR2101MB1801.namprd21.prod.outlook.com>
References: <SN6PR2101MB1807BDF049D7155201A8178DBFFA1@SN6PR2101MB1807.namprd21.prod.outlook.com>
 <20201126154630.GR1437@paulmck-ThinkPad-P72>
 <MW2PR2101MB18014505C01027A9486D45EEBFF91@MW2PR2101MB1801.namprd21.prod.outlook.com>
 <20201126214226.GS1437@paulmck-ThinkPad-P72>
In-Reply-To: <20201126214226.GS1437@paulmck-ThinkPad-P72>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d55a0606-100d-4e47-890e-1a8b2096574c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-26T22:17:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:909f:1fdc:142a:48f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1801911e-1801-4a7f-a4ba-08d8925ee88d
x-ms-traffictypediagnostic: MWHPR21MB0191:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0191FDA238ACA02C782DE710BFF91@MWHPR21MB0191.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mw4pN+wFkvMuhcTpSNjPhsddtD2/1b7GzrsoE6PXtS1BxjSUuixST6ekk/tI0DE+ql7VxjubgkxUiZL4pJf76/36gz3lyhwMnwD/TY6O5aceSQ6hBDXLhUdISSFuy7cc1YNaUrMuObW3ZoP8beq77EeJ5zV0KTwOZMqPPV2PONY7unmMlNS8InsTB+bOCwfOonYuNX0PTUoP/meDe5YTty9SQyfDw57iRaF4cBFX1Df3T4YSy3ntiof9E4QiwQ89gsSMnLRacdnHtOUKn4QFarVm2lDJFLbDItilRCyphz6bvREyWrmQnfg3TBe+FA/gEWAolyLAD3I2z/UEjYZ9dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1801.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(316002)(71200400001)(83380400001)(54906003)(82960400001)(186003)(6506007)(86362001)(66476007)(6916009)(66946007)(5660300002)(8936002)(52536014)(82950400001)(8676002)(4326008)(2906002)(8990500004)(55016002)(478600001)(9686003)(10290500003)(33656002)(66556008)(76116006)(7696005)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5sLvZF998+Egsjg3AExbV/pKs0G4/WpaslD0kua7GSQsvrlgB4wbqbC1RNF8?=
 =?us-ascii?Q?Obqi7zAosfmc3tymMxWpz1+CH104ouGf26Mho61d/sSbeIL8P1g8mTI4C4uF?=
 =?us-ascii?Q?/sT22XvgIDpNvVSXh9zfr5T+baY46kRDky1MAnCpeWa3G0NbeecsMuDaj0oX?=
 =?us-ascii?Q?Xi7uQbxXmbP0WQg2XWFjxLhZkLcQzbVqcdegK2V5fiZPrH56t8vP4RGHwUDR?=
 =?us-ascii?Q?IQvrofDksyuRV5DpZiAeYp12AhopoEHQ96PXU0zJZIvO7LYIgisEDMpr7zDn?=
 =?us-ascii?Q?CGLxgSTRk+ek+FepcW1JxSsl71P4pLVht6wVM/jJqc96LPclbnxbn/eOTpX5?=
 =?us-ascii?Q?Ub1cfOjRnSOO35/y4oR2bXQx9G+ypwvNE2FxxeO+9hCB/hUQvuW0oXp3ZxxD?=
 =?us-ascii?Q?HaeCm3BSFuYOEXJbLgG7h2LFsP4G+ORRVgrXgtOcKwxo8XZwSlJE/5VlWY7g?=
 =?us-ascii?Q?ydwB2v881uf7Wo6f0LpE2OIYQTml3jmgLvhD7Nn+KmD5lU60aMafSB5nadHX?=
 =?us-ascii?Q?XaH0EOiCdry6a1h3q0x6SY4hEgt1Ya3DVzZSq0OrfwXBo0sMpPSZpH4pVqVW?=
 =?us-ascii?Q?LtN3oAk5RdT3MnBiC5xp76geFilMh+iGeotcJCCmSbMqaoJyaWcrtYSYsfFE?=
 =?us-ascii?Q?sm1TF7XFepfxuXKwGmd2CMpgG0RzOAJv29keim0Nh2mV2dcokM3zFsR8zlVh?=
 =?us-ascii?Q?q6EFZUxXYWih6+rUIuG5HpBBJtMMkqAGJo9nAMQvLN0lDzeg9NKRXKcZfeY7?=
 =?us-ascii?Q?9swjUD9C/B/X1ry+L2mATa4iotBItMjxmdxAvgvfHpYSaWCVFBzEtkFPh6ud?=
 =?us-ascii?Q?2I0KI/bEm8u/laL3YYka8SuZD0HVDG/wSnv7wD7fi+PFDtHWRRnQ59zl10Xm?=
 =?us-ascii?Q?p1apzfCThEKdR+di1UFYRhm+aGeyIEbzcLOBm5cvccGoP+0TykLJu9K/S4k3?=
 =?us-ascii?Q?1IWNoTJ+pyUUi2vbkzN/PAuYsjfko7vnl7on+czgM6He42VguKezczJFtEuM?=
 =?us-ascii?Q?ilIuCQrQdomtUjdJbFHj7hru46No8KNKPbbx60WA4JV4GlI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1801.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1801911e-1801-4a7f-a4ba-08d8925ee88d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 22:59:19.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZ4DxnVwjHfbR/PA1VJFqOp5Piq0hRwg+a/p1BnM821bF+0FFd13+M+NFzeye9T1wU8wDuuJmPYiRqLJyU2a4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0191
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Thursday, November 26, 2020 1:42 PM
>=20
> > > Another possibility is that rcu_state.gp_kthread is non-NULL, but tha=
t
> > > something else is preventing RCU grace periods from completing, but i=
n
> >
> > It looks like somehow the scheduling is not working here: in rcu_barrie=
r()
> > , if I replace the wait_for_completion() with
> > wait_for_completion_timeout(&rcu_state.barrier_completion, 30*HZ), the
> > issue persists.
>=20
> Have you tried using sysreq-t to see what the various tasks are doing?

Will try it.

BTW, this is a "Generation 2" VM on Hyper-V, meaning sysrq only starts to
work after the Hyper-V para-virtualized keyboard driver loads... So, at thi=
s
early point, sysrq is not working. :-( I'll have to hack the code and use a=
=20
virtual NMI interrupt to force the sysrq handler to be called.
=20
> Having interrupts disabled on all CPUs would have the effect of disabling
> the RCU CPU stall warnings.
> 							Thanx, Paul

I'm sure the interrupts are not disabled. Here the VM only has 1 virtual CP=
U,
and when the hang issue happens the virtual serial console is still respond=
ing
when I press Enter (it prints a new line) or Ctrl+C (it prints ^C).

Here the VM does not use the "legacy timers" (PIT, Local APIC timer, etc.) =
at all.
Instead, the VM uses the Hyper-V para-virtualized timers. It looks the Hype=
r-V
timer never fires in the kdump kernel when the hang issue happens. I'm=20
looking into this... I suspect this hang issue may only be specific to Hype=
r-V.

Thanks,
-- Dexuan
