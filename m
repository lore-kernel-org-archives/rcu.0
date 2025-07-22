Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6D280A5C;
	Tue, 22 Jul 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221894; cv=fail; b=LHVdY17J7zGRwjWU1nyz/enRbuNSkMT+Udy5IPGkS2HQQ1qy9TdtivmVce0UJyrTPaX7ntglq/LWQbRx/9WBI7FQKYcn/4+5L0757kNQ2REowhdqnY0Ih3/kH6VYwuVplaLtO5wVxx0n+RRx50ZxFOz31TapbJ2p+o2KSvhcsag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221894; c=relaxed/simple;
	bh=amNwqheSlHatBwROOVi19h5pzBAP/KhAsex9UIP1awo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hA3aI0yZjCZUtPhP+hC56tZrG+MjbngsikDlpz0AKK6SW++W+694i//SF+Ofm6zi9l9wXstaby2KEZ32ka7OltVQ+rUz4t6IGmqqGeFb/s8n3lOu8IU6/1oBfXA0OY1zeufVsFhiFLePtXWvrk/JI9q75Kt/5tqzQc3EyGgdZ3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KOQAx4x5; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KOQAx4x5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSxF5qreuh1MFXV5S47e0IZAOx7uzggUQx08PpIafhbhoPSSVsFGJv0s75FrTXe9HO1Be37sS4HQdaWgZt11ck5d+MuY6ucnYBPNEa/d3yLq34nwFF8PBuEYOcW14ogjpgf0S6HKAWbqJBBnGco8qBbQtpdFSNTm48mLEA/hn3Zb5tfc03IuljBaEDzZmrlCcGAy51SbbG4ctzH5KYVxs06QzbCLhQJ+lVmi3e0nS0JWW38VN6l6RIkJUrCP6OPZxASy3BkhJhUuS8yMD6BUeNmINGCmJHXcy/TNJj9S5sLeiqAGUeb5B+ElLKQCSRKqeUpcCXd7YijbYm62Pl5D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQIUBBAhh0VnQk6zI2ks4HourXCI0ssqN8yihr6Kctc=;
 b=CEDDZb7GXA03kAfpvXVeIRqC64IVDGpjFnt4XgKlxlVPrJuoCxVwmAZCswPWbn1k6WLCu7EmXNeHQK608sEPOOwhGyZCL/3Ygbl8fOI9JJuxFHNXVwORB4skSJyu39DR2NHWas5G+GAJvdH4wPTjGPM/gHHPCUW4mhXfZK2+xqXmEjtO97ogi10lBvP6Z69DfKQSiBj8vddj/2lkzw6daDwm70rrqi0bQbc8mCddaGtJqdbFPlWLE1mIbxMRs9GKSOZsaQStyywEJzO3lLdsXx4q8ChXikshgINxjDlcki0A4Zu1vsRVii/oaTVcTKfLRGmBNsjswS7KtzUP0EH95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQIUBBAhh0VnQk6zI2ks4HourXCI0ssqN8yihr6Kctc=;
 b=KOQAx4x5Y2QAm8ZkFk3qCen1zlUGWlhKp9oYaY+N2jKrHsIzM9WLDhGfTy/4NynSEtTLBYlYt641bD+Mc3vIVCmAYE8n185uqQMeofmHrRLhS94aEOz/14USdJpL/K/BmRkDnlR/DsyuJJ6xex4a9QXOOmmVMZm/qoM1C1IbV7ba7OynhOztU5qCzYe/yD/pRaKmZOKtOlbg8lm6yAYe3GoIS/KX57USspWKdkRz8pCu6sFAci67khLO1PYGrb2gpS08YlA4HzlR1+f3We/fwkJzHxjw3bAWPO+a0bLWDmsT+oO2UNEe+zIIFqWZjTaXo2sm7dihOt/L0GIh7OGDVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:04:48 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 22:04:48 +0000
Date: Tue, 22 Jul 2025 18:04:46 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 1/4] srcu: Move rcu_is_watching() checks to
 srcu_read_{,un}lock_fast()
