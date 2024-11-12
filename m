Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E55204F90;
	Tue, 12 Nov 2024 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382102; cv=fail; b=OBzASC1ddeLA+6d3J2C/pqOwTbhrn0HgmKRsMhxIk5j1gJM6YeMWS9sBdbXC3lIDft3ZMLcwI5/WyLMGMIxcabMu+hZ9ulnGEML5FNTeF4FY3J1IrGALE1GINJiD7mdQSHD0pTAPREK78ABDQ7fpDtXr92Bmx8gpuP+CttjWy0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382102; c=relaxed/simple;
	bh=zZ5AOly05X/9CXho7djsrf3LN+k/Cq2dXRE6b2ZvEAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ieM2cV8nP8mdTO0LRLHChw78rklk2E8VtSQyyMKPSLhFi9uFEWhC3/6aWceI9lixFFC2mRezR56CSXvbxVoMfSTA5kZXLcvphzsMdJmR6NvgN5nfppikh26XucNyncE1qg/FgSZosHXKmGMjAutoSGRXOGM4Zn1f4AK8GMydWug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iLHrFmDS; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iLHrFmDS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxLoXZ8qmxhqyfWg+5uaptmlYs8omFzr+fIDQvK7+ZSxS5d3sv4yyKsj5CHfcbRsONC4SFg8csk7Bku2c9Q1322J7LrNGoBcVyMXvoVC5GfQpdrsL9obehHm7q/qJb1s+muevhFJFiz4XaO/3QjnahlRpj+cHgVHlAw9hZ10u6U+iR3CxbM+N14IdKVBlRYSHEgCRfYQjFV7V2U6h++2EV9osZjg1XX1EwaXImGdJXbP3JghUWnpGE6+WqKDAbrqp0xa3L/fYXHHC+8w2uGdGu6in20BKjjnYrfimMEv8eJmN5GmK94tyB39sNBvXwQyDmYr8MQdgcoRkGVB0kvIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZUNHZSqVKvMRkjZTrdX/3C1jluRvfuMGh9dadtNhqg=;
 b=NP50V+iYsNmwoswm+rRTg2x9OoHKPt78+34wcIOEOU2QcAyHeoFFWJ3F3mH5anEALsyI/FJ1cWzPrnv7U3zqXPm2UUBPzEKOPcfxkl5skty6LlPH8ZVM8vuJViJtVJg39LexD+0PXn69eN6H6auvYmC6hJRFa150LcSI/fIhD6p64XWlS9o4qqq/WqOjgZoHVUkgh3eJ4Evjj2UuPjDmgYRbmVSywugYxYykuuWAqJUA+9FbPSqMlzNQBTZtRg58yteD3BNOUYE3BFJAUOB0eylT6jv93wSbFT9cB8UwWcy3mhCKx/sQlnLRiTfDNMWYOtMa+NvTQQM5meOzImTLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZUNHZSqVKvMRkjZTrdX/3C1jluRvfuMGh9dadtNhqg=;
 b=iLHrFmDS0rAhPdzfxf/+37S+iD7zYUFqCHQ4l83E7+C0MaAQwHjt0YktXlNO06lA/bk0Dr81yNGt0E//VdAvMbC4HTmSyG1+OE/oOIl8Dbr2mUFYSXEKw3+/Jpe3C056Uao1RRCo1AVAdGznRiBsaRpURLn/E+li0KOlfQAd+hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 03:28:17 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 03:28:17 +0000
