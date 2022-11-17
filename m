Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD67C433FE
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 01:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKQBj7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 20:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKQBj6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 20:39:58 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788186AEDE
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 17:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668649195; x=1700185195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eeIDwlPHTUyjbbNuCiFIDi2lQBcV+dhWk6p1ZYvDszo=;
  b=h9o9b8j3efjtPl4RJev2uEKPjr5Q2dqiqNOekEGAzcTP3g7Qg3L7sFXX
   F76ndxo6i0SbRbqyXB1Ai5jgUC1X41OxOnDE+y5/Kkxm2X8Z3uUBrc5bV
   lduB7ccF1XxsmsH1aS8U3ePon7ADIMJBRj184HSDkv/o5aO1+tIimVavS
   ywI9dUrOsDiCDSzQerJpp6Upd2xxNu5ge1zoyUkmkGhPdtP6RxlMSUyu3
   ACFpSkjsbVvyEwW4hvN5TAIZ/mqxHtxtE1nBPO077YQ2b29XcFBo/a/hY
   NvsiB7QIf+IdQ02R+xAoiQB4yUJh0t/0rXCGaLpcXp5zT30VtgxsNFhn/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="374854269"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="374854269"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:39:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="703119975"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="703119975"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 16 Nov 2022 17:39:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:39:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:39:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 17:39:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 17:39:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek/s83+jobadrlxckSBW1V4cYIpcFGfLfQkxW4xtlBmJKGVXfankNpBKpwD2ilUwq+t4qyCU0ukOJzKqYf7WrKHljbcC5g41jgxb8fr2HxShSG9VKoT6hxON2++mO0IB8AGAt1lI8ySCmx188s/5gRvLMkvLgdi+WgYxRhVAUmF7xrIhfrYgu/9OEpCnveMGvcEHZiCpG4yw+VagPW94hTTZHC6m3N5CRLVJrCIQ7HkqGg0nbn7H+IpzB7rxUPaCK2zHzBliyxLImIxqMlKoDhd87Rl7DXq51oimaVUA0sE8hdnhtAfIRehBFAxx50GiraDuckFYWLcRCuwTyHW3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdqWbu5powcW0qYGH38GzWk4lpn1oQoHmp0qKaHY3Dk=;
 b=bM+Uv1htCrkHra3ghpVAivSp8r+BWAI1L9fOBonTwKAUDxr189txF4TNnKo4saTDM2C8VEiVno0TCVwdb+qobWQm0qULEXhFY+meBKtR60Sa68tb0zM3RtKuX2bq7AX90CHwR232zxi6jZNU5A+RUa7AVbDplrWGuq6M9ObbWwzbNCtW9+fXu34bajNkJ1PsGWz4FQhIwdhb3UUt3DitPsCGoGNZN5GqSojYE2lk8aZrUcP6SWRV4g9ecy6W7piWC4omBQZpYXuu1MIjuPLeF7KrjqaQF0f8XjkMxtjG/zatpdwVBZ4RBTxFSJCV1gcCFZvkc9PyXY3JBolm96SXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA2PR11MB5081.namprd11.prod.outlook.com (2603:10b6:806:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 01:39:52 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 01:39:52 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: RE: [PATCH] srcu: Move updating of segcblist from srcu_gp_start() to
 srcu_might_be_idle()
Thread-Topic: [PATCH] srcu: Move updating of segcblist from srcu_gp_start() to
 srcu_might_be_idle()
Thread-Index: AQHY+V60i+VYukqOQkmScnUaZwJ4gq5B15IAgAB/HYA=
Date:   Thu, 17 Nov 2022 01:39:52 +0000
Message-ID: <PH0PR11MB58809BFEE53098AA617C57A6DA069@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221116015626.10872-1-kernelfans@gmail.com>
 <20221116175922.GR4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221116175922.GR4001@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA2PR11MB5081:EE_
x-ms-office365-filtering-correlation-id: da42ff0c-70f2-42fc-55c8-08dac83c9f34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUCfiznu7r7rtmm7AfGHRbcjyeHuC5VxQue1nfYP2tGvB0W29weqqIPFViQsv/S6HCvaks9FJ+OL8H4Gfb0Mu6kwg6M/SE9Bn+JfoHy7OyiTp5XIfubywWYzetnWi/dc28XgBCDmWuuEeRi3GHgxn2+EP7PztLVJU7rSJ395HkKAzxhFWca00DWVArhV58pHZNNXNVmwv8q9pwwXLxH8yi2iXwVgTXIPEDqgDW5jZgPvv+UPcRLspqb9uIgfZ23oCNDcATQd6tfrdEt8g2dq0nZB1Hc5k778uVIeUUCIIL3Ljjs1cZucFBwLdHKapkXRZwpqJvcP4zfAnvr6GinUbbgvfRfL1HObQDVX7wVL/OietkVOuwIA0TtfHuT1MqeY89B7fcYfVIyLOJtOkC5c+010ytk6TJoebMk9mXSRs/W4f3LDU0Opg2SG3UOeAzqztd88v69Mc7hp7Guq8gh6tBCEQpWbvGUxDLvLZz6nj2TqHWl61Ktf6fKAVeYocDrGeXv2Kv0c3VW1VnZjggekw2zWedjhWF3hzGii1+YtSqXlRjioRhxZdla9+P0NLMWHDdZ8aUr6lpOgxFwcgPx4P4y2Iz9GNGg5OGeu3C/1q7khFYotQHNqkletRJDNqFr8LHJwcrb0O1AxpkruV0gR2XdawqZeh8nevgNe/EI0PaSUPR93t6bmxkeo2lw+L/FSG19+Y4o97GJM9du7+QkuRMpUQNHdZLnHtYeD1wn9REC8hhTSlx/Jtk/ENaVWRrQ7Gi2LsRMIdBTFS8CBP3XQhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(478600001)(71200400001)(55016003)(41300700001)(54906003)(186003)(110136005)(7696005)(316002)(8676002)(8936002)(26005)(66476007)(66446008)(76116006)(4326008)(64756008)(9686003)(66556008)(66946007)(52536014)(5660300002)(38100700002)(33656002)(122000001)(82960400001)(38070700005)(83380400001)(6506007)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FnH5uyU8uUaJJfHHnmnkA6vgYSSKSq6Qc2r/FdOAu7jp+Q4CT9Exc51+fRNi?=
 =?us-ascii?Q?RnPUD9T9z3aOypt0ZQnVJYI030+vUsuwPYaQMeBj6NkOHgG8UGDC7jqfWiLI?=
 =?us-ascii?Q?BDpwgVc5dWy5Q2oBVa6suv1/HPcRPIybSlRagkq+YFPYUnlR2VjjOTgiln1Q?=
 =?us-ascii?Q?iVfqo8EvhGh8P25GKjhIJuJ/PyfcATe7H/6C4i/eDTcJSVT/CXGT8fM06mOz?=
 =?us-ascii?Q?zlFZR2dT1NpyYgEzXKeiRYGKBSE4NS8rOC3VpaU309HuPG5Z66bvkzfao5/8?=
 =?us-ascii?Q?uSQENn3t3CXidjjXcFKdLWGSlgqA3sbKhwDNPt1ndA5YheVAnU8L+G5jRxfd?=
 =?us-ascii?Q?NTbxqaGrsUGhD9AV0YVPSeTRxGC4NMnmNR2XKZdOXMvvpNufddQqCKElxK9A?=
 =?us-ascii?Q?p3O171zgHIHrmhG7DN1fqwSKu59No/0t0SP4VCTy9rdjif8EpjyOxB/2Nhm2?=
 =?us-ascii?Q?Kf85SfyAbxV4a9NZHLOlLQHWGdgyY+AsMIGUbvoS6az+jthlxkJNvjnLg5N2?=
 =?us-ascii?Q?lr+44W/bWWbhLEbtIKYqyJftsBiQKBwpiOvDgjofuCvk3FbMXk/KaCgP5Ysm?=
 =?us-ascii?Q?48TK3Jg/Sg9yN6WI53c0xp8EVaHn5mZkSFYy0hVAiEeWDd0zBDwxnDi5ofvh?=
 =?us-ascii?Q?2lFXf3OQVpLIuaos4sFNzfO/mjQKf7c6ZVPNVVzDXQB5DYcf3Kf7VVnAaDbZ?=
 =?us-ascii?Q?y20jBMVglg9KPjSa3a/iW0Rza/8GpQkkDRYzJJ7vbaMp2OkMrY5nXywCfhDC?=
 =?us-ascii?Q?Hu7ej+h4KSwONkHZrl8WAbaNSpKstX9CXvVjfRMC26h5JoA/s0ZGqzxaRgOY?=
 =?us-ascii?Q?+wQTLAESHebeue2yv6CAvJ6Nm+NrWKoUYzUSz1KTWT1iPj2dHRtLL6GzlZ70?=
 =?us-ascii?Q?rewxZTNmca+FsFX/XbTX8Ch2klZcTZDXWqAznrHFlNIgxwlYgmVKU+FMIjwg?=
 =?us-ascii?Q?PU1GcN5/6kHOLgE1+Z2cM8ju1NKTkz27os+7vYh+GBGBmCPPxAYbPkL5vDmK?=
 =?us-ascii?Q?v47PpalKvPJDDLk4mnxEvAOw289CsSxrRzk5GDw0aqORKUswlLx9leLdRQaR?=
 =?us-ascii?Q?nqUZTgYuC8+Ojk/b8Hrbw0LETcBYdERoxAN0jyMVPhOJlMESu/yky4qBiLOA?=
 =?us-ascii?Q?PCW2MstYIH3oDdmUcqBqaAWCWoKomW38SeFxsh+HFUHGpX1/kj0iS1hIscaM?=
 =?us-ascii?Q?3yyCilJea0dJkgNvBDlP/1dJlCESlZy1zmTv+IliiyczDX1LxmC98tDbPxwq?=
 =?us-ascii?Q?nm34jjDBQhpOpnj7NOfz9jeL3njYWidctvtc+nVI4PCSGbIch1NW1oZv/1e5?=
 =?us-ascii?Q?ejwVrhP9qRp7eTezFGMCOCHlv11jSO5zwy8pabu6g1fhDTkaqvWnCjn5NlLN?=
 =?us-ascii?Q?nLFpVQjpWt7PmSPy0J1mp4irwbl1mcxE7cF5ROKWZUitxHD36dPHRNEUuESn?=
 =?us-ascii?Q?rl3WFsJl7CR72T9pfUU8V2Risb18LopRW29CrB6JU5fSC9UNO3NSWXnt13Dt?=
 =?us-ascii?Q?oulKjuYS28VBwA3wZiAaddZt6PmbdI1sjENPzhKuFQoemKGY1DpPMABr2FHo?=
 =?us-ascii?Q?uTioh/1UzP86ZEeSJxOfTzd1DxtDimAV4BO4wxLX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da42ff0c-70f2-42fc-55c8-08dac83c9f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 01:39:52.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEwx2BbKqGn1v21D/GhPQWMjneCIOTyyF1MBSOK5aXfH4cBvPCWOm1IUIbaeSgdi9HyMzfkCp7gWQYQEs5l0XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5081
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 16, 2022 at 09:56:26AM +0800, Pingfan Liu wrote:
> The pair of segcblist operations: rcu_segcblist_advance() and
> rcu_segcblist_accelerate() in srcu_gp_start() is needless from two
> perspectives:
>=20
>   -1. As a part of the SRCU state machine, it should take care of either
> all sda or none. But here it only takes care of a single sda.
>
>I am not so sure that I agree.
>
>Taking care of all srcu_node structures' callbacks would be extremely
>expensive, with the expense increasing with the number of CPUs.  However,
>the cost of taking care of the current CPU's callbacks is quite cheap,
>at least in the case where the srcu_struct structure's ->srcu_size_state
>field is equal to SRCU_SIZE_BIG.
>
>But are you seeing performance issues with that code on real hardware
>running real workloads when the srcu_struct structure's ->srcu_size_state
>field does not equal SRCU_SIZE_BIG?  My guess is "no" given that this
>code has already paid the cost of acquiring the srcu_struct structure's
>->lock, but I figured I should ask.  The opinion of real hardware running
>real workloads beats any of our opinions, after all.  ;-)
>
>If you are seeing real slowdowns, then one option is to decrease the
>default value of big_cpu_lim from 128 to some appropriate smaller value.
>Maybe 16 or 32?
>
>Alternatively, the code in srcu_gp_start() that this patch removes might
>be executed only when ssp->srcu_size_state is equal to SRCU_SIZE_BIG.
>But this approach would likely still have performance issues due to the
>acquisition of srcu_struct structure's ->lock, right?
>
>Also, if you are seeing real slowdowns, please place that information
>in the commit log.
>
>Thoughts?

