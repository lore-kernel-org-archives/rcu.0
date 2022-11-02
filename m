Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1213C433FE
	for <rcu@archiver.kernel.org>; Wed,  2 Nov 2022 06:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKBGHP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Nov 2022 02:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKBGHO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Nov 2022 02:07:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71A423BCB
        for <rcu@vger.kernel.org>; Tue,  1 Nov 2022 23:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667369231; x=1698905231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oeAep+v9yhLvnu1Qu6M5idgbZogHi7NX7AG7iobgeeA=;
  b=BIZkcC092i+Lc5LHXbxnR9QzbvjRFOx/LBJ4k5dItvEMbEmj69j5Bk0d
   QX336xXDkfmGlvIbASjBB1uI414HNeOHPqAYRcp4cwifXottZ6PW54PGk
   wN4l9SNP8SghgyDDVFq6a/5L5PE7NusXRbGREY7lN3pSTWZAII1MD1iwK
   U0DS0YeEMnN/0gfnTZ0BcQHp1jksKkQvyiS+Ii2Px6RUyDuOj10vWXie0
   8akAHK/v2K9yzmdxaExxe71KWzr/q07o6oxmEJmqRCJp3NytXZlMMY39/
   sVliHIjkO18v4YIGfXHJtTjo051DMIk7RbY16BY2Dl/VOQ9Da8Pj2KYSg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="311039704"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="311039704"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 23:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="628834895"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="628834895"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2022 23:07:11 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 23:07:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 23:07:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 23:07:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqSIjp0YfB3Nb8wvNnOQU13gPxWqjOFwQaSjy4WQW0Z7snb3Awt2jdKs6Sw1ji+j254JIwKrWPFjMpfXztsXH5gpmNZS9NK2Y2GoDIiQuFU+YBUdzt+vcLaJx1Z6nFMeAy/cywZrS47FRca+5B8aNqhAur5Jnfvp2s933M7sRN82I1P+YGd1nmFgQsgUmFX2n+xuapEfpIqK1qFhIzCPb0QEI+/oVX/KtUsWQiZh77SAENE1HQUGlrNzOUyOjsqs1tYO/ZI7Kzf+IlbAj2ClfCkfQ/N1y470M5i7k08A+qg8UEp4z80pkLOwpOPztaWlirQx9ZWR0BM4v0IspJtElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WaLZJwpn+gdd/ClT2qm9pFfby8BNqSLMq3yDNk6yHA=;
 b=GL9Dcphb8IPBPte9ue98xg99OS+mXWYfeuyfQjkstHf4zuIC/Ac1RKkw7rdH43GcfNknHgmil/Hkik4rrgGTfNVShvFNbYKWnr7ggmz9S1aJWO0EWOvMZhrvfKzHrhGlcjNIUzN2eJGBKSGP5Ffvf7tMNfYVWaXkSbquZmCI4yCHLhzlCoEGPjthSDFawmJqdF/Zv8aGi81B1fhD2LOW2FHaCvhp8aVTQUAJTmVU4Sz6Nzol9x0Sg/b7qHAWW8B9Q3EjXm9ujcD2DGgN/nNAjJ9DxZtlcn4h0Gg3FWiGIwvc4QzjvgsXIlQicsq7YpTNmewWPjlccg5faOWR2JDKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 06:07:03 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%9]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 06:07:03 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: RE: [PATCH] srcu: Delegate work to the first online cpu if using
 SRCU_SIZE_SMALL
Thread-Topic: [PATCH] srcu: Delegate work to the first online cpu if using
 SRCU_SIZE_SMALL
Thread-Index: AQHY6OspTMvdEnT1Z0Os0kVmIKIlOa4gC04AgABKvQCAAF1wAIAA3CyAgADnXwCAASXcAIAAgyCAgAOjNICAA2yUEA==
Date:   Wed, 2 Nov 2022 06:07:03 +0000
Message-ID: <PH0PR11MB5880917B88DB5B45CDE63153DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221026032716.78674-1-kernelfans@gmail.com>
 <PH0PR11MB5880F4D3045159634170EFD0DA309@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CAFgQCTsFoS2qmF8N3KsQzKStPJesAqbNQK=VxhEs825OqfW2Kw@mail.gmail.com>
 <20221026135552.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1n1GT4HSxUEGYlT@piliu.users.ipa.redhat.com>
 <20221027165200.GZ5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1utslDY9Su3t7FM@piliu.users.ipa.redhat.com>
 <20221028181305.GQ5600@paulmck-ThinkPad-P17-Gen-1>
 <Y18o1x0F3EcZtskH@piliu.users.ipa.redhat.com>
