Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2420C433FE
	for <rcu@archiver.kernel.org>; Sun, 20 Nov 2022 05:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiKTFAu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Nov 2022 00:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTFAt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Nov 2022 00:00:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CDB75DBC
        for <rcu@vger.kernel.org>; Sat, 19 Nov 2022 21:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668920447; x=1700456447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2ZIzchiS1lUhTkr1EkpKV+P4dxtpMIio/4re665kZy0=;
  b=U7zY4tlgVDRlcMUbMEGIh/bOay4dj5UNNV7iXKhsXr/ijuWEGLutAOIt
   ECJMhz59hgVt7eQflNyW5P2RfRZNXo1IfLpGcUrz3GwHE8PTpuN8fALbA
   8rUgMeQ5hEo2n0gcHLjQO+LDSlaNt6Nnglvks0K579LX0n3ggavpudnzl
   71GEzY87fjkdE/u05gO2GCOJS3mCTtIuXu6YvxMhLgWeo0vfNn3ae8VUD
   CCJJ9MeZwUZizsX/SGwemT4P8J1C42AwG3KI9hgyFw8wyQlfw17iZ4eu9
   tbEG4S/JFL+DJTuNQvyihRasCrr2QnJ2j44kRK0OKCF0Nw98vnvZlN2M1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10536"; a="313397545"
X-IronPort-AV: E=Sophos;i="5.96,178,1665471600"; 
   d="scan'208";a="313397545"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 21:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10536"; a="673627901"
X-IronPort-AV: E=Sophos;i="5.96,178,1665471600"; 
   d="scan'208";a="673627901"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2022 21:00:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 21:00:46 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 21:00:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 19 Nov 2022 21:00:46 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 19 Nov 2022 21:00:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5yC217GbKWlKMsH66l94F/V8i7FjT34TkUjparPoo1Bf/vU4Mlu43jvPMt0DvExWdGiBzGHYmO3Bw2JSHX+SszsWC/GzjWKoU9GTSk/PcceR/Qs0MNNQ2eBJCSFDQ3QIIxRK5xsjt98el8NywS5KXlCGNEU1eUGHhTKCFtNnumLjTaGh2TSp3a9agWP1Hv3xaN/3WMf2NIz0zwizr2tfpwU8OKG6xBsbKXc2b2LGqJesOoqr5tF1EY2e8NjJxDuXV7jj9O91J+AQnmHfMkDaP7yvzUr0GThNUJ9BE9gbik10eTsVfHp9SoAYIzNALCtI69SrMtG53mojyy7iRZTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz+WgfYxJ4tjlULoHn7t10ZGz6qtqDyMrIXKE+ztU48=;
 b=RkjmiCvobF9er5IGO/lCL3MKBqHYaGbDft5WiSl//W1iFOupvxnH5Pd06kIJAudjkBQ8oxmrbNdvZDe2GZk1NXUkM70Csa+jSQOXjgIfmyGyBI/TWMRQZv8ewIWlv5WAQk23Bgppoq9QSiMR2vfnbwr0yVuTr4wlzrEZrhjO5yBhcQAr/qB3GT8O8JPvEXX7Pkjzw+WM3UxJ9Ae+eT5kwcwFmoZWYIgyyVdJGgeygFwM/yXOTwL+1MfzKdzSoLNLZu92sa3Q3E5WGgXiLwIg8IdXKC+BP5EXzcmi+MH2S8WMpoPXq+dvCN7Q4G/je+Dgptshv1cs214J0NzjJ84jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by IA1PR11MB7678.namprd11.prod.outlook.com (2603:10b6:208:3f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 20 Nov
 2022 05:00:44 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%6]) with mapi id 15.20.5834.009; Sun, 20 Nov 2022
 05:00:44 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: RE: [PATCH 1/2] srcu: Remove needless rcu_seq_done() check while
 holding read lock
Thread-Topic: [PATCH 1/2] srcu: Remove needless rcu_seq_done() check while
 holding read lock
Thread-Index: AQHY/JHd9d//U0/L4k2HFU5iBCpwNq5HO1gQ
Date:   Sun, 20 Nov 2022 05:00:43 +0000
Message-ID: <PH0PR11MB58801BEEBD2DED79AB1ADBDBDA0B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221120034014.7390-1-kernelfans@gmail.com>
 <20221120034014.7390-2-kernelfans@gmail.com>
In-Reply-To: <20221120034014.7390-2-kernelfans@gmail.com>
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
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|IA1PR11MB7678:EE_
x-ms-office365-filtering-correlation-id: 85ab9f07-dde0-4cf5-4d51-08dacab42dfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8nb+bbmsMmjzBfiQRU2Hg8S/Zfyy2QqhTNox288aZzlZYAQxNn3J50OfWKjnagOYdxvd8uvzFwdoR8ugx3cGeJTDFii9l4o1s7S1NphlyFZ7dXwBRrrVEtNsaJfI4xtRl3FkxCJ7U1Aaqo/lvRjGUa8+oTtBcu0P8Kx3GQruli7SIBcitA11AOEV6hqAwmDrdu+OdlV3P5qnfkpkTINzsN+L6xHtMwXLP5zxyAyNWPMy3rcT6jysgCPh29zbETIkf+shTCO9a1ur6F8vBdoXiDWiaYFTfNdVRqlbr/Xs8uoN4SPIN8onhXrZCkFdLLIUAUSMHVgIzqe+tgjP43nSl7tyHUhsV9kfjTm3Lf9wSdyh/kd5wYfHAJHdf/xo9tGx4KR5YVKJ2luHH45aKmmc2loLws+gb9ZabBqpZGZ+lI05MM5gQpx65DXhUIHc8ylsNbo8Fs8bJiGpAZvkjh/jF2Bs3TtmL4OT7ZxAB6wC/LJpV/IiraxR2ZtRGfs5zyErIsmDkE1KjsF9FgV+QZ+X9W8+stEL6TIzBAL6soBxcIyAiStkBBIlwLAWipW73ONLdNfUviH9H4n1YkkUN1LeVQXRJXk3TjNkSlqdV/omkaQ8ynz9tLnavV2gs0atrxMZJOHEBStORYauoxeRKj5Eq4tf07SEPxszEOR6DeMkEAvpe2k4MxVEWD5Uuc78ldXlfC+nRJNsLTAlHHAmiDZK0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(6506007)(186003)(7696005)(9686003)(26005)(110136005)(2906002)(478600001)(71200400001)(122000001)(38100700002)(38070700005)(82960400001)(86362001)(55016003)(33656002)(83380400001)(8936002)(41300700001)(76116006)(64756008)(66476007)(66556008)(66446008)(66946007)(52536014)(8676002)(5660300002)(4326008)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VwO+cSNzb4ToldoO8aPqOJhxs828T7bthHVUKcOo70He9u4PEcfRbl64IQJT?=
 =?us-ascii?Q?/UGNgM4VvAp5G9F2bsijF57t6DPHKBWfD8N08HmI0fIVauPu6WoP3o+9+y0q?=
 =?us-ascii?Q?zBECoVQYmmgn/8bhel580apm6kqeJey/fNcd2AS3mjmK4sH/FS6PfUix8o2p?=
 =?us-ascii?Q?6za5srqgCIj3AGCwfeXHXP9GTzAXVyCU4zvlkbllT5LeIu4SYeIF9hIprwrw?=
 =?us-ascii?Q?zpJJFz+DHcBQ11beVRM/31csXZcuCuh472XXuKjTm8h1NJNZgY1LcnOsaShF?=
 =?us-ascii?Q?prcu4pycqqMgtxiQT15+AUaEXGcMQdyoWyqngq7VuovZVo5lidCFB3R+Y0uY?=
 =?us-ascii?Q?ckjUWeNhU/EiVMakClBCedpAq+NvKxNWBUyymV0At7AdNTSshVzApAcJYJJH?=
 =?us-ascii?Q?0vD8NaDrtH1CRrMVcAcn+vDMoY16onzkxIsLDy2pjMgAvgJtCYMPrc1f0dh6?=
 =?us-ascii?Q?3ZAH6K20N/yQcL3PajetUZUU39pp5sQZlsGvhOYtC7zy10UMcuNC3Dj1WJSI?=
 =?us-ascii?Q?VpkYlHm4NUQSg/6MwW0d481c4mHpDC1p/blKLbhjoT+Ev04O9NyD/TVOEeLp?=
 =?us-ascii?Q?XAi6f/AyTbSZ6WDl9ADJzHHBVtd9y5vB56YcpPEz911dXX7P+01P9f2ugm4W?=
 =?us-ascii?Q?AlDHhK7HyCVIZo//LzQQaM5KBU8HldQQvROAAj1oknmS0eLPMHDB9MB+Ue06?=
 =?us-ascii?Q?L8SwJRfLF3yAK88JkTpag/3OMrXzKsScRLLgNLPGPII466tMLHQAendjfdCl?=
 =?us-ascii?Q?pccEop7MZlGPX8BeZxQuisGPV3TkGvgW51FeHAOYDO4JoY7Ju2QI3e8p89wA?=
 =?us-ascii?Q?mqq527JGmrxUxz93yaUPPOsCLD64eJRiEaZhGDjmhjV7WYGYBc5LLDDMAa1F?=
 =?us-ascii?Q?WUiobqX49tVKAKHCGYwlQ07esfrkNHCoqR/tAerbfoOxkPJvzwP4amHNVB8f?=
 =?us-ascii?Q?mnABaTx8ESbBIB6ZBNtVLESsiYPKbRd+q8CH4WG6NAeE0R27hQlpo9/qkfb6?=
 =?us-ascii?Q?k33AFNDyA1Xa3d6w708UWf2b/Acu2Lv1hOVdxQLw+qOpTmt3QsRWx6i0Yc61?=
 =?us-ascii?Q?VsPZyGDSI757RF1xTe+WuHMYhwQnyaVihmnmRFbvvrwIPTVjF/dCSJPc66ji?=
 =?us-ascii?Q?Gze24hjwMVNREi7oIifTPJjC1mEQVrY4/Ti6d/Def4t5q6iMoYkV+3/FKS2h?=
 =?us-ascii?Q?rLvbsWfn0HiTBo2dZBH78yNarFEXiVK6g8yynSwq4YPomkHOpenUSfnKjCLf?=
 =?us-ascii?Q?eptESk251TcM3xcLlkwRiQUtTXM8I+Cm0bJifei+qtYZvveDkhuM4MAqH98R?=
 =?us-ascii?Q?1Lug04SaZ4LowmGLcG3Lh0jWBsS56TFHAsGdr9UWk+461eqp6PXAIiEo9LIg?=
 =?us-ascii?Q?4xiqEjowkggTX7HxoF4qtcJrkWhitE3CK8xqMJoT+tmfanO1Du9Uigw56PNx?=
 =?us-ascii?Q?bPuh2ypppdm1FlCXIp7GX3ilB+JtrL4YA9XtvYnLp3wlYsmn+GHS6/QypUlZ?=
 =?us-ascii?Q?iAVg8bwo++PH7D01/J+IApGJnBWxqYC2xXoj8eii9v6NnWjSE7exCDAcpU+n?=
 =?us-ascii?Q?lEhkh6du38GNl81eFRS9IE2tNHZvGbw06CE8Nhmy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ab9f07-dde0-4cf5-4d51-08dacab42dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2022 05:00:44.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2NI2bk++SfXrbsIe9bqklTivnmGV4UxTpB8fKRm8+wfsh7Ns1begce6pCahMA46dnXqHap8aKuNcs6Nxbmrpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7678
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>
>As the code changes, now, srcu_gp_start_if_needed() holds the srcu read
>lock, gets the gp_seq snap and call srcu_funnel_gp_start() passing that
>snap value.
>
>As the rcu_seq_snap() promises "a full grace period has elapsed since
>the current time".  In srcu_funnel_gp_start(), the statement
>  rcu_seq_done(&ssp->srcu_gp_seq, s)
>always return false.