Message-ID: <20250722220446.GA376252@joelbox2>
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
 <20250721162433.10454-1-paulmck@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721162433.10454-1-paulmck@kernel.org>
X-ClientProxiedBy: MN2PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:208:236::35) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6e1fb6-9730-4d4c-d509-08ddc96bc642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5XI73JGjQ08m2V3L64siintTgJdy63hAU7ZFzJkH/QBwwN104dMBEoWv/J9G?=
 =?us-ascii?Q?x1CJ13fL9rW1jqIcV58aW/CNBuqueFExIJEJCj4/ysEW6QnnukSmB6Y1Velg?=
 =?us-ascii?Q?iJOEc+yJYHu+Dwt2ZOB/m8K1LN0cawTN0zR69j2tR2IZYZ95JcPjHslVTRhw?=
 =?us-ascii?Q?GcvU3Lavb0nIsYctdVKF/h+RA5XwkbEwEmMa4vkAXx2zkLlGQrCRJ5bhfMF2?=
 =?us-ascii?Q?YGVVbKwFZhhioPAJdbAUkGYj88jlxO6Advntfn2/9w0DJ+3IClwnpDPZjnFx?=
 =?us-ascii?Q?R4hgPsbz+EboveE8qEwHlYGOI9TBfOmoqH0Ex0sSDGeVsI2mFZpk+3S0T2Ah?=
 =?us-ascii?Q?6BF5VTeGEUM/cqWZ6fmioUR9Ir1O+SfBTqzV9SjikqEtyRahIcjbd9uNAchY?=
 =?us-ascii?Q?eKEm6xt0M3umWB/Gkr8l8jtkPOe1Mc37VjKN46bLd3JAEI9u9vknNmbjAe26?=
 =?us-ascii?Q?Ss2HLBaYdhwyonWf39LKp2olCXJTF4C+0/d6G4Qw2sc1wMumHcdKRr1pOb5G?=
 =?us-ascii?Q?l3BFuOHH6hbFR/Q7dHd/YnrYxnWaHarGDVXqmyf/oDOo7lNCp6Mzck1kNhIA?=
 =?us-ascii?Q?VkrY7W3ik8CLoF4WDtk7KR/TJs+Amqkn9IUsT2MrG8b5EFrq7QOTLC59l/eh?=
 =?us-ascii?Q?3ON1RLXwVrTHq4BloQ6N9vPvlXNkZ46YEo6VOEWqJ7edUtzeAjlybkh95+K6?=
 =?us-ascii?Q?oukHbdcihowKmD0XZp5qzoAitnB6eZZN8gzEC9y+1mprbx95FaNYiIxIqZSS?=
 =?us-ascii?Q?T3BoCFU8EzVTvnBf4xfbtxNPwvHqVSgn3+fVVYrGNRl7pbuwvUfhCTnDaDZa?=
 =?us-ascii?Q?gOfxSsfMVSy3CurhfXtSl2zWSvnWxpyFSyqbk6r5LszVI51rr4M0rcoZpUFQ?=
 =?us-ascii?Q?Zbhj8oyl1hNj5dCkFPQkpHT4aJchzeuDPgQe4CnwhFA1dsqo31+Jj+Zi3yxC?=
 =?us-ascii?Q?9LBHuXC+l0FIHeO7SLoT4Tq/jVtAHYSh4l7rYZdrr+Yx4TkbpTasP+chkKh5?=
 =?us-ascii?Q?3W3peY+OpDoEfobEGCEEcydQyapp0LPB5oqh5XyRD5jvw80SLSrGYcfhvuk4?=
 =?us-ascii?Q?S5k1057Nk6Iv7cbHPFlBK/2YeDhrzbSiKdJGKNnNJXA3b2b9AlINTMtzTAkM?=
 =?us-ascii?Q?nnLgj/fdp/G9QOxocSMT5knNCUxTLN2T2ERfTAfg8SEG62K0++UwJvS5U+T5?=
 =?us-ascii?Q?0YCwI6TKvbOZmCZRO0adSigkdXsuVei7FFYUlZj4pOOgfd0VEpgXRejcyWPm?=
 =?us-ascii?Q?mFcijgElEWjyVSWnwsyymnStky5J5dofAz31mhmNJmb3OmL4YOUbSU9iDNTG?=
 =?us-ascii?Q?CcHCEG3Zr1z/W6vF5/i3qGdlocWwYMa/wVa1J5W/wDuuQ6R1oWaiEIEykbZ3?=
 =?us-ascii?Q?pPnYV8by6BZXWCz2ofAP5AA3g2DEXpiuJ23lnuojoZyhs8ndyCjCUiz0zzJ/?=
 =?us-ascii?Q?12hEE36vRm8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zoy0Uni5JoRh+qtecb2SlaxqwMW3TDHgnjgmGnlkONqLz5ffHEIOuoBXDV89?=
 =?us-ascii?Q?snZqtrZyjd1eku37wFUaMUJ2pWJX/blkY8L5zm3KI6ScoUq6CBW2S7xgDfKP?=
 =?us-ascii?Q?C8K15O8TmAmGmGOwNQMpjA05HdNbWDWuGiW83cMxZTb0xtNWhVb6fxsS/0/g?=
 =?us-ascii?Q?WS8HrmTrfHTqUDt/vTYhx3UK5dUuR7aWRHPkMTJFCj5RUG/vZ6HKH4AA+HbL?=
 =?us-ascii?Q?BjJFZGoZK/4d8ubfCsHRiy6sVx7UniNiXCT0Th8rQvwCEQkCGwTT0jLqOnk1?=
 =?us-ascii?Q?w7YiayVZgRStpxZ7sv/fkdqxAQSFq56XKibngQoIJQ3/prklBK7dyA2lZFTv?=
 =?us-ascii?Q?BYtSm6AjKlqY4fl4HyNrtDuDzuOY1f6mUYtEbz782KTgrqZ/vCGEs/+D5NE6?=
 =?us-ascii?Q?NOZyjw2BBnUp7ZgFMqlMKhcQg7FVoq5ae16zvM2fvFOQSydYK41H4/79y3r7?=
 =?us-ascii?Q?hLl6Fn/lIwESBAm1W8LGSIIYkut6HqcYqfyL5NQMv3GaMZnUAN2SMNidew6x?=
 =?us-ascii?Q?LwT9zJcK1fc3E6qE1vpe2RpZ1xMofdAsEOnP41Oym6xMMi6NO7wssl3vW0Dl?=
 =?us-ascii?Q?WMAjSrmLNbYrYxhTIpXNnNE45eSlFeTnALhAjBKV2f+uJwochs6ZZtIw6BHX?=
 =?us-ascii?Q?KwTsnyClqngpG7C1oahcqewGyvHzi322IvW/vY0BhzcYVuprpTd+1bR2wuWn?=
 =?us-ascii?Q?Ke9gD8mUftMuCD/zNb3j+M2vYkXd13kbq6bmRQJdVNomho8z9GaBMrgddENg?=
 =?us-ascii?Q?lj85NeHymfdqXDXT9j2T2iLQLLKRsoEWHQnqgjPlxyD9QthFteAOSOa0an0m?=
 =?us-ascii?Q?sCvxYGlwwDiu+8rx6F0kLc1ycdtMaa6fgLt8IHTnmth0xeEEWZVfmvSpdwQR?=
 =?us-ascii?Q?Ulg7t9wEvZIaVUI79d9cod3V6kKB2rOgq9OQooLk8E34zqTCGtvWwk3vnmdO?=
 =?us-ascii?Q?PtzU6A5fXwsdmIX8gGpgU8f5IDqOwXxHwRYUD2WWGLjaByBhDUeBn9CZhwEP?=
 =?us-ascii?Q?poib4r8BBC646bFf16sJrf5utnkX61/C/DCPX2iA7MbUsZiB2efDKCUFu1EF?=
 =?us-ascii?Q?Ng9nYT0Eq/+7yOo0hUJc0NJOOZfpRKxyN998LLVDdv9qnnm26dsoO/gaBApk?=
 =?us-ascii?Q?sWnlZxryWYZll40ZvZkI4yX0Te6VANu0iK+7IyjSVCR6nPww2FCQfcdHXpFV?=
 =?us-ascii?Q?sEWV5yst5PkKU9vZtwyNFESS29QbiHSX7zcF0U0NEMG+0UqzYtcn2WElpLs0?=
 =?us-ascii?Q?6xNYWrfXUd+KThMvCFzWZObQkobB0/JFPtfmYyyaWLz45qEcrvdONT6TkgJ/?=
 =?us-ascii?Q?E+2n/KuzzfO3m7wm5O8ZMdnoWbxSEr/dnABvJ+OghvStFK0iiZm3mZWv70oh?=
 =?us-ascii?Q?w5xg80i2+H6ukYl2sBJmAYwP1O5GQMi8rAEUx4STC9qclWgKM5ewQDrfrvtb?=
 =?us-ascii?Q?7ncm3oIyyRwprhPxgeQUHLkArk+eAwkZLnVLJwUNwqJPxGi1XAl1BPwwLn3h?=
 =?us-ascii?Q?uVG8wclKlImfCOFxRo29lkA1TMOLFYTNYqIpj1mKXq7H/l9RzDh+ez2NrExU?=
 =?us-ascii?Q?WNw0HDwRWzsZJYQk+P9dMZw0T6LT9XyWw7uRLeoa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6e1fb6-9730-4d4c-d509-08ddc96bc642
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:04:48.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeVUc7YGXPYXUAgcnDxFD3Tr8hfy+OFg0BnlZAj2SemABlqtnB1MREraqll4x0ohhvG5JGLKOeQhrno+Uog5Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA

On Mon, Jul 21, 2025 at 09:24:30AM -0700, Paul E. McKenney wrote:
> The rcu_is_watching() warnings are currently in the SRCU-tree
> implementations of __srcu_read_lock_fast() and __srcu_read_unlock_fast().
> However, this makes it difficult to create _notrace variants of
> srcu_read_lock_fast() and srcu_read_unlock_fast().  This commit therefore
> moves these checks to srcu_read_lock_fast(), srcu_read_unlock_fast(),
> srcu_down_read_fast(), and srcu_up_read_fast().
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel



> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/srcu.h     | 4 ++++
>  include/linux/srcutree.h | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index f179700fecafb..478c73d067f7d 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -275,6 +275,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
>  {
>  	struct srcu_ctr __percpu *retval;
>  
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
>  	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
>  	retval = __srcu_read_lock_fast(ssp);
>  	rcu_try_lock_acquire(&ssp->dep_map);
> @@ -295,6 +296,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
>  static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires(ssp)
>  {
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_down_read_fast().");
>  	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
>  	return __srcu_read_lock_fast(ssp);
>  }
> @@ -389,6 +391,7 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
>  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
>  	srcu_lock_release(&ssp->dep_map);
>  	__srcu_read_unlock_fast(ssp, scp);
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
>  }
>  
>  /**
> @@ -405,6 +408,7 @@ static inline void srcu_up_read_fast(struct srcu_struct *ssp, struct srcu_ctr __
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
>  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
>  	__srcu_read_unlock_fast(ssp, scp);
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_up_read_fast().");
>  }
>  
>  /**
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index bf44d8d1e69ea..043b5a67ef71e 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -244,7 +244,6 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
>  {
>  	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
>  
> -	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
>  	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
>  		this_cpu_inc(scp->srcu_locks.counter); /* Y */
>  	else
> @@ -275,7 +274,6 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
>  		this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
>  	else
>  		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
> -	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
>  }
>  
>  void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
> -- 
> 2.40.1
> 
