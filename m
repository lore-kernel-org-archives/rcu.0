Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3916FC433FE
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 09:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiK1JUX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 04:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiK1JUW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 04:20:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48625140F1
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 01:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669627221; x=1701163221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=83pK0UyidCysZjpgH6/lCnkSlE3aFDG8bxpBAunDCO4=;
  b=XamAAkX2ZmvzYzbTMmyz1nbhQWHut0/+hBJWeSrPmuPaJNKkzBOgbmPt
   Zjit7IvR00DAqCmg842C6SCZtsPov/HaF1DWj/PtPj9oKjfQS51rdwlGj
   UOMoCOR8H3707WhCcGIDBaZCK20M+IPYsAX8r4WJvUj0BOT7JSlZmsNYX
   vL7nmk9hDG+owZ3UyAjuYR0QTJXr248wPtBTELl8Kt0EPTHKwtkJr2gKS
   sqkYuitrT+gn7dfsS6dCUjvyLAX0meLZYsrgzazxt+2zvVtV9fo757IKf
   6Qh1aMbRBLUyxXf9UBuLDtWshBkL7gkQMSvrpuNTPqpPrvkOrNg6DWv5p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="341700549"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="341700549"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 01:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="711894315"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="711894315"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2022 01:20:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 01:20:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 01:20:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 01:20:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 01:20:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSdrIpTts4RDtsGyAPxKEYsEShCtKQOZjlFfNeSpWCprpgQ3+SRf7NFea12TEL5qwWy3LN9v4K1W7o3mWq3wPk3kP66eAj5EcJSZAyOX7jlFaV+UaShxt+JyeugmqwH7Q3nZ09Be+i+hptAquj2zh4of5TOUiq1ik//YSHl45qTWIws+Z2pN1dYaOT7gO3j4QcZLjJAT/oJ/UAwW4/+/z+EiDjSiEVWT+JnW41mKDWZw8/zxmhz+9qG9dH/7bh6rsZm6iy1WkmqGzEqV/t3Sq9Eeg3AE9zalajDfUJsYC8PFElZn/yqZ/VKF7/tDhPSz6jAurIVN9w4jCl79T1PA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTYpEKXiCHoZQwzRlGo9ZRzIc6S4XSr8D3OkTLGQnvI=;
 b=alJ/iAMSlwnaPiQJxUD7yU6XA088p2b8rYhfwPT30sYXMD0sAO5eMA3gb/CFyX6Rfc6pJejTbYW3vWOk0/fKJasQkg+SV3NwNQXRVYs05BEpxMETDybQAU2sQgzgJYo+dwOBV4NIXMjgiIdjnhGfWqQXyfAZJpwaJQbEsQEUz55xUVYl7iCSYfWGsiLojreOFEbd9TRPlallE24NLSoXjFQu7javgZ2UK/u4UyVlToSI1KKAYQ2Uccgx7XwOuCB78a9e/gEz8ARqRkfbPX9gjRfr1V/FeM2y57asMmBy/ic8zu0BYbbQESxXHvfDzVjBCboc+RpSWIofJA4fXxiIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 09:20:18 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%5]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 09:20:18 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: RE: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
Thread-Topic: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
Thread-Index: AQHZAwNxpZWoZYYOPkq0Qajw7AIDeq5UCziQ
Date:   Mon, 28 Nov 2022 09:20:18 +0000
Message-ID: <PH0PR11MB5880585607E73B0228D77946DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221128082816.28518-1-kernelfans@gmail.com>
 <20221128082816.28518-3-kernelfans@gmail.com>
