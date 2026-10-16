Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020095.outbound.protection.outlook.com [52.101.191.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5574772B5;
	Fri, 16 Oct 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158080; cv=fail; b=J+BYCBoatPBPXWfH4IbT1S5YGW6ogboUs+PFvzIFCXbUo6N2pxVz09sHxOKa485IOIFiAa6/1Q/ENKxQc2H59tln4NvjXARU2HrXvGPlOUlrF+bu50waW2ITWctt3qI7hfEe7/qgYnK1ltSBPo+K4D0mY9uLbJwp7tpLftlMVcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158080; c=relaxed/simple;
	bh=ijQxGsPrACQfsN6YBHlr57MYjDf0Dij0DkrJJ8oVv10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iTlF9iYpvKeap6PXgC6K2J1RxmpUsK20T3HxJ+d0nnNtru1JdHlYC4Wcox8F9nPedyfMfN8tQuEfxugRIj0ixRLpENRzn9rqzm3AC1Q1cQPCTbTt64ckv39qe3fFykU0VeDXE+AQO3epONaRnF5NPXgOn0ThrRSxIIy64LKVMrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=By/W43Nf; arc=fail smtp.client-ip=52.101.191.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="By/W43Nf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn4Evg0y9GzaX8ie5QW7hHqCD8MGrbH8ORaZb2jpzB5gqBAlTjATay3vU1iPSVlyXeyGtumeah6jFoqzSOTkI+J7jiSp+EcKG5Z3RkMGEp9ZTfN8AA6glb5xu4CDvmWzOUS8Brs0T67TDq7lVHGZCtoIM35eR5RXLVhOV/orC3pdSRTnsD0EUyRiIzSRtJlpUZPPmLjTd9Jb49oJnBFLV8AYrp3BIIQzE2IpuT8YLADQuitjDAyhQbt+EdJZvMU366E35xNPC/BcTHBNT1h7sCQ4rTBKgt8V6Ar+RLLgk7JpujzbIrFVG73KzxJvS3MFh8oL5HfU2/ILLoBGsuqHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZnpV/AzgHKJs/WYqyPdZ5vwfr/gzKAodv7dHlnJhsQ=;
 b=iBhekoU4j+DAR6gKId0eZ4t/e2sRHKn6XPSwaTtZuOxpJfc107mypTfTzPrIvTmkE6c1BSuDN+2JxpPFOM5hmH1I+fNpAnIGUph8tVqFSQc17lpiq2zV5fR1TZPlm6NCjkXmWeEUaL05WQsv/vRPcfarYQti3tQWXqWHQZmE0HDuOWn00Nn9rnLmiau3rou5HWyl02xgCTsFcJn16gADsEQpgs9bQN08QnSBA+MniWd107M3cxGh7kjFV/sPdhnxA6P9rHvJiq2G3AmRaajMQPaia5DnJSKgks/fOBNe+8xljB0TCnsuPEn+n65qKdyhFj+nc9xt901hleXMBewPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZnpV/AzgHKJs/WYqyPdZ5vwfr/gzKAodv7dHlnJhsQ=;
 b=By/W43NfRnN++aCJkBKsoNR0uKFLplFdfSwDAb2dcrwY3DgBt+UBajTofep39kMGc4ogKgd1msNlT79jGwFhjiounr+XUqRPpQnRw3frb/c05gg9F7cpYnnLD6/XWHgFQ5+Nm4kGb9eb5KgQ0mugA8XSxD2sKQsY4x3LKMGqyHrY7NHyt4VK+NC2tGPTDGbDj/vgQb3hJzEKu6xJkTD86XVZKNVBSUn0r0WE4NvCPtNb4s9NwN6sFzoNW6QJEXL92C+my6721MpMhy6wMFVX4Fa74KtMDxT9vLM9tLtis7kA2Z139FPMLg3gPPtp4VD6kTovp4b0Jfg89RCNFcwImQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB205979.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1c7::14) by YT4PR01MB10689.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:105::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 13:41:14 +0000
