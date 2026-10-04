Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E533FFD;
	Sun,  4 Oct 2026 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791074027; cv=fail; b=HVHyVabHU6dYXC3sqHBd3cZmBGR/D/ZpUg7TXgoAFqKlj7BN9mQXJq7NLP3AhgqfmxkUuyLnpMsyFhqESS+m8Vg8mcHj//oydqZq2KOY7FER1YeJNsETx6ftpOzt7eyXEyrC3eD0mU3qybvVMcR9CgoEo1IEiMhyyOPAT46RYlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791074027; c=relaxed/simple;
	bh=lQs9StQJa0R9epEw3p6jNp8z+n3WgQe+j66v5OwtA4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DVXV42hTRBXwqYbxsHHs9Kf5WY1R+8uc8lySjLu+u82zcuBfhnVaOkCTQfNP1oBVL4nxsD7Hik8VttjSrSiMNPpgzJOYn1ogLw4byeLF2lwRwVvlpz5UA/Gbg4LAPtVgEpPuuy+Ksm+Y9iWQgAHXXYXkGPevAjDwHAFZwzVONyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DbZMXgUe; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DbZMXgUe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkZ+0ImrXZr5/EYMUpRcWRApfE5eG47XhSuRM+XZ63u0CBX1NCaZzeqC+yI4LaEvTpbUFBcmBug44UxgvXwcjzk+E/2tRR8Txz8lJa2h5vBJFJyALL7+dB+rFUupgNwN67bRrX1SnWDRnbp4GuAKizumJ0ac0ET1I/8ATpBtWNiyOlBcs5Mau9bkHAFFYGmnxA99DQtOOk/T2Wwcyh/6lZZAA9jHOgnsYXL0+s7dowpop8bX7reSPtMh9Zv5BbuyBPxa0zfyiL+KfsfSi51dHHWFA293GnZoFJNhcMT56SRzxAxhYOcnFyLx2qvzouYYRFAjqW5X33CLsVIkkHbykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXaTZG+PZhQFlVEZsHGEGY059is0r5fuygjP+0XjVP4=;
 b=NRvRfLuPhQYg3YsdsARPQXxC2cgBodzJph5DlDxJ/Hul8xDpxkXpky4B+g9g+IeLMooI8ZqvoyRYOciXky0nskuRsiqwGOSjuvr22ZKm08OrMD1D66r7TKz67yXTDkt7rKU6UM3thml2g/HuOftVcN4iD5vfaeGuW3krooor0CijkLDlOTd0LeemRV1ikC3L/HHgyTvc9hk7z2buCFhHLjz1FYdagXvwrw46QTIibd0oWu1Miz6TnskfSSrbccwucviqnYnxcZHit699xnGYv0xag59Z78M5QG6/917P8c7AiEZO0Swm/J1/a2VBWQTvwwVIqQsbz00IPsGIJ9OFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXaTZG+PZhQFlVEZsHGEGY059is0r5fuygjP+0XjVP4=;
 b=DbZMXgUebTU0d2m8nWXRmjKjegHjs7tHp9r4yqxOMUuqWa8VVcqB8WsvumUn09rd1PXrxY2cCMdSUzfz2eN49zMrwaZQoQQPDaRbZVyRePWGYQUJ14N6mur39AuvPENS52xyxs7mnIJht+N9r118RR7e52ni/IACNHK744I2aXOv1gOXYjsQPTgmsWSbXzafWeULCr/ZjAB1Q7bF4uEXZjIh4/TkfOYhCwbuSOwEc84qydNUbY9qD2QmgmPVmxs96OVZpXEwhz0wgUMH8p7ctIjsTpUBPhoUn/Y1jeUDn+Nc71Rqfm4bUjEW9mN/TW7+142Xz1Z1EKMTu/jHnr5ybA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sun, 4 Oct
 2026 00:33:42 +0000
Received: from CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056]) by CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056%4]) with mapi id 15.21.0472.015; Sun, 4 Oct 2026
 00:33:42 +0000
