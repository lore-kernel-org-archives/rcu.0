Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E475274658;
	Fri, 27 Feb 2026 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154844; cv=fail; b=BwpaNagCm1CMRml8TQBJkjmjOK0q+lntdDmAX02if3sTUvBe9/17b5eR/yoh+h+ZqVwvCgJGU2Ygqg1aHUiYKLG/n5Fw8OcCIJn+3ZwBIsG71ya5m6SI8HMiMc4XkUzRRYnHiJ5lLuVV85xs8d2ef81iy1+53PniH47VNmOtaN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154844; c=relaxed/simple;
	bh=3+B+biHDUQOR3QIldnfYTSe+Eip/eGSszJMhKFYDXPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oK5DqvjPA/7OCI/ZLfnPSOTHeEsDGDuKL+QPySCC/4Re801I5MqgtY4bz2GI4JduZMGlj9JIsxXKFdfoB3zhfMjsU3yGFuYfIgleSaDER11G9ZJkW5QFn1Kyy5j8RjL7WNIPZhL9XPLbDxZbrhu3j/iL0odZHcn+9Pp9KD+HPOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=INcnsl3l; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="INcnsl3l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7ZlgYkCyMqXV5LmLm2ksL0awjEV8oO0Gt1HK/G6A5bWmvMwZgYxIwhuo/bVVNpJ6YPuiT+wCE685LmpvZTkKcgfQIcHcs+d9iSNeBJtiPq9Bi7BTRH6zaBMnr/nMtnD60oRRH1Z7jtIN8DiPrdT8FTVX7/zPhkKR5JjY1OQQS6VB/l7msFnWUGFcjHvBO8IIm9R3Rbm6+SqSRKKNCLYGAEOwwKBwuI30X2EZ4pGvgGxqq/EOe6gLZSBFmR62qz3qfCOwmLSO3Z8Im2FWnzokQsn1vsZVwiaorNlCbu4tP5YOpkhbP653QMxDFSkeIhrzAc/hWE358qnrc6Q0kBZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OnmBB3nYfggW7rVY5iGhhmVrDvzGINJsKBd7ETc9Xc=;
 b=UH4xP6MkiY4kiFpnsGGdD+mBfRytZt01BxNk2ukGpLbW/42LAPW+NOQEemRqGv5qBfSlEWg1IE27i69U0LEXtRHbb16xMchuMRRuEBP2Umx1IvvD6XS5GvBzZ7HiWIgupsp4oAUNwMaDl2klz+FT+4XyDJUsELYnlR+a6Jo4aFgVIKw5AkMul/nqdqMkKVTsTDuwx3DCP7tT0orkSEYdjpzeKPud3e+FDwRi4bdo1wWscPte5FH7LECe4tb8uxnn122Ia5nEBNEOsoz1ygQqt+akfMk53A3m/MDRn/+fKwxGrX3ZbkwzO/kgBPGZ7HyGPiQs76nB0sLlrwaeW7/rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OnmBB3nYfggW7rVY5iGhhmVrDvzGINJsKBd7ETc9Xc=;
 b=INcnsl3ln/qB1FHsm9S3o1Hz2b+MNhKjPPuFYuOvV7nsznF+FDtYISAEsYimcE1WQ/f3WRrBHLGQdazghn/47ey4JuqbFUYZLd73IDsMruKD81qVO31uml4hi6PAqJ8LrCKvdB/zAC5ZY6BcziWqcO3hvIaJLgmujGU+mkOtjPdFzVCJgrh7OlVv5Y+piVvsyoUAAfW9KFce7YaghuV2tjMrL0lpOj4TPKnVhcNMqdNkyuY8KBSIAg7o9n8FeUhXS/Kt1l+/29sCQrNZ+OVs9kdS3k2hPea8fBoLX885ZUdtuHMfMWRagyPxlb9npEA37FyiEK1hhn+3aFcqI8CtQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Fri, 27 Feb 2026 01:13:54 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:13:54 +0000
