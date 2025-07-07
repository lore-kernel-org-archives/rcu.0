Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287625D917;
	Mon,  7 Jul 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898001; cv=fail; b=TVeUiam9DSDqS4xX7pLujZRg8sdG6YO/OOA8j2Og0gHf/auLYPa9OsCyGPjOVGSJqVD+x1LCagrjC7FPuqEklIbFHQ2wZbZebnmLUukHpqnYtFDvRuc9dipdb9ZCsuz3/mVER4xg6gLv8A0GogjZphCLOdW1ODstHhpfTLZt1hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898001; c=relaxed/simple;
	bh=H1zDp6AuRa7LB8wdkZypgsLIeiYM9pnCioYK2X/n/J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hCLLs8e+zBnPfTDYVtg6gSXomJ/G4E6uBpWomUa8cntD+82KNjRm1/UWMY+DbosSKcnQUakTTTTF4Yv1n3WxRPdrjN9JIy6hAcxElDaCGpHlAfES62wqAEK5D9w9OiiiqhRep81LQvaT05dcAmJpxZWq9c1ltE8+oODdEmGTX4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rC9p60wO; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rC9p60wO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM0l5MWK31VU8qHcVR23w/fBF1EGHWMD70vU/ToBZ6VhQucE2AKRkbLkQDWqyoyYsqvYbrqGpnHxxAiCNlFd5Lk9RnkEizXDvgecL32hUVQRUa7d7nOqcPB7vYzE032/eicOlSenMaPDsn1MXljZWUXWu8dp2YFxb4HKOR55qUI4uhZR5citcxDPFO6pTLLnGSYFwpX7C3TbTkE36v88KtRBvNnhtcCEDddXhnqb28TVLD5yPEIKhDR14BbeVsrS8RkKLC94hCK9y1HUu7D4NoYpDlYz5/UXPnSJGtl/KEB8ew+TIqEldpco45nMovIjq3uGj3KchiVocWjs85XG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHLw+8NMoOylZffW8/fpbamW9NlK8G2C5uN1hjWplO0=;
 b=qoGB7fNYV5SePGFasm5au1BHVeXwXgL+xKkWrQ8mxnriyCgq26YPD+eGsbZBqib4ir9wzEmqvaptdxiZaO88UkhAmR0cBt5zfoo0TE1evt6dRN6uXclHt9cy2jjV5DH5oWFLxTvinzHbSNh6AMkzlhXXX4Fl4e293gG27bLdQrm8Gyc/GZmpFaFVS3aKDv24fTrPvntLaRJmmDikgAPVtD+SPEEbGc2SndFlDISLOVkZvfO63K3fT3rShhTLyknAiF+jL+KQN2Ya4opzx0yqFJwniD4b2q4fTcg3ACo3A3uM7joHDKJdKsgjmhC2CiscgsDa8r6JHybegNSOS0lHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHLw+8NMoOylZffW8/fpbamW9NlK8G2C5uN1hjWplO0=;
 b=rC9p60wOVSE+dhCTCACgmZa60ZIrXJg1lqo4+G4BomsxqN5afhILe++YbtSDD+SA9rDKaAnJ8TH6DEE/fSdqRKrCdJhRb2twaepwdgaCSDrtJyHcMe392W4D9AHID3eyaw+cCuJVO1sX315J1poVwh5zV4tFFKQVHhdEgOgVD3LVcXmdrFzYSDJvfq7Iowu+xzAtrHhGYRNtGnFJD4jMDYZnMb3reO339itIIaLyIRRd//Q5y8Cw56+WLoM+95kuf5dcZD0n7KTlVmcsgMz1o8wrX04Z6BoK5g7ME8xTlXqehuYMSjtBYcYQD+l7gPqBn5ia7CGW3221ZkbesnASPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 14:19:54 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 14:19:54 +0000
Date: Mon, 7 Jul 2025 10:19:52 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Andrea Righi <arighi@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] smp: Document preemption and stop_machine() mutual
 exclusion
