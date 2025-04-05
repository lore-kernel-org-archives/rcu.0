Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653525569;
	Sat,  5 Apr 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743850881; cv=fail; b=uWbp3ou6Ucpkebt1AirS+aa4wOKLOFmpYKvMJ6QHv84Z4CWwbmVT0g7l0qG770AlEP3M9EJAaru2ZiMMOdvl2uumzrEa0bwDvpL2pxeKJXkiBp+Nyv1pzavq5GwNsAijh+CMurCH3YoEvDHN41C2u8qkVJqB3nLtYQFMdYwhaU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743850881; c=relaxed/simple;
	bh=p5m9d3Sp4D2GxemZuS50/sOuB7L7fEA6SzzJnnr+bHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rhQivvslzob8tuAELRNJAPSe8GGv6JsKNuaGcc2wM6nYPOBz/kcSnl1MJ7ZhMPkG8SsGapf1UvcANxbQaenQ3FYemJBYyFnA0dl6RGT2ueMOo703vVQIkqx3jIJqx/c8GIp1DNPpxKNSb3OUa+wABTfmK9kob18BxGLA+wKm0Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjkoPaw+; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjkoPaw+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GugOhZm9ckX3DTyWhgk6e5O4MzpYoWRU4+KIPYVLsdsxicI5VCPZt01MD4V0D7ShpxnmrHJNmpVROvHT2luZeD4pEdAJ/RPWTFspqtRcSqNiIzYqJWIOACP0MjIWSjV4/KfGr78hokJJXZOoBsHu3TRjrInWiipykW2PA8eDJYrE0Vk3CS/yNj5P8ufGcWUWLhivkPDVzRhhSCv/FzxEgpzyMkVo4KETE6nDpkWp+JI1kIuTGRAjjHdymbyJBMUGl8t045e+stXn1SCoA8Y7d10roZbjtk5n76O7uEoDDRyiWnVHTUaZX+Lc3RiTd9u8kZ1ZScqVsDz8ZAn1/7ga9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9NzOF4nDWwN8HagDfOGNRHHAAAEHq2Sn/T252JnV4M=;
 b=bcBcG5MxiveJzXPkbsYVe3zzCgietlLscItyKsatImEJN7N73lyxMbdk+mxiqjaGZr/V11dKJJPZkUy3Zqej+vSLZXhwmJ3P5zRyjAOKjcoIfP8sQ64NEpjvXcqxiXVBFKvZrKTgdepqS5JJ4z04jTuc5j8shbxrkp8HA1k6NzTPSoyYf1FKzLaTSpY6hBgUnlY78VJOQxa/k34g2qTVuVXLgE2u1FA8xNoNEKXRaibljcI9Wk7ssjfNJFsYLEeZ6xt+h88i6+BFJB0coCBI1C7p9J+uy46wDArMQZvq6TFz0vtb4WtBbEXZpe84oBNOZ6LknOMMzXzt0mCXUfUGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9NzOF4nDWwN8HagDfOGNRHHAAAEHq2Sn/T252JnV4M=;
 b=tjkoPaw+whXP8PlMQFqZik/1uDR2A+ycK7C3zr/mEKl9JtbA8MXe1owCJXiF3xS4UKzJMfHbZ/gfrOu0AUlAGoU0nP5bYknMAv5nFF4mrJBXMAkY7x2OALTed8tnxD49oYV8Rq57YN/eCW56za5gwM/ymW6Qlp7fyOyyJ+FX9Ro1twSep6k9d3W4qTLUjbOx3WnqEoU25oj+2tvgqCUyNr+Le1IEMoxdVytW+pKEkkJ3vSWPh89IkQx2VQiqwynxUgsaG6ziSg2wUXVbqGBVPnsbz+OwkWAZrVDtnAPCWELaKXN27+FNUXZ7DOitU2NIuQbZxXF4KkA8WHwdpE8OGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Sat, 5 Apr
 2025 11:01:16 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8583.045; Sat, 5 Apr 2025
 11:01:15 +0000
Message-ID: <0dc1bec4-ed35-4852-a15b-781041d26df9@nvidia.com>
Date: Sat, 5 Apr 2025 07:01:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,04/12] rcutorture: Make torture.sh --do-rt use
 CONFIG_PREEMPT_RT
