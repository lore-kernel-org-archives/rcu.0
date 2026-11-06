Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990950;
	b=AEnuMQ15/lfi6w+MQBmZiUIXKugt40DFyxcqzqHKuSZHR1QehVfyux3aqaPW1/kn5sst
	 XBg8z0ear1rgSDaMPL94IDstkTjAPJPpA9C/tx1kMglpz6ENZneeM/l44NAIE1smObmma
	 H/3pKntWebKSkdf8+qJRxtawms6RSemk6lNOskpefyy1TNRfo8Da46Shp00ftN24jEplj
	 AFeqP1oQmtuzvYxPfGQzi8adu3umv8X3f4H0KjebS3m717FDvCrGdAS9cVVtF6407L/SX
	 aTscHX6C9FrJ4sfT4M+NG9d6BsYsG5AdQ9cU/GyrR0+4hJeh1gZ5OaRo+yyMbaSxTNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990950;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=r+FFZysMJGqhuQqYWqQPSq55YTC1psTEydctIpceXvk=;
	b=JXl97l1gij3G61z5udPs7KlBAybfuCYLbrKtVDPkMr3ui4FHjHos9v5Ie9USA8RIMokn
	 yc3tviJqDgNcHkKTskJCf/1DiBAVsHIdM3zsdssaMIwt4xfN2nkHtzwPyiwje4PPsbWbO
	 a4qRH6GT6s4E5tHwFFlk9zjY5cjeTOyAX52AY20G5Q3sjcGj0UirmT1tepZBDLlz+aP8y
	 TTbcOBLk54FM4iXCdmKeAG9fNmd3lhwNdeM48pTAnR5x6vjIbkAAeJzF+FoW/wtsbzbzz
	 7CnTq0bZupWi7ep+nDewY5yz+u13UwiVYCTruoB0qOOYPj2nkerOc1jUvmR6/Znb8Jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FFg8V6RE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.22
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E80606A329;
	Fri,  6 Nov 2026 18:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E80606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FFg8V6RE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqh1wKNSaaD4yGti6eRQaKH5nPLpkaJWXI84kfX7fJ18wrRSWFAd/iXVV8MeypVvQJX793GnM9I0HSyC2L3t1dipvOskrQXIJ5/Rlkrku4jp+u1aaKx5CNsA5sEvrlW13zk4vh9lyG/jaeIh1AOhrrYHZl2BE3oYA+ljJuXGL//mm3URLvUwmrjHI5a+RN7L3w6T5d/Q4A6zolJrxLPTVfqsx1eyRHlfaegq/LBENh3GFXkqV2rTgTIeGMjfO1LdeUpLXKTx7rNvOyQQZ8f/i3Aag2f/WXdH5cf+5eSEJ1ic5X31sxn8PZkGqzq+Ndnq9qIVr6s//BelkZoasJHf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+FFZysMJGqhuQqYWqQPSq55YTC1psTEydctIpceXvk=;
 b=jpUqRNMBEyiFNjtP6GMGm3QoHHEYy5qEA6W84e+j6tm5Jp//+qHFVfBzrTNi06kbpo9BhRKToexhbWxR6sMFbxhV5X7S4TmtEKJOZlYmCXWDWhfUcibJ6XeWvctJE2zsHiTRWdmB6OZaKGmUT9BRfH6gtFPqkIoSzWmTLUAaV/z1lkSSym95Y8HTpfIN+05NPpoy1upMnIwThKk4LR8UVSQA85ZnipzhXpEj2BjXOMegAaEwERafiMgRCVM4B+ajwxH0WeVWomREz/chyuQq2wkpEU8uO0ZSIRyPJifkUz63w9NSceI+/O6WyXb1vY8+dKltfNGVfwUI3Y4Nh+rShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+FFZysMJGqhuQqYWqQPSq55YTC1psTEydctIpceXvk=;
 b=FFg8V6REF5TkLVR7MpGTssvExg4vtSMxzYJYcuT0NAsTst60K0f4x2EJ0lC8TZuszkFs4x7nvi0dqcj6eG6lhsGCOEpY38rI7DvVhpD332pU/JCqNs0JifG05WFNucU2GFllXK7KiA08Oyd/P/MjMdjDwJBASq18vndgJ4QeRzy+ddeNMq/TREK+cAoSlzpoCexeQWNrg/dXAyoBGIS4aD+8Q3LAV6McoCMRj9Q6O9mtQ9Q3vt9pfNAn8R+IVqbws2KvYTaGIKbmtF7o/Ac4R8iep0tIVA6W2Bys32e0cEMlwrBEtQDH3gVaxAKL9jJQqjsNUHvA6DI1t3YYIhhStA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:49:06 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:49:06 +0000
