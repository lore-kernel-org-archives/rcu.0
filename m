Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665E377EDE;
	Mon, 23 Mar 2026 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300202; cv=fail; b=iwgTl3cIlqcWrBGrSWSja7CCJc5Py9tsuUjI7YPpgit4IxuiHcreJib9sD96OaRgRHi41G+3qsXFYNNBYPkW5MeGP3GIEcn+Ev6dp8EUltbXezjIygLXFA4QpdBPofiB9XrmuGlU2LZRACkw8zftLrhQ+Y6cy71rpPgFVQ043Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300202; c=relaxed/simple;
	bh=UcxRPOF+xkf9IDOw2kdAeMFb6bBluIHJGTfRPTIitAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HgtUCC3jIPN8aWvQ5xo+7jA9st1+wCBp5fKcvTRyc0qkwu7hVKkCrW60a/wbIHFgszLVVxAYqu9lNh8+FaYdDbKLB4w/BbzMbjVWpDywiHplZbImc8zUxOGwdBK2HJfs4X+XMFaBW+4MiJ6avh/8I/1ku6XewOjLVXOvVvkyBhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+A3upuH; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+A3upuH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f224SMyhWlvU7NnM1zjduzIDhVI7vkkG38PX242/1un3XmC/5GgKucS5u/4PVDUGirVZK5+cOYys9Ec+Stz6RECHOh6NdHhoA+zsRIVuDhFgLwLqBmHeZkrtOyGdIxT8mh7xhWndma43WlEUEThnicEPEV89TuXCb66bD94fImXBUpCGDVbIXzC8EnQq7YK47Em9bBgw8Gu5wRAhhxSfcCzGjfe32q071Zg2ZQDuHwvveMlcSD/68QDourXlnzYlZjFRxKRwqBaPa0edeh0BPmfcxW1LQw2wUI3pBNS3xUg0j9ORo90AJJg7fAk+pSk0qyqWg7bnOAfSOUFlvA8ycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9xNNhwQTTAvpxVkTMrP/X4nLcxChZniZ6+TewJAl9U=;
 b=urw26vq97ga1xjmN7qamOOyf7o2GMa1izaOI6T1bApUoP0LMVUxCL36TvIpiDttMEwixkxYUPIQK9lZdrt+i2HVz9kDzMUga49z4e+VDwva+eWWtVT8XlqRcDk5Px2l4gLxzTIxW27vmxjYbGZ8UjekafHCR6GMF/68qtR3dS2A30hnz0XGewUv4wtrvcDIn4H5qzKqD9lWJUurAiIUbC9Czjk6FCEsQCILDtqtM70OmkchDG8RwmiU7+KrDwWQs4rjLJ60zQ3OenSbpvOp3GrWGf6Y79eZ6cJ/IN3+vEYL6NjZZQGrf3BpPtjwRX5wFQsSZOcSvpJOGzM8zc9tH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9xNNhwQTTAvpxVkTMrP/X4nLcxChZniZ6+TewJAl9U=;
 b=c+A3upuHx52x/6HBbzy2Ggm5CfLXxYZAleFRtHhttHXJwM1pRLqvPnehHqFboLoeXzD0OSXrx6G9ELq7WZQjKr7SGwnfHZUuv9FrlC/SxwJUE/XFktfvBLPtxcceEv4uswLjBcybYrPud/53q8NgHk9MHRqXO2A/pvRqAtyZ3o35FBb2feoYa4yt0PCm6NLvCN58d/MjPVKpW3rFiiVCqxs+FOz762GfmpxowGafCMKkHr3wzvMtzKYiFLMzjb0PdM/+fLHzlDvhH34D5DIQDPbIYT11cZoHVnSKGHDZeMgMJcuMZCe0pkt/jhYL5DbiG8i6Zx2Yy2oNxsP/t7eC0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Mon, 23 Mar 2026 21:09:56 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 21:09:56 +0000
Message-ID: <8fb6b64c-5c75-4b42-8abd-8e85173710a5@nvidia.com>
Date: Mon, 23 Mar 2026 17:09:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
To: Boqun Feng <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Zqiang <qiang.zhang@linux.dev>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260320222916.19987-1-boqun@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0242.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc9ba61-6f3d-4c84-1188-08de892088d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NToEF96GEqn6fJ2GVm8kxvj3eJ2yvWR+k5x61D91T9MxOiQcfqMX9jmumiIsPUhWlXiCu5U94/tnQ6rUB6nIfNMoS8PjbFIZWpAahGyIhZQJFLDS0DZ8qh+puKj8Qy7TQACHfgfeIPrfey3PQK2Y7hvn7fpcJ5/kqGxofT0w8os0fJU6neW1kF6gaPr+rfbqk5WVj6TF6R3B03I3lojhS44QwU267clzkhFWw6fbBdy87kCfwkPOgZoPnx5Xd4iM/YKXOWCZcDbCsOob7Sbaa2kNd9n1NcIaltkv+Ib3hpVyzVG/8MNcnGjfpfAfz/l/LRa+fqz5KYpGQCw1Ovda7EZ1pd/89pX5IT3L1YZ0aiMLjaetiXJYzf7gz7H5Dq1mKPa6Kyy2zlD+x/BK2zwFHZm88y5ReCIvZeVAwaPh13BM0OL7jki9fdGTMRa1CQaxryiZ5aT9nQRH0rUZTwMuvFMiR6pRPWYdON/aclzLvJf4qvlOnq8GPvRB2BQFf1e4aDh40lIcyXwS3lnToqXr/840781r+K6BjwkJuuiu37BMT2GKQKnzNUeegvLLjM0fJQJyPYPJozC9kKLsSajz4lRHezdDXKERwQ7igOHKYVDnBEkazB3ZotEaL8mERlSFVVLfdsF6M0iX0x+1qcSpjRcOTGCaCThEHnrox4VZ2kwXbVO8NqDQ/PTfcvPJ87qsnyc3Hr3Pk+VX9yKXwJMPuEYlDbppnPclmRJ+kxUPE3kTcJXOu0vcK/3/7e6zFpTQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2lKYk5kNzdkTlRMZnhhRHNHMGlLTWk5SnV1WHZ5TjlyY1YwNG1sM2l4QUFR?=
 =?utf-8?B?dTFSTlFIVW5zOE1YMkcrdmhDYkVQUEoyaldoNlgwK3Z3SWYwSWFzRU92V29H?=
 =?utf-8?B?bytZcmkzVjRDYXNWTUpsVFpzQ2RYYTU2YWdNa3dCWjk1TE13NU9CcVRGS1ZT?=
 =?utf-8?B?ckgyUXFMV0hkZDNadFpFcmpISlVzcUtjQnp6VWdNZVB4RUdJN3dyM1dWNU1X?=
 =?utf-8?B?bnRrTGdkZzdtMGFLVFJ1djFHenhsVVdOU2dYdmprUStKejkyZjE3NGEyY1NR?=
 =?utf-8?B?SytaWStjQllIZmNGZy95NGN1Mk0vdm5uakhoUzc3Yyt6Nk5OODVWbnNCUzUv?=
 =?utf-8?B?V0YzQ0p6M0Z5Ny9XVCtwU29OWlZONDBJMVlNTDlqN3R0eDdlV1psSFZFSkk2?=
 =?utf-8?B?eFludmNUcEZPNTlmMmYzS1NnejRQaEhjSzQwbk40M1RiRWk0dnJPQ3hiOEZy?=
 =?utf-8?B?RUFnazNrL1l6UndKV3IwYkExcENOVmtUN3MvbXIwcWVhNk1kdDd5c2dNMjJj?=
 =?utf-8?B?Lzc0ZStwTGxIb3oyc3pQZ0MzTWd1Szl2YUM3TU1vOXBMcVJZeVc0S1NaOVJR?=
 =?utf-8?B?R0ZwL3dxZHllZWxBT1lyaTdaRmVrc2tOOXRYZEJ3dHM4ZmhXY0V6R2dIczFQ?=
 =?utf-8?B?NmZ4Wk8rWjJTUDdVTFdFQjNFOC9LQWsrNEJJeWJUeG0wL3ptZGIxS0gydTho?=
 =?utf-8?B?STRtdWpmVWZyZXlXb041YTZubUh1RmpJQ1ZLV2o2Nzd1R1FPZG9DSE9xbHcv?=
 =?utf-8?B?Yy9rbHA5WnZ5UFhpTjBNNmtnOWRRTDU0SnpnaGFPcUlWaHNoekYxbTNNekNy?=
 =?utf-8?B?a1J1ekxQbnEvWVNKYmQwVHY0Q2xsQm8zSXl2bG4yWnNTK1NPVVJ4K05Qci9k?=
 =?utf-8?B?dkV3c0FSazgxUmN5czlLcEhjTGlRWW1WYTBUdEs1d2dEd0lMZHFqNXJ0czhZ?=
 =?utf-8?B?d3crRGdnNXh5MjZKNmhWbnZONEV3OHR6UnJPT0czaUNzUzVrMktwV3c2cEFU?=
 =?utf-8?B?Sk0rNTJkR3A0a3BwNTUrSTY3dzB6UDlnS0wzdDc3MFNScVVPMnhBOXF6eUFz?=
 =?utf-8?B?WHp2SEpwbUhEZjJCYlRMN3VVWWtDSmdpRWdLbXlOVy80Z3NncXE2STc1eWZR?=
 =?utf-8?B?bFg5NkxFTXExbzdsaGgyZ0kwZDVjTmtldE9sWEtwR2pWSjJvQnE3VC9XbHIz?=
 =?utf-8?B?cHJpZDBaQzZLTEx2NzdMT2pmQUhycWhXUGtKUWhzdlRzM1J5VUxWSGhuRWFp?=
 =?utf-8?B?K216S1BCS1o5eDNIZ1pnZjNVQjNIQ2FHdkZCZU0vS3dQeUlpYWF3bGU1Rk5j?=
 =?utf-8?B?NldmUC8xVVljb3RDUzdFMkUxeWdsbjRzSGtKRkxSYWNKdGs3aFdXMFkrZStS?=
 =?utf-8?B?SUIxZ3ZGMVVsMURoUjJ3WEZvbEkya2VxeXNwbzR4Z0Vmek92aExTcnNIZFBs?=
 =?utf-8?B?SXB3WEFSSkhDWkNOSytEc2RxVHU4Y2FXUlNSUDFPUjUranVIeG9FVzArMjhY?=
 =?utf-8?B?ZzN4M1BtN0RINjA5NXZaNzB5STN1aitDSzNhMW83VDRjOW5SbFBUc05hOVFU?=
 =?utf-8?B?V0VPQ1F5ejIrZGJtdVJ3WTJ4ZzB3eDlkcWpMR3ZRcmVqMTBFWWZROUlCUktJ?=
 =?utf-8?B?bFlDUHBudFBhdWhKaG1vN2g4eGV1SnhKY05GaDh4ODdseldZMXJjQXlUV3VF?=
 =?utf-8?B?NmxiS3JYVVFEZDRTV2lpWDF2cHVFSkFYL2p4SEFPV25wSDM1WTI0Zk5SWXBJ?=
 =?utf-8?B?N0QrZzRLaTc3cjNROWtRTlg1QW92cWx4OFNIOVc0czYvVlFYT0UvQ0FsTUtB?=
 =?utf-8?B?WHRwVGFVME9jZWkzNG85dGlKTnJGeS9aM201WURScG9pbWZ2OXRJTm9YRWI1?=
 =?utf-8?B?dGJuU0FEVFZYOU5NdHlMeGlHRFpNb3l3ckhWM3lKZnA4QVU5RkwwdlppZUk3?=
 =?utf-8?B?eHg4Y0NqSU15TWgydnArTUZUb2FmR0llajRPOW12UXkwaVVFYmNEZi9BNFU4?=
 =?utf-8?B?SmJkR2V2MGdjZisydFVCUEIvNHZIWHVFZDBBOGh0MXBBcXZqK0xQMW0yWkdQ?=
 =?utf-8?B?aG5LQlArNy85UUdBMlF1K0QwbjdqTlNqV041aCszdm1jSkN0ODY4aUlSclVp?=
 =?utf-8?B?clU4Z1lOclNiYldQY2E0aC9ORGNqRVlBVkNFL1hwQlIyNkR0cVMvNEFkMGc2?=
 =?utf-8?B?b3plSU9ZVmJYeVI4WStFT28zL25LUjk4cjl1aVVKSzBoSUhIYno1S3RhUWJx?=
 =?utf-8?B?aG92RExENHlVeWtxVUcwUGtYQzJDZnpzaTN2eVlvK0tWcE04d2lwWTRNc3JT?=
 =?utf-8?B?bXM3SVhneG1HL2gxSS9Lcll6Y21rU3dDNVNPWEFaNU5KdDNqekVHUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc9ba61-6f3d-4c84-1188-08de892088d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 21:09:56.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/N4pTk6qwFP+uDWOIYzjoXSL1WOmL8qnKrhvT4Xjf09lV/jOc2/UXCPaJtTMMvMolYfTL7Oj71oiMa98kV21w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695



