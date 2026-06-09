Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079536604B
	for <rcu@vger.kernel.org>; Tue,  9 Jun 2026 05:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981830; cv=fail; b=QZjozVOjgF3B7l/GatJ1P8NqbCTFXCwMYwMH2onOcMuVNu9sQqd6uSx5onDwiyDw8cJIg1O5D2zmYa3VUzPIN6GvZtQG1yDPFHxUuinas97FENjv2yqK2RphUAOEWHVWrev18+hr/4++pD1NHk+8XGRu4h+4ES70hHDYTHmFDZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981830; c=relaxed/simple;
	bh=NG6TGCssRTgtuhTEpJAUkrjeXNxJsUCsPujjknV2v28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tSgf8E09t4EY0YcLQtCKSu4bSi6iJfLenNQT3pyPIPchWRKb61aKZV648BczDEN8vyPrg0Cc/g1YGkfqtUwBzelYkQyzLd8xJhq+6+nQgoeQTJ7hI6ICuULL9fGpu7kfXK9E8tMg1MI0jafjwRcIRsG5dRimEvx+5ju4GVXcODk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vd1uYtdd; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vd1uYtdd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbnPr5fW0yNmkyGWWg29hXu1nDNSAsescLyx96S5Y2yUU5SoePRfjeWT0mqyz/xR+lZhzFi2c5qzHNYOFVQoQBm3MxgBACSH9Ss1+04S3Z9mDKoE6FGams091jyxtQS0oZB1OdYHQTRZBy1HUyr7naUT4fMwZCfyj5y/QOwucW/4ehFoOrMVHqH1Hwvyj2F0I0k4ajpRv3Gh2wrED4cOQODqr/nFJE23q4gPRjAFnqPwTssvrCYIj7I6RonigVLMMhCn6bBytPtvrIR11mRMhCaLCcMLO7OIfARe3Di7d12Q2g3TrWJhVX9yKmZZHXvV6JU5BSuBH+SC8FqBF/Tx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvfuxrkOJ9b7r1Na3vHDmie1H+qkhvm0jYNNiL5eIOA=;
 b=SX9RaBhIlJi0Q60zmFA6KxLMFBvkaBe9tcyg7M15HDo7j2BSXV8BACk4v9F7xGOv81HmEu6Ci5ROGRMh+BMyB8E3FNAb12E3QKzvPeKv838d5cSg395DOJYrBC5cnRMl7RFBPOz/kXeOHhe3W5NEJZFhwVIRUmUQJA2UNaL5ZLxTnN/hykTomfht4f26VyZPIIPXGdeplrcPBDQp64Hjv0++rNlu9a0QysW1pFpjg6l2EDmx2E4hXZg90vvbu/m7xjoLFawCKcvRPah6x/R3kFLgNaspyyTwz/8KRvR1AH2iuKojm1pPp/1YadjP+lExiqvzTXl4ijzFw/pd1NEh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvfuxrkOJ9b7r1Na3vHDmie1H+qkhvm0jYNNiL5eIOA=;
 b=Vd1uYtddO+v4YaybXOsJWzhJZNZ9gThXlcebd5MVu0N+W/Bv20nmC+c/tXQGosKxAug/PUEkGsI4/R3OzEuaTTm9tLjDGbEcyEbwMl8zNDjaGdwQkun1/i2F6tfc/WODGYJb9lURNMVqkbE1pWSavYzvLVCOsKc4gQSx5dPmYXnRGGZRJOBfSDUhWWLuHOji5Z8jcWFmIPMr6mNtUGbHKSdP///cmMbw0AWXcSJ9/NxaC5SIGLF+suyg9NQsEm7FlTXGzX0MWzb4IQU/F477N9dwJMaU1x5p0sce+zLxKuofciykJ0HInZkjC0BcaEcV7cZphvfcMQzHX7z+N+mCTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 05:10:23 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 05:10:23 +0000