Date: Thu, 26 Feb 2026 20:13:52 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: peterz@infradead.org, aboorvad@linux.ibm.com, boqun.feng@gmail.com,
	frederic@kernel.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org,
	srikar@linux.ibm.com, sshegde@linux.ibm.com, tglx@linutronix.de,
	urezki@gmail.com, samir@linux.ibm.com
Subject: Re: [PATCH v3 2/2] cpuhp: Expedite RCU grace periods during SMT
 operations
Message-ID: <20260227011352.GA1089964@joelbox2>
References: <20260218083915.660252-2-vishalc@linux.ibm.com>
 <20260218083915.660252-6-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218083915.660252-6-vishalc@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0249.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::14) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: e5072e93-f7c4-4592-a632-08de759d7987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	8QMhmcJHshys4uJepXr/zCVgddiYw7AtLX7skglULyKdwYZe6BBwlc/4RLzjnOtR6G04JfEbZr80dTuhBVfmtsOtCxxXES0ZNTxMa0bVUbls4m2MOJex87P/y/WsfbYMJmxvcdx8m3GJTFcyXvcc6WPcuFAndZDzTQylXwY2PQwXRiEhqGTgb4Pn3H9TBcn2/9u9wjAsqzfFjbnM38X9X0uGxQM61jeRdGwYGh27MKx0QXCGQOOINghDuFzjicJUukfaPs1D7/HnASj0KmkseywYbf9mrrTqebtCZ0EtzOYAehp+gV2d3eR1aaunsrHs3yi+DvD1MasOp9YLIF8OVwgbcS80Xj6fpC29ubEr8meu5o3+ShVnBDcwTDrPClEffkaKIXj5z4sUPkVO4xrwyrl20pIxM7XQeE4poV7JIr0hHxwJ62k/CkJOKpSHiUabV0CD4Em3ykdb34tPvxisw01JnauZ9gfl2WD/fcYansTRN1vGwtS0wHmDU8mFOPhA+EMddFYS6LTCjBXqbh5rRqAYdJVy+arM/+rBUXniMKku9iDIq0T7GWs1Ge8MyMEq3WbcKhfHdhYAjLdXJ4I7H0Wq64XxOMi4dZjWzCeHNx/idHXiDpo71CG1rg3e7M5hQxW5rDKZE5stKMvmCm2aBPmUr+BdD1S7gAED1mDPt/H1bS11DxFvrlA2+0n/cC0skckrhLJjO9XwZ36V0zqkxPbZon/5xKoVO+yYfUuhCNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9c+3qnfaG8D9votLWEkvZ+9bCX94cP94t+t00SbrqOlvLezXB6ajrLIEJOa8?=
 =?us-ascii?Q?qPQih0YlqmrRPvyUiEZG6zBNjz5KJcd6kz6tW5vdt4gzG5QhNg8lV/w0e9Lm?=
 =?us-ascii?Q?QglfXdStxQoX21+KCia39hOmymoE4VRdw75LOUDbopF/0cJdmAnqFXJSSYcG?=
 =?us-ascii?Q?sVkh36vmESKjVTIdDI+6SuOxxXNHNR/ydV/FdZpNdcX44g5NYnm1qPpWTT9w?=
 =?us-ascii?Q?4kzQuUbhVm9wyI3CYI7dKNiA6Pt06Aw32L5SE3gEOL0dOvS/I7NOiiPZLgGv?=
 =?us-ascii?Q?dLZwWuWIKsQAP4I/4DXQTX1vjpYXCSv4DNPRMTSFQxNQ0MMr5wy7WWIhzxQf?=
 =?us-ascii?Q?oUijPXgFW6X7f3mQCMkIFXGKJxfzMDCBlXBxAPdJdB0nArNjoTAffid+91PU?=
 =?us-ascii?Q?Gf6g7Kwe5IDTuTG536BWOOg7p670/Y1EaPDfSpE4iqf1yxlcfc2yj9jb1Ib4?=
 =?us-ascii?Q?+F390iaEc2f4IhzuSZPcGHnjrhUVmjLPUBMjFerSNL0PR+nJ6sXQ5bvkeC5i?=
 =?us-ascii?Q?2lu2VVenecAElMYbTFr1HIK0EZLQXu3kaMTsguYQH5TkTLYKf3BCjkKX8Y0j?=
 =?us-ascii?Q?qRt5TRoegynZ9gWSeMThbglPEqu6qD7Zkow7dTVPu/yLmyRHv1Bo9KXbiPC6?=
 =?us-ascii?Q?PY7jyvLkf2fnGLJ5R/rvS7kC/SDEE25EfYEeCltPa3NIClR5XGgIPf/UG2I5?=
 =?us-ascii?Q?mHWa4hWobOHkaGB8qNq/xMqFx15iVwwSxiSCeeMEPy7PYMn8Ya2sxxxivmaH?=
 =?us-ascii?Q?qV38kq89MpnGXib+Iljs6B7S6lPSb+w98NDCtcgQZ+ITjIJQoFHQoJc7QTPE?=
 =?us-ascii?Q?60SViSVk5B6vrgB1pVdYKOBonmmSr1Yp0toat9NZLegrBlGsLhdT2jIT0rtl?=
 =?us-ascii?Q?aDZfNqXfCHUnWv9fjxTvy9/9yWT4VCNHjUx0UtXf+wx4/VmsdKaNy10GNSEg?=
 =?us-ascii?Q?n4T6YiVQpgsfGXQv9xOspJtNHU8ZRDFo3sgKiMpeUEo0evOIk0nBO6AY8RFV?=
 =?us-ascii?Q?tZUOaglBBeYYTaG/Dq1XyLWaeHBZ4hBYIr0/oDqDxRaVKo23JLbvONW82OxB?=
 =?us-ascii?Q?ar36GScp7582cenDBoibNtUgEMa76C+AowzbifCXC2UvXX6wz+Sl3KqaWbQL?=
 =?us-ascii?Q?tZDHAQb1XKT/07HiVkrse+vADfYlj7rr13QofVrKhlfWP6pm34Dp8hhRfE7q?=
 =?us-ascii?Q?HVd/ymex3VrmLl39sv0rbZa1AdmNeD2IXeKShspKMWaC4fVJsdBxBgs+vqiv?=
 =?us-ascii?Q?WRTZZv+pDzf08BZTIQ+RmHOf1rToxkBAzU1Wg0liMhmkzazQBl49m9Y9LMDE?=
 =?us-ascii?Q?Is844Q1VjCpJu8g/1nYeLVL7+6bxbpJmrl7wNHasZJ86az+BnCD0V3buaGJg?=
 =?us-ascii?Q?iATgJudiQmKZIiOyfT/tVTZIBuqx4jqJrnF7jwejoqYFLdiOM48yscoYlk3U?=
 =?us-ascii?Q?nu+1rLVCCXK0aeheqyCfNNoqRJI6BqesM0M5BInxuFcNgrzeTHPUZRm5WtEb?=
 =?us-ascii?Q?o39M4Lx++D4PiMIV0TPo75qEc7OWo/Yueir1jTgf0rUVcMasyI6InDhXCCVb?=
 =?us-ascii?Q?W/8EPg9Zcilpt+uzQeiACRTXstUzcUbKRxmzDzAg+EgGAclP+PCodKJfCYGq?=
 =?us-ascii?Q?1Mx9ZeCI+8+LxRuMMh4Pk7nVHChned/5F7sArJ76hpNYtKZXglHsZFEji0Ee?=
 =?us-ascii?Q?3BhFLBEzCxsMdXXSjE11ouBkNoWtXp7tvsHgu6Ed8DaJimxqHYQQzPV2wS41?=
 =?us-ascii?Q?sGsVQZq45A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5072e93-f7c4-4592-a632-08de759d7987
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:13:54.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8di8foGZ5jPc2X3N9A+84zkwbdTLwbKAbiuOWxUsD/3Fcl+WU6tLr6AGmCQ3k2V+EkIJq4Lpz9JX2LMpXa5SKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574