Message-ID: <20250707141952.GA3640857@joelbox2>
References: <20250705172328.4114289-1-joelagnelf@nvidia.com>
 <20250707075050.GB1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707075050.GB1613200@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MN0P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::22) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 8380d7f1-c244-4528-71d5-08ddbd6157d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XQDSHM6YEM5VB05zcgSjstf6k2hebguAfMAmQYWWkyBuXqMSb87KSi/v1ZGW?=
 =?us-ascii?Q?LUX+CAKuuGYux3mJzSy/rJETMfF3/sTQ2B44nYaARDJP4rkBTVA9StRO03GB?=
 =?us-ascii?Q?msnr5v4YnaA4Szzu3elrhPLCfw8cDro0LflQxYHtUjZfFrqShXXZ/cTv7q1o?=
 =?us-ascii?Q?P0iehqsD6QkarCuJHGrTjnQMgwZa0TGr8R00aEY5vUWZivUtz4m5unvgmXPV?=
 =?us-ascii?Q?0UcM3+570qVdVr46psDh796A7/BwePc3lCj/kpRGQNlCaTXO8bocdGvC4yFy?=
 =?us-ascii?Q?2//jlJNYMbVXdy/Y/F1d4456hTv5Ehnp6qqYpahZjdn90+3uQ++KnvAZSsyZ?=
 =?us-ascii?Q?2QHHOxIAPLOQRb6134v3adfNSX3zkMecn4Bp0ZUgXES5sImSVtwPrrdrdLP0?=
 =?us-ascii?Q?mUoNo6EHEjuZb4Fg/X+J2wZ3axnxtv6O52/CHGRtcVg8K6JVpi/SHheSGaJY?=
 =?us-ascii?Q?4KmtcFrePSEPlwX9uZpyh/R6tZrcclulzCJRLtHmCPoCgfrSe4sW7nZJpvyx?=
 =?us-ascii?Q?TedvHeqcxwBIfSoyITvbTpI/JYsnjW83xROalSUR3unPKGlhHi9TcMB8y7dx?=
 =?us-ascii?Q?WsmtRQZLrOE1Gh+OQ6+E6GwDVwuKsoqyf4K10bDjQ319UBFQQ+lhLLVgWKsC?=
 =?us-ascii?Q?ifPjIC/nGHs5Wqp436FbCgm1dah+PfaFiA2CToe3ifTzplOh2fYcvshAyIY9?=
 =?us-ascii?Q?feUVCv2kL51388GNkPWYUHZF1QcLWdE7mLXWbbG3pxbrDvOEDBnrNNiccWJC?=
 =?us-ascii?Q?EKohtJx2H5YoJJp4y0YYlwbVrYRogJPAQAe2mUN9xnrlpAVsJqpQMkXCi7HO?=
 =?us-ascii?Q?+Q4ra9BmZkI5VPJHi708cVG9JSn2OT9CT5S302CLz20/DLvc/ZkwBxqwHicp?=
 =?us-ascii?Q?a8RTZYsACpVnSyfM18I+BF4Sf1MXNjsG7wUExZRjuwQycBbl7RT2CFeuj1D3?=
 =?us-ascii?Q?Fg/hKle99E+fyZyMk3I8NN/O0kqwIgBiMDckD8E1xeLaAePDkSafKk0bKMI5?=
 =?us-ascii?Q?FpROzrTConTJOnvbqwGj3vi4PYF7l64mrfEzdyJCHZaT8Q+fuwRW2dP7spxq?=
 =?us-ascii?Q?7DGUbPz9sKhdqUAHwNoXSPTcTnezBvpnWSwgxfnT2NbGvMUtSlHliGOAFYkY?=
 =?us-ascii?Q?pIrjgRuOj4X8HQ46gNltNCrW4Pl7alzxzofdamaTBdbOFUHqUD8cqHMKe75d?=
 =?us-ascii?Q?ZvJ0dkYme+b2jjaUsWD6n72r7lBbFc8zo6vQR2A+se5J8+LnioDOu2Jolxqc?=
 =?us-ascii?Q?8B7SwxorNja2NkZMT13OcNO6httfgMdXvFIWIUzaqRK9RAjW7zHSpzMIwkzL?=
 =?us-ascii?Q?GjyjBDxz6XjRZyC6gvHOmwkFVRCT7PlAfpcwyt5CnWRrqCGHZUAJ/OK40NHP?=
 =?us-ascii?Q?tIKX0OnznGsu6LO7PWBQzEMbdH3ZuU0Cw2N6keh+3Qxqkz5UpL5kF8ExAa/6?=
 =?us-ascii?Q?ZR0bmp7BwtE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0KhxgITpy5HUAV2PRB0qS2gWD2tnfIFC1X9qj7qQj8d6ckg+0hC6kzGaxWgu?=
 =?us-ascii?Q?BJtMAOlniUpevQ9/9tmQh3XsrGegkpca7dIg58fF4f18HehtCA1rNMunKHJf?=
 =?us-ascii?Q?Nn5ISQmAljnFTr4KgcHCs39TQ4lK3OHFzkV3+77x4E+KnpuSzVp8Q2poNggs?=
 =?us-ascii?Q?//kQ7wnDDddMzmqr7PzYcX4U/qHVLwmtGpD2o6cml2Z0kXfqbpyaJ7mRJ3tP?=
 =?us-ascii?Q?rcgxRGxZhgC9nhECLqdg8sEHlarOXeZwvASRLr1E+6xo3LD9klgYyAFvnZ6H?=
 =?us-ascii?Q?kMyL5gGBKYDfpTfDPiTcii0PUqkjHH02B+mYyvh9yOD2ZQ7J7yctx2ROHjBk?=
 =?us-ascii?Q?EU6bNmZGGmEvA10anMalVucFW59qTKbHLe1ViPuY8cK4ZLl9RbTLEp3Irz0D?=
 =?us-ascii?Q?1kNva8UaZpEg8U0TnfAvF+633FAJx9yBdDOPeit1FkaLfNa0i4s91tn9QptN?=
 =?us-ascii?Q?3Lpp9e4QiFAlFgllUN0GTrdQjkZSHOBIFRHry5zGZMIdJT187Ie/c2on1ayx?=
 =?us-ascii?Q?NNq5SkMV2hdseZcH5lw0sqo9yMdBz8+NKEJIDmq5EYrXyHhptuXcP1ez+APD?=
 =?us-ascii?Q?VXY8xy9WVgwGOKdknJemxqedbxxIcFbNAa2T+oGDQZNWGAZnzlRnOohyhTQ6?=
 =?us-ascii?Q?cPtxg3aMrMb48Lm2Pxt+aZgFYnESjncoPmOpTH8Hfw7ywcmoY48ISB6CVcnh?=
 =?us-ascii?Q?B8JkIrjnKmoQdFSA1l8HINk7TthdLcCrPr3os/Mz91vtrLuUFhE9TGALzJkV?=
 =?us-ascii?Q?z8fQK7suuB79ssIRuJSnOSbJg7Dha5PlMrzEFXCA9IfAL8o7tQUJb4ydQbp7?=
 =?us-ascii?Q?DsT0SgKhUp+a0oHuQnzPOI8/qiyVqOA2ckOK5k0cYE6oGwiNtAGi4kxzuPrG?=
 =?us-ascii?Q?eKdEjAmoBbgNecoDDsRLY3H99H0+7lKaFtNjXOzDBHoG3PCUt/2F0zis0MmZ?=
 =?us-ascii?Q?ntpxdRfoTapsVg4p8Cx+U93kO4O6mOTVB9+DUaI7WTarcm/d/HqzoocR1Gzy?=
 =?us-ascii?Q?EsMJJleRYxEJ2Ny/1PU8bZhNhlVzM8kLXoHOXrNRDb7J9f/Mev6VvAUyuMEa?=
 =?us-ascii?Q?4yCC2G1fPP58/RgDZtXUgRcw4MlL340BAN/tamaTwd3lKq3BIIpwUKR1a+bq?=
 =?us-ascii?Q?2c/s25w/vQfV5ONae1kX6J/3+WFTD4G+ge+33KyrxUGUtWohoR5fl369lSHG?=
 =?us-ascii?Q?pSY0itB0PUVhnWta/WEQp4flWvPHoMst5dKtz77CwijcdpS2cgWFqEdHfqTT?=
 =?us-ascii?Q?ONR5BfUgHUPUslQVK24W4No+EpvwhkSDXdKM7CteNIUVFOWPJKMnFtp6Fw1Z?=
 =?us-ascii?Q?RpIqogtlX+bThfBwHvaq9O8xXHnRtCwpD/nzPJv+gBtGjj/RAsrRXUxXhcnd?=
 =?us-ascii?Q?XrVaLop/TE1YpZuc+hmnJLOikUvQc2TR3LOb7aywceLajdLeSskMFDA9KngV?=
 =?us-ascii?Q?2jWKIb6inEd3P2tkBewECbPmcR+d3c+CILgq4HYHwgA1Dg3Joy38dRVRyKRv?=
 =?us-ascii?Q?lQBY1S2w93BCeb5EIzypb3hN/AxmgC9iTlejRyCk5oii8npmcMNBq81LlhUG?=
 =?us-ascii?Q?dErA46X1Yfhdnzit4DcLj45h++leNOxQldIu3Wx/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8380d7f1-c244-4528-71d5-08ddbd6157d4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:19:54.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Yr4T9rnBdJ4l37PlO4G8BxEOvNctsWj1Naf/QQD7kWUhZ2YhKfaNJoVj+RZzgZK1pIVvvyWXhBgi5fNJPbTYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

