Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323722116F4;
	Thu,  5 Mar 2026 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733235; cv=fail; b=QCwhvI87H2yJFK/iEuw8QLThGdPYRvbJrOphM7qJbe1+ImPvvh85YD5zkneubzuEexaWQjxOjRngOVRma97+XUEPSbFaQ8q2wdwJU+x0u7kvpNtbbRIKYncJAAdMaZOUHZ1a8t3SkDxDUziivohVzC7vqsK5yzGVRZHN08uXIFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733235; c=relaxed/simple;
	bh=NOiWnDmHX22YsntMtQOU60plcqVuTnpTmKMaxA1A8ig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YKO68eQw86orclMWAR9eg8uUgaOzvBOKDxiSMN6f1dX5kKaNC1pAERAb5a2G7aqqlxOOa4RCzbjXaKdINEfiTTk1kDIrHukjg/5v0GRKZfd2SDt5By97BqQMdRmaxJKXoP6waHERK7CVvIhUvIBTv09vbkS0T6qdCTUAMaJzuT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RQXsP3J6; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RQXsP3J6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fv6fBc6Y/6ZnQSx1T+1YzAuGhDfsIFNbXaksH/OPQYsIuJnqmaPjsDVXdXEN3s48gZNGHs2F9O5dwh5C4lSrooNTO31Sk1OaYgRgtcwpa4f93QzPv0pTUgqu6pKsDNWbxGMJvkJb8J9SAX2Sl1DP5qTxdzs/3mg4/anh/ojLm4rzlsIcbK2lBtor9iUDMTCVLJ6DRsbMAj6iPyDszPJLKIDc4g4qOarDsB/WMOQRu4fardbUwDnKPEulJiTWvLyLQfpYDIpCZliiVJiqSMb9BnpeRLJrW80LWDEd6g/PsHvCcNF4x2uNN8Fms1Ce6QYXi7ZVj+AVYBCWN+7c1rjnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGENd1oasvx4OWtaKlC03G7zNTyOKujFZZgeZsCHUkA=;
 b=HRhMOyvS+8mX+41KZZqG0zFTB958PQuPonUhK8J39QU7uVExMqIfQnIOeWMLHw4YABqhgCniTV9GP2T9gqruk+6baDx44atroyrMK84m6VXVnJlaqlkjdaFaII6WKZ27MoUz3prk7GNeI1eXO1xTwvt86MZ3YIduU9Xqqtxwc9C8lxPIalUTqGPrwojw0rH2XGabufTQT9RteA/0OouVoEZT2CTjKteA59rtTZWjyzp0KCgdqOUsWlYNi/gmteLgxUHh15NNLpnKZDB/aUu4WPYQwn+ALayYio89HwrebSD9JbOhNAHnSRSfr/8+mXHUFsTfKtGPtPaITREQJTGhAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGENd1oasvx4OWtaKlC03G7zNTyOKujFZZgeZsCHUkA=;
 b=RQXsP3J6TVLqc8BtsXPkLRaWmguBhy2s3AKKG9FecqyKDE37BZ5DrUAVO6YfmsntU0WNt4j3KkBvQ9dTGwsItSMofFjn7gyXs1zCx3/O5DivSgT0jrzhf4AmZjtHBP5kZ5vKOuVD08svoY4iCkzr1EZ6PRsOfq1ZgJfKXhhX12od+LmFnBdaYWHk+k/DRBVmFHiJL6jzZmgogW/dgp2suKJbwbRdj54H9X6c9+DpWDvaoXnKUFK5HqLDZNYc/YtS1QF/GZsKT49b6b7KFGYh4mGsUXjnqQFNKSa678PfZnwHYdojADr3g2zhtbqeVKyjNC9mFmqi/Fcdkk4e5XE2qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Thu, 5 Mar 2026 17:53:50 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 17:53:50 +0000
Message-ID: <0f6f8cde-ebd6-4f77-8eeb-51c2fcccfbba@nvidia.com>
Date: Thu, 5 Mar 2026 12:53:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] rcutorture: Update due to x86 not supporting
 none/voluntary preemption