In-Reply-To: <20221128082816.28518-3-kernelfans@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM6PR11MB4721:EE_
x-ms-office365-filtering-correlation-id: d905424a-6191-4892-44d4-08dad121c42e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTR2x8AfQmrjR8tws909TnPHsAKEiMhXr7iX2Mh5UCrhuI7MHOncNFP92CQDw5NYXb51YG7U20HM6en1xUz57LgYDSBAbpa6ZP6vgT3XGrtEARtH7Y+LqpssYlc+zovr2Q0WdyXcjft6L8M78JF3zo6vJu9ow/0nSW30sgjJoCxl3aIySn04ogXr9YjT+obIsbCrtFY5b2IEDw5dRyxVN1wGpIstaqKfc8aFcbzAkA81HAbf3fem58A7bgs1vYTXiosITDb0PsLRQkFJtWKK/RJUxKklzXhcXihhqupl2i++JptuG8SjOHaSri/fKF9nwsPvQa47blQNxHC/F2/GtVmvaj3keQIrI7xVQSlhFc0wChwwjV5/S+bFbcG8rF5P6kwCNnomuywKxpaUlZ/S3a0hUKnhk65jGH1sppu7PSC4eUORr12AW5YVSXT/srhkLx3uAjxPJhKWJ/XDKBnBqLWPHRJT/qk4EasskpvpvOyZpoX0kGmPXDg/67XtWV+92h6KSs0Moz/FILRQIW5NPq82TVysAMzw3gxpcp8i0vWppCZBWRBgoQqVYSb3S6BWEUl2966G6riIdfgh+wQbqg0Vh/Rj/1GNe60EzMP9UJoafsBZTsOnNRwBgqGGqmOaqVOqjQXkLuaNCb4SCPXYmnOtp5aIV8vwB47HiSO6s0EkzZJATmqsH0OYn4SY4wT+WG6w99xUP4fzMlCwfNMKEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(2906002)(83380400001)(6506007)(122000001)(38100700002)(7696005)(478600001)(26005)(76116006)(66556008)(41300700001)(33656002)(8676002)(66446008)(64756008)(66946007)(66476007)(71200400001)(82960400001)(9686003)(8936002)(5660300002)(186003)(4326008)(86362001)(54906003)(55016003)(110136005)(52536014)(38070700005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xKR2Fdc2RITKHYwweWWEXzySscTP+3s8Pk0uPiU0tPFpMiyfVj+1Vq3IWX1I?=
 =?us-ascii?Q?r4I4oBEmcwUv36oUlh7r9GxR8MWzcQ5GCOueJ8wfzB4PcQYiMvct4t5RPx8m?=
 =?us-ascii?Q?SOfMXOJoISuQEwn6goFRZb3CcWcqasjeQprpIDeIdDIbfPpmINiF5v0/T/St?=
 =?us-ascii?Q?6kd1A41JUj3I6xNQM0iH3RqFrvrK8zFyqOqTr24C58BTT7GuC0d94zbgb+h8?=
 =?us-ascii?Q?BYpr/lmpSVIZXjYhqU1VN5e7irpdOCvtQIHoSvRMOTfuQ6Fo23tAqJ0VxohE?=
 =?us-ascii?Q?d7SOw5kqXATaLi5J/yY7gGquVTzob6Ma5oV6Z/xyqfi7M7zoEimDN6siPwmA?=
 =?us-ascii?Q?qNHLfu7ziFY/cV4I7QolvTzC9CttYM162WOJE1ucc+6D9MV3+quG7kaEGWPS?=
 =?us-ascii?Q?/rMngWTJ52paAyUhA5CIbXP1uFHphBp1GaBzb3b6kOAvmvGFYJ6w/7LQz+Ed?=
 =?us-ascii?Q?0gDze3+vjxyHFF/4FpzvgSn3x2toPb578ObpB0o+TTtW6TUYnX6ltHBw2mgr?=
 =?us-ascii?Q?jSe4yU/PZQewUSoodVtxoMcV+xD4ADQTvL+BPq3oM8vzHHEkXJTll+0yJJTb?=
 =?us-ascii?Q?utFglbWYSs3Mfu14jyplUd5Foa3zyOwHhhYnJWRobE7VlMlVazncz7fSIcM/?=
 =?us-ascii?Q?5tYhFyJSY+gBqFOZccmJ6RrdIAVffhxwCWH8Pi19tHZS8222SLkXutAra4HX?=
 =?us-ascii?Q?5Oa89cjyqj88+7nTeoFKYRkBBorXv378RD6V0fthNqIyDOdnwMlHIiLNUUSZ?=
 =?us-ascii?Q?ImPVteKsw8sW7l2Y6G5g6soT6guHTzAwCLA4un/yUE/DGybPTn1w8B7RAWKf?=
 =?us-ascii?Q?WUndFvnQcC/GLDXHp2O2sU4YY/epz4xzN+TEnsJ4zSWZX1Cl7tbJSwHhmr6z?=
 =?us-ascii?Q?mC6SJL61YKXq0q6FjwtUAuDsuGrlhKEOuHxUnfmZzp/u1GTkqF18NA113Khi?=
 =?us-ascii?Q?1YQmWuyayBCT76HFi1N5KoRhiS/t4oKPetFrC2pGScuQ8x+KQh9/2lyMANYI?=
 =?us-ascii?Q?1gc96rv5zRmw0B8A5UT4CPPvfq8wNCVVySv+0D+WXKCSnykRLXIGYYH4YK/8?=
 =?us-ascii?Q?IUBiHknLmzbLRQpk4zHZpqabB4eHhMJC2Y7cz0ZM+uq4xoiDOfTvFrzW6Lqd?=
 =?us-ascii?Q?npT28d/cPYfhelsA9WhLUPRdKnYDvO5L/KE0oY1HP/Mhpe/ZTajjWZ6TuGF8?=
 =?us-ascii?Q?zUajdm/Z1WFUl4DMvijNxry+//qsvM8jGbZQokFTpQHO52aiBgk3Hr7gh13S?=
 =?us-ascii?Q?xDB3HRnh84GLgicbENA9xOQZU2tkKgqdTT2ZxO8MdSr18LrIii1TwKUhVkk8?=
 =?us-ascii?Q?Lb7MFsAuSGCFwKt1jbCjXkM4zft5z4NUucl+W3Ax1JYInWZUjD+dtC0/4rgM?=
 =?us-ascii?Q?jQ/INhDQNfDW1e0S3Gronb5Q5ySpEYnBZl0Tr+yyAb8e/5oCC7yFA1zcm5sR?=
 =?us-ascii?Q?xHwSQj+H+nySbTCr3w6GH20FZgqMGJ3PKqwlKcmCo94mwRz7OlxumrLDRu2k?=
 =?us-ascii?Q?6S8tbiaSXYh1EAK9PibPcPkWpS+uaJgSmeEevjsI/Ijv8MTG5fBIrKxJdz4V?=
 =?us-ascii?Q?O6FR+mVA2mUIsWywb+KeNFMxOkx+0uT6y1iaMmU5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d905424a-6191-4892-44d4-08dad121c42e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 09:20:18.1683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBndMdWv6goqwZ2QkqwIIFlIzUqy8Ql5gTm07mf3Ke8Mq/VlrNhwZQjIq7tczelU1Q3R2OvPnq5pv7GDtDYUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>Subject: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
>
>At present, the code chunk "Transition to big if needed" is out of the
>lock srcu_cb_mutex, which allows the following scene:
>
>    srcu_gp_end() on cpu1                srcu_gp_end() on cpu2
>
>    init_srcu_struct_nodes()
>    ^^  scheduled out in the middle
>                                         init_srcu_struct_nodes()
>                                         ^^ overwrite the context set up b=
y cpu1

Hi Pingfan

This scenario shouldn't happen.
The srcu_gp_end() is invoked only in process_srcu() workfn.
for the same ssp->work, workqueue can guaranteed that the=20
process_srcu() workfn is executed serially. (view __queue_work () details)


Thanks
Zqiang


>
>Squashing out the race window by putting the code chunk under the
>protection of srcu_cb_mutex.
>
>Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>Cc: "Paul E. McKenney" <paulmck@kernel.org>
>Cc: Frederic Weisbecker <frederic@kernel.org>
>Cc: Josh Triplett <josh@joshtriplett.org>
>Cc: Steven Rostedt <rostedt@goodmis.org>
>Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
>To: rcu@vger.kernel.org
>---
> kernel/rcu/srcutree.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index fe0759d89c2d..281cd69fe804 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -811,6 +811,13 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> 			spin_unlock_irqrestore_rcu_node(sdp, flags);
> 		}
>=20
>+	/* Transition to big if needed. */
>+	if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_BIG) {
>+		if (ss_state =3D=3D SRCU_SIZE_ALLOC)
>+			init_srcu_struct_nodes(ssp, GFP_KERNEL);
>+		else
>+			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
>+	}
> 	/* Callback initiation done, allow grace periods after next. */
> 	mutex_unlock(&ssp->srcu_cb_mutex);
>=20
>@@ -826,13 +833,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> 		spin_unlock_irq_rcu_node(ssp);
> 	}
>=20
>-	/* Transition to big if needed. */
>-	if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_BIG) {
>-		if (ss_state =3D=3D SRCU_SIZE_ALLOC)
>-			init_srcu_struct_nodes(ssp, GFP_KERNEL);
>-		else
>-			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
>-	}
> }
>=20
> /*
>--=20
>2.31.1
>
