Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770E0C43334
	for <rcu@archiver.kernel.org>; Thu,  2 Jun 2022 05:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiFBFpZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jun 2022 01:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiFBFpY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jun 2022 01:45:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E523B56A
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 22:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654148721; x=1685684721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YRFBqamylivOLROmiegTiMqYdzUOQDsPqbPjJgvFz20=;
  b=avzGiT0vALbHBQ6O+cy/M+cqe6A3DMbhHDB/JzCTugIN2N7Yi/qCRoI9
   5EjgCA+U4wSOPi8Mr95nCHKBD9Xls7ImJg2pYi8gLez9npUbTVU4/Yc8s
   VDl6O4WobH20As8tnDislphc5hZR00C96FKipbKCNS9BchiXn6qfvAMLs
   LrYF/Nv8h9B5VWQYqI3rJlGe31NOxQqLEBbMhaD2imJkb70YiKMeYJb0O
   oRF0UsGmzN+80ZEmQ0X9oV+tsHvxKQPWuKCKL3rEgUI9M6XAwa1sQe+jm
   j+j1u+d1xUjs4j5ZoCkyb+19dzU7WRG4RsHXYu6X6mhr7hXNtAmNZubC7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275839479"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="275839479"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 22:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="756813094"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2022 22:45:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 22:45:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 22:45:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 22:45:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 22:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQ4a7V2y3OUVWFqVGjIv1rt/l/hLpuYJEK/xJgfQiTIC5hzboJdt/D6Nus4SJCdTBt7Ky+Dixp59fgXvIaxHSVeCdaIBTttcuwDij97jQbnp06vRmu6SZIVcGVwB2vttDEPhZEO5hBIXVFcgNWzM11d8T9LU0/0YIvkqFxAPAQJK9Y94MYC2KkYp9mYU8hM76brwXN3caWkE3NzCPQ51Bf4FMtyoh7bVMxemuEAbhWPVivvirMIE4UEtCUtgX5p1Rt7Jo3SIhgKh3q/GHs4uKzQiroC2dzjCMgr6GiGkmjfpCSPsYKaNVFrmyN4jgWz4XVsjTzDSMq/vZafB7OFZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7IZJseZyNSygN3L7L1/lYuaobYUHOFX5XXMBeea5AI=;
 b=nf1KNH28shxxoQy8+t5pzm9Idb2KokAgQ75+kmCI/f75tQq2OeS9/8TePoi7G9naTcP/bfa50yLoqrj/bNrseFwoYlkUrbFvPEUE0ziH70P2OcBi66cHo/B8pUcvxQLlm+zTlUCcgnhNChS0Z6rrsQ5TjDNpbapfjHT4uwZQ4yg0NtWKNPBAeGiAGhUeIIlJz46cBr/rgOlOzcspiIpT/DnXxSX2G5GtnEnPWA5Js0XzymbtU/Dm9ddbKwVaQ/y5t0rgH/Es/rDxQzc3hJoP24eGSKvrhIzivJ6KN2568maiRjO5+/edRX92KgblWBzPQlIvgycsJ9Igf4BPIWZhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BYAPR11MB3206.namprd11.prod.outlook.com (2603:10b6:a03:78::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Thu, 2 Jun
 2022 05:45:18 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 05:45:18 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [Question] About rcu_nocb_poll bootargs
Thread-Topic: [Question] About rcu_nocb_poll bootargs
Thread-Index: Adh2IdX5WBxfPCDRTXiD1Dt/WvPIPwAFjKAAAACD8BA=
Date:   Thu, 2 Jun 2022 05:45:18 +0000
Message-ID: <PH0PR11MB58803A844F44DA9B80FE4B2FDADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <PH0PR11MB58804878EF58CEB821D4C4ADDADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220602042004.GP1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220602042004.GP1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 697ef872-2605-43b5-5c90-08da445b133d
x-ms-traffictypediagnostic: BYAPR11MB3206:EE_
x-microsoft-antispam-prvs: <BYAPR11MB320642655000AC386AE78408DADE9@BYAPR11MB3206.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lRVyAO9+w2OX9FBQj4Xvqcude7OdnczPWoMffn3H750P54dPWXx+J1My1ohT9wNCCk5i6nQbvbOjyF+4SDSd8vduRVH6Si6RCxJ7QifTHqeEF4SjCFAQd34qosWo1jI0GvDg1R/c2ExcFUTeF7hTlMJpARUJRzxYDaRkiaG3cQs9fHy3fuoTHkKGwV6ieM8t8L0FS+MALmd3P9z3tv4B7HHbG8ga5cJIAGWw5LEXCN/lwJo2yLP+SSTI1jflzCa4B4lu/FRz078CEObJ++REzQ97YWcca3NqNNS34G6nVD7KwUlgqbx3iwgJn+7e7IJ1E3+l6Kx8lH1Nvu0z7JAWYYwQmqhKSq8O7QkBuYQNAOD4hJXhoJN/cW0atEQxEuP5o0Wj7MBoUqVOuUh0XWZESXw9PD335Y1y2LcD61GZyn+LrBIgBeuvWxDLr5TYPDDGZocAHbv3Hn6HV1kJdJqBBb6sTkAYQ4oQeZLKFUU8Ge1gVZDmzbixofkXFtXfxa/Vik5d6LqbsYx4zhguchOhtvMlyziOpvVG5zzlxvCHHACrqHvRMVtisnx4eoox1esSoPi4D8UtLDeyXh2apu3EiZLzh/b7U/nGdceLSI7QZMva12e+1c+JfZQi1VZ4vIxkFJPzz1/rA1/6mP+OEyKwvfPxh3pvlBSDzp24ZK64VBqoseZX6/+VKTiCcs3gJa4cXTHZpBFe0+WW+06u8PO5zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(84040400005)(4326008)(5660300002)(83380400001)(6506007)(9686003)(8936002)(76116006)(38100700002)(8676002)(2906002)(55016003)(82960400001)(66946007)(52536014)(66476007)(66556008)(7696005)(38070700005)(66446008)(64756008)(508600001)(6916009)(316002)(26005)(86362001)(71200400001)(54906003)(66574015)(122000001)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4s5AdzawRnXAne4fQ7VBUuFy+3vYt81wPdxYsAdwVdBv/73+R/tY9dp/lVkk?=
 =?us-ascii?Q?gvu0sDAPyvSp3hBFVoEES0tQYQl/g12uOi4DAvX9OkTqUS5N/rxQjt3uM3cd?=
 =?us-ascii?Q?EHL5X+YfGII72qNYabUIRDlwaIkG1yAl7vzr8DSINZfW4UImGF83zQNYaKxP?=
 =?us-ascii?Q?UXmEchBcPofqHnuKkySdCBTCIV0+sI6S/SfdhujmWRzqP9Hn205QieRKvYGj?=
 =?us-ascii?Q?c1FGspyQ+qw8PAoEIeZVPebAFSEQa1SX/RyteuxVONobKuBNigjKB48IxdpM?=
 =?us-ascii?Q?s/d05KuwERrSiIbcCP2zLbMP40TOBPrysHdh9gLkmQye44Mw1rWuIM30WCyk?=
 =?us-ascii?Q?dZ3exxj5tOSht86S3Nu8lHEqkqCZu3l+lb318w+ALRDsKqrFY8hXGSbvyOwB?=
 =?us-ascii?Q?NPJe7DeNyiHu7JhEkdBDXJIzJU8XxrBwvJPY3FPGKUuboNYpvCWpRZ4BEhYI?=
 =?us-ascii?Q?4wOVllIrOHGxYu9ITFPrIEhBoQFswND3g5a+fTrAW3RacyYejXhb26bbkG8x?=
 =?us-ascii?Q?b0VKYWJqgulkhOZdIP64JCXFqk6RZZTgkY6ZXEXdBxR6uRHgAorTu6wN7bOu?=
 =?us-ascii?Q?9y5bQC1eLO65MDZkYoBesiiKprmnZV9D+50nVyfIuVeTnakyJDY5LUQSL/eJ?=
 =?us-ascii?Q?UcgroolxXoVFzV7SQzcsl/fUvDj7+/g7KgVJABM8S7cGhyme0lU52x32jcs+?=
 =?us-ascii?Q?h91HZ+Ssw4vW6nAXFzeEkZqrzAa30L6ztqypcnEof0FJbiiXGqgNdrvhWWE3?=
 =?us-ascii?Q?jZmvsUg5CKtVtjiwpUmCEbuFPVhVpRSDbNtEwKz7r+OlhGbG4KGKDcLcv8eB?=
 =?us-ascii?Q?eEwxsc7ozmvggjt9jK39a5C+HZDXvJXVxvAwvFpaUZhIPutRMZuRdP4NwXj5?=
 =?us-ascii?Q?fU7z11ahvy/9HscDdLOKCCphq5Yh6RSRL8jszM3o9UriUlrmMfg+SQcvyrC+?=
 =?us-ascii?Q?VPGIDVvF7Wp1tqQLzVFCTZrnwdsgSVtkLkBmuUGshWlUvt3Iq7SsPiX/9lLY?=
 =?us-ascii?Q?xNSmHV7dzfX1PKGluDUp1mXYWY2x7E3jGwH6lGoJgLPGLIRROWGOS5rqWV/l?=
 =?us-ascii?Q?r64kV/EMU3ew3jG5XiaBs1c8Fva8h/RxPqnDMlzDYdRWlPlpw+wAP9953IWs?=
 =?us-ascii?Q?JCVuB2QgsxjMRTDpLdsl1Gxyi7YNb+1+cv6kHdFDN8pNqxh6hRPYumrLuHrt?=
 =?us-ascii?Q?XgTBstFmnzE2srT1UWCirl0u2f2kL/ZHPNZBu2NSB0CGfuIOUFQ/7HbaOu3R?=
 =?us-ascii?Q?cKuQ1QoFGMc81Q34FN0QJZrpIoTPDN+Gwk5xHTPDkw3xYxtIa1Dd4q1JwCH8?=
 =?us-ascii?Q?axotOKG83tpf4CAI3WGXTtf4AF7ZPC2RnM2hP2qDfgwh7rIA98aPDZMsIWLy?=
 =?us-ascii?Q?ld1dKquwYMz9j88gCl9OTXdDR7458DXcKSy1jq3IRHxPngKCxF5KLBjkIz0d?=
 =?us-ascii?Q?jrCqs3rxzVewiNQusoYuXVI0tSjJ38KHpjnCThPQ4scnSR/lx2yFDNe+r/Bp?=
 =?us-ascii?Q?COd0ZMfhAIDfJHLjtISjzSI29IGZ+75B4dtqSChZmYUs3Xsnyib+fy7oAiWF?=
 =?us-ascii?Q?fOuj3CnDVBie0AGAmf/4TuWX2VogJ48k5AlZM2knCtTvBYE8Un/9+w3DfJwQ?=
 =?us-ascii?Q?OmeLhULpN7bFveRB4kpTPnEPV+7Jon3V+guHHEQa4hLdLeRxlNHN/fvjWVoW?=
 =?us-ascii?Q?O7H5ED3DqlDKiT9MVzwL6LHM/GW2DVQiumMFLEPYctVetJz6cL9enKDCja+m?=
 =?us-ascii?Q?hw5LEw9KEg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697ef872-2605-43b5-5c90-08da445b133d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 05:45:18.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gsb5q6BO6rVInxeFexOgmuODP9leUqWV0Rehla1zkTZJSW3nxE6GT8M0CsmG2l4gkHKgAKP+ScloCNBGCP7D7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3206
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


On Thu, Jun 02, 2022 at 02:06:50AM +0000, Zhang, Qiang1 wrote:
> Hi All
>=20
> Currently, I have tested as follows:
>=20
> runqemu kvm slirp nographic qemuparams=3D"-m 2048 -smp 4" =20
> bootparams=3D"isolcpus=3D2,3  nohz_full=3D2,3 rcu_nocbs=3D2,3=20
> rcutree.dump_tree=3D1, rcu_nocb_poll" -d
>=20
> rcu:     Offload RCU callbacks from CPUs: 2-3.
> rcu:     Poll for callbacks from no-CBs CPUs.
> rcu: rcu_organize_nocb_kthreads: No-CB GP kthread CPU 0: 1   (rcuog/0)
> rcu: rcu_organize_nocb_kthreads: No-CB GP kthread CPU 2: 3   (rcuog/2)
>=20
> but I find the rt-fifo rcuog/0 kthreads always doing polling, but due=20
> to the my_rdp->nocb_head_rdp always is empty, this doesn't do the=20
> actual thing,  Is it possible that we do not polling when the nocb_head_r=
dp  linked list is empty, and polling when it is not empty.
>=20
> Any thought?

>If I understand your question correctly, you would like to avoid polling w=
hen the rcuog kthread's CPU's rcu_data structure's nocb_head_rdp list is em=
pty.  This could happen only when all of the CPUs served by that rcuog kthr=
ead have been de-offloaded, correct?

Yes, thanks Paul reply.  I'll be more careful with my wording next time.

>
>If so, this is not currently a user-visible issue, but it would be good to=
 fix it before offloading and de-offloading becomes user-visible.
>
>If this is what you were thinking, what did you have in mind for a fix?

When rcu_nocb_poll is set and the rcuog kthread's CPU's rcu_data structure'=
s nocb_head_rdp list is empty,=20
treat rcuog kthread like non-polling mode and put them in the waitqueue(my_=
rdp->nocb_gp_wq) for waiting,
when nocb_head_rdp list is not empty(rcu_nocb_poll && !list_empty(nocb_head=
_rdp)),  re-entering periodic wake-up mode. I need yours opinion.

Any thought?

Thanks
Zqiang

>
>(We need to get Frederic's view in any case, of course.)
>
>							Thanx, Paul