Message-ID: <7883f32c-80b8-4bfa-a4e4-f1e04da647f3@nvidia.com>
Date: Fri, 6 Nov 2026 13:49:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] rcu: Record callback enqueue stacks and add torture
 tests
To: Kunwu Chan <kunwu.chan@gmail.com>, dave@stgolabs.net, paulmck@kernel.org,
 josh@joshtriplett.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 boqun@kernel.org, urezki@gmail.com
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang@linux.dev, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
References: <20261106143913.3627722-1-kunwu.chan@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20261106143913.3627722-1-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9cdfc7-aca1-4b54-c3b2-08df3c36a242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|6133799003|10067099003|56012099006|5023799004|11063799006|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	OsreDHQ72bIbc3HS5GTNDyx19n/EIvgB5qfOOHmVRbLxAkVv9/1Rfq+MnMn5EJc2RWKdImchC5grui+yM5DZ4fUaciwUVan+1zyE4NCiaYd8rHRPjpS1sMYDERwK21aIkFpCb9JjKLxjZaiIiMQZJUvrtCLER6wWyYXVxbmZUWyPQKAqeu+gSDm2wEi1EVcNSnZCTDxwXRiVHitFhSKddT9ZWMvHYWYGghHSXg45P9NUJin7GsYsSILR9WOboyl5yK2TkJD4b33VgYNEh7yjBDbNF/Je2kScUedPDeLWqUs8cdROhGEZHqBpKLgZlNQGXp1+YsvCL6t8JM9roqtLzGtoknWJfDvoMPsq1xa9CODvyUT6GBGkvJNZBO5Z0DnwDdMC2QSHvbCbpB+5ZWzB1KYWH+9LNz6gcMFcl9PsPv1W6+vK+w4pEOWcCMA6yanzMr7OoMQn6l5agAlu3NRYasvWx/FobpZQh0v/mKocThzD408qjkKHKZWjL/ANT7ZiDzn9ZIlLCM3GOCTg0hbtU2GDaOx7gVMvfcK0LKed1Jr2fnxyeG2lI+rhj12kTSSiR6t8ADfV5pG9R7Zc7C6EO7SloE3m4o5YalZcgkfIw812Tbmm8JmYU1Bk2va2penrInzMOqO8GNJOuL1GMq0yn2mWgQef7vslfEJadP3Ja88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJteUNiVHduK1VnVFFxZXIyZ3BzVnNoeEVrd0RlQmdzU3BmZG43SHFVd1dK?=
 =?utf-8?B?a0JZSkNiVmJIMWNVbGxYSTdhRE1OVkpjZjVzdWRMNWxSU09UdUprRjhFRzFL?=
 =?utf-8?B?RUVDdUQ3azFITlJkemV5b0F3U2tjOWhweEN2b0hnQWI1TXhZZUx3U0s3U1pZ?=
 =?utf-8?B?VW5Ecm1ZaUM3cVFJWWsxN09pSUMzMmJobkxlczRVMFBjQ3psaWpqNE5PNXow?=
 =?utf-8?B?YlNmTDJtTm41VlN0TmFSUWdMaWx3aW1Bd3I2MkZFRS9jYkdwakp4K0R0TVBt?=
 =?utf-8?B?b1M2K2EzTFYzVnN6Z0I1QjJ4SjJtQ20zSUVGSm5hd0dmL0o5alREN3gxbEJ3?=
 =?utf-8?B?N3pzQVNydGNWRmdmTDJ2UG5DK2xMSWpBT1JUdld2QitDcVlEZ2hHWjN1bWFC?=
 =?utf-8?B?ejVsZ1I0Y2hIdkQwSk5xL3o4RVM5S0NEN0djMnBUS09jb0tleDJUY21LNjRJ?=
 =?utf-8?B?RnBjRU5mSy8vR1RCL3Ayem9XUGd6N05jMUg1bUg1THJPeExvTFIwcUl4ek80?=
 =?utf-8?B?aFIwSzVSY3JnSUVQZDhTc2xlSEZPbkNvT3Fack1GYU5YaXdCQld2R3BRaVRR?=
 =?utf-8?B?VFVKa0l5c29TSkExejFxN3grWjg4Mk8wSHhBdm81Wjh0TXVKY1d3aTdGT1ZW?=
 =?utf-8?B?RjZITi9yV29BOTU1Nmp5dGYyWE9aeVlUT3Q0aE9vNlBkcHl1dVdDN3RSclF4?=
 =?utf-8?B?K05VZWtmdU5lQmFXdUVtcmZnZlZxemNjc3gxZFB4TllZZmZBUWphNGZNQUYw?=
 =?utf-8?B?MVVWa3BzSjNYbDAvOWtjbGdVdG9EdnFwdEh6ZC9MWGNWb1FGQ0hvb2kzWXYy?=
 =?utf-8?B?STZEVDdCTml0SnhEWWVIRWxwbzh6RmZjRkZSMlZqN0ZuRHU5ZlE1Q0pyOGRm?=
 =?utf-8?B?UWlLN2ljeGtqRHlqN3J6L3JoUEFUczlEdHVDb3N3czlsV0ZHKzFXbldQTTVk?=
 =?utf-8?B?S0dxV2FvQ2Y5dm9oOFNTUG9HamI5TU5KUkRocWs5ckE5bHlDZDRCdVYydjE2?=
 =?utf-8?B?UXVnNFVpMEc4MzlYek4zY0FQTmxoWEZQL3RFb1daK0JwQmxYQlQ4YmFUT2pO?=
 =?utf-8?B?Zmw4akdoWUpNQWpCQUthVGR1c0N2UVRZVEJhNXY5WkVEMHVKaUh2N29UZ3kz?=
 =?utf-8?B?ZVJUZWFiZTFjZi9kRjJtY3RZdU4zRHIwUGxzd1JIdUgyTHV2U1VSd3pvSmMv?=
 =?utf-8?B?MEVKYXo1ODhJazBDREF1NXZBcU1OZVBjTE4yTWJITjVkTllEMm40RzdSK2k4?=
 =?utf-8?B?THN2S251T0RmbE1YbjB6a3FVWENudFBJV3VRT0FXaGgwSHBZM1NNc0U0aVZp?=
 =?utf-8?B?dFMvd3QxL0pWaVBiUkJCdEF0R0ZEU1FDajFpNXZUVmFQdVAzTnU5ampxaldD?=
 =?utf-8?B?eVR6Z1R0L1A2TXpYVlN1OXJJNnFBWUp2c1lTUWpoL3lKNURLQkc5T0dzR3pC?=
 =?utf-8?B?S2VWbFF4aWE2STBWR29JUGxrdzM5TUR5K0hRc2ZJajYyc2ozaUl2WFYzS1VL?=
 =?utf-8?B?dWpGTjJwRVIrMFF5L1BJVDQ3VnhKeU8wanJybys1Q21xZHpaazRwNmxPSC9j?=
 =?utf-8?B?VVhhcVYyTzN5QlorWkZGM2ZvRTM0a0FBaFpZOGN3NENXUndRSC96Y2ZnTzZ4?=
 =?utf-8?B?YUtka1dMZERzMzRub3pMcjVUTW1JdjBVVjY2amlma3NadFJCeWFiV1FNS1hi?=
 =?utf-8?B?S2dISk9ENDJGL3FxOTlNNFI1UjZiMEdIcFpIbDVUcDZVbFVGYTlkT1RoM3I2?=
 =?utf-8?B?MmdzYW1ac3BhbzB5bytCYk50ZUIyZUo2L2RycmQ1TWc0emlQQ2M1aTBiUWFm?=
 =?utf-8?B?MGJWbVdSNFRiYXRHSWYzZVg3L2Z3dDVuOWZoR0taTExCVUpJNnRiVHU5UmE2?=
 =?utf-8?B?aGJVQit0QkNLbmFRUWFYaTlvRG5XMHZBSkZFSDl6QngxcFNGRGQyWVNGT3M5?=
 =?utf-8?B?TDM5L2JoQTNjY1ExUEM1cWFBNGY2YUMzaU1DaUZzZ05INnBGbFhCbzBlWGxm?=
 =?utf-8?B?SDVUZU95QTZnYXZiSW9QblJtN2hEWjVSZnJJamV0TU1mc1ZsdGVFSTRQZzUy?=
 =?utf-8?B?SldlQVREckFQcTVuSm80alBreTc5ckdyR1dyNGJJV0hzdW4zL2dZUG95c3NQ?=
 =?utf-8?B?RHhvTXNJU1ZhUldBeGJ0OHUwd1FsVllESmcvaEhtaWdlRkN3SlR2WmFqZVBK?=
 =?utf-8?B?bEx4Mi9mNGNsY0JDZzhxc1dKT3JicXlBcXo0NjJEVjRXWnp1aU5NYlVxZkgr?=
 =?utf-8?B?T2Jxb1JUWU50aGh3SlFkL2VRK1NiRkJXNWVwUk5kNWU3N3dCTGFyTzhLa0Vz?=
 =?utf-8?B?SXZHMlpyVk9tSXl6NFVkQ3JvWW9kWHZROURZcW9HUUJZZkFBSmV1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9cdfc7-aca1-4b54-c3b2-08df3c36a242
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:49:05.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjswwHW7WOo7X6Du5JwJvhZ1wIcHEmaJdQc7S4T31urr5Y4ruepoBFll6J8fwB8883JkQzvHrT1S1jKRNtEZkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271