On Mon, Jul 07, 2025 at 09:50:50AM +0200, Peter Zijlstra wrote:
> On Sat, Jul 05, 2025 at 01:23:27PM -0400, Joel Fernandes wrote:
> > Recently while revising RCU's cpu online checks, there was some discussion
> > around how IPIs synchronize with hotplug.
> > 
> > Add comments explaining how preemption disable creates mutual exclusion with
> > CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
> > atomically updates CPU masks and flushes IPIs with interrupts disabled, and
> > cannot proceed while any CPU (including the IPI sender) has preemption
> > disabled.
> 
> I'm very conflicted on this. While the added comments aren't wrong,
> they're not quite accurate either. Stop_machine doesn't wait for people
> to enable preemption as such.

You're right. I actually did not mean to describe how stop_machine is
supposed to work. Indeed, this "trick" for IPI sending safety is more of a
dependency on stop machine I suppose.

> Fundamentally there seems to be a misconception around what stop machine
> is and how it works, and I don't feel these comments make things better.

Sure, but again I am not intending to discuss how stop machine works in this
patch. That's more ambitious.

> Basically, stop-machine (and stop_one_cpu(), stop_two_cpus()) use the
> stopper task, a task running at the ultimate priority; if it is
> runnable, it will run.
> 
> Stop-machine simply wakes all the stopper tasks and co-ordinates them to
> literally stop the machine. All CPUs have the stopper task scheduled and
> then they go sit in a spin-loop driven state machine with IRQs disabled.