Message-ID: <51ffe989-9a0b-4715-b434-3e4cead5af0b@nvidia.com>
Date: Sat, 3 Oct 2026 20:33:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcuscale: add srcua scale type
To: Kunwu Chan <kunwu.chan@gmail.com>, dave@stgolabs.net, paulmck@kernel.org,
 josh@joshtriplett.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 boqun@kernel.org, urezki@gmail.com
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang@linux.dev, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
References: <20261003161720.240855-1-kunwu.chan@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20261003161720.240855-1-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::27) To CY5PR12MB6479.namprd12.prod.outlook.com
 (2603:10b6:930:34::17)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6479:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: b553b380-2820-4235-e0b1-08df21af2440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rnWCbTz7Q0XAcIKpezekpdpJvTcsUDc90SmEKgIaEedwENBEow4J66iraJ9Ov6jf8EpwN5j4SWRsBstHyUqs4OVnjm/XbDYjsBlw9KKagzyUwLd4xJX4eLX8pV6WTX5Qb3mbyLT02wfefqs30SRl2iueq1PPNQWtyDtTyzoumBwJY6X7wVWY+K/Ey2hBOMhdYBRxL9OnqTcguMVdZzPC8c3Y/JjbpBCNx1vc04Nq7Y6iq+MPE/sINwLds4lQMcbwsu7YbqhYCbAjWdhaN+Roj42BWH9GTaQkkAOMurgJ/pDgPFQCi5utx80fZa6NaMWj2P4lTuVo8wSAmuHT8Kauht8gco0GhIUgtLFi7r3k2EfNmmJ4RCrCVaqXUvibR1K92RoR3LPw1JTWinLatyRI5oJDHsYBNpSkd55RQjJ7hCGzlLU7u94cOAdfJhr333y17LLtV42sVUEouEb0Ah6KhfTN8Qp3CsMDs1YYftSjjwYsFOdQwuDYvJqOTpg3wAMEQjt562ZanGic8F/nhPzJI+hbLg2CUWp8lMTaApPjK0VPLgJwVXsL2Z7IdVVsg/DAcSf52ecNGrB0C2E4zCAzP5YI/ou6X1MuKiTEapcBR1JO4JrGCT8kGCQ73qwSUywWCaMQfTZBwDaD8RmUtiM4+wacseROrGeWoVhWcf8f3ys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG5YT1VReWE2eTFWUlZHRTVCUUdnampjTVB1MEtwTmhYdHZvN0E5VWg0ZHd3?=
 =?utf-8?B?MGV6SWFHSlVPR3NsTC8xcnhET1dFZllMVURJWUVtYy9jV3hNb3E5TXgzRHZT?=
 =?utf-8?B?aVlEN0lBQytlS2pBQk9MdHpzdXFuL1YrVEhRayt6OW9FTnE1b3RpSUd1SXFP?=
 =?utf-8?B?elFrZzVob1FITGEwQ283SUtqNEt6Sk01Vlg4U3Vzb1FuZTAvditmT2hDcWFl?=
 =?utf-8?B?RXJRM3pxb0hOOUR4V3NyYlp5a2lnTGM3M3YxWHk3bWV3ajR2OGFucFJVNVdT?=
 =?utf-8?B?bkMwU0oyd2l0cmpXZ1hRMUpLK1VSQndMaDVUT0pmUlVJeGMzd1dleDlSYTVH?=
 =?utf-8?B?dkRGZGdWLzVsOHB3Mi9BeXUrWCtlYVQ4LzlsY2FvbGJZNk5xKzZLMU9lNkZE?=
 =?utf-8?B?QTcvck5pZ3JLOXQ0aHlaV2VVZ1NjQWlUdmtWTW1TbWxENXc3K1dKZ09SY1U0?=
 =?utf-8?B?UGRMbzFwaWFFVmxsS0RpYUNmOStJK2NBRkxhdWw1YkZXZ1NLZVdpcE1ZdHps?=
 =?utf-8?B?Nmd3R3d1VWdLcm44a2oyQzBvRVF6eW5UN2FnZVh5Y3dvazVYcW1XMGQ3RHRG?=
 =?utf-8?B?NlE4M3FZSUZQbE9QVkNHdWl0L3NOWFAxaktBd2dQeE8zWGtVUG1Ga0NCd1ll?=
 =?utf-8?B?N3ZZbWFrY1FHME1ka2tYWkk4S05IWDU5R0U0d0VTMEdycEhHTHZiL21wVjJ3?=
 =?utf-8?B?enVOTVUwT08yRS94TU1CaUI2Nk4zcmtVN2hnbUw2QzhmdUdzTi9oOUFTRU9s?=
 =?utf-8?B?S2hjUUI4dW5Jd25pR3BBUkgrMWlyTldBN21SMnZmUVFxMjA3UjRkejJCQmRH?=
 =?utf-8?B?RC94Zy9vanA0a2FCWTlZWXNPSUxtVzE0TG5jZE9naTNWaDVQWTh0MDlqY1Vj?=
 =?utf-8?B?eXNKQm80WTUrUmlQU3diWDNxRm5aOU41Q0dwbjFnNi9JVDhncC80QzlJcEhL?=
 =?utf-8?B?OTdqcCtTcGp6SUtDRjBGdm9mS1hsYlBuVFRpNzBFOTdHQnBjTTY4T09MNDJZ?=
 =?utf-8?B?dzBiRDRQNlZBZlpuK2g4L3dkMGI1NVNEUzBKVFNwZjNDTUFwN2EvL0haYTNa?=
 =?utf-8?B?VGVhSUJSOHF0Mkl0RzdTYkpxdk1lRlVva0w1TnMveElCQW1rSVNlRm4wdXRV?=
 =?utf-8?B?TnJ4eTFVYVY3UjJ4V0pIaHhmbGhudmRwQk8vWm1HNDMzMG1ZNjdKdy9pbmIr?=
 =?utf-8?B?dVQ5VGJMaEpwMEtmZ2owNk1kZDkyVnl6WFdHM3N2eTdsYTdON08vQnF4NHo2?=
 =?utf-8?B?SzZVaFpYTjNWRmRFakFIR1JVeHQ3Q3FxSXp5RzgzdDZlWjV0THJNMi9PWUtp?=
 =?utf-8?B?b2xZeEpJWlhVVFN1dk1aSEswTVg1ZE0rS1YrczBhRlRMNEJiRE5wZitUbFNz?=
 =?utf-8?B?RnVEUjFBS2htWng1aW1jMHBadDBZQXZudGNrYnR3ZmF6MnBhZk50Z2RkaXNM?=
 =?utf-8?B?aTJFU2k3RjBlOG4xRkJuSGZWb3JrZVFGVUhHZUcrUWF5UUxXRHZYVXFidDQ0?=
 =?utf-8?B?aktoc1Npd3VKY25FdUdNZVRJbnh1K2wyZFZ6bVJjZkNpTGhFdHZSQXNuRmVS?=
 =?utf-8?B?cWFVeHRZcnJvRmp0akdEaEpqUVpKVXFtc3dEZFI4MXhDMzdXWGNSbVJmVHNQ?=
 =?utf-8?B?SkxmeC8wbU13UlpKVG5xSmVFZFNTS1BmYmJRQ3hNMmRjUDAzZW9qRzNtRVJJ?=
 =?utf-8?B?UUx1cHhxYWRJeC8zMTJickFhRTBNVE9TbkQrL2JRdFFSYXZNSHYwVzNhVVJ6?=
 =?utf-8?B?ZEJ6NW8zVHlldjZiUTVBSi9ZdkI3T2NSYlVPQVl4cjlmV0oycHJDb3ladjdK?=
 =?utf-8?B?QzlVQS9YeFdzOW94MVhlNXhUYkxsZVB0UGxkNmIzWmxQYi9pZ3hJUmFQUUV4?=
 =?utf-8?B?ZTVGS3N4b2diUGJDYlYxWUs2YUViOER3aW91VnB5S2hmTk01R0JEa3dZQ3Bt?=
 =?utf-8?B?ZlhEcjBBbFVLNEZmR0ZkLzFZZmNUL0dIZDZHQW02c3NhTWdLNWIzS2d0YURP?=
 =?utf-8?B?S0lrY1NzeGpsUGo0Mm0zWERzcit1bm1MUVFGWWZESUZmQ014em93czdFUlJl?=
 =?utf-8?B?RFRpMFhGdzd3RENXRjhCOURaQ21tQlZTVC91UUhZY1psMmxWSGlDRW1wTjRY?=
 =?utf-8?B?ZEEwRUphZFdGTzNtWGltM2tydEVKYll2UEd2U1VzNFYveC9IbGhVRmRyYWdK?=
 =?utf-8?B?NGNFVjVkTFFxVmxKa0lja254dGlDK1VYdVFqUjZMeGdTNzhUNVNrdkplNEM5?=
 =?utf-8?B?ZTJ3UFRoZDc1MS9ZNWRXYlEzcGpPVllWWG02UXk3NHpmVHR4Ull3aEJ2V3FL?=
 =?utf-8?B?MnZOS1V5OTFEQXRtQWZ3WUZtUjZMT2hXRUxMYVFXZHZYanJrRkZxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b553b380-2820-4235-e0b1-08df21af2440
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 00:33:42.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylPM7HU9Pe320RSwwxcwooB4Tixj+Jmz1cHSGfY7l0qTirD1/e2Y6ZK8afmsjFIqSsqaHdunIl0THuKA9ELVsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

