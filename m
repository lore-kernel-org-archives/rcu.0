Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92D3911A8;
	Tue, 16 Jun 2026 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648807; cv=fail; b=EIqIN7Tr6AdiEyzvLtpDPQURLWCImhdLBKPmaYUvrKpDCjgd34oDq8nVJSv7dHSdIPGyJVS5X08KMMOQv6/YXh6C90mF04mFKVVkF7JYzUQwkGqXoe8l1OjTsUE65QtX89x6gftIHnIr8xGigFE9M/8v8fQ0jcSFWerVQP/FJ7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648807; c=relaxed/simple;
	bh=6/YWWMDLKs9DnEFldbk23nR8KqyhTnP/2Ef3cbAaRIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Va/VoSozDIOd+VvX1oo3ilDJXRqmu6ZjNmyCEPrYJZVOYBnpi8jmoCmlOX4YUuJjegW+A1z9g1XPRLYLRyg4VNkffQY/TvhYgXuADOfAgVusZskSbjWVQPu/9zLwniURPiiI1TQCybmSvw8WM/eilL5HJXlPEcXZWVQzrRV6pHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D1ye+aeG; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D1ye+aeG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z45MDpEy7GpYTr9YMVtW4M3UIDxPOG/K/44Xxmr7qbd37O5uA7aIMUFAg0OTfqA6OEX2dapSEZBVNBmCDgUQkde5Rm2eLWZ2IAvnA1wMlRRDy6mpXFQRiE1mM6+VnJnsfG4h0VOVfV96JFhSGsKe4KE0+iwxC6zvqcEQmeEJyWC4Tz/ikCCAaera7Skuuui73Za57I73/GskELACg1Z7/QGAQjKVXx8Fv4K9Ix5nW0rDQejn82YI6fwFmsWsuF1ebjSOnGOe285ELk65K8SCxcDleMiCW0wh1akiG4HUl6g7cpcoMagFdr0jpKx+OIve4i6VtXvHCpS7InT3hBkvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfSdkXRFp8fyGyAGQv4PDPhSyJSJOtnhSFK5XvTSVfE=;
 b=P6cJLARR5gd7E/PfjJbql8p8e8Jgm0qiy2+8P/eCC6XYNUvEzLhmxLxeldqfL2ofc9y5IWG2qg5EziOcItPSGGteUZtKEEcmSbqdFCtD2UHUergDA8eI8TiMfdz582pVDaPkdC4nIg/4lDK7PvXy28gk8hnUcxEvxZcldozbfC34Mat+toAePWNdYAtJ/Mg9Xcr3HvkWAzo0zLBP8dEX5qsTI27r3GJlE61NTBHfxQpy+MjV1RsyurLio2qh2JJmHIq853gKbtXOuBHpJRCxSHaVdWcOpRf49k4X8FYZ2SJtLL7yb/7unhdoc3WTnzm8qX2goM3dwfMT45A8/Q3Mwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfSdkXRFp8fyGyAGQv4PDPhSyJSJOtnhSFK5XvTSVfE=;
 b=D1ye+aeGKtcMDaY38iNpOLZedSFbXoHaA0SU7sJ+2sxn3JgWvZrd2/Ut3MSgWxhmJDoGxZlCymUOvUWqlIciksZ7fqievGgtcdXTc6xGMElDAN4+TCHRw1LHHn+FxV8YauHjGcyj3UrqVvOHCn6b+mJoo88Uaf9vPNCY4TRVbJ43lsYfEQ9EewREGeDXn440GucF7xGTz1w4fvQU3zad6WnGBWaNP3Ma2iq9uTo+ONSavMDL8ySTz2D40BN7BFWZVgBVe+RSo5+RW4t6Ncat0bsLZGKdo0eOH+A7Y21zLA0hTJkGclN4k8YL3xVxckzWLyQcNqUUp/mSjnB89CBW+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 22:26:31 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 22:26:30 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: [PATCH RFC v1 4/5] rcutorture: tighten boost-WARN to exclude any implicit-reader context
