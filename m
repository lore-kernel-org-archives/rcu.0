Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792534817;
	b=k9h7/pIcKZL2/6MOhJ9wqMfJC0exC0jxaHd1iJwJEAbgSXyPPQEn7c78QJJqMwMS6yU8
	 gr1UhjIIUfLvBcO78bAIGYrzJL0TQ3QboeFQtp2rPG/qVaxWtzSXMdylcN8wrFNgDpydT
	 pkJENjgOTUIxJqcYKeqZIJky6dZOvPGX85sLrnphgsfsWTeKHgRRCTNGBDg0K21XyDO5X
	 8iTO6EOe0uHzgICe92CGUqmTGYBIdrkOkHcmDq5LnqTCTinu7FpLvV42tMal0xzK9MIb5
	 0m9+VB1WErmpbQ3TFSks8dFZZ+D7XJSRfPSBHD3b5mhaaDJhgIbXuTiI2bkWH/D2ftg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534817;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HyqXdSOv27XG+rJmxrrYx12gBBZ+2go+ltU0KEkdNTg=;
	b=WFMhDow/ZsqsjKpFjbbkBvLnV4JN8rbzZP6g/guug9JToZgPAEnd28lpHJ5Cwhh+W4/8
	 gMbfU73Ah6VlZGUT/F+HaKOkWEdZaMoozy2sOdeOXrH03DWuyWYgtuYWVl0Hrg7R0Btga
	 ohPzfcAdBM0shc6T6FT1uEtiHSS9tcBlyaxYQyyrvKo+/Bj/roGMZmbKMbeKFXBhgfIoX
	 gzFGvASHScYDuqeG/MVLK8PVAM6r2hVhR8SvrMIC6f+pmPZ+XotVWQIDubHSw3QirQVvz
	 o3XnVROYwsL0CUgmIqtG6u72gKG8lj607+0Z1LRhlQnXLiaTbOrnbxv596T/0CGMGZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BPOy6KPh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.66
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA73606A319;
	Tue, 20 Oct 2026 22:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBA73606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BPOy6KPh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL0ekwYKdym2KO1Hxx4Rp+cBOFiWAlPzJoMDSWxOBWDuywp+A7QuwKLJWMkvqW7ZTFB81CJ4M/xZjRbDap59AcNwnqCnZPe1EUE8kKdy7FbN5Y237ZSkIARfPBhOOHTKKDZLllB73IL11zwLuIRIEgxusWhVkQ7BOgiGEx9BroKHXK0SawNKzP2zuHLT78Dz3nJF8VIABle/Jw8nli4GCatZYTV7FKUvUDo2Bor4px2BRd9hzB1tRBey5w6drr4UEZV07ZcJruZFac0bUbqtq/49v846dX/vVDFzYu+6kLv/Bguepv6/OwUCfYLoiuWhNyPHo1jogyG4i3L/qEZqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyqXdSOv27XG+rJmxrrYx12gBBZ+2go+ltU0KEkdNTg=;
 b=Phdx1tOJ03bG3keDFYnUh089zvO/A1LUQbM+IWrcufvn/ufLW6NW9BIiwRF1LQfXRryyZxBVxIhyoPPWR17pHKpreYxaiKAiIV5TDuS2qBW6NW/yaRi1mooi7BepxHSN14KF/lQ9KDGBe4YcnYryI1Xnrq2KUD63QlQdnw0kaS0FrnCbqVwk+2xA7EblneEn4xsMEFCQY7ZqGXaKAux8tgFYwRBcs8G6Gt0cDNeNIGNF94sCx9/TiXgEsROnHSGBw8Eiz1H3AFoJxUc+3GNGmenEKuJpO8unfXNVgRsDlIxVg+rfdh3TI+pMyMTSKCawKq6WERJ62mHp4AwDtvUsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyqXdSOv27XG+rJmxrrYx12gBBZ+2go+ltU0KEkdNTg=;
 b=BPOy6KPh4UkrzVQR8mitWyr+cm2dbO7uodeoGOfeEq1kF+uQM+e1Pa4ajn2jdr9bnyGffa08YlGUps3fqYfnziU2edy8TpgMj3P7xi7ygAuM3SK6mP9bhLxyLWnM0sc/lCzVL4pKZKAq1hn4DbMDWlg8IgIv10vJakiDcrXLCcslOnf99unLCNWSc4EZpS2oIbu68hD+2/0xtBNezZ/T/c1T0bK4Hj0LfXbJKmAOzDWwtnvaioid/ZVl6CFw71Pa4HgF9JwyZq/UQq2qYNguicxc9ixnhUuVNBzKFar8dSW7wMCTNlkvfVWDWQUB5bI4wOe4W0P3owg4sMrH+A2JFA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 22:20:13 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 22:20:12 +0000
Date: Tue, 20 Oct 2026 18:20:09 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>, qiang.zhang@linux.dev,
	boqun@kernel.org, frederic@kernel.org, linux-kernel@vger.kernel.org,
	neeraj.upadhyay@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcutorture: Fix suspicious rcu_dereference_check() usage
 for trivial-preempt