Date: Tue, 9 Jun 2026 07:10:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Message-ID: <aiegNmIT5mZij8KP@gpd4>
References: <20260531152646.1206799-1-yphbchou0911@gmail.com>
 <20260531152646.1206799-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531152646.1206799-2-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1PEPF000008C5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::427) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 62610cb2-e04c-443b-2e9f-08dec5e568d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	g7FV6oHXt1iqLXephrbEbyiXfcQ19MAZc6/fsBB7YnkOpqmvNB4bVi0G8aHo0gzeaHxCv0MQPeAyHKKLm+jZnB5t8qGEUgfsy375OuXkL9F4ZBRJR6DUO/MBAw40G4Zvq10bn0mJBMZcxqPIFgtl+l7TcEcIzu8giLM2x0FIC+UsPoPwxh6rOVwJcbossVpH2jVJz0K61x7tCtgIN1GUAolK5rfpwF5t7Sw3UBVDZMS6HblCxl7mirvIPCd1wozZOyQf+xsqJxSBlZX1laVk5lJXMuAi/SGaGWti8F9y9328zLgls5QVrzwi7UeeUfDWf/SeLz1PcezGsfi+QJ2phlhjI/0ctzHRSPmrdKzycKgEFZGDzl6ZW5LAIzRifglqAocBGymV9phVHhBo8yXWMRJJG7nU47lAewzvRV5DhzlKVamoyoL2UcAW92S6zobG5HjvPotnrGNYaJfmDOTMEgPsrAcwm++cxL0tkBHPZcTVfh020YtgXwrWLKr6pnifL0Wtc+XvOb2tyBJe7BnQ/MXD6ZLqZ+BRxoSAJ5c6Mdx7YnO9w4DxGtu4tYqHqjs1WZEodBTnOLlX5yOvBcVrjAq2fn/Tu7wk3bvyp6iA68Hu1Dd8zDSPe+GKqpneWLR40Fkc+0BLPyeOcuz7Q65mO4Yt4goQQIGBOq0K+N+EfXa6W59pJ5muPoKXgnVHT0bY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DJLjK9KDpd0s5y1IvPDy3YutVl9kwQTS6kLeumqj3zyKFI1F7mdhnVgE1ZMg?=
 =?us-ascii?Q?OzYtaTJbxPh2whVXplWffqhHbWa63iOKxotGLlciQU7jv3KnqEP3EhL5ubJ7?=
 =?us-ascii?Q?cOXPjB9kEYUtjUyVC2SRyUpzAEcJi/fPx90oyJXDAVG/x4U0tgNo/Hbeprlq?=
 =?us-ascii?Q?B0UBLo3E9gO7i94oKpqKEWzj8n7Jfcqu2nRiWqb2PZQA5j9rlmjZwj0A8iuo?=
 =?us-ascii?Q?8LOubjeNn1XtU23Irxv7Mt2u+aC6+PSQv065T7l7a8CHTKmTOxcZNf10b2hQ?=
 =?us-ascii?Q?6mRasoCTVIDCTl5wHIWEH6ko4WmfYf3x5YrqtkGre5liuHWux/fO3tNG265c?=
 =?us-ascii?Q?3z3hnD4yVMdFEtoia3TPLTPdEZMMF9V2cchu+jusD/zn4ShGx2WA/KMmtr+r?=
 =?us-ascii?Q?TEUVQP+WPf1MTIlJq3ynKJTbCu3ks2D9XvTp0o5sHj81v6DiJAS5eczE1kve?=
 =?us-ascii?Q?Llnco39yhwjCtd4//8imlAwi2coA56JB5T2IeU15K69cYmeh3jd+ZiVhyHAc?=
 =?us-ascii?Q?CSHi9OkD6L+gu7mwu9Y2f+TSTbfsrGutnKTezu/b3O29X7DON1WVllUqHJCp?=
 =?us-ascii?Q?FWZmUfflyYOBatVAqIDiphBz4xy0AGVr47jNvQlM6yxJ2PLz3cN81h6H5rTG?=
 =?us-ascii?Q?fTgM1UXQj5PDSiYLoliw+2rzNjOGOUDTifJFudlcwYI7MMe1K+m1f0+rKykA?=
 =?us-ascii?Q?C/1S6S3X7b/xMbfW/MaS3/9tyih4coiGANtxQq7tdxrprpPDGds0J94GAnw+?=
 =?us-ascii?Q?8rdrhqFCF80SiYhSBxkDmeFGZTeTS732z/6NPJsiMLLVOJLBBMUA5Rq3cnyl?=
 =?us-ascii?Q?QdZfhbvntqUR/1S3ZCeTK+wwPGefVg96vcWBVDqGYse4WovajDi1wck1p2Xj?=
 =?us-ascii?Q?drQUzo/NpGApsBrO8BJaLF//3N4evxeRNsW/Imy665fwIC2eWWEoYkPbxLi+?=
 =?us-ascii?Q?ma+EBriJflzUMUP61wyh2UPdJ+tosf69i2EcTcbMNDL13GSJyZcivasMYX4s?=
 =?us-ascii?Q?J9b7e782Igv4CS8E2LGVZF261x9H7Mc7M3fhV8Q3HM5D7SFgE+3YKsW8N+qs?=
 =?us-ascii?Q?fMf82euKfXReVaCXKkvvwexDaTxabohU4YSHvPimQCkhlgCeFNlfX4mTZ6vo?=
 =?us-ascii?Q?ugVGPUrOAGP139YoABLmDPZuLoOyhDQfgws6TKFt8VDRMXuWZFBRANsrirvZ?=
 =?us-ascii?Q?CrIlp2QYwg5UMdP3Lp8k2ISYmWVPeeY646Y4vXDS96jQL2YCGhh2h8VnUrcc?=
 =?us-ascii?Q?njCfM4eK57d/OfIE4NsiMXrEl/BkYQInWkluqpCXZXjLlgI8BxlGGpqUFHe9?=
 =?us-ascii?Q?flSMiH4wSjsFEPBQqBDLHtURz8k0NwMUAzQJo8mJxLiWHNQul8d5CcTP71qZ?=
 =?us-ascii?Q?6/hclEIpGWAv4F9Ta2spBqKYZpsdbCB8yYa/ZyutdX61DdKeL1LXENr+kVPL?=
 =?us-ascii?Q?w2MelmZMacR0jJSqcoacfchVH/i24vK3I69FjzRkGIWqgrZRB3tL8E1ZuDqk?=
 =?us-ascii?Q?Hy3Agt/Mn5q8csxlHAVwkzxkR9kHjbEQVZVCcJvt0EJEf1at1Ms8gLc6EZF3?=
 =?us-ascii?Q?fpR2A1W8BxC+c2i2tqMCmJYPxdmJeMTflbAyuAIg3zDyBy5K8usDFejJgkZy?=
 =?us-ascii?Q?ONtzd523yTnCwlSGRS884uYrMYDlOoFcN2B0ysAzK+wxkBf6tCRMfKdKWq/0?=
 =?us-ascii?Q?cFj1W+zj6s+RqSz9BGQqkWPJVN3QRulufT4Zzd3A4GHUBOGe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62610cb2-e04c-443b-2e9f-08dec5e568d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:10:23.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT+TdJrIt1ECT6ExgF3Qj3yIZa5hmzpJ/PGQ7H4j2qlb4HWDeHxHjjkZivDaGh+tkaudYrairoBhP1PABLz7rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185

