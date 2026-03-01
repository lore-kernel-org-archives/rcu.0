Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA101DF736;
	Sun,  1 Mar 2026 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772334556; cv=fail; b=FAGxfMEouEb2qDr6MezwNylD9uH1UxSUeLxK+x6MR8/LPEswZpPV3KwhQQrD8TwfBQ6iiUhAUayd84DLybtgEO+wwOBzJu7vfnsDkANA+pxvMCArO5qHjaydMdxJqrDNZjgNl/UCwtzGnMlro9xjdTr9S41POxMCDz/+08HCkxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772334556; c=relaxed/simple;
	bh=uWdh2hfrVEMiGidxoA73zUT5VpiYzXqDVPWZmEA7nO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y9fiwO0OLF8vPlfN008/l2lPViNAls1qXNzbFTJ8J8j1nzfZIVqAll+NfGUW54+Q1AJua9E8zcperWhxINEK2VjsaDjtQK/OHSgzOOfnH+tSqANjHizb6RIwdScBC6Z1tfDzg1iBrzI3KZZEhVOBcp488PZVMUUIXGPGnS/r7Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YcX7BWPR; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YcX7BWPR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZB7zdxw9+qa3Rwo/que7yp98rJK8cPgjODq5WxwrG2+k66lzCaLFHPRJU7ti6cKCT5hOMcdcFVexc8KwP4MnmS+9hxx6ISjpqT95FVYiRE5EZA5AVMFkz2kTmi2lzne1jRn2YhNuq4ySUZI8w2Ckdhf35ekc9ipI0WMCs+6MNM2Pbfwqi4zHpVhh104WYjtNt3sZSA62d94r1jaXpEGUcL16j60AJ5caOaIydE5IBHmZCIvjPrP9XUeT4l32CWhptMzWnZY9BIrhZG1fdG3x8Of+DKocqVGE5PeRn99H1GIW+A/kJzJhDWhmgu3RN2ejdlMPBenATQCFATJsmKAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxC6Fxfr0S4FOIqLS3AeMgnvmW1t7L3sBFUByPDhvHY=;
 b=du/g8HRXSV5k954TTzD9YsoIMJmXRzhadOWsBv28CGnV8r9f86O+SA5Bz7HfJ60DhISqCqD2FEVuh9nLektQpWKeBPonqmwmVb+UsACiy1tTbUnqfxdcSUKZYLIU3f6aafniCiSiypV3VPdsJyLFiZHEll3zq0DFd7X7ejg4d5d7yDVbgA+GxsWcFeXlGNwXOfJ/hMSUXNb9e1xnVQHnTj++yCas51LYC49zTJlxrPZ+IoEppeBjVccSGcmEoK8mDTJZzjd3ptw7TF7/B7RoKyhSOuljCGQWN3dI7e+OIP9FCvd3+nZBgZu91LZwk8hJ+1wenKnM+qLEUlA5Vuvf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxC6Fxfr0S4FOIqLS3AeMgnvmW1t7L3sBFUByPDhvHY=;
 b=YcX7BWPRMweoi3L3zXS4llRzeEpqZkYs69IKEtnGKXr7oWhNrPbBrcq3wGpAtaIkEZQLlPBMlGpIOB0mk/mfGfIW8m2KgwzNjX33aIp32eNFo7M5bpVq2l33ugQLv7bm2YRaG23fKI9b9SVEB2dQf35y+t+9yGi3heqzSPy3BFkdOLhEHYIjDTAeHvYhtjtYrbvWj0XKI/H7jf7g1b4u/cWoKKCmQg+T3KTUIcuU62up+yyt413Hz8M3CAPi+KrLURvGDwjPWOYT5Nbzl1LY7AZNp1yOhgpxKo1JIti4EiO18j9PFd4x9XfK9/9koJLWJ0VjXCFFYzQrkdMXwSVt1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sun, 1 Mar
 2026 03:09:13 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9654.015; Sun, 1 Mar 2026
 03:09:13 +0000