Hi Pingfan

Please correct me if I understand your commit message incorrectly. because =
the srcu_gp_start_if_needed() is
protected  by srcu read lock,  and the  rcu_seq_snap()  seq is a  at the en=
d of the current or next srcu grace period,=20
so as long as we are still in the srcu_gp_start_if_needed(), it also means =
that we are in SRCU critical section.
the current or next srcu grace period will not end, it also means that we c=
an not invoke rcu_seq_end() to update=20
'ssp->secu_gp_seq' , so the rcu_seq_done(&ssp->srcu_gp_seq, s) is always re=
turn false.

Thanks
Zqiang

>
>The same condition stands for srcu_funnel_exp_start(). Hence removing
>all the checks of rcu_seq_done().
>
>Test info:
>  Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --durat=
ion 10h --configs 18*SRCU-P"
>without any failure.
>
>Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..7df59fc8073e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -851,8 +851,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *s=
sp, struct srcu_node *snp
 	if (snp)
 		for (; snp !=3D NULL; snp =3D snp->srcu_parent) {
 			sgsne =3D READ_ONCE(snp->srcu_gp_seq_needed_exp);
-			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
-			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
+			if (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s))
 				return;
 			spin_lock_irqsave_rcu_node(snp, flags);
 			sgsne =3D snp->srcu_gp_seq_needed_exp;
@@ -878,6 +877,9 @@ static void srcu_funnel_exp_start(struct srcu_struct *s=
sp, struct srcu_node *snp
  *
  * Note that this function also does the work of srcu_funnel_exp_start(),
  * in some cases by directly invoking it.
+ *
+ * The srcu read lock should be hold around this function. And s is a seq =
snap
+ * after holding that lock.
  */
 static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data=
 *sdp,
 				 unsigned long s, bool do_norm)
@@ -898,8 +900,6 @@ static void srcu_funnel_gp_start(struct srcu_struct *ss=
p, struct srcu_data *sdp,
 	if (snp_leaf)
 		/* Each pass through the loop does one level of the srcu_node tree. */
 		for (snp =3D snp_leaf; snp !=3D NULL; snp =3D snp->srcu_parent) {
-			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp !=3D snp_leaf)
-				return; /* GP already done and CBs recorded. */
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq =3D snp->srcu_have_cbs[idx];
 			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
@@ -935,9 +935,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ss=
p, struct srcu_data *sdp,
 	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
=20
-	/* If grace period not already done and none in progress, start it. */
-	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
-	    rcu_seq_state(ssp->srcu_gp_seq) =3D=3D SRCU_STATE_IDLE) {
+	/* If grace period not already in progress, start it. */
+	if (rcu_seq_state(ssp->srcu_gp_seq) =3D=3D SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
=20
--=20
2.31.1