In-Reply-To: <Y18o1x0F3EcZtskH@piliu.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB5053:EE_
x-ms-office365-filtering-correlation-id: cac5c825-1412-4e88-deb6-08dabc98767b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAmgB/gcsK1KkOEJKWE0Db8wXYCOBH7dCGzguuRSJ1JYh2cwM1GT8lrrW6bbnh+A4p1TFqa2FN6z40j6S6Us5IqOdcy3KRxk1ACLPiWI0gymfAe9rfn4QNqSpe3zMI6iE5nA05GjmJP+ouRbQ9NKdh2/uJbg+92S5TJlITjsUSZ+L0RCIJ2gvh0xTIgelIJ4Gl+Ey1o+X8P0YQLOXeY6aL1IMcBkVm0IqoulbvbZ4X7WQ24FBH9+vqJlobvPCwIHOGh4c355BOYwDtPk6BTY8GtahcObt7PX47dmNQIcp8IBG3T6Ho34UE9ptTnjil+pVKFxxi92NtQGlC3DOr9X+mfHisXaIjHtEMM4rhd5dL5Kte+B0HuMtS9pM1gnOxnm+7mxsEh+yjbV5WmKNjs3m4phBJVUn1RBMExcxghHAgH09YWbrzrSDE71eMuUH7091ZcoSily7JGGqJY7HTjbJWidLqK/9++34oeJcYSR4pfG0R4DgJek+n1O6ksTajYXiQlpR53Tj+8RpUEFC/WzfNy8lq/ROXaV2UiPg4su4edoXUzAJZjl3Jyj41SzJYvMsbOgdwx5tPNSwPnJqeCOvx+3JTe0n+dPLN/CERDIuvxCbf06hucgQO4ryXE2QDz1Rs2SVY5Jot3WhCiMEtHgWeiKHW8DK12Hiqe3SW0FG5V8XGxFobyO6b5zLR+tMK8/B7uYR7Iob5KNDCvE6EapKFYe0QOClOKSFRYikHMJxl8JOSxDnIeg6Xk/5IpxgaPu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199015)(83380400001)(33656002)(38100700002)(122000001)(38070700005)(82960400001)(86362001)(5660300002)(2906002)(8936002)(7416002)(8676002)(66446008)(64756008)(30864003)(4326008)(66476007)(66556008)(76116006)(66946007)(52536014)(41300700001)(53546011)(26005)(7696005)(9686003)(6506007)(186003)(54906003)(110136005)(478600001)(316002)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XqgH2YNbGwKcG9Kkph2dKO3iBrcxHRR5weqVMWGPMqy9mb22CKaA5ThNoFkk?=
 =?us-ascii?Q?WfcKzWFjyO5ZR80+f7mpqZl0hRx9D1b37bDaF/PRjBlCDYzsIjsfCQiI+Yo5?=
 =?us-ascii?Q?0Ai+WOezVfPCVaBkuwRJ+ryURLBUK200/2Ioi1B4aHOb2Mv1MhhCtelz9LOx?=
 =?us-ascii?Q?md12u1utRI8iF+UjxeklRvqUNVHCwiH16X9eV8mLvar4b3xLdA+CQkOVeHAe?=
 =?us-ascii?Q?PttsnTUUIHa6elwOyTv7FC0AKK75ksQbLqV3ID9CF9BSugvAYleCwg/QH2Qn?=
 =?us-ascii?Q?Uqigrd5u/g++tH/qGaAn78wqwnKoyfKRC5ayAReRDU51S0qIhEU7MV8lHUMQ?=
 =?us-ascii?Q?Kk16X9yPAL9hdudsdA7ZPYyq0kdzSlxGuy9JRsj1ZPpMqUP0CWSVvxGWD93g?=
 =?us-ascii?Q?Sz75g2J1aQnc3n8CjKjVVbl9Fy11a0BS34fZxP/ubJfL6xVAbBRL56Aww19S?=
 =?us-ascii?Q?P8ENpPHHaHw3CK2yZWV8sLvXDGMddB2U9/Yruei0IvfzDbLwIuFanYuXIwtg?=
 =?us-ascii?Q?KBXafgw1Dx5vAJz8/s2bkCyBqjO6rzjfySxjbiWrKVxZbgXyCFlx754N0m4u?=
 =?us-ascii?Q?6Fr6K+cgSf20Qe+llZl0pCrEymL0Uu50GBodWxdemzH7UPhAhLrNgeCZCt3B?=
 =?us-ascii?Q?2aypwfebb32N+pukTQrdVnGT1LBqUzP4Im8kXZbOE6gBfGebH+jy1PBlqisE?=
 =?us-ascii?Q?JH6UOZmS2eZwCJZ0jIx+xPmQnp0ym53oMvMSbrRe5hqqgzc0S5/NXOxOnos3?=
 =?us-ascii?Q?hjNGE4wzJkR620c2X9IXNVoO+1zgsixbeVlTz/fIRg/j/LFvXm5o3H9G2NBV?=
 =?us-ascii?Q?ui3LXVxNzqUmDJcu0BPCv8j8DJNDSgL0K3PzGxQi4MF/iN8tHRTDePcpL46w?=
 =?us-ascii?Q?GyA2v1k4A0I2QCMoeAJorBodFktriFVqzp/Jghk5EIgy1m89pIVIGuzUcOQd?=
 =?us-ascii?Q?Vy3ajfoUnaCQAx//9yPn42U6FpUZh3OTjBEDcD3DR/9sGUuwPex2DsomjXO7?=
 =?us-ascii?Q?6rtffgXlsagVAV/PSHFHG86orrVHKNTtBVA0zG651FSTKkb/p9GQhFV9M3Uf?=
 =?us-ascii?Q?a2vI5ghg3CkqfmKsz0I86x1vePquf0rrWL+xyknf4u+/3W6TH5EMpzbmMrrf?=
 =?us-ascii?Q?fk6tlNSEWHjbDHqECZKrJSvdNjMqFg5y3RPcVBBALaoznGlA1QyU8g90ym2a?=
 =?us-ascii?Q?z8c+jO6ZTjwU+Umf/sllpuZ2gQ3+zH110kh1EK70dusIYmQsNLu0pSO/otXl?=
 =?us-ascii?Q?zPsEE+2T9cWDABtGgLt5jSgPNTBw0TsuC0NmiT2DcZIBBVPZDgkmzAd1Xt1u?=
 =?us-ascii?Q?1Ctcl5ZW7B89IqS4lh/l11sncywTM49cq7L0WJE1WEDUUrNfNspyyivduYk1?=
 =?us-ascii?Q?hPJLPoJEUnXwIy/Hfo0F6QiSypeWFDT16l/VepvqpBe27EQq6y2Q5YLa/6IP?=
 =?us-ascii?Q?jSPAGjHRphgReiHzLErQd24lzqJP+vJ5hDjDZY6S8tGam0aiscsAPK2BzlA8?=
 =?us-ascii?Q?wQ/OFC7NJe4pjWQtnpaTEW2oKTOXyR+1AjQvB4yz1oQRw0EoHfQkectSlgdL?=
 =?us-ascii?Q?V/TPVl1Wj2B/CT+g8yyIA0RIMaF1rgyrYZAkHq+1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac5c825-1412-4e88-deb6-08dabc98767b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 06:07:03.5071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rg13GjnZnU/sNgOE+zB9nQ+m6s6wBJPb8THIV0TUNMjjVOaPPAnDAToQfp0vcWElMuMPKwB5LWKkeX/+KgAUrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 28, 2022 at 11:13:05AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 28, 2022 at 06:23:46PM +0800, Pingfan Liu wrote:
