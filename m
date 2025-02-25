Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517212116FA;
	Tue, 25 Feb 2025 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518656; cv=fail; b=prQqnV5e4iI1NeC39QrwGdPbOJ2OoKLLYNbgPKGGB4zdkyU7XGO1x4IEYmia1YUbWLhgWvoVoQvoDftWjlhngAEl53eIjJN65U/BD92xATBsgLzkzyw9ZJLLEB54tORSdv0leeJFZmf8fS2ksSQLKkM7j/VUcyrHOQMXI1VGJqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518656; c=relaxed/simple;
	bh=S8V6XtcLKcpyZIOagEk8PTAr3n4byNGC3h7oG0MKEkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gdZWUzbNoLNyjmmo8UFJEkydTbyydrvW1eMil+O2/H6pMV5GssE4nXQmpDAfRXKtL7O8El9CLfg1JCf3J7rLCwqLwR4bZw0vr1mXjTQbA9b8SRPlOnAVlQmDMG9rPdW6Ix/e7wli7PXdzK91wJcDuBdFpMLkOsan9HvxFy9Pkcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bpuMrX43; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bpuMrX43"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6WaVbkeKROXOF8CEgYMTwvq4TrDcInic83ZfdqUznie4lGC8Vt1LBiQKtg/ZKaK+qyH+mFL5KygpCG2WSRfpmwDo83QGGgOOVlGreEkPxq5DVxBwUrxwX1mmGzT6KAH+5TPafR39rojapmtUOOUxi7FwLrYZhYPPJjvfxWtwxzGvo8ztIvzuMSwg0mSv8gNsQcBfMB82DcQk364Z98ttt0vDI1IzWK+9kc1n1wHXg+nD0vWHvxXWR9BPGiBmx9S1S79RYEe9NEMEN+ETfBVDQzVzG5dci+yFDnTIugfTYy0YTlLPxRofo1opQ1gJ6edL7eSn9s0zBcOtZDtlICdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrNXioVTwoB1+/nUGuP6Sl8hLeha+Wc5QAw+IsmEfjc=;
 b=eixd3d0FWAu6Mp16wQxLbCJJckwmPnAt+/wcFZ0iQVWkhQJ3vuolsUSv+LUHDRDrV2bjsTSTshYfJYWwfMcW9mtUCovF1FUltPkwJXCE7wqZ/qfXbbrGUP5yDl71G0fO2hKZApNtOFiFMMYZ6GsXYYSbauRBv5oDqzc4zx14n9rFFDB2/EgfDYbYAxjY2MLMehXLMri0fsHQjxYmvVhCcIy8bECp6uZrvPhjQry3ckR3QaHaEySRrOG48SO6omGXjEExh/gNRVwbE3oOEkkZaRzGVsExStRp8ph4Q6ChOZOdzA6Ue1kJ3O/HkXSy2c6iDOt2HcbhRJ2cB9nXJQz9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrNXioVTwoB1+/nUGuP6Sl8hLeha+Wc5QAw+IsmEfjc=;
 b=bpuMrX43gZZUTp3u0lcTiGSeARLbuAcR9ep8PNvExUgGZekcBoqLnbLnOBS3Xz6cjNJK0O1cf9ESd4zAQs+VYSRShWldk9Ktr4Zult+fUk/HMqfOn/kaUvKadlbN+4Ohh0QkzptzxNp7dca/fSi/lTq4hujd3sjSJbzLUu51HLKnmXS3YxfNJm6SrvSfH5JRahANHDAWoWUDc76RUD4v7dDNEkQUVZGEkS8U/Knej5Bas2w/4oHadSOLDcwlwV9NTwK3TYYny3V6Cit/sVIosl1LDEfAzdniUaLykmgFYfGtO4fjUgmMDyoh+KHbChX/NdbD6LduLnPlfaHCfE21ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 21:24:11 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 21:24:11 +0000
Date: Tue, 25 Feb 2025 16:24:09 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/3] rcutorture: Allow a negative value for
 nfakewriters
