Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC93E1221;
	Sat, 18 Jul 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395059; cv=fail; b=gc6c3wZESmZjFA/14WiizPv/08A0z4/5MILRy53y+rmFR3jH7BrgHa0M+prYM1DLfuWBrz16YG6TWvWF1JGTURVWYlK1oEZ2vw8B0XGEqeqVM6o+A22bssMmpRjNHr6UV8Lfk4rnQ4KFtJg2SvXcPiHNPhDUdojyl3JjCmf6Gw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395059; c=relaxed/simple;
	bh=C8TRJTpbhI6OSOyNqLfpruddOZrp2nQqphSAsQhPWl8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U738gkX8EdcyJxcPSy5872j5zTMYe4t7OEzHNblRE6VBDokYkvlAwDnA1+91wXtPzbz08VdonBMWbLGGuYVPLo9Vx/f2A8jz9h9ziLeGS8IKmI7nvwQ6IuZnj4ewfR7Hj2bWbjlNnY2EA/uBWmiItlzM8goElcOc92PUYOjA4YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWRjhfqm; arc=fail smtp.client-ip=52.101.57.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWRjhfqm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0mgAu81C8vzgrsIVs4OL9/L0j4ylK7wbNMgURGJEzOIvOwIsqDnsGLHcshHzJA7j1S+Hc/Lm9VxJjVIFuMN0uKMS8CYOt1OIGaUzDQWOTtMEgvoPvlNxEngXZ7eYAaJAiAWbzC4B8RZNgI5H+Lf8WrKDPQhNUv6VtphoegrYuLaP29m3rk4aZgkRsygEjwNIQDMSOeQzV5BXVBXo2BUhKQLRrmnPR7uS8LJfGKiacOIjLObB4OJRFs9QfRk3aZQNdhRdo1uVTGxrO5rOlfCKU9pQI2/czxeWh8RLTo4BJGESrxt8O4PxRLk04pjOi/bV4gYuEy5CZBvjHPy/QDkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQ06pryjQjwvzgkGX8wp2Cto+r7226/u3Dz4OLT2nUk=;
 b=mm1VPta4Lk8FbK1BBYaQxHablAcsy/syDxsv0MQbmuu4zXhAKr04u7Zc6P0M2HvuRaiUdda88HTztpGneVSLbxTYzMIgrDV48GwBt8cmi0P9lNe04TD3Lji0yAsUI85ut1G5STTHaTHXY//uluSufyfQesf9JzXoMWGHlvhnfi2MpqWL8cnj2S4MTVyy4kkltT3XLL4xlfvPKjuLqJkTE6mMyA7psegj24vtrRLobEpEqpLqCr7FXhYnlud//pERN2nUzWqSlQHopIu+0DKUSXnnF9Z6D0E3XmsQz0svpmtG2Cl1rn0uNJQOdQoTIoYhlpEoIjsXBTxeez0//ekN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQ06pryjQjwvzgkGX8wp2Cto+r7226/u3Dz4OLT2nUk=;
 b=kWRjhfqmAF3lSFcYu35TNYvStu/uRzCqtPUunycxnk6rW/uHomsEuXnf9HU88BBs1ThSw/8mt7ypYcx+/vWySBCgm90E4Lu5pYy2hIs9LN0bhHyHF8vcnRSZtnOpPo7pS/w5VjDzbxkG5hd9RxJluWS+1RW4rxSbfZG9eo37lFQSuIc+3lG4s8X+JzV4AvjOlgaS7NXqk4weHaadRnta6Dw1UiVi2tttw5fnel9W7l0PyoPsabGi4x7qhF9Hh3r9BzrjKjWrVXzVBUEVwfwP1U7Zbif2Zld2mn1tVlad3zGcI9Yqzu16tQqrrM8rPnFBGG77td6G43trjYfR84CMFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.13; Sat, 18 Jul 2026 17:17:33 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 17:17:33 +0000
Message-ID: <e1d02f43-2e3b-4e27-993a-ed2cd1672356@nvidia.com>
Date: Sat, 18 Jul 2026 13:17:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] scftorture: Count single_rpc offline failures in
 statistics output
