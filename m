Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022103.outbound.protection.outlook.com [40.107.193.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F91223336;
	Fri,  4 Sep 2026 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526871; cv=fail; b=HB8O/6XSJoN6UPxdJr8sv9l9zkWB2yxw6vF85/0sZ5fdpMztuDx37yR0OEUdfyAEohzII/5nxfKNDP8vJTBx0N+YXtfsl20dYwzEIFSoKKlxnEQWMPSKHmZABiG4fKwjq1yQObB0ChP6eD/3Vj5qjTb388868VyN+8A3xKrbWEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526871; c=relaxed/simple;
	bh=9Ya/+U54wH/jpdiKTS4de6+qjxkPFPBN4R4wDutfKlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtO+ll7GVADToQs6st/kuKcducYL1+XpvWt5qRKBNOE2yp52AJkBA3nnfe9NAwuc902VJraMr5YyFH3D3p7AiYqV0N/hEscVcARuhP9+ktGWjF8UO5i82obXJQu6NDFC5R0q8nhZSDwUN6gXyfZQkd9yFqcDqUrA+V4Zi8b5ZUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=iwzp+An3; arc=fail smtp.client-ip=40.107.193.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iwzp+An3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEijYreH1QaCIMwVYdWbIWngoGHVMA7c/TH1G5ul7snqzUyYTP7DiaUEyAuLD/R0pcDlPwIeoXRWnTBP4eDQtn7VTRnQp5Kab8iuQ32vamjieLjZXOBiwQ+WApOze++5et2yICXAbNREO9jQxCsK4+wglaTNl1vxGK+CNKB7GlvxqFeYjBYMMwG1KDybRPxGPOohZ0Zto1irH01AtUM1HmNYWNu5U8jCXL1Ue8dq9/BHJxh844PU1WKpsd/6aE/fXicLShFLcl4ICe/yE8m10KWx0TRHY6aODe97ivF1/tfO8CHzgILIf6h2IsxyWYA7dYkYtD22B1uVmOzqGHsFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYOwvdiiyJkc2cSf62650hPwPU9TFmW/fZVSrNu/3Lo=;
 b=w2QJnNen+r5JW/LeX/2NL+tYU+M/L/b4D3fdqxfpaR6E1sF9O+Mie/x4gp203896aFS7Xz5a4R6GnMZLSWeDl3JW3HCXCded0yF2PG5nD6icFSSUvKnx5UJccc1/YKe70BmuguIBQjkEMeEyQQotMQuap26z+rI0qUpfpCR/Nv/fAt7iYsylB8iKJRfIg+RALWXVsziiwIqUqLR7+8apUFnnd9p8iE0zE4HfrLMX2L04QqenD3WZI/aeWn/YdFvHTTs2NZY8b+OlxNfl6veY45AjGko2GR8OtFMb8v9GBzOOlGBuXFZqZYK1cW/cMhFnm1WwZ+vZGW0+9PYUTdYQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYOwvdiiyJkc2cSf62650hPwPU9TFmW/fZVSrNu/3Lo=;
 b=iwzp+An3GhrDx423XieUKyNWdJ/npAMLy0/c2oHQ93YTjijqXYdjirX5rUAfmEYzJIQ+sCjTUpT0N+Ey4u2PKTVE/gAboJiW5CmM5e2UATebPBXHovoRDYneABBcN8dEN4M2oGzodLgP02bEYSB7hbkBFQSJte07kb7bfrd9fpGGTAhOwtp8d+pyZPgfeqqkbj67vN8TkmHHPxnyqDKJYkwlixm6hQVwMF/RK1CU++drzM21SBboKB+lEzxSmtLBLH/QzN+nrW5+Iv9bXmXFS2Einfrxxjxo7d3aePuQmRACosFIQE2WOvQkH6KAm/Uudd8bNqfxU3/+3lfOPuOnGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by TO1PPF85685F8CA.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::664) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 13:01:07 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:01:07 +0000
Message-ID: <cd110e62-da2c-4366-b9c9-24c1df6a39ec@efficios.com>
Date: Fri, 4 Sep 2026 09:01:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hazptrtorture: Fix inverted sleep condition in do_pending
 kthread