To: paulmck@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 rcu <rcu@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>
References: <5da8ff7a10670359647fc8135668be7c.joelagnelf@nvidia.com>
 <72693320-1863-4e47-941f-0e887f87a855@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <72693320-1863-4e47-941f-0e887f87a855@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:408:ec::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcc75d0-a9aa-4336-4946-08dd74312f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODUxc2tqcUIwdUxiRTFtYzkxZTRDcUZVVnJhdFZPZ2h4Q2ZadVQ2SUN3QU1H?=
 =?utf-8?B?VkM4NnhsY0F2NEFINmcwejRhMVZZRzVHVXorQkdmeEhSU2F3OWd6Tm1VbC9q?=
 =?utf-8?B?cVhQSXNVYURwV1pZc1gvQVBCQkwwMDVoNEw1aFV5SUJMcFJpVFUzMTNUUVhE?=
 =?utf-8?B?V2g2dlpoS3pRN1h6bk8rR05aaHRpcGkxQ3RjS1hTT3BPVkY4ejdpVnpKVVls?=
 =?utf-8?B?MjRSU1cvRkM5cFZnKzRCWWdLMHRHRlNENE1ud3ptQ2llNFl0WHZ2N2NGRTZ3?=
 =?utf-8?B?VHFOUUpYcmNrT3A4a0N0RzdoSHc0VTJaYzZ0VkwyYjFWd09CdDVGNE9MRHpR?=
 =?utf-8?B?b2NiK09tRE5rNFhOaW1IT2VJYmVlNkRXRXNLZ0hiSVNIWkF2a3Q1b1dCV0hM?=
 =?utf-8?B?aElNVFdtUlFnQXVKWGpaRXAzQTdIaEx5c1k2UWltc0F3OUk1UkM1d3Vvd1F2?=
 =?utf-8?B?MDZlRGNVVmt0TWp4Q21BY0gzUlBhSnE0QmhTVHlNRndoUmZhblFLbldlU0Rs?=
 =?utf-8?B?cHErVkhValdVbHhUYzdsbXdwMzlRWVY3ZEt4ZjVGVFdEQUdJSXdiUmV1ZDB5?=
 =?utf-8?B?N1BMaVh5NGRUdU0vWjdtUEpmcHZ2MUJyMkhaK21YR3VHbU5yWGxSZ1JUbzQw?=
 =?utf-8?B?cnRIRDFPMHZyMExZRUNvb3VXb0lrQ0Q0V2N2dkFjeVBoZERzM21rUnZJNkpD?=
 =?utf-8?B?eStqMkx6UzA5V3Q0Z1hyUDNjOFMvT1l5N2V3UnphN0V4bCs3YzUvd1pFNjEv?=
 =?utf-8?B?TGIzenk5YkcwT0k2RC9GZXhIbXhaTDYzZUo3Wk9HRTBtaExzVEZSVDJCY1U3?=
 =?utf-8?B?cVVIelp6RzhrK2dPU2I1SlFEa3U1bnV1NUVQZ0k5YlRVSStwRWMzZHUrSUpn?=
 =?utf-8?B?eUN3dFk2TnRETTRkUGM0d1ZhZkw2amRRSndkSmJrdlpqYWZUMmRCUVNTRFJQ?=
 =?utf-8?B?bnVtb1NTVFEwdFpwYlBWeTdnUEk4bnBPQzF3YUhpby9iTVNkOEh0aUtrYngx?=
 =?utf-8?B?ZGxMNTcrN0dROXg5OFJRL3ZVYURFV1EwcnZXQWVmalR3VHdydnRNNGdUTllZ?=
 =?utf-8?B?ZDE0TVNrWnA5SkNGb0VmYVVLWGJmaHZTYWlhbVBTYjdCWENNYkdYTTlMdTgv?=
 =?utf-8?B?MFU0Z0o0WnFpWDlEZng1VDdrL21nckZCaEpWU3lHblllbU9sclZ1OFJBUmFi?=
 =?utf-8?B?cjNmS1FWYnBmZHVPcEZFOG81THlGRTJCMTMvenJCWHl1VEVIOE9pOTFzeDZx?=
 =?utf-8?B?Nm4xZzl1T2VEbFMzeEM1dGZhWEt5UTdRS0xXK2d0cVJBS3Q3WU5NaTJXSVZp?=
 =?utf-8?B?TDlpbXZhK3VCaTN5K0RhN1VsbHh6M2ErS2VHOEFoOHFFN0dRK0htU09ab0ow?=
 =?utf-8?B?Zy9EVGhzbStZd1dySm5jeTZrOFFDVE5WZmZmWnNldDRqajZPdWd5RFlpRGd5?=
 =?utf-8?B?aUdZdmtjNU1oT0E2WjdWZG5qZEMxV1dFblU5SjRxbENVQUUzbjdUaytnOXFv?=
 =?utf-8?B?V05sSGdZamJ1a1YvdHVNTUpZS3VWa3grQnBzZU1Ja3NtUDVHMjZ4MlByR29k?=
 =?utf-8?B?cTlSSytJM2tDcDMrMTcxWlUwdGxKSHBKTGdhbG9nQWRkWXJveXFZVzNVWENy?=
 =?utf-8?B?dVJjZW5FQU03bW03N2dLZ05GeDg0eWFWcE5NM3NNL1VzbTN6UW0zZUN3OGhY?=
 =?utf-8?B?UDRoOG0rR3c4bU8rUmJGWnRSb280QzJSNmZxVldGMzhFT09CelhVMDhJWWh0?=
 =?utf-8?B?cWdIdjJBR0JKTDJKZWs0OWtObHRHK1pYUVRQK2VNNnAvLzc0RU9Nb0tWdVhH?=
 =?utf-8?B?ZnRQQWVMU0t6Zlk5T1F0WnlMQ1pxK25FK3dIWm1vSUZKUzZrQWZHTFRrbnJR?=
 =?utf-8?B?eUYrSm9xZFhsY1M2enBjUUVra0o4Q2t6QzJVUDIvTThnc1hFYkZGSXBML0hY?=
 =?utf-8?Q?JnsRImMaGJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjNvNTUzT3g4ZWtpWHovV0QzblZ4cEQ2dnFlUlhiT3FvTURNWGprcTY2NS9Z?=
 =?utf-8?B?L0V0Ly9BQjFOR0dmZ056OWlPQnNxKzJHaTEvVG5ldkxWL0NYTlQ1dFBKSkdC?=
 =?utf-8?B?S081MW4wSWp4UmMyMVovQkNjaFBiNkxWMkt1aXFWb1NMbit1OUt4bU1TZW42?=
 =?utf-8?B?cXJkYW5kMTNCTU9wSlFRL0ptZlcyc00vZEZ5bk5QdnB0amNmZ2k4R3lrVGQr?=
 =?utf-8?B?MjVKeXpkby8zVHI1UkFuV3p1R2YzZEo3VVlZa1ZKMUF1MFBQZnhqMksxMk9V?=
 =?utf-8?B?bmZiVGNHeUE5N1cxUDZTMW9NL0dkZ053Si84dnlXS0JPTWlLTjRudjdTdWx3?=
 =?utf-8?B?Si84elZUK1hPSmpFcW5IdHdJbG1NTnYyQkQ5Qm5RbDBoS09LT2JkNHdza2JG?=
 =?utf-8?B?WDRxOXV2T25UaG1pYUxzYXppbkRIVldXc3J0bmFNMjBWWjJ2VWVVSXA0cGtE?=
 =?utf-8?B?TmdsOTdPOXpyR2N1Y1JuWEgyK1pYNjYzV0pVWjlQbTFYdVpSRnhRS05MSlFL?=
 =?utf-8?B?NFk0U0dYQXYwWDBhM1RPcmNjVTVXTmhyV1ZBd1lnWkpTNXh2S1NjY2NTaXdR?=
 =?utf-8?B?V1FNS0JBbmdlNlh0UWlFb00xa2pWS1AybEZJaURoc1hNdmRIZWhaRjFtYlZq?=
 =?utf-8?B?M2huVGllRzJGN05BYU9OQ2g3UGRFUlpuWTdaZ0hTR2wzWlJLLzhCYkhNcnlt?=
 =?utf-8?B?QTA5MjBFSllMUUxtY3BtME10emlXQXNxOWc5WGRYeDFVT1lYM1V3T0N1dWo1?=
 =?utf-8?B?Q3Vva1pHek4rMFhxUnJMWjJBTWV4bFpDMVlmUXFQNjdnTWVabkJoSWdEblVC?=
 =?utf-8?B?d2J1TmpjbE1Ma2NSV09CQVJFVVIwbzlmdjVxbmdNUmhQQjBOM1NKcSttYmdF?=
 =?utf-8?B?ZXRNNHFVSUNVcUdmZWQyR2Jpd00xZG1YVlFpQWxyblNXZnphdVg2UEZucUR1?=
 =?utf-8?B?dHBuRStoRk5CWTNaeG5XUlFXRUozS2FwRHFLWjNBc0dtNFYrY2JIY1YrWWVP?=
 =?utf-8?B?dW5lL25xbnY3ZHYyVkZScmQvT3l5ZnlkYkdkbVJjcjZQMFk0U2RBTW0vTzVW?=
 =?utf-8?B?V0xVR1RETzNVZUEyWkI1dW5jRjhnQjJmR3k4dzRTTkVjendRMVN5T0tMRzhv?=
 =?utf-8?B?ajRKcHlIMnFST2xYKzh6TFNOSEI5SzJ6aWpEc255QmdQbW05VmdtYmwvdVNC?=
 =?utf-8?B?NTNITDJkaTRLRWtSYUhVajZvdDRIMGRjTHVDOTBUbmtVc25Db1VSdEY3MHhi?=
 =?utf-8?B?amhpVld6RDJSUXNPWkI0YUZuMmpWb1dEZGF5T1M0ZSs0N2RtNXBEMklUbnFT?=
 =?utf-8?B?WGFRZXVhNnVkRmV6Z0tFazVxN1hSMHBSUlpkYXZGNFNIS0ZiTExOanVWUFp6?=
 =?utf-8?B?Tk9ibjVhNTRVcWVsTkNuS29iZ2lIMytvTnY1dVgvNE9oN3BLM0VzaHgzRjMv?=
 =?utf-8?B?NkszOGxEa3p1dEI1TXYyOFZCMEZaVDN1WnM3R0kxZnhDK3p5b05XRmptb2Ro?=
 =?utf-8?B?SjB2VXVPK2EyVHpJV1hZeDhORkJRbjJlMGhvQzVhcHRPTzVtcFZUOHRpVWt5?=
 =?utf-8?B?cVVvOGxjM1NqNStqVGxJRWZJNzhqVUk0Y0ZNRXZmaDJuNGpFNlAxSzdmWWla?=
 =?utf-8?B?bkRPWWJIenRvaXZDMldtZVlpUDl6cWY0Z01JcHFtU1FxYWgxd2xaOEYrZDUr?=
 =?utf-8?B?Y1Q3cFBhRDNuK2dUeUpIRnFmcW84ZUloVFVTMUx5blM0TStORHJzTHpJc3ZK?=
 =?utf-8?B?QW8yZFZKNGhtMWRsaitkcGVKbkZFVTdlRkRjVFc0OWJ4MFc0bzBHaVBkTUF1?=
 =?utf-8?B?OVZ5TTAwZ1lvWi9zeHpJY2ZmOFIwMVVhbG5rNmNUZWpMcXZtZjdRQkxENFhp?=
 =?utf-8?B?NENXKzRZTGloZGQwazVxUWxCZko5cWdZeFl2RTM0cUdsamlDOFVjQjdzM1dn?=
 =?utf-8?B?cVZPNzA5cnBkb3hqSlRnN1RGVW8xa3c0cHFyd2pyUzhOSW9TNHJnRmNVc3kx?=
 =?utf-8?B?S2M1SW1SMksrcE50dGRNQllMVStjbE04cit3VmpiT1dRUVphemxCSE9Ca0Rp?=
 =?utf-8?B?QTdqNGVacmJDSHp1NVZ0a2VNYVVjRFdGZ2tuWU4wcDFxWlZSdkthM2hmelBH?=
 =?utf-8?Q?2oAbWAtvN2QllPAyJ1ahw5U3G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcc75d0-a9aa-4336-4946-08dd74312f6c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 11:01:15.5812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdVxmquR4/1ggGOt/fW4EprDoUVavuY1t/shnKVJ8Ckl9viGvAG7Q4s6niQ7MWU2S7VGlvJHxcZQbyThjsfgMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954