To: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 RCU <rcu@vger.kernel.org>
References: <20260718171539.3781595-1-joelagnelf@nvidia.com>
 <20260718171539.3781595-6-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260718171539.3781595-6-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 66179f48-49b4-4310-760e-08dee4f071b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|4143699003|10067099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	eIK5plpX8q0iBrVhz7YcrZa1rubtNOlQVhKn4obVe3mH/EV2ok8fhSbVQI3md0W7zu4ByG40qBnAGr8myMGKD6OnIv4p4A6eaa+l5tc+eSeCOiqNgE2LsY27g8vG+g9xV4dSpCUHhVS59XkBiCkVFie8DJR4NG3gGyfQrwSFoyYRFL5x0qUToW7BKocbGIHx3WkUqoH7yUotWT/kVg+bp0nVZRc6nuzg6HLbt7BS1krFOL/s64kCYwGCusY7dVMaopBz19EhJURBjDHdHC1mYFQPy6lxgFcjGRxp76n9SMg5qv+Z3AMXNDEE4oUX6x+JO1V7X/tBQvGCb5fDws95TXc37x+hmS2QbNvZxeXHFltz078bRQEx2qM8TH8d0+H8bL5pIpA+et1u9PEfglwXS8gyQNPAGWWTxzeRegBn2hbIZ0HQTgTTCKMgieTpOPqjXh8eQvsubqfW0hYzMg2GsuLJ+m2aGfPYcEv0B+M3nEGXXah6JUnDUKmWW7f9Add6jnjACv9c1Gtit9faddhxzzYCKIYgm+7qTttsdvqkc5jIx79M4RnGWkcCJDA/vZJCfZmo/sQjiKwyj0a9ZrqbfTOgwrrKfdw13oeEV2Y0umOQCEzxoaHcTh8t7om5TG2syRfHGHDxxGjXvqxfDB3iRfEl6KPD/+HUL7jJCyo41so=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlZxSC96aTRNZ2tnUGlHMEdiZ1JaYWtiTmQ1NnhTUGZ1RmZvdDVUL3g3cDVo?=
 =?utf-8?B?Z0tha1IxQ1BVYklmSi9EYnFLcTJub1JTVGpVbWZLc2dad1o2NzlxeURtR0pQ?=
 =?utf-8?B?OHZMUVpHWGJwUDZ4UUR1MkpIY2VIMmZHWHp0TmRNYVZYeHJpV2tpWWZ2dEZL?=
 =?utf-8?B?TWdoYTZId0VBTDViRHg1dzNjTGxBb1hyL09aQlAvQnJDQ1QwTk5QREJwMUND?=
 =?utf-8?B?ZFZYenN4YWhVOWtzZFY5TTRJbkRWU2Q0eWx0ZWRaMlhCRi9LNzkrTkcvLzFM?=
 =?utf-8?B?MThKeE9mZU9DZ00yYTVxZmRQWWRvQ1Q4S0RhVlJoTHlxZGFaRFlzS1ZJVkMz?=
 =?utf-8?B?YTdWVXMxUWw3NnNva2VKTW43eXNBQzBmZWZuaHdkODg1c04yUXI3VTlxUGl3?=
 =?utf-8?B?VHFQUjFERHNHUVh3WlJmOVAzQ005MGM1Q0daMjN1LzN4Mkp2QjNoY0M3RThp?=
 =?utf-8?B?UXNsWEhlNTdMMUNRVXRSMzNlQXVmeFp2S0hJNE5qRVltZVRIQm9kMHd4bENK?=
 =?utf-8?B?TlVnUnRCQkw5RVF5NWU3K0syRnZRM21mWE56NDBSWnU1czFnRUo1WnN2aEJj?=
 =?utf-8?B?c1JlcUpOT1lRZXhmRFhISDRVTlJNMFg2UjZjdXo4MHROeWJEUmpPT3pZZzBY?=
 =?utf-8?B?QWxsUTdVZHNRbWlLbVBKZUJMOXh3Y0R0Y1ozSjY4STFBREpMUzNlTHViOUVI?=
 =?utf-8?B?UkFnSkVORG9zNXpjUDgxYlp4aWxUY2lxNFV2UisxWHdVV3lLV0piQkNvM3hS?=
 =?utf-8?B?bTFTRUdUalZKb0Y2czhnUElvZko1ZzhQaGZUM1dMR2xtMUI1Tlo2TkNtOWQ1?=
 =?utf-8?B?MlVzZzZMa2Q0UE1PdGpjemlrTTFKY3RoTkx3U0NEMnJCQjlqOHpYZXo0R0U4?=
 =?utf-8?B?WDlvMHBXcmpibWxXdTJsT2xxcTQ1NzRHYi90Tlh0TTFCdFlWYjh1NFhTT0hp?=
 =?utf-8?B?NmloTVcxeVZ2VmRUQVRUZXpQbFFBU3lXNGZReXVXRG52VE1HbkNid2hXaEVa?=
 =?utf-8?B?VFZmaThIdktsM01rSm1yd0p4MFJIWEltTkpkbDk3WGpaWkRTd1F3Rmg3VS9a?=
 =?utf-8?B?aFFZSHp0QnBReC9QRmVTMlZhbUIrVWdSTDhmc3N4aGRNelUvWVgrSy9TWEVO?=
 =?utf-8?B?azI0REM2S200NXQxcklhcjFQM3QxTmpEd0VEdlNFYVZxSkhDK1JlT0dkN1Z3?=
 =?utf-8?B?czNJSkxRK2QvZ3ZBMTJqZU4rcGxRalZCRGYwV2IrNjE3ZktBM3RsRlFhelZC?=
 =?utf-8?B?d3FGTEx1d0lVOG01ZW85RU9tLzNCcDg1UXJSNnVGNDZXazk3ci9NTjRHNnVK?=
 =?utf-8?B?cVhydzV1aVoyeVhUeUZsNnVFNEp5dUlITmo2NEtXU05xWmdWaEtBYnJoVWRP?=
 =?utf-8?B?SXdSTHRITUpGQkRzWlBaQkczSWRhNHFpcWMrODRyRWIzaGJyVEdPVjkvellw?=
 =?utf-8?B?RnFmVnpHOHBoYjJDU1ZKMkxrK3RZOE80Ry9KdnJnYzlUUkEwZEFPV01MK2tT?=
 =?utf-8?B?VnRjTEJyeENoZU9mVWd6bWFYQUlwMXNzMmhrMnNuQVI1YTVVZmFvZ3R3UmRp?=
 =?utf-8?B?MThjeUVSaGFVMldzMXVsUFdRUFpWcTI0T3VjU1VvT0hQWTYvNjlvU2VPTVp0?=
 =?utf-8?B?NnZWSm5Ga1I1U3J4TC9nSTZwQ0s5M0MxMmtpWFFpVVBhYjk1WU9OUEtzWWhH?=
 =?utf-8?B?T2VESlhPK0I5RlBjbVpQVHVoM3B3ejc2bjA3WFZHSVF0NDVNdnBtc29pdWY5?=
 =?utf-8?B?Zm1HU3ZsQXNuT0VIZ3NMVHZPcXAvMkpEWEtmOGpuajg2RlVnWUQ1UGhWeTJs?=
 =?utf-8?B?cytIQTFNS2tEcjViUUhwR1Z2L2Y2VlM4czZEcXlFcGJ6azUwVmhTUjZRYWRo?=
 =?utf-8?B?cVVvQUhsSCtxV1FQZjdQbTdlMkVlMVdmRjY2dEx0S2gvOWowK0dhSmppUE1Q?=
 =?utf-8?B?T0xEZG1uTll6QlltY1IwcGtJR0dGeEUrbWtOUUpGMHJmaGkrVkwzamI2NGo3?=
 =?utf-8?B?YS9NRi85V1M1TXAwY2kzenlKaHpkWkl5N2lGM0N5QnVndC9RL2FrNHg4aXpx?=
 =?utf-8?B?QjFYd1Z3cFFzRTF1dzJ6NDFQcUQ1cmdvUU0xcEkweGlsRktjNW41dnJITHZU?=
 =?utf-8?B?K0JETitmdmRrc2NaN1lmdzNXR1Ywb2pVSkxzREwyTUZtMEw3NDBST1lNODV6?=
 =?utf-8?B?VEpoVDliN24wOTRXTVR2cDBQbFRDc2dHcGRQQ3hPZWtzVGJmS05YR0FnNUF5?=
 =?utf-8?B?b0t0LzlDOVhPVkV0ZFRWK3l6bzIzeDI1R2lNWFcwZ2JySnZQelRtNVZiMXVr?=
 =?utf-8?B?SkpVRFlNMCt5SDlkMExVS3hnK0xOWWxycFo3UWZXWXlqNUFlMy9aUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66179f48-49b4-4310-760e-08dee4f071b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 17:17:32.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDLGwF5pfA0T6jOtL1WGXtdAlOvQunEbG83pH0gdErUORruXaEz7TKRmdRhVVr94ZQiwZPP7Dk1Dr4yWHVdxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