Message-ID: <0b88aca1-fd46-44d0-b114-c6daed1a5a11@amd.com>
Date: Tue, 12 Nov 2024 08:58:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 2/3] srcu: Check for srcu_read_lock_lite() across all
 CPUs
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 frederic@kernel.org
References: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
 <20241112013143.1926484-2-paulmck@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241112013143.1926484-2-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: e8185ea7-4a03-40a0-2353-08dd02ca0c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW5DRGhiOTdCOVNTaHF4cmtGMXZxWWtvSy8xUzFnVmhzcHQrenhZS1pjUHBx?=
 =?utf-8?B?VzI1WXpWdTErUWZPZ2twSG84VWp4UExUdE44WEdKejVNZzh2T0VLM1FVQyty?=
 =?utf-8?B?NFYwSEI4MFplZTMrRlozU0VCY0l6aFVocjdzd3hwSWZ3VmgwTngwY0RWRlBT?=
 =?utf-8?B?UU8wSHVwMEsra2pJZDY1VFVKU1BGbFpSakt2QkdYR0lLRzVIWElLYmtaWHBU?=
 =?utf-8?B?NkNVMlVFcTB4RlJKa054NjVPWGxGdW5NWnMzY2VNb1hON2c5ZTJRMmZlVFZh?=
 =?utf-8?B?MS9HT3EwVHlWNDYyS1VZcFFrc09yNXVKRkJGMHRhYWNnUnJwRHphZ2JIT05L?=
 =?utf-8?B?dzc3SDAzbGw2dG0ydTZnajNPRkI2dTVYeDFsZW55Q2FlOUx3UGNTNm55dzRq?=
 =?utf-8?B?STQzcFRERDYxNDhIbDk3Ni9ubGRoSTRmRWxia3dFOEoxYlNzTHAxbmVlMTZ5?=
 =?utf-8?B?T3kvbitXdHI5VkhsY3lmRGg3cEtUdWNlMUNvZkFwbEk2MkgzVm1mMHc0eEU0?=
 =?utf-8?B?N0haSXJQMGZuUGxOK1NqTWZqbnR3UXg1anZJc0QwK3hsNG9mTUJPVjBjMlNu?=
 =?utf-8?B?WW5RbFlIOWdlRENuNm95SmdvOEwvamhsdjQ0bVpkRkZzU0RqZTFnWlZGaXN5?=
 =?utf-8?B?Rlp4TDBGNk96T0ZGMVZCRWtjK0NIZnVPRWN3Y1Z5ZXQyckx3cERKVFMySGpF?=
 =?utf-8?B?eStRL3VRT053cmdTRVRsdE12MWdsejRkMzE1QzUzeUNsL0dnOGlNUWQ2M0Y2?=
 =?utf-8?B?T3dTWVF5SnNSQ3NzdUtRNlZqSVhnR1V5UnIwUmp3N2RScEYyYnp2cmZoTjdO?=
 =?utf-8?B?Q0E3MENmVHE5Qk1CYVcvdjhCT3JHNzVzSGs0OVg0NUMrMVFwVVFPR29QbUR0?=
 =?utf-8?B?V01wUVY0YTU5b0Jqa0dLbGRVNWY5bk5tdnMrRW9lL2VUMUUwYWNFQ0xDSnFo?=
 =?utf-8?B?RkVrdlMxNzJXOS9MNGFaTFFmWi9zZlh2TVQxa1U1RVBCZEx5MGF3bkFET2ha?=
 =?utf-8?B?bU9FaXR3WFROVkdrWmx5OXdrS0Fnbmg4eXZDZU4rRU1NWS9xMUN2WDU5cjlM?=
 =?utf-8?B?bGwrakltaW5OcDNFMFZvNnRyOGZoQXNjZ0F0UTEwNWtnNzI4dkhQZ3VpamZz?=
 =?utf-8?B?TThQc3ZOd041YnNHSVRJUU1EYjdQVktYNmJRZ0kyNEJiaWNPZjZ6bnBwaWFX?=
 =?utf-8?B?cUpiNUVwUWRBZ1FiNXJzOHVYVWJuZzlTdG5kdFU5RytDNXNDSndHYkFuYXFN?=
 =?utf-8?B?ZXFRNGt2ZDA2Nkc4c1VOZktKQ2UwMlJpVnZnakNsemR2c3RaL2JhKyt4SUdW?=
 =?utf-8?B?TXVabUF5SUxKS2NwNDNYRUV5MkRKcHc2TWx3LzBFZVZiYmE4Wnp1WVhKcm9j?=
 =?utf-8?B?YmcrK0JMN09KQUcrQ0x6dnArKzkxZnRMaFhyRVlPQXU2NjZNMS9ySmZhMUhN?=
 =?utf-8?B?ejJtMUo3U3RWM045VmNOZ3NEQVlZUTdhZk1qNVNJTjFhVUREZy9ZSGVLcVVX?=
 =?utf-8?B?ei94QXB3RDZLdmNlU2xiWTNhNHY3YUp2UEJ3YS94bnNHejBvTTNQWm1FNlFw?=
 =?utf-8?B?RHovTTM5WTFuTGF6d3I1WUt3SUdOdkxMbDZWbE9zYjR6Y2hCeUpZOVZUUVV1?=
 =?utf-8?B?cGFYMXNjR0JZSHJqYWthY01mUERVbWhNY0V3cVNCL29qSWQrOWZpa1FoVS94?=
 =?utf-8?B?dU5CV25QY3NsRWtzaTR0UlUwMzBIQWdudWFldnBpS0J6akRFZVcxU3NsajhP?=
 =?utf-8?Q?gDzW9yTFfIy6pPUIlwUQPXw1Bfws8jt3YCRhAH0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW50NFpueEM0V3NWUi92OS9EMjVTdkJLTUtwVmRnMjRMOVRoSHo2QlNZcEcy?=
 =?utf-8?B?dDZzaWliWWxZWE1GQzRhc0hoVnVGbm1hc3RMdGRhRmN3aVVVOTNaZ0FVQ3Qw?=
 =?utf-8?B?U3pTRGFBc2hoamFIVWVuNi9nQ1laeXBTZUtpMjMwYjRKODFPUGxWK0lZdEFy?=
 =?utf-8?B?UzhPVFVJU1RVL2dXRnkwOFhYUHlIYnQ5SGJCRktwaU1WVHRvZnZnc1VJRTVM?=
 =?utf-8?B?SnZ3Tkhydis3bXRoN2t4SmlwRGtoWWRjTFFKZHBvMlhWdVVrT21QU0RpNUNW?=
 =?utf-8?B?SWZFbHFjcnVIZ0JZOFlMdkFPRGRXT2R6dm94eDR4c1dwSWE5SnlveThZMUJU?=
 =?utf-8?B?MmRwYVNzWTkvUG9SWkJibGw3WFdCSVJJRUx1ekFwQ1BwTXRHNzViT0szMS9s?=
 =?utf-8?B?eGp6VWdzV25BT2VkaWNRWDE2UkUxMkJzTC9nQlhqbmhJNHZDb2JuSnNkNHMy?=
 =?utf-8?B?am5YQThvSmUvNlpzMzJXZnRwWGYwalZUS25QY0VYU1NCelUySHlWZVlGY1Y4?=
 =?utf-8?B?ZmllRmJkcnlJcGxQWFNaS0tMSnpFS1ZsZG0wVDF2Z2c2VVRrQ09ZZmdkblNS?=
 =?utf-8?B?RHVYcDVUcTlYUEVSRURYaG9iYktGdWZSZW82L0xRYmRyVldGOWRFNUtBeDdl?=
 =?utf-8?B?a0VaY2ZTT0FtdzVuT05KZ2FBQkhzOWhydWxSYU80U2dOY0NkeWFsRDNtR1E3?=
 =?utf-8?B?ODhsMnUwTjUxZFdRVGJZM3hkaFlPbHBMQ3JydFZnMTBHeFJROHVWTEtJOC9Z?=
 =?utf-8?B?VnVjWDRFOTFBMzM2TERrclNZeXFuWTBHL3RrcUpwK0lSTmdYdm9iTmdSSVhT?=
 =?utf-8?B?a2FnVFRNNVB3U2VUVkhEWHIxOHJlRmxxV1lqNko2c1VvT0FQdGtxTVNUVDdS?=
 =?utf-8?B?KzJuR2FtcFFmN2c4cXdHMkdYNHdBbnVOWFk3ZndFQ0M4NXQ3YzhZZ2NjbjJt?=
 =?utf-8?B?YVg3UG90QUxuVUt0Z1VLMmR1ckNENXh4YVRRWG1PbG5UaE5mV2hpU2h4bjhP?=
 =?utf-8?B?ZHp3czB4STFWSWVmVVpPNnhSOFgxTkVkQzVYVnRUUXB4ek5ET2JpV2pQN3Uw?=
 =?utf-8?B?WG5leXlWbjF6bXZZNXlpbGNkcTNqbGhobmt4N0xDbUpNZkZqQlpuby85NTZH?=
 =?utf-8?B?TXNkVUJ4VXgzZWFpTE9kSjY5T3NtTjF5aEdkYm1FS25iWlFJcTZqcitlWmND?=
 =?utf-8?B?ZFBEaWVMYmZFRG1jWEc4N3lsc3pzNXdtVzlxdkxTdkRrb1VZNE43RElTMFBB?=
 =?utf-8?B?cUVoYTdGNHphS3c5cGxncEVNc0xXbllqb2dyZmh5bUMyM0dYSFBONTQ0MEcx?=
 =?utf-8?B?eER6S0kvU3VDYWRLeVNWUzEvR2UyanhJcHVMdGprMGUrdmtUcStubmdPSDJ4?=
 =?utf-8?B?MkdzbmJ2R1NQdEVBQkx1eS9iSlNZUDJTTloyWmpJK0FjeDk1Wit2UEZlRFJy?=
 =?utf-8?B?ZVgxWVpRZGtPUE5KQi9rWnB6ZVVaT2xJTTdjNjJzN2ordEpVTHRxUi92bjhY?=
 =?utf-8?B?L0Y5dXVGcUJRZ2hDSVZnOUJ6K0daNThLenpjMXA5bVBPTFppM3lDdDNkRjBN?=
 =?utf-8?B?dmdoWHUwRHpKZ2hxeWtRL0lFTTloZW8vOEpCNjFsZHYzejRwWThwZnRBN1gr?=
 =?utf-8?B?M1ZBclloa2UxcTZVdmR3L3Z2dURWcnQyRnZ0UXk2cW42Zm52elhkTHZwUE1j?=
 =?utf-8?B?K2F6YXdvSjQycU9DUzhkNURLR013Z2hScFcwWGZZUHdHdGs1b2RhQWVhVTFP?=
 =?utf-8?B?cHg1MzB3ckF4WFRiVDVlZGlWTjRqUFN4OGxNR041aDVsUXpUNTl5N0I4T2ZJ?=
 =?utf-8?B?UDJKN3dZYXQyam5SMngrMiswczIvNFd0K3hkQTBmMlhoa1RodWxPZW1wSG54?=
 =?utf-8?B?U3dYUlUxL1NYWGNPZ0pBLzZabDBKdlNsV0dQK05pd0hyZ0gvR0pqWk1IbTNM?=
 =?utf-8?B?NVFRUFE2NzZEYzF4VmphMVo0RURqZHFES3QyNG8wNzRXdHd5ZGdJdUFJTzUv?=
 =?utf-8?B?NGg2VDdKZXVud0I5cW1tenVaQm0xdGJMZE1rNW42RFlHZ3RXZmJXejdvaVBs?=
 =?utf-8?B?bkxJQVBacXEvay9aV2RCS05rNE9iOGpublUxRWMrNEplcUZlcXRrTWxRVUhz?=
 =?utf-8?Q?1GSICIZRl5RkkwZCCCTLox6L1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8185ea7-4a03-40a0-2353-08dd02ca0c4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 03:28:17.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioB91pnbtYWdcaa8p2IrIWiouX/SGaPSEN7aIZiTnb5fg8zvOwmjK218wvtr0MJaKiHeeT81voX9nOrdgRL2fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788



