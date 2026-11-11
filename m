Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794412488;
	b=MhUo5nfTRXFXOSqYUuw6e69GfcGNQlPVEQpN4f+6oGDVlvqzbv4gBjpi64IGZuU3eDa0
	 nv2AVOM2HCagfI/f9DuM0KcHoGULy1Qgpm0Mwy7nPu3WJGNY8iPJAmfVExulLNIBYKTNY
	 SSYnYKWEvS3iax1QTGO+OxiWNrbhG1b2t2X/QFQ/uCnlxP1rKuh00Q6zqGKIkY75fDYW0
	 PTLbc0a8gz1jzQlWkTIsBluX2UDHKFG5XazX8Be6udsWCENKyTEcMpmdMM+G8SWcSFATi
	 ySUvcK8ufx4uYK5N9wsgTFHUYO0umcpOU0vfQ03O3bimhoJRC/Oo5ppWo55FvfDaEyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412488;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7hAIthPPH2hVY2TgCctLYfF1/xUrBisDOjTbFKSE0Sc=;
	b=W0Iu7s0KgpHXdx2Thavrb65lp9X+gAGR/GuWxHAuU43OJBmQRao+a65kHFU5btozBpds
	 osx/6SIqDm3aPGkopCzMS3qBrtLZkzjIv7BCJXI+dVJ5BRQnWW2kcWKCYHc/9biYuFtbu
	 PpgLaJXkXd8Xn8aK67ibNunIE8AYc5mJucIDyJGaWopcWcWvlIawN+jxk9bDkoS56LYjv
	 cgvhQ7SGSSccVfmUvckrZEtPr6uDooVE2P6auRDU8gxCrHsGPzAuh7j5C9K59ALQ43bxw
	 Xv0TRm1bbGpCxSPq3coxztjQGQib1rxzkLaTqmNA9WE6aBev+T0G0Vdlhdk5DrqiNdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BfkdUczh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DAF606A324;
	Wed, 11 Nov 2026 15:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DAF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BfkdUczh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkgT8joAkja9SGog/GrUi6Nlvq9oznVGtas3hTzIxy2FNuW0JHPieP7xFlMakecn54tg6q4ZNsYMSaaJRBByCLRF2Ipaj6RRB2HzNwNrHBrRa6XVb6jxYLrjNrH0QFQfeFrDGDngyx6hcqZPnURQYPn3A3kRDgqhvNEo/MRNLbWofJdn1LxFe4cwEhI4v+coNkFcfD3b8gaZn5+fnrHE+mW/TrrN7IsppeJs4R9bXh5UI5h/izJicgJIM79Sw8fGW4t+XNXiHpEsQcKYPay3C5ID/XcUqgCbZlKrUW6dDi2YinCjOcMVjRSwdiYqPpQHImh6BaNFdPeYPVN2ZKg1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hAIthPPH2hVY2TgCctLYfF1/xUrBisDOjTbFKSE0Sc=;
 b=D1rta2pQiw6Xxn9NR/iXbh7CjdQPjk42kYXfWCznPkoH979V46R3gpncNXC9vsckPSvTdU00N7TkngOwXJFsrFsT9FjKUasKmO17kd9w/0CbT+sxHv/NFyhOyWR+Dp13/SEVlMbjlZXKJ7dpc0CeFEuQ0Eltjtr+kLBBH3pLumMOHKVwTbOGMGEv2mhx1LTIz9qjouihJWFjCnK7UgszeIj/7tDyzFiz6DRaqwJ7yQoqCL4jxFM49QL+YDKXD6i2eFQwdxERTuzJubsynqLg0FcTs/QB03wnTzWzRH7C19nJrLdMtUIAv+XsEWWkpVPXLpULsX6Apk5Wv7W+JmoCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hAIthPPH2hVY2TgCctLYfF1/xUrBisDOjTbFKSE0Sc=;
 b=BfkdUczhBFG3/6snd8Gbgltsrd+2SnLS5algS1DNdVUZYb1VHNXRK6bdxmi1oehkT2k86NqK2KRRKmlafilasIJmRc9cWLfLN3TPjpncPLKvfmKkd6TRUIQFgqG1V58NL7E5lVSgdg7emTcHzI9oQnpCyTm7JhhR6Pc6lLMjdo/IpDPk5NWMBxyVlWsD2kd9hUabo752LJkk81vcF3/MB0ViZIOD5KTtb+OE1i9F6xA7TgdcXQXTPg6zge4CMuwnMN1d623uvT9P3m+GaSNvyCleWH9FPXM3yPgvAvoB22Jexqs9H136MbxYvH6hs+vjd4Z9a30STzKG4GYBfREy/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 15:54:45 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 15:54:44 +0000