To: Bradley Morgan <include@grrlz.net>, "Paul E . McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804000340.4812-1-include@grrlz.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260804000340.4812-1-include@grrlz.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::35) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|TO1PPF85685F8CA:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b928e3-4de2-4a1b-124a-08df0a8495b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|366016|376014|22082099003|18002099003|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	GaKYayRGKBn+/goKuoK/xaFfcDsLuvaeWOqsjX+Fc9PQEFBUB4bdXt82eojPo7kvzji0BzB0spQHW8bm//9aOQkAQYG+FIb0PO6AfSsCKmK9yvGrSOaTn5EvVbsQbqJHWH2f1Um8mmM/dx91rF2A6kwAh/h/JUqW3Ez0KSsuJE+A9uOBF16qxxaBN+sbj24oEEc93SD3iI4cq2bDb2jkMoVJXIWtbrBmkLwrGB+FzPTxRGtaufclqHmhdx4PrSHFPuWYUdVbsQYIDkGjiCeE9QWJTTu5Fm4u1db1EfYPghvGJ8zdUKhY8bYOJfHPQcodnj6iKY9Psa6tgCSdqGwOnxuZVTcfY2j3kix+Dookhkd0x5HCxpt6GNTvp/dtks4o4W/D+w5Bla5IUDERvTzQ4CnINGWvCZe6c2w2CwVcipYZ0a9dUnAI2s7nnNTMxBR0XKzHWDC16FzqeCv2wTkAcX2hp6upFGcYS7mjz18vbUYuZOdEjUzspGkgbOi85fajD2nm4MxOpZFxkx+GJGYVHyobI6trYvAryb+sSU+18vhVfKxSGlRyzqYOsMsq4moqyfSvhhj38LYhVhGtuAJS1vbUj4gwlM1V9kXjPlYvPkc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(366016)(376014)(22082099003)(18002099003)(56012099006)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjhRWnRqQzVPcnp4MkNXcVRvdjJydlhhbFowMkRHM2YwUWlhelZjNi9Ma3JC?=
 =?utf-8?B?Y3MvYnZOZ3E3V2p2OXlFRDFsbDlQQmY1Y3lFT3ZiSjQ5N2U5M00vbWlOdmhy?=
 =?utf-8?B?ak9iMFJObElrOEh2aktvQW1TTFlWeWRNYzVYL3IxV25DckpZdE81U05nM0VG?=
 =?utf-8?B?czlmNzhYeFNtSFFRSTBWWkdXcFU4NGpJUFlpaHlMalNrNXJHVWR3SlZ3N1lx?=
 =?utf-8?B?Mk9LWkQ2YTY3bEZjMUwyMkt0R1lhczhZNkVhM0VLQnpUNU9BUUN4R1pqcGsz?=
 =?utf-8?B?ZE85V2p1TE5aVHNhZFdsMEk2VWxnemthQkV4UzhTNzBydXFnenZmSkt3M2Vo?=
 =?utf-8?B?NjkrZVFRQ3lyY21iVG53ckVIQWc4NkhuQmpBRUM3Z3VZUTVMK2FsQnZqSEIw?=
 =?utf-8?B?d241NzBpSjN3R1YzU2FpYmErU2JpS2VNcGZsak9FdW1tMCtnbzEwdGMxSnVn?=
 =?utf-8?B?QlJJZ00rc05objRldmo0VVdJMmZDdFBiT1ExeVoxRkV2aFo3UXNuTTE1aXZq?=
 =?utf-8?B?b3kzWVdGeENhRm1rS3BxUUllazBBd1lzbFRnK0xBRGpRNmVFcGxsRjJpdSs5?=
 =?utf-8?B?R3g3aWViTzAvbThleDk4RURRQTJIc0NyZ0tNUlI2Ykpwemk0eTcrV0RIa2t5?=
 =?utf-8?B?Ylcvd0llTEpxNXNlbVZ3aVk2WDkrWTYvWmQxbmErK0U0eEx2QjRCSXB0OXBt?=
 =?utf-8?B?U0NWMStNNnV5NGJsaWVNaE15dTZVVURaYXhCekh0bjgyWkRVbmgzQVI3eFRN?=
 =?utf-8?B?VkVGYnp3blJjR3cydnhvUGk4ampJc21RQnVsYk9XOHNiWlFBL2JIcUpjUjln?=
 =?utf-8?B?SUtQenhrbjY2cG5VR0MwUmN1a2JPSzc1Q2c2cWpsR2ptQXNNN1FxcHJaOGxB?=
 =?utf-8?B?a3JLLzMvMmJmeEFHMDNGU0lJRU1MNEZXaFQyVU1OK2dzWk9kUjQ3VVpCNksv?=
 =?utf-8?B?UVBoRTkwcmlrMEMwQ2liejZiTU0rZlJIWFQ3VnkrdjNoaGNIQjF0TE05WVRo?=
 =?utf-8?B?QmVEQzR5THFGbFR1U001Z2dtL0Y5a0VUdm1UbFE3VVRzZnBESWNaMHZDMFdF?=
 =?utf-8?B?ZlV3SkQrK3JKbXRPZGs3cnBOTlpGbWs4aEwwRzBzaUF1NnhncURRM1FESUVN?=
 =?utf-8?B?U1dNNWN4SFVLMXU4NkNKUHlRbzZlN2tFNU00OVBjbFFrOUI2ZW4rK24vUUNX?=
 =?utf-8?B?Q05wdkJ5bFpURHlZOGhKL1BHdW1DZFRMQ3dVMElIN29INXJwRFNGUHEvK1pW?=
 =?utf-8?B?LzhWK0trYk0zdWp2aXQ2RW5hWUlNMWFKelJzOFNMcHRydUFCaXBSUUV3RFRD?=
 =?utf-8?B?S1VRV253bjM0WWtPNHR5OFNZTk9JR3hnOHdNa2lzMlp6aWRJZ21sajlYM0Nw?=
 =?utf-8?B?MDZTc3VqdTVYcWMvbjN6elVOREgvUitZMWE0dDBQc1hES0ZQdlF2bXQ5ajBk?=
 =?utf-8?B?TXB3NnJ1QXNiR01Yajk2UEhhajhwWWxydkpMemdnQWxzWllxSUwrRzJJWDVJ?=
 =?utf-8?B?YXFocmtyc0RRZXRzMW82QXBDS0JQUUFGOFlpcnpyMkxtTklUaUdHZVNYT1c0?=
 =?utf-8?B?SGhMRzg2SVJVZDlvNXB6TG8xMGVJc0VnUmxmQ2Z0dkdrTzJYb2l6TFJoN2FR?=
 =?utf-8?B?S05BQ3k5Snk1Nm9ob3Y3VVFmQlk0amJURXFTVkxoY3JIYmZDT3MxS1NWUWZn?=
 =?utf-8?B?RUdyZXNucndUajBzbDVEQitxdXNLL000aVhPMkJ4enk2a1JxazBkcDlMcVdU?=
 =?utf-8?B?NE1qb01XU0hKTU1uOXFFZGtKenBEbE1sYjFwelNZZjI2TXZpZytmam8zQ21n?=
 =?utf-8?B?Z2dYR090U2I4Y0JzakVpdUpxajAyRkdnMm9JL1RuV1dnMVdpd3Rxd3Q3Ukh0?=
 =?utf-8?B?cUdwVDE5RE9ldkVJSGpsaWNZaFBMNXpFNWdOc0k1N2hlUndFOGlZSTQzMmpU?=
 =?utf-8?B?OW9FRk9keFkxRW1CT1h6aXRPcmE3N2NEbUlUTmluM2FTMHlRRlcyT0hVdG9I?=
 =?utf-8?B?cVBEWS9YS3VMRXU5V3BRQlRwd0pSSDJiNFZsOHRQQ1pCdFJGV3pxcU0zMzZ5?=
 =?utf-8?B?TitmV0VOZTFKWUNzUWNEVmxHay9aTUt1VUZPSWRuSG1iamJFT0FXYmxMR2RM?=
 =?utf-8?B?TnM0anhZNGt1c21iN0ZESGcwb0FVN3FBY2J4SEFBVkI2dDRZb3lzYmxwWFMy?=
 =?utf-8?B?ekkxbFRLRHlZaDVTeXFjMEk5a25zeStqaWhTaVlGeWFMNmpkT0JVNmxBSklZ?=
 =?utf-8?B?VlNHNWZ0ZnF4QTE0alFWcFRIT2hUc2dJUTNGNFMvYkhzejFsYk1Pb3dvaFJi?=
 =?utf-8?B?WDlsaEIybGh0ZGJiNFFFL0I4STI2OFozWHlNK25ZUUhSZ3VNN2FGRlp5TzEr?=
 =?utf-8?Q?+exjtwaBrzd7aUts=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b928e3-4de2-4a1b-124a-08df0a8495b4
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:01:07.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r35X/6ng4qRN1DwVOyEPNYi+ESVsJ7Vi7FUc9ybZFLVRN1fE0Izo83Kb2F6EZDuU2lyxZAObW7mLO/I/9nQbxZ6HC5lTdz6ubBZjT0Hej1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF85685F8CA

