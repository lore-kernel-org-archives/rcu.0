Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD52882D2;
	Tue, 22 Jul 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222591; cv=fail; b=UTGBi3JrVv9ll5QbxO8n9Rn0B1npt5QFGx5zIhvuu5XkMxvnfOze3gNUbUV1kBluIEO6VRcvkPq1SRjqU+IM+a8nY4iVm5qoN1sur6NuWCTKLFYDpL+gXeMvS20dCsYBjYTz6Wc3Hlz6hyMmXc4m2V+j49xvnZDKEs48Qzba48Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222591; c=relaxed/simple;
	bh=v6X5+ecwawGJpLvjQpy+OzyjajSb3ivkdcBgGZkMNAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C29AHkoaqnYPG6EO17RiuJ+p7Pg7Goh8P8BtrHznTEPOII+osMxFCzTiOtI3lWuYjkwNgWSHgNYKt8GE8blU5wEqtgMSBVAUAenWUr+npOCCA5rFJ0ykYoGUMe7kB+/R/Q29bnXZSaMmayJHepu6mp1It5UDTIYxNq0CwmwtRHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sG6a+7ah; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sG6a+7ah"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efgHWkyRgQdOvy8UsKjuIB0uRdGGeyQiVxmMD3k+YCvSfuCjeCGodXp8Dbr3Qz4X7+2rA7Ymv8usSVFIz0Z17UDyYpi2aQEcc0mMErm6AnKNjWnQxrL6V8NtTpN1//cGq8Fu/lmHWJyf60TrlTK2Xo+fdivKCyfXGuq8D7xZhnpOhwm7plw2uHdbZSWfTyEftz/52etS3m0nlCq1aqbUxDIQv8cOyKMUwkdKFhdLjGR1zCJPAZTVC+CWFcL/E/TvNmV+yC5hJn8yjLCxgPmppVDePrAoQJuOayqoSWxE8ruMAav2Y62TttOos7hYAWVkl0GKelwdNys2xxsf6mUu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8rXq0FOxxg/gMIhnTffUjdEr3GVZXTGkRLSjAHzLSU=;
 b=R4FGFd0w8ejoKwnojF+sBxd0BTq2oe11z3DmUM2Z2jR7EOdZ8YeCZbRV9ylGw2Ex+lWCuwOwVn8+9HWs8mw3iqMqKFYO2Nh4Hey5Pq63D4TvIzVRf948tqXPVzFGrbtbH3tQ1NPLxvIzLS5Ez+5hp9IE/1hNHrBQviL3f22kntabHxv5SJcbWf75tscZzi16J+Qz2IoxcvNHbAq75wgh5nowx2CjudGb87OMUHUGAzZjvAaUjnAoq933mMJZwX/aLqKw0yAHdQope+m76+/dicO9dWK9FzO0gS2wln3pQ4h58sLOxTV82ClpGnAazOXK7hIhWw1hlHAvuOq1DcHqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8rXq0FOxxg/gMIhnTffUjdEr3GVZXTGkRLSjAHzLSU=;
 b=sG6a+7ahK0s33wc8OjVwtSqHO4rWPiFmw5SdfM7oLAmJ1fqnKkqlntOHgmK28wHbsN+mITs/4ETqcF2aQXxdP8CnplDOnLzd17IjGhvhsqcF3Gy/11/7g17CFNZFSA+0gvaUgx9D8Gyep3JuaVnyT3kMIYGazdtWIgvNLlULf5hO+RCcBRP1EWY03hgiK/jHfexKzM898lzlodmwAagpe6ofJP02LPWuRqLh+B71QAMsIvz1qQzMjVEFsxkEV9azjUTQR+pQoAmIR0f7PPUSQpNBom/KllUds5yvpyp/dFPHV7BV0MVVNE1K3GCVBbBrmGesFbLQQVAY6eZ7MNbGTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:16:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 22:16:27 +0000
Date: Tue, 22 Jul 2025 18:16:25 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 3/4] srcu: Add guards for notrace variants of
 SRCU-fast readers
Message-ID: <20250722221625.GA377653@joelbox2>
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
 <20250721162433.10454-3-paulmck@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721162433.10454-3-paulmck@kernel.org>
