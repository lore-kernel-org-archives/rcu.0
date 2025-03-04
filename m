Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498DBA2D;
	Tue,  4 Mar 2025 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132071; cv=fail; b=CDOPTrW19pzCQyeJpI1wHDb4bg2JI3EdLip8MYEPhuXyS/8BScap2FDHSmEM2RbRpSjJkjp/t3gvMAIYRAC85xK7/PSd2vjeaG32rP5fbWiQJQX0qquo7EcE5pOv/YPQ+pZH99CtW8tNjoXDlFk2eA0STG6zzP7U86IbBQ3aRFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132071; c=relaxed/simple;
	bh=9ROUt0GEBcy0EWITwjXr46Yb3Q79zCPmdhVcq1eUMHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mXOjwzgj0eAlBXthgB8Dj/wYQr3gZdQxgvEqgUEr/dnb3UAXxHP0mV3KTwOeFcKrBe98IkSLE57kYDLskXHm4KCXCod+AfPhNYGcXqmTYfa/24MjVm2if5rcJHVDqfY7mMz76FluYXScTyakHyy8AJQA06OK4g+4JAMqy9Zj0v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EJuB67/Z; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EJuB67/Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGxVdPiyxWTMbp1ZSxc7sa8drtaULZCznQHx8QDCsYindtH0JucB+r70kzk83IzyQFYOsTZQwAWaqnpgKTvjwXgnycEpvqLhEccFcpRBsD4RkKS2zlDAWGLr8qxMcuoa9VOWlFGN1ifPQJ8mKkmKlKRP/DdfxC7yq0ENSCvmkrY5XRNRwFw0VNRl4E/39Pjzs5FqOARYGn5fUJutHIP5ux/zREUpDT2kSArfrU5BVre9gw4og0RJ3/HaiVZrzKzgC+DuuNGEGPVlMes2hWAl7JFoJnP9NZs05uuLI5PWcbxxnJrvQT6MmyOM1crzapUfG4bEokwi+lS6SkfObJCt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmhKmY3PWDQmfWBM30/UVbrQQwe7Ez9JzGCTvomLqJs=;
 b=JIslbkNp35ULEyj14w+VEQGMbpMo11nR2gorlLwIC8cvwoFv5CNwzl/MFcDfyBSIZWHk125Qas6XuDkaQ6G9DOT25zfXMIziBsBwDMWPs50pWlv1UewyuLcUJbHcX+HyVsZq3fqR1cfL9xlJSkZrOKz6uHTHBaNUSGXwnJ2YeLHT5B/IBsfe2o8XqGbdYAbuFGXndsE5KuGV3zyTm5vgYCnw8MvrQfICCq3n4VxbzfDwBTSYk/GScdrvRy7QrzfQnrthVaW3OP42X9qIKynlHSkwJTFE/FKhdXg1fWPekG8sV9ID0gPYCm7N3DkwPGjZAnV6qVtt1rgtHuD6s+nqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmhKmY3PWDQmfWBM30/UVbrQQwe7Ez9JzGCTvomLqJs=;
 b=EJuB67/Z06ezChRG/QeOPFmBhPsSaCrtSpSTdiVyZMayn7LTDWECLXZHE6m1XOqIq3ZlG1jiJ8MbttUU8WbQoIIC/Vchhbn9+LqH3aG37jix8eLuaaBPHgYXCVWsh4gWRUoi6yL6zBNcNuJHW7Tt63Z+RaVInIgKVnn/WvpUrF4nBYlFCESJ6OetK8lGQ+Wn7GfdwqxbSPSfdXyGaVxG8cdi9FeofixjjT341BoCOSWNyi7yP4tq+T5dCMFPU1bw0W6KmGEaACTTB3x8m3dFjym/iNbEcVPqCDnjBbCzWKt05cWRwc3pPaER4ptrIyzQtoZs+PPap3DB1G0QkdYDEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 23:47:47 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 23:47:46 +0000
Date: Tue, 4 Mar 2025 18:47:44 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, paulmck@kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH RFC] sched: Disable DL server if sysctl_sched_rt_runtime
 is -1
Message-ID: <20250304234744.GA2283516@joelnvbox>
References: <20250304200116.2210119-1-joelagnelf@nvidia.com>
 <20250304150632.3fde716c@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304150632.3fde716c@gandalf.local.home>