Received: from YT3PR01MB205979.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c44:538a:b098:c192]) by YT3PR01MB205979.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c44:538a:b098:c192%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 13:41:13 +0000
Message-ID: <c38a5c3d-ad8b-4cb4-8ef3-a9602a1f3c38@efficios.com>
Date: Fri, 16 Oct 2026 09:41:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hazptr v3 1/4] hazptr: Fix two-phase hazptr_synchronize
 race with detach
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Bradley Morgan <brads@mainlining.org>,
 Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, lkmm@lists.linux.dev,
 Lian Wang <lianux.mm@gmail.com>
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com>
 <20261011194902.97364-2-mathieu.desnoyers@efficios.com>
 <CAN_Opa-zH=+By+Qrsrg3W0prQPNv17xCCh_n0CzfimUB9__obA@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAN_Opa-zH=+By+Qrsrg3W0prQPNv17xCCh_n0CzfimUB9__obA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::27) To YT3PR01MB205979.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1c7::14)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB205979:EE_|YT4PR01MB10689:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ce3fff-cc4d-4143-526b-08df2b8b2547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|10070799003|366016|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/HF89tSRDQiVECSwBHCAbgojoKYohzmXymcw5r7yAyded46AKSxL3kOnuheG6XGQJbBt6BpY8ynM6hH4xsftHDwt+wOfAtP1EBPR9gB3GcnK2QzL8EE+mhkwjIZf23+ftVNPx6tN+K7HAaueN5aEhN2Mvk3CFIHvl1xC6LyqyBrSqdag+JemaDeAkPL4+yI9K1X+agAWm904/hclCQq+o4AxebeQhYL9pPv872FqpRYsiC8pGyXVIBo8//wForcXkj3tZ991yf01L7y4URMOynjZO3FZrZoGWfuujcv75Bv6Yt+K3CDarySv46uJ9h1fJSIS2U11VvzIjPRzwA768E0ajDsuaDH+K2hbgMq2lc2yUDpaLiZ1Uno7CkiFqTD4VQ5aBVNlk4FnZvTA7XmoOKnhADWQnOLJKkJJJYeRRrEc7G3JPRz+qciAQDMvCqkAt0Pp2XcMuJCv44GhiuJsieVwkc/4Qc87d0JtS1lk38yt+IG8QcQ3PU/pq4SUJM324nAJIAW/VIklDpbnouDoYvtMmwjPLMPhmlmO/KX7J/Gs+f66LXHhKoGJSzxa1KDbNOkX9fyyl+BqJ22sVcxKGPpCFct1RPHLfVNLgoc7jSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB205979.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(366016)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bysrWStmeWFIYkFuK05tQmVtdUF4ZTJpUXdoOVFGdnhEL3RvdW1aL2RuRXBw?=
 =?utf-8?B?VDA5Y0NTbzRDM2NEQllMNE5VVExCdVlZLzVUVGc3NUthWnlHN1haRTFEYVpK?=
 =?utf-8?B?MjdKUTlhcTd3U1NUbGpJbzVISVNvRGRGQzl6VitNb3h0aWxsaU96M2E3NDdT?=
 =?utf-8?B?bTlJZW5MQkhnWERTa2U1R3NQLzExN2s4VEErK1V4eUF5QTNtNFpWSVRiUWdp?=
 =?utf-8?B?Y0lXVkt6UEVKVnZVS2hJSDh1dWFoZldTQnQzbkthMUhQTExDNWJDNjNTM1Zu?=
 =?utf-8?B?eXZXeWxuUFF6ZDl6TEZaaVpoL3h1dGRXZEFnMXVqRDlNeDMwWVphUHN2Zm1L?=
 =?utf-8?B?VGozQk1ydHRwM2o1S2xoaGx0UncwYmV4OHBmNmZncjFmb2poSS9KM1ZoYWMz?=
 =?utf-8?B?RHJ6azc0UVhFMElSUFYzNjcwQXl2RFkrNzdZeWFhcHcxZWVVbUJ5bVlObDBo?=
 =?utf-8?B?d0xGU05oTmZIR3F5OFNWSXQrTkVqYVJGaTJqVTVnTkRHWEhoRUJyWllvcmRK?=
 =?utf-8?B?N0lvVk9jckg1NytBR3BIcnJucWtyZmxpSG9xK1JXM0didEJ0RzI2NHhYRVpC?=
 =?utf-8?B?RjVCQzRYRFBneElPZ1NXTnYyNHUwU3UyalRCcDI2b0NIUWg5eFM1WXJ2L0di?=
 =?utf-8?B?czBvTDF5aVpJTTdHRFJ5dUVsbWtLOWFjK05UU2hvcTNhUktyTWRRQVJXRGJI?=
 =?utf-8?B?RzFtYUxvOEk5bXdSUUgySThkOFU0VXZ4S3M4U29xM002OHM5UG96YzE4MVJ6?=
 =?utf-8?B?SW9Xc21Nc2V5TjFRQlEySUNnZVdHcWVYSWorTHF2dnpsU3ZGZnlCcnROOWRB?=
 =?utf-8?B?dEMyVU1yVXFvbzhFVWhuTkx3Y05QUmIzRzJ1Ky85NnVqNGwrdUN1OFFxTUFP?=
 =?utf-8?B?YmZYcU1CRCtUY1FNVFNzWmVuWGZOSHR2ZE1rSGIvWmttbUlQS1lRNHZEbGg5?=
 =?utf-8?B?cmNtT3d3NGgzNnpNYU5Hc1BzdFg1blYzNUxPdWJSdDFsc2swSEUrL01ZYjJh?=
 =?utf-8?B?eSsybXB5YVgvR1hpU3UrMENzT1JPSjNGaytyMEhQKzNEWFdISk45akRibXhL?=
 =?utf-8?B?OHJjYnpJVzhIRkNDd0p2SkJ5SzBqMXQxZWtDY0lRM1dqVjdWWjlzU05zUXdF?=
 =?utf-8?B?eXRmMVdOVm9TZ08zOFZXNTMxZHllVzM4UXFNTWRIekh2dnVveHFyeGJQMUJT?=
 =?utf-8?B?M01EOExkbkwxSG9QREU2NGZpT3VHZGVCTFRtVm9zUk5QYitkWSs2ZUg1Skd2?=
 =?utf-8?B?ZlJiRTROZnhpM2NKS2U1Z1Z2Ty9vczI5aC90Rk9uTGRNY3E0VnlDNzJtZ3l3?=
 =?utf-8?B?c2RZOXk2bkRpdGhHVzVWOXQ0SitTNW1TSUpwc3FCc2loV1lDVmdnZmJXWmIr?=
 =?utf-8?B?VGFYRnFPbmZRVlNPUUhXREpXTzhKbmtIUlhEenFaZ1RZcHRjLzR1L2VNK3RQ?=
 =?utf-8?B?eWhGK1hkZFNWMXhUTHdDT0NVWWJsZy9hUVhBaFBsTTJ4alN0UFhvdDBEVlRE?=
 =?utf-8?B?OHpic083cll2MnBGREtaQnIrV1NqcWZodllsYlBHN1NMN2hrQ2VZWFQ4N2tT?=
 =?utf-8?B?bUlyQWR4Y2dUVWdsUkJnZmErcFVNMWR5UGVQUXlZTzYwSkdWZEx4ZHp2aG51?=
 =?utf-8?B?VE0wOEZiRVdYRythZHMwWkltS003QXEzQVQxODZHSWttUnMvRHlHMDdmRm5E?=
 =?utf-8?B?SFRCTmdQcTR0OSt2WURqWTY3TFZpcjJjd0FtL0F2KzJrMGNLaUlnS2g1aGJy?=
 =?utf-8?B?Q1VncW44bUJoVHNYdHlLM053ZnBWcCtFVWZscnl1ZXBicVhQYUVuZURjUFU1?=
 =?utf-8?B?b21xQmV2MFVuQ1o5ajhSemxncGVhKzdoUURrcTZ6OUJnSlBFVUhORlNYYVJD?=
 =?utf-8?B?S0V1MVcwOUdDU3BIN2d5RlFIazhKYlpGa2J5NVd2NlAwcUNlYWRuL1hybm1I?=
 =?utf-8?B?ajBNNmlFL1Q2NXNzSWIyamcrc0EvTnNoTWVNZW1pREpZNzVoZ2NpaUFYNlNE?=
 =?utf-8?B?WDZKYm9qREZMYjJqSk1mSHVtMzBNbUU5cVNrRFA1NTJ3WmZQUU9hUU12Tjdl?=
 =?utf-8?B?NGtqdHBxM0Z2b2pURnpOdXoyMFhaZHV6OVk5eXFSY09GU2hHYVMrSVk5UmNz?=
 =?utf-8?B?dytQODBOQjRqZlpwb0dMOGRPV1FhZDBZZ0tTSFJZUHptNTJyTDhWR2ZYcGZl?=
 =?utf-8?B?dithZEthaXhBZXQ4bXM0UDNMUGdRbjBkR2orangzdUYxWVZMWkZOMHlpUG1k?=
 =?utf-8?B?d0plZFc3UkdSMWEvQzZocnVxYmlVY2FYalJqV3FSTWlUbFNhUG80RnMxZUoz?=
 =?utf-8?B?WDJoZjFodHlJRi9zYUhEMGR2c2JhNHZEbjMyTjRWVjk2cFlGT1BMTXkzZGsr?=
 =?utf-8?Q?ZZDNRfLO0HdczKedssdtLqSRNEqxCWTkx2qPcUzluziNB?=
X-MS-Exchange-AntiSpam-MessageData-1: GrqaW791pIL2qIjMvkm/fS9Sa0CemRuB7OA=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ce3fff-cc4d-4143-526b-08df2b8b2547
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB205979.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:41:13.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTG4kzkIotu2SiqO2zY1vIdNv1sBsINBYa07R3dxyZOKQPSllc35Zhvf/E2Q0ZMZ+7PQxGtBRtUKkOg9gmzARg4yfaS0yd2n8K4eTeUp5rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10689

On 2026-10-16 04:24, KunWu Chan wrote:
> Hi Mathieu,
> 
> Scanning all per-CPU slots before the overflow lists
> addresses the race where a backup slot can be moved to
> a list that has already been scanned.
> 
> Using a separate overflow-list phase also decouples list
> selection from the wildcard phase.
> 
> 
> Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

Thanks for the reviews ! I've picked them up in my own local
branches, but it would be best if Paul can add those 3 review
tags into the commits he recently picked up.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