On 4/2/2025 3:17 PM, Paul E. McKenney wrote:
> On Wed, Apr 02, 2025 at 12:19:13PM -0400, Joel Fernandes wrote:
>> Hello,
>>
>> On Wed, 2 Apr 2025 16:17:06 GMT, Sebastian Andrzej Siewior wrote:
>>> On 2025-03-31 14:03:06 [-0700], Paul E. McKenney wrote:
>>>> The torture.sh --do-rt command-line parameter is intended to mimic -rt
>>>> kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
>>>> mimicking more precise.
>>>>
>>>> Note that testing of RCU priority boosting is disabled in favor
>>>> of forward-progress testing of RCU callbacks.  If it turns out to be
>>>> possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
>>>> testing of both, both will be enabled.
>>>
>>> Not sure what you point at here: You can build a PREEMPT_RT kernel and
>>> RCU boosting is enabled by default. You could disable it if needed.
>>
>> Yeah, RCU_BOOST has default y if PREEMPT_RT.
>>
>> Paul, should we be disabling it in the --do-rt script?
> 
> You should have a "rcutorture.test_boost=0" from f2ac55968df2
> ("rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT").
> 
> Plus I just now made additional adjustments based on Sebastian Siewior's
> feedback.  He is likely to have additional feedback, so this is currently
> a "squash!" commit in my tree.
Ok, thanks. If you could repost whenever it is ready to the list, I'll pull it.

Also I'm guessing that checkpatch one does not need any changes, but we've to
add a reminder to revert it in the future.

thanks,

- Joel