Message-ID: <20261020222009.GA1111073@joelbox>
References: <20261020094907.15781-1-qiang.zhang@linux.dev>
 <BD9E8AED-23DC-4A7E-86E9-297B8FE29846@mainlining.org>
 <3280ed4e-2fc0-4eef-b6b9-234bf4acce58@paulmck-laptop>
 <37881d14-7efe-4e03-8a92-6bd80c82b52f@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37881d14-7efe-4e03-8a92-6bd80c82b52f@paulmck-laptop>
X-ClientProxiedBy: CH0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:610:e5::8) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0751e5-4787-4149-ccee-08df2ef84f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|22082099003|11063799006|4143699003|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mZltA0chVVrJXGE89UGzemk57XLf8qDZfRYUAK8zf+1eJ6Gjbb11TuWM9GmBClIkBYTCsmP8ixSSco4SvTfaESwlLmjIL5AXlenjJsvMtbAtaSwcty962cRx1nE59t1+i7R3NPQNisnTHabwU6xGMS1bjURzASAXDjIagofKijSk8GHymx/R3O4xDC4mwaOBsuEDZFWxbU9li5gFMndQdYCoVNUwZY9a+zkqbw0dsGZiRIcRyeZlqqSCRx2T53/K/pCG4ZZcgknn+le6lZJXuOGlgJU82jmkd5veQXbefLJK7lt+TcCSM9QgrkUIsnZEBulIbD5/yaRKbcffLEZ6SQE6LxIarx0KANBVXTSuEIf6CNPlSe9Rb89EyYv5GoEqadghhorXCeytKz/viJ8YsanbZ5ynHpsJ3GDo7G9RjBru0PiQc3uGNI0m0/mXu+kW1wWEvhRIKkKtWReHa44yTeNGEv6qO7k1KFp6qYa/OOYk/Rxqd4yhpysnpIT/rziKZ7GhAKfb9/UA7ox/E778xbjJOiM0n3TBUeFJVUn3gEoRAo0Sj7ksN1HxgGbHRAX4hDVq6WPDjetcGIdSrOm2L5rF/k1eSbNg0TRk9aGZwStpfrXPJnCnEb7rIyams0BXmqKavfmcyVu7klWYRGnKUUxNY9gcGrzyU0lTh1/6AB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kfVLdRYKZuNVv05bvaBIO3C3KLhlgD2e9Ec8wyk7lu1Qrsw05nGa+T9NA+IP?=
 =?us-ascii?Q?PbNlqJjueHlM5FQbqbOhZ3jCWZA76pSRWFLeaUDYqdQfxFcnGs2o5OW2MvJ3?=
 =?us-ascii?Q?62AxgqO/ojv8vkNFvptiwnoTJvZgFrOTqiF5UWi7SqhjqD3Y4AbVgt9Z8zDJ?=
 =?us-ascii?Q?ztCe3QKsQgRtE3r1Bl+ey4jYLnD7yJHkb0HrKC+Ae/kfdqP7fa0wlsBsOifp?=
 =?us-ascii?Q?0ESjEBE7Y3GG8oT3z47B0jcfIIL9wqCM88GQX1WFgWc0cqSk/Oef5ZKMiJg7?=
 =?us-ascii?Q?752gpTtpHtjz8yo4YB2Cizo+zjk+Py9tFGvJkbvPDJ48lZ2zFcRRZ7BZSjnU?=
 =?us-ascii?Q?zMGttJI0ySZ8qm/3h8UTOhXOX6oN1guAOl/JaNTuXzVhRN0OsO/pd6A0cBhc?=
 =?us-ascii?Q?cDeyJpEM8OZZCsqRvJhRY4bR9hlUAAwlun/1dMJLS3kD8OHK19nX4x1ycFyy?=
 =?us-ascii?Q?twqHzKRA5MfF3XGpo4DTyFATXzCPHA2sNqQ4Bfxxinl3u9/KL5Dby82cl/MN?=
 =?us-ascii?Q?+QOvvOXxHoA6sLdfnW8O++t2h/hUMhTILSdc7JgLxGAkr6Gxk/6qTAq+gnhK?=
 =?us-ascii?Q?PaXRu2zKD6G3PV77JHy9kTQMDl1TMtrA/zDTCVxkWoiIMUO0NGBNAWQDuuo2?=
 =?us-ascii?Q?VN+oabcPCpSN2aDjYkMQI64vCAh+4DAJihnEopcZsgVL8CYu35/ku1dMJtg5?=
 =?us-ascii?Q?bnEEI12T7sdN8/Pi1OsY47GkWoFzyzdR7l2ghdOITKReY99gUv/KZFAwMtZj?=
 =?us-ascii?Q?vZ3A5zEAA3RK2xQz7yyzEj1pievlsDKvE1tkT+V0BLbDGsh6gTSe+cnh/UgV?=
 =?us-ascii?Q?WzCqij+bFUiJBzsSmy3Uq/gm1eUJuDwe+obgofhjePaL2cfpT9jcVPxlfShc?=
 =?us-ascii?Q?9yd3wdg7AUHQ+IOuSiA0YhUd7j4lVxQNOeyxJzTg0Q7+T8CgUGh0f8A0n/EO?=
 =?us-ascii?Q?6c2yzGGQ+GppsZW37I0Lwg0xmfHUsu+6lJ45LRgwLFMEy951tcZLmaNHa+++?=
 =?us-ascii?Q?whUdNTpecxnnikMnzd7S1zyzux+9tseRrD5+YnxeVLKgLC6HuXW3ZmRptQn9?=
 =?us-ascii?Q?8+DiTUz5PUZq6xAur+8is6VEhiIHKv7ui+z6z+nN0yAV5ZK6JTWkFG/MrM/w?=
 =?us-ascii?Q?Cth5uX/wDw4/T6D/e+ZhkPlPge5KPsTBfRRuruarAG58wMGM//eKKBWEQHcD?=
 =?us-ascii?Q?ox45gxhS43wu+2PUIddRY1/iDnQX1soXO+CXc05RJpBwfB0qETThJYAsBYDO?=
 =?us-ascii?Q?ZPHGnqCOeRIktXytL8S7776aFMu6doRgkQlRaB1OQivJ8JKO6VfYtBuMbv5D?=
 =?us-ascii?Q?jTFBnqOjcO/xCb0o6E2LHKKkynmRsyi/OjXsFjpmBlqsa4glUWs78t3KgeKV?=
 =?us-ascii?Q?0xyl+OcnxrE0j6XUpxKuk52jZvbzz6cUzxtonzW+bTJCOmfcN0m3iDgZJ6Ou?=
 =?us-ascii?Q?LlpBgxj01jko+2mlkQ7YWyMdIqCmYib6BqrO/szrocuXA5GHKoKBp7pPelwO?=
 =?us-ascii?Q?s008oDX9AUqTocHnmjNkFwweNCQZUm6Y31zaAW0Rb7fARbzfe7nQHKx2731P?=
 =?us-ascii?Q?3E7IAAiyyaG1w7ffYTtkfP1YIrRQrt55lWYTnmhPrJGabMDFV6TDJrcLbjgz?=
 =?us-ascii?Q?vj0wuTyTpgL1mpADTkSBIqy3nwVzJTWztjMWta2FEDWSImrURhKRz5z0NjeQ?=
 =?us-ascii?Q?p20vIhB1/SQnQJO4nx/wUGmznKEy3kDbXJEzAQwzQNWh1nucBR/4fiazqAP/?=
 =?us-ascii?Q?5llJDLQQ2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0751e5-4787-4149-ccee-08df2ef84f36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 22:20:12.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlZ50GDUj+oK2RGtmV5QL6MGirX9M2RXl/DwV99NYntS58zc7+EFU6xbbo+fu0Y2AQA8kZHNfmazfiuTE2XJUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900