On Wed, Feb 18, 2026 at 02:09:18PM +0530, Vishal Chourasia wrote:
> Expedite synchronize_rcu during the SMT mode switch operation when
> initiated via /sys/devices/system/cpu/smt/control interface
> 
> SMT mode switch operation i.e. between SMT 8 to SMT 1 or vice versa and
> others are user driven operations and therefore should complete as soon
> as possible. Switching SMT states involves iterating over a list of CPUs
> and performing hotplug operations. It was found these transitions took
> significantly large amount of time to complete particularly on
> high-core-count systems.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  include/linux/rcupdate.h | 8 ++++++++
>  kernel/cpu.c             | 4 ++++
>  kernel/rcu/rcu.h         | 4 ----
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 7729fef249e1..61b80c29d53b 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1190,6 +1190,14 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>  extern int rcu_expedited;
>  extern int rcu_normal;
>  
> +#ifdef CONFIG_TINY_RCU
> +static inline void rcu_expedite_gp(void) { }
> +static inline void rcu_unexpedite_gp(void) { }
> +#else
> +void rcu_expedite_gp(void);
> +void rcu_unexpedite_gp(void);
> +#endif
> +
>  DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
>  DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
>  
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 62e209eda78c..1377a68d6f47 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2682,6 +2682,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  		ret = -EBUSY;
>  		goto out;
>  	}
> +	rcu_expedite_gp();

