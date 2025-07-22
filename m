Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA328725F;
	Tue, 22 Jul 2025 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222268; cv=fail; b=le4d9cmIcdczAtBr/GgkEcp1Gp3aTBHAsbc9LomSijHLsJUw2cffKEAp1ulZp98dh/REzZwVGluUkmTjelz7dbsXxzllYHqL84fRYnCPRVkU8/SXhnsQSAXczS1EFNyZggYJec7WC6fetMtVnaHimyPhiaahNCsHaaM87GHObtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222268; c=relaxed/simple;
	bh=DSgyKeVrHSLz2wjh7vHzbusiKYlx38xfrwFn2FPrQiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EUY/3a4KJe6cqIgytSgVjhmhWpks+Ef1S3P9n922CHK+eBZOwn+/7f9g4bFLQa758L5q6vaz4zr696l+PQtfDG+/kx5Iu94PMk7Lzf36d4RuRKd45DMAU52r9VPo9ZvUDCpikG6FARis/DTLk1v1VxUZWddvWHmtRY7T4Fxn+k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RNa1kpMT; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNa1kpMT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcRkeyTxf+zU8qiSfv1z/iyZ9CkO5mdmUeiOZt13hc+NsIQAJzxRPLuEHBf4nDzukNgHIeL7XCrKSvnwXztTeSXxdjn74WlC47WrizABJ+I6BZ8p6t1nwkdMwxFcMboO3yAJJ6LV4rv+XEeTsgbGjj9OocGJgSN3jr/H0M3lKCCX0CpqzaKvOe1D0oycdJqP28nH4PyVK6gHQcv1Qh13J1lIrJRe8AxLvuR70AmFaHpsAyDIdAxdRFbwtv7KiVV/3wa1Mc1PPo7AN5IKc7bwvSmVRt+IF9WDDQtz4hQO84hFeUlqLcjN+jEXXruJImdfFEZ1vCRTF7N+XcJtt2V9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/p3gpCggnNLDLEJ3cshl+UAZ0ixyybKIx1mUd46fyI=;
 b=e4+F18jime0SGlxgW1ZQ26Ks3QRQM4/fqZSTZfd/y3JJ8MzKThCMXYxNxTxS0z0A13OEUJGg3UGc+JX1e0lQqMiGBRrHEt+HmSZYcTWe4BUWAl7Lrmti+Vvh7jg8k9G3zgWqy+rUObzPgROP8yrLGflMSGOxPzuqRbnt4as35SHGsgkaUCCqL2iP+BcE+3oQFhhEI8a2xtwW5gc4Qxo1JL/rS5Cd9UcmBsqc3qbULj89avbQ6A+ab7wgMft00FlybFxfuuMDQHME4cNDocoQIzXMdPQnu3ag15ls7un6Ev3B9Z1VO4amlfO6MyqRZCYFAudpj+dboNbN+PGTb8xnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/p3gpCggnNLDLEJ3cshl+UAZ0ixyybKIx1mUd46fyI=;
 b=RNa1kpMThnO6U8WnDxX6obFRnDNyDOgjotTwP1HhXN0/0xWMGdgHo7A9Tfv8cFKX9e5mGqhhiLnSIkAbZUUFzHLybqZAjXbq/ZD2Ch8KZVs1C7V7I4e3nLqYy1FGkTUoWwH0LfMCasolYrnPf3YBSeInOiR1O4fKr31XlGoTPiQxds2WJntqJk/YvkcX1CobAL8Ms8Us5OWnX5oQ8P5wcsWtzlVnYOY8Fm1k7FlV0mEIbO4+T0x8R0RFYymWVWTovMCbN82KopEiMYbT1FdX+PRWRItUQGuPO78Cy8iCF8IlBsasTfY7O+IrLImyl/CtXi+zVcGHis6kGD7x6yWFkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:11:02 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 22:11:01 +0000
Date: Tue, 22 Jul 2025 18:11:00 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 2/4] srcu: Add srcu_read_lock_fast_notrace() and
 srcu_read_unlock_fast_notrace()
Message-ID: <20250722221100.GA377047@joelbox2>
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
 <20250721162433.10454-2-paulmck@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721162433.10454-2-paulmck@kernel.org>