X-ClientProxiedBy: MN2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:208:236::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 790c1084-3f01-4048-57bb-08dd5b76f6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8cqbl2kIFdIoQnrQvGNruDS5dDRcq/PxFe52w/pl67NEmsqDrlArvHrEX+IE?=
 =?us-ascii?Q?ueDfgas06DiP7ri3KDvki/MfwTHLQJndy121AzWG1CJI+lXylQ+VVgjflSYb?=
 =?us-ascii?Q?EnNSIp3tQmFo05YxpqZlMRMdn/L+r7Ju49SZpL7UR9LcL7vbWsMo21NCS0yE?=
 =?us-ascii?Q?6+KwK24572FHq2tEsJmW3AWytsrdeO6XRk9pqagxffBdLCpg5zfxD6PIAxF7?=
 =?us-ascii?Q?TXQkQXD0gvt3PiMaMoLxTlcLFnb73H6k3Ol6DX2Hf083YMb9PcQFbKqADslI?=
 =?us-ascii?Q?SVO5Gae0YAcMjRm5efEnEoko0uuDniUFxv0cq7yjJV20glfdd5mdGWa8TIzs?=
 =?us-ascii?Q?ry9ijGoaImPXz8PHqBnED0YxUtZsENYuuhlAKmYHpxpyVs3fXGfmnLsJJOgL?=
 =?us-ascii?Q?/34VvXFFdilI5CGZh2Nstj69S2FGcDOuYDCYMQggYYszlIcdJOeY1NJGhsu+?=
 =?us-ascii?Q?hrjBkv3Y5/KxMde87G9VmLuOeV0mGi4A9KVNYULM4nfENv/Yhg3qpF6E0bPq?=
 =?us-ascii?Q?gQW1VRNG71vAc8Jk5jtwthb8C/ekbJxlclCjXqT6QgKm/T9gKLbDYQWDOcgp?=
 =?us-ascii?Q?X3ogjye/+vqNx0EBNBX5AgQDDEllzc7L1rR2puaQ5MxWgexl8suAzdwxcJjD?=
 =?us-ascii?Q?akzIxEhA/1PcNRzc6r+a+fb2W2Dd2pJOix5G6yFiIgZmZiW1gGQvm9uRF9Dc?=
 =?us-ascii?Q?PSGJ/ON+0YPnLJQjRp00JsGuweb1DRmSWk70l+GnvCcQmVqWtp/pXsux+3Vj?=
 =?us-ascii?Q?GPxuPGw9TXk98kScmPX3WdRcMJS+zBj/jmCm0rPY9WgKwiFa7RjVqT9ldx8A?=
 =?us-ascii?Q?GVWcezXvd/TKsIVPe24rts4loqmA667PoIfwSeC35C3fq9dEuZK7J83kWd5d?=
 =?us-ascii?Q?J3UgWZDU97kbOllAz9GyulOe7N6B/XuXT0P50taxFFw5i80wMLJo9Ucu3UAw?=
 =?us-ascii?Q?fktctjTNL9rSE0y2DGl4PCrzg/cJ0HrYd2j0u0IWK19vsEceuBR89XmiQM+h?=
 =?us-ascii?Q?mxRdcyUuU5YFK9jbLG6mHgDkqq8HAiK04s5XiWcf+BF2/mIc127gRBhGpcnq?=
 =?us-ascii?Q?wneEhs0cuS2ViQlCVW9y46uGMNxOytUBpTfY3V1ZVWA5h14y/YlI99eP2I6L?=
 =?us-ascii?Q?uo9QdLC6KDGWq2JWtP7NERKfspI1lz2+i1BjqKYq0S1aJX2sRCNfB695SLgE?=
 =?us-ascii?Q?QLXcdsbjBdqrWuFHrUTyfrpEVQjIWIDVuQKcci2PdkY+qE/bJyWn0RAfG/8Y?=
 =?us-ascii?Q?kYNyiXLudtnxxvFSKVjbfB1gEUm0zA/GPTL6k7kdf/g62GZPoG4OZu/DAPcW?=
 =?us-ascii?Q?8GKajI51of+up3aD+oGzG9Wxnreg/iZYoqy78JL0PJZ0/91tlFIeadfDn1Zj?=
 =?us-ascii?Q?dvlrigMXv91AXN5JokYlgPCaEMML?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ux4H8R/lmVIpjj85DXJ4XmxXlaycxrP24gX/wW7gNjyexmVCCA2YBCS3IZxT?=
 =?us-ascii?Q?6H72U/7RLPsrk0Lhusc0sSdtgw7o2Bvy7CXplZtMAHbiR1r7lr+56Y3y6ZkO?=
 =?us-ascii?Q?Ndce3N9IVigre4Hx8JnxNJmGDenlEdJifgZzsy8wQHvPJnNjWIpbIT+ehc9T?=
 =?us-ascii?Q?MZrJx2tNigHSdHzbwRA4diHbsi4hb7lXSAH92cHNfK4GGNbrr9zlU5gzLG2e?=
 =?us-ascii?Q?dnHIPOKuX88Rus6dEo00JfSq0Ql4nJ8sOOWmv/rRQlG2T3TewQ+3yOHY4PhS?=
 =?us-ascii?Q?5J41mIL8q0NH9hhg6aEAdvUBNv0Parx6i/cqneBtP4bO9zn8HRMVGN/Dwal6?=
 =?us-ascii?Q?jBcvj0fjr2d0T9FAhakeIAKujUXS7S6qRTsOfzI4/GrZimv40OOXTEfx5dnR?=
 =?us-ascii?Q?jgQooXgniOvccPfXExB0zL0aGCMQqIuXcx9dLK4sRlvbY9aSBM3ZDjigxx2e?=
 =?us-ascii?Q?K8gp5gix4eZw1PsKK5G9ab5eKysXLwO9qUvl7uFmlh7+JZb4Mm3VP4QcriXn?=
 =?us-ascii?Q?zVEaLJQrN0Q6bd7paYLkeURqj7gn1Y6QacB7snb/ilPHYdPjAqcwbG8SXytI?=
 =?us-ascii?Q?xeOW/pzb5IzPGhbtZw2Sf5J5pOP6sarSK9TKdZ4D9iESF/JokzWx2n1T6iyt?=
 =?us-ascii?Q?VqVIoYvjUpNYNquiAxF1yu52Ea7/c4W/Y7Na5+2qtHyjH7xi5XBgK0uwevMY?=
 =?us-ascii?Q?10/1ig0y+3qo3ds9Ai/ihCTnsUm+yIABNoogFaMH8adKm9k+JKFdM8kWAtl7?=
 =?us-ascii?Q?WRoJOG/v9MODP/VZ/8Wsc1n7PMD/tFlEXxeXkTowXCc9G0vRGfXaULNAmgrD?=
 =?us-ascii?Q?NOJizGVK3JwdC8Cao9HEoKHbkX7WbwYOkDjck+CRA2qJfshrqSoj7UMN669Y?=
 =?us-ascii?Q?7WMDuK2Ql5Iyt/+qAHsHoGOmW0Ht3lr13KAWYMg/SjRW4r8dnXv5b/6IilMk?=
 =?us-ascii?Q?FM8zKX5HcspBtuNaI8b8mRn71KBT4iYNcS3KnFAiYxk75VL7g33JA2vkIb5Q?=
 =?us-ascii?Q?PZHdWntxjoSEDE/A3I7RGqi9SIOi/+ZwdF75TylvGLBELF+3G/uXk3q6y9Xu?=
 =?us-ascii?Q?hJo2aIXI9/NMMqSAO+5nVBIwNKAOV5HSKG08cnx2tJ8trzI08zVvwDsp4RIp?=
 =?us-ascii?Q?5gMSPgJnnbw4LwVCpQMvRxxpH1xK1lxh1dR5EGhP6n8oqS2eb7hQt03oC1EZ?=
 =?us-ascii?Q?dyJt2rvVb/rqIRevSKSbz1nLQ/FfOWnKvy54R7hKFseSwGzDt4K7gS+wW/YO?=
 =?us-ascii?Q?orOyL4wNHLXyQ9UTcZK1POY/hp17v/jA/q3KJeOjcQI/HNdZXRbgWU8nbm8E?=
 =?us-ascii?Q?2Q0yVK8Mb4EcqVPnhRsrIp5VBTozXhg/p4l6Cp8r2PVTrO+92UZ42SetzFG2?=
 =?us-ascii?Q?+rmFCKyLYb57A+q5XYzwLiIj53BKER4MDZ4+aZPnNHQHn8unOVujHi5XgP4n?=
 =?us-ascii?Q?0+2pSjMn+vsgCzfgEm8PVNXJFKJ+umqIQG4hg5o3FzC2RCbWatYBRFZDxIW2?=
 =?us-ascii?Q?EhxMTYM6A1lI2+DXNslwKCinqG4DuUfn/mzQ65e8jRjTrDOr3iGegiqKMUxn?=
 =?us-ascii?Q?axv9WIXzh2TXQilaLG/z5vhjXLQXz/H3UJR8N2tM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790c1084-3f01-4048-57bb-08dd5b76f6f7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 23:47:46.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04lyb2rppscQgXyWdcbJWLO4KTNDc2UWAMpmm31FEipd+uJEiKqOT36RJviCsyJFCVwkzSSRRU41xdjk+/3L+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598

