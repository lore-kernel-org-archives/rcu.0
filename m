Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039363D3CF4;
	Wed, 25 Feb 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035218; cv=fail; b=T6kSA0Sce75/WXxKD4d8Y1Xc4lPODDnwb9waGgmUnl4WI7GabIcxieNJFJHSUGCLD051pnGVy5RBz3NFrzGB9vmQN8rYebiRTcvNOx5v2sJ24TfVWHhXOhfLzxh6cu2ngtT7cLqU7ZMSfp/aBA2GhCY0irYxy/1ySFtP87CwcFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035218; c=relaxed/simple;
	bh=5eXStQBf9zM0IPRK3ScmJm69CdZV+OSrFy9uHDSeL5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K8PNfGTQHIUIrXedJd25uSFNgWyAJGc3TdEdLXyDRVZYEM3W0o6pNwM7jb5LvEfFiI05D016oOlezK59K911Msqt8nglmZgSp7iD8xKz8Pn/777ZJMA6xVjROhZOb43CiyyYuOjn2UHAV2Rb84eThKkugd3R8y6LiAJfhqnkhkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HOi8dFyt; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HOi8dFyt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfU2h6SJbPTxO6BVLoEKUcQVo2nL7J0vOIxxjKtlgF6dNZvzj7jfVtyiFh+OlDgsQ/R/0SUARhpKABmfWzChQRSeicmxo5irr8yKbidLvmuxburXhJfEiR8cMeDujKvKBBsdBMb9lKm42p9S8EXZkL++yZ47wfDxuyaSJFoLknOJD2t6G5BowTTBHOmizf0gTCMBPq6tjIxGmgTHC7GdpqF21MOqULPtax9rGdiBGejDjT2JlgFW830zGoBzZAfnBefij4GtQ5TVMU4TJGH7QT/MNkaO3wSBUFZytRriEg4plKmKxXDi9biyVs06/Ill512YQwfGnp0RfhJf3So8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T798+nxSGgxFRxQk/V8WM70rFh8pC8siuED9/BJBrYQ=;
 b=anQ0Q0evxDQYhI02/duoSz6BhRxPZzw/zGD0ElMviBI+lNf+76mWE85reTsVg1/a47ZuHJeCf+upH5qFTux/AY5BJ0FVq7chEbtD6/8+g2jkday52c1UOg4ctK51bZ7OE6HIv1+SCLNvVUdB9mHZFEzIJFL2ysBGw5iioVCtv962J4kkdPceKBFJ17fNQcfxCPuiuZD9q/j8iA0+wDKtLX49g0Y+CfSrBUK6BtORTRdVyWzJ5iRzcX30YAwMWJzmZnp8o+2QORpEO2+kwqutHSooFm6LC8Qg5mqJ6HOEexopcV+m/xwn1lXozbHlT/tRnvgLBYfu+KgssiPFnbE+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T798+nxSGgxFRxQk/V8WM70rFh8pC8siuED9/BJBrYQ=;
 b=HOi8dFytbJ0faHZ3SnSfz65UNaCr+b2IbxJZ4xBc81Zd49ksdoBI6Ll0bKuFD2eW9wTosjbcTuEuUmN+yZ7BwdGL2E4kBuZxPlXZwi1Ufb52FUVi+gqp6YatL9oVGV06JOcY/FWcN6+o+IXmB0w6u4TeebnofsFG8vG2p8g6hUYfxjbqML/vaiE/C/vS7r4ne4I6t8eJAmJuvdDGJOJ5pRCHZEQQJ7YhiGX32J2vkulxcK68nl38aRR5iTgHBmn6zBiRbIZNyi/qCXyNFbHe35GC+DaQzZ71G4o4N0NfLX8zWlsDJAQH4i//gg2ykwI8Lhy60v1ID6TXYuXKkhOExw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Wed, 25 Feb 2026 16:00:09 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:00:09 +0000
Date: Wed, 25 Feb 2026 11:00:07 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu-tasks: Remove unnecessary smp_store_release() in
 cblist_init_generic()
