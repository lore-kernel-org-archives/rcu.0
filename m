Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350DC433FE
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 08:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbiKQIJN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Nov 2022 03:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbiKQIJL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Nov 2022 03:09:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4B725DB
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 00:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668672550; x=1700208550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SsG1MWQBxNKGwZfsTHjRqyGGeGUEKBUbBWOUIkGp6gs=;
  b=KXEUUj/VRlrO6vyIl+txgzctY5bSyu/AfGA4RT2HB+tMFzNJ/j8rFutZ
   yR0fBAX5xyKLEWcKTa3qMv2rlc1Or8hGot7GczOcGo/3AA8S9iSkekPAL
   1U+sxcOJcsLeFhQ8gO4XddEOGcD3IvHtZYTUneMGtJ0Fbxr0p6DaQIdaA
   8eNvo0DiowGHLWkynLY18wm9KCri+2RGjXPIQQ+QMA/+2tnjGB/khk8iY
   O3NLKM3QI1lc6mqj1E9Ja2ZV7ppI2kYvjFXZJV5IhjjmjxXBhpN5VHz+Z
   q7J33LlAb4fTRvyariyTglxiVFwuUQROtVWYYaqpRu7Br/4Wcxgd7cPiX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313938276"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="313938276"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 00:09:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968774656"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968774656"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2022 00:09:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 00:09:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 00:09:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 00:09:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeKgIEcxCV5xAAGsaHYZ4L4ZXUiX6IfgNKvWGJ5g0YgqCcwLT8DNIocBXLx4Pcj/K9A3dxlsooFDT1l2T/h/r+bcIYM8+qN22EsCAbE/r4B8t/S8JOQqZPrB+Bg6l7RWYllA67XCuX+WWCCeqWBb1+WaFh78gyILoUP6C9KNFovwkefcLXiuujjMTFpiQd5+nWnCT/o0MWXhJ+mnYf9iBb2KdQMpSBIJGRd+IQ6QYxtWmByxUTRVG5YB0fI0djQSIp+w85Pw9TiEosC1duFJW77YhNwUfvcrIGHjWsUUIVdod/Vjej4aO0DqnhgyuKbcVUrQrIo5GoKIPbpfADFvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z917ZU/UNu1sc7qAo1WG4SsRCPeuaMVd3pbni3Xwb8A=;
 b=MfhvUh418wPJDGsAuD+zQLHcs1kc96gLBDPeQ2/oFRiFNO82eeJTA34kyyS1mtndqE37TeH5+sBLhPPtGXLqQf/PpCSLZoeXWm0JRB42uyXzN+M9AnxeoU1wUKbWTrqqBw9PbomqeXaepO1zaqhgoewCFXYeieTHqHJQhEfLjdNcj80iUPEDQwi/KIRiqLxqww966I0R27zhkMl7BzOBNFldmMsv+05dV7HXLUuNdmCY9HypboEEYysWcXwcUhl7wILnqW04KPmOWHvJ0Qf2oqSYtgb4D8mgFkZYSanCojDaU2ajaMz89AfwqhNl63QmsGgLSJduqrI5dpkxMqfuew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH0PR11MB5457.namprd11.prod.outlook.com (2603:10b6:610:d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 08:08:58 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 08:08:58 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: RE: [PATCH] srcu: Move updating of segcblist from srcu_gp_start() to
 srcu_might_be_idle()
Thread-Topic: [PATCH] srcu: Move updating of segcblist from srcu_gp_start() to
 srcu_might_be_idle()
Thread-Index: AQHY+V60i+VYukqOQkmScnUaZwJ4gq5B15IAgAB/HYCAAChmgIAARUvw
Date:   Thu, 17 Nov 2022 08:08:58 +0000
Message-ID: <PH0PR11MB58800370F7D065E78EAA1D52DA069@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221116015626.10872-1-kernelfans@gmail.com>
 <20221116175922.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58809BFEE53098AA617C57A6DA069@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y3Wxf80yJTV+a3DD@piliu.users.ipa.redhat.com>
In-Reply-To: <Y3Wxf80yJTV+a3DD@piliu.users.ipa.redhat.com>
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
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CH0PR11MB5457:EE_
x-ms-office365-filtering-correlation-id: 0f22420a-2af5-44d2-00bb-08dac872fa99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /M1bGii7wbGA7UNMNvaOu8grIjXEqjZ9/jn6QY87ytkzV5OUg3hauds5OWb3xCxG9uOTYmf6B2LFRybx+VVvR6K/H3QLyl+iRetbQp5R9g2a6cKci/X+bDpZrA1VPKNXZkOBnhQnC8bh4ONwzRBv6MOTEh6nbu00UhmgARLkxF7YbH1qIwiCBonDLjRP9LJQdUne0ucgpm570A81gv+DG73HBtruQ9c0o84rOpETmJl+b0mUJmMkIXXNC3ilctm74jRxwl85Y9I3EjspYsbB8oix9tIHPhwmstXT8yo513lAn/N6F9RlZtT+JG3KB0unIF56S5m46T3Fe9PppTRr9zQINlMIkEdQ35b5CcAsC0pW4cyP0ft0tmXnTMzYsVUUbWFIknrb13Jr8Ez1eykYHBY8Tmpiz+9gNXDnETFSSmLJsHxVeLYOhxhB+n7x3+Uka9xkqs1j0pSL/XMq2XdHnubDEUI9IBpNU/Bb6O7xCFA7Pgb4ofjjxGAXWBB407tzxXop8svpKWezktnlKVYS0cToC34Ta0SAod6MoP4d3pi8j4Ndm0jMVfYpGiT6s/uNPnONCpJ5PWY85UlFoaGkIJVlq7puvJRcnzpNz/j9ov5d6vldLRjn0hf/yheX7sgUvwxPF5q/896qqKjiuzCdcsmNNDtj5dbghSQ1pNUe/dtsh6ZHv7OpJbAwpF7T5t/GXnV3yTPKMo++OvGg9ZPAsq6M9wM2xn5r4aAi30t4f2TpcR7KZl7OWiLt0X1X3mHSqS2xJUuO3qMPySaGX4iDrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(38070700005)(38100700002)(122000001)(33656002)(478600001)(966005)(83380400001)(71200400001)(86362001)(82960400001)(6506007)(8936002)(7696005)(2906002)(4326008)(66476007)(66946007)(8676002)(64756008)(66556008)(5660300002)(76116006)(55016003)(52536014)(66446008)(186003)(9686003)(41300700001)(26005)(6916009)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kMZqYVvYu/VE3h/TYdn+bjqfAEws6PaQUDX6mrrgHaFJBVvKfoxxYtBj3vXO?=
 =?us-ascii?Q?Qhe0S2Vb8/DnEIijNPbfBCpjQoXvMqtBKx0zN3TRl4Fcm3013sPksPXoFcog?=
 =?us-ascii?Q?YLV+zTpcW1d1n9ubivM/9B98mH8yunM0Ijm86uNN8LoyjmIlDBYDAI+6gDRu?=
 =?us-ascii?Q?eEqfHHQ4+F+9lKWppZJlakHHfijnai31G5bJ+NDBC0uR7rAgCtehjM09vg0P?=
 =?us-ascii?Q?jimFkzh4kmpMQKUAuU7/qAsJKJcF3bkqOmXTTyHnTBYaBMbrkbxVUXbpzNvA?=
 =?us-ascii?Q?YwLVc1YS9k6jvqO2tJnIvUQvr6yAzyB7zUnP8UKuWBTc6wxBfJZeZgUFJhmA?=
 =?us-ascii?Q?FQH8Mi8MwZHy8kiQMfGLTz/Wi8cE4XtLQ6kMjSMPz1KXe82is5fOHWUWOcCi?=
 =?us-ascii?Q?FxWbSs/yC1ubQYyIKT2CSRHKL4kakOf9nCXMtG7CCODaUZ5flGwdyNNKlEqW?=
 =?us-ascii?Q?owMdbdbAqTN1DKCU1Tw/bk82cgZv61lmTLkfq9R5UUKQIzi/rp5nktVQYzdL?=
 =?us-ascii?Q?byBncNDqqOsBDy4AppI7VbLzqvzSUuVyAcIdpJV08mNWlNhJW/qOuGGaTOZs?=
 =?us-ascii?Q?JulWN8PVUGeDE+A7VOtGiUZ03SuCZHekqtY8dYn3jLfUECaeWTFrdXqHBDEj?=
 =?us-ascii?Q?g6Pg91Y9zQR2HYAsrhE7j8XAPLOFyeQB5SsAdpDmtiwaLqQ9hJCXxOWXB5LG?=
 =?us-ascii?Q?A1+m9WOe0AywU1nuPvyJoz7hEC0/oYctz2bt3HYCtnAG9O24HXo7zBmYboON?=
 =?us-ascii?Q?QsfsicUWnspXNWBvFFfHnlGmQv++/ufBc98YQBQx4flW7Jy7dU21wuUOS03w?=
 =?us-ascii?Q?mnQm511Vh1qkyccfu0WfOBfH10pRp12vPPgoT7b2MMcQKWbRfcDPiwiKBgHn?=
 =?us-ascii?Q?Z3OQTuA3Etv2pPjMu+Gr6v/dcGW6zirImn7CyWSri8Z1Y5oY15zo9aHYXNTN?=
 =?us-ascii?Q?gkxLtYdHHbTDnj2QWTHbcWxAQ0bRVCc2JFb9urkjNz4MpEnx2mdQXNqiiTCu?=
 =?us-ascii?Q?xhEvf0te8J0FUdygFZtAHh1zWMD7cBmys1FxngggdDhGIHq0LRIYJyQzfedv?=
 =?us-ascii?Q?xq2kF7Yf5j6LGwh7wQNvrBs/6Dt6hlvsRlNSnQaD2Yl79jLySTGZ/phoLZNb?=
 =?us-ascii?Q?eOw5fKZu5bq/dLNr2eVDQOBuHoHU4PFjwP7ad3whoKcsHXMrEMInv3HlaVL/?=
 =?us-ascii?Q?9ENNL29Bg9m2bFemwgcDFkeRvx3r/T6sGP/nh7g1gHrynEaBdnD/OAXCXo76?=
 =?us-ascii?Q?vihrudrq1WA9yxGcro4zBFetmydaNxV3+ZC+xzXwCus7JQcQooa8D/1RW/9Z?=
 =?us-ascii?Q?OaIgRtKUj0kiAlVA7mB7CdeBfpuUfn4cwJnKZ22SEFL7Jq3a9p+ngv0mTkvc?=
 =?us-ascii?Q?WRCVtqMVDg/1a2nyW+X9dd8p7XRsLsCVsrqH9cxZWZCJh6Oo5bXId8YBVapW?=
 =?us-ascii?Q?gOL9wIaqdjnE4jufp9KYTOwJso6GTjYXVSw4Gy2F2z4t5LSfP5PbnaJmyJYJ?=
 =?us-ascii?Q?5pKTmNTLnLp6exqnCajgI2+6/gGXWKGelp0OKV7KAdVCxDt7I+WW/mj3uqL4?=
 =?us-ascii?Q?1TqbdLCxwyQfFpnd05NEAvlRbQLMOA+SJZ0kIl6V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f22420a-2af5-44d2-00bb-08dac872fa99
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 08:08:58.2348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9fH3pD2wXDeHijvY2smLego/8mskWybnv7pJSg7kAH2GcEDbzeQxHxz1L/dXbT1gR7djHBxh2o48Pj2Rtbamg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5457
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 17, 2022 at 01:39:52AM +0000, Zhang, Qiang1 wrote:
> On Wed, Nov 16, 2022 at 09:56:26AM +0800, Pingfan Liu wrote:
> > The pair of segcblist operations: rcu_segcblist_advance() and
> > rcu_segcblist_accelerate() in srcu_gp_start() is needless from two
> > perspectives:
> >=20
> >   -1. As a part of the SRCU state machine, it should take care of eithe=
r
> > all sda or none. But here it only takes care of a single sda.
> >
> >I am not so sure that I agree.
> >
> >Taking care of all srcu_node structures' callbacks would be extremely
> >expensive, with the expense increasing with the number of CPUs.  However=
,
> >the cost of taking care of the current CPU's callbacks is quite cheap,
> >at least in the case where the srcu_struct structure's ->srcu_size_state
> >field is equal to SRCU_SIZE_BIG.
> >
> >But are you seeing performance issues with that code on real hardware
> >running real workloads when the srcu_struct structure's ->srcu_size_stat=
e
> >field does not equal SRCU_SIZE_BIG?  My guess is "no" given that this
> >code has already paid the cost of acquiring the srcu_struct structure's
> >->lock, but I figured I should ask.  The opinion of real hardware runnin=
g
> >real workloads beats any of our opinions, after all.  ;-)
> >
> >If you are seeing real slowdowns, then one option is to decrease the
> >default value of big_cpu_lim from 128 to some appropriate smaller value.
> >Maybe 16 or 32?
> >
> >Alternatively, the code in srcu_gp_start() that this patch removes might
> >be executed only when ssp->srcu_size_state is equal to SRCU_SIZE_BIG.
> >But this approach would likely still have performance issues due to the
> >acquisition of srcu_struct structure's ->lock, right?
> >
> >Also, if you are seeing real slowdowns, please place that information
> >in the commit log.
> >
> >Thoughts?
>=20
> >   -2. From the viewpoint of the callback, at the entrance,
> > srcu_gp_start_if_needed() has called that pair operations and attached
> > it with gp_seq. At the exit, srcu_invoke_callbacks() calls that pair
> > again to extract the done callbacks. So the harvesting of the callback
> > is not affected by the call to that pair in srcu_gp_start().
> >=20
> > But because the updating of RCU_DONE_TAIL by srcu_invoke_callbacks() ma=
y
> > have some delay than by srcu_gp_end()->srcu_gp_start(), the removal may
> > cause srcu_might_be_idle() not to be real time.  To compensate that,
> > supplement that pair just before the calling to rcu_segcblist_pend_cbs(=
)
> > in srcu_might_be_idle().
> >
> >I agree that srcu_might_be_idle() is not a bad place to add such a check=
,
> >especially given that it has other reasons to acquire the srcu_data
> >structure's ->lock.  Except that this misses both call_srcu() and
> >synchronize_srcu_expedited(), so that if a workload invokes call_srcu()
> >and/or synchronize_srcu_expedited() on a given srcu_struct structure,
> >but never synchronize)srcu(), the opportunity to advance that CPU's
> >callbacks at the beginning of a grace period will always be lost.
> >
>=20
> Maybe at least we need the following check:
>=20
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 6af031200580..ce878b246d07 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1099,7 +1099,10 @@ static bool srcu_might_be_idle(struct srcu_struct =
*ssp)
>=20
>         check_init_srcu_struct(ssp);
>         /* If the local srcu_data structure has callbacks, not idle.  */
> -       sdp =3D raw_cpu_ptr(ssp->sda);
> +       if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARR=
IER)
> +               sdp =3D per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> +       else
> +               sdp =3D raw_cpu_ptr(ssp->sda);
>
>Consider that srcu_might_be_idle() renders a rough estimation, this is
>not necessary but better to have.
>
>Also could you pack this pattern in a inline function if my patch is
>accepted [1]?
>