Date: Wed, 11 Nov 2026 10:54:41 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Song Liu <song@kernel.org>
Cc: rcu@vger.kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org, leitao@debian.org,
	david.dai@linux.dev
Subject: Re: [PATCH] rcu-tasks: Use pr_debug() for callback contend/collapse
 messages
Message-ID: <20261111155441.GA1829883@joelbox>
References: <20261111053551.3367903-1-song@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111053551.3367903-1-song@kernel.org>
X-ClientProxiedBy: MN0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::30) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6b4605-4931-4886-32a3-08df400c1aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|10067099003|3023799007|261009223027099003|11063799006|56012099006|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	OpjgUcYUy5P1RNDk0uw6sYjcMUCcIjfuaEpYD1CDWDkURDFSfuGxdv4rY+LaFa7nuhzd3C+O06Maky9OzGOV2xd7sY55W7HepaS6BWWUoGpnWlannF0i4YrHlfRDOFWaovjaJGBwkxIxn+kmq0wlLMgE1dEhUzJnL7UD+XQNFQOnoz0yAxIVW6+PaTRYAZ3olP9jPdWVESES/JdyEl+kIhk7XnzvgXUOnni3fbmdt8lk8FVjqqf8sE6yH3VN5fn9Wk98xkK5QHAXTlYxy/j/S5Yu3lNHPBCFmcwimCmmK/iE8x9lBAmNdklU2t54YlpMCXyiFz17M6X9+zBaJm88Ip4St/OYurT2sy5QqZJBx+TlXUog8QAHGFtH0UUoS8MD8/GwmfKFOMXNYtWUgiMnTvvj9EVFM1D3liulyyGVSKJDBNgymoihgQPM1Mv/ix2hOZCDp4S7IPofW6QJrsac/0eglCK+oYHxPwAJ9ASfptsD9h47Etppr7lSZlJwM5j1+aKi/7o9OYYNIG4flnnqV9Y9Na5ssHdGHxRtP9q8K272XsjbJwRwo7l8Hx7hcRDsuMpArI2ODNGu2DHm8e2BVV1ZXUuFFaAzFQFOJPd5PoJp+wwtCsmOvs5MFojCa5owANuKH4Kaw5SifDsQH021YzhZHYQY3P+CQmUXmJjsGOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6I4Mnf4zP5+r1LAFDCeL6sxCfAGjKAVUg0WYv35RaJ3AFZKPbG4wpZ7694Ad?=
 =?us-ascii?Q?stIfAS0LtY62Uvoopzw+BK2HnUdsdk8NzNgsG0KYSbHIH6OQmsGhZ/auXLAb?=
 =?us-ascii?Q?Xbym5iAOrY9fcEulfkpxDjAQH/L9EEh8NmMJSW5LeDVGGsBFJVFHLOY6GT1r?=
 =?us-ascii?Q?oVdZU/pFo/N9eEvvGrLAvJPTaYqv6Rl6N7tMNUNXmow2b+cwZj9W1RMjvSOS?=
 =?us-ascii?Q?Gt8zWvy/yoHQWr9VutUaLKv33Ce1EvJAGBmsYVvQWTex7jaWchuFOpXVyuy/?=
 =?us-ascii?Q?EGVljAdJUGhwKw4yh7GKJsDO7OPOwKDhZx1z5yYLVPWl60h2Sx5MOlu/9OUc?=
 =?us-ascii?Q?7CqtdTADvJRxMuyH5EkcTJyqqEvVy6em2/H6SsG2VSgMvmsuu7AwfxkCfGu5?=
 =?us-ascii?Q?hPx/DU5LRnAqiLpPS1yHzgKrKCHBekJq31qzOoS9FvVBpwa78UF++OcosmK+?=
 =?us-ascii?Q?0xNmpfpI+zT4+ZrWOYTH94t6X0iqhQL7QfmYO4O256TCZccx2o/RZjzYJw/c?=
 =?us-ascii?Q?yJqOuoT0SotSJYSrwtgBXICMNhQ/T+txgaXHMbVjEgA2FaTiqkdgkms7tICd?=
 =?us-ascii?Q?KDxl11C/fl+d0WmYr8nuTcTdweFKOuAM07Z/bItbK2CO0Mt4BRtzmLkNBxU8?=
 =?us-ascii?Q?HXyENRkhPZxx2nk7DatzoOcGD8qafhSUvNriI7RfDruaDOzUtEYiM0pIu72u?=
 =?us-ascii?Q?6aAHXFO4THVcZNzECmPYbnoaadhx/XASkkMQPR/Jb7eWft2PNKp/NZu//Sho?=
 =?us-ascii?Q?mAfSihaqKTR7Myv7C2caqGUxGugEXCO3pFZKmLrxPo5gA0k3kH++g8ttmfoe?=
 =?us-ascii?Q?Ln6/apTbx7TDH2dOKVX8hDLXIe0RjKx/fWFxzO77r8MzTKmEkuQ2uitS1Sb0?=
 =?us-ascii?Q?NgnbrLrQe4Myh+GZ+hA0l1lpVFQRjSiX9y6HeXdDFPrzOgkb/L8W4A6bdVur?=
 =?us-ascii?Q?Dofo1D9jvlv+1eCd967zLvB9XcKlxQ8dmeMU+bZ6PAYu0g42/4qaPrGbJ9hj?=
 =?us-ascii?Q?5/Cq3mljCXyy/2DcIZO/LJ84Agn/fwovDH9Xh0Z+Vz7zUhgqIjgFQ8KOgcd2?=
 =?us-ascii?Q?xT16mc2Til3IDlUHxAjFe43yujYKSp3JKAg81OfhA8rT/w+ybrIbCepubXSX?=
 =?us-ascii?Q?ts4wnh+8/30yEewFwLRjlzbkgaAy9sfZW0dOpI7BIo2LeTDhMc45Zy4CcbqB?=
 =?us-ascii?Q?tknBr84hWAyvTg2nqkCin5fZjMNgw5ZBTJ75YIAAhHq/PpjmwVzdaMCEccdW?=
 =?us-ascii?Q?xkvtNq09D9i9azqgfe62xrRL7slh8iGo2hHt4o9BlYsWHEEObftyhl/wWDsM?=
 =?us-ascii?Q?fgCzooC3ertVdT1K/TVUIV77au0x3mxQUIUgvB8sqTSjVdEpNcgjmWS0QCDJ?=
 =?us-ascii?Q?NV3BCabqmlcdr0gGRM4Eolyxc/ZdhzGLdDvY5QW3a4lUu65uV/43xHswBGoP?=
 =?us-ascii?Q?0tUKSWobhXTnTjqwy+zY90ohSeqslr1D4ssVIB5LsSfShFfl1Pl5rGvjNIEB?=
 =?us-ascii?Q?/6UUNDVxidLQIRo9Pef3ISImlGyriO6e5FQrjXPHWqKEUabGToPM2OsPpTJi?=
 =?us-ascii?Q?rm5oKd94NwVg2/DVxgyCQ+S56J9bedux1rR6YKyL4AG3bzFWg/yhBTTZGIR/?=
 =?us-ascii?Q?jZRT6x3ULjAlbaxXuR9IXOJlYDsPxHpvOknUkvAFYEGFNrem80+/BHZ+42Os?=
 =?us-ascii?Q?y0pjUtkrjgyvLbsZy9mQve3InJ4qd+pOzlqCPtI8+9QDvUpzhGOWfydK0uYr?=
 =?us-ascii?Q?ta4Iug5QXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6b4605-4931-4886-32a3-08df400c1aff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:54:44.8709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efIyg7YwRM8x6rAAgPSsdH4ECmPocDzXGv+6Q0H7ARdKWq97XBM6hZi5JybmH72UCwl9eXhHDe4Fys9Nfpcppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