Message-ID: <20260225160007.GA1186891@joelbox2>
References: <20260105011951.72850-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105011951.72850-1-qiang.zhang@linux.dev>
X-ClientProxiedBy: CY5PR22CA0072.namprd22.prod.outlook.com
 (2603:10b6:930:80::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1eb904-839f-455c-a656-08de7486f390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	AtN2M0C4oyQoDZhPZFIo/GlY8AZwJtmM91VKru8g2qEtCVYaE6axNQRKJ01YapbPkP/5ufwCG+JHiqAvlClmpkA4AvRwLvwhIHekjk03DQH+sbtAh7TNBCbQqnbdXAs/6IRoWZjOdxv2gusQ3dWH3kxM7lSr9iUUwyT1m9e+H48ddBGwu6LtZ3IFHgWr51todFUWwgvXgonGxkD7mWV9dSlsASu9HknRMCHuh7lsdFaQ1tMGjsp5RPRA/Gw/dEeCRbuXX/1BBIt2T3Adwi1V8CZdT7sqi/BUFtZ0MVOPj/WR9ZcP41Ya+MJ/cgouP/7HmwCjPPo7/7WC1yPEJft3O/dNlErhbAoZwCB+ccVOWiAC6tvS7SR77v3e/EBZ+UT1xhZE+1n5sSN92GmUqlLkbFNVhDgH25VrjVITlsGechcttE9uLPnzLCg9no8awDi/Yfxr+zE9CvLpryVnKz6B1baPXkBLBcbYGc4JlF7KlSq5dwCFyXsxyfdgtxhdtiEjggsPjMKil2xYnT5vzCVuCDG+mSFZYIgPWuipwTkicvtA6lCi5kaGCeAXEB5CemEI6E644LxGnb/bF+vSszFpjnOUYjOsmzOLzVjfMI5l/dVKQCl41mCMG7x32VqepRJlzvebel7J+IZavTEO8443H7/5yU+7vX7kBTvJY2XemROzpm/B8N+SpSkEN8f/k7tC6SlymycuZTHAiqSOpq+dAxlLBzS22Kz6Mzw8dLGssIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?56a0nFnTnfPeSUtnhzg7P805BMfbpteUnsQD/qchZS1NE7oNQ21EwXzu9YnR?=
 =?us-ascii?Q?Kk5n96YZEbthBs+LAmZGKA/vLxvULDOoVe942BbiCOnLBb6YIBF5JDxuADRi?=
 =?us-ascii?Q?F3sYpcPSWg/p4WPk3KE5+eXQX9v2K5Sg/WbO3np9lulyY+SL1gS9y618BEEl?=
 =?us-ascii?Q?hQRZRxGHjW2MiNhphFfrPp3vipgMZTiAJO9VyAsAq393alAtzBfL1p2+6+Y1?=
 =?us-ascii?Q?TYU9I2lpFP6dqZ4QLFFZ8LoieqltgJDdNlcRZ8UdHmyjSs2XnFF1yqLp3bLc?=
 =?us-ascii?Q?Ne/wU3LRtjkwEDt9AeoCU8hK8eo8phtY6tZ/qq9i06YyB5hVYBIuH3djgYE8?=
 =?us-ascii?Q?x5QAion8vzEtId4N9AU2+oud5HjBSiwo3lR07z6eCuq6qRivZb20/7VJm+6t?=
 =?us-ascii?Q?7GXdewre2Yr2SB3wjuB8gGbDJKCb00WU7M0MnvB6S4Py+Tt1n/roA6tF/YIw?=
 =?us-ascii?Q?WJs0N1E00GsmUGh2Rb1uveEaO/8SNAn6P6H5Z5CkPPrScZNABUA6/m1mLuNj?=
 =?us-ascii?Q?dlqkvwIbvcPFi/817yhUoJWOi1n9+l88I1CMXVWdGtHQ9dTV0nGedSowyGYs?=
 =?us-ascii?Q?lItWGLcweyAd2xYnrOnlHh9pS3yLKmO0VXHUXb1jovazIeQYwT+V0ADwuRph?=
 =?us-ascii?Q?fWOrpgoCV0LjXrj8pec4HECg84moq6fx9UznNQgn32tGWnbAqWcSqlCVF+ud?=
 =?us-ascii?Q?aMXDxevCMe2CCIAW47fe15P/TxQ4CDWdb+1RYE6SeQPJX26KNuHdw20vualL?=
 =?us-ascii?Q?ta4lWuS8KRSMbUR9bfBJEdCEbzMsIAk0ya6iQ9842jvcMvDL4/xTn/nZWVXN?=
 =?us-ascii?Q?LZQ7vgu4Hl8ZkErCO0A+gfZFkGHyX+poBzWTKdmimdeCg/aQ6sR7VAlUdqI4?=
 =?us-ascii?Q?fxnet8YWXgJd0vIUHVawko7xncLB9ElxiDawoASeSizx3Su8hh3zUntiOfnE?=
 =?us-ascii?Q?HgstW/VyT2ZM9u9zZCJoYf9Y0gN3nFwARXlb8J8/Gzo0Uod3ENzWphceY2cZ?=
 =?us-ascii?Q?Ks1u3imrJ4vYI41tNuE9q+HT9RDdkJaK/PbD6RKpfyosLOuqjSnX0vJEbFWk?=
 =?us-ascii?Q?POVljGqfuChLNl8jpeECIV8scmqrPX15VHlvnkUgU0YBNnF8T0Tra+h30kRD?=
 =?us-ascii?Q?V4hDB/61E9d+PEiPKJhqqDhnmnd7pZJiJ5HY6bs7DikZ9l4d/t8knisvkS9j?=
 =?us-ascii?Q?CgK3c5alAJ4wljoNy7dsMIjMICKZgKg+WgexOKvZ0RPApe2Uro9Cvzn+1KwN?=
 =?us-ascii?Q?yltKepYjwFeqoo3aUdXFnqR/0dBRF1TFVsUmF2sUz4leDUdhZqrdbhY+tu4Y?=
 =?us-ascii?Q?Mv3OBeH2rbrno9as5l7E28OXb8kkJ1WNG88qkuTSWB6bW/Rj/cxO1hwFnL6m?=
 =?us-ascii?Q?CrczhdeON9/aRKZPuWhbnbzvPTVpdnZuoz0hO4j3vzIhCzh+hDAasOpkZU7G?=
 =?us-ascii?Q?7A3643hI7hzPuhQ/K8OPNesEP1YZVJztH9gfRq8PrGhcGi/8hxi+XxLaXoJ/?=
 =?us-ascii?Q?13XbPEQYGcE5dMSYitMU567c/EgH/0Xenvw4jBSC8r6nypuIzrhtEwjJa71r?=
 =?us-ascii?Q?nhY0XUdAPjFjXXf0SDM1pQQBYrN/T9UNXWrofnicQXm6Do4DGKCoLjaY5YQC?=
 =?us-ascii?Q?1K6dZPBeO+rCeSkMjyvCIu9Z2CvvMdBuMe2N+3kc8QeUnrT4MkITrceOoFvY?=
 =?us-ascii?Q?5o1utSEQ3z94w7Ch5tDH14BOCWqUKsMVOlESL5mQmbPfM3g1cjmOsgsx8gRV?=
 =?us-ascii?Q?1r7+TjDTBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1eb904-839f-455c-a656-08de7486f390
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:00:09.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeHh12OKixPCm0tWa8kWFVMtlCx5DKCinCivOwBZ9RUsNI2gBvruUq5h8cGAo+TWPrydF5POhza/pYi1M9D9vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818

On Mon, Jan 05, 2026 at 09:19:51AM +0800, Zqiang wrote:
> The cblist_init_generic() is executed during the CPU early boot
> phase due to commit:30ef09635b9e ("rcu-tasks: Initialize callback
> lists at rcu_init() time"), at this time, only one boot CPU is
> online and the irq is disabled. this commit therefore use routine
> assignment replace of smp_store_release() and WRITE_ONCE() in the
> cblist_init_generic().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Applied for 7.1 with Paul's tag. Thanks!

--
Joel Fernandes


> ---
>  kernel/rcu/tasks.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 76f952196a29..c736900317cd 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -290,9 +290,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  	shift = ilog2(rcu_task_cpu_ids / lim);
>  	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
>  		shift++;
> -	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> -	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> -	smp_store_release(&rtp->percpu_enqueue_lim, lim);
> +	rtp->percpu_enqueue_shift = shift;
> +	rtp->percpu_dequeue_lim = lim;
> +	rtp->percpu_enqueue_lim = lim;
>  
>  	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
>  			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
> -- 
> 2.48.1
> 
