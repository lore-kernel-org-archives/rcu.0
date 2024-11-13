Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A6273F9;
	Wed, 13 Nov 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517246; cv=fail; b=LBFbnMy4HOlDu7rExMcik9tmu5NUJDABv/AZX8q3HTd3vhJI6/tiM6gwXDCCq/E01OCYr8baAMQJ6lPbwm3ZxiK6fTtNCu2uhicdRj3r21/nsf2FfC8AffCKUqsdK2XUOxVE2ZBV7FOLSy8DfQ8YlC3CagMF4wwcAbhd8qbDBao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517246; c=relaxed/simple;
	bh=TP/uNNAsBYOTTorPjk+SBI1h9mjqZ6sey1HG67ojJLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VyTsk5zfzXqbvc5lppE3/0c48tva5ETZkTQGLNH5gsx/3PU1Oslr0y391fPiMPqg0b69n97AH2M0A1igudP373cnvXqBV6PPBu3DkpoIF3qbdT3+Zg90suAvFFkUAW5EqsTbgen0b8LeUmZYNhCNkPYPJQm25WmpDAAgIK7RNLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qz8J5eP0; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qz8J5eP0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlEiFjtlfBMyMWNqFBCt1V+D8vkORRY6MScHcXoOGCF0GXLS+JoXIiOEcWZGnNOys1ioNQrsaHYg0tajW8e8s1ja2vkQRwqbS6bjenaAA/4Kkrf3qfLCkitpg03DkLu847ObgKCMIluOpDDV6A5F6L/EWVcMiT9/tSYMuljD0qAlMx52ajEM9ds8DweeE9gEiV/2QT+9EHSfzgFBHGEeECR3CKhSUuZxUr8dZHq2hFIT2TLxbbVfWO16ka+L/Qz14Dkl1V1Ut/YqpCHrnTt7352WWSFW/sCLYoGKZAWS1AcAs2DBg6XcSF4+4NZgxOhwcWMtrJhp9mJJMVYku5XgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYB0T/vp7CYgM3tXHeJ7HiqQPmK7AoX673WbVC7NS74=;
 b=W5GQyVY/XMS1CKfe8NRW0aNuxGs5SFw2KfmRS6aycKiHW2eIMVZfubZ84el1kGv7Dm5BI9XWC3stio43Ae5l+IXepV4J73TOoIMRVwAKkLC9hQTV2sxdFjqQScOY19HBXihK8HcU8C4kgWW2IGrwHONk1VuKEEHCq5GlPMxaVLZvttdWl/u5iGW0zxnaWspo2vexmw1ZooUmnFg6zf4rr2HiGJ/bvrE9rXiMJqT91Jw235yi6OAaUrCGlyfqo+05MOsNay/XKLRv8CieSwiiTObhYrneQcWeD8hYoZFgLXmqlDkViC4anJ/USI9ZMkfyXGCHQiS2f50BcWPkisZ2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYB0T/vp7CYgM3tXHeJ7HiqQPmK7AoX673WbVC7NS74=;
 b=Qz8J5eP0kzl8tST6g7KVgRRZCT40+R/0b/atq+pieT/+dGmVCj2uejWD19sQ3WBVEOgToDsttUbaEQKUEOI6r6GjoQHcHAXfjiA2BZCyum+HYkdJOKKRfKyCc8rHg6Sy7ZbhfLb8xhLmgPvAEWndFWhs1HeBd2SS3O/kMhMt1F4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Wed, 13 Nov 2024 17:00:41 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 17:00:41 +0000