Hi, Pingfan

patch already exists
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commi=
t/?h=3Ddev&id=3D1d0f495f69001f0f121aa1f60f114a94b1c052ad

Thanks
Zqiang

>Thanks,
>
>	Pingfan
>
>[1]: https://lore.kernel.org/rcu/20221114175640.GA410504@paulmck-ThinkPad-=
P17-Gen-1/T/#m6534975507c2abca497a94d81c7abbfea1d0978d

>         spin_lock_irqsave_rcu_node(sdp, flags);
>         if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
>                 spin_unlock_irqrestore_rcu_node(sdp, flags);
>=20
> thoughts?
>=20
> Thanx, Zqiang
>=20
> >Alternatively, if we have checks in both synchronize_srcu() and
> >srcu_gp_start_if_needed(), we end up duplicating the work in the case
> >where synchronize_srcu() is invoked.  This is also not particularly good=
.
> >
> >Again, thoughts?
> >
> >							Thanx, Paul
> >
> > Test info:
> > torture test passed using the following command against commit 094226ad=
94f4 ("Linux 6.1-rc5")
> >    tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1=
0h --configs 18*SRCU-P
> >=20
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/rcu/srcutree.c | 15 ++++-----------
> >  1 file changed, 4 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 725c82bb0a6a..36ba18967133 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -659,21 +659,10 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> >   */
> >  static void srcu_gp_start(struct srcu_struct *ssp)
> >  {
> > -	struct srcu_data *sdp;
> >  	int state;
> > =20
> > -	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> > -		sdp =3D per_cpu_ptr(ssp->sda, 0);
> > -	else
> > -		sdp =3D this_cpu_ptr(ssp->sda);
> >  	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
> >  	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed))=
;
> > -	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
> > -	rcu_segcblist_advance(&sdp->srcu_cblist,
> > -			      rcu_seq_current(&ssp->srcu_gp_seq));
> > -	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > -				       rcu_seq_snap(&ssp->srcu_gp_seq));
> > -	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
> >  	WRITE_ONCE(ssp->srcu_gp_start, jiffies);
> >  	WRITE_ONCE(ssp->srcu_n_exp_nodelay, 0);
> >  	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. =
*/
> > @@ -1037,6 +1026,10 @@ static bool srcu_might_be_idle(struct srcu_struc=
t *ssp)
> >  	/* If the local srcu_data structure has callbacks, not idle.  */
> >  	sdp =3D raw_cpu_ptr(ssp->sda);
> >  	spin_lock_irqsave_rcu_node(sdp, flags);
> > +	rcu_segcblist_advance(&sdp->srcu_cblist,
> > +			      rcu_seq_current(&ssp->srcu_gp_seq));
> > +	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > +				       rcu_seq_snap(&ssp->srcu_gp_seq));
> >  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> >  		spin_unlock_irqrestore_rcu_node(sdp, flags);
> >  		return false; /* Callbacks already present, so not idle. */
> > --=20
> > 2.31.1
> >=20
