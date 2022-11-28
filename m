Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AC1C4332F
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 08:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiK1Ikq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiK1Iko (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 03:40:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E134217AB9
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 00:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669624838; x=1701160838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Fgg8go1JKscHG/9WGFjET7fN2GG50QoVkx1gDx4N98=;
  b=foU4/eIxK5k9SwfUeJ4h9lzoOlwzIGP9LX1HEgn9wvvUQjidYUTov6hh
   6W+kfSpQ60s8MlxNpOea3iGfYOWiBfGnDIHtZqj1+xTj0UY8mwAq+qNSn
   S2umy207L/pqHzwgs9TqAv6bZ/YzlZ9oQquLNtz84Ll/sYpawEWkIGEhv
   K7XfFfCpseRztJsvE+FuLVQ0wNbJNsoisBQQ8JvnDgJpBg3cUN1S5PmG0
   E6s7ys95xWP/OPOxsC2sJLpYWNYxp7Iqm8P+TY6AdTmJEY7Zx5BK6wNEz
   5TYvHaUpbqM4QctYf1v+mWmt3LYlB27luNj5JrmWZxSA/CGih4buUaSSJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="312414605"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="312414605"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 00:40:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="643310673"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="643310673"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 00:40:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 00:40:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 00:40:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 00:40:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyHRY/JrkJzPz+udxtlLK1vRGlNqQs9M6FLVQLiFCoHsTB0CbEYn0s/zEz04Bw9WIUmNEEaeQXIqmU+ktWlX5/ySQ4rKFPHcqN/28Gj9Yd23rzfty7d66keceXNT70ay7b1N//QnmXKUabNBeSM4nSTbzfQQ88eKApOd6y8JAWxIH38Rg2fwXYVjdzjhkoMAwsFrspsci3vC/bm0V6n1AcfUwTvPPtvSr2z+9Ab/nJ8Yq1Is+q7V8sGDVIfvVWGEPfgGAIzVaF02iyY/0Z/CzlXp7aYMa1HfFhfC7DX2vjWybPOFdkJyKBXR23wst+7F+WV8G4BcGAa4Ow3xE/MqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx5bA10tsePJEHROd0rxSNnz4w446cZQvMgytkesu2s=;
 b=GJBoKdPjQ5VYCu1bdEtJMr9ryTLTwI28d3vuUmjfBTYjdG+KelFFYqVHWxv7A/TOcabuwNl8TwkJXqZewBBetrZkkzkyfGJkf35gZ8Bl3imGLMYh2YLGnPSFIbc1SPYrsS9EyvlpoVTE/5i7XSlTpN0hgbasc7a+IUeNMQns2fbR4wyjSddQnDNO4cplXQfe4GDFcb50GKvWt3YySm4e18NCxNlr7tLvC8HlOFO8TPH3ppLRGw5zQc1asUVvM0NZrLSLcqYp9N1Gl+6SWIkTPZsnH0NuNH3K+jlYE1wreccV325EVlq5hxsJm4UPU743Aq/dlX5L5HYMsC0ZJkRGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 08:40:23 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%5]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 08:40:22 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: RE: [PATCH 1/3] srcu: Eliminate the requirement of
 SRCU_SIZE_WAIT_CALL
Thread-Topic: [PATCH 1/3] srcu: Eliminate the requirement of
 SRCU_SIZE_WAIT_CALL
Thread-Index: AQHZAwNyWF39f9EJPk+b7DTfHrJiQK5UA1wg
Date:   Mon, 28 Nov 2022 08:40:22 +0000
Message-ID: <PH0PR11MB5880CEEA5D2CD0F7AF21E954DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221128082816.28518-1-kernelfans@gmail.com>
 <20221128082816.28518-2-kernelfans@gmail.com>
