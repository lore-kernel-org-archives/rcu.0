Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868A32A801;
	Wed, 10 Sep 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514986; cv=fail; b=WjPYtkrmdyDYe44hTDQIZvKQBEU7GA0jl/qDZxEEhmwMkWIsN/9a0GV0x0dsuLxchDmPeJUR+QOpUv+ainOACdiCkkX8zGBJKlsMgO8qKseWGy2uGbNc28Z57eyqVq+KmO9gFBT9R7rpXrI7rSGzuEBEIbu56vKZHs46FEoB4f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514986; c=relaxed/simple;
	bh=/K8ENBr8VmnaovcpX8tOTK4agAFT0rU04KfCjzQENNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rWVngy4D72jSefEZB2nat6v0P+W9I/I6ZlrCGllozFaoj7feEvrhYIV71p9Qp4QJicIetqVCJzzkavn9i3QEgMZesh/yHRNSgCnyQc90BGYPGZHRZLyiQWQT0TeNipDm2lqUANsoievWr+W2xMAvbx+rU4kMrFXAVD5MyJjihFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqALecml; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqALecml"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hM8lEGMdVkz7dsKSdV4S+x0OrJ1PRSj8+kxDcbnWNXylQzeQu1bVg4YjBl9nRsZ79vaK5W3nCovx/ZdUCbp48aQnh3KarLV67cCUlmTEYBtEYuNRi1mtqy9xy99IMAZC4XcNgl2HGZan9aGP8spFBdObcYvomuOIfkz8uw0NyGNcFniLTKqJ8qg8Qyq0zLnljId5x8BC6Ip+LU3uKzSHL0yNkNhjgiZAHhDT2iySpRF17ahFhwAXLuYSsDkS+Vm8/geQlAZyabKm0VDVjAI31muzCI9WBwIR6bO2to5DOT6cZ6obYGH+v3clYXDY/vD7s5JKrqHRo5Xp9QLTuUy5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6jjNPSXG3tCXUWNs3RViauGxQS2gdUxDn9zdOGiDuU=;
 b=yxHz77RDr14/Tg1t1n5X9JUWpoPb4nNTIK1Bp+WN5tAjrrI7ybKPFDjACVrUZpiybEKlVp182hrtq3E6mU3se9056PLG4uYhYjh/VnRxCsCmy65YVgSMRteed1BQ0UzAwKxtwvMG3SX+dveJH8YTTRwksv/E0qQPtPw+MAhNJBmJJdIB0fLUisCiPkd0wPKENb0PnhFjYy0oH0nGzFuaspmYrutRuZOc2pXfC1svd0VVy3gsf1dI8KqdjkunJL9WJBMNTcvoO14ccfqxghHStNsZVD15imDA+zRH5zg8t6sRo8VDZS2AwqPhcpuVqlF1SEZ23UlDGRj0g7RTb65qxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6jjNPSXG3tCXUWNs3RViauGxQS2gdUxDn9zdOGiDuU=;
 b=bqALecmlhc02O2BiZ2E0iYlycLfPohYMeH/rtrMh70Mef2GedgihWoNLskcSweahR67XkOca2+rzLtUshcvbr1w2R1gNM6bUTgo6HRj3MJJAZB0B5WDICqgAHoj2liTwGnPfqJipiWz0/8veVBQnYvopmvSN7xvf49Zd6c3IOHrtituBoIZtgTUha7O2QvfD7MiGBzgfkU75QyThUYLIp/Yo6jR6fwOCxjWbE5L/O0cuhHR57Yrlc2hhG/ODVCMigFq2261w2TG+Po+vsxV6wnEvmEeRjSe7f+s2O8XemTVt3FSstF6E5dTbs6+rHsiRZLjQrHB2LTHUACXG49aDyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:36:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:36:22 +0000
Date: Wed, 10 Sep 2025 10:36:20 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Zqiang <qiang.zhang@linux.dev>, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
Message-ID: <20250910143620.GA561834@joelbox2>
References: <20250909133928.615218-1-qiang.zhang@linux.dev>
 <4c7d977b-7d09-48e0-9a88-bae93fa5e401@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7d977b-7d09-48e0-9a88-bae93fa5e401@paulmck-laptop>
