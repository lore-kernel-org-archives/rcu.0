Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0251422D8;
	Tue,  4 Mar 2025 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060660; cv=fail; b=aRdHYLKRTVjMRMgkag4BcDeEj3S9yyyxfQpuZadpgk+pYs+rBu1uRmHi4TowI8yqqT+aqANYFGuRdWVXxCOiCGhuyjLqUTYM90erEUFikpfOqF7vP/vIu7gnbeMtxw8kgJmyANzhniDmXKmirkf/6Jg0Qf/ecwXb1P3LkifFFRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060660; c=relaxed/simple;
	bh=bwLnZKbc8bLrBJFNI5dkdkqALo15IdrKKMG8/7pCKIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eOiT0d0kkgoau9Y2bU96h5dLh0C/dg8bTNZcEJH0atSalihnyCV8sFJ+QQtA5CJTOkKhby1N/35xyB1X2erhRCdcL5MFPCcKVVQefPHRmOIp3csiMFdwi+SCT3aWJMNTZwMHO6JMnxXOxAR6e4XZYTwwY6YV6sHSUQmSOcym0Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DNV/8f+S; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DNV/8f+S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3Ls875SVHT5tvO/FRWvA73wi2CYUxlhXXaApcHapopxAq1zUsKK1WRlxz4eY+uJkvyUNsowAO9eCN2M09/Mjqv5gVVkWCSdY1mQFXln6Crnv1+ENZPvjPmDAAGL+TPRgYjA4bku3cXQv2x6fQCn3Zum5X7v+AyuDn3rutBkXcG2nU4Q2Ru553irxl8zTxa7yS+o+4oY7vfwCXCoIB3c41J9BOhrmy+B/WiV0zvy9zxROK08aJGhrTbNux58BugqEtJiAgnk8J4U3JSK8vXCF8sRcM4t2FxNdPzjNP1EwEnZVlwdTscjwAWSG2dY4lplihC5jo9it8TV1lz3AH3QIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzN78j03jlzH6OEdY991KJ811mJSdZID1onvmyndArA=;
 b=Z5tAus7Kc2iv0u2xstApWfoSQl7eZwrzocxUl3H0Yj5RmY8CQHkOECMaRp6vCB5inAJUgFlwGTXPNueqxTAKJd9Qm32vMdo10GKDTM4zLr1GB02CqgWJ/uwyUwQtqoObh8Nyou08CXkPZBIqaD1k5KOIXWYnAlnhwfvXTWm2hAlstHMOt+a2G4ZZzgGbgQq3op8LDiL/MGGMqS6l3KBMHnRrGOkB6l3xn0ablk9SpouRFL8Q/QQchefIqjyRum2A46ULB+1OL4B/0+v5jiBMtQf3iuhz7xEr7xuW2H5yoxYGqRN36ojK2CNVCCYN9+wFa5DvclQyEYgq0aRbNbbUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzN78j03jlzH6OEdY991KJ811mJSdZID1onvmyndArA=;
 b=DNV/8f+SLUdcR3ijI225As6ZF+WK9dKDUCHcHS+z0LXwD99/x3HHnbUojBW+wn3K5DMg7bh+jAfhffk1+mK7m4p5sPI+lXCPQ6Duq/u3ldEF0lVEmOvFrFK0AjWogjbRtA6uMaKYY+Ho9KEv5A4JEWY+yvwSxo7NfhdY2eA033cPaT1DFctu7QshKKJ1q6QLQLlyoD6sbZ2t4cR+gGhkEcWm1lQHElgdh8oc7rW3nrAMp5CA3BGSdIwdAvYgxAFyaLLU8S8xKel1eQNLmFsHP9xhQllZUUjQCb/hyXdF0ZWrWxEQ/eW+6D5VBDQzNqkqIcqxL8ig6cxPDOdcU5mCSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 03:57:34 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 03:57:34 +0000
Date: Mon, 3 Mar 2025 22:57:32 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Strforexc yn <strforexc@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: KASAN: global-out-of-bounds Read in srcu_gp_start_if_needed
Message-ID: <20250304035732.GA128190@joelnvbox>
References: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>
 <20250303114711.12716d05@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303114711.12716d05@gandalf.local.home>