On Tue, Oct 20, 2026 at 03:03:27PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 20, 2026 at 03:01:27PM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 20, 2026 at 04:06:49PM +0100, Bradley Morgan wrote:
> > > On 20 October 2026 10:49:07 BST, Zqiang <qiang.zhang@linux.dev> wrote:
> > > >Running the trivial-preempt flavor triggers a lockdep "suspicious RCU
> > > >usage" warning from rcu_torture_one_read_start():
> > > >
> > > >WARNING: suspicious RCU usage
> > > >kernel/rcu/rcutorture.c:2581 suspicious rcu_dereference_check() usage!
> > > >...
> > > >lockdep_rcu_suspicious
> > > >rcu_torture_one_read_start
> > > >rcu_torture_one_read
> > > >rcu_torture_reader
> > > >
> > > >The trivial-preempt flavor .readlock_held is set to
> > > >torture_readlock_not_held(),
> > > >which check RCU-bh/RCU-sched critical sections. however, it's read lock
> > > >just increments current->rcu_trivial_preempt_nesting, it's not also RCU
> > > >read critical sections. the rcu_dereference_check() condition is therefore
> > > >false, and lockdep report warnings. this commit therefore drop
> > > >.readlock_held
> > > >callback to avoid this lockdep warnings.
> > > >
> > > >Fixes: c6f4e552e1ea ("rcutorture: Add a textbook-style trivial preemptible RCU")
> > > 
> > > Looks ok to me.
> > > 
> > > Reviewed-by: Bradley Morgan <brads@mainlining.org>
> > > 
> > > >Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > 
> > And it works here, thank you both.  I have queued this, and thank you
> > Zqiang for thinking to test trivial-preempt with lockdep enabled!
> 
> Wait, Joel is doing the next merge window, not me!
> 
> Joel, please make that be:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> I will drop it from my tree, apologies for my confusion!

Applied for 7.5 for further testing, thanks!

thanks,

Joel Fernandes

