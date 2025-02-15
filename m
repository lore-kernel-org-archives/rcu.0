Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F1158D8B;
	Sat, 15 Feb 2025 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739598238; cv=fail; b=W86wpzfs8gidHsu+dSJDZ9DqnTXL5abbzPM0QNE7YPJ+0My/r1O6yPdEx1wjET6h3riBM3XH2gWbQCy17s0sRueX1vk7KTQeFcJpKs8wOcwdR0MbICJbEudCyY7jE3b2dJC8xjjhedUPRFxvYtt1lQEZW8bTtY4pI5SUU2Uq8LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739598238; c=relaxed/simple;
	bh=JV8ASnLn1m79pChk+dezac12gI1BqKKznkKM2Bl+Zak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ghcUPBPXqKZxKO2iZ2+ZxGUR/GBQCItfhPl5NCltzk81RvfIh8wDfK3tk3VlI6EEm1vadOIPcRag+zsM3lUC6HSHFqP6q1zfTRwTML4jlnSvj/h+DtI1od+goFhAiq4/7w1VjbBfr6CwQN5J8Uw2hXSI9pMtTe57ceJ0PDeBTGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=16eZ6OSB; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="16eZ6OSB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHRI/2ShVdgqNzu+09vQZrQyGphpGHTdzn3OBQufAEKkkx3uqF9g9xiumRDDh/TZU+VKmP3opy1TokstEZIvWEqvGQpkdqjb96lWb4nu7mQieEdRaO+WE0qlhN5OVcK7PZlurV2mPCzZwxp7vGFX905UQ2hhSOzmiMJBPwjjjBZmJ8Mr62duy/NiFDbvVXqIxaMn/VbdEb+IEMbZhXfahDt9eqfeer774RXyuqnt7YWKOKfBGGQOa6CLZ8d09Yq6QBLNPCh2/N6g2rTqZC2CqnnWzQWdlxnTX9xWm3udpHEhsvGF/fPcZMEe9F9hn6GujVzcNwMoSPK3gFiKIffTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHAV7X6FHrQN72FD2a/D/848wEtS89QxRBR/1plxL08=;
 b=e/etWXhQtV4MO/t+eYt9r3kKrBed4msrDT6vef1L+qf6Y00V+xjlJYRe3cHwik/NNCOo84hmjKpHB84yaPVC7CH3yHyjHl5XJ7BgnEspmNV+YTlh74hQ7B7tvfM8EHTb9h3TrZ6INV+PknP9UkODLi1chhdXOr6Rn1s72oNoLxSF5H+fS5CHnPXa6jp8IW6FJeFNdR+gIOnZGuj21zwWzVfdDm+XAH6csSoyGPxksWKW51YkJlPfKQQg5Cww6k+Ny3wBCjSKpYTR01LnIMRX0xS7VHzz7z5QMXb5pWTUAsI+/sR5FO2B9Zj1JUrhN9dpoNXTsISGjGyQApv5dIkVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHAV7X6FHrQN72FD2a/D/848wEtS89QxRBR/1plxL08=;
 b=16eZ6OSBzHnfyuLX+PgE3Hb5hnvv3xvzm80UWrLpigi8sgoVfUA1J2lsLo56DYO6Bi95WDprgZboXnmNLIz7QJCphx6txT9S3jurE/bgEZhng0QneCKVlaFL7nGYgAkYIt53OhBPzy6kAXh3lxN0K9qLkAlYWpMtFxfWGTJp7q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Sat, 15 Feb 2025 05:43:48 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%4]) with mapi id 15.20.8445.015; Sat, 15 Feb 2025
 05:43:48 +0000
Message-ID: <e937ec66-1cbf-4f73-8272-a7e75ff34a1e@amd.com>
Date: Sat, 15 Feb 2025 11:13:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu/cpu_stall_cputime: fix the hardirq count for x86
 architecture
To: Yongliang Gao <leonylgao@gmail.com>, paulmck@kernel.org,
 frederic@kernel.org, thunder.leizhen@huawei.com