Yep.

> There really isn't anything magical about any of this.

So I modified the original patch I sent mainly removing the comments in
stop-machine code and reducing the wordiness. Hope this looks good to you now!

---8<-----------------------

From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] smp: Document preemption and stop_machine() mutual exclusion

Recently while revising RCU's cpu online checks, there was some discussion
around how IPIs synchronize with hotplug.

Add comments explaining how preemption disable creates mutual exclusion with
CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
atomically updates CPU masks and flushes IPIs with interrupts disabled, and
cannot proceed while any CPU (including the IPI sender) has preemption
disabled.

Cc: Andrea Righi <arighi@nvidia.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
I am leaving in Paul's Ack but Paul please let me know if there is a concern!

 kernel/smp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 974f3a3962e8..957959031063 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -93,6 +93,9 @@ int smpcfd_dying_cpu(unsigned int cpu)
 	 * explicitly (without waiting for the IPIs to arrive), to
 	 * ensure that the outgoing CPU doesn't go offline with work
 	 * still pending.
+	 *
+	 * This runs with interrupts disabled inside the stopper task invoked
+	 * by stop_machine(), ensuring CPU offlining and IPI flushing are atomic.
 	 */
 	__flush_smp_call_function_queue(false);
 	irq_work_run();
@@ -418,6 +421,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  */
 static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
+	/*
+	 * Preemption already disabled here so stopper cannot run on this CPU,
+	 * ensuring mutual exclusion with CPU offlining and last IPI flush.
+	 */
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
 		void *info = csd->info;
@@ -638,8 +645,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	int err;
 
 	/*
-	 * prevent preemption and reschedule on another processor,
-	 * as well as CPU removal
+	 * Prevent preemption and reschedule on another processor, as well as
+	 * CPU removal. Also preempt_disable() prevents stopper from running on
+	 * this CPU, thus providing atomicity between the cpu_online() check
+	 * and IPI sending ensuring IPI is not missed by CPU going offline.
 	 */
 	this_cpu = get_cpu();
 
-- 
2.34.1

