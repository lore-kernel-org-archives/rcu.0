Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2922561DF;
	Wed,  5 Mar 2025 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204542; cv=fail; b=nUZBa6keQsiexzitIz0A24w9NIZ5kruIL1V2GH1GGPKyye5Yh2qNeLQt84zPmjo/xOm/AV7XFbpb849OXQ/T1eDz8OAlgxAiwC+jemAnorReIPOqIXwpPXj+EUj4wVjl/evn7tWvAZPXv4+hmJHp/WowCw/5Hnxxec7GeQxPPA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204542; c=relaxed/simple;
	bh=/+c+n0oRgPim5fQOan803m4gLK030LiI5jJ8cFmfGDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FPhN9D5YqiHUjtXFr+vYAq1ZQVGtEv3olqTFu5aMMoRvWSStakvjw9raD8fgk3bkzo6YYqc5ycAoMVLrn/+8ts9mROqkbRN5vWu8ES8sCWiSDQ1QFcfdm20cm1ylEUoDvsSeeSl9up24rINerCR2VrDdA+sjM4Qy+lB6r35xBt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IyMGrRGT; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IyMGrRGT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH7pe2DdzagctXOOBkNl1UXmDLlRq1Vzx7Bjy2lw10UkAZNswiqvCjIiU/6VZMISk1mN1PAk6BPkGikMzLoploK0hgYYfBVr54eoAPo87vXX/C3Ky7JeWL2sep/NnSjK3SyCovA1VsGQfGNSPuo1CEv3cvyggADaAcV5YhLmVZD7ohOTCeoWKGva8uZIeg2iok6b/yYLzsu20dU8Xufv3y5PdJEFuH43Q9pGSSaLRV1amONXikI15GH4fSNp1hyhOHS6bsqM4GQX6s7XNiyCMS2nfsPpn99xmjUQQ6dO1c0pZJQLmQUm2lrEHWVk7jVp26KQ+yLQa1D13tsGz5CRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQmR7dhUX9oOSDHHUs/ueAI+1G4kA77xNoIinrxMVDQ=;
 b=WQvh/KbaYkgMoHKyyPS+Ph3y/MYJ56SohJU4/2DD7bE3MsaOQf+93xV3aldRgB0uRHXtYLyG/9jdpiyzwB2yI2gCRdUybRGOxugWuVyz9Y9KWxqhMKNnLULJMHppXFcA/nsL36zju4SajUqjcaH3wb5afOVi+y52ANb2T60vt525EEnZd0dSgEpWVVZVTA0wTVHg2Yql8ma0vdM0YdgPFpqhNneBeWXI4k+GXA4sMxXeN9GyCZOHmb212VA2Sb56alenknGsiBh8AxBARgX74X+RwBDqch/IAGcZo8T8xHZT0ILzkhYeShb4MLBBiuuMwPepg8PoGDI2PT0qVSPK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQmR7dhUX9oOSDHHUs/ueAI+1G4kA77xNoIinrxMVDQ=;
 b=IyMGrRGTZiJ6W36BwW6VqHa9AonLW/jzaKQWGriEQu72DC4ZEs2fHgUm7pK4gzS7o3200SmKcZugvX8PfYtVhJIYYZKH01/TLrBZj8tyGgW8fD+jNUdTwWDUxTioe+Sfk+CkNZJKKOEUydMlWEtjAT9HM+7qANiGH8IzU+3zfwuGOd1HBOPjQTT3Mr+zOOMQD+7+i8HX1yYGZ5zMIuI++14QypJK9r8chSw0JLHY0TjAOAf0FFSzopc503B3v9NdLkHupHHfRn3xBo6ZlZV4LsiJjgLiZIH198VUcDFKMkad0/6UN64KeRgnXHsE/z83pSP06HunLAjsOeYUWJ1FLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 19:55:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 19:55:37 +0000
Date: Wed, 5 Mar 2025 14:55:35 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, paulmck@kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH RFC] sched: Disable DL server if sysctl_sched_rt_runtime
 is -1