On 11/6/2026 9:39 AM, Kunwu Chan wrote:
> This series adds KASAN auxiliary stack recording for RCU Tasks
> callbacks, rcutorture coverage for duplicate-callback detection,
> and KASAN aux-stack verification tests across RCU and SRCU flavors.
> 
> This series is based on [1]. For testing, I also applied Joel
> Fernandes' fix for debugobjects tracking of barrier callbacks
> [2], which is needed for the barrier tests.
> 
> The changes:
> - Record the enqueueing stack in call_rcu_tasks_generic().
> - Enable duplicate-callback testing for the "tasks" and
>   "tasks-tracing" torture types.
> - Add a KASAN aux-stack verification test module with a Kconfig
>   choice for each supported flavor.
> - Add one rcutorture scenario per flavor for the verification
>   test.
> 
> Tested on x86_64:
> 
> - TASKS01, TASKS02, TASKS03, TRACE01, and TRACE02 completed
>   3-minute runs successfully.
> 
> - With CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and
>   rcutorture.object_debug=1, duplicate-callback detection was
>   triggered as expected for both torture types.
> 
> - TRACE01 was run for 1 minute with
>   CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and
>   rcutorture.object_debug=1. The test detected both duplicate
>   callback heads through the SRCU enqueue path:
> [    0.405836] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
> [    0.405852] ODEBUG: activate active (active state 1) object: 0000000020df980d object type: rcu_head hint: 0x0
> [    0.734724] rcu: __call_srcu(): Duplicate call_srcu() CB 0000000020df980d->rcu_torture_leak_cb+0x0/0x10()
> [    0.734780] ODEBUG: activate active (active state 1) object: 000000006634e8c9 object type: rcu_head hint: 0x0
> [    0.776688] rcu: __call_srcu(): Duplicate call_srcu() CB 000000006634e8c9->rcu_torture_leak_cb+0x0/0x10()
> [    0.779126] rcutorture: WARN: Duplicate call_tasks-tracing() test complete.
> [   65.411342] tasks-tracing-torture:--- End of test: SUCCESS: ...
> 
> Both duplicate callback heads (the stack-allocated rh2 and
> the kmalloc-allocated rhp) were rejected and neither was invoked.
> 
> - With CONFIG_DEBUG_OBJECTS_RCU_HEAD=y,
>   object_debug=1, and n_barrier_cbs=4, the TASKS01 barrier
>   test completed 630/630 rounds without barrier errors.
>   The only debugobjects warnings were the four intentional
>   warnings from the duplicate-callback test at startup.
> 
> - All five aux-stack scenarios (TASKSKASAN01, TREEKASAN01,
>   SRCUKASAN01, TINYKASAN01, and SRCUTINYKASAN01) produced the
>   expected KASAN use-after-free reports. Each report's
>   "Last potentially related work creation" entry showed the
>   expected enqueue helper:
> 
> ===== TASKSKASAN01 =====
> [    1.244567] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0xb0
> [    1.244707] Last potentially related work creation:
> [    1.244716]  aux_test_call_rcu_tasks.constprop.0+0xc/0x20
> 
> ===== TREEKASAN01 =====
> [    0.670399] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0xb0
> [    0.670561] Last potentially related work creation:
> [    0.670571]  aux_test_call_rcu_tree.constprop.0+0xc/0x20
> 
> ===== SRCUKASAN01 =====
> [    0.658679] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0xc0
> [    0.658919] Last potentially related work creation:
> [    0.658932]  aux_test_call_srcu.constprop.0+0x16/0x30
> 
> ===== TINYKASAN01 =====
> [    0.951503] BUG: KASAN: slab-use-after-free in aux_test_init+0x8d/0xb0
> [    0.951641] Last potentially related work creation:
> [    0.951650]  aux_test_call_rcu_tiny.constprop.0+0xc/0x20
> 
> ===== SRCUTINYKASAN01 =====
> [    1.009005] BUG: KASAN: slab-use-after-free in aux_test_init+0x94/0xc0
> [    1.009141] Last potentially related work creation:
> [    1.009150]  aux_test_call_srcu.constprop.0+0x16/0x30
> 
> 

I'm not feeling very excited about adding more configs just for KASAN. That
sounds like a maintenance burden. I believe Paul already has KASAN testing in
his scripts. Is it possible to activate this testing only when those are enabled?

Thanks.