Message-ID: <6f362a9d-a87e-4061-bf41-14810e432333@amd.com>
Date: Wed, 13 Nov 2024 22:30:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rcuscale: Do a proper cleanup if
 kfree_scale_init() fails
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20241113110009.65256-1-urezki@gmail.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241113110009.65256-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7e2633-28b3-4038-8f0e-08dd0404b451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0xqbEV4U1V0Ly9UV1pkQ3dTUCs4T1EzZzlmQnNmNWhNOTFLOHFWK2pmWkc1?=
 =?utf-8?B?TmtyQUZaakFaUE40MGtEai92cmRlWUpXaEg1SnpDeis1MmR6RjE5UUk5QjdW?=
 =?utf-8?B?eVJHbXBrRm9zMjFmcjR0WFhKWVgxZTdDQjVsL3BvUFhsK2xxeHJnY2hhREV0?=
 =?utf-8?B?UEFsVW9uUVVScW9GS2Vmd2toQi9zK3NoVWtmK1hMWHByZk5UblVaRko3VVpH?=
 =?utf-8?B?bEQvVUdpbEtrclRzbDRqalI3Ukxia09qQlVJWjhKelU4RllaZGJ4QVZMajFZ?=
 =?utf-8?B?S1lVZ2lXR1EyaStjeTg2eFdFRHFXMXJxWU0yU2JCZGxtWHJPRllML2llQlJY?=
 =?utf-8?B?K3ZhQlkvZ2hXbUl5Y09BV1p5NUtOWUVqMUlOS25NZVRhRlY3UFVkWXhuRkxQ?=
 =?utf-8?B?dTYzVU9CdXU1VW5uU2lJM0plSlpBbDdtcllzcGNPSmttbUpHWVdIVVZRcXVz?=
 =?utf-8?B?aGdLOHB1aGhkaXdMTUVWR0RRNEZmbTVnaVZwa0VnSlZDbnpzbVhjMTdMTGFS?=
 =?utf-8?B?RGtONXRlamlvQUlyM3VSb2U3MXRpYnZ4VDRxeGNMeGJiSnE4aU04YlZabTVT?=
 =?utf-8?B?R3duVDZhVDhYTUNqQXNuSUt5NUFqVEE0ZWovWkVncFhpdGdEQnBZTmFML0Uz?=
 =?utf-8?B?d05DUnI3bkNyK1p2YWp5QnIyd0J4cU0wVDZtVnR4V0lNRGx4NHhjZHlGUVFE?=
 =?utf-8?B?UHFhN2VoRE1KVzJnRXJ4WERzaENDejNKR2xjVkNuUmJHTUpQL0NvMzRzOWww?=
 =?utf-8?B?cExZVzIwNDJHVWcxbHVUbkpjamxmaVhtU09vdlVZV3NBaFM2NnJCbFVzc0pL?=
 =?utf-8?B?S1pwN3FpM2hEWklrVTBWR1ZVRzhsV0E3cDRjNExqUEpKTE45OXJ6QStsUTNr?=
 =?utf-8?B?NTZUN2lLYW9pQ0JJc0NBb2F4dEZybFBjVnliS0NVbEpjZGFTSDRaYlh0YVhi?=
 =?utf-8?B?OEdSRkNQS2NKT3RpNzRkVzNxQ3dlZC96UHo1TmxTeERQYjVlSkFXcC9wdEN0?=
 =?utf-8?B?RnUwRW5OR05WMy9hWXRMVXRNTXVYeDZTdE05WVdSVWdxMzRqWnBUeXRFSVcv?=
 =?utf-8?B?VEEvM2lvNVpJWlBtbThFRjNpYWc1S0xGRHBYMmZDOStwalZEOGpMWDdEUlFY?=
 =?utf-8?B?bURRMkE5bGpnMEZ4YzRNdjB4QWFDc2g4YTZJN1ZEWnpBNnJoUXRtRlJUUkpT?=
 =?utf-8?B?SnlkZ3dwOGpvUjNWSTVVTjNmeHI2VndEc054VEJpYmZIb25lVmV5bUdpcDh4?=
 =?utf-8?B?Y05laWxrMkorNmxsQWc5TDhaU25LMThGTkE3b3RIVVVXanJQR0J1SlBQZEti?=
 =?utf-8?B?VjkzY2IreUJ3eXRvM0JtZ2JkTkRZT0hEOGxRMTZJbE9naHVPUktDblFGRmZE?=
 =?utf-8?B?OFp3M09rK2UzeDdQTXFFWklkNVM2bVpKMzBsQ2VEZXFJc3lhcythVGpGdnY1?=
 =?utf-8?B?Z1R1SVErTGJpYUZFZ3k5T2dCQjBJNmpCRzJ2QkxocWNTZjRackwveGd4VWFG?=
 =?utf-8?B?R0tYMWVTYkN3RTFJYmsvWmhaREw2SUpLeVd0VVhiMHhFSVk1WURqM2JOWkdB?=
 =?utf-8?B?aEtST29GeUcwRHBGZXM2NlI1UWxaK2ZhWVN2aHh3Y2NpY3ErU3paaXN2dU96?=
 =?utf-8?B?L3lqVEFoZHU1U3FyV3ovc0RDVG5ZQnhZczV2Zk1lQVNSUWZsVXRCck1iZnp1?=
 =?utf-8?B?VXA2c2tlUmJWeUdVVE5uNkdtR2pWcVRwM2tqSmRqYituMWhKcjc2dGczTjN6?=
 =?utf-8?Q?LcRyLXOgkRb8BRqa+1nspNS2CKK3L9wjUZfd3da?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3A4ZHl1UE9xdlJNOC8vc0JQZVlUdjNxdHV5NStHblQ5bUhiVFBsb1M3QUwr?=
 =?utf-8?B?K0Q1Q3lDUjg5UlNwZDRwd3oxOHozQjJyYmZIc0l1VDE5enMza3I2MmdMNnVF?=
 =?utf-8?B?dGl4WGw3SVdjSjVXMEJMVmY2NG5vQkRIdy96R3NmODkvY2tOYWM4U1pjaVJT?=
 =?utf-8?B?KzVaOU1MTTFNNkVLZmhtaEl1WCtIWW1kSkhVQng1L0d5TXpUWWVxS0ZEYUpw?=
 =?utf-8?B?dWtsRmtCSnA0RklSQS95YU0reXpiYUt0WEk2eEZ3NTg0R3hNZXI4RUNjZEN5?=
 =?utf-8?B?ZFZHL0VZdndWOWJGQ0x6bXRleDRoY1crVzlocElkU2hJblJjQ2lCZHpEV2pP?=
 =?utf-8?B?VlBLMEU4Smpzcms3R3Y4bkthcnNpSXJqTExpMTB5MU5HMXlwVXh3VXZXbDlH?=
 =?utf-8?B?SmRQVEhsOFBGeGNlK0tFWEhSd0o2UnNEczVOV0d0akZyU29lVzF6Rjc1MkRR?=
 =?utf-8?B?Z1o1M3MxckRkMC9relQ0SGpHR2JYMitzSzZoWHp0K3oxRjVQZDRwSVhZMUY2?=
 =?utf-8?B?M2hFSGtTSHN6cGNmR2cyN1p5bW1YdFMvWDI2aTlBcFRvakhJY2dqMW5nMWcz?=
 =?utf-8?B?SzJvTS9YRk9QVSszV3A3dFdHL1h2b2RTOUF5bUk4cUNpMi83a1FJYnFGMXNm?=
 =?utf-8?B?TXFuRTA2RjBoK2RuOUtPaXZrQUdTREtDNG4wMVJJUkFKajBHSEdYcGtyeWtL?=
 =?utf-8?B?WklNQUNRV2R6c3VBNEwyUGZHYitSMXB1V2RablBRT2JnZ1hpMHMrZFc0Tlkx?=
 =?utf-8?B?YXVYZW85MXJLaDh3bVVtNHdDb1FjWWloUWJCMG92Vmdwa25VNis1Yk1WSjhY?=
 =?utf-8?B?Um5rMnM5aWUrSys2NjMvU1kwOW9FWjNOQ2k1dGxjU3dFNkZFc0pZOW84UmNT?=
 =?utf-8?B?R2JYVitQVHBpZDcrRHA3bnhMVTBURVp0ckFXRkVnRU9Vb0ZacU1pRWpmM3Nl?=
 =?utf-8?B?U2JOcDFaMmw3MnhpR0M2bFpvYzJoVFR4RThLSnBNeWFWQkZ1TmNxNXBzMm51?=
 =?utf-8?B?clhnano0aFhlNkNJTFB0WGs5V2M4Si9Oc1FSL3l4MVl4Ty9iMUNGa2hWeGpn?=
 =?utf-8?B?MXhXaDRGK1VSaG5xRTFOQnVycWluMmRyUjdrVnBQVlplcE81WEdKQ2hkOEdk?=
 =?utf-8?B?M25qTm82WnYyY21reENPT3c2a0xXZkFJUTMzU09jaVdoS3RMcVFSSFcyd0FJ?=
 =?utf-8?B?MHdsTDdvMkNyV3Q2QkN6V2hybkhqbXVIUWZFT28wa0xGLzMrUXFONkVSS1pr?=
 =?utf-8?B?WFFNc0JQbjFQaVdjMnIwQTU5TzlVUjI4VzdKWStQYVhyN1YvMEJndEdpM3BX?=
 =?utf-8?B?bmk0eUwxeXZvL3Bac0lrczkwemxRMmtLdFQ5dDRlV2JEU1hMTjhZZXBjdEFD?=
 =?utf-8?B?V1VQVmVTbTZCSFNyQnlhUjRxazZjaXdHTlVHZUNmRkJrODR3eUtJUmlrU2NR?=
 =?utf-8?B?WWhwRnVJYzJmQUQrWnNveC9rbGFqVGMxemNMbytrYlRwa2MwTjNWNnZFQ0hh?=
 =?utf-8?B?dXVsMUkyL0FRVWloVUNWWDUvUUhXN3dpYlFKTmx6RldlcHRTM21Bb2p4eFY4?=
 =?utf-8?B?TEY5SFUzeUtGdzJaNHdLcG5SdTFzY0xLNzRkZjJhN3ZBS3B1UzBrTzVhS3Mx?=
 =?utf-8?B?THcvempFdzZxSXh1cmNqUUtrMDlTaFNBYlFuM0Y2K0RSaVZWYXlEamowaUpx?=
 =?utf-8?B?bmxaTUlSRERoMmNNcXdEMWhOZHJwakhGQkNKc1p3TlZSSjljOTJ1NHFCV3ZE?=
 =?utf-8?B?TmtjNEtIMjQxc3Q0WXBzbVNZVkxQNm91UVFhdCtFOTdxanNybWhjR3h6WEg0?=
 =?utf-8?B?Mm5SeE9QeXA4RDJTZVAveDRKU1V2ek8zL1dEK01lTTF6elpMeEoxaEk0b2pS?=
 =?utf-8?B?R0VERFU5UWtkU1lNUjY4V3B0cUJLMjNtSEJNZVUrbDY5VythSC9jMldLWjNn?=
 =?utf-8?B?NTNKdmliTVQ2NG1IWkJRMFh1SDhOdURGNjEzYWFaZ3ZnaDdmSFlKSncxblhi?=
 =?utf-8?B?Qk02cEdwbTA2akd6cERlbmdkQ1FpUStvWFFSczJtWm1HMEd0bHVHUzloNWM3?=
 =?utf-8?B?VUVFeWVicjBqSExJSXI2WVo5c2U2dXhUY0FYRFZvV1RYQW5TM2lsOG1pWVd4?=
 =?utf-8?Q?xRPpZWJPh8XsKLEfpMphxU+LB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7e2633-28b3-4038-8f0e-08dd0404b451
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:00:41.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyIRL2X3eZd6Lk+wUuglRGLiv9I3ET+iMcPTunLUefy7mNuxurfTMDrZ4F+IVaueyPagkck3CPxS62APxnvCNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072



On 11/13/2024 4:30 PM, Uladzislau Rezki (Sony) wrote:
> A static analyzer for C, Smatch, reports and triggers below
> warnings:
> 
>    kernel/rcu/rcuscale.c:1215 rcu_scale_init()
>    warn: inconsistent returns 'global &fullstop_mutex'.
> 
> The checker complains about, we do not unlock the "fullstop_mutex"
> mutex, in case of hitting below error path:
> 
> <snip>
> ...
>     if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
>         pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
>         WARN_ON_ONCE(1);
>         return -1;
>         ^^^^^^^^^^
> ...
> <snip>
> 
> it happens because "-1" is returned right away instead of
> doing a proper unwinding.
> 
> Fix it by jumping to "unwind" label instead of returning -1.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/rcu/ZxfTrHuEGtgnOYWp@pc636/T/
> Fixes: 084e04fff160 ("rcuscale: Add laziness and kfree tests")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj
