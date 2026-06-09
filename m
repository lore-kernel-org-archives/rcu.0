Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA03E51D2
	for <rcu@vger.kernel.org>; Tue,  9 Jun 2026 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992437; cv=fail; b=nZ7H3yG5QvPFBLuW/G1lXN85vfC3gqMWmC6M23+nZ7qZ7uoLYJP7nuB5k8AKtm9ZGajcOlgkNIEGnNfNUFKf3Safx/DfuFm89Ofen2EnU7UqCXjpDgj7yzysYqptLuwM/5nzfeMhvnBigu/Cs56ET17KW5M2p9oiqbseBR9az88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992437; c=relaxed/simple;
	bh=0zXFv6/jE1I68vNd/Y4cmlEjkKiJWzC60x9xVmCspnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QRWLKV0Wvj5AusuXVHpHFOdTZO8bpVhtlofhhPME+2k3Jia0ZPAvIgyRFqlZKzbUwKdHpR3zZmvHP4M08isLl5FBGngUqwWRtclfanDXqSKVDNt5fKIneB9H742TIGbVnPgk8Ss1qGYOOTnjPCVQi0nYHVdSW6Rgg81H7ju/gwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GAUxy346; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GAUxy346"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps19qMKMLBepvoLHjBretG7vdjUoiQJjQtgv8WIzPP+HhhXhfauSXENY4ZWWQMyGdC0DauyRDI5Jh8Af8AC1VMIts+h0S+z3kp1KbRNIEUpK7xi2BvFygfllg3+4WDx8/00WXkqTc0AUiaMpqIFklssoPCD7TnFOVPaMenTSCKPorJcYLPAoCpNwdBBD/U2XCY/AB+LtZtv6Wz3EInGDoKDfLiu2hk3eMp2/ur79DqsVdusEIH4ba2GEAV2pvp6eRbBbn44libIbharL6X3a1ulzBMp+aKHSDntXVwX0xW3P7/b4/MY1/G2TqF1bR1pSI28szhZShNKBfJqIQ/7iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEWEHCSSzzABXRJ8VdxkLVbNY4di0T1qmzl6Grn07hE=;
 b=Duly+BIkeygzyqV4nvVvxdKktS9kMA7on2KycfQOdXqZc67I/j4+W1eWIOPyoqAdUeAHgtUigaldnnFPOB3cK08l3N9X/8tFwkA0vdQRv5KhIaTSJZrOu81ACLrOZvFSXlW5oY8G1a+EsEOdEbCYRS0Q/Cs6Hf4B5i6jQ8tGVWpPRCbyQGaoMN9B9+eqOIU9PJyOlCPxYG1a4E1m8WPp/zYo3fSHpSSHq15nfyl7suez8e4jqRD29da6i6PvgIRuIGswbc+ogeqYziZAztc4LpaivVHUbHJ1wV//HnFi+fi/RLSHkHJUNuJm3D+Bky9RibPfWb+rVkhB5odnoo5hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEWEHCSSzzABXRJ8VdxkLVbNY4di0T1qmzl6Grn07hE=;
 b=GAUxy346DBFstRmqrjofbm7SyqsAVy/H/ichaZTZ6aAXbQovAIzjTWL2Q3Ufggm/zQLx9smYGfvZdLaq2omwIP2O6nnSkF8r53HTmQ6z3YY+EkOYHx8hbUWD4f4ChfmzOX16Hpn8jMX1Q8XzYSLarVhS/Q96UDwyCzKgmAEYGP779x1/A/guFzL/2e4XtTq3sIFsB2uZaSCMYYlnchhoCHf1f58NtLBeaEwMcBMSzS+POndXyvsFi93+Pi6XGF/DJIuNpXU4qu8IZJd1J1aR/9utjaHweDR1djdZQlJDZouGi+CmqGvabxd95RPRe9MN1GaQ47rwLPrQ9BPITyyuzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 08:07:11 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:07:11 +0000
Date: Tue, 9 Jun 2026 10:06:58 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>, rcu@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <aifJookTje68036x@gpd4>
References: <20260531152646.1206799-1-yphbchou0911@gmail.com>
 <20260531152646.1206799-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531152646.1206799-3-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1PEPF000008CC.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::43a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a313220-bdf6-4e57-5cbc-08dec5fe1b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|4143699003|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ydE3yzWCTf/WWB8F77mZeJLTWzMzpPnLzBB3Ul1x31dsoAumaAarykAM6fe22OMCMjsMQz0VObS60ZnmC4scZgADEpX+7fgVJpyezelO4pKW6PpzQymazYz2Z+OnKQefsvAxvrxs3ugVw9Zo46SKQgR3takoIb0SGVYIuQrxfFBfYbzlTt0ybUT97xLzTiuUUzfqk+5OQHCpxGza5VkIOgbr5lmzUE2/mWxrjUu+7Z74DkE084tZ7ipQgNYcmt0GMdU+DuzZFGItp5pziCn3e764FnpW2f6yu1NaL0WjcZtlCTQszvo6nsDrxYW/6gGS77smlWnzHOUhCaog8qOadb/4/5yDbmfV47oSxlPp4qp5cabq+LpL/p0MXmM0fR7raB/dnU00jmSf/G4EY+dC+yv1D9dUsOBt7keokTgC/wI4IhP9y1CJfB7GLoeYN0TjGRM1mZuAQesOPB63qQ3b0KwMAaEk1GFIeqe/STSFTJz1LrMufFpy6cb0yHcRa3K9t+DuODLrz7cSXNWEfXyN+lIaLlBQJW4nBio737zsSRUEE3kUPLmUiXce1Rw5K4REayRfSTGy5kSTgqB6TWMCsR/18+UASbUkDkiYjCjmZr4Fo3s+KFjlj91LR9z9onevVi1S3l/Vm7jbYpOHt/0N+msnu7UBYdaVfOUBtpGifmCOyrFThP+l9FC5zAvZHvim
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iu/80izzZSW857pMkc4c7p07Abd5GoOz+8LP7+PADtsA8MXqraE6wg7I/J3J?=
 =?us-ascii?Q?60uaImJjbIhn1IN0qv223A/H5YH+tnFJtEEmg5B+m9ejwUPdTyTwiLguF4fe?=
 =?us-ascii?Q?QM0qGPmct4JnNKeTFMpHTnWSvs/FnbROXuYF47FGNoQoNcGl6MDD16Y6/9RK?=
 =?us-ascii?Q?rd/a4FNItZddj+VeVK6GpiE7uNaW+1mPryLVtiXFD1TZPndROOq6BYt7ysQj?=
 =?us-ascii?Q?flYBDWhg4aTHfv1cIX9HpEbpFvEL5f52CEa9b76lODse0WXaI7WvEP1RGZsc?=
 =?us-ascii?Q?QcPKkW5t+RhvenxgR96tMkd5qeRPNiGHZOAWOrW3AkfVf3c1I7wv2MCaq4aj?=
 =?us-ascii?Q?JKYLt3tvcuPvX/2GHabKcQXx8NjdBcbWXB6A5M8TqS9FyG8N8vOQEQDZh11s?=
 =?us-ascii?Q?gJkiQQN6kNsY8b6h970hQUSjRgdifEgTu58GMuNuWsEQvHrHsElnmM3Q/SuM?=
 =?us-ascii?Q?CYP3MgZN+0hE5fhPamtSst46lwQ8IqN1CSkRp8Ea3Eijyxo2ZkXAsoPNYY1+?=
 =?us-ascii?Q?+UzrEL9QBHWEo6p0u2bVg9cvAZZZFpi/cDbJTvWKqhf21QuN9OAku3SACG8M?=
 =?us-ascii?Q?R9vGg3DPYteUV9v5YYnqny/JGzwprJKtvcvY2TFS3SIdEYqaJxAfQam0yAuI?=
 =?us-ascii?Q?qkXdpkiXsHoi5Wmd7wvYpTQr+x8GcUZ294eyZcL3gDfE3kfmQ5ObeDQZbZ9S?=
 =?us-ascii?Q?WJepYoxtMvzbB7L5ePhQSxNLds5L36YZe39cJQULsWouPP6Qv3PBOGx/aV0T?=
 =?us-ascii?Q?Bnrv/fFzxHIk2b+iPOSQA+R+7N2SSyK1Av9ExKuTMHfjRwtyJC2YFhgGFLRq?=
 =?us-ascii?Q?BxHnwbNxS7McKw8E/f9FZ0qY3EFQTimnPvdxq/pVtInV1Us0ghtNPaLB2s4k?=
 =?us-ascii?Q?5B7NtdVRtTr/+D1/VXH2gG4JzpUyd25hyvaK8+1+98rIxss0wOn3rM+8meeV?=
 =?us-ascii?Q?BHZXXpDUBmzI3BD2El81OUwixgLK4kNhnK/3PGkNPgEal6guBuohy8OSXI2a?=
 =?us-ascii?Q?3RyaGKliQIvRDrdOptC9utcsFlZe1noGu90zdv7dMU0uhd0HkmJ0WWivs0f1?=
 =?us-ascii?Q?DnZddexB7rdtYtT/s2gbFEEIxN6NiHw1vETmAxz7A0Vqmcq4QOoimbmCtLth?=
 =?us-ascii?Q?YsUAuidlvzviV/dSBU9pNPLHFLI41fZaHpgCYRrI3KmocKHjO8eZKqHYqxWp?=
 =?us-ascii?Q?GrMxd8AT5DMG4iUgvEsrYyjwyx+HDre9Hvm/2jUAWj4p5MvZtjBazajrSZqN?=
 =?us-ascii?Q?L1Ul6OdemzZpAFbUzJITa0PF/UbDgCXw4OYn8I3nK/EognXOg1Sr3iXLs4oO?=
 =?us-ascii?Q?VUgnOlXRGUZ3SDOtgJsS7S/NHRwJNWI2gARjg9JCmurI8sKB3V6P3ermTiYZ?=
 =?us-ascii?Q?sIarwlQpYK66spy05nH9Lwefmht7EpwoFNIXcdOCBemuPk1lS061vhEYkeFX?=
 =?us-ascii?Q?1gGr4fh0CtEMdglL2wBTm6ir1FlXWSNJauSW8/T/2GYatR13HGZ0rt3nUqlU?=
 =?us-ascii?Q?tacyWKXxYcNYAj0dLK0SJqVqoYM0tI9Df93wjurE1Ti8VbvaxIPEUAcfkkFe?=
 =?us-ascii?Q?Memv+T5lJKPzbNg9uk1n68GSJd03fVTvTXoKj6ZG4wGbm3DIOpJxG+5dTSBJ?=
 =?us-ascii?Q?3QYMBORrry812zlOVT4ZC4tKj9txgVddVI6yKnXYfvaRZOADAFO+jefvXPrT?=
 =?us-ascii?Q?s5vxyxLFhI5hUr0iqPtdOTMt7twBXfqABtF2sh5Yzh7tVE+P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a313220-bdf6-4e57-5cbc-08dec5fe1b65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:07:10.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6e83vfpPTg51picVtwr7SyIzpIBNxYVhYucU5VYZ+4qykpawtXz9vAX5RDquf7QaeWUJZnM7vmgyfDgLXMELw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