Cc: frankjpliu@tencent.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongliang Gao <leonylgao@tencent.com>,
 kernel test robot <lkp@intel.com>
References: <20250109024652.1342595-1-leonylgao@gmail.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20250109024652.1342595-1-leonylgao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::10) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0ed8b0-c640-4c49-4f75-08dd4d83b7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3dnbTFML01JaTN5OHZaTzdlNGpVVk9qYlRRYnBTVGFUY0NYMUYxVXg3dmxr?=
 =?utf-8?B?L0xvT3JScjA2eFRSOTlrK08vajluWHV2b3pJYVJjQWc5U1FtU3BFU0RZaGtj?=
 =?utf-8?B?YXZJNHdIVU8wQVBrZzZjT1g3bThPOU5tV1VYRDlWK3dQbnRINGZNc05JcmZi?=
 =?utf-8?B?b2ZzNlhIS2Q1U2I1VFVBME5pa3NWdTRFNGpHV2hNcDV0UFdYNHlJQk5Qc3FG?=
 =?utf-8?B?dSs0WUZzaDdSS1pYaFBVZ1BNaGs1SVJDRmRkN0Zlc0dEZ3ZIcHhwVGVXZFNS?=
 =?utf-8?B?WGpDV2xVUEd6Tmd1TU9lSlQwRisvRnpITVZDRTZTRHpkdUJkOFBCbEQ5OEl4?=
 =?utf-8?B?SWRFTXVXNjdPZnlMeXBTSlg2MW0zNW1pSFVGaG9UaDFWTEI3NzVzdnZMRURt?=
 =?utf-8?B?MUttb2Y3M2J1ejZodEl2QW15QksyMEVpejZXdEoxRks1YVRKbkhpMHBrcHJW?=
 =?utf-8?B?aGRyVmVKT3d6aHdwRGNqYmZXSG16RWJmU1NCTk9aZFdIWEplTDBZMUlzLzhG?=
 =?utf-8?B?L0lJR291ejUzVlBkQXoyNS9vUHA2WDdWb3JZY2lPekJ1ZGVjbmJzekY1cDEx?=
 =?utf-8?B?eHA4c0ZmSU42WFRjWTZwb2lCOHNpWXRlc1hMeGFJZTFSQzFwa1lxRDFqcnp1?=
 =?utf-8?B?eFFPRWk0THg4Q1JLdEphQ2JzOFFoK0p3UnkxeGVTYWpRT09ZVjNobjMrajdq?=
 =?utf-8?B?alZPdzlDM1NNQXFmazVoeDZRRkpicXY1RzNYWTI3bHFHTWdwTHBrM3VaRjBu?=
 =?utf-8?B?S1NhekFjNE83dmlNUG1xUWI1c2hLRGt1dmh4azZxYTU4QTlBbm84MGp4Y3k4?=
 =?utf-8?B?SSs4QkRjM3AyelFEVEszUmhpZkR0NEZiWjNwSUhrS2NkOGYrakQ3NHprZWNI?=
 =?utf-8?B?REVLTVZGU29oeGVMUjA3UlpLbXNkcVBMbnh1MDVUNExXT2JsU2tOMEkvc2ox?=
 =?utf-8?B?RytJajRJTjZkMFQrazh1ckZHVGxzTmZSazhhTG9RZmFXcjdrek5mMThRNnox?=
 =?utf-8?B?Sm4vWWM3Um13Zk10SGoyNmRYODdkaE83UHcxd0MvZXMvTXhKMForekhhREVL?=
 =?utf-8?B?Tmk5SzErdlJvZDdXSXZzWnZBb3k3OXRUa3VkN3h3RjMxYlZrdXYya1pIRUsy?=
 =?utf-8?B?WkMzMWFVemVsMHl4M1kvQU5BQnFVdnhkMEFMMUc2N002dXRERHMwSjhYQlMz?=
 =?utf-8?B?c3dzRDZuWnBNUXJzODZWMmZib2pIcldJTkJYRUdRQWY5TUZQV2N4eCtkSzlT?=
 =?utf-8?B?UGJ4Zmc1ZDBOMk9uS2xac1Zwbnc2MjM3YnZSK21GbStQTEtQWjAvTHJlQ1M3?=
 =?utf-8?B?aVVpVEpOcExKU1R3dnd0dUNwQmxKb1JRaWFhYzV5bjkyZEFNL3J4dnJtNUcz?=
 =?utf-8?B?aGRVTFVZZm5ORkxJd2sveWw4ajBORmxqVGUvMTI1d2xndUdLSmtDN3ZyL0tO?=
 =?utf-8?B?YzkwNUVnL21hT0JuY3M0U1NtYkQwazdzWWxVUjhsb0Nadyt0VllYQmFGN1Mw?=
 =?utf-8?B?c2x2Ri9TZUlTRXNPMlhzMWIxSURsdHFYWmdsSHEwaE5GY2NwZnR1UVhMd01l?=
 =?utf-8?B?ditnSlVKeGtvVE5ZVE15aDFsT0VnZ3lRaUFFeUJneUczWVZ0UERrSEZ4T1Rx?=
 =?utf-8?B?NGpUcWJJclpjR0psOGRDNVREaXgyY1ZESXAyb3FmUmlmTk1zbkJuaWJ0cHp6?=
 =?utf-8?B?Nk11S0NuWmQya2FPZDArUUVOVjFYVFhEcGptaTl0b0gvU1YrTUFMRWwrV2g2?=
 =?utf-8?B?Y0FvQVBqQkdhMG95OVRwZVcvcm1ka01tcEVyMHZwSE1LdEszZEhrK3p4Wm1B?=
 =?utf-8?B?ak5tN3hMWTFQZG9zR2Iwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0s4aHpJY0lEUTE0MEw2VjJqWlZFUFJzYU5aeXZWWTJESGY4NWNIbHhDYmdC?=
 =?utf-8?B?NjREbmZ3bFNWMnBkVklKcmNYUHQzQm5NU1dGdFpSTDlWNVoyZ2xFbWV0NUhN?=
 =?utf-8?B?R2liOS9Eelc3Q1cyY3R4K1JkM0IwWGQxTk1MN3Bib3JWNGc4S3pudm40QVRK?=
 =?utf-8?B?and0d3ViK1FNUXJFZThWVytaUXpUc0IzeUlHdFB2WkVzeHJHUzlsT1NWWjBa?=
 =?utf-8?B?ZE5LUWhzaDBWY3N6cElyTElERm56UWZCRWRrTVFVMnJnbTFvRm1vZzJKZFVH?=
 =?utf-8?B?MVJ1Zi85d1N5UUlGYjJyNG1Ec1lkZmRkcFFwVGhpT2ZaNzIyY2lRMm15aVc1?=
 =?utf-8?B?SHBCZ2ZYdWxDTjVFeTYwL2ovUitJQ044NEQ1NmM1N2dlcjFBUk5BWmMzQU5x?=
 =?utf-8?B?NGRySDdZbE5iV2VQQ21UVjdWN05oY25sTm16YkxMbzBjMGh4WkRhUCs0QkQ1?=
 =?utf-8?B?NElRWFZEZFB2SFpyVW55bTZtbUUyT1JKMmVtcFBzMUJWL3NVN1pnUkxCZ054?=
 =?utf-8?B?RHVSNjkwOWtNVC9HZDlTUjRyNFBML0JVckNmYTUzUXM5cUxqby9iN0pDN0hD?=
 =?utf-8?B?RXFmNk9lNUUxcDcydDRybVQxektEeEt4R3p1cStRcFBBU3c3TCtBenR3aUV1?=
 =?utf-8?B?aTFVeDhNQXArSHFpZEtWYkcxZXh5bHk5SldVQ1QwL2hCQjBER0tuSFdxL2kz?=
 =?utf-8?B?eElUa015UmRRekRnWXQ0RmNQaE9Xc25NcUhlTHlrbU9SY2F3VHJpbEY4UEVO?=
 =?utf-8?B?ZmhnL2NLMkpjRThmTXRvY2hlM0RFU0xpdUlNaUFQOHlNK0g2RnV4cy9iV2Yr?=
 =?utf-8?B?bS9JUk9nbVA3UTErekN5dEkvRmxjSThzd2g0VFBhOHVCTUFPZnhZZDZ3WnNm?=
 =?utf-8?B?TTZuS3dIUEVDbkkwdzZuY0U2KzdMODc3empoSWsxMlBjMXZhUzdxbzZVcHZ5?=
 =?utf-8?B?elpIQ1B1T3JtYmR4Zm1xRVR4V2krbXQzWHNvc3ducFpFR0hOMnJQTXNLTlNK?=
 =?utf-8?B?djRCQ0lSb2xhejBlMVVBYjZzRGx6ejV0QU9FZllFajdVanhqbk1ZZms5bEFv?=
 =?utf-8?B?RUV2M3ZRckVvRGJybTR3THlHQ1JkQlFSd0hvWmJZNXVkbldYS25ld2hKMmRt?=
 =?utf-8?B?WTJ6dElSLzNCUDJ3MXJ1T2o2a3NRc1F0MUhZQS9LWE10a1loU3JjZUFKaFNt?=
 =?utf-8?B?K3FqaFVVNG1xZVZkSld5WmxDZVYrNVNxQnNKUjFSVkhid05kZWRPMXI5bEdX?=
 =?utf-8?B?Yk9oNlJZaGE1RG03YU1xNjJCSE1mRy9QMXZEK3ozQ1NmUDNjejhzU1hvYVNZ?=
 =?utf-8?B?Uy93WlU2RzI0ZDJvelBaRTBOK0R3OGlVd0phV2E4RmZrOTVZRG9kUnJMNThp?=
 =?utf-8?B?N1Y1K2p5QjIyUGtpNytSNGtmUkxVWlFkbFlEMWZvMmNjKzEwNGlWK1FYKzlS?=
 =?utf-8?B?bktXckpaN2tGQ1hrVUcrTndDZ3pObWJDWlpMUFBUbEVhdCtlUndPQWtzOWVt?=
 =?utf-8?B?MmdwMG1UYnNkeTE0QmwxY1VEMU16VEMvanZHMnRVSlN6MmFTeUFVODNUMTRG?=
 =?utf-8?B?aS9RTHRzelB4SGk3V0NWcGVmenlxMmNLdjdBRTJjUTh4dmN1R1B5RVZPaFQz?=
 =?utf-8?B?ejhQaWZxcUV4QlUyZnh6ckM5NDFESTVZaUpHV2wybElkN0x2aG5RMXNjNkow?=
 =?utf-8?B?RDRaQ3pnY1dLMDdQdFdKZkpXU0ExaStiL2RiZVd1QzNqZHBQTVpOVUJZeEh0?=
 =?utf-8?B?RXJyNFUvM1l0QWloSVEwc2I0ZHRKUERhaStrVDhRYkt3cU5FSmNmQTJkMXgz?=
 =?utf-8?B?am9WTDAvVmw0emY4bCtaRG81bDhZYUFSVEtTaDhta3RGYlgzaFpOZGFEbmls?=
 =?utf-8?B?VXdJK3lvRnI3bUZZbkFtTEd3NUY2azduVUJ1aDNkMXVlQXAyamJERm5pUDdN?=
 =?utf-8?B?akZaem9SSndKMHp6ZzFJdFpSb3BqSGIvc2RZejNwTEVLSDlwdHhSOU1rMXpq?=
 =?utf-8?B?WWJUTlRxR2ticklMSkQyQ2ZOUGJtbFgzdWVpNEk2SlZtN1NFOXVJTG5KRE5j?=
 =?utf-8?B?RUdjbEd0aVlUQitjRjhHalJrUDdrRjNVY012L0pud3N2b0ZPZjFpcW44eVdO?=
 =?utf-8?Q?Q8vP+TNGZjKCtfBYjn+r83GIh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0ed8b0-c640-4c49-4f75-08dd4d83b7fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 05:43:48.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuuSkfiei3vVjDYTuvpteyB+VN6QHVMbjiJBkEFZuJZ7kIZona7gBmflCHJd7dzpyG1lSvkSLXv3tPuRsKhjbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