To: paulmck@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Boqun Feng <boqun.feng@gmail.com>
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
 <20260303235903.1967409-1-paulmck@kernel.org>
 <dda12988-2a5c-4549-bdfc-8e429fc0aab1@paulmck-laptop>
 <bfe89f6c-3b63-40c6-aa6d-5f523e3e9a31@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <bfe89f6c-3b63-40c6-aa6d-5f523e3e9a31@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e8e64e-107a-4ef2-aaae-08de7ae0287a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	wjRAvSCunlaIUsPWRV900/yjOMgUfx/itJIhjAS+2k5duZo6ZO8bv31UNISktk9gaOIyCI3QpiGirCRRXb6YeSKWnQWj32CQi0EOqRMJByXfcdWbW2573YK1aVIEXv37HdGu5WEXP8bs1I7i5bTdOk6wWhPKnukVuuCZgW1vjzfD1ztEo3/E7fjUvtdpzabk9fdFN7rqhD3boyiNXBnaBKoJBqebvHV6Gww8hgrzPXN8xWc7faWBN3rdA1eazoRzkFL6p5fcZZQZbfcNddFZ0BRQmHSZolT7Xk1whc6NdxUMa/n9+mGs4wA11s50IIi1nB562MYr94Wt+OI6BEl51/csRaPyNYUi4p4PAkemKTtcMLQjiSFUa/DYnxJf+j/LrjJhZQnvokFqBSStihcfRXdhpiaCCInFSVNFiiH4gZkHpPYJEBYXXGDxONV0qyXD1uVrz6gw+4ndmHK1QBubsw+0ATSk4JUsJydEF7ihuO8u8BmUt0h1MwrjwCo4qEhy0dE/4m/JG2dxuH36c1RDFcUBZV0FB+zamCRPGMJpBLqypRoAzp9+Rzrgw2QKwR9PhuDVU93Gk8UWRQf3Dqj+wVTPWxMdLpwE28rjvnnyn2lqOz5bh+l17wQoQvjUHLYifr/qabUrcn/LJVeWElNlYr0Ok1uDwZr5rVrMIXSiWzxEt445plBApBaTW4uw9p7xk/n2sQHMco8MtbU6aUtAGVtLXmGpYtpAT5ShsupxZgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzV6U3FmSjhweUtDQzJyeE1RMHFHN2d1Q044UktPSXJmMkE1bzQ0TWRrZDh3?=
 =?utf-8?B?QndENWRIRUlnSjdVOXQ3N3B2RDZSZi91Z21wb2RpYlF0ekFXR2FGdHY5QTVH?=
 =?utf-8?B?NmVHVFhjRWtyQ3JGRUVtTzYySERmdlNlSHNtTVc3Tk9pcnZLK2xuSGpaSGtZ?=
 =?utf-8?B?MkdwU0VFb0NuWWpBOXRSRVBEakg2WHgramhzSWY3b0pWRzNzWkpkc0tKQXNK?=
 =?utf-8?B?YTRjSmpUeUpEQUN4WTFRUVAxeHhvamhDLzhEVVJ4dEZkbHJ2a09VbmxUVm1p?=
 =?utf-8?B?N0pZRnJUV0tyWHIzRkNQRWMwQ0ZINUVTbFFQVjZ1Mnlpak1tSzZMN0liK05D?=
 =?utf-8?B?Y2Vwd2pYNFJFb2pPN3h2VUozVUxzc1FWL3pUMGhNUkdkbXFmVlZpNXVUSnhW?=
 =?utf-8?B?ZUFTZDJyTDJNVDNsQmhBVVJYbVk5MlFzeFY3Kzh4RlA3ckxEakl6U0FRU0tk?=
 =?utf-8?B?UGtpL1RTZ0VpSlFOZFlLcXkySUcxQ0dzT3BBVmE5UWkvMjB1dlRCV0IxUVhK?=
 =?utf-8?B?MWdyc2RyREdCSFVTMlVOSlF1RFlseC9IdS9kTUZaSHN2eGFVZnBNWVIzblZJ?=
 =?utf-8?B?QmZZMXdOUFlRcmlNbjk4Ty91TTcvWFRGdEJYeXdzQ3ZpZ3NQaTJ0ck5rTVZo?=
 =?utf-8?B?UUxTYVpqMU9kSUZ6eGt5Qm03ekJnODBUTDdFa1lBUkdPZTIwVHZGeFB2ODJX?=
 =?utf-8?B?Q1Q5YjQ5RXRWRTZTSjliU2ZHa2t2TXovUVFabDVsUXk4bkhpb013WUx1dnUx?=
 =?utf-8?B?bGUxOUVtOGdaU2M3dzNPNjVydEVXcVBoSDA5NFFuUldTY2Rod3VWWlA3Nk5T?=
 =?utf-8?B?ZFF5eHMwQ0RlODhLdGdWUW5OREUxbHk2NlNUdm9wQ2lLcVpNNzQxREoyM2VY?=
 =?utf-8?B?eUthZHFxNnBZNmg0OURRMDhGcVR2Qzd3ZExLQVpuSFg5Wld3bFVZVG0vNi90?=
 =?utf-8?B?Y25ybEZKUGNxQWpYQmN4N3cxcUtQcmhrY0dzb01DWXhscE82TFkxYS8rVmNy?=
 =?utf-8?B?Q0ZXeWZxbGVza0xQNG8ySTRlNHdMODZiaFFZU3pZMUkyQTVaNG94UGpWc0xH?=
 =?utf-8?B?RG43eU03djB3VkFySmwydXJSNHFkUzBJcmM5aUF5U2N5OGlESlA0YUhFNFhj?=
 =?utf-8?B?Z0EyQVN0LytUblU3TnV6MGZhdEc3VnlUYWd6TjJGSHRtb2hNRGRPb0R2MElH?=
 =?utf-8?B?ZjVyemQveUpSME1BUGdmL2RrMEtPTURsVG5MYmZZNVlzMCsvRkQ1NWRDdjBk?=
 =?utf-8?B?Uy9CTkdCaVNDUUhIU1ZNcXpoTURYVVNGZ3kwdGZJblBNQ2RYNVYwcW41cFd4?=
 =?utf-8?B?ZVVCTnJuYXpjejc1WUNvR1RRSFlza2xxMTJUV2JDZTQrZUFIWVJIZC9QcnRu?=
 =?utf-8?B?aklZWVUvdVYybXFLczFmK05saVh5UUFUSU9acVFkb2g1dEI5NXBWQ3RkUEJk?=
 =?utf-8?B?ZXBDNVQ2cU83WkFIelZTZEEzZWlBdTVaWW5xZEliWUJVSXRDUXhTcWY3Y3du?=
 =?utf-8?B?MDBVQ1NFZlBUT0dBZ0NMVVFUb3RKUWgrQUNxemFDMEhWQ0MwV3FKa0o5LzFr?=
 =?utf-8?B?ay82Vzh3aGdDS3k1VktpN2ZtaHpFcVhSOUdadDBwMmJxWnN1bEM0Zzl6b0ZV?=
 =?utf-8?B?a1lLT25IcUhoT29TMmV6R0F5Nm9UcDh3Qm1EYWtXOGdxTXBTSmJhcnlPYnJw?=
 =?utf-8?B?eHRaZFE5bzJ6bXY4bXRzdkJJTmNQUmdZc3lJZzl1eW8wd1p1QlJYbnZhdC9a?=
 =?utf-8?B?cVB5OG90L2xZYmFLLzNSb3lxeTZUOHprbnRwL1F0NFY2cnBzZ2JORlVoY0Fx?=
 =?utf-8?B?OFVDd3BTR2p2bkZ0cUw5VGorQ0FPYXgrOTg0NDVodzdsVXQrN2FjbDhBM3lh?=
 =?utf-8?B?b0lNbHVWR1FnQmV0bDU4dkZGajJ1RXluMmFvU1JpQkZHbUd2eVZXSkF3UHFI?=
 =?utf-8?B?U1ROV1hqYXNwV05lZWZNeU0zc0lQZGlyc0VqVXJTaTlKU0FwYUI0bmswWUVM?=
 =?utf-8?B?RVJBZk5UTlZXL2tvTHFGeThHWm5PaGp5Mmh3c05YSHRIWkJEeG9KUEhKbTVN?=
 =?utf-8?B?M3VLUGEwMlVUUEo0c0R5QmV5NTVzRDVqZUtvb0VMTDJBN1lFcTIrMUZHZDF2?=
 =?utf-8?B?aU5TcjJwYnFGeld0dXBUV2dNYllxSkEvdkpucnlXL0NEd2YvK3lvS1NmaW1v?=
 =?utf-8?B?dkVXOTd2Tk53WGoxeVdJQ1J2VWxHSFAwNzB1RGRTN1Rxdy9iRzJZL3hwVFZ1?=
 =?utf-8?B?MkxsbVZZamRWSUhMVnQxNXJDOWZoWkl5a2RiR3pHc1JyUUhwYXRyNkNmUXFU?=
 =?utf-8?B?ZUVzZStxbHU0M0w5SHpqSDllOUY5WXRxMy9LL2NramZ4YlVmUmtxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e8e64e-107a-4ef2-aaae-08de7ae0287a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:53:50.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXNWXzGoIS/+q2IVnU4/sumMZWJvWjDMo2/meGIACPr4kRDnmUdbBb2NOqPTQH1AYcyRJVfpaFdpf48HHmm3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499