Hi Cheng-Yang,

On Sun, May 31, 2026 at 11:25:27PM +0800, Cheng-Yang Chou wrote:
> scx_rcu_cpu_stall() previously recorded the detector CPU rather than the
> stalled one, and the expedited grace period path had no stalled CPU to
> report at all.
> 
> Thread a cpumask through panic_on_rcu_stall() and scx_rcu_cpu_stall()
> to capture all stalled CPUs. Report cpumask_first() as exit_cpu and the
> full CPU list in the exit message. Task-only stalls yield exit_cpu = -1.
> 
> Store the stall mask in scx_sched rather than scx_exit_info, keeping the
> BPF-visible struct unchanged. scx_dump_state() reads sch->stall_cpus
> directly and dumps all stalled CPUs first to avoid losing them to
> truncation.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Looks good from a sched_ext perspective.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  include/linux/sched/ext.h   |  4 +-
>  kernel/rcu/tree.c           |  3 ++
>  kernel/rcu/tree_exp.h       |  5 ++-
>  kernel/rcu/tree_stall.h     | 13 +++++--
>  kernel/sched/ext.c          | 73 ++++++++++++++++++++++++++++++++-----
>  kernel/sched/ext_internal.h |  1 +
>  6 files changed, 83 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 20b2343aa344..75cb8b119fb7 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -263,7 +263,7 @@ void sched_ext_dead(struct task_struct *p);
>  void print_scx_info(const char *log_lvl, struct task_struct *p);
>  void scx_softlockup(u32 dur_s);
>  bool scx_hardlockup(int cpu);
> -bool scx_rcu_cpu_stall(void);
> +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask);
>  
>  #else	/* !CONFIG_SCHED_CLASS_EXT */
>  
> @@ -271,7 +271,7 @@ static inline void sched_ext_dead(struct task_struct *p) {}
>  static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
>  static inline void scx_softlockup(u32 dur_s) {}
>  static inline bool scx_hardlockup(int cpu) { return false; }
> -static inline bool scx_rcu_cpu_stall(void) { return false; }
> +static inline bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask) { return false; }
>  
>  #endif	/* CONFIG_SCHED_CLASS_EXT */
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 55df6d37145e..03c9651be5c0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4871,6 +4871,9 @@ static void __init rcu_dump_rcu_node_tree(void)
>  
>  struct workqueue_struct *rcu_gp_wq;
>  
> +static struct cpumask rcu_stall_cpumask;
> +static struct cpumask rcu_exp_stall_cpumask;
> +
>  void __init rcu_init(void)
>  {
>  	int cpu = smp_processor_id();
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 82cada459e5d..46b6907f1b09 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -578,6 +578,7 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
>  			if (!(READ_ONCE(rnp->expmask) & mask))
>  				continue;
>  			ndetected++;
> +			cpumask_set_cpu(cpu, &rcu_exp_stall_cpumask);
>  			rdp = per_cpu_ptr(&rcu_data, cpu);
>  			pr_cont(" %d-%c%c%c%c", cpu,
>  				"O."[!!cpu_online(cpu)],
> @@ -665,6 +666,8 @@ static void synchronize_rcu_expedited_wait(void)
>  		if (rcu_stall_is_suppressed())
>  			continue;
>  
> +		cpumask_clear(&rcu_exp_stall_cpumask);
> +
>  		nbcon_cpu_emergency_enter();
>  
>  		j = jiffies;
> @@ -675,7 +678,7 @@ static void synchronize_rcu_expedited_wait(void)
>  
>  		nbcon_cpu_emergency_exit();
>  
> -		panic_on_rcu_stall();
> +		panic_on_rcu_stall(&rcu_exp_stall_cpumask);
>  	}
>  }
>  
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb8770..d0c4f193f17e 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
>  early_initcall(check_cpu_stall_init);
>  
>  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> -static void panic_on_rcu_stall(void)
> +static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
>  {
>  	static int cpu_stall;
>  
> @@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
>  	 * Attempt to kick out the BPF scheduler if it's installed and defer
>  	 * the panic to give the system a chance to recover.
>  	 */
> -	if (scx_rcu_cpu_stall())
> +	if (scx_rcu_cpu_stall(stalled_mask))
>  		return;
>  
>  	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> @@ -645,6 +645,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
>  
> +	cpumask_clear(&rcu_stall_cpumask);
> +
>  	nbcon_cpu_emergency_enter();
>  
>  	/*
> @@ -660,6 +662,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  			for_each_leaf_node_possible_cpu(rnp, cpu)
>  				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
>  					print_cpu_stall_info(cpu);
> +					cpumask_set_cpu(cpu, &rcu_stall_cpumask);
>  					ndetected++;
>  				}
>  		}
> @@ -701,7 +704,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  
>  	nbcon_cpu_emergency_exit();
>  
> -	panic_on_rcu_stall();
> +	panic_on_rcu_stall(&rcu_stall_cpumask);
>  
>  	rcu_force_quiescent_state();  /* Kick them all. */
>  }
> @@ -754,7 +757,9 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  
>  	nbcon_cpu_emergency_exit();
>  
> -	panic_on_rcu_stall();
> +	cpumask_clear(&rcu_stall_cpumask);
> +	cpumask_set_cpu(smp_processor_id(), &rcu_stall_cpumask);
> +	panic_on_rcu_stall(&rcu_stall_cpumask);
>  
>  	/*
>  	 * Attempt to revive the RCU machinery by forcing a context switch.
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0c37b5fd58b0..28009d08762b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4966,6 +4966,8 @@ static const struct attribute_group scx_global_attr_group = {
>  
>  static void free_pnode(struct scx_sched_pnode *pnode);
>  static void free_exit_info(struct scx_exit_info *ei);
> +static const char *scx_exit_reason(enum scx_exit_kind kind);
> +static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind);
>  
>  static s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
>  {
> @@ -5022,6 +5024,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
>  	timer_shutdown_sync(&sch->bypass_lb_timer);
>  	free_cpumask_var(sch->bypass_lb_donee_cpumask);
>  	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> +	free_cpumask_var(sch->stall_cpus);
>  
>  #ifdef CONFIG_EXT_SUB_SCHED
>  	kfree(sch->cgrp_path);
> @@ -5251,9 +5254,46 @@ static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
>   * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
>   * else already initiated abort.
>   */
> -bool scx_rcu_cpu_stall(void)
> +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
>  {
> -	return handle_lockup(-1, "RCU CPU stall detected!");
> +	struct scx_sched *sch;
> +	struct scx_exit_info *ei;
> +	int exit_cpu;
> +
> +	guard(rcu)();
> +
> +	sch = rcu_dereference(scx_root);
> +	if (unlikely(!sch))
> +		return false;
> +
> +	switch (scx_enable_state()) {
> +	case SCX_ENABLING:
> +	case SCX_ENABLED:
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
> +	ei = sch->exit_info;
> +
> +	guard(preempt)();
> +
> +	if (!scx_claim_exit(sch, SCX_EXIT_ERROR))
> +		return false;
> +
> +#ifdef CONFIG_STACKTRACE
> +	ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
> +#endif
> +	scnprintf(ei->msg, SCX_EXIT_MSG_LEN, "RCU CPU stall on CPUs (%*pbl)",
> +		  cpumask_pr_args(stalled_mask));
> +	ei->kind = SCX_EXIT_ERROR;
> +	ei->reason = scx_exit_reason(SCX_EXIT_ERROR);
> +	ei->exit_cpu = exit_cpu;
> +	cpumask_copy(sch->stall_cpus, stalled_mask);
> +
> +	irq_work_queue(&sch->disable_irq_work);
> +	return true;
>  }
>  
>  /**
> @@ -6672,14 +6712,23 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
>  	dump_line(&s, "----------");
>  
>  	/*
> -	 * Dump the exit CPU first so it isn't lost to dump truncation, then
> -	 * walk the rest in order, skipping the one already dumped.
> +	 * Dump stalled CPUs first so they aren't lost to dump truncation, then
> +	 * walk the rest in order. Fall back to exit_cpu if no stall mask set.
>  	 */
> -	if (ei->exit_cpu >= 0)
> -		scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
> -	for_each_possible_cpu(cpu) {
> -		if (cpu != ei->exit_cpu)
> +	if (!cpumask_empty(sch->stall_cpus)) {
> +		for_each_cpu(cpu, sch->stall_cpus)
>  			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		for_each_possible_cpu(cpu) {
> +			if (!cpumask_test_cpu(cpu, sch->stall_cpus))
> +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		}
> +	} else {
> +		if (ei->exit_cpu >= 0)
> +			scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
> +		for_each_possible_cpu(cpu) {
> +			if (cpu != ei->exit_cpu)
> +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		}
>  	}
>  
>  	dump_newline(&s);
> @@ -6916,6 +6965,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  		ret = -ENOMEM;
>  		goto err_free_lb_cpumask;
>  	}
> +	if (!zalloc_cpumask_var(&sch->stall_cpus, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto err_free_lb_resched_cpumask;
> +	}
>  	/*
>  	 * Copy ops through the right union view. For cid-form the source is
>  	 * struct sched_ext_ops_cid which lacks the trailing cpu_acquire/
> @@ -6994,8 +7047,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  #ifdef CONFIG_EXT_SUB_SCHED
>  err_free_lb_resched:
>  	RCU_INIT_POINTER(ops->priv, NULL);
> -	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> +	free_cpumask_var(sch->stall_cpus);
>  #endif
> +err_free_lb_resched_cpumask:
> +	free_cpumask_var(sch->bypass_lb_resched_cpumask);
>  err_free_lb_cpumask:
>  	free_cpumask_var(sch->bypass_lb_donee_cpumask);
>  err_stop_helper:
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 2f15a4d3c534..f48dfda3facb 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1199,6 +1199,7 @@ struct scx_sched {
>  	struct timer_list	bypass_lb_timer;
>  	cpumask_var_t		bypass_lb_donee_cpumask;
>  	cpumask_var_t		bypass_lb_resched_cpumask;
> +	cpumask_var_t		stall_cpus;
>  	struct rcu_work		rcu_work;
>  
>  	/* all ancestors including self */
> -- 
> 2.48.1
> 