On 1/9/2025 8:16 AM, Yongliang Gao wrote:
> From: Yongliang Gao <leonylgao@tencent.com>
> 
> When counting the number of hardirqs in the x86 architecture,
> it is essential to add arch_irq_stat_cpu to ensure accuracy.
> 
> For example, a CPU loop within the rcu_read_lock function.
> 
> Before:
> [   70.910184] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   70.910436] rcu:     3-....: (4999 ticks this GP) idle=***
> [   70.910711] rcu:              hardirqs   softirqs   csw/system
> [   70.910870] rcu:      number:        0        657            0
> [   70.911024] rcu:     cputime:        0          0         2498   ==> 2498(ms)
> [   70.911278] rcu:     (t=5001 jiffies g=3677 q=29 ncpus=8)
> 
> After:
> [   68.046132] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   68.046354] rcu:     2-....: (4999 ticks this GP) idle=***
> [   68.046628] rcu:              hardirqs   softirqs   csw/system
> [   68.046793] rcu:      number:     2498        663            0
> [   68.046951] rcu:     cputime:        0          0         2496   ==> 2496(ms)
> [   68.047244] rcu:     (t=5000 jiffies g=3825 q=4 ncpus=8)
> 
> ---
> Changes from v1:
> - Fix compilation error when using arm64-allnoconfig/riscv-randconfig. [kernel test robot]
> - Link to v1: https://lore.kernel.org/r/20250108065716.2888148-1-leonylgao%40gmail.com
> ---
> 
> Fixes: be42f00b73a0 ("rcu: Add RCU stall diagnosis information")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501090842.SfI6QPGS-lkp@intel.com/
> Signed-off-by: Yongliang Gao <leonylgao@tencent.com>