Some reason my scripting missed rcu list for these last 2 patches. But they
are on the lkml list :) sorry.

Adding back rcu@.

On 7/18/2026 1:15 PM, Joel Fernandes wrote:
> scf_torture_stats_print() aggregates each invoker thread's counters
> into a local scf_statistics structure before printing, but the
> n_single_rpc_ofl field is missing from the aggregation loop.  As a
> result, the "single_rpc_ofl" value printed in the statistics line is
> always zero, even when smp_call_function_single() invocations for the
> RPC test have failed due to offline CPUs and been counted by the
> invoker threads.
> 
> Add the missing accumulation so that the printed value reflects the
> actual counts.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/scftorture.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index 327c315f411c..ffd6c83732ee 100644
> --- a/kernel/scftorture.c
> +++ b/kernel/scftorture.c
> @@ -193,6 +193,7 @@ static void scf_torture_stats_print(void)
>  		scfs.n_single += scf_stats_p[i].n_single;
>  		scfs.n_single_ofl += scf_stats_p[i].n_single_ofl;
>  		scfs.n_single_rpc += scf_stats_p[i].n_single_rpc;
> +		scfs.n_single_rpc_ofl += scf_stats_p[i].n_single_rpc_ofl;
>  		scfs.n_single_wait += scf_stats_p[i].n_single_wait;
>  		scfs.n_single_wait_ofl += scf_stats_p[i].n_single_wait_ofl;
>  		scfs.n_many += scf_stats_p[i].n_many;

