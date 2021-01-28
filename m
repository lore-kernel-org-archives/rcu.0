Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAAAC433DB
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 07:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0076024A
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 07:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhA1HbF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 02:31:05 -0500
Received: from mail-dm6nam12on2137.outbound.protection.outlook.com ([40.107.243.137]:15040
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231858AbhA1H3J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 02:29:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpS4zUS+QpZA/vACon/Tgm5LASV0uSGwTOxZtcOlcf6nHQnMILIM7Ab0Eo+5xihALCbyweHXaqito8yPomUt1s+K0AFhIiWRJ5GLYXvgqHDDlPwjZxaO0zj5TTKJyJ1HPAuN3J4ITGN+oSEEJlTDboLWPwHjBxeHr2SSUef8Kfg7xcPqbIEYFRNEeDbnEzLepXv9dqrlz+OkoP64JCHpFRUs7BYhVYEPXQj3O1IGu0LtPWi534TC8UF0PZb2P/D+oEYF0kcxJcyKdVWVMvt1BD5wjZt0IL7WT2rOUV4CqJZTsaBNOrCKdRN23ysLzmldLxyL5JsUB+euxqFD/lrFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIA5KQ6A7AeVq0IopnHo4MjChan4MX7Rg9THMFnnUO0=;
 b=UGzPanIloP1oN/kIlM/d16MLCHdvVFpRv/iQf+xzUr0F19wa+69/uIcb4dMDCh8ce+10pPdZi1SCTPQhV2IMqTiM7akRPStCeWmxflx7wjfXGBFrKRs2Aexw1CsxqvjStwfb4xGA1Fp1nGnM5q/VQ4OHIZ5DG9iZYOnizTa2iZFhuHaNnVgn1rPDrWuqFJd+XxHosvAf+zowoEuFwzA7wd9YE0ecnwPPcHSWFASowRuA3rXORPR8Pf5vqa4HqAWaNT9lqhvugeGw4C5cPNbHVaLWu50Ww4wjsJYwkIzaMTYgdB4wBg65lB5ivf4esIbcvkPTygitaulkX9MQa/k+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIA5KQ6A7AeVq0IopnHo4MjChan4MX7Rg9THMFnnUO0=;
 b=EeKrn2DX1XXluHJjAGR5NvafzYy1YtSM+N/XzozTKkAXJP444HwZMJhmTT+G54Bn2xnR/045tsMGZBhP5i0OO0sPynpN8sRNVd67sU76Wop8Zuy61kA+dbCOfcgb+ye9zJm1Oo3M3n6RFA0pHqq43HB5ySteVDAsqkpEY62rJs4=
Received: from (2603:10b6:302:8::15) by
 MWHPR2101MB0875.namprd21.prod.outlook.com (2603:10b6:301:80::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.1; Thu, 28 Jan
 2021 07:28:21 +0000
Received: from MW2PR2101MB1787.namprd21.prod.outlook.com
 ([fe80::c9f1:a5ea:6bd9:f0de]) by MW2PR2101MB1787.namprd21.prod.outlook.com
 ([fe80::c9f1:a5ea:6bd9:f0de%6]) with mapi id 15.20.3825.006; Thu, 28 Jan 2021
 07:28:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>
CC:     "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: kdump always hangs in rcu_barrier() -> wait_for_completion()
Thread-Topic: kdump always hangs in rcu_barrier() -> wait_for_completion()
Thread-Index: AdbC4sELsDFnKKqwSUucudo1Ms9VZwBKI3EAAAtIoWAAASWqAAABOEggAANl+gAMPdI9EA==
Date:   Thu, 28 Jan 2021 07:28:20 +0000
Message-ID: <MW2PR2101MB1787FF5912C90FC4FFEF3993BFBA9@MW2PR2101MB1787.namprd21.prod.outlook.com>
References: <SN6PR2101MB1807BDF049D7155201A8178DBFFA1@SN6PR2101MB1807.namprd21.prod.outlook.com>
 <20201126154630.GR1437@paulmck-ThinkPad-P72>
 <MW2PR2101MB18014505C01027A9486D45EEBFF91@MW2PR2101MB1801.namprd21.prod.outlook.com>
 <20201126214226.GS1437@paulmck-ThinkPad-P72>
 <MW2PR2101MB18011DA2FCF66D03BF8BB0CCBFF91@MW2PR2101MB1801.namprd21.prod.outlook.com>
 <20201126235440.GT1437@paulmck-ThinkPad-P72>
In-Reply-To: <20201126235440.GT1437@paulmck-ThinkPad-P72>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=42b98977-bb50-49b3-9199-3ee5d91e2244;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-28T07:25:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:4da9:51c5:c8ee:3beb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 079519b4-2359-429d-c50d-08d8c35e49f7
x-ms-traffictypediagnostic: MWHPR2101MB0875:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR2101MB08757CC5B48A7A9F45691A38BFBA9@MWHPR2101MB0875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRR/H3CBENA7KErcOV8R0ny6SXspLfCUSVu9D/ulx1gU6B0Gmhr/afxPZ0Tcu1+tt847q9lCey2cEvWgiKt06mdHQ5Zt2D55+/XPtXke8kLacI0/rlTibThI32dS9oJcmJKMTYG+LZev9wQ0HY0yF/n9TEqK3SOKD1pQB3p9U2VFCOvxdLl8d8jPnIoM+s6dYWYoLeEMC9xmfdSIWIdtuT0ylKan7xuRFKl3Z1LeArFlMVGKbibMEJyJZ34YOxEqNRQz0SgZ0Oey9iIVW9dR/RB2AEdERlmmmNnGNh+3PQduEibzq78XOy4IGCE/3BGdw1pgEdy0uYv+25/diTjE6zlDAje6ZqXdzdKaitXnmM+erndC64ndZnASRC0weK1TM45m9y7E1WHQWjUNuoKza/Bi612QzQHztqGkcgF7rMgGDnN8vsAvdbiVislAm7zR+gh1WVMWMlBstW1nKKoQBfSMX5cxgVT1iHNeAlV5Q000VnRQlgEd3F2Iy+GCHY4uAbLwZxzeKtTOVzuEK0SYi3ER7WGQgeZPAHCK5FmR+6XwEABJlvLJLuq2groclkuZCy/fJrTYozoLvoCNiTrkeoC0tVZL2/uPrIpJFEPnLBw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1787.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(71200400001)(8990500004)(186003)(6506007)(76116006)(4326008)(8676002)(83380400001)(66556008)(54906003)(52536014)(66446008)(316002)(110136005)(9686003)(66946007)(82950400001)(64756008)(7696005)(10290500003)(86362001)(478600001)(2906002)(33656002)(8936002)(82960400001)(966005)(53546011)(5660300002)(55016002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KOTEMUWViQ/WcMvRjunR3TyelFK9WilhJSabHR9YwaNTdvl2+xF882drRsCO?=
 =?us-ascii?Q?SRqtaNhp1wRkruLz4ET2v6nI0puQKTm1oTzTaWLyQHvmu/QTOVTRE5glQbC0?=
 =?us-ascii?Q?8Mwf77Q4Vrl8ubYFI6q1Xo2uSf80+NI08Eddx06tcc6I9fiKAB+RHgkCLdqV?=
 =?us-ascii?Q?iyFKHUCNzf0BsqPKI5LwfdkxJMUIm7rbOfRFSfWGGfT4rX2xYSMMp6ryp1Z6?=
 =?us-ascii?Q?4yyt8JA2Nal0LpV47/Dzp0asF62VBYZUXCIpKYKJ0eoaX0qSfNuNjmgSgu5X?=
 =?us-ascii?Q?WwHS6UaI2d7A5sGOpodFauJFEUFI24P7tewHiP2jHooufhw5ZhPDpNq+PVAv?=
 =?us-ascii?Q?/7ui3QUFV0wJyKkznLoxU212YQA5JD/j3DFTmlFfLhry43vtBlOBpHI9cOlC?=
 =?us-ascii?Q?sxoZWWMlwvuR70fVBimbdi/ADdVH01YzFs+evOJVU7Dv7JmkK8V8Vac3j3a+?=
 =?us-ascii?Q?qqnWTy0+5jh0wjx3yneFoZOgmUsEftkJRuGPMtboDn9uMwecAT8MpH+mgsU+?=
 =?us-ascii?Q?oCqMBIxgiJULVmKnZX8dEeFkwcFPs/7oIWyEpD+rS8bvM0Qo4eHlW/+fjy/A?=
 =?us-ascii?Q?tQGbQNpjbJwQgEUsPBaDWSqJoR91mbK/6IHYSG8kMvLY9ugFw8SgBFTlyAUN?=
 =?us-ascii?Q?UTQUlcOdQN+GmHkSEkbzcEZaeyD49LXXsytf2IZgOMhbJVTgphRvGMrrxzaq?=
 =?us-ascii?Q?qiY1fiz0vIDjVBdDpcInHCPgSbyzltiwVaEkg5rIwc9cq1Bvm7Z65jiSijSQ?=
 =?us-ascii?Q?mYLVZCTAFgvrsSjjWyhju/doFEtLAFjfW7g3hTshfD+5EHd9Kj8TDHk4gs78?=
 =?us-ascii?Q?Euql1DJ233pYAXyqhdqUUkgaAFCi9dIFOu8wUoBnC0I3BAqw1co1hyjwWf9m?=
 =?us-ascii?Q?6KLVdzw0NbbE0Ut73xDHHmUJyuuuquYvNz7G6EG+YA5Bu8vn02SboKKpS5BJ?=
 =?us-ascii?Q?UnWKydw7nyS/BNtLCJBUPEKWR32xhy1UiHoaMXg5AawmkBmkFIUcCb6Vdnme?=
 =?us-ascii?Q?Zf55QE1nj87XRE6GB+KBP9szlf+xe7JKPvSoDcQ+Bb3GToqTKJl8jxuaVV1M?=
 =?us-ascii?Q?o+XdpMNHU0FuIXAyFV/8nEFYufWteOXBcyA7Y8MF/6llRqXrLMuD0iae+vAq?=
 =?us-ascii?Q?UqWucX3xUzRx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1787.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079519b4-2359-429d-c50d-08d8c35e49f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 07:28:20.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5jHucKvpyoCoF7uvrjsSSBGzRMNcnZP+PInSy8eLUcTbq1pdZuEHQc52joMG9cDw+z1f/kvyGKzTxr0v64ekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0875
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Thursday, November 26, 2020 3:55 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: boqun.feng@gmail.com; Ingo Molnar <mingo@redhat.com>;
> rcu@vger.kernel.org; vkuznets <vkuznets@redhat.com>; Michael Kelley
> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org
> Subject: Re: kdump always hangs in rcu_barrier() -> wait_for_completion()
>=20
> On Thu, Nov 26, 2020 at 10:59:19PM +0000, Dexuan Cui wrote:
> > > From: Paul E. McKenney <paulmck@kernel.org>
> > > Sent: Thursday, November 26, 2020 1:42 PM
> > >
> > > > > Another possibility is that rcu_state.gp_kthread is non-NULL, but=
 that
> > > > > something else is preventing RCU grace periods from completing, b=
ut in
> > > >
> > > > It looks like somehow the scheduling is not working here: in rcu_ba=
rrier()
> > > > , if I replace the wait_for_completion() with
> > > > wait_for_completion_timeout(&rcu_state.barrier_completion, 30*HZ),
> the
> > > > issue persists.
> > >
> > > Have you tried using sysreq-t to see what the various tasks are doing=
?
> >
> > Will try it.
> >
> > BTW, this is a "Generation 2" VM on Hyper-V, meaning sysrq only starts =
to
> > work after the Hyper-V para-virtualized keyboard driver loads... So, at=
 this
> > early point, sysrq is not working. :-( I'll have to hack the code and u=
se a
> > virtual NMI interrupt to force the sysrq handler to be called.
>=20
> Whatever works!
>=20
> > > Having interrupts disabled on all CPUs would have the effect of disab=
ling
> > > the RCU CPU stall warnings.
> > > 							Thanx, Paul
> >
> > I'm sure the interrupts are not disabled. Here the VM only has 1 virtua=
l CPU,
> > and when the hang issue happens the virtual serial console is still res=
ponding
> > when I press Enter (it prints a new line) or Ctrl+C (it prints ^C).
> >
> > Here the VM does not use the "legacy timers" (PIT, Local APIC timer, et=
c.) at
> all.
> > Instead, the VM uses the Hyper-V para-virtualized timers. It looks the
> Hyper-V
> > timer never fires in the kdump kernel when the hang issue happens. I'm
> > looking into this... I suspect this hang issue may only be specific to =
Hyper-V.
>=20
> Fair enough, given that timers not working can also suppress RCU CPU
> stall warnings.  ;-)
>=20
> 							Thanx, Paul

FYI: the issue has been fixed by this fix:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dfff7b5e6ee63c5d20406a131b260c619cdd24fd1

Thanks,
-- Dexuan