> > Some stuff is PowerPC specific, CC PowerPC experts, please correct me i=
f
> > I make a mistake.
> >=20
> > On Thu, Oct 27, 2022 at 09:52:00AM -0700, Paul E. McKenney wrote:
> > > On Thu, Oct 27, 2022 at 11:03:53AM +0800, Pingfan Liu wrote:
> > > > On Wed, Oct 26, 2022 at 06:55:52AM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Oct 26, 2022 at 04:21:26PM +0800, Pingfan Liu wrote:
> > > > > > On Wed, Oct 26, 2022 at 12:36 PM Zhang, Qiang1 <qiang1.zhang@in=
tel.com> wrote:
> > > > > > >
> > > > > > > >
> > > > > > > >commit 994f706872e6 ("srcu: Make Tree SRCU able to operate w=
ithout
> > > > > > > >snp_node array") assumes that cpu 0 is always online, but th=
at is not
> > > > > > > >the truth when using maxcpus=3D1 in the command line for the=
 kdump kernel.
> > > > > > > >
> > > > > > > >On a PowerPC, the following kdump kernel hanging is observed=
:
> > > > > > > >...
> > > > > > > >[    1.740036] systemd[1]: Hostname set to <xyz.com>
> > > > > > > >[  243.686240] INFO: task systemd:1 blocked for more than 12=
2 seconds.
> > > > > > > >[  243.686264]       Not tainted 6.1.0-rc1 #1
> > > > > > > >[  243.686272] "echo 0 > /proc/sys/kernel/hung_task_timeout_=
secs" disables this message.
> > > > > > > >[  243.686281] task:systemd         state:D stack:0     pid:=
1     ppid:0      flags:0x00042000
> > > > > > > >[  243.686296] Call Trace:
> > > > > > > >[  243.686301] [c000000016657640] [c000000016657670] 0xc0000=
00016657670 (unreliable)
> > > > > > > >[  243.686317] [c000000016657830] [c00000001001dec0] __switc=
h_to+0x130/0x220
> > > > > > > >[  243.686333] [c000000016657890] [c000000010f607b8] __sched=
ule+0x1f8/0x580
> > > > > > > >[  243.686347] [c000000016657940] [c000000010f60bb4] schedul=
e+0x74/0x140
> > > > > > > >[  243.686361] [c0000000166579b0] [c000000010f699b8] schedul=
e_timeout+0x168/0x1c0
> > > > > > > >[  243.686374] [c000000016657a80] [c000000010f61de8] __wait_=
for_common+0x148/0x360
> > > > > > > >[  243.686387] [c000000016657b20] [c000000010176bb0] __flush=
_work.isra.0+0x1c0/0x3d0
> > > > > > > >[  243.686401] [c000000016657bb0] [c0000000105f2768] fsnotif=
y_wait_marks_destroyed+0x28/0x40
> > > > > > > >[  243.686415] [c000000016657bd0] [c0000000105f21b8] fsnotif=
y_destroy_group+0x68/0x160
> > > > > > > >[  243.686428] [c000000016657c40] [c0000000105f6500] inotify=
_release+0x30/0xa0
> > > > > > > >[  243.686440] [c000000016657cb0] [c0000000105751a8] __fput+=
0xc8/0x350
> > > > > > > >[  243.686452] [c000000016657d00] [c00000001017d524] task_wo=
rk_run+0xe4/0x170
> > > > > > > >[  243.686464] [c000000016657d50] [c000000010020e94] do_noti=
fy_resume+0x134/0x140
> > > > > > > >[  243.686478] [c000000016657d80] [c00000001002eb18] interru=
pt_exit_user_prepare_main+0x198/0x270
> > > > > > > >[  243.686493] [c000000016657de0] [c00000001002ec60] syscall=
_exit_prepare+0x70/0x180
> > > > > > > >[  243.686505] [c000000016657e10] [c00000001000bf7c] system_=
call_vectored_common+0xfc/0x280
> > > > > > > >[  243.686520] --- interrupt: 3000 at 0x7fffa47d5ba4
> > > > > > > >[  243.686528] NIP:  00007fffa47d5ba4 LR: 0000000000000000 C=
TR: 0000000000000000
> > > > > > > >[  243.686538] REGS: c000000016657e80 TRAP: 3000   Not taint=
ed  (6.1.0-rc1)
> > > > > > > >[  243.686548] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,=
LE>  CR: 42044440  XER: 00000000
> > > > > > > >[  243.686572] IRQMASK: 0
> > > > > > > >[  243.686572] GPR00: 0000000000000006 00007ffffa606710 0000=
7fffa48e7200 0000000000000000
> > > > > > > >[  243.686572] GPR04: 0000000000000002 000000000000000a 0000=
000000000000 0000000000000001
> > > > > > > >[  243.686572] GPR08: 000001000c172dd0 0000000000000000 0000=
000000000000 0000000000000000
> > > > > > > >[  243.686572] GPR12: 0000000000000000 00007fffa4ff4bc0 0000=
000000000000 0000000000000000
> > > > > > > >[  243.686572] GPR16: 0000000000000000 0000000000000000 0000=
000000000000 0000000000000000
> > > > > > > >[  243.686572] GPR20: 0000000132dfdc50 000000000000000e 0000=
000000189375 0000000000000000
> > > > > > > >[  243.686572] GPR24: 00007ffffa606ae0 0000000000000005 0000=
01000c185490 000001000c172570
> > > > > > > >[  243.686572] GPR28: 000001000c172990 000001000c184850 0000=
01000c172e00 00007fffa4fedd98
> > > > > > > >[  243.686683] NIP [00007fffa47d5ba4] 0x7fffa47d5ba4
> > > > > > > >[  243.686691] LR [0000000000000000] 0x0
> > > > > > > >[  243.686698] --- interrupt: 3000
> > > > > > > >[  243.686708] INFO: task kworker/u16:1:24 blocked for more =
than 122 seconds.
> > > > > > > >[  243.686717]       Not tainted 6.1.0-rc1 #1
> > > > > > > >[  243.686724] "echo 0 > /proc/sys/kernel/hung_task_timeout_=
secs" disables this message.
> > > > > > > >[  243.686733] task:kworker/u16:1   state:D stack:0     pid:=
24    ppid:2      flags:0x00000800
> > > > > > > >[  243.686747] Workqueue: events_unbound fsnotify_mark_destr=
oy_workfn
> > > > > > > >[  243.686758] Call Trace:
> > > > > > > >[  243.686762] [c0000000166736e0] [c00000004fd91000] 0xc0000=
0004fd91000 (unreliable)
> > > > > > > >[  243.686775] [c0000000166738d0] [c00000001001dec0] __switc=
h_to+0x130/0x220
> > > > > > > >[  243.686788] [c000000016673930] [c000000010f607b8] __sched=
ule+0x1f8/0x580
> > > > > > > >[  243.686801] [c0000000166739e0] [c000000010f60bb4] schedul=
e+0x74/0x140
> > > > > > > >[  243.686814] [c000000016673a50] [c000000010f699b8] schedul=
e_timeout+0x168/0x1c0
> > > > > > > >[  243.686827] [c000000016673b20] [c000000010f61de8] __wait_=
for_common+0x148/0x360
> > > > > > > >[  243.686840] [c000000016673bc0] [c000000010210840] __synch=
ronize_srcu.part.0+0xa0/0xe0
> > > > > > > >[  243.686855] [c000000016673c30] [c0000000105f2c64] fsnotif=
y_mark_destroy_workfn+0xc4/0x1a0
> > > > > > > >[  243.686868] [c000000016673ca0] [c000000010174ea8] process=
_one_work+0x2a8/0x570
> > > > > > > >[  243.686882] [c000000016673d40] [c000000010175208] worker_=
thread+0x98/0x5e0
> > > > > > > >[  243.686895] [c000000016673dc0] [c0000000101828d4] kthread=
+0x124/0x130
> > > > > > > >[  243.686908] [c000000016673e10] [c00000001000cd40] ret_fro=
m_kernel_thread+0x5c/0x64
> > > > > > > >[  366.566274] INFO: task systemd:1 blocked for more than 24=
5 seconds.
> > > > > > > >[  366.566298]       Not tainted 6.1.0-rc1 #1
> > > > > > > >[  366.566305] "echo 0 > /proc/sys/kernel/hung_task_timeout_=
secs" disables this message.
> > > > > > > >[  366.566314] task:systemd         state:D stack:0     pid:=
1     ppid:0      flags:0x00042000
> > > > > > > >[  366.566329] Call Trace:
> > > > > > > >...
> > > > > > > >
> > > > > > > >In that case, note that maxcpus=3D1 instead of nr_cpus=3D1 i=
s used in the
> > > > > > > >kernel command line on the PowerPC platform. Consequently, t=
he crash cpu
> > > > > > > >is the only onlined cpu in the kdump kernel, but with its lo=
gical id not
> > > > > > > >necessary 0. While SRCU queues a sdp->work on cpu 0, on whic=
h no worker
> > > > > > > >thread is created, so sdp->work will be never executed and
> > > > > > > >__synchronize_srcu() can not be completed.
> > > > > > > >
> > > > > > > >Tackle this issue by queueing sdp->work on the first onlined=
 cpu.
> > > > > > > >
> > > > > > > >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > > > >Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > >Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > > > >Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > > > >Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > > > >Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > > >To: rcu@vger.kernel.org
> > > > > > > >---
> > > > > > > > kernel/rcu/srcutree.c | 10 ++++++----
> > > > > > > > 1 file changed, 6 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > > >index 1c304fec89c0..f2df561e0995 100644
> > > > > > > >--- a/kernel/rcu/srcutree.c
> > > > > > > >+++ b/kernel/rcu/srcutree.c
> > > > > > > >@@ -663,7 +663,7 @@ static void srcu_gp_start(struct srcu_st=
ruct *ssp)
> > > > > > > >       int state;
> > > > > > > >
> > > > > > > >       if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SI=
ZE_WAIT_BARRIER)
> > > > > > > >-              sdp =3D per_cpu_ptr(ssp->sda, 0);
> > > > > > > >+              sdp =3D per_cpu_ptr(ssp->sda, cpumask_first(c=
pu_online_mask));
> > > > > > > >       else
> > > > > > > >               sdp =3D this_cpu_ptr(ssp->sda);
> > > > > > > >       lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
> > > > > > > >@@ -774,7 +774,8 @@ static void srcu_gp_end(struct srcu_stru=
ct *ssp)
> > > > > > > >       /* Initiate callback invocation as needed. */
> > > > > > > >       ss_state =3D smp_load_acquire(&ssp->srcu_size_state);
> > > > > > > >       if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
> > > > > > > >-              srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, 0=
), cbdelay);
> > > > > > > >+              srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda,
> > > > > > > >+                                      cpumask_first(cpu_onl=
ine_mask)), cbdelay);
> > > > > > > >       } else {
> > > > > > > >               idx =3D rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->=
srcu_have_cbs);
> > > > > > > >               srcu_for_each_node_breadth_first(ssp, snp) {
> > > > > > > >@@ -1093,7 +1094,7 @@ static unsigned long srcu_gp_start_if_=
needed(struct srcu_struct *ssp,
> > > > > > > >       idx =3D srcu_read_lock(ssp);
> > > > > > > >       ss_state =3D smp_load_acquire(&ssp->srcu_size_state);
> > > > > > > >       if (ss_state < SRCU_SIZE_WAIT_CALL)
> > > > > > > >-              sdp =3D per_cpu_ptr(ssp->sda, 0);
> > > > > > > >+              sdp =3D per_cpu_ptr(ssp->sda, cpumask_first(c=
pu_online_mask));
> > > > > > >
> > > > > > > Hi Pingfan
> > > > > > >
> > > > > > > If CPU0 support hotplug.
> > > > > > > For example , in this time cpumask_first(cpu_online_mask) ret=
urn 0
> > > > > > >
> > > > > > > >       else
> > > > > > > >               sdp =3D raw_cpu_ptr(ssp->sda);
> > > > > > > >       spin_lock_irqsave_sdp_contention(sdp, &flags);
> > > > > > > >@@ -1429,7 +1430,8 @@ void srcu_barrier(struct srcu_struct *=
ssp)
> > > > > > > >
> > > > > > > >       idx =3D srcu_read_lock(ssp);
> > > > > > > >       if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SI=
ZE_WAIT_BARRIER)
> > > > > > > >-              srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sd=
a, 0));
> > > > > > > >+              srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sd=
a,
> > > > > > > >+                                      cpumask_first(cpu_onl=
ine_mask)));
> > > > > > >
> > > > > > > Due to CPU hotplug, CPU0 have been offline, assume srcu_size_=
state is still SRCU_SIZE_WAIT_CALL.
> > > > > > > in this time, cpumask_first(cpu_online_mask) not return 0,  t=
his will cause the srcu barrier to return directly.
> > > > > >=20
> > > > > > Thanks for catching this bug.
> > > > >=20
> > > > > Indeed, good catch!
> > > > >=20
> > > > > > It seems that get_boot_cpu_id() can tackle the whole issue.  I =
will
> > > > > > wait for more comments and send out V2.
> > > > >=20
> > > > > Does your patch require the CPU indicated by get_boot_cpu_id() to=
 always