X-ClientProxiedBy: MN2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::34) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: bf315c7e-b056-47d9-3ff3-08ddc96ca4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wCPCzuykf0jQFn6j+BkF1B2AyFPO1TSp3DE8CO5RwzKxpulKl9VLkJpSMGAf?=
 =?us-ascii?Q?WkpIxuta3AfZBsyudb3/az5UMwMbqaoIBvr64TyglUm7OdyKGlSJbXazw2cR?=
 =?us-ascii?Q?qjD45myuDS2ydxUvrTLEK2ZtkzwucBniMRZnuTYk3sMz0Icl+VA2Nxy+9J1A?=
 =?us-ascii?Q?ncHxAqc+nGYrUfr6uzl3Tk/IRtjGcHrI4S3LGti033mi1JD5Rfz9atDf82sg?=
 =?us-ascii?Q?SIQUorqP0AV4itLkPZJpN7whQwdbe/UJRXH/cVkzHFafAam4BAUyyq/2SQIh?=
 =?us-ascii?Q?9TwuJYlslrHLD7nLsDtzvsbe0+ecUzGDzALlxrJGjicPZ9zeCP9dgsdP/tWv?=
 =?us-ascii?Q?DsK5BySZ+DjJwHZ1inC1ny9KP9dO62IfI94yyfYmpIxjUVnXtApcukAYqLYv?=
 =?us-ascii?Q?9AAoWtC/nwFIvqMxPB6rNz1/fJCzGfayYxvzNuiDmBSWTkrIde6I5bqYvTaK?=
 =?us-ascii?Q?At/7nzc7phth6LuqA0ak/sNvERyruLsO0W8F0NI1/yGOieve0CLfzVgCaDZb?=
 =?us-ascii?Q?PiN3zb/RZ+hMjmibMuE+KXT9nYXPpGouKYOdzJRxChBo0mpFh93WAbrOd3v1?=
 =?us-ascii?Q?F1wvSeh5S5sCOgU7f2iyVif4Plpwd9cPC827NwMAlsbw7DSOZSb9FniRSxYr?=
 =?us-ascii?Q?2WxvABVVHkayIBAKUa49T4cD9yAbFpvYkfP81LE9+3A9Vt2qxNl2obyq9TmE?=
 =?us-ascii?Q?ekyIPf5Oofin33rNm7av+s+MQZFB3z0tWLRQ5rMnAFs0KMgbQoDnLt+WI3WJ?=
 =?us-ascii?Q?OyQS/HPfDIwa3xku9MbaYPQmvAI1jN2JOKa27XB5XmI83kY1fYKCyUGEthgR?=
 =?us-ascii?Q?zKayt1DLSK2kaeBAj235KDOF/GyMygwdAZP9OZ7z9oKQUuPL8MwjlzIv2mng?=
 =?us-ascii?Q?0lSFepmuJO1XiLdYGRk/YCH1ma4Cpk60citVRB93RCHcD+hUrxr0WmNLPltb?=
 =?us-ascii?Q?fZGh4zI7IygN1lxILKpUKEqQ4pK8kE8vHns7Rz+hxDF4PbvXU7dpI/r1At8Y?=
 =?us-ascii?Q?Yu4erhqJ/LwnNrG9b/ReDC3p5Fv8ggfVzMK+O96pvt6k0yukrjjAW10ykurr?=
 =?us-ascii?Q?qW1pLf1ui6UVDpvmlCS9wUxvvMEZWclYZ9HOL1lLHZTc4zz7aGbc1gKqm4CC?=
 =?us-ascii?Q?DsRfQTdapMOitUVXsTu6iIlRTUxolo/2loRBSLXNczKvE0I0KfrQC+hy/bCc?=
 =?us-ascii?Q?Ky1JikGJGjixML2+OwZm7w2QAmaDk8vUsPXMzMwMdcuqr9ipbf1hBZG8Gj5U?=
 =?us-ascii?Q?NBig2lb5S5UbvSWnsx633DmYPnkdfY5R3G3FXCH+JTYwQgp7AUj12xo0WXNL?=
 =?us-ascii?Q?hyTE3TykxhGBymwtXY28n6eDZO2AfNsSq6T3TS9f1FtlWAy5e7V9M5T2fwlH?=
 =?us-ascii?Q?EQECMWX99l39PCteaHI7lEPcJsebo21PPPf3HSbsxquizFh6jygLHzvRj7Re?=
 =?us-ascii?Q?FjJM0QYK3GU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GhC9SWjTq8QP9Z5soLfksj8fst0Sgotdk4tpIDDwUQvatVIhKzlcVIfb3ztc?=
 =?us-ascii?Q?g4SZ+IBPhrsSPeTFYe66f9lj7aFQVlcY4spbLZqiXYh3sSuc9g5fYxy4UN0W?=
 =?us-ascii?Q?ijC0huuJoiORL6B6Z8YlowqWrqA1uY0gJ1sF/Cv8Lj3Vk+N5uFJAr2HzA0SB?=
 =?us-ascii?Q?+ngalKkWRWqIC62i59KsFE8VBcyrB0UetyZ3Rnw/B0Cyo4h0JXFjxASFSRuD?=
 =?us-ascii?Q?NTv+aSzOWsEp4Erm7iGx4cq40By6iYvzogjUbImk86SfGO1jlaQ+tSE31upZ?=
 =?us-ascii?Q?fclnhD2y3NavSe9jk6xR0zNk5AuaZ7YGn70mDOfI4xxlJTKXPaa0sYgP6XMY?=
 =?us-ascii?Q?4MAc5XpVlDeKceqL11//iSxRhKwZea0hs09ZIRsKfAU14oBc0b1yD4H+4l7W?=
 =?us-ascii?Q?tdrhWV+qgJuMou8QDo0WoJPI+gZhOeNMb+lnQ0X4t5IvlikPFpMCo4MFYBXQ?=
 =?us-ascii?Q?Q7i+jq8o5IWr9dU/8vWCwaF6+mOPkLabdR7nH988JGnGpkS2KyJ0Cbes4PFJ?=
 =?us-ascii?Q?Y4IlCsROGZV+A/qYpbJexzv+sbuCvwVS8IKG45JF/mL6gl+GS2f4ANAnLLqY?=
 =?us-ascii?Q?Yh3Ew1idTlvWCeJW6cEjWcCqe8EGCUQt4vXWkL0pzuiIDMeTBQW1Drixzt6h?=
 =?us-ascii?Q?LtbB2c1tQrhRq5gTb+8Ncx8yjRPRy7AQ4f3I5xqbtxtdlGdv7tpcjkBgplG/?=
 =?us-ascii?Q?4y+4Vbp4GqxtBisyBoKz01Q5GJFkMvDeHUwHMtLQ6XFruaZbH0DAmhg2fNt9?=
 =?us-ascii?Q?/2a76nTZLpm9iiuF6mStm0q2+EQXtJYTfAdMNkQ88d5a95vnTUYxXLTijxX+?=
 =?us-ascii?Q?GFA3usQ7q5/hqntsfFt17G/D0x7UH4+uNkhHfpMJMY5AkVuLCwwdaWleYs/Y?=
 =?us-ascii?Q?FrmDss3MWeVH4LD96AKnS2dZX03XQYCBSDVXtVGemgsXcBe4XNvnGIMIscvU?=
 =?us-ascii?Q?uCcRL4Qp2CmaReutD6DPoI7Iy54hlZdRlxa/8J85fILYeqGA+rBbY4v/Hr4d?=
 =?us-ascii?Q?OFyfl8mEPKEwV4KKykiBOj6hbTt4gqDNMFb3p7NKRlh8B92Hbv2SkBBrZd9p?=
 =?us-ascii?Q?SzOCjbLlaUioWzmxQbM/TUFx1Ldl+ZSnB3nWPVMfNMjTX9uMxRWV1ILTPxMn?=
 =?us-ascii?Q?DOnU505sQ13Z7Zvu7pDm4ysNxEWaRxEp4rLBxPrn5VsxptmEfJWqkcaIu7b5?=
 =?us-ascii?Q?Cg2qPsAZoVlZVXc05P8mv8iyj+rxGVaRSqizS3wE62UNgsa8oL7QKQ1WAkE4?=
 =?us-ascii?Q?x09uMnofaCn7bRldH/H9ejRqzAXTUWzXs6yy/aaPRSOb6iOiZp9yq/y2/4NC?=
 =?us-ascii?Q?Wz3DkfNUxFVSd1aeKYT4HE0BQjpbrCl2zqgzPE7al0Mlsx7WdgCtu9wH+250?=
 =?us-ascii?Q?DGbpRzWSAObwIL74n4Y9ThUcvbaLeNf0QnFs5dQGcOEwqiiG7gJ25zjyt+Kk?=
 =?us-ascii?Q?UkxuztlXWR7rm+jjKBJE1Ilx3ZBAuFnbCSXklDnzl59YVg9xKlsdioYgGeIl?=
 =?us-ascii?Q?injMlJ11tae8//p5zIvEfh30KUwTN2IsIThgKk1bGqfEE0uSdkfhK3NselXd?=
 =?us-ascii?Q?B7xa1BFXGOyoUSByC/yliwVQ2Na8R3lz9rJwtSX/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf315c7e-b056-47d9-3ff3-08ddc96ca4f4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:11:01.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/3KVXE4J1kkM8i+9X8EkWL6BHJxcYV94miCJF8Crj+olcMbV1ocpNoFtgidpRMfbZotLpwrNcwwXXqwgQYQ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

