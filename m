Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F62943F;
	Wed,  9 Oct 2024 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440670; cv=fail; b=FHYwAMv6t+4e5O4Avitcj3xJfjRGqk6ccGNgfRSeuf/pDZX0ndcLT7JhRf9GIprUhNXeVG80Y0RZ99g0i7R68Acst3gXkkr1yg9BImOGycEIroJUbbt2pn/qIHbzxTHV3j4d09uyz2+do7aEsVGMr1wTVvVal7r4wYJLCul771s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440670; c=relaxed/simple;
	bh=wGhgJTfp7gt1KwXlh/QRtJ9ciBBHraY+qZ3gYlj6We0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nl4W64g8MNlfm+0sDhV/4Z4TCtbLBIJxv4QctaFYPidcrV75Z0VnRRb6d7JsWRtuOB8kCufWXWVzwlnowJXLamQjOvMhEj002Lhg2/UM0Jjt9f9WMoHLny1WFcmlCj79+gIP1oAE7Ul+tmnDlcHtwFjTjlshQxFuUgWgCoSTOlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VzONEMRB; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VzONEMRB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGr6Qc/seu6M8rKPtmN3UXcl+XD5c35Ea+Lnc8+EG3hOwHiv516ivhK/2eIxe2NS6PP1i0KU9PYZKB0H4cqCAUd7L4SGGPh7ITifVn53+M6zB7BNxnT5MyMAOgFmcDcbfPMLWVdbP8/1/uF7I+qdiny+h4mSVLNnTQV+YBm5xRKFvhr6ASEdi72VGq0YebvOP2dDZk3skD/NhQrvrfyMOrH0Cn1qjwjZ9hLevIYL6LMCBdg+zbP/TNjG2hqc7AY6F8UOqdJiVZOSRopj8eEa7mxuQt50b3MQrSdWgNuRwMLXGFEuustQi3UZMIl3XtF8YIWZtgJ9PIblfuB3P77v9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI7lRIFQNSCjb9CX5YO8yj8ogYLacJWVAMc9PNAuUmc=;
 b=PUz3AtqbgjUug4MFpCzmeEcF3SJNZG2w4HQU8kQKJSflyXZqvXKopa/+Q7iuUDyTT1toUbFNWlliQ/a6GdVEyx5eNWMQqjUWpBUbIwVNvOkLTtxvLXbbaPpOhgz9yCCvIlhslfScXXHzRqzoOosiB1XgLvvMNe0AuoJ940IzzH7xeWjxhPOX7PS3KoeeXw6XLg49KjOyQ35fY0JbFKF4q9vDU1YEr2+60bwtpw7UfCW9E3YQs5VC9a8r3GmMivtO1/X45IZUygluXRwHzqA9kvzcEsxb3XY/cjA/qNbrjclhCqZIW3GxgTAxkYFl+OnwE8muCmfF+4KZlH6x2islFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI7lRIFQNSCjb9CX5YO8yj8ogYLacJWVAMc9PNAuUmc=;
 b=VzONEMRB8BG9Iul1pcNmuqcZLR1kpSs7YH8of633vlqnphJDFNXce7JIrylnEK2s5kBBHUshOGZUpIwOEfZm0JVG/9GsKGvsjOGZZG8Wi2VEGB/NJvOdN3kWTr2NCqZgZroiHZlLCJIqggeGwdCYF2ZbmFeRldbzrfYXOFyVcNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 9 Oct 2024 02:24:24 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 02:24:24 +0000