Message-ID: <20250225212409.GA1807836@joelnvbox>
References: <20250225110020.59221-1-urezki@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225110020.59221-1-urezki@gmail.com>
X-ClientProxiedBy: BL6PEPF00013E13.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: ae104903-dbad-4007-426c-08dd55e2beea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sMK1VZVVuCyTLD6vkX5SWTXY+qXxXpJKbMtRXdMGrkEMa78BganX45fmIY1z?=
 =?us-ascii?Q?ZR+1+3VIAeXxrtje+zOhERplqcGRkuZPn+yqLcj2Oq2RM16tjanQaiLRoN+o?=
 =?us-ascii?Q?hhmYRZqPM5F/QSAnLMUV2Yarq4fi76qWWSFHcMPKY/DwxBp84+vEhlfmlUPl?=
 =?us-ascii?Q?Sbxb8uOHup3mbI2tM9VkTcU4BhfNzzhJdjKv/yspnlZa5OuNzOPwSIeKJHQx?=
 =?us-ascii?Q?Vl0V873Wc5+kHLd4fUa7dwIULJOWfMjUrNHdFmR4M6Plx1pJoCDXhB24H+h+?=
 =?us-ascii?Q?nY/4atKgbNhycwax/XX5IjGHS2tRZbd5KLjVDqHlSaU4stIr78RTARJwDhcX?=
 =?us-ascii?Q?/YMImjrNqtmksxRWG8yyfIvVbepAfN0MTCOdR+Ldyh6evtu4jN57WEcPPWks?=
 =?us-ascii?Q?lGx2ZLHxKakh4eujasLAo1usiEoQJoj7qB6gtIUmjoUAi3cU1Y8HKgQhWzL4?=
 =?us-ascii?Q?6AenuisCAtpg8PDTR37dPxjQK98U/HpkFFqyEzMejqUOf0Stdjsd3TIugelM?=
 =?us-ascii?Q?5zPZZftT6hTexY2dFR4e/bvfvLsjRJB/xhkah1bmjyCCNAV9E/TVGYeFCSMR?=
 =?us-ascii?Q?hsUgKjdarFvMmkp0bYRka1eDXPm+BA82heHgiubpxZ1ZoBRxS0LmBL9oiGs8?=
 =?us-ascii?Q?hL3JML9W8BzzRxtlaiw46TEMCyj4txpR2gqYG+O89k804oMObNu9TbmWYmPW?=
 =?us-ascii?Q?SyMTYBzAgL8obu949RYpHaLEd51phpCjmd7ecNmIB4XnQS2SiXExb1aTK0MD?=
 =?us-ascii?Q?xj2SsEc4K5Q9iJwxNjUqMIFXsJWKRS0kfIL2l1boowjNvoAya3EGZdv3pz6M?=
 =?us-ascii?Q?zyMmQWyvImxBVTYyAFN0ou8o6fUtTI3viFTg+AuwdG0uW3cdYdI5oUh+ll+F?=
 =?us-ascii?Q?a+5YDEydPz1F1shBa+eT9OG6xGsoHuRE5r88F71DFHii0LLHm4WVNhZ21bj6?=
 =?us-ascii?Q?qPTeDDVY/xlZf8ZRaq7lhF7HKpVOWhzoxJD+lWGyzIoriQDsIY2tk1T1pD49?=
 =?us-ascii?Q?BtTHCwIfMDK4pMhZ5LOo3Ky/kry/TKmw9QZlW6NoSozVQrMgYMmbtfRDjCH3?=
 =?us-ascii?Q?c/fEqws5lIZ755LmRTjJTtEemWBCISqqKR9BMzwEkbuT3zQyAEzkOCVo9UPZ?=
 =?us-ascii?Q?blfZM7EEWJZIp5clybh05851dOZqcQbuNrGLCG/U2o+EMGqnmXw1HMcbNb1K?=
 =?us-ascii?Q?mB8rjUWYSRY35l8pKP8OGY/Fo2+D67F8tvCtBk+58AiUxKtg5GSVbOz5uJ5r?=
 =?us-ascii?Q?LaHVJfHvJ7kKbwUb/a+Z14Vwv+XjVNedyDzCNuygOu3KhJRbQqUeqe4WGYxc?=
 =?us-ascii?Q?GlTpziKX2LmsbLNwz5ScRyz092a8Sgq5Q7Tmwt9nDaekU1PGty7uxFaIgxDt?=
 =?us-ascii?Q?e6kYysAPuZS4dh/ozxfJavY7XMc2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LsyCfc6Zn0q7coj3irFwwmKQ2dA6i3esN24Zaff9SvbLMwhRfhA/t/NaGWcG?=
 =?us-ascii?Q?jIkS19Oi19zNd4iZtR0Y3IuWMTBLiTg/PgQOpHb4PNybc9MjzcvLJ2x+Bscl?=
 =?us-ascii?Q?L1GY/Av9bXml7Xa2zC9wQJLLeOGetEYUKRO+C7fml36FYMUVJMKoVYcb0FEO?=
 =?us-ascii?Q?vccYl/NYvws34txXtX49haNJjt/Zi7VTBq6VZN2cpmEFEhSsGDWoFYhogYJI?=
 =?us-ascii?Q?SC0EnSWXxOT869kU1hJ24+5TapuXRA6LdF+5wQYz+ypGgzgVKxCFFl1StXBP?=
 =?us-ascii?Q?o0J2GJd/LMYTsjWX76FEenhDzyG/GKJ5vv+NjwV8Dwz6cL6Wed7ztCigE3Ki?=
 =?us-ascii?Q?pOx1h4IyBmRSRv3WEMn75TlKleqjQC/1Pgyfz6UMkGiSdqBkmxH+XAYpqiLn?=
 =?us-ascii?Q?C7kciGzRqOtp07ooacpOR/5eyDI2/wRknA4FVtwH114Vu4Ceg8Mxax2D526u?=
 =?us-ascii?Q?w/DDKWx1zU1qeIRi6jNHK9LQu5J5VdZu/Es2kLKsMAi+lmbseShKcKSd0NC1?=
 =?us-ascii?Q?bVYDvxiM6pKxdNXhHRgXkFXsxyOgQrH8TTpw2rROKnfHWyCSYYMwSnh5gK/N?=
 =?us-ascii?Q?uMvXQgzm+FrP6Fw/aEZl+oE7V33dvvT54qsukDZvYyBxE6B09mpc1GEnF847?=
 =?us-ascii?Q?OexrHVYEpD7xet/I3JBJcg6XF0G/RJIG9VpJKWLJQd6TXUKIQ0Fq1iP3wYzt?=
 =?us-ascii?Q?nLUivVcB45JQVFIBFDeu1Qr/BXcKevleYw7Q22/fOxdFAh6kO4nSpqzh17WG?=
 =?us-ascii?Q?5TA18YlJM4Ow0wNEZItqNHyG6GYbXc99N2BzoNUItSCzJtYIW6MOAX4hsTRE?=
 =?us-ascii?Q?Z15VM9sp9zPykX0+cNlhDpnIpA14bu+kPHOTZdfRzRJ4F+0PGofQFUNlxOhP?=
 =?us-ascii?Q?S2sB7NdaKy+aWkA1fTAGspavvmUedLHg0RUleaQZl7r/vjOmE9wuhvqyyz5t?=
 =?us-ascii?Q?g4RzdF5DghuEDN8FHNKp55z+QxI9RC628oseC8rI5OiTQ/JlsrQpfg2fo/fV?=
 =?us-ascii?Q?TDk27eCXYwCkd7nxxn2zmpAgqwRRcqMJw3+NUWPDJpy4OEjFXmjD0iUPQtRy?=
 =?us-ascii?Q?dlXOyWFxBBSBZBllN4pSZwlsJgLf08TFBfOUCDSJC/D8RAniA8ylpcdOXjK7?=
 =?us-ascii?Q?OWvoIGA0O6IRi/MrnRj4hQO2j2gvn+dwgZn35kMsyg7ZkqTqufmVs6LwPN7D?=
 =?us-ascii?Q?q6uXjjvdsm4tUWOTFhAEp0aoXGixt+cUNqJ057YwRZ7PSRpLBY9tHk6w5PVl?=
 =?us-ascii?Q?PzJEOTlTG2YSy4gZov4lgmHfFtus89afdOjL0zZh4niWStAUeWX0W7fiFm2z?=
 =?us-ascii?Q?98nItuz0Fmtzvq+pbtFXFl9LDieXKeD0j9b7crVJB6v/AE2ttUTrXXF3gcGq?=
 =?us-ascii?Q?g8mOmM52w0MPqIM/PrWuW1j3CI+0BX4VRoa6T4ozwuuYQ30ORPIKiVAeWa3F?=
 =?us-ascii?Q?IQNoLof302SRbthTyLGtjadYmEBrPPQZOUYOK+TL8GTGi63B/hlO9NxJhQen?=
 =?us-ascii?Q?DVU6+bRWTikQD3nD0KTv2NICMPvEc4SI8MBGWJ4YO0I+T/2jMGfZTuZkkkpr?=
 =?us-ascii?Q?T/0KMpC117ObVDrfWX9Kx/4w8qAbMLhDckqnsjDZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae104903-dbad-4007-426c-08dd55e2beea
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 21:24:11.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZpHd+KK7m9vm8id/ySlCPt9sRB2XSFEGTm4edyC6CfYt4l8ZcWM8gFahehg1jpr9GAt7LxN6m153xfzo7yQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429