>   -2. From the viewpoint of the callback, at the entrance,
> srcu_gp_start_if_needed() has called that pair operations and attached
> it with gp_seq. At the exit, srcu_invoke_callbacks() calls that pair
> again to extract the done callbacks. So the harvesting of the callback
> is not affected by the call to that pair in srcu_gp_start().
>=20
> But because the updating of RCU_DONE_TAIL by srcu_invoke_callbacks() may
> have some delay than by srcu_gp_end()->srcu_gp_start(), the removal may
> cause srcu_might_be_idle() not to be real time.  To compensate that,
> supplement that pair just before the calling to rcu_segcblist_pend_cbs()
> in srcu_might_be_idle().
>
>I agree that srcu_might_be_idle() is not a bad place to add such a check,
>especially given that it has other reasons to acquire the srcu_data
>structure's ->lock.  Except that this misses both call_srcu() and
>synchronize_srcu_expedited(), so that if a workload invokes call_srcu()
>and/or synchronize_srcu_expedited() on a given srcu_struct structure,
>but never synchronize)srcu(), the opportunity to advance that CPU's
>callbacks at the beginning of a grace period will always be lost.
>

Maybe at least we need the following check:

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6af031200580..ce878b246d07 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1099,7 +1099,10 @@ static bool srcu_might_be_idle(struct srcu_struct *s=
sp)

        check_init_srcu_struct(ssp);
        /* If the local srcu_data structure has callbacks, not idle.  */