Date: Sat, 28 Feb 2026 22:09:11 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH RFC] rcutorture: Fully test lazy RCU
Message-ID: <8C3B3E86-91D9-4F27-B385-CCCD0041B733@nvidia.com>
References: <07395baa-806d-4e12-84b2-c393aee064cd@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07395baa-806d-4e12-84b2-c393aee064cd@paulmck-laptop>
X-ClientProxiedBy: IA4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::15) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7685d4-defd-4e09-e9ce-08de773fea23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	alB70IIAKJ81OKNUVxxu67xy906tNC0SX1z71un4+F4nC0U29d2JBgSkD8TapZjwhybgcmt3foT/aqaQeLYUytvpZNkoS7IAHPAvSsvYmXZnyenmWbWPw9msvnd9nhOYtwIEBUauYNk36KGYQq55bx1UPjBWWtRwZVWUihxh/G9G0v3EG2u5Z9QEAPxwo1REtGQg8e3dRdbUlhnQW0emNDn/uppWdnxzK6HwJQfLT2/FyPQrNZyXo5qHdcywwyjTZptxNZ2jSwgCEMpe/hH6HBrLQoZPfQbR873epyZxM4F7toYxK8KpyVVbdQV/j/FmQi1Jq3iEgYAWjdLKan4i18FZuNUQdCUogW/V09EWk86L8XAsX1El7kbqhN5kHQvkaH1LT2CXSbc/rbiF9P5hPWDbCf69SzbpexzqzJ4qG2/9luAFWjdEyMUxYIgib96nZDSLaO+q1mpL0YvAwEaoVZMju6pxXk8M7KEJLTInrIDPaLBVRrZcoXoSpp9UGah7/wuZzVmZJqn2j4vVbSJOLqbJLqbizVYnEXEp0IFo0/dFNfBAqvEgjUOeVoutQstlLcw7g9WqZxGDp1mHKtTmbBooWgSVDYPNj5JklPDD9cEZGwXUStVzM+N4HzDfZMM998C2Ca+U6+sRNjw2Q+72NzZByCMiQKGDvEGUp1qMlrgt5fst5Hs9XkUgP1SmQ5pFBiVMfsNvlhiYV3TH8U9LA4carnenDfOYK2xpVRCB/RA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2J0WSlUwfNhuvIfTXTK0Z2bVBq1tcuC0UlaLRuxi7YA5yvwg+7gzmPfHuChA?=
 =?us-ascii?Q?JDk8FJaGLr7rVsPyJPB3FUfBBetLmPOR265YuaDtZII3p2CkVbNSonfzi0o0?=
 =?us-ascii?Q?Lw/Zvm60dy2/TrZ6wuh9wc05oI9YY6y3kwY7PEBopH8BSuiXphaC79Jeutfz?=
 =?us-ascii?Q?yPf42WA+GC6tFTy432OZPYB+Jls1FTdkdYDwWoOwAZhGoMYCA+UH/L6/LBTf?=
 =?us-ascii?Q?refYcwOEuQXMApsWdM2O8I9HZGSAxKGoPXOkpLqxVJZwDifA5MRn5NQbrFIa?=
 =?us-ascii?Q?2JlAQRWsRinTNN+FlX+gL6TBkSDELhM5Pqf3YX2baswL2xW3gAMbE1tsU7J8?=
 =?us-ascii?Q?SpIFLafIkWyoEDeRZyNx5W1VBXsGhVle6uKgEytLFCLIvJAvb7XwdJBMuC84?=
 =?us-ascii?Q?Rt77JPFppdGKUD1nNP2YlF9eEicepC1RF9V44IyCJfxgw2OtYWzevwoxrKl7?=
 =?us-ascii?Q?9eO24ge1/G18uOx09G/xbjPdLE5jUxIWBEosbsLsPThVsCHJ4NY8zYKF6ftK?=
 =?us-ascii?Q?crjHHAWyO/0aYv9+lwAtadCVbwrkvkUm8x+sNFAjYmjhyR1QsvNAFt2g8jHy?=
 =?us-ascii?Q?ZqC1Gaj78Jt8piFnvG4srHkQ6/12Pq7mYh3ayElhSOLoT1t30t8o6gI/HugH?=
 =?us-ascii?Q?Qz6q1oIKTrGufT+zE1SAd2BlgvVtmG8D/JSM26z8AnucJXSsySRVHOZtNIYl?=
 =?us-ascii?Q?laY+pN6d9r3cZec2u+19URkCFjlrxModlU35tEO79YIW0zd7Q1rH4riCThBy?=
 =?us-ascii?Q?IRAbuD/Mo95XkgXx/QTbjOjJGJDPrxRcLXpqaW5r0e52SdF5gkiCQjXShkzh?=
 =?us-ascii?Q?vfck7bpf7wGNsbpg3WWsWR2J/l0GLcme0ZD39kmR/VbZnhgNt+cFYpJz/sxb?=
 =?us-ascii?Q?7hztjhfbqENFEnAdRklCL/eqA8+TGAubsT/hVsYDmMP/O9jmha4NHZigSzJI?=
 =?us-ascii?Q?yO1HV6sfT3dW63YNUH5FlSJB+2KdbOrESudMaDchOSWuorP/HLojWB4QlhS+?=
 =?us-ascii?Q?kXXR4iES5BPqMn5eG2ZkUetM3PwhoL7mc24D4Abi5SPNSlN5NA58s9YYllfg?=
 =?us-ascii?Q?J9mgnF1ixMZu2bR0LyOu0DEKI8BmQ5MYs/rB9gNUVG+XvZJXo11Zkfbr3xjf?=
 =?us-ascii?Q?xWtXOqvUN8Cot2OiDVySmAjDGDbsjjjK6QzYqm9//Yum3Z+r0TPJzJasV5Fs?=
 =?us-ascii?Q?A7Q20ZrghSdowtjqsGQKAS1oCosYbK/2GGCGmyp83fz29Gu9f4VLrjcCbaT0?=
 =?us-ascii?Q?wzBfbD+Rg5pVxEsj0PuJeKWiNO9wVfxYJx12DWys9RGgDOU/pL7lP3GMIELY?=
 =?us-ascii?Q?U1cwFSNfFdVssxh0LO25wGd+mAclWlhiWyQaGLn2ATO6zXg3R6OmkQ0v9cDU?=
 =?us-ascii?Q?Uxewyq5PaEzMOStZ2WCmmZADOlhniJKLuw08aBY28GgRrlnrVkYO/lvVV9PZ?=
 =?us-ascii?Q?j2LNjgHGt/ttQ9t1Jc22p+eMVUT4/jlH7amyMy4dSAr0/shDF0bcHehkRhza?=
 =?us-ascii?Q?jW5YkoMXbRa73Cnn4G2JWbATTGCozjgzrJ69ezMyUoZig4w+VzXpSD0GN/cd?=
 =?us-ascii?Q?9qf3o36iRpArFecRfTlactWab6AJRVnR6jz5oh2bV2WQ7n77y67KjvEuukta?=
 =?us-ascii?Q?pq0a1beuCjqrx/jw/u0FqVJVTtBYcDyi7mKvSzogEfhRkH/dkapNkxdY8g2E?=
 =?us-ascii?Q?nrrlPjkmnL4yvGTHQn7GfcUzg4L+pNIQeFFcWP33k159Wug5DC7eJwZAN2Mb?=
 =?us-ascii?Q?Fo5oUGiSPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7685d4-defd-4e09-e9ce-08de773fea23
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 03:09:12.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ9B/NIo3kUQOwysK5H/4SFn+VtqxtjS18XAka43OR/6/Z+EtiA0o2KzymndccUXtWo4lUHKEJ8WW8IxqFBG4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425