X-ClientProxiedBy: BN0PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:408:ec::13) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: a7986c84-fdbb-4287-e8fc-08dd5ad0b1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t62lvxB3MBLS+GSYOzB5DENFCqHqDX8bE/Xb7RxD3ZIeBUfhxzYp1rQ6QRvv?=
 =?us-ascii?Q?DWblKawaFyGqRofda3CRyhSDeIUCiOX2ctZyofo4ONSaFyGTeRp0AKLpmDuF?=
 =?us-ascii?Q?PoWjgvArgx1ZAY4135QdFWwALlaBasjOi82glKm5gudsLrFBhnkDBlcsJ1Te?=
 =?us-ascii?Q?sjNqzkxhPVj+165zpDLB5K+Ds4Me+EQgGZDvKrkuh3WkYEXEhyiD8l5wEcb7?=
 =?us-ascii?Q?A8vW6oByAQ1PGGPYIaQp5hmOLEGp2l9cFRwwlvnZ+jxizIzWgJ96WCE33J8R?=
 =?us-ascii?Q?lKoALr55TqRmXEy36wIIZaIH6sHpIcn4SFDgK56RmxuDc3m0JqE+lSHL6IDq?=
 =?us-ascii?Q?EPIDTIVJIybs93kChtExvj4EpcD9ps7YZnVEqKxh+/GpS93cW6gUMva/Rhsd?=
 =?us-ascii?Q?wlvhKgjVQDHx+ZlLNtBtFO83cVPK0rNcFXVCePzQKyC+5DWMr1LkzoSdo/Py?=
 =?us-ascii?Q?l8x0bSSFYktLgj5plBQeKG4F1yMM1gRYl/gjVAYIbK3lSNlqpMtRC0itKkaW?=
 =?us-ascii?Q?a9ahrtCEXCseRmCKqOa+LrsTiY1hGQbdzkuEu0+Ur055D26rps4oc6Wltg7d?=
 =?us-ascii?Q?OvHVc4MILWYwntYNAV3ibZtIiuDRFYbArvDMi4iY+cVO8T3MjyhwPvAylnBP?=
 =?us-ascii?Q?vxDoZxWVfBSUM6ld603yvYC3jKXEtEfOfPz7/mSGlizp4dH6YWN27mwozA03?=
 =?us-ascii?Q?vM3u8WEtWSE/sF2nCNo+zW3Cc/nRWls74bGczhT2VfBhE0R+eorLSJQAr9Rr?=
 =?us-ascii?Q?AwHSuZqUHh5iTajY9kBqW+tsScZ1cnH4oUdCu2DRIPKKnvIu5NG+3ya0Gy0m?=
 =?us-ascii?Q?6FccIY3zuZQCjIOrxIvpY0eK3VUYvqRCJQRK6BRly1WHJMSdnWYYGBhQQ96j?=
 =?us-ascii?Q?2wgWv/YVWS+UuMuoXbm1YT871XO3/VrlIs4KYDlo3fivw8ix9KQlIAAp8jHi?=
 =?us-ascii?Q?kweBUaDsOG9gW0QhFg7C6hiVKtpCKYJP2uF9ecSTyM2QqgiJFtWP8ABz/ytB?=
 =?us-ascii?Q?68XSvgY53mu3+SJ4Lb7ll2QER3+llMl8BdpaZxTCFcuelycX3bySTmROKxXB?=
 =?us-ascii?Q?cF026tEUFfwq/HnNWsz+wroBkuZMHUI46fBRs1qhSE9U78Dh7+lyJgH5Jf6S?=
 =?us-ascii?Q?jV1QOEdbZsV3fRNzd4ya3B6Qq+52vrAWorklZZ8JZicBAeynHASuMlvlWEiT?=
 =?us-ascii?Q?zkDSBIueBOniiZchJ9rG+n87BHua3ppAH0WRTav6mq8DWaqdMPPNejbMYB6E?=
 =?us-ascii?Q?+Xhn5vFP0TVDSoUe70Wl6xz4d50q+V0Lh5JL9I2vGSZgBl8LeDUoFAIwuDqF?=
 =?us-ascii?Q?PjJpY7xi/Nq/NmCPMKt1RlizsDSX6/AWxll7JhAOGCZSQFF9GAd1LchQjPhR?=
 =?us-ascii?Q?nnDxD98udeRMkR3ouFIkbR9OICa7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YIK26Rzf0eqARUNOhOEsmxa+XvM6W3rVpX/R79BuvOF76rOSoyZO0HmCpgnH?=
 =?us-ascii?Q?t7yq1EW/8kemLqIfmjNxD5annWVNdmv33dbhr4+TW9EmCjAL77vlAGFg3SWd?=
 =?us-ascii?Q?udrDxdduME8ypMEXfqk7ND3M9QjunjATtE0BQ12SbcwDEB8/BRkwA9iygVi9?=
 =?us-ascii?Q?OXqp+NS2G6FBapFyo0Enl9OcldgjDEbq+383JuPQTkTMyNfZGuQxZPfPCqNv?=
 =?us-ascii?Q?FYbveXr3EwPPK2B1P9Me8k1l10h7INTb51npPt755mqFNXYvY8csdSfgLB1q?=
 =?us-ascii?Q?wuLRsc1tbQBIjpRHLrxOYOXADBsts8bxA7JMw/SS9Ibr0ezLFUe1e+keuLGK?=
 =?us-ascii?Q?XeLuBO30OAADuDHTnMajbiWV6OQGsizdxXL26YwJISi7X0y+Z+13WKTjKCFm?=
 =?us-ascii?Q?GVYQdJFyeFiFJ1+p7SG+tkYNJrogc6qqyBZEjXFmpT+RU6VdCNDkSvFaS8tn?=
 =?us-ascii?Q?A64F900NYm7w6wI6B7zqB7gzUUBFh/Udozsr2bsATLhOefN60s6hH54mDmE9?=
 =?us-ascii?Q?YenVsRDJ2KrQI7vmEY4K1x2BUolTn4rjvI0AZdPAozEqkjAcy0SJjSsLT7wZ?=
 =?us-ascii?Q?HeFx85EuxiexSpOcrRmx9MyA7Le2SXEELaXycpNPsoX7TcWIf/XsUdzs/7nB?=
 =?us-ascii?Q?Yl9NEHQWo5Y8V1tePoJ9me0yi3gB5OwlmMrmy8F3O/c+G/zsdAcdbqu9+SW+?=
 =?us-ascii?Q?5PuOcig4MOFABaN2r1X8IP+/bNzNWRP9Eujn5AYSsbod/hLIBrJdtTCTwryL?=
 =?us-ascii?Q?89Re78/m5uvSVgAc4yyBJcs11so0Jsp44NZxV3AaRBO4Ovylj/4SRODkvUjb?=
 =?us-ascii?Q?PDwDax0uP0fj3QxOneYecZDySIMfSNoOlxIAs9P0OhXI+ZxAIp+/2L5sjvrv?=
 =?us-ascii?Q?JJGIzPSbgDUxptzHKepD9s5XZcHzsv9b3SU8jKGZ/6trJNq4R6GbDOIGt4b+?=
 =?us-ascii?Q?82DQBbamMBXMJMnNtlAWhPFmdIwx6+YgQ1hGM9SYeT5EbNge/JKTKA3RAs0t?=
 =?us-ascii?Q?bNwYUygXnzDIbC5F5qxDuH+tZRZKAYlSkZ2QkHrehVMf4R3J8Efzf1/IWU3X?=
 =?us-ascii?Q?Msavg7hWh+EnN2dc07b4hB7qsozWNXDGzfNvczeyOOvc5E23Br76sSVCN78t?=
 =?us-ascii?Q?XvaP4XPSy+Q4l58TyDXjj077TGOSUSpQBxN6w4qvHQFlT7gx0P9KtI2GKHZE?=
 =?us-ascii?Q?bDJ9rtm4xobyt4Kf3bq6hXm/ey6RmRZi3ajX91TkFejdVSFaKUN8XQnztqc0?=
 =?us-ascii?Q?fH/oSQhx0U8GGoaGRdKmdMFZ2/8poxsPf9+O2GBVwz0PWYwab6Rp6Kfu3nI7?=
 =?us-ascii?Q?DN0OB6q0mExZvM3rRosYOF0JG0u6OQYy9UWe/DPdSOey9k84Rt8XLN7ncUZu?=
 =?us-ascii?Q?eY/k2h2Htnk1b6fIPxu5wMMmgfFsV1ZkEU6+Q+QgFyamviCfhokMWRV48TvE?=
 =?us-ascii?Q?I7jY4kWYCHPGFimVum0Vt6CKB3ru2XVnxTt+MXIkYNaMQrQcaJPeTqn7oDqX?=
 =?us-ascii?Q?4anAlsT6RTo8GOKq15xHbJA4XMfgd5ejdO59CLcDwOGhkk1GmYV9YxkbpAdi?=
 =?us-ascii?Q?LQa9voAeuMWNEnsBsXSt8bKc7tttEG4CIc85cpoA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7986c84-fdbb-4287-e8fc-08dd5ad0b1d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 03:57:34.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGsxNphoUJHjJ7XH0LOtO4I3T2g8v5ikSz7edfWKgW0SPArqtPJ61vkqnj/IHuWPjAXpeTDD4e+Ig1FAJJfwfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