After the locking related changes in patch 1, is expediting still required? I
am just a bit concerned that we are papering over the real issue of over
usage of synchronize_rcu() (which IIRC we discussed in earlier versions of
the patches that reducing the number of lock acquire/release was supposed to
help.)

Could you provide more justification of why expediting these sections is
required if the locking concerns were addressed? It would be great if you can
provide performance numbers with only the first patch and without the second
patch. That way we can quantify this patch.

thanks,

--
Joel Fernandes


>  	/* Hold cpus_write_lock() for entire batch operation. */
>  	cpus_write_lock();
>  	for_each_online_cpu(cpu) {
> @@ -2714,6 +2715,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  	if (!ret)
>  		cpu_smt_control = ctrlval;
>  	cpus_write_unlock();
> +	rcu_unexpedite_gp();
>  	arch_smt_update();
>  out:
>  	cpu_maps_update_done();
> @@ -2733,6 +2735,7 @@ int cpuhp_smt_enable(void)
>  	int cpu, ret = 0;
>  
>  	cpu_maps_update_begin();
> +	rcu_expedite_gp();
>  	/* Hold cpus_write_lock() for entire batch operation. */
>  	cpus_write_lock();
>  	cpu_smt_control = CPU_SMT_ENABLED;
> @@ -2749,6 +2752,7 @@ int cpuhp_smt_enable(void)
>  		cpuhp_online_cpu_device(cpu);
>  	}
>  	cpus_write_unlock();
> +	rcu_unexpedite_gp();
>  	arch_smt_update();
>  	cpu_maps_update_done();
>  	return ret;
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index dc5d614b372c..41a0d262e964 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -512,8 +512,6 @@ do {									\
>  static inline bool rcu_gp_is_normal(void) { return true; }
>  static inline bool rcu_gp_is_expedited(void) { return false; }
>  static inline bool rcu_async_should_hurry(void) { return false; }
> -static inline void rcu_expedite_gp(void) { }
> -static inline void rcu_unexpedite_gp(void) { }
>  static inline void rcu_async_hurry(void) { }
>  static inline void rcu_async_relax(void) { }
>  static inline bool rcu_cpu_online(int cpu) { return true; }
> @@ -521,8 +519,6 @@ static inline bool rcu_cpu_online(int cpu) { return true; }
>  bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>  bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
>  bool rcu_async_should_hurry(void);  /* Internal RCU use. */
> -void rcu_expedite_gp(void);
> -void rcu_unexpedite_gp(void);
>  void rcu_async_hurry(void);
>  void rcu_async_relax(void);
>  void rcupdate_announce_bootup_oddness(void);
> -- 
> 2.53.0
> 