X-ClientProxiedBy: MN2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:208:23c::22) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: e06c1f1e-28f1-459e-7440-08ddc96d673f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HtHcNmLQCEM0NCf88Nbxu5Q0uAeGscAjnQyBz1TDQA3uFXbxgQ0bm8T1VI3l?=
 =?us-ascii?Q?Ub8Z6H+0cm8mwrDi3GCiZWxlVChPy+CmR5kRpDxXbIh7Hb/J2a+rOB6Ez7wL?=
 =?us-ascii?Q?l4//dGuBlw0PnPTLlid0OjXhe0AYZuIkyW24UxU/m3NNxuvW+pclsMbbKAMO?=
 =?us-ascii?Q?0u47B8B2Znd53KIOu/hQQl+XfNyv7WPDNBGy0mA5pk5fF7GFznhWo0dRcCfs?=
 =?us-ascii?Q?bMYCfKZAU8I3cGSZU0/A4TlrsJjrRcRDi2wKlX8DPMRAGV+gqsKsFJVeXjWn?=
 =?us-ascii?Q?mJksSFye7FRmC6BxfuiyfIngq2wcqgUsHHNbsfZaklTRoBGudzhsHUBLV7wq?=
 =?us-ascii?Q?r3lpuzfRZtYOv6BFopHy0RVH7j4iin9WI3dEAe+42EarEQQXNCcTXwHpFjSx?=
 =?us-ascii?Q?ujZ8l56stHvAFYYcQUbfAKfU0egzV3kzqvz53m7WoWTZo8hTAErEMEmjU+LB?=
 =?us-ascii?Q?zaXwfy4jCUZanMTTHuQNrUuKTvY20OE6d1lxDI/5risS81XmAKzBcmA1nVmt?=
 =?us-ascii?Q?PlHDxjjV1gCxpJp+4VTHHGQQnzXmxbK9YHZIH+/kCq/wbM6hQ6wZJlE8sALW?=
 =?us-ascii?Q?LZGXz3e/rsQZ5xFb/oBwByxHAI/99xteHmIrw56s5iBcZrGuy5pj+6oT2UAv?=
 =?us-ascii?Q?Ke4soNXRua8G2sF6u9mdTHuU9tYqWYdQZ1cMr8FcZ67gwgGE+KKSuRbCSRZ6?=
 =?us-ascii?Q?EoE67kSi9fuZSuKp9V4ok/HywGmYJSd767Rsiu1gQr6/plBU4a7g99Q+rKaF?=
 =?us-ascii?Q?lv0v64RQDhIa6XVoZSafwbsj9DGNgYi0X7akocHVwQQ6v2NjUcmjA+eDh7Oh?=
 =?us-ascii?Q?n1CQjSGYVcyvlStLbBTry7MVcLFtyocEYA5m4JmjXtrwcz8j/BpVLnFyn84G?=
 =?us-ascii?Q?x7tFfzI6UvUrkR0Y5gwkXJRGiarugR/Dg2Cu+YSpHZsMWTt0iYAllagy8Lqb?=
 =?us-ascii?Q?3HCQMTLMPnZ2Q9an9Qds0P0GtDPfainOXpwkhCWIIVyuMRCQ9D6yfHZBovDP?=
 =?us-ascii?Q?aoHrVLbM2SX4JtpgOP4TJYzEVPsddh2gJNtXeRDykOGouTMNmwPlYEkPWClq?=
 =?us-ascii?Q?WP9YZP1MaLcM96LjwWg7jS4p+Q6l9kYsif47pofOLtuEosIjQfEcXFfg+4r+?=
 =?us-ascii?Q?UR3gDIHzKgDpQAJuIhTKcX62hZWu11YCGtv8AnKV3arx+opZFHLG4Xg+eClC?=
 =?us-ascii?Q?AGMJ0NcyOP44rVN5kBeB3Bhcy1wOJFHujM3FZFjvWBDLrPCTlmfQzfz9TBGh?=
 =?us-ascii?Q?SafV5yOJDEB8otFGakQeUMXFdQtaaX91SOTMo/gp8z1ENKwQ7BOo4X9R6iTk?=
 =?us-ascii?Q?iWbi9nGNU+xbQ6LZ/WiSSsXLMm+QR9ZakJQtvf/XUyontyD6iT3m1mcxycoD?=
 =?us-ascii?Q?O9mL8m6UwOl67Cqi6FZG5p7SAiMbJ5OK1poutqFPCpFgt7Sl+DNj2Up5BU9D?=
 =?us-ascii?Q?F31wG0x+h+k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7iZZ46k2KrQhrnORnhCgz/7rOkQKzMXWGBthB5UpMgkw9tCmzZpO0iSeHnrk?=
 =?us-ascii?Q?ja2r0YzcYnNwicOfNMYb2PD+3p9nSOHPJ0O60aO6BozunUNf2BqiWB4x2pJU?=
 =?us-ascii?Q?ZGILYy6kzIb8CY6c2zJcLgkvzxI6olNEVkkbOfNxsIBrGMXAGEskhpQwntHD?=
 =?us-ascii?Q?1Xp1TPqNLi/HM1Lhi+fER2Q5285jGCMUyDYqmhRKC2Svqv4/7Buy3i4A1CtN?=
 =?us-ascii?Q?psoBGHzPkZJPSCr/wiUU7GSDpPGg4Pw72oCpEjmLLaot2SyEj5T1KwXRjHVA?=
 =?us-ascii?Q?/MqPHPf2Ty6l4F/ltCfXGFT+7pzZdSyOfuPGOQEKnxW5sCxiBAT1ZYbCXTJC?=
 =?us-ascii?Q?jCUQS37bkZajzXzwZk/CFRXwrMS116n+RfEi9Zac8GUsGFwEsJR4JFbUcHp7?=
 =?us-ascii?Q?KG+8YojNpUvzD4vEHP5Gvovff7bW/YttxDwqyztHMP2t+lFNASq3CQPZWYLr?=
 =?us-ascii?Q?l+/O/f/6UH4jnDea12S6uWhgCVg4r+ehPvT8NCov4v57xXcwLg0rADc1bnPL?=
 =?us-ascii?Q?JiwkH8LNiyuF5Q7j2CLGaJR7QYFD/nseoTSRD/7eKbnC4Ook53wcWALU++Ue?=
 =?us-ascii?Q?Va2EWtDLDuVZuGRpa4R7E8wwLpbZTLiQa7ySM78uw8JxnllSFtUn8EqR11mJ?=
 =?us-ascii?Q?TeI8NNDEMJlN7fIly+WTwEZfvHGv1/gI+FlxSCPhL9V4nY/WdnDjGx7/3g8P?=
 =?us-ascii?Q?wwRCH7jeznFkPO/U0snOK+fSPrI27Xr5nqnw5ejTrNTzAnisFCIUBvLU14aP?=
 =?us-ascii?Q?nf27JJPbh+srO1JSKH92dloJAW/yWxJ8IMGofB/nxsqKtSx2E2nL0MA9m8mQ?=
 =?us-ascii?Q?OiVBQuSH2DEJjjJ8DAlQfejPDuUxbpONSWyhFv7hQufxn4638EDrR9TwHiiu?=
 =?us-ascii?Q?xahxTDBLr3KHoT1cKv1XSzQrlkvfB5a5T915V66XHwFJhZIP+lgnAFZL/ftl?=
 =?us-ascii?Q?efLOXx4V8lPSvsaHJrhStPSBVuL6H+V+htmozeC3Xc6kqKyDaav0qXXRMiXS?=
 =?us-ascii?Q?IKiRmsaHvPq6hohCgdzJfan4RkTpeGBYHJynqRz37ANjOFofrEwJcDQTAR6y?=
 =?us-ascii?Q?IJGhOrHKAtsB80LAnd1n+szbJe53AsxXLGwaAagl7SOI4L1m7t9jzspIgiGj?=
 =?us-ascii?Q?6TMKh+DH4n8Ylizam/OFwwXSl++vKUv6193CFy9sZxoiKiinFXOYQXZrgb3K?=
 =?us-ascii?Q?gF0pbVVyS4aiS0hAjx+eDx3/ZYkcuZbI8mEiotGZqf95pmwSDBzs1DuxUMEi?=
 =?us-ascii?Q?78v0W4gZXrwM/CPhiVGGC+mwosb6Kh/zXDbrYpL3rpBvWCtWkw1qszEObiIz?=
 =?us-ascii?Q?6vGydw2R1wt+bCncYvkP6F2BJ4CPtH1azL6ySHQuu1mbq/sVuaxb5yIwLhu+?=
 =?us-ascii?Q?FwrUHO1XaRVqo5z67mjEAN+KBzzYM4JeOBgPThmY3zC2zPfq3oDSkBKE9peX?=
 =?us-ascii?Q?wDsm2eRk4PYxC2dRSHtiJW4s5TX5z67y9rdhbsaWkhaZCk61Vq4SKI6uBvR6?=
 =?us-ascii?Q?CYCA49+8BNLcW1yxX1hdsUF2lALGUOy1UCWDZoTd1/a8yeurav0bYRDh3Mj5?=
 =?us-ascii?Q?YTQ1kYs8+Mth4MPHgYqdrGYXpTcHmP8r6IdS2XUY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06c1f1e-28f1-459e-7440-08ddc96d673f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:16:27.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDLVkHmV3jgscBOw7HKWg/SiU1qr1CAXqRmfaAqLrMhbWKS9BK5SYx+yKIG8Jpqw7ZFkygaX7RV9OZk3VLLD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

On Mon, Jul 21, 2025 at 09:24:32AM -0700, Paul E. McKenney wrote:
> This adds the usual scoped_guard(srcu_fast_notrace, &my_srcu) and
> guard(srcu_fast_notrace)(&my_srcu).
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel

> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/srcu.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 7a692bf8f99b9..ada65b58bc4c5 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -515,4 +515,9 @@ DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
>  		    srcu_read_unlock_fast(_T->lock, _T->scp),
>  		    struct srcu_ctr __percpu *scp)
>  
> +DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
> +		    _T->scp = srcu_read_lock_fast_notrace(_T->lock),
> +		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),
> +		    struct srcu_ctr __percpu *scp)
> +
>  #endif
> -- 
> 2.40.1
> 