On 11/12/2024 7:01 AM, Paul E. McKenney wrote:
> If srcu_read_lock_lite() is used on a given srcu_struct structure, then
> the grace-period processing must to synchronize_rcu() instead of smp_mb()

s/to/do/

> between the scans of the ->srcu_unlock_count[] and ->srcu_lock_count[]
> counters.  Currently, it does that by testing the SRCU_READ_FLAVOR_LITE
> bit of the ->srcu_reader_flavor mask, which works well.  But only if
> the CPU running that srcu_struct structure's grace period has previously
> executed srcu_read_lock_lite(), which might not be the case, especially
> just after that srcu_struct structure has been created and initialized.
> 
> This commit therefore updates the srcu_readers_unlock_idx() function
> to OR together the ->srcu_reader_flavor masks from all CPUs, and
> then make the srcu_readers_active_idx_check() function that test the
> SRCU_READ_FLAVOR_LITE bit in the resulting mask.
> 
> Note that the srcu_readers_unlock_idx() function is already scanning all
> the CPUs to sum up the ->srcu_unlock_count[] fields and that this is on
> the grace-period slow path, hence no concerns about the small amount of
> extra work.
> 
> Reported-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Closes: https://lore.kernel.org/all/d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com/
> Fixes: c0f08d6b5a61 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/srcutree.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 70979f294768c..5991381b44383 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -458,7 +458,7 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
>   * Returns approximate total of the readers' ->srcu_unlock_count[] values
>   * for the rank of per-CPU counters specified by idx.
>   */
> -static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
> +static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx, unsigned long *rdm)
>  {
>  	int cpu;
>  	unsigned long mask = 0;
> @@ -468,11 +468,11 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>  
>  		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
> -		if (IS_ENABLED(CONFIG_PROVE_RCU))
> -			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
> +		mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
>  	}
>  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
>  		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
> +	*rdm = mask;
>  	return sum;
>  }
>  
> @@ -482,10 +482,11 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>   */
>  static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>  {
> -	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
> +	unsigned long rdm;
>  	unsigned long unlocks;
>  
> -	unlocks = srcu_readers_unlock_idx(ssp, idx);
> +	unlocks = srcu_readers_unlock_idx(ssp, idx, &rdm);
> +	bool did_gp = !!(rdm & SRCU_READ_FLAVOR_LITE);

Move "did_gp" declaration up?


Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


-Neeraj