On 3/20/2026 6:29 PM, Boqun Feng wrote:
> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> happen basically everywhere (including where a scheduler lock is held),
> call_srcu() now needs to avoid acquiring scheduler lock because
> otherwise it could cause deadlock [1]. Fix this by following what the
> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> the work to start process_srcu().
> 
> [boqun: Apply Joel's feedback]
> [boqun: Apply Andrea's test feedback]
> 
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Tested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>

Tested-by: Joel Fernandes <joelagnelf@nvidia.com>

I have the following in the shared rcu tree rcu/dev branch, but if you're
sending it for 7.0 -rc cycle I will drop them:

998608c o rcu: Use an intermediate irq_work to start process_srcu()
15d921a o rcutorture: Test call_srcu() with preemption disabled and not

thanks,

-- 
Joel Fernandes

> ---
>  include/linux/srcutree.h |  1 +
>  kernel/rcu/srcutree.c    | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index dfb31d11ff05..be76fa4fc170 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -95,6 +95,7 @@ struct srcu_usage {
>  	unsigned long reschedule_jiffies;
>  	unsigned long reschedule_count;
>  	struct delayed_work work;
> +	struct irq_work irq_work;
>  	struct srcu_struct *srcu_ssp;
>  };
>  
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2328827f8775..e08aaacad695 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -19,6 +19,7 @@
>  #include <linux/mutex.h>
>  #include <linux/percpu.h>
>  #include <linux/preempt.h>
> +#include <linux/irq_work.h>
>  #include <linux/rcupdate_wait.h>
>  #include <linux/sched.h>
>  #include <linux/smp.h>
> @@ -75,6 +76,7 @@ static bool __read_mostly srcu_init_done;
>  static void srcu_invoke_callbacks(struct work_struct *work);
>  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
>  static void process_srcu(struct work_struct *work);
> +static void srcu_irq_work(struct irq_work *work);
>  static void srcu_delay_timer(struct timer_list *t);
>  
>  /*
> @@ -216,6 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
>  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
>  	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> +	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
>  	ssp->srcu_sup->sda_is_static = is_static;
>  	if (!is_static) {
>  		ssp->sda = alloc_percpu(struct srcu_data);
> @@ -713,6 +716,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>  		return; /* Just leak it! */
>  	if (WARN_ON(srcu_readers_active(ssp)))
>  		return; /* Just leak it! */
> +	/* Wait for irq_work to finish first as it may queue a new work. */
> +	irq_work_sync(&sup->irq_work);
>  	flush_delayed_work(&sup->work);
>  	for_each_possible_cpu(cpu) {
>  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> @@ -1118,9 +1123,13 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  		// it isn't.  And it does not have to be.  After all, it
>  		// can only be executed during early boot when there is only
>  		// the one boot CPU running with interrupts still disabled.
> +		//
> +		// Use an irq_work here to avoid acquiring runqueue lock with
> +		// srcu rcu_node::lock held. BPF instrument could introduce the
> +		// opposite dependency, hence we need to break the possible
> +		// locking dependency here.
>  		if (likely(srcu_init_done))
> -			queue_delayed_work(rcu_gp_wq, &sup->work,
> -					   !!srcu_get_delay(ssp));
> +			irq_work_queue(&sup->irq_work);
>  		else if (list_empty(&sup->work.work.entry))
>  			list_add(&sup->work.work.entry, &srcu_boot_list);
>  	}
> @@ -1979,6 +1988,23 @@ static void process_srcu(struct work_struct *work)
>  	srcu_reschedule(ssp, curdelay);
>  }
>  
> +static void srcu_irq_work(struct irq_work *work)
> +{
> +	struct srcu_struct *ssp;
> +	struct srcu_usage *sup;
> +	unsigned long delay;
> +	unsigned long flags;
> +
> +	sup = container_of(work, struct srcu_usage, irq_work);
> +	ssp = sup->srcu_ssp;
> +
> +	raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
> +	delay = srcu_get_delay(ssp);
> +	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
> +
> +	queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
> +}
> +
>  void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
>  			     unsigned long *gp_seq)
>  {