On Mon, Mar 03, 2025 at 11:47:11AM -0500, Steven Rostedt wrote:
[...]
> > [   92.322347][   T28]  register_lock_class+0xb2/0xfc0
> > [   92.322366][   T28]  ? __lock_acquire+0xb97/0x16a0
> > [   92.322386][   T28]  ? __pfx_register_lock_class+0x10/0x10
> > [   92.322407][   T28]  ? do_perf_trace_lock.isra.0+0x10b/0x570
> > [   92.322427][   T28]  __lock_acquire+0xc3/0x16a0
> > [   92.322446][   T28]  ? __pfx___lock_release+0x10/0x10
> > [   92.322466][   T28]  ? rcu_is_watching+0x12/0xd0
> > [   92.322486][   T28]  lock_acquire+0x181/0x3a0
> > [   92.322505][   T28]  ? srcu_gp_start_if_needed+0x1a9/0x5f0
> > [   92.322522][   T28]  ? __pfx_lock_acquire+0x10/0x10
> > [   92.322541][   T28]  ? debug_object_active_state+0x2f1/0x3f0
> > [   92.322557][   T28]  ? do_raw_spin_trylock+0xb4/0x190
> > [   92.322570][   T28]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> > [   92.322583][   T28]  ? __kmalloc_cache_noprof+0x1b9/0x450
> > [   92.322604][   T28]  _raw_spin_trylock+0x76/0xa0
> > [   92.322619][   T28]  ? srcu_gp_start_if_needed+0x1a9/0x5f0
> > [   92.322636][   T28]  srcu_gp_start_if_needed+0x1a9/0x5f0
> 
> The lock taken is from the passed in rcu_pending pointer.
> 
> > [   92.322655][   T28]  rcu_pending_enqueue+0x686/0xd30
> > [   92.322676][   T28]  ? __pfx_rcu_pending_enqueue+0x10/0x10
> > [   92.322693][   T28]  ? trace_lock_release+0x11a/0x180
> > [   92.322708][   T28]  ? bkey_cached_free+0xa3/0x170
> > [   92.322725][   T28]  ? lock_release+0x13/0x180
> > [   92.322744][   T28]  ? bkey_cached_free+0xa3/0x170
> > [   92.322760][   T28]  bkey_cached_free+0xfd/0x170
> 
> Which has:
> 
> static void bkey_cached_free(struct btree_key_cache *bc,
>                              struct bkey_cached *ck)
> {
>         kfree(ck->k);
>         ck->k           = NULL;
>         ck->u64s        = 0;
>                 
>         six_unlock_write(&ck->c.lock);
>         six_unlock_intent(&ck->c.lock);
> 
>         bool pcpu_readers = ck->c.lock.readers != NULL;
>         rcu_pending_enqueue(&bc->pending[pcpu_readers], &ck->rcu);
>         this_cpu_inc(*bc->nr_pending);
> }
> 
> So if that bc->pending[pcpu_readers] gets corrupted in anyway, that could trigger this.

True, another thing that could corrupt it is if per-cpu global data section
section is corrupted, because the crash is happening in this trylock per the
above stack:

 srcu_gp_start_if_needed ->
	spin_lock_irqsave_sdp_contention(sdp) ->
		spin_trylock(sdp->lock)

	where sdp is ssp->sda and is allocated from per-cpu storage.

So corruption of the per-cpu global data section can also trigger this, even
if the rcu_pending pointer is intact.

thanks,

 - Joel