Date: Tue, 16 Jun 2026 18:26:21 -0400
Message-Id: <20260616222622.2981876-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616222622.2981876-1-joelagnelf@nvidia.com>
References: <20260616222622.2981876-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:208:2be::31) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 93117032-5a60-4877-e330-08decbf6504e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rUucfaXPxkZwJwx80oo8gZvIQhBTn1U6Q/emtnFIg1IlGSJxewz6gGvltUbJDNL87DLs6Jn//LbTmZfvBRBUIUPbz2joTubqyOa68HoM7Up7NuBIh6PGmXQ2MVAYInTxgMOOV9brOpOCSxZclRzOYIr5nwwBOv14+iTxCFk8iq2q1sYHAFPE0I3z8vTXMLw5y/JZDNkZhJQ399aWqxmm01nrmoLKcY8grHt8Ar+B1x7Es4bG/tSX+WK7usjKv/Gu50Xfa29YS4oGUFACrsapuXGFHIJBPTcEg5cwRdYeFyqH2eoxHxB3CFGR6Ktxxnc4p4fN/aP+ZWsC6Z8AFpyhiXqgF/BTp+XA2QErryMtFVTM4KiDnokJyEXge5u31QliVEHId4+vjybpQC7gjyoNINmrfAXi4FVCTYUYGOl8azTN2MR9ymMK8t5xpkP9xgcociAOZjuUcqKAJDN9/flfwqBXf16G+x8xY5zQ45aaTaIOzhVqMzUqV2b/pg4BS1EJoR4I0/Wmz74mIXwtVrnYiCsgHb3JEF2d2tSPGVCPrbSI6MHdeddUZ7VoaAWZD1AxNF8yMpAb0iaD6yaTThBTGadRkmHsRdQqR8vBr+RSmkZRB3WVxgB49hbIjzAnCPr1PZ2v7cy2QaK2D21qKd68KaOnA4G77dPB2b3/zXTrRLeKQebV3jEbw05kXzwtZjMj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWt3clRGVDhUeUlEUVIzK29Qby9abkc2NncxQ01nSVdZNjZpdHJKczgvSlFs?=
 =?utf-8?B?SW1tcDVaSnNaOTJCL1FNOUp3N3R0Q3laNjFYdERWK0tBaWwyeDRpcFJIMGp4?=
 =?utf-8?B?b05mYWpOWWwxbU50eXRod2ZWZCtBcVVnSUFBL0tIM1hhRUVXTTF2Tit3QUUx?=
 =?utf-8?B?NFUyNjB4c1dhV3B1dGtzamFZTlFET1RSb2lHWDNRZEVtL2E5ZVE0bFQzWGo5?=
 =?utf-8?B?YkpFVEhCSnBUTnliVmZQMzl4V0N1dnFZKzF5OFBRbkFINE56Nm5iRGZpMnVK?=
 =?utf-8?B?djdKd3ZpOVFBS2lQYlJJNEVBSHJhQWhvU2FsbkZHdnMwcjZTRkFYNkJ1aElr?=
 =?utf-8?B?ODEzbFJSYkNUWThYZ1F4M1Ewemh3VGJXY1hVTjRIY2N4SjZOWnYwU2FDQzBR?=
 =?utf-8?B?alNwMXFvS1NFS2owTFo5dzdmcHdFRDZmUjRLdWl0R0RKaHptVkd1MUtxNysw?=
 =?utf-8?B?ZjVtZmdpMGNnK0RrbkNlelhxVUV6WU8rU3VmckZtYVdwTTZwWnZoS0pmTnR3?=
 =?utf-8?B?STVQeWxFV0FLL1NXRk8rdGRnbCtnTGp5SjVlYjkwaFdkVzhwcEMvLytjTmhZ?=
 =?utf-8?B?NDFTVUp6UTFybjA5UDZkZkZCd1hFQjdZVi9LdE1UTzBTRkx3TjhKMFBUOVgw?=
 =?utf-8?B?THhid25jb3d1MGpCQmN6Q1FBZTNNcG9Jc3E1SStSU1Z2dkYwaERBTnZkdEg4?=
 =?utf-8?B?YW50aGRPRzl4NGNqRHJvR2lObHRsemZoT3BETFRkYStxdnlYQUVPYVlYTUxi?=
 =?utf-8?B?Y3JHZFFGVHNYTVlQQlNUeno4bm94MlVWK2NyVGFRTDhKVkMyL2pYTGUzNmJT?=
 =?utf-8?B?RHZ3UTVxL1lSSWUxOHl2QlBXOXdGdVg3MnNPVU5aRzFYQVVHZ3R3NGJKN1Uw?=
 =?utf-8?B?d2dYNTBTVTlNdTQ4emRBcU1jUXhyUmRsNE4vM2JxaHIxNENST24waDBzSkVY?=
 =?utf-8?B?YmhoWmoyMldvUEs2MWh0a2w0OUVqZituY09iTVZNZzhNVVliWE9yUzVRekQ5?=
 =?utf-8?B?L1BIZytkQmdtUGZyNi9BOUZheXlNUHovTmJMMmNNYzgrN0pwWGhaRXFwTzc0?=
 =?utf-8?B?QktPblJYRzFGMi9hNGhpUGQ4QVhjb3BLYzF1VjllRGhsdEpGaU1kbzBpd3U3?=
 =?utf-8?B?UzhpVDlnc0VmbkhOYTB4OTIxQmFlRkZndjg4eDJEZlExMGNLQzdwU3BhM3A3?=
 =?utf-8?B?QlMxQ3NyOS9ybXBqZFdza3RZQ3VsR0FWZWVzSHpGc2x6OXRvTDFtdk9ITW0v?=
 =?utf-8?B?ZitWT0VEeG5rYW8vYXNoR3BBNnZaWEh0YnhBV3I5QmM0R0JqbXNjcGcyMVBs?=
 =?utf-8?B?YjlFVjB5elRMVGFHNkh6WjJwMVV5ODNvUHJVdzMxWVBmSElHd0VkVk5abFpQ?=
 =?utf-8?B?dFZQSG1lVWZza1Fmd1ZkT3ViZDdxMTVKZ3NWcW5HQ2s2bnRRdlNiSXdmcXNH?=
 =?utf-8?B?Wlg2SUxuN0N3ekNOaWpncmxISVdlYmJ1MkNwTzUwZWdoY1c2dmI0dk9QKytz?=
 =?utf-8?B?ZHNWU3Q3RkpiSmFkT1k1ZlJyRmNOak1XUng3N2xxMEJ3eVpDQkNBTThpd1VP?=
 =?utf-8?B?L01VaEp1VGQrNHRXSU85enF3UjFlQi9vQWgwZXM2dHpvVVgxd3VvWVVFN3pw?=
 =?utf-8?B?VTcrSis5UXI4Y2xqSzQvZTJ0cDhjUGVhYlIrVng0UGJWT2pWanExSDFsR0ww?=
 =?utf-8?B?bWUrYjNjTWJleTY1NFovK1JFNkwyWVpOZlFEL1VPbzJnbDZJTnp0anN1R2t6?=
 =?utf-8?B?NVBVNE5INkdTbmdKSFZVeEYxSXhMaWgrT1VZTlFaOEhpZ1BuUVhsekZsOHVs?=
 =?utf-8?B?MWJteUpucS9ScHNaOGJpWVFsVk9TRHFBV3RpWVFnYWhjcTU3d3JVMXNudXkv?=
 =?utf-8?B?dWpKSVErU3I2Ny9zWHNxOVNkaCtCSXY4SGRIM2EwZ2NZc1JpWjlQNG9waVBp?=
 =?utf-8?B?b3dVS01hcFl3Q0dhUzF0bXp0WnJPNGZYRVZTU2pzY0x5UkVkSHZhZDZNVjFV?=
 =?utf-8?B?KzVFb2tOUmhHY3N0WjVQdmRac25lVjkxNlBsOW0vVk1SVFNVdW1CQm9Ed1dF?=
 =?utf-8?B?UEhHWkh6SnYrdzZ5SC84bXF3VTliZFcvUUZQMkcvdnUwazQ1bzJKSFNGVHNk?=
 =?utf-8?B?cndJaU5Nb2VFbmYzaXB2TzF4REFXNmRqWW1Ga0pYa3NxK1pUK2doc2VVemxN?=
 =?utf-8?B?VEFlWWNMYkVsWmVnVTB4elNzaUlLMTlEZFdwcEVhbzZ4U1NjazdaVVNUTVpo?=
 =?utf-8?B?U3RaZ0ZTdjlDNHVJSlhiRTNudE1Gb1A3WE42NTBMQkQ5NEhYMFYwU0ZzVVVY?=
 =?utf-8?B?Z2dmNzdIQWFYWEEva0hzdXNNdmJjZksxS1ptd2JIN2xXL0NGcHc3dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93117032-5a60-4877-e330-08decbf6504e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 22:26:30.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zC8VgqCZxSPOlW2l3YAoyFdYgnSFSmL7cSAW79sKFt7ElIi2go1fjG2Fy5f63gkemLiOBYNkaQ6sN3enLaWsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

