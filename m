Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4E3C465;
	Sun,  4 Jan 2026 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767555941; cv=fail; b=JF5k7xKZCo4lmlVW6oxPLPezpj0nSlk6smb7bi2GpzI/TMbmu/1wkCN2nscJijrLxfJbMmTpbG7HfnzhOAfkzEQ8ExmfSIQeWTkb16WaRP8I94/7bzE4AhBeIQlFSbGFMIFgaUs5WRazDzl2yX6qvIfCcdcFyPtneKr+QJ+sn3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767555941; c=relaxed/simple;
	bh=P8X5mDYM/8fY+zfqOfT5/LpMr1Edygb2JMiMgrFUczs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hul6WcbIpE4+/8zGW7mANI6REVPhjGQ0jj2tiyXq8hnC5pAXU8DVfNYOBARALGF7l8+T98lsYj1xGoPMfzJJh48D8f5AzR0oxX6rJu8eKcedEaitpBMlZH0uZ/1TZEZoSiaoqjebcMB1w97yJ/4+raRyZ+SKz7YeDsa4YQEJdSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dPUBzB2x; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dPUBzB2x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW7sPdVGARg3+bGxpEisiB8qmifKmmN3JcDJ+gSMJJN0VPFV74e+zrRWFFzue5xRSz2OVd1gPTAx9lSHIdKuGzvs0HbG0vV7bPuH38tWJa4iACCtq3H4SoY1wuBYzB3scSan/nPQ4lKOhnbELfajPgBlt5lmGqcySgqX/EvSxCPHKWmWZ9U89DqWGITyYl6cH0NK1BhnNmOmdckuusLRyIZTqKA63DoMXcXzt3eMKzYAe7esUMZoUZpArnJiQxiYB72tGL8sdJTVIVbUlMNaWTagAmv2g8r0IFMHvNK8mWMfv/Pjo0JDCLrslne+AP64C1QG5MoVaCIVViH5eo63Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c2U7/uKv3tOZq6Ls86Q/wg1XMN7LyRhB8FMFdErS70=;
 b=G6dnoCc9fARcXj1RV/bf3l67Frt8tbhi7sFJxkAUvzo5xkuwDh5tQjGXE8E7zm36HlU1fAnR5bCm9pI5YuWfqO1snHya/vxssUvWQbJLMCHha5yJm5edPguA/CMwzhC23Uu62itUY0yFa6Q4lRtkxvgVeikRm/3ly2b8Tb3LfmISLfzsy1KB7udFtr6gOs91Trgu+UXOWaTyWRxZS6tu8YDUXWrgVzY62CSl3N04d8BbT0JoLctqpm8iWGwVQ/rBjBCYvry1k6HL0t+13iYFAMopG44JWCTDCYrcQrXo102LBxaqKOvaholZ8uJRcr2AWlHDa9RuS26958eR6k2MDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c2U7/uKv3tOZq6Ls86Q/wg1XMN7LyRhB8FMFdErS70=;
 b=dPUBzB2xYOrwfLuA0Dj5Ty6OfjRV8IOZkw4c25WbfK1IRnUvlsI40w1bXKs5SLvtduEY/O3vTibMyHSVMzKvj91QCATJ94WgrwJo2DFqW02eiBW6QFv4zo/IfVny3ebIMjzJuZXT0GdPb4ma/dqKE+qk32/HlN/WP96CCAHQrKdc1X1qhdbf50UCvwgZKo8kmxdiab5AQm1kfvGCRAjQDaM7c9WJ1vWxw+tplEI0eSWvAqK/1ueddf19qy8cgFCnXELpok71vvQpdbrGJohdFLNSBSJqeB/C7iUSaCGSm5jvf46+TP2nxLGnZAUB5O4PaJ2HKKfKOLLAclzGZEYW5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 19:45:36 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 19:45:36 +0000
Date: Sun, 4 Jan 2026 14:45:34 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	qiang.zhang@linux.dev, rostedt@goodmis.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>
Subject: Re: [PATCH] rcu: Align stall warning 'idle=' output with
 documentation