X-ClientProxiedBy: BN0PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:408:ea::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: ac89469b-8222-4cd5-d54f-08ddf0776996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQf5YJ1aAV/SQoH4B+emDLhF8jejLad2ygDjiSj/4fKFwUSZAJB4BWn3mY9n?=
 =?us-ascii?Q?yHQUaEQP/oXOnAogMs9yFf5NX79DLvUQaYw3lD1oLBU+Myz6FQtP4YDf4uce?=
 =?us-ascii?Q?qMkqR1KDP3wudQ004X8B4rpRctzoJiY6siTaFqSbmq4jFGvmGOO7tGnvNLnL?=
 =?us-ascii?Q?JSH0dSzE19vjWljxChzcQ4XFEp3OQahULg3fICE7m3lZFUmqf5aCZsiaz5O1?=
 =?us-ascii?Q?0IS/0n/SfyNvDruS7iUethSXQ8ygHMNdCqlkGlVhMksgzanp/YRLkt0NfPhj?=
 =?us-ascii?Q?DBSrLa4TGBrA2lGkZ5HSBB/ApHNemR81Bi6sWdRdn54gWAY/3njv+63HpMwm?=
 =?us-ascii?Q?3JzWSNRtdpIDrUQzsZcZITDQxjjrX21WjF8alKDCNXxW8+/T5T4FQuDynm/c?=
 =?us-ascii?Q?0oLAHncRhT81IwyGzVdgmljyHya+MQEKhxsvSYHrMNmQ5VaAvgDIic1Fk7cP?=
 =?us-ascii?Q?T1W9oNVAmXwgfTmpMQZAvOLY6lfr4kTGlC6J6dEPtxOEtieIaRt0r8XyDXYY?=
 =?us-ascii?Q?u4vevjtvbv4mXsc0drq0GBU188Dfmni+q/7CO2Aqejg+lEA/WYvtUIkMUsX+?=
 =?us-ascii?Q?Msh5pMbHINH3fbEBQE0gDWHPueKhXANoB54XEazObdaGo8mD8uDtXeEM7A6J?=
 =?us-ascii?Q?rNaqrmIZ7ttpgz1GT01g2MrybeNjVxJuaNpZyEGzfvW0mh5abfVhGsxpm8bc?=
 =?us-ascii?Q?194AEWAOjyuC8MEzRqeYqSIkQ8IA4U9/2WQgomqAk3i00FYHbGVHn73J+2kC?=
 =?us-ascii?Q?fhX3ihUpqnzErBxBNAmaDmGiDkuoKj+M/4aQutHxbFMd2oQw1CjtC9XSL5K7?=
 =?us-ascii?Q?0PMPaZFNQQOewIOWMnw3w/GIcLYnb8E9F7gaEyLQNKe0t5kWDvEbkWokCE+g?=
 =?us-ascii?Q?ObgUToHPg8ZHQieMgLaK0s4tauHDdFN9zlkDucdrYeSxF0CxIsa19f84Pk1I?=
 =?us-ascii?Q?GK6quh4NcOZgUa3O4NPk7OeNi9RyBluCWVuxjqZ9FC0PVYQxmkjTJNqIPyqV?=
 =?us-ascii?Q?oNIojLpAnSA8svUqYr+vt0lq4ZiDpDGJy3dPAtu24UMnf9UchDINEBERm30Q?=
 =?us-ascii?Q?GCOP4YHiN616tUwYifC1vbnOEp/3HkmHLox1h6sFV0vBKSbTVBvg6YLjpJa4?=
 =?us-ascii?Q?Lw1+yDN3Vr6ERKLwrLbG1m8M0TC/nS/c7xf5/gao2hjP+QzgojKD94MzRwl6?=
 =?us-ascii?Q?DYBHCFgxw9FUyREm2SksXFtCkY7w9oKrv/Ew6H2HgV0lXWJOB11OXGiOYuVd?=
 =?us-ascii?Q?eNTu/q72hKsXTGxDisUV1ECcjuFDe3GzjOwY5nbz1MX1t6ILN+HOuHw+YpDy?=
 =?us-ascii?Q?tpMdDkTl9OHSe3FqAV6nCHMOx8+Shq7oi/u4iBtiRRyhKbW50LNpRAQe28fb?=
 =?us-ascii?Q?+QCH70bIF7S5BtBILaNHeYSCOb22/gfX+2w/UqVy+qDCfGJ1eV+3+lZonYiX?=
 =?us-ascii?Q?jK2Bg9fgn/o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDx4/9PKBXcjAGKSUtmglfmFMmIN81cwJJHG1YfxSHF8nZDZWmlbUativ+Ew?=
 =?us-ascii?Q?umxQXnXIuekAshRQg8jvmCz5ssiZKKI3NQaOq8sG1rj3IFW8SiNXDLlZyBGI?=
 =?us-ascii?Q?4SMZZLHIFKxQRoz1MtUK35C/ZTF9ErRt3j5fGgso9U16cMDhIesv46/78o+q?=
 =?us-ascii?Q?3eI0j6QTxLrynC/mDow5x/xjp/uQY5Q+b3sLrYfkzEWPeIguIhi+Bfyv3Oxx?=
 =?us-ascii?Q?OjS5we9ASN8sK4/NVYHwjN3m1viNKpkPjmXnWdPG0HaPLPf4+L8mPAMecY8+?=
 =?us-ascii?Q?vvaSDfajl7KYriWLaWMRfM87qPKsuxQhbVAToYdUbGB5iOhAJsKyPTmQ1QON?=
 =?us-ascii?Q?2fyOCv6G12AV+9lQxRUpGSYKdMSM1JcyaFmux18ivnuOzG8lOdODKEaGJpUs?=
 =?us-ascii?Q?Fps1BT76lUU2y/lh4RreYg6EWu6IJ7Pbj5wdB1Nsr2LKXpS7pIF0z32p0qYm?=
 =?us-ascii?Q?MuEs9T0gZ63YvBmxLYK4yT5Gg1TSLkgultLGeRTt+Z3JJifQweVs+bNS7Kd1?=
 =?us-ascii?Q?7G56PDLkLD65J61WM/I9E4DhdV9pc8W0jiMFKfBq8SLazGoke3Cz9YC63Bs1?=
 =?us-ascii?Q?KzAooggtUlls1XBz3vv5b58NlzJNRk1GlNWPJcoxaO3wKGRdXIjOp/9MaAto?=
 =?us-ascii?Q?loTqMJ+9Oahm95Ts/JGQqTCopozIn9jm+RJB9qacrPVCWALQjFFERGeESr9l?=
 =?us-ascii?Q?u5NLY0vy0TLIPZM5Ed9Y5SxD7L7YM+kxdS/D5y8wGF4yubLDP0lkEpzn3D6r?=
 =?us-ascii?Q?UML6bWuSfi5YcrrYxq1Ibs3cGoHW4f6M1e6YT7p0OybyvialUJXDmQQsPqhI?=
 =?us-ascii?Q?myQXwgVyXerEk6wjyk7kBlHqFY4FavNYGNuXdGv1GFoP5BTlYXNba/iNeNkG?=
 =?us-ascii?Q?ahd0wRuIoPiLo3RJwU6eRYl0OdmieWFstOoxpu+Vc/0Plcp8W7OoLuY4uHfh?=
 =?us-ascii?Q?z65QigguYC4KgEK5sK62ubNQAQKF9Luu+ajNPjSEcs/uls6wLGopcZN6zhnD?=
 =?us-ascii?Q?SaIz6caGMl7aPuQ2IaY2hB1p9JmJz0uqnhwdkfoKJ5sK6TOVMsD3QYyvxPUy?=
 =?us-ascii?Q?cQxwkt9AnI5O8z6soT8p4PstBqlNcFBNtba1Pu908nuMHe5dQqPxI/sumDZf?=
 =?us-ascii?Q?MozL0nrCQtUl3zFFaDInQXJRY4AjiyfshzpIlkeTseUF0JYvgYYyv6NDVQO3?=
 =?us-ascii?Q?ixIYV5KmelSQhoth0gWMZDryWN9uG9anYGMKNu0OO1TUO94BuBQXqOlZCsl7?=
 =?us-ascii?Q?4/vNjnKjjulI1+2fGBrBQcrQqAPFYhG1D75dhpIv5pz4hajRvlAm/35CemCm?=
 =?us-ascii?Q?zp5Mrwtyi5gbjGYpT7jK30VmLawTth4y2eaTKW6STj4JuMcehRhHoqpuKOko?=
 =?us-ascii?Q?lQ2cWkLpG5d0iJ6C1opVi/L03cATXKm4DcVAHvdGZjm4HIyDS/EN5HcqiJyo?=
 =?us-ascii?Q?+PZcUwdjWtGEkLOOA/ahWxm8TOotXj6QvEthVscrxQOZsG7AfC94/gV1t09E?=
 =?us-ascii?Q?lAGhF4sayQSXE/fvidkYI6w4i3JvUN5ZryoVTLhCxR/w5lMo2BqMXMkWKta/?=
 =?us-ascii?Q?cvx8yYp2q9BpwC3GwewOPhxsgRIOCKvse1D7KVPQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac89469b-8222-4cd5-d54f-08ddf0776996
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:36:22.1623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwJ/YHZ/SAy34WRhG8QfZFQ5xKr7bESQOd/JHfGySOhAIfH/Jog3ywzobpiukl5KMcj+qbm8zZd0QsI3RO278Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075

[..]
> >  kernel/rcu/srcutiny.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index b52ec45698e8..b2da188133fc 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> >  {
> >  	unsigned long cookie;
> >  
> > -	preempt_disable();  // Needed for PREEMPT_LAZY
> > +	lockdep_assert_preemption_disabled();

nit: Do we still want to keep the comment that the expectation of preemption
being disabled is for the LAZY case?

thanks,

 - Joel


> >  	cookie = get_state_synchronize_srcu(ssp);
> >  	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> > -		preempt_enable();
> >  		return;
> >  	}
> >  	WRITE_ONCE(ssp->srcu_idx_max, cookie);
> > @@ -194,7 +193,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> >  		else if (list_empty(&ssp->srcu_work.entry))
> >  			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> >  	}
> > -	preempt_enable();
> >  }
> >  
> >  /*
> > -- 
> > 2.48.1
> > 