The Slow-deboost WARN_ON_ONCE in rcu_torture_one_read() currently uses
only the handler-context predicates to decide whether the calling
context is "safe" to assert immediate deboosting:

    !in_serving_softirq() && !in_hardirq() && !in_nmi()

They do NOT exclude several other contexts in which the task is still
holding an implicit RCU read-side critical section.

  1. local_bh_disable()-but-not-in-softirq.

  2. preempt_disable()-held.

  3. irqs_disabled().

  4. rcu_preempt_depth() > 0.

The current predicate set lets the WARN fire while these implicit
readers are still active, which is a false positive: the user-visible
"tardy deboost" finding becomes ambiguous between an actual
deferred-QS bug and a valid caller still inside an implicit-reader
section.

Replace the three handler-only predicates with the following which
covers everything.

    preempt_count() == 0 && !irqs_disabled() && rcu_preempt_depth() == 0

Note that we only check in contexts where rcu_read_unlock_special() deboosts
synchronously, i.e. where it is not inside an implicit RCU read-side
critical section. This matches rcu_read_unlock_special()'s own gate
and rcu_flavor_sched_clock_irq()'s:
 "rcu_preempt_depth() > 0 || (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))".

Also note, in PREEMPT_RT, softirqs always run under local_bh_disable(),
which itself takes rcu_read_lock() to satisfy RCU's bottom-half
requirement (see softirq.c) — so rcu_preempt_depth() is non-zero
throughout any RT softirq thus making in_serving_softirq() redundant.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 13e0eec1e1ce..e0bea4039c42 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2603,7 +2603,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	// rcu_read_unlock() does not end the full segmented RCU read-side
 	// critical section.
 	if (WARN_ON_ONCE(cur_ops->is_task_rcu_boosted && cur_ops->is_task_rcu_boosted() &&
-			 !in_serving_softirq() && !in_hardirq() && !in_nmi()) &&
+			 preempt_count() == 0 && !irqs_disabled() &&
+			 rcu_preempt_depth() == 0) &&
 	    READ_ONCE(firsttime) && xchg(&firsttime, 0)) {
 		nsegs = rtors.rtrsp - rtors.rtseg;
 		nsegs = clamp_val(nsegs, 0, RCUTORTURE_RDR_MAX_SEGS);
-- 
2.34.1