Message-ID: <a48ec24f-fe53-4a62-9397-e42a23fc3a2d@amd.com>
Date: Wed, 9 Oct 2024 07:54:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rcu: Report callbacks enqueued on offline CPU blind
 spot
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, "Paul E . McKenney" <paulmck@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20241002145738.38226-1-frederic@kernel.org>
 <20241002145738.38226-4-frederic@kernel.org>
 <Zv1f8-1tLd-r1cyu@localhost.localdomain>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <Zv1f8-1tLd-r1cyu@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::23) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0ce58a-0ae7-4095-706a-08dce8097d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG9kaVNKL2FHbW9MNjhibUlsa0J0WWVhdHBSc005ZCtTSUV3T0pvTmdwWmN3?=
 =?utf-8?B?eWhRZXVxeVZtUlFNTjFRSjEzcEMza1RTK2psR2xFdVJ1dkpzaGt6VmRjRTVs?=
 =?utf-8?B?VVlZQ0dtcGVuWHFna0hjMk5UV0FVZGU0bVJYdFdBa3RXa2ltKzNxTHRIeHZo?=
 =?utf-8?B?eE1JbkdFbjJJRTR6bjdqbm53ZWh4dkl6Tnk0anJUbTh6UUV3eVN6VkwvR2pC?=
 =?utf-8?B?YkxLbGJCNEk1MDF3VndocHUzRUhTRUl3MFNiSTBHZFZMMktFQU5VUmhKelpE?=
 =?utf-8?B?enV6cC9GTjNyZmpQTnl2OXlKdDFrUGxPaVh5dHZ6SC9mczFjRmNiekY4VThZ?=
 =?utf-8?B?SExDclRZZTBsNTYwTXZ2SkdQYmlSdElsenV4b3NVdXZYeURTekNZUXhXalhu?=
 =?utf-8?B?WGExOTBkdEF5cUk0enowWXEzUkF0V1JjYTYzSmNmejRTNDRXVk9CSlIyOXZM?=
 =?utf-8?B?OExiMHgwUjJGV1JuaHNlNUtyN3E0VitFTERWNnRjSExtUjN1alBoRHJab2x1?=
 =?utf-8?B?M2VxK20xYWFhNVhQNnA1eGVBbjNkOCtTSktDUkN5bDZoRVlsZUZwK0RMZ0Nx?=
 =?utf-8?B?aUtjOG8xckZGZUdBVnArOEI2czJONm5DVFhiZzZoS2hzZGQzd21DeVlVS2ZU?=
 =?utf-8?B?WklYWE10eTZ0WUlpTFNiTkVndFkzRzRObEdpZGVvaDBqcGE2ajVKQTIxQTVJ?=
 =?utf-8?B?Z0J0VEtpdTZwcDdhVi85ekZrOGYzb3FWR3M2TG1tUDJacGxKSUY0bkZOdm1Q?=
 =?utf-8?B?blBKSE9tLzh6ODlaWVJBUllHV2E1dmJPSy9LU1NheHg3L3A5RnVtK2dVZnFO?=
 =?utf-8?B?bUJOTklOQlpLZ3RYdG1YcVhCWkZJMFkyZEtaamZTMGZUWmFzWXZadkhsVmFI?=
 =?utf-8?B?TzNuOUhrZ1htZkF0RVEzN0QveFhrRktueW1nR01Bdmd3a1ordmRmb1dIR0Z5?=
 =?utf-8?B?bC9hZmYza3FSVDBQVXZramF1QUVlREhQclNBVGlabEFVUUlnbjk3eWQwUlJK?=
 =?utf-8?B?TWozMmw3TUpqRCtPMndDNk1HUk5zTFd3ZlJKSnBFY1pWNDlRQUpuRkszcGk0?=
 =?utf-8?B?ZENWcWFGc0hQQnVRVk5XMHBPUjIvd1pJakVaRlhZWk1NOXE4V3pvTk52Mm8w?=
 =?utf-8?B?bUI0SFFXN1N4Z2FPU0ljUld1UHY5TEQza2F0RHF4RnBPYW5DWEJncElCZUtM?=
 =?utf-8?B?dFNMOTYxditNQnM0QmdHTTZyMnlsUVQ2dHdGVnlIbFZoMEJjM0hScEt2OEZJ?=
 =?utf-8?B?QTF4UU91SWh0SWIwZEZUZE1jWmhJVVdzcDVtOWRaNllDb0RGcm1jNndzZE12?=
 =?utf-8?B?czcxZ3ZmV083Ykh0SHpuQTU5WUdwamlXVkViZlVRVDhVYjR3MjE0MHMzK2xs?=
 =?utf-8?B?Y2dLK0hOTmFKNXNJSE1lWWR5cUlYMkJVOHRjdkVZU0xSQTJWcDBaUXpKdHJQ?=
 =?utf-8?B?Vjcyck5IRVNCUnhENUpaaXNGeG1QckZlUEdSVGpub0l4a29DYm5wb2NFNjY2?=
 =?utf-8?B?SXZrazJHeFB0dmVDWDRGV1hWMS81cndIdFlKVzRXOUZCTnNPSk8xWG1ocmEz?=
 =?utf-8?B?N0k0enA2SndaaHI3UGJZRklGbDlBMWZyd25oa2tpUmhGS1VOR2hFTktsOERj?=
 =?utf-8?B?Y0tzRFloRHVqcVpSR2p4OHpyVXo2WksyeU5nNERMWnlrV1dBZlNHeUdORzM4?=
 =?utf-8?B?WnNFRFdGc1pBTEVMNTk3bDY0UktFOEdPU3BiSmRJZTVYZDZ3amlDQ0tnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zkx4Rzl1WVhyTWZDTGZYTnhKa05Xa1I1N3E1NXNHT21qcHM4QTJYYWRvZVhz?=
 =?utf-8?B?MmtwN2JYamVuQXA1QVQwVnJCb0RiZVBncnlCT2wyNHJxWU4vb2dSdXFMdWVt?=
 =?utf-8?B?aTlyWi8xNFNGWTZpQ3dSZHdYckxyZFZQdDFKYndwajFpcEhFVExOKzZBbU5u?=
 =?utf-8?B?Q3lPazViMWVyTEcwdk42LzJQT1dSMWpKbkVLdVBiM1dyZHplbkhJbkUzRjdz?=
 =?utf-8?B?TW93aUVlYTdXRkZFWmhyRmpDbm9uWlpuOUU3SGg4Mi9BeDNTWXZzMEt1Uk9W?=
 =?utf-8?B?NDJmdkRFZlNmejRwVExOazc3SDArc2FQaFh3Q2ZsTjFjdTFNMk5TU2ljRUNj?=
 =?utf-8?B?VWRBQjRKMHFXQWhkYURibGtSNFh0UlVRSXZZaThYcVpOU2pGSHA1NGhQUkY3?=
 =?utf-8?B?QUFFcUxUUXNEa0FoZWE1UmFlTmZISkR3M1BSRnFEcUpvM3VTQ2g2M2hxcXE2?=
 =?utf-8?B?VjEwZkhBTnpZS0dheWRtMmhxSGJsVDEwbU9GNEJ1bjR3L3h2TkREU01jZVFG?=
 =?utf-8?B?OENqUkt4MWk0TkhoU2hOL0NqYXVmckJXRXd4dVVzQ3EyNGFlRjQzZWFQTFh6?=
 =?utf-8?B?ZDFodnRHWDFlWHVQZ1VYcVpTeWlqZU9ub0p5V09kZTg4SnlHS3dDa1VCVWNH?=
 =?utf-8?B?OGtKc2Z3V1JzR3ZWVTZ6VTJZWnlKWHJmN1ZWWVFHMmNrMEdxN1BjWEMwc0Yy?=
 =?utf-8?B?VWVBNllVUlZ3T1RVbnV2YzBqaFVBNzZPZDNiUG1zR1NjQm9JWjBoTUpDZVRs?=
 =?utf-8?B?YkZHc3Y3RXRrRDdNMm9acjl3Z1dvRU9yVTdnYzdBZjBNT0lxckl0cnhCTGlz?=
 =?utf-8?B?c084MDc2L1dzSEI2VHI5STJDalg1YmZ0anhUVWNMeUozdWVOSDBEZjlJdnVx?=
 =?utf-8?B?NkROR1hYRXptckJwNDM1a0JRNDhtM0txL2NnbitiNFhLditlSTMxTGMxWWpN?=
 =?utf-8?B?TCtzS2YxU3FWUmlPNG9NZVlKVENFRnFENVRGRmtRaGdpZk9md05ibUx6cFZk?=
 =?utf-8?B?NEkvWHNPOGhDcVBmYmtvM0lnVmU5NnB2U0NQZDdkTzBuM2htQy96R1VuUlpD?=
 =?utf-8?B?TWJOcUZVZ3BLNjI1Ym0veEdrcFVzY2NURU56L0lTUHZVZ2hBUzVBVWIrQjNr?=
 =?utf-8?B?U1J0ZzJzUVd1ZVJUSEFoc2NIZGRML25WSGdKbHJPSXozeWREVXBvV1hyM1FL?=
 =?utf-8?B?OU05Q3VPTDI3VXV4ODY1YU1UVWNacUJlNytPa0pHaS9jVFVIWXhQcmhRNDJ6?=
 =?utf-8?B?SHQvbXBXUjZxaEZjRG1PM0hNeW14N1JjRUMrRVpYRWppY0VwQTI3eEVwR3JL?=
 =?utf-8?B?SWlOL2lIZjdjeTRpY05QWWo2VjdWOVdrKzF6L3ZNbDZRRXNNcUV3Wks3aHF4?=
 =?utf-8?B?dzlZVmhrN2NIZnpsTUZvZlp3N215WDJ4TDduRXpaVnd4bWpGNERGb2VEUnYv?=
 =?utf-8?B?WHBZQ2lReVI2V1Rjdk1rUlZnaXZHUEhpaU9UbnhxN1IvUndwb3p0RTJMT1Yv?=
 =?utf-8?B?YjdEUFhGK1hwYW5SVkZldXRGMWxpNWlVbC9RcnZLOHovZHBvMkxlNUdtcTZu?=
 =?utf-8?B?YzdkOTVhcmtycmVQUG5zSm9CeHZaRGFaQVhWbTZvbHZkTi8xUzgrT05tRUdD?=
 =?utf-8?B?Vm8xd1RrbFZRUzR1WWhTV00vcGxrUDJVSjRGaGszMlBndHk5bytPYXZpWUQ2?=
 =?utf-8?B?d1VCTDBuTDNkUFVmRG40aXo3V3prb0NiaEpvMnB6WE9BK00xRi9BYTZtY25u?=
 =?utf-8?B?YkloQjYzY05VSnpOTTVDT0hIZWZaUTh0T2pEYkJPUUY1L0dldEJQUmVyczBT?=
 =?utf-8?B?Rk9HTk5PcWNHNVBuaVpNUkE5cVVBbVptVlhCQmFNbUJ1VmxNT3NIc1RKb0l5?=
 =?utf-8?B?ME5td3B0aUYvYjZzZDMzaDlQZmY0WGFZZzRIQXAvVVpoQTB4UTV1QUJOV29L?=
 =?utf-8?B?M1VseTh0bEM3SEJPMDVpV2xHTW1La1ovQTU2UnlqSmVwM09WMERmaVpNd2Vn?=
 =?utf-8?B?MEN0ZmZ4WC8rNkVOTVpxSlk2eEZ5TTFLb0ttU3YxS2VwU3V1SFV6bGlUY0x2?=
 =?utf-8?B?R2pBdHJFd1JoWlFtTnV5VXI4U0FIampwd1pxZXJzaDY1T2lzNGxQNHhldnp2?=
 =?utf-8?Q?FF0QaJm1VtQTSMkZIh3eSvKRk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0ce58a-0ae7-4095-706a-08dce8097d9f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 02:24:24.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuMvK8y9Efyp9NwuX+6z75Sgj188+Vjgq9hfHEKvdCEA61Mk+HNEREgpDv1URQZ9EKsJuNQf8Jetiu1uoamJog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558



On 10/2/2024 8:30 PM, Frederic Weisbecker wrote:
> Le Wed, Oct 02, 2024 at 04:57:38PM +0200, Frederic Weisbecker a écrit :
>> Callbacks enqueued after rcutree_report_cpu_dead() fall into RCU barrier
>> blind spot. Report any potential misuse.
>>
>> Reported-by: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>  kernel/rcu/tree.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index a60616e69b66..36070b6bf4a1 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -3084,8 +3084,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>>  	head->func = func;
>>  	head->next = NULL;
>>  	kasan_record_aux_stack_noalloc(head);
>> +
>>  	local_irq_save(flags);
>>  	rdp = this_cpu_ptr(&rcu_data);
>> +	RCU_LOCKDEP_WARN(rcu_rdp_cpu_online(rdp), "Callback enqueued on offline
>> CPU!");
> 
> This should be !rcu_rdp_cpu_online(rdp)
> 

With this patch series, 600 mins RCU torture overnight testing completed
without failures at my end.

- Neeraj

> Sigh...
> 
>> +
>>  	lazy = lazy_in && !rcu_async_should_hurry();
>>  
>>  	/* Add the callback to our list. */
>> -- 
>> 2.46.0
>>
>>