Message-ID: <20260104194534.GA2247470@joelbox2>
References: <20260104081027.189234-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104081027.189234-1-dolinux.peng@gmail.com>
X-ClientProxiedBy: MN2PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:208:fc::37) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4ac1f0-0ef2-4fbf-7530-08de4bc9d4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uIeOG5ovZ33EUgVGKn9vNzZ0Q6D2ANcy2QdG3wMSNOiJQ0RPIDSkwQndvWQ/?=
 =?us-ascii?Q?44A+K0hTnTw91jbSwySTab7kr8gexPhNSZaIyOLpqvki3GRbo5xDJqiNR5PH?=
 =?us-ascii?Q?TAFChBLgk9QI0Yee2HlcGoxMSHocQ5SN5co5/cY8fTnP1/6IzgOzTGuLm0lj?=
 =?us-ascii?Q?AEsXYqfr+BA2pZMxpmahr1orG5JBmp9LrAGzR/DA0EKeWk3aDMuVhqlRUqRY?=
 =?us-ascii?Q?uxCjaRop9BYHoEBnRmKd/6MiFnMi9ggmIGYtLDNx9yIXXPjca7mVMdC8bzVr?=
 =?us-ascii?Q?sFaFxBgOp4UpiRNBcUenNfedMxtMC0Rj5diq1qYaraszGM+P/Y8afOMnrm2n?=
 =?us-ascii?Q?yksm/XWbXm/r9OEFfGGFkzM8M9PPI4dDe4BfWVQFvAkFLQjV9j3hDNeDzkSf?=
 =?us-ascii?Q?Kjv/74Som6GwoN2tWIbP0AUxGhf4u9Z6JpVwKbIPI2m1gSTK13/Pg0EbkVvD?=
 =?us-ascii?Q?q3+PenGmHxMdaBC6j/Q7gZSTUrJTvjwTYNTd21Snqn9/3kB6/x1Hh4OGdfjT?=
 =?us-ascii?Q?FfhtJASlahC2Y8/k8VtbrxbjqzD/EOKBlQICnzl7RNIcYFfDsG2N4h5cm2sB?=
 =?us-ascii?Q?DLCyOU5NmfQkVBVeM/aeGQFkgp/f+vVQaHmMN2wLptt/Ml0Pt7L/NuPEFOsD?=
 =?us-ascii?Q?fbw+QNiR3Re0BZrngUd0rV5R8rFsGaSxb/Q26cYi2ielQehAGZ5mVc/QSsNL?=
 =?us-ascii?Q?FDQMMFwFE00UmeIeYmPywdHTkK/ejXwfJPfD9aPh6eWoqq39wSA0LULTlFGw?=
 =?us-ascii?Q?5RMiIsXBZsEDCdA/xHr1nUzruOvCl9YSlKCf6s+WZxV1XVQM4mxQ24BY58Ii?=
 =?us-ascii?Q?o534kwpQkKSNbVssiYaBGyLiR9CZ59be3/KBgp2JRy4jE4fAo/CWqdrXuno2?=
 =?us-ascii?Q?tO8bsb9+xhtRNR0Oy9obMWBYtbDt0m6yYW2fM6PuDsf16DmKf1PIvrmTPQog?=
 =?us-ascii?Q?jmNj6wY5HbH+P4EgqAEVNgfsKG6BAagdgdto/r60XWwNF1FrHsZGcc4SmSff?=
 =?us-ascii?Q?vlJiEMEpWffTIwATvSeSG2iBeMfHVZ8HVhKw5y5WIuttCwhBl9R/xz8J4g0M?=
 =?us-ascii?Q?CESKlnPiQj31aS5lHYzcR/eESnYpY1nH70UN5nAnFvanXxvc3gi4HfDNqkxM?=
 =?us-ascii?Q?vWT++0gJy4JFuPMU8QH3aqwSjcYZJ18M5e8OEjAk8ZYh37EJJoX1iGHuBLfg?=
 =?us-ascii?Q?A9TvRK1Y4+A357DLKqkYXpH6uXHcMeVFjbShFJwm74c/AaHuBc6T11SeR/II?=
 =?us-ascii?Q?8keEBZHHvJgZ9ja1wslDLl41np3oiJMzOUYj4ZlQGiXG0e3rEkk0y/gR8vMF?=
 =?us-ascii?Q?28Mj4sPb9BxIjXBljDC9vQo6Xr24xdf3b2jCU0GP6BaC8C1zfNb+Y4Ui0I9u?=
 =?us-ascii?Q?8j2PVYbwBQUactLldygXswnASc90XA78onNajk97OpyOyN/qAZ/YzKCbsMIq?=
 =?us-ascii?Q?awqWDVHpNO1+BycVqzqPcUNjJYE/Bx17?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5XHfVS7VEEjE2DmPoFMPwvpJrKAoZGSSlD3ZjQ1L1dkHJ7iu0n0Eq2CPEjYd?=
 =?us-ascii?Q?fNOHbBqk6UUuDLbO6kMNjBtiehN1bMj1vGD1C696fnuR52Q8JRySKcIVVbIj?=
 =?us-ascii?Q?FL9lLzyLIEa/MZSANbjCrY/c9QqWi4SSvgcWYMZM1+w+r6h3uqUFePELowzY?=
 =?us-ascii?Q?IsHTr12Sk6UbD1wseISuDVzGaFzvyE4ZpCRQWQ/A+h1mexr9qn2C47k0M+5O?=
 =?us-ascii?Q?hMsgIWDkf5dNc5OGxgC7W/TIurkC25fBfPOPoCT/X+ZDc+HeYaCIu2XcHQuG?=
 =?us-ascii?Q?Vah2vKWxdOx9ioi6yqcX9asBrqMHQqY3tq9VvPTlQPe/TmsL3PHP2whhLKfD?=
 =?us-ascii?Q?PpLpL6vRP2zU6T6hlDkR6Bgfe9ouEg2OCRnL4OdWyJp3nDhKcCTvopzpkGgL?=
 =?us-ascii?Q?OkjQw+BMpEZyJWkhfD9O/xEWyVVhZRol+cGnkA1oz+Ji2xLdYIw+TwMrSGyB?=
 =?us-ascii?Q?iqyzVdgXAzntdN/MqlRoUCFVOUsVWWutfm7sRMaFjBDdRpV0QG3FIPNvajcg?=
 =?us-ascii?Q?Fd1q2U6L2viH6IALLSdwQa1tCXhEXJhQj/eLSFI5LPZmkXZ8+wM0Ntvs1LGN?=
 =?us-ascii?Q?+6viZUxOShUKjxpj6R2HxD+93BVAz0n/YJCewdeLSD4wUTL8dKRyyAXXsyEw?=
 =?us-ascii?Q?Ybo9DiMkf7pzHC9jD/wBmcaztou441+b0pTcIUIonLVJV0XCzB3BSWU0tdkJ?=
 =?us-ascii?Q?gZ45oGk5ip/kIr20yye3PQJPxDabMXAYx9rDtQUxXVCPObl0+QLDXX8j+cOI?=
 =?us-ascii?Q?XUa7AJVfP7BCji/dUSbPLT6XQoMT6LdocxMyI2WP721+BgKq9rLXaBr3mzvc?=
 =?us-ascii?Q?1WdSJheydS4L/+RAz3O0nEuYFf2aYhPg91RJq/Hve+RIBAmUzigA7Suk9qSB?=
 =?us-ascii?Q?cE+Wjt625hvy61kDI2wQBQVicaINOBXF428iKXRbm1DXoLle62g+7N2N0D4N?=
 =?us-ascii?Q?M83OBFAC/Ez6MKEa6pCJgLgOro+6bd8OB3G2GCxuEILFvpYFJ89lt5uUOxUH?=
 =?us-ascii?Q?U4NnYJEe6xLp7CSBjFYlg/ku5hOJUMHTxZD4M8FAam6hbImyfkjKfsgcSaWa?=
 =?us-ascii?Q?kRIHgHYCes/+zFDc2SrXgpdMpRyiw6c2TrHPuHCjRbxkzCn0qMmxDjuJHiKA?=
 =?us-ascii?Q?//ZpxFzXZis54bOUBfZg1lS5V1SEZsefDOfgfk3Znv/jxK6VAeeYso0ilq1p?=
 =?us-ascii?Q?j/RRRlhqqDbSyFcNRUFKgqEhp4MorI3bjy/akQVOIp6jitFALjgTVneof5uF?=
 =?us-ascii?Q?B4dp+EdJNSMrcTjEwUGHsTf4WiFgQDsM6mPdRho+EGQjc1NYfm0C2WK2Xc6C?=
 =?us-ascii?Q?pY0ypFZF9M/TdEuMwrxOw0xHCZYT0DcbR9T0oP8ajwmfT2Ir6ROVHhYQjNcS?=
 =?us-ascii?Q?bNcuKmpCyZ5v6M1OoIV5qc68pw3yfYG+C8HGoy8AkXbRzi/ajZQPD4NNBVh0?=
 =?us-ascii?Q?+ZQVEKE4a3yoVMfsI7eCJhTTtxia17yacgDmxvZyL5IJS/w3MHokzNtZW/eJ?=
 =?us-ascii?Q?Roky7KhWoFI0R9Hw8nakIzo2BeXaerw1YZH8OR555YepVfxnqMWsg3/YJVsM?=
 =?us-ascii?Q?2KFSqXboy4taa0n4GfpYQ7Z9p7HBeylJZyFgMmBK336b4w8UjvMO6asHEeMK?=
 =?us-ascii?Q?IulADm2taekGD16IjXCpt83IDYDI5Pg4WbUHUjLCYV5CvSkY74RISHmsoDg+?=
 =?us-ascii?Q?MKu2HU9HHb9yVlEK0jdYXgGJSEPYdeOLKWvYfVlgu5YLt41FI5oEJ5j40J9D?=
 =?us-ascii?Q?WSEedWmcMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4ac1f0-0ef2-4fbf-7530-08de4bc9d4a7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 19:45:36.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP56zuQA5jwL7c585aaZTgdaL9wiPhTW8RolRfQPHxh0Ezt+h5jt7P6tOj0OEF8HtCkRSxFEHBY3+wu0q8Zk7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261