> > > > > stay online?  If so, is that CPU guaranteed to always stay online=
?
> > > >=20
> > > > No, it is just a replacement for cpu 0.
> > > >=20
> > > > A qualified candidate should meet two requirements:
> > > > -1. worker_pool is initialized, so it has worker thread to dispatch
> > > > work. This is satisfied by once the cpu was onlined. =20
> > > >=20
> > > > -2. this cpu id is persistent as Zqiang pointed out.
> > > >=20
> > > > For hotplug, it is the same as cpu 0, which is taken care of by the
> > > > workqueue infrastructure.
> > > >=20
> > > > > I am still asking my question about PowerPC booting with a non-ze=
ro CPU.
> > > > > After all, if all remaining architectures always boot with CPU 0,=
 then
> > > > > perhaps some simplification is in order.
> > > >=20
> > > > As my understanding, it is not easy. Let us unfold the discussion i=
n
> > > > another thread post by you.
> > >=20
> > > As you wish...
> > >=20
> > > First, let me see if I understand the options.
> > >=20
> > > 1.	Take your initial patch, but fixing the issue pointed out by
> > > 	Zhang Qiang.  One issue is that cpu_online_mask is not initialized
> > > 	until boot_cpu_init() is invoked.  Given that SRCU is used by
> > > 	tracing, we must correctly handle early boot usage.
> >=20
> > The hotplug issue takes some effort to fix, so if there is a better way
> > to go, it should be avoided.
> >=20
> > But you make me aware that I miss the early boot usage.
> > I think it carefully and hope I can learn from this lesson. Please
> > correct me if I am wrong in the following assumption.
> >=20
> > Since ftrace_init() comes after srcu_init(), so before srcu_init(), onl=
y
> > _mcount has the opportunity to use SRCU, right?
> >=20
> > If that part does not use the SRCU function like srcu_barrier(), it wil=
l
> > not a problem. Right?
>=20
> We would need to ask the ftrace and bpf people to make sure.  Except that
> in the past, my fond assumptions about things not happening before
> some point in boot have almost always been rudely invalidated, just so
> you know.  ;-)
>=20
> > > 2.	Update your initial patch to fix the issue pointed out by Zhang
> > > 	Qiang and also to use get_boot_cpu_id() as you suggested earlier.
> > > 	Except that the __boot_cpu_id variable read by get_boot_cpu_id()
> > > 	is also initialized by boot_cpu_init(), and is zero up to
> > > 	that point.  So this has the same problem as #1 above.
> >=20
> > This is the way that I want to take.
> >=20
> > On the PowerPC, #define raw_smp_processor_id() (local_paca->paca_index)=
,
> > instead of (*raw_cpu_ptr(&cpu_number)).
> > So in fact, boot_cpu_init()->smp_processor_id() gets the "boot_cpuid",
> > which is assigned to __boot_cpu_id() later.
>=20
> I have to ask...  What does "boot_cpu_init()->smp_processor_id()" mean?
>=20
>
>void __init boot_cpu_init(void)
>{
>        int cpu =3D smp_processor_id();
>                  ^^^ This is specific on PowerPC, which is finally implem=
ented by "#define raw_smp_processor_id() (local_paca->paca_index)"
>		      And it is not zero up at this point. For the initialization of ->p=
aca_index, please refer to the old comment just right after this function.
>
>
>        /* Mark the boot cpu "present", "online" etc for SMP and UP case *=
/
>        set_cpu_online(cpu, true);
>        set_cpu_active(cpu, true);
>        set_cpu_present(cpu, true);
>        set_cpu_possible(cpu, true);
>
>#ifdef CONFIG_SMP
>        __boot_cpu_id =3D cpu;
>	                ^^^ Actually, cpu will not be zero up
>#endif
>}
>

> > For boot_cpuid, early_init_devtree()->early_init_dt_scan_cpus() decides
> > it. Then early_init_devtree()->allocate_paca(boot_cpuid)->initialise_pa=
ca(),
> > where new_paca->paca_index =3D cpu;
> >=20
> > All these are done before start_kernel().
> >=20
>
>More accurate info:
>arch/powerpc/kernel/head_64.S:973:   LOAD_REG_ADDR(r12, DOTSYM(early_setup=
))  results in the calling to early_setup()
->early_init_devtree(), which finally sets up the local_paca->paca_index
>
>Then=20
>arch/powerpc/kernel/head_64.S:1002:  bl      start_kernel
>
>So before the common kernel starts, PowerPC has made its effort so that
>get_boot_cpu_id() can keep its semantic.
>
> > I have tested a patch adopting this method. It works.
>=20
> Could you please send the actual patch?
>=20
>
>Sure, I will sent out it right after finishing this mail.
>
> > > 3.	As in #2 above, but modify srcu_init() to check for SRCU callbacks
> > > 	queued on CPU 0 when boot_cpu_init() returns non-zero.  In this
> > > 	case, move those SRCU callbacks to the srcu_data structure
> > > 	indicated by boot_cpu_init().
> > >=20
> > > 4.	Leave the SRCU code alone, but boot your crash kernel with
> > > 	srcutree.big_cpu_lim=3D0.  This would switch all srcu_struct
> > > 	structures to big mode at initialization time.	Once this switch
> > > 	completed, CPUs would queue SRCU callbacks on their own srcu_data
> > > 	structure's ->srcu_cblist.
> > >=20
> > > 	I am not optimistic about this one, but could you please try it?
> >=20
> > I have tested it five times. It works.
>=20
> Given that it seems to work, I find this approach extremely attractive.
> Hence my question about CPU 0's per-CPU variables in my recent email to
> Michael Ellerman.
>=20
>
>Sorry that I can not get your point. Are you suggesting to append an extra
>kernel param to the kdump kernel?
>
>
>Thanks,
>
>	Pingfan
>
>
> > > 5.	Start over with the current SRCU code.	Make srcu_delay_timer()
> > > 	and srcu_queue_delayed_work_on() check to see if sdp->cpu is
> > > 	online, and if not, use queue_work() instead of queue_work_on().
> > > 	There might be other adjustments required, but I am not
> > > 	immediately seeing them.
> > >=20

Hi Pingfan, does this change look clearer?

--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -745,19 +745,23 @@ static void srcu_gp_start(struct srcu_struct *ssp)
        WARN_ON_ONCE(state !=3D SRCU_STATE_SCAN1);
 }

+static inline int sdp_cpu(struct srcu_data *sdp)
+{
+       return cpu_online(sdp->cpu) ? sdp->cpu : raw_smp_processor_id();
+}

 static void srcu_delay_timer(struct timer_list *t)
 {
        struct srcu_data *sdp =3D container_of(t, struct srcu_data, delay_w=
ork);

-       queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
+       queue_work_on(sdp_cpu(sdp), rcu_gp_wq, &sdp->work);
 }

 static void srcu_queue_delayed_work_on(struct srcu_data *sdp,
                                       unsigned long delay)
 {
        if (!delay) {
-               queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
+               queue_work_on(sdp_cpu(sdp), rcu_gp_wq, &sdp->work);
                return;
        }

Thanks
Zqiang

> > > At the moment, #5 looks by far the best to me.
> >=20
> > The boot cpu is guaranteed to be online once. That condition relaxes th=
e
> > code. But if you do not like #2, I am happy to have a shot on #5.
>=20
> I need to see the patch for your #2 before I make any decision between
> #2 and #5.  But #4, if it works for real rather than by accident, looks
> even better.
>=20
> > Thanks for your detailed suggestion.
>=20
> And thank you for finding this issue and your continued attention to it.
>=20
> 							Thanx, Paul
>=20
> > Regards,
> >=20
> > 	Pingfan
> >=20
> >=20
> > > But first, are there any options that I am missing?  Or, for that mat=
ter,
> > > am I confused about any of the options that I called out?
> > >=20
> > > 							Thanx, Paul