On 3/4/2026 7:01 PM, Paul E. McKenney wrote:
> As of v7.0-rc1, architectures that support preemption, including x86 and
> arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
> Attempting to build kernels with these two Kconfig options results in
> .config errors.  This commit therefore switches such rcutorture scenarios
> to CONFIG_PREEMPT_LAZY.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> ---
> 
> Changes since v2:
> 
> o	Fold in c69ac5693540 ("rcutorture: Adjust scenarios for default
> 	lazy preemption")
> 
> Changes since v1:
> 
> o	Add CONFIG_PREEMPT_DYNAMIC=n in order to test non-preemptible RCU.
> 
> o	Remove CONFIG_PREEMPT_COUNT=n because it conflicts with
> 	CONFIG_PREEMPT_LAZY=y.
> 
> o	Remove some stray conflicting CONFIG_PREEMPT_LAZY=n instances.
> 
[...]
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> index 34aee1acb8662..ac857d5bcb222 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> @@ -1,11 +1,12 @@
>  CONFIG_SMP=y
>  CONFIG_NR_CPUS=8
> +CONFIG_PREEMPT_LAZY=y
>  CONFIG_PREEMPT_NONE=n
> -CONFIG_PREEMPT_VOLUNTARY=y
> +CONFIG_PREEMPT_VOLUNTARY=n
>  CONFIG_PREEMPT=n
>  CONFIG_PREEMPT_DYNAMIC=n
> -CONFIG_PREEMPT_LAZY=n
>  #CHECK#CONFIG_TREE_RCU=y
> +#CHECK#CONFIG_PREEMPT_RCU=n

nit: Let us add this #CHECK# to the other configs you changed too? Otherwise it
is a bit confusing because it took some digging to clearly see that
PREEMPT_DYNAMIC=n and PREEMPT_LAZY=y implies CONFIG_PREEMPT_RCU=n ;-)

Otherwise, I could not find any other flaws in the approach and it makes sense, so:
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Boqun, you will be taking this through the 7.0-rc tree right? So that 7.0
release tests don't fail.

Also I will drop the 2 related rcutorture patches for 7.1 and rebase on top of a
7.0-rc fixes branch Boqun might be creating.

Thanks!

--
Joel Fernandes

[...]