On 10/3/2026 12:17 PM, Kunwu Chan wrote:
> Add support for scaling atomic SRCU grace periods using
> srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
> synchronize_srcu_atomic().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
> Changes since v1:
> - Rename srcu_atomic_ctlp to srcua and reuse srcu_ctlp for
>   SRCU operations, as suggested by Paul.
> - Reuse the existing SRCU cleanup and completed helpers by
>   initializing srcu_ctlp in srcu_atomic_scale_init().
> - Add .stats using srcu_scale_stats().
> - Use "srcua" to match the existing "srcu" and "srcud" scale
>   type names.
> - Use synchronize_srcu_atomic() for both normal and expedited
>   scale tests.
> 
> v1: https://lore.kernel.org/all/20260927100359.3903688-1-kunwu.chan@gmail.com/
> Tested with kvm.sh --torture rcuscale scale_type=srcua on x86_64 and
> arm64, alongside gp_exp=1 and PROVE_LOCKING=y: no warnings or lockdep
> splats.
> ---

Maybe some performance numbers too for an rcuscale patch? ;-) But either way:

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>





>  kernel/rcu/rcuscale.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 1097ec15879c..b172882824ac 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -293,6 +293,44 @@ static struct rcu_scale_ops srcud_ops = {
>  	.name		= "srcud"
>  };
>  
> +static struct srcu_struct srcua;
> +
> +static int srcu_scale_atomic_read_lock(void)
> +{
> +	return srcu_read_lock_atomic(srcu_ctlp);
> +}
> +
> +static void srcu_scale_atomic_read_unlock(int idx)
> +{
> +	srcu_read_unlock_atomic(srcu_ctlp, idx);
> +}
> +
> +static void srcu_scale_atomic_synchronize(void)
> +{
> +	synchronize_srcu_atomic(srcu_ctlp);
> +}
> +
> +static void srcu_atomic_scale_init(void)
> +{
> +	srcu_ctlp = &srcua;
> +	init_srcu_struct_atomic(srcu_ctlp);
> +}
> +
> +static struct rcu_scale_ops srcua_ops = {
> +	.ptype		= SRCU_FLAVOR,
> +	.init		= srcu_atomic_scale_init,
> +	.cleanup	= srcu_sync_scale_cleanup,
> +	.readlock	= srcu_scale_atomic_read_lock,
> +	.readunlock	= srcu_scale_atomic_read_unlock,
> +	.get_gp_seq	= srcu_scale_completed,
> +	.gp_diff	= rcu_seq_diff,
> +	.exp_completed	= srcu_scale_completed,
> +	.sync		= srcu_scale_atomic_synchronize,
> +	.exp_sync	= srcu_scale_atomic_synchronize,
> +	.stats		= srcu_scale_stats,
> +	.name		= "srcua"
> +};
> +
>  #ifdef CONFIG_TASKS_RCU
>  
>  /*
> @@ -1110,7 +1148,8 @@ rcu_scale_init(void)
>  	long i;
>  	long j;
>  	static struct rcu_scale_ops *scale_ops[] = {
> -		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> +		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
> +		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
>  	};
>  
>  	if (!torture_init_begin(scale_type, verbose))
> 
> base-commit: d21906b0aa1e9573cdb5e7acaca44966b9d1dcd2

-- 
Joel Fernandes