Please move these tags above "---" of "Changes from v1:" section.

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj

> ---
>  kernel/rcu/tree.c       | 10 +++++++---
>  kernel/rcu/tree.h       |  2 +-
>  kernel/rcu/tree_stall.h |  4 ++--
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ff98233d4aa5..cef8859857fb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -802,6 +802,10 @@ static int rcu_watching_snap_save(struct rcu_data *rdp)
>  	return 0;
>  }
>  
> +#ifndef arch_irq_stat_cpu
> +#define arch_irq_stat_cpu(cpu) 0
> +#endif
> +
>  /*
>   * Returns positive if the specified CPU has passed through a quiescent state
>   * by virtue of being in or having passed through an dynticks idle state since
> @@ -937,9 +941,9 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
>  			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
>  			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
>  			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
> -			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
> -			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
> -			rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
> +			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
> +			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
> +			rsrp->nr_csw = nr_context_switches_cpu(cpu);
>  			rsrp->jiffies = jiffies;
>  			rsrp->gp_seq = rdp->gp_seq;
>  		}
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index a9a811d9d7a3..1bba2225e744 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -168,7 +168,7 @@ struct rcu_snap_record {
>  	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
>  	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
>  	u64		cputime_system; /* Accumulated cputime of kernel tasks */
> -	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
> +	u64		nr_hardirqs;	/* Accumulated number of hard irqs */
>  	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
>  	unsigned long long nr_csw;	/* Accumulated number of task switches */
>  	unsigned long   jiffies;	/* Track jiffies value */
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 925fcdad5dea..56b21219442b 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -435,8 +435,8 @@ static void print_cpu_stat_info(int cpu)
>  	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
>  
>  	pr_err("\t         hardirqs   softirqs   csw/system\n");
> -	pr_err("\t number: %8ld %10d %12lld\n",
> -		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
> +	pr_err("\t number: %8lld %10d %12lld\n",
> +		kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu) - rsrp->nr_hardirqs,
>  		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
>  		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
>  	pr_err("\tcputime: %8lld %10lld %12lld   ==> %d(ms)\n",