In-Reply-To: <20221128082816.28518-2-kernelfans@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CY8PR11MB6915:EE_
x-ms-office365-filtering-correlation-id: 1ae9898b-8491-4796-47d9-08dad11c307b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHvHY5165SDHuGNzlr59lPT40GUmuJWodi5Cy3Vlhhy9pkHGomIkAhMumfRE+ucmyBUoskvjb46goAfLoD5BbnH3WfPvqtvqQ36FEgRzbaw1Q/MYapvf9VjMHFYzoSGbBTUQsJKO8IF+lCDiebHU6ifO66gnZ2cWga6CT0YUtutBNt/F6oJLv1is3I7a6fvgjjlEnOIzIgExETnGmeveMFbh5RVQkAjO2SOVtIvcJVw87Xrwg0htaYa6IS12nNPoKmzJfAGZ2Cm3iJM55KYn321w9oQlZKlE1HJUU5/lEKw8K5qa9qhPuKLFCQFgmBbdi90VI2cpHWlFxWMPciCp2srTq51rILdHBqSdaHf1gzXnFBzUrVGPycK+Aul4tGtigZ6nftOdXM8gNe62/akjuBEgaSwk06mO+xwfz0hpUI5TgVDp0DJSC3d5hwCrOLS9vdywaAohOwuDdLqnRC4D7l6y6ROzaHZjs83HMkeiCbraPPGk7mZGzV4Q8fLYUrYXtcAHhwrHuMznw258UXOh1kRjWLObjbipf0ngNbvxTTaASz3Aui4QV54IeFn6/hwtC7375bj27SSOpBZKbbXix3yQB9MKpAJ0B9EMLYNsVs/9YTNS79ix90kcSjd8+vLujpZRLcxkxVvwqoWfl1EnB+MzUts7bJGyYLjdgJR1lr9yRd/mTueMzy7lbCvmfOEkaPcKY03JP4qKqe/lomXWzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(5660300002)(33656002)(55016003)(54906003)(8936002)(110136005)(316002)(26005)(9686003)(52536014)(41300700001)(186003)(76116006)(66946007)(66556008)(64756008)(8676002)(66476007)(66446008)(4326008)(122000001)(38070700005)(38100700002)(2906002)(82960400001)(86362001)(83380400001)(7696005)(478600001)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MqlxrlRVbi2wA3tr/KBc9GL6rdqGYjTVC8DZA8jx2fU7RemIx8kN7AnwHwHv?=
 =?us-ascii?Q?uTbBOQmwFehEzdzyTxEphreL6PEPGETiSF+c6MSmxy0yRA5aES4n3c4fBOyO?=
 =?us-ascii?Q?Vr27zMAs9c8yZkDfn/7Pdr+zBh+vwswqIxZuFsjD5Qw0Rm/xCBRheurGJJDb?=
 =?us-ascii?Q?l9Jzc6yANfH9MUoCjxQnT5v7LoqvrDT5n3iLAPbEPNyoAhjL5IaqJZTaUW6/?=
 =?us-ascii?Q?20FMlDHK9iisMArTkF3MUAQnc8y1Z09VjYi1+3pKw6HXt7Hxw/tBrN358BuR?=
 =?us-ascii?Q?lUZwpDkP7dmE6EI03xH5CI+wMXjS+RkfV0hY7KO07AJLr4cL5e37b4qKKCzv?=
 =?us-ascii?Q?xOr9Fq9K/3tFh7gKMGElxU5+dANwGPauiWb4vOnYZR3r6/UwlI+BjAU0popP?=
 =?us-ascii?Q?NcPPLe5ROKDCGZe4AevTdNtDg0PpaxD/P/TIf5nIeGC185hRoo7ClrVPItYU?=
 =?us-ascii?Q?rbI4/LDC+cvKH1JyXB/CWVdM8aG5R16CMN1ZBZiyV5eW4vzcaU4dOdC3YD0B?=
 =?us-ascii?Q?Nh5ZG7p8cQcmHrdHjtuIJUACFKIqQVjeQ448z/WZCSET9C6qkeuTs2sve7M3?=
 =?us-ascii?Q?yewKOQDunxKyNhHBPJuQZ3yRWtAQPKWcL9b8lnyqMkZIRb6muJGO74XYLglG?=
 =?us-ascii?Q?naaAyKMjAfeDmPulZ97F2DxuCbx6E7bTG3uUbj6BfONcSsYmLo3IJzr7v1/+?=
 =?us-ascii?Q?yVfeqY48K8m03EOAgJJbB9pGhi5DB9saQdFM0SHkrHzWlEZ9J6+9nGajBHal?=
 =?us-ascii?Q?znr6b4opK/nc4EUJUCCufitqM1TvBxThmm5auZmS5Fdp0YljtmPnBS4woLCc?=
 =?us-ascii?Q?hfczbsJ3WCP1FSwT9XLjwaP1wmbwgLvUTrGuPWYVF7G1KTq4gm76K7eWEQiG?=
 =?us-ascii?Q?yXeGciUt9nnYRsVOoeQNuWbftYeFUFZDI2VIWdMTxKgvb218p4/ojL7Rw7dT?=
 =?us-ascii?Q?rV18ZCz4SwYR3d+A+Pfq7DWD92XN/xGyFpwb/9gCLikSiWQLghonhLMSxOyK?=
 =?us-ascii?Q?pK6nWpyoG9XU/Xpfpxls0ZRQdGgBMY8m9zpX6sa40opptAgdLiiGrj3aSB64?=
 =?us-ascii?Q?B4RWMgOVIFHfgS57fw/wPhfnfteLTBEuBtwNe3VeQmEJRwdCESSHsgd1g/mN?=
 =?us-ascii?Q?vEeRQKlzh9EF9V8H7hldJmm4VC5uFlg1LGJ7om2n8g1rRPqXLGXlkMEgnR61?=
 =?us-ascii?Q?t01k3fJ9VzEVuhfPT2l9BO1HFwrckKX4sYsYGjS3RPyXs1NWlPaJ9k/dTM8+?=
 =?us-ascii?Q?gObtI7Tfr6uzzTPfXzzIILmW9QvYLafd/NrcMyvWApqhvLkcYyqF163jImQF?=
 =?us-ascii?Q?ddBC8NyeMDRlwoVZ9HIiWxIKS4elFkpH75/IyG4869tdT387f3BdCugj91xE?=
 =?us-ascii?Q?t/U75vAHXMMz4kZEL/nNi3ehpeGrUwU0k5rg6F+vsogHkcpWiAtXn2cd8cQw?=
 =?us-ascii?Q?c2y2649X2MT8ztw7MPbjcUXq2ek73aCW2rxO6mOcDN9fD74Uvxbcj28JtTRn?=
 =?us-ascii?Q?ermkfXAX7j4IOUsRqltwm0kS6G4Qu/Q1A1lUFbkdds4hy+OXTQKbPPYY5sXw?=
 =?us-ascii?Q?bNNoDdCRgHFuEYPw+4JmmkXd2upxLUMYNiY5Y1nt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae9898b-8491-4796-47d9-08dad11c307b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 08:40:22.8865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIcxZ8Vw0ZcqXqNr8iwLpzRpPGsDV+HK5GaZ1N52ugfMuHLl6ljg1K9B0mJjj2DsHL32Z4fe9h9bkdg4gqTACg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>The state SRCU_SIZE_WAIT_CALL is only used in srcu_gp_start_if_needed().