On Tue, Nov 10, 2026 at 09:35:51PM -0800, Song Liu wrote:
> Commit 5de907d24919 ("rcu-tasks: Disable callback contend/collapse
> messages by default") added the rcupdate.rcu_task_collapse_debug module
> parameter to gate the three pr_info() messages that report RCU Tasks
> switching between CPU-0 and per-CPU callback queuing.
> 
> The kernel already has a mechanism for debug-only messages that are off
> by default: pr_debug().  Use pr_debug() for these messages, and remove
> the rcu_task_collapse_debug module parameter, its documentation, and
> its boot-time announcement.
> 
> The messages stay off by default.  On CONFIG_DYNAMIC_DEBUG=y kernels,
> they can be enabled at boot with:
> 
>   dyndbg="file kernel/rcu/tasks.h +p"
> 
> or at runtime with:
> 
>   echo 'file kernel/rcu/tasks.h +p' > /proc/dynamic_debug/control
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Song Liu <song@kernel.org>

Makes sense to me,

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Will apply for 7.5.

thanks,

Joel Fernandes


> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 -------
>  kernel/rcu/tasks.h                              | 15 +++------------
>  2 files changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0b3c140babd9..176648941aec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6369,13 +6369,6 @@ Kernel parameters
>  			period to instead use normal non-expedited
>  			grace-period processing.
>  
> -	rcupdate.rcu_task_collapse_debug= [KNL]
> -			Enable debugging prints that record when RCU Tasks
> -			and RCU Tasks Trace expand to per-CPU callback
> -			queuing and collapse back to CPU-0 queuing.
> -			This is default-disabled due to the fact that
> -			some workloads can make it quite noisy.
> -
>  	rcupdate.rcu_task_collapse_lim= [KNL]
>  			Set the maximum number of callbacks present
>  			at the beginning of a grace period that allows
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index fcac7361ec51..743f777b4c18 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -178,8 +178,6 @@ static int rcu_task_contend_lim __read_mostly = 100;
>  module_param(rcu_task_contend_lim, int, 0444);
>  static int rcu_task_collapse_lim __read_mostly = 10;
>  module_param(rcu_task_collapse_lim, int, 0444);
> -static bool rcu_task_collapse_debug __read_mostly;
> -module_param(rcu_task_collapse_debug, bool, 0644);
>  static int rcu_task_lazy_lim __read_mostly = 32;
>  module_param(rcu_task_lazy_lim, int, 0444);
>  
> @@ -392,8 +390,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
>  			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
>  			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
> -			if (data_race(rcu_task_collapse_debug))
> -				pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
> +			pr_debug("Switching %s to per-CPU callback queuing.\n", rtp->name);
>  		}
>  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>  	}
> @@ -514,9 +511,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  			smp_store_release(&rtp->percpu_enqueue_lim, 1);
>  			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
>  			gpdone = false;
> -			if (data_race(rcu_task_collapse_debug))
> -				pr_info("Starting switch %s to CPU-0 callback queuing.\n",
> -					rtp->name);
> +			pr_debug("Starting switch %s to CPU-0 callback queuing.\n", rtp->name);
>  		}
>  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>  	}
> @@ -524,9 +519,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
>  		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
>  			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
> -			if (data_race(rcu_task_collapse_debug))
> -				pr_info("Completing switch %s to CPU-0 callback queuing.\n",
> -					rtp->name);
> +			pr_debug("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
>  		}
>  		if (rtp->percpu_dequeue_lim == 1) {
>  			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
> @@ -711,8 +704,6 @@ static void __init rcu_tasks_bootup_oddness(void)
>  		pr_info("\tTasks-RCU CPU stall info multiplier clamped to %d (rcu_task_stall_info_mult).\n", rtsimc);
>  		rcu_task_stall_info_mult = rtsimc;
>  	}
> -	if (rcu_task_collapse_debug)
> -		pr_info("\tTasks-RCU callback contend/collapse debug enabled.\n");
>  #endif /* #ifdef CONFIG_TASKS_RCU */
>  #ifdef CONFIG_TASKS_RCU
>  	pr_info("\tTrampoline variant of Tasks RCU enabled.\n");
> -- 
> 2.53.0-Meta
> 
