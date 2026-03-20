Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6801DE4E0;
	Fri, 20 Mar 2026 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034345; cv=fail; b=L4KPrHpw2UYSE6FNteLU7tcIuJFmFrY88zsxrH6sje9Ko4n5+BZ52FzhgkQSDB42zwBYDfgsAYd9d9Fj71XdAeO0tbV+uLC4pfevVlAUGAP39IhS5UJ6exRKC2bCU+6FVPWoIMCmyGH3WLiVug5aV4T8eItzR7HZmmjtBoDHm3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034345; c=relaxed/simple;
	bh=QVGOscjTI9U6kOf85nDf6KUHPzezXIUCgp4Ael6kblo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pjli2irL92cNWO0Ss4hbKAFLAvVGnjspS27YWVEa3hr3OvZu7T18WT5U/qiibcskkJ5yQZrtKbH6mz0lCPisWT/A8SNDWzkFfosDEovCoPfTM3lwI3jkYwv+GhiwzX2L86E2i114XBIYzvKVTCfEYAnVEX6FHidFu+Nu3mnKllc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qXReC1V8; arc=fail smtp.client-ip=52.101.57.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qXReC1V8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twW1i8Z9uVqDex4Bm6cuJT6np5Las7AxXtevwRTHUMvU4g2Lsg0P/Xx9Ofzpqmb/600jnXfRV5pL6pbiKh0OhyUE4jXo3uOkmXEpND6fbInAi7H7rq1iBwUjui8WCDVB3HLQIBKEA0REl8sXn+TVGEf6R6P7d8lhgdIaCDc46o8dRf11vLvjB/gsm1rnF8S1wFsYeTDxYyH2vJrCKCiOf/G1BC21X+ElguYPgqAU4PHvMlryQ0p7qBEiERGdvkxhNuipT7ksUKtIbuHY79SS7kNZykLXK2AvTZuFzKlOUBM4NYqHl2K4G1K11OJeNyN25If8VO5vCdH/Y57EEQIR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIw/cv1U220WnhssXnF9dYk4vm/DdkiGnAo9+IC4kkA=;
 b=dkzUwFviXNgUgagyU59ro/2Lrg20Y6T4jTgrFv7/+ZOG+CkcTSKwzc/vf3+TtvZIa8e7vFIXv0FzLXmGbLTKIVcLmI8bASBgFvdBMwdYsKJGA7y539DTGwZSlz2gt/1PXoDDr9uT8BNrXVOYV7qTapknNt/f10EDtr0rxFbDh25TwxP2a0HvwLbfj9WbuThOOgYnuHlcXIsH/HcACClYDQZqHwClu0gnQfEWeLyjfjk+ciNi+7X3oAdpbUANihwyqE4MX1a7DczA+U8tWz0An/So6wgGfU6kVZY6nN6Yb3hO1iBmqdvCwtY5lcDo92+2lDNOaDkXTVOkgeWPPF5LbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIw/cv1U220WnhssXnF9dYk4vm/DdkiGnAo9+IC4kkA=;
 b=qXReC1V8GUuqIorNlZs+uHnQQeMchBQ11F5rlEGruVd+f78/DuHi5ftFo3NBsiCvg7vLIKMoM8ocPh1xztdrO991awFRkzSTa4I3vEQO1Nexu0IO26e5xODpa6fwaMfE2v4ovw7tymSEV6gPL9OG6T6HbJAvaO2RFrMra60thg3/AwTQRPq+cQqm2IHlS6Ulb/9o/FsAu6c0IkTiOzjgOoWNyylFPKFjUQMTYruo/Jkt/l4NCdWyV5zOBtZJ6lxcJBCZPYH9pNWhFD5+at15TFRYZ0P/HT1iUiijzwA6xQrCjkPd5S6d4trM1R/QdaA6WxaltGNreH4Vop3ZlTqIcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Fri, 20 Mar 2026 19:18:59 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 19:18:59 +0000