Message-ID: <20250305195535.GA240409@joelnvbox>
References: <20250304200116.2210119-1-joelagnelf@nvidia.com>
 <20250304150632.3fde716c@gandalf.local.home>
 <20250304234744.GA2283516@joelnvbox>
 <Z8gZuaAavG42unZb@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8gZuaAavG42unZb@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: MN0P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0cd8fa-1c4a-4282-7cd9-08dd5c1fb2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4aT8r8Sn6QKyF+fquty+vd51xPGsGW7VlmMgy8z5XV1juLPpL9jyJHv9WGK0?=
 =?us-ascii?Q?Gjb5Rep6nN1AILd3Cbqfvdl5VcQ324yXHb3d+TtjC+8oPCx04reEUEQ57aRs?=
 =?us-ascii?Q?cgv2w0J9Xnc7hPcGVNvnb8jG+PbbU/rrxuEw1Xtg3PrFsprilXdOV3cl5aOh?=
 =?us-ascii?Q?Hr4KQNRyWPOitAVrdpn0iRgNo0lCb2rjeDA6KdzDMy+dub++Y1ekXmFyWCPo?=
 =?us-ascii?Q?WTGuRRz4xInqgCo8tDZUTFDx7KljXAGFF5QGA4lrzDAg9+NRMSthBFuDEhRP?=
 =?us-ascii?Q?ePeJb4JTlBHsramgqxeOlYe8EqjpCisw3RAusvB/pd+S9c9fbVW2mhXBicKH?=
 =?us-ascii?Q?/Ab9lSHeVGA2xXau21P1vmNekMoeVOVxnquJJy1qUmCG/HH1w6++ysAPBPvY?=
 =?us-ascii?Q?1T2YvxEG8KIirri/UVNJ51oh8I+AUhGT7OTMec0WTCwlmTaQ5EyHMua9gttD?=
 =?us-ascii?Q?Qr87LekdCDN/wrytm03hR4aSAQ9uZtymILsd5Z+ehnBh0LYhFCJDyvekRGH4?=
 =?us-ascii?Q?qgLSDk2W07Zxw0H1p0o1ioS+e09KslKv7jzR/ssW2NmLjde+JI+f6r78zVmH?=
 =?us-ascii?Q?pNt2dlGE+wEol1P8mJoycrD5z8HGlDUVjQDgYWR0NhtROgKzQ+xrrpNgZir7?=
 =?us-ascii?Q?hXGc/7MzOCY2Idcl0QtM92gFQ8kOHdydGlvI2PBwLSuYRSCcCIpnIAue/a0p?=
 =?us-ascii?Q?9akclNnEcfAwOhTxicDkYpcxteqjjW0QriTQypuK5oCHeHqJ0IT2j9SWdazo?=
 =?us-ascii?Q?dde/VP9ZOFYSOqk6G4Dzzpl1MqEh7KIYIU8c4yKNhU47xtQPl32Lxuk4N8pc?=
 =?us-ascii?Q?wpmDPYeiNo92R87NYcV8SZHPoDoYEa5bVfoJP3m094YkFDzIWYmfPJVSjKVE?=
 =?us-ascii?Q?Yxt2oinChsVCdsKp4u3ntv/6X1cjzw6CgKq8zRFhISQW6zHFE4dW9L78FBnn?=
 =?us-ascii?Q?pDN8S4VeQ7r7orHeedfCC9PeAkIsziisxxiMV/O0w5UcHk7iyKuEt42WRQfT?=
 =?us-ascii?Q?WENbkpQDHDn18PMb/hEQ6iDVuIc1k8gOgd7bG+i1lF4l05V0FNBlf95msYF+?=
 =?us-ascii?Q?nB/zSqoiWqm/fQ7XXc7zvyEXSNjCHTtt9xHO1TgSCewr3Kuc2XpNTokj9YF/?=
 =?us-ascii?Q?YuvCTtePMXFbh/UjFXYxjnYyiVytAXPvBEJxf0tie8lbyofOBZ1vBwYorB+F?=
 =?us-ascii?Q?bTUMPo2gvrjBaZKEQTyih7+Olcsdcg0Mi7+lM0rvdHoLqVJkRJkjtGxaqFtV?=
 =?us-ascii?Q?1LbxYcjJyvmpc6XQQTeoc0PAMsi/p9gK8KwQ+QXryyLsrWQym+aPOE5WEMzv?=
 =?us-ascii?Q?EPqDG41di+bxRSpChMJ5myN8BVrKiz3sT6W2fdAvrMmbNGF24il3qVmCwe/s?=
 =?us-ascii?Q?woz+wP8EXFTTO7cwd3PbNojx/diy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nKZNyqm9H0Pyp9LkpMpQ4GXWcoGjsF/wQaWx+BYsVMbgMTuoGzZ4yDGUlht1?=
 =?us-ascii?Q?C5OFp2uFCoOi+LjQ0J+ordXMgntPTPRllii7m02bKw90lOf4tkxyiW1R5BBT?=
 =?us-ascii?Q?VSjSuS5lwpQ+0aPcLn8hDUEcbwtyHJ4BvW0jSXZiutPMZUeoCQuNYAHakRfW?=
 =?us-ascii?Q?mzWUyNWhcAuJlBuQl0BPLDK9GNuM7EbmmnhaW0qdLLCtzYYHT2jpPihfas5G?=
 =?us-ascii?Q?KbC3mucbOIQg43IXDWB1jzaYO+T3DJHQqnv5OTcu2IlMGDqRPCQ1mV4L8xki?=
 =?us-ascii?Q?hbH1HBKx7AEdRu1iks4SRoEV9OSaBoRDkK19rolk8NWF+FAkuIgZ5lQTIxkX?=
 =?us-ascii?Q?xDc8oyYfw0XaW8PpLDvOCbOIkYr5Qt0eg+iq0Dwe5oPqcvX9g2s+kNsfmvlT?=
 =?us-ascii?Q?RiiXjmHmaUIRjT2Zz73NkaL3byg5eOl0O7ExZuCKw452mRckc+BirKUqo+Px?=
 =?us-ascii?Q?qPaf+AbI+K3Gk1CxMii7qRiyk8QdkUB/lMveQxJikV3pHGoDS3xNIK3C4Fkb?=
 =?us-ascii?Q?RgBEvXPXbfplvAfmEtynUzxzPLqWjKXyFzN7WRdwQPUYgzq0UpHUPJAR3B3Z?=
 =?us-ascii?Q?/5Hbsiz9jQhvk7qRkwAmV7tDNoP6Mk9Rw9NmG7k5knxu2rTeqeAOH2g/1tuc?=
 =?us-ascii?Q?6F2xM5XdCSHbvzuGC8p4Negt0Qh2c/iEwoOY/rrHXDTbj37YIuKEWcz9DJVM?=
 =?us-ascii?Q?bce7VFw05m/2/q6yuyHr8FkyRyh/XGTU1brEvUp53TNKD58t3Ade2X4ljVRJ?=
 =?us-ascii?Q?O0UgY/YXPgw+85jlAm2QPyGfdIo0l87XH/TQp9oFCWmZY42eaVtQhyK7UjTQ?=
 =?us-ascii?Q?xQt2iQ8TGcRq7bw+7jPLGVWp0W9DfTUHSjPLo4kN5nh9eHHOssBrJBlPUpIJ?=
 =?us-ascii?Q?lsGh4/QG7xoR6TmWQQazdnCh0Xjo4sFWOY/eWOvDcPCfbfU/00rxSKVfHCzQ?=
 =?us-ascii?Q?oA6JTQq+BDTYmAjJD3Z5aZ872wYpm7cqBiN6C4GQklHtTniUHjsjcMdBNNdo?=
 =?us-ascii?Q?56JWTin2734cwcTqWcSVhDGt2vCNGB0fi+AdW7XHVKDYGyU6qMmn3SfxJpbn?=
 =?us-ascii?Q?mc0VLtiP2zUFesxUb1ts6dRBTWvh0n5kRmLkmCwj7pV2jcSn7nu4TrRretWs?=
 =?us-ascii?Q?EzYDTFVDirU5BNZynbwU81wzbVtvO6PlNjBFCxE56cZdDQg4MbIVdI6mW9mZ?=
 =?us-ascii?Q?tSEJA3GRGeGCztLddarw2DA8TS/4+L6zuCKBB7UR8StmB67sjroB5Y2h0VbS?=
 =?us-ascii?Q?0AH8TPP+/6nyA9/gmAahJTR+ETXd1ORESWn8VhSoCv6eVxNIOc1r/Ha+qrJm?=
 =?us-ascii?Q?rn3pqrvkvtnZrAiIUyHCDtEzHjIsAsv8F8OCv0s4pUytYzGvGQKStZ65OoYi?=
 =?us-ascii?Q?q/IDlW73dBcf82k1T6EU/97oaKsCodU2Wc5ZDx839w5xCBNgW8qvP4HVcH18?=
 =?us-ascii?Q?k+T8PgJnG7YmaUaUjEHiCc3h8uK5ADNEJUCC/AviiW0EpsiYtLRslRx1JzIc?=
 =?us-ascii?Q?DX0GXhffp0cV2ugHh1wAZNBCXMUtgA1/tmgerdafNmj30UELT12rGN8yC9yD?=
 =?us-ascii?Q?hpsfxeqhMfQUhlivjoAizKgC4JoQ42s5PRs439Xq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0cd8fa-1c4a-4282-7cd9-08dd5c1fb2d4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:55:37.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/PRiBOCtnT7oZUpwZfYveuiksMfmGLnkzFwQIGuJqSJ838JSA2lB07D2SQbPDE6BzerMxpGj8wFDjV/CW+1Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