>And it is not needed. Because counter_wrap_check has guarantee that both
>srcu_gp_seq_needed and srcu_gp_seq_needed_exp are not far behind
>srcu_gp_seq and no false alarm will be raised by the statement in
>srcu_gp_start_if_needed()
>
>  ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)
>
>As a result, once if SRCU_SIZE_WAIT_BARRIER is seen, the tree snp can be
>used immediately, not need to wait for another srcu_gp_end() to update
>the srcu_gp_seq_needed and srcu_gp_seq_needed_exp to avoid false alarm.
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
> kernel/rcu/srcutree.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index 1c304fec89c0..fe0759d89c2d 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -1092,7 +1092,7 @@ static unsigned long srcu_gp_start_if_needed(struct =
srcu_struct *ssp,
> 	check_init_srcu_struct(ssp);
> 	idx =3D srcu_read_lock(ssp);
> 	ss_state =3D smp_load_acquire(&ssp->srcu_size_state);
>-	if (ss_state < SRCU_SIZE_WAIT_CALL)
>+	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
> 		sdp =3D per_cpu_ptr(ssp->sda, 0);

Hi Pingfan

should it be used get_boot_cpu_id() ?

Thanks
Zqiang

> 	else
> 		sdp =3D raw_cpu_ptr(ssp->sda);
>--=20
>2.31.1
>