On Sun, Jan 04, 2026 at 04:10:27PM +0800, Donglin Peng wrote:
> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> The RCU stall warning message includes an "idle=" field to indicate
> the dyntick-idle state of a CPU. According to Documentation/RCU/stallwarn.rst,
> the hexadecimal number before the first '/' represents the low-order 16
> bits of the dynticks counter. An even value denotes that the CPU is in
> dyntick-idle mode, while an odd value indicates otherwise.
> 
> This was accurate until commit 171476775d32 ("context_tracking: Convert state to atomic_t"),
> which merged the context tracking state and the dynticks counter into a
> single atomic value. Consequently, the value printed in the stall warning
> no longer directly corresponds to the documented dynticks counter bits.
> 
> To restore consistency between the code's output and the documentation,
> right-shift the merged atomic state value to extract and display the
> correct low-order bits of the dynticks counter.
> 
> Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>

Looks good to me! Also nice use of ilog2() which resolves to a single shift
right instruction per my testing (shift right of 2).

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


> ---
>  kernel/rcu/tree_stall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb8770..d25cc826d77a 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
>  			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
>  				"!."[!delta],
>  	       ticks_value, ticks_title,
> -	       ct_rcu_watching_cpu(cpu) & 0xffff,
> +	       (ct_rcu_watching_cpu(cpu) >> ilog2(CT_RCU_WATCHING)) & 0xffff,
>  	       ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
>  	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
>  	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
> -- 
> 2.34.1
> 