On Wed, Mar 05, 2025 at 09:30:33AM +0000, Juri Lelli wrote:
> Hi Joel,
> 
> On 04/03/25 18:47, Joel Fernandes wrote:
> > On Tue, Mar 04, 2025 at 03:06:32PM -0500, Steven Rostedt wrote:
> > > On Tue,  4 Mar 2025 15:01:16 -0500
> > > Joel Fernandes <joelagnelf@nvidia.com> wrote:
> > > 
> > > > Currently, RCU boost testing in rcutorture is broken because it relies on
> > > > having RT throttling disabled. This means the test will always pass (or
> > > > rarely fail). This occurs because recently, RT throttling was replaced
> > > > by DL server which boosts CFS tasks even when rcutorture tried to
> > > > disable throttling (see rcu_torture_disable_rt_throttle()).
> > > > 
> > > > Therefore this patch prevents DL server from starting when RC torture
> > > > sets the sysctl_sched_rt_runtime to -1.
> > > > 
> > > > With this patch, boosting in TREE09 fails more than 50% of boost attempts
> > > > making the test more useful.
> > > > 
> > > > Also add a check of this to task_non_contending() because otherwise it
> > > > throws a warning (in the case when DL server was already started before
> > > > rcutorture started).
> > > > 
> > > 
> > > Hmm, I wonder if dl_server caused a regression. That is, disabling rt
> > > throttling should allow RT tasks to starve anything it wants. And some RT
> > > applications rely on this.
> > > 
> > > Should this include a Fixes and Cc stable?
> > 
> > Yeah that makes sense to me, I'll include the Fixes tag in the v2.
> 
> Not entirely sure we want to link the (legacy?) sched_rt_runtime
> interface to DL server, as it has its own new interface at
> 
> /sys/kernel/debug/sched/fair_server/cpuX/*
> 
> Admittedly thought the latter is a debug interface, which is not ideal.
> 
> I was thinking we might want/need to add a kernel cmdline parameter to
> tweak DL server parameters at boot (and possibly disable it), but it is
> indeed less flexible than an interface tweakable at runtime.
> 
> If we end up using sched_rt_runtime (and _period) to tweak DL server I
> believe we should make sure changes are consistent with the debug
> interface at least.

We could also do it the following way, if RT bw is disabled, then just don't
start the server stuff from CFS. This also makes the RCU tests work and also
addresses the issue Steven raised. It does not require messing with DL server
interfaces. Thoughts?

I'll send a v2 along these lines as well as Paul is also testing and I'd
like him to apply the patch as well. But here's preview:

---8<-----------------------

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..d7ba333393f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1242,7 +1242,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		 *    against fair_server such that it can account for this time
 		 *    and possibly avoid running this period.
 		 */
-		if (dl_server_active(&rq->fair_server))
+		if (dl_server_active(&rq->fair_server) && rt_bandwidth_enabled())
 			dl_server_update(&rq->fair_server, delta_exec);
 	}
 
@@ -5957,7 +5957,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	sub_nr_running(rq, queued_delta);
 
 	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued && dl_server_active(&rq->fair_server))
 		dl_server_stop(&rq->fair_server);
 done:
 	/*
@@ -6056,7 +6056,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued && rt_bandwidth_enabled())
 		dl_server_start(&rq->fair_server);
 
 	/* At this point se is NULL and we are at root level*/
@@ -7005,9 +7005,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
-		if (!rq->nr_running)
+		if (!rq->nr_running && rt_bandwidth_enabled())
 			dl_server_update_idle_time(rq, rq->curr);
-		dl_server_start(&rq->fair_server);
+
+		if (rt_bandwidth_enabled())
+			dl_server_start(&rq->fair_server);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -7134,7 +7136,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 	sub_nr_running(rq, h_nr_queued);
 
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued && dl_server_active(&rq->fair_server))
 		dl_server_stop(&rq->fair_server);
 
 	/* balance early to pull high priority tasks */
-- 
2.43.0