Message-ID: <59f24a92-a738-4af0-beb3-c3ebb31c41bd@nvidia.com>
Date: Fri, 20 Mar 2026 15:18:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
To: Boqun Feng <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Zqiang <qiang.zhang@linux.dev>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260320181400.15909-1-boqun@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:52f::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9977c3bc-1a48-48da-1b74-08de86b589bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|7053199007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	26C5FLWT8m64ax6NVmlfw70GZdwhDtLSGcgVvAxC4I9xCgUHCr/sRdWQJXKbihkXWRKAU0/Zto1oZ2WnFdJ/4phIzBB6itL0gr2OBQ/WnvO9t8+6fb3g1yysCUG1F4iGmyVwP3H/MWRPYRL4yV78mAj2qj6+72z9b8qgyuXgDZ1HaSu4qDFdzoJ78/jo6WKFDxI098n2BdTXZhZH+4xRb5nm+12NRUNqswco1OkIHexgMgLWF0a+7C5wNCfof1ckgca+2LY/dPIZhSiuHlBAGC3de9gHbv2aDNmImeq37EWHztsSPhsVD47gbv94qpJyaLDxMa/apB9Y1d9VcDF3EeLe7PH6YB6oBlFkXRa61tlk2RJVIASRHQulhjIgKbYsmj/8ppHyx9D0lFpvesKPx4D41n8Q1uTV6+usv1TGUQTYmbEuz4hz5n7NxXyqsF3ykCvsUNyVVOe+xp9UQIDPuFxY3BVBY1onvSv5kB4l3dE+dJjue2KzvMnQ5ApdHHKAy+jvdYlYHLt4fqQyp8eDnNE7byE0AmkgVKK2/YEPwwu3POKothx7mnF0yk4Wsnm34hwwA+qO4JnUbYf/oKRYR2qlMZilof1QVu6StVtfNdIJrcbi4TlhI2s13dcZb5D0MeBZ+8ko/FaDNLlQVBxKv2OJHeyE3zDecbbCG5k27pk6503OKK2W35q8Xj6uF3DZk++z5gSuY2QCwt7sbd2ur97w0l5QhSX4qQPKunm60B0rZilt+Uhf06C3hLN7ErM7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkUxMSt0eUI0Q2hkR0tIQzFVWCs2ZThZZnRUNnRxVzJHbzMwVVBmeDM1Nkw4?=
 =?utf-8?B?SjBlTDlNQi9vUDBRZDVxYWgzOHRvT3JsQ3pOWXBSMmhxTHpYcmszOVhXVS81?=
 =?utf-8?B?TGszaVg4RWpsMmtDMzhlT1RwUUEwNDBhcDNLQ0NVekYwd20zMHFCaHhNMW9v?=
 =?utf-8?B?d0ZJcmhzWndMc1RHUlJ2bVhPVFVibWoyL2dZMXU5U2R0TldpOWZtR09RWU5n?=
 =?utf-8?B?RGd6NVYyQlBVRmtya2xNbVZGbTNLMUthY3FZclUrVGVpMVJxTWVCL0FJYkJj?=
 =?utf-8?B?OU85WE5nVWdmSzFLQS9KZTN5eUVEM0d2UWM1ZDNQK0MrS1BNRTBxMUxjaXpH?=
 =?utf-8?B?WEY3eHI2MVU3TmxDMVBwN20wcnNnQXpIa2RIMXNIdjNRQ0xzN3pPTGNNVGth?=
 =?utf-8?B?L2ZjZ3diYk5CTFZqQ2phYXMxOGp6RVRDZUI0aGsrL1BmazlQbFYzQ0xNK0Ir?=
 =?utf-8?B?eWFxTDMwMTAzWGFENmNZZjF6ZFNNZ2NmSGV1WG41cnkxYzhHUSt1a0pzVStz?=
 =?utf-8?B?WFhtWmJ5d1ZDV1VNcWlBb2pURkdjWjd1eEJSYkpxTFNsb2ZUQm1STlgvM1N5?=
 =?utf-8?B?Y2huaS9RREZDOUtBUEVSYituY2ZMVGwyNFRQbHNjK2FhSlJ1RjArVkkrdkxq?=
 =?utf-8?B?TFZpRjhOWWg5M1NabWIycTJLVisxQXRPVTFhWG16S0lKVmpvUmRPYnhLYWtx?=
 =?utf-8?B?R1dtZzFYN3dRMjc5UjUzaW84eEhPL2VIc3Y0bnFnVzlhT1F5Z1lNZDA1bExr?=
 =?utf-8?B?RTNwL1A2d2ZuNklYeW9WQVNBamczekRVS1g4VFRSb1VDeGVpcU5MRVlHSWd2?=
 =?utf-8?B?MFFEa0JQR2Y3UVF3SVB3amlQOXdYL0xUajZZMjhlZ3F2aVBENHFmaGpUVzBV?=
 =?utf-8?B?UEt3eVVtcUVnTVYxa0cwVlArRXN3ZnhvQ2NiNDdhNDRvbXRMY24yQXQwUzRp?=
 =?utf-8?B?MVJBUlcyb0thQ2RrM1dzNVpJeU9CbjJrczB4QVdPT2g2amZUY3o4V2ZJbjVM?=
 =?utf-8?B?aTZGWUJlTGJBT1J4T3pUUFRIbm9CeFpLSGN4RWVCbEpQdERHVXQ0ei9vMW14?=
 =?utf-8?B?R0psbmtTVktFOWk1bW1SbHhmWkFWdmxGcmlqTk9NT1ZlT1NZSUtUNDlCT0I1?=
 =?utf-8?B?d2hJVldkY1JaYndXZ1p2cHpRTzQ1UWZMYTZZZXJvL3BJZXl3MWZoT2QyajRm?=
 =?utf-8?B?RWxWY3BUdmZtanhNVnU1RDFkOG1XNjc2Tmo2bEZibU5tMWc4c3BMZ0lxQWdq?=
 =?utf-8?B?Zi9lODFzUTkvMUw3bkdUcHVvNXNlVTZxbkowWG5UTVlFRlMxV3FtMU03NHV3?=
 =?utf-8?B?UXhrQVFNekF0ZHdGQXo3VDJaU3doOHlreHBOeS9Nb3dQcjBDWHVRdkNJMmtq?=
 =?utf-8?B?ZVB4TDdCY000SDVsY2daRldYMTM4VWljUmtENFBjKy85QUtSOExDWUJrUUoy?=
 =?utf-8?B?N1haNm9taHRFYlNac0hkOWVUMk5LNDkycm5RTkhZRVB0ODQzdDNLWmE3Uk5M?=
 =?utf-8?B?WkY3UU5ma3BLR1EycVNZS1Y4MEF6ekZnbVB4Yjg1bW8vdVB6SjEwd2RldFdW?=
 =?utf-8?B?VlNkTFRCL0tJOWUxcVBQQ0hVSjRmRlB0NnFVdW9qZ2lPR1dSNlVtWm5uUm1a?=
 =?utf-8?B?NFQyOWlUcmxmUWNxaDZ1eDlSWHFzTVdNYVB5ZElVTHloa2JWN080dTlML3BQ?=
 =?utf-8?B?WUNsY1pVSzZWdEUwUEtzMFBINnVyZldJWWUxcWp1eE9SS0pJb1JmNW91K2Mz?=
 =?utf-8?B?YzBMN2haRVAyYXdCaTNBdjR1RnlOOHRVc3g4TUMwc0NlR0tuck1pVFNqaFh5?=
 =?utf-8?B?MVo5VFhjSXZrNWtHM0RDeXNtWnlUVThOTHB3SVdDL3lnc3hHUmVPSTExMEFz?=
 =?utf-8?B?cktUWDFQcnllcWExU21SV2xRbFJLcEEwaEp6VEI1QzJoKzAzQmJwNENiS1Bt?=
 =?utf-8?B?cjdrN0JZWmV4dnpLeWhWaDhYK3NvamRMMVoybWF5VThlbWg1WjY5UUdBOXE5?=
 =?utf-8?B?REJFbDdTWlJ4eEZidm9hMkFHK2lGNEtiOHlHREMyNSt5SmVUY25ReVdsVXBu?=
 =?utf-8?B?TzVGd0dKZ1RCd0dtMGxYWFRuRFQ0UFZacW9Sc2dlRThTS0ljaGNHWEZrSUor?=
 =?utf-8?B?aUR0VGV4SVdVYkNpUjFsYUdQZUVYY0dtcXpTMnhGUS9Dak9LUVg2TTN0dVJS?=
 =?utf-8?B?YXFhREpFUDJiQUxkM01RVDUxU3kzQjVGV3IyOWxSbE1pZENXQjNNeXZTZDJZ?=
 =?utf-8?B?c1dqUllCWkd3c3pGZzlBZDhtQk1MUjloSDJNYi8xYUtWMFNkMkxxVGQ3cTNN?=
 =?utf-8?B?WFpRenc3dnJkVEEzTng0Nmk1STBndkhyTWU5OWh2cm9mdkZLRlhmQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9977c3bc-1a48-48da-1b74-08de86b589bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 19:18:59.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg0BiN+eWZvigKu5q6oNPLR9yqdrBgFaLJeEF6kQC6h0Npbp9HzMb174Pvt1vPafhQcoJ5r/C8sD1aUMSDG9PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176



On 3/20/2026 2:14 PM, Boqun Feng wrote:
> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> happen basically everywhere (including where a scheduler lock is held),
> call_srcu() now needs to avoid acquiring scheduler lock because
> otherwise it could cause deadlock [1]. Fix this by following what the
> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> the work to start process_srcu().
> 
> [boqun: Apply Joel's feedback]
> 
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
> @Zqiang, I put your name as Suggested-by because you proposed the same
> idea, let me know if you rather not have it.
> 
> @Joel, I did two updates (including your test feedback, other one is
> call irq_work_sync() when we clean the srcu_struct), please give it a
> try.

Thanks Boqun, I applied it for testing further. It would be good if Andrea and
Kumar can try this patch as well to confirm that the BPF issues are gone.

thanks,

--
Joel Fernandes