> On Feb 27, 2026, at 7:39 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Currently, rcutorture bypasses lazy RCU by using call_rcu_hurry().
> This works, avoiding the dreaded rtort_pipe_count WARN(), but fails to
> fully test lazy RCU.  The rtort_pipe_count WARN() splats because lazy RCU
> could delay the start of an RCU grace period for a full stutter period,
> which defaults to only three seconds.

But call_rcu_hurry() should completely flush, so if we are still
splatting with it, does that not mean that there is a real bug the
splat uncovered?

> This commit therefore reverts the call_rcu_hurry() instances
> back to call_rcu(), but, in kernels built with CONFIG_RCU_LAZY=y,
> queues a workqueue handler just before the call to stutter_wait() in
> rcu_torture_writer().  This workqueue handler invokes rcu_barrier(),
> which motivates any lingering lazy callbacks, thus avoiding the splat.

But nothing should be lingering with _hurry().

> Questions for review:
>
> 1.    Should we avoid queueing work for RCU implementations not
>    supporting lazy callbacks?

I think so, best to isolate non Lazy cases so the barrier call does
not cause side effects.

> 2.    Should we avoid queueing work in kernels built with
>    CONFIG_RCU_LAZY=y, but that were not booted with the
>    rcutree.enable_rcu_lazy kernel boot parameter set?  (Note that
>    this requires some ugliness to access this parameter, and must
>    also handle Tiny RCU.)

Yes I think we should avoid.

> 3.    Does the rcu_torture_ops structure need a ->call_hurry() field,
>    and if so, why?  If not, why not?
>
> 4.    Your additional questions here!

Do we have a reproducer for the splat? If there is a link to the
report, I could take a look and investigate.

thanks,

--
Joel Fernandes