On Tue, Mar 04, 2025 at 03:06:32PM -0500, Steven Rostedt wrote:
> On Tue,  4 Mar 2025 15:01:16 -0500
> Joel Fernandes <joelagnelf@nvidia.com> wrote:
> 
> > Currently, RCU boost testing in rcutorture is broken because it relies on
> > having RT throttling disabled. This means the test will always pass (or
> > rarely fail). This occurs because recently, RT throttling was replaced
> > by DL server which boosts CFS tasks even when rcutorture tried to
> > disable throttling (see rcu_torture_disable_rt_throttle()).
> > 
> > Therefore this patch prevents DL server from starting when RC torture
> > sets the sysctl_sched_rt_runtime to -1.
> > 
> > With this patch, boosting in TREE09 fails more than 50% of boost attempts
> > making the test more useful.
> > 
> > Also add a check of this to task_non_contending() because otherwise it
> > throws a warning (in the case when DL server was already started before
> > rcutorture started).
> > 
> 
> Hmm, I wonder if dl_server caused a regression. That is, disabling rt
> throttling should allow RT tasks to starve anything it wants. And some RT
> applications rely on this.
> 
> Should this include a Fixes and Cc stable?

Yeah that makes sense to me, I'll include the Fixes tag in the v2.

thanks,

 - Joel