On Tue, Feb 25, 2025 at 12:00:18PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently "nfakewriters" parameter can be set to any value but
> there is no possibility to adjust it automatically based on how
> many CPUs a system has where a test is run on.
> 
> To address this, if the "nfakewriters" is set to negative it will
> be adjusted to num_online_cpus() during torture initialization.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index d98b3bd6d91f..f376262532ce 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -148,6 +148,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");

IMO, this should also be updated to reflect the possibily to set it negative
and hence to number CPUs:

torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");

thanks,

 - Joel


>  
>  static int nrealnocbers;
>  static int nrealreaders;
> +static int nrealfakewriters;
>  static struct task_struct *writer_task;
>  static struct task_struct **fakewriter_tasks;
>  static struct task_struct **reader_tasks;
> @@ -1763,7 +1764,7 @@ rcu_torture_fakewriter(void *arg)
>  	do {
>  		torture_hrtimeout_jiffies(torture_random(&rand) % 10, &rand);
>  		if (cur_ops->cb_barrier != NULL &&
> -		    torture_random(&rand) % (nfakewriters * 8) == 0) {
> +		    torture_random(&rand) % (nrealfakewriters * 8) == 0) {
>  			cur_ops->cb_barrier();
>  		} else {
>  			switch (synctype[torture_random(&rand) % nsynctypes]) {
> @@ -2568,7 +2569,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
>  		 "nocbs_nthreads=%d nocbs_toggle=%d "
>  		 "test_nmis=%d "
>  		 "preempt_duration=%d preempt_interval=%d\n",
> -		 torture_type, tag, nrealreaders, nfakewriters,
> +		 torture_type, tag, nrealreaders, nrealfakewriters,
>  		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
>  		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
>  		 test_boost, cur_ops->can_boost,
> @@ -3644,7 +3645,7 @@ rcu_torture_cleanup(void)
>  	rcu_torture_reader_mbchk = NULL;
>  
>  	if (fakewriter_tasks) {
> -		for (i = 0; i < nfakewriters; i++)
> +		for (i = 0; i < nrealfakewriters; i++)
>  			torture_stop_kthread(rcu_torture_fakewriter,
>  					     fakewriter_tasks[i]);
>  		kfree(fakewriter_tasks);
> @@ -4066,6 +4067,14 @@ rcu_torture_init(void)
>  
>  	rcu_torture_init_srcu_lockdep();
>  
> +	if (nfakewriters >= 0) {
> +		nrealfakewriters = nfakewriters;
> +	} else {
> +		nrealfakewriters = num_online_cpus() - 2 - nfakewriters;
> +		if (nrealfakewriters <= 0)
> +			nrealfakewriters = 1;
> +	}
> +
>  	if (nreaders >= 0) {
>  		nrealreaders = nreaders;
>  	} else {
> @@ -4122,8 +4131,9 @@ rcu_torture_init(void)
>  					  writer_task);
>  	if (torture_init_error(firsterr))
>  		goto unwind;
> -	if (nfakewriters > 0) {
> -		fakewriter_tasks = kcalloc(nfakewriters,
> +
> +	if (nrealfakewriters > 0) {
> +		fakewriter_tasks = kcalloc(nrealfakewriters,
>  					   sizeof(fakewriter_tasks[0]),
>  					   GFP_KERNEL);
>  		if (fakewriter_tasks == NULL) {
> @@ -4132,7 +4142,7 @@ rcu_torture_init(void)
>  			goto unwind;
>  		}
>  	}
> -	for (i = 0; i < nfakewriters; i++) {
> +	for (i = 0; i < nrealfakewriters; i++) {
>  		firsterr = torture_create_kthread(rcu_torture_fakewriter,
>  						  NULL, fakewriter_tasks[i]);
>  		if (torture_init_error(firsterr))
> -- 
> 2.39.5
> 