-       sdp =3D raw_cpu_ptr(ssp->sda);
+       if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIE=
R)
+               sdp =3D per_cpu_ptr(ssp->sda, get_boot_cpu_id());
+       else
+               sdp =3D raw_cpu_ptr(ssp->sda);
        spin_lock_irqsave_rcu_node(sdp, flags);
        if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
                spin_unlock_irqrestore_rcu_node(sdp, flags);

thoughts?

Thanx, Zqiang

>Alternatively, if we have checks in both synchronize_srcu() and
>srcu_gp_start_if_needed(), we end up duplicating the work in the case
>where synchronize_srcu() is invoked.  This is also not particularly good.
>
>Again, thoughts?
>
>							Thanx, Paul
>
> Test info:
> torture test passed using the following command against commit 094226ad94=
f4 ("Linux 6.1-rc5")
>    tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h=
 --configs 18*SRCU-P
>=20
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org
> ---
>  kernel/rcu/srcutree.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 725c82bb0a6a..36ba18967133 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -659,21 +659,10 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>   */
>  static void srcu_gp_start(struct srcu_struct *ssp)
>  {
> -	struct srcu_data *sdp;
>  	int state;
> =20
> -	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> -		sdp =3D per_cpu_ptr(ssp->sda, 0);
> -	else
> -		sdp =3D this_cpu_ptr(ssp->sda);
>  	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
>  	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
> -	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
> -	rcu_segcblist_advance(&sdp->srcu_cblist,
> -			      rcu_seq_current(&ssp->srcu_gp_seq));
> -	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> -				       rcu_seq_snap(&ssp->srcu_gp_seq));
> -	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
>  	WRITE_ONCE(ssp->srcu_gp_start, jiffies);
>  	WRITE_ONCE(ssp->srcu_n_exp_nodelay, 0);
>  	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
> @@ -1037,6 +1026,10 @@ static bool srcu_might_be_idle(struct srcu_struct =
*ssp)
>  	/* If the local srcu_data structure has callbacks, not idle.  */
>  	sdp =3D raw_cpu_ptr(ssp->sda);
>  	spin_lock_irqsave_rcu_node(sdp, flags);
> +	rcu_segcblist_advance(&sdp->srcu_cblist,
> +			      rcu_seq_current(&ssp->srcu_gp_seq));
> +	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> +				       rcu_seq_snap(&ssp->srcu_gp_seq));
>  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
>  		spin_unlock_irqrestore_rcu_node(sdp, flags);
>  		return false; /* Callbacks already present, so not idle. */
> --=20
> 2.31.1
>=20