On Mon, Jul 21, 2025 at 09:24:31AM -0700, Paul E. McKenney wrote:
> This commit adds no-trace variants of the srcu_read_lock_fast() and
> srcu_read_unlock_fast() functions for tracing use.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/srcu.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 478c73d067f7d..7a692bf8f99b9 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -282,6 +282,20 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
>  	return retval;
>  }
>  
> +/*
> + * Used by tracing, cannot be traced and cannot call lockdep.
> + * See srcu_read_lock_fast() for more information.
> + */
> +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
> +	__acquires(ssp)

Should these also be marked with 'notrace' attribute?

I am not sure what the precedent is, I do see a few examples of 'notrace' and
'inline' in the same function signature though.

Other than that one nit:
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


> +{
> +	struct srcu_ctr __percpu *retval;
> +
> +	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
> +	retval = __srcu_read_lock_fast(ssp);
> +	return retval;
> +}
> +
>  /**
>   * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
>   * @ssp: srcu_struct in which to register the new reader.
> @@ -394,6 +408,17 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
>  }
>  
> +/*
> + * Used by tracing, cannot be traced and cannot call lockdep.
> + * See srcu_read_unlock_fast() for more information.
> + */
> +static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
> +						 struct srcu_ctr __percpu *scp) __releases(ssp)
> +{
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> +	__srcu_read_unlock_fast(ssp, scp);
> +}
> +
>  /**
>   * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
>   * @ssp: srcu_struct in which to unregister the old reader.
> -- 
> 2.40.1
> 