On 2026-08-03 20:03, Bradley Morgan wrote:
> The do_pending kthread never sleeps. Its supposed to.
> kthread_do_pending_ms sets the gap between cleanups, and the docs
> say so too. But the sleep sits behind torture_must_stop(), and thats
> false while the test runs. So the kthread never sleeps. It just loops.
> It drains the pending lists over and over, no pause, and burns a full
> CPU for the whole test.

Paul, I just found this patch in my junk email folder. Maybe relevant
for you ?

Thanks,

Mathieu

> 
> Flip the check. With !torture_must_stop() it sleeps for
> kthread_do_pending_ms between passes. When the test stops it does one
> last cleanup and exits. Nothing left to do, so no sleep needed then.
> 
> Fixes: 94d2e93c222e ("hazptrtorture: Add kthread to release deferred hazard pointers")
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>   kernel/rcu/hazptrtorture.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> index 72aeb50668e9..7c8b5899fb01 100644
> --- a/kernel/rcu/hazptrtorture.c
> +++ b/kernel/rcu/hazptrtorture.c
> @@ -555,7 +555,7 @@ static int hazptr_torture_do_pending(void *arg)
>   			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
>   			hazptr_torture_do_one_pending(cpu, &rand);
>   		}
> -		if (torture_must_stop())
> +		if (!torture_must_stop())
>   			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
>   		// Omit stutter_wait() because this function needs to do cleanup.
>   	} while (!torture_must_stop());


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