Hi Cheng-Yang,

On Sun, May 31, 2026 at 11:25:26PM +0800, Cheng-Yang Chou wrote:
> handle_lockup() uses raw_smp_processor_id() for exit_cpu, which is wrong
> for two paths:
> 
> - scx_hardlockup_irq_workfn() has the hung CPU in a local variable but
>   irq_work may run elsewhere. Pass the local cpu explicitly.
> - scx_rcu_cpu_stall() records the detector CPU rather than the stalled
>   one. Pass -1 for now. The next patch fixes this properly.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Small nit below, apart than that looks good me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

> ---
>  kernel/sched/ext.c          | 12 +++++++-----
>  kernel/sched/ext_internal.h |  2 --
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index ffad1a90196f..0c37b5fd58b0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5205,6 +5205,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
>  
>  /**
>   * handle_lockup - sched_ext common lockup handler
> + * @exit_cpu: CPU to record in exit_info. Pass the stalled/hung CPU, not current.
>   * @fmt: format string
>   *
>   * Called on system stall or lockup condition and initiates abort of sched_ext
> @@ -5214,7 +5215,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
>   * resolve the lockup. %false if sched_ext is not enabled or abort was already
>   * initiated by someone else.
>   */
> -static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
> +static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
>  {
>  	struct scx_sched *sch;
>  	va_list args;
> @@ -5230,7 +5231,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  	case SCX_ENABLING:
>  	case SCX_ENABLED:
>  		va_start(args, fmt);
> -		ret = scx_verror(sch, fmt, args);
> +		ret = scx_vexit(sch, SCX_EXIT_ERROR, 0, exit_cpu, fmt, args);
>  		va_end(args);
>  		return ret;
>  	default:
> @@ -5252,7 +5253,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>   */
>  bool scx_rcu_cpu_stall(void)
>  {
> -	return handle_lockup("RCU CPU stall detected!");
> +	return handle_lockup(-1, "RCU CPU stall detected!");
>  }
>  
>  /**
> @@ -5267,7 +5268,8 @@ bool scx_rcu_cpu_stall(void)
>   */
>  void scx_softlockup(u32 dur_s)
>  {
> -	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
> +	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
> +			   smp_processor_id(), dur_s))

nit: maybe we can use smp_processor_id() once here, like:

 int cpu = smp_processor_id();

 if (!handle_lockup(cpu, ..., cpu, dur_s))

Thanks,
-Andrea
