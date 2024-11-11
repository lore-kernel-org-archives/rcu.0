Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3FF1A08DF;
	Mon, 11 Nov 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346443; cv=fail; b=TKyI37Jutjuk76nSUO8om+UCye6vGgFkcpXkR5owhQUVdbuDKNyF8q4jksP3XuBAGLSHMvB3sZANuIXPB93vdM73BQEPwiOESwn557etXe0S8ZK5RLEP3vjPIchKGbkCLxNyzSOBhDH0tWBXyO+yGm3ThIrq3xDyYEUGggJMdZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346443; c=relaxed/simple;
	bh=Dl7YbMX3oC/tpVaXzzLB6PgDrRDt+eZvfHj8Y7eVj4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c21IxkHTpcH0Y+CIPv3hkXyTHwSkslEkxkVS6pCci0TS09MzmPfg9WpIOPZbqinr9BL+WpCJ5yHxiAp450IbRmOAb4iq3E0GUpr4+TBWp+HxxMu4D6yuWdAiiQjg1a9SN7WH49Jld8PMm3NGnkpGIrkqtkQlcpko0+yDlb6f4B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t3SlhKAJ; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t3SlhKAJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZ/Adz+sovdmqoEx2LEvIh9tSqw7c1QF2YQkPNo+HjxhlvUz2EmJBO+9eA/l3JclOnUpUL7Dt+onJfxOOPUW2obqko732jSZ4Zvyq6t4KZ2OxBbhJcXhvC9rq/vHmBIS7bpYHeu4oeiXHTM/LOWrBur10N+oSgL4cspX2ruA8O2y4AYYf9VJHnTkFFJa9N57yAz5y6FEMEO/0QU1J7vIbgw1W5ftFZueFdHD8oDExXgab2CkphgW975Db1XO8fBZye4WecYKY+GXLpEDqdH78EoqjhW8Ifgn/FkpFtIxvmKmw1zk2+6plS/sAKwllpMCIgyowU5c9zFmVQNHqO0PaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ddjSoAMvHqmwYM1AHV7IJrFsX6N2BiMDcOzaXGRWV8=;
 b=K1oabr7EBgBfjOAWa0JVDr+elnt/rSEVgk546hvn3d75VtJklryZ8t7MOOHL4NGazUm0h+K1e5EPGKjo8i7D1iLnQwnqNhKmiCK4rUQZ7ZRhh0MGc7xaH1NGStR8enc24O+y8pTMsUg6eWlS+3ulg1PFO3r53iAJCShVR5eTSvTjSO+O5xkSZKNwpS2wnI8YFtWTLPYsDDK8+A+8TufKA5Pyb9EaaQmTBimmScm3nWzW6nod2P09fpjPo/iDshBrAq25gKgOyXOUO+LB2ugaan8R23fFJE39pkj0HOgxRxLzlkhRWjATubwbuDSNfrHNxunokBTsfkFKC1/3hewCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ddjSoAMvHqmwYM1AHV7IJrFsX6N2BiMDcOzaXGRWV8=;
 b=t3SlhKAJVIn+9MU2EcgMngAso6va3F6UjlZA0A9a/9ax4q4NAoBer/WqFdBuTpJ+qhKtK5aZn8CXn1735ylKfaUork49Wxnd0BItc7FlAKrzEQIgv0XxHiNkwwY6CUG5a3ri9J2T1Wxxa6BqtNeMbcZNqsUugjLRedggEctHnl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.29; Mon, 11 Nov 2024 17:33:59 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:33:58 +0000
Message-ID: <6f51a12e-2776-47c1-a989-1188fb15aa35@amd.com>
Date: Mon, 11 Nov 2024 23:03:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] RCU NOCB for v6.13
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Uladzislau Rezki <urezki@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
References: <20241106153213.38896-1-frederic@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241106153213.38896-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e07734-6926-4dd2-4ea0-08dd02770660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0V4OU12ZkxURnd1NGVFcW1SakRmNmUzK3krK1A3MWFqcXJzYlN2WFpKekNM?=
 =?utf-8?B?WUsxVzFtYlR0ZUN0Y0FnMDdTRmk1eHlMN1IzT0dlTlBHUkU0YU9sZGVqSklK?=
 =?utf-8?B?cVBuSzFWTmE4Q0Jhd21VcmdOREpmTkJ4bUM5dHVlRFJ2Q2lSK2QrL1VER2Ji?=
 =?utf-8?B?RUVUeENPZ21YeExpU0ZDMG1Nc1BsbmdWeHU0Z21TNkN6WExJWWtpeGhyeS9T?=
 =?utf-8?B?TnQ5bWZ0U3I3VFpYazJDSVNCN013Z0RwdmR3WmRYeXYwam9Ba1A0dXF2cWtu?=
 =?utf-8?B?NEFhVUpIdXo3aXhPSHpXckVMbkNUczE0NHNJbmFVR2cvVTFMbWZaSmJGR0ZL?=
 =?utf-8?B?ZFU5RmtxY294YWZ0M3EyRDFQZ3I2Zkx4NVJoSXlCSmlEWFpVdnp3bWs2bDRw?=
 =?utf-8?B?cG01WnZPcHdJTHZFTHc5R2FONHVGdWxtd0E1UDNrNlZtdjQ2RTRsT2s2TGVy?=
 =?utf-8?B?L1d0Y254MXBtcUZmLys1MjFkbFp3Z1NsWitsemw5LzdzQ1M5UXJ2S2F1a1Jt?=
 =?utf-8?B?SndXUlRtcmFpK05QOHhBUjBqamtoU3gwN2VSNmZYRDVmR0dmS28vZHJHUHd6?=
 =?utf-8?B?UHhaeGxmRER4VkNaL3VkN3daN2FsTHVrbVo1RVhaN2JWaUw2bzhBMWRDWFdM?=
 =?utf-8?B?Z2lod1dYUmVIdVZ0a1FWeXNFUXN1Z1Z5cU05blJISzVMYTc0K0ZLcGhsMk9B?=
 =?utf-8?B?Z1Rrc1NLWmpuM1QzN3BPaFM1WXBSLzFlUDBvRjhlOVNESU5INHRvNExSQVlz?=
 =?utf-8?B?aUNFUWpKUUlpVkV5OWZIQVNEbW5zSGFObHVSM01BNWk4NU05TFVGU0trbCtk?=
 =?utf-8?B?Q1p0T0tJQkRCcUY4T2Q5SytlZ2l2b3pVK3FTZ1czRHdjNHBESFR2UzYySENP?=
 =?utf-8?B?K1lCa0V2WUNrOEhXaEVyQTJnZ0VjVkg5cktUZTdLRWYyNTBjYks5TVR0am43?=
 =?utf-8?B?dVBvekw5dE43SUJhTThXbjZoa1BQZkJLTVd2WnBadmtkZGoxVkxhWlVoNnU3?=
 =?utf-8?B?V0pQOHpTdFBadWwzbXN4djE3SHo4amxiRDdWR2E2dUs3am9sNDN0YUYyTHpn?=
 =?utf-8?B?SUxNN3k4SmV1YUd2bHltY3FqZFVxSUNnWTk3RjVLQmVCRkg1RE1lcDAwd0Vp?=
 =?utf-8?B?dWVSUUZwMDNVNitXdlROMzhpMHhVcmxKaVdwMXBZMzFqand5SU9IRi9PMHov?=
 =?utf-8?B?K1hOblpKbHJoT0tGVTQzZDZzRER4TW40SGVHS0xXL2pmbFJCcDdVRm9MbjFR?=
 =?utf-8?B?dXlORWx6QXBiK0kyRFVoM09SbkdyM0lXaEsrcS91L1NVaHRyR3dmU2lMcm9q?=
 =?utf-8?B?eFdRbEVCSmk5TkswUFY3bGlXVU14ZUJGcWY2N3BTUFZyc1BQQlpMK2hYaXpo?=
 =?utf-8?B?dGI1WnFZdFlOZFpQNThuQjdHVlpGeGdTQVZoYW10dHdGQkhucWJuYWl0Ym5h?=
 =?utf-8?B?Ylh6OTkxcVBRZVJiYm5jNUU0eE1ORDZJUXA0ZkM2MTFuTGhqMFUxdmlIYUZB?=
 =?utf-8?B?KzdTekdWQ1JWYUE5N296enBZUkpPSy9Pbk9yYmQ0eDBtR2FidmNyUXl4dFBG?=
 =?utf-8?B?cWY1UVFDY3N1Sk45dDR4YXIwNlVuWk44TFRWWTFWRHdHdE5ubjFXZi84b0tZ?=
 =?utf-8?B?QnEvV0gxNHNYdUxCcXMvbGk5MkN5dWFJbmtLZmNsSlduckNjcGlpU1FCejdw?=
 =?utf-8?B?YnJKeE1JZGlsUyt1cnBrOFEzQzVnczBYN0I5WGFjNVlyekU5RE5jVXJGOUJD?=
 =?utf-8?Q?vrsnSXT8D+UclxvxxBip9Fqvrjqv2KcEm9SGuXJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1lTY1EwUGJ4WGZEdE15ait1RjkvRDF0NFc4cnlKWTNlL1FjODZ6VTJNR09R?=
 =?utf-8?B?UE5MZEM2VWNXbE5tc2UzS0dlYURDRjlOM1AxZnp6amRMSW5rNVpRVmZGZjUv?=
 =?utf-8?B?emZUcXVFVkpJMXhPUWN0bmNlQkVhZWI2R0lIMWNmWXptdTM4dUlVeVd3WDI1?=
 =?utf-8?B?WWM0MWdVb1l1dkM2Ymg3anVzM1IxL2JvMm1xQXl1Z3p0b2V4ZnFtMlVqRFRW?=
 =?utf-8?B?NUFrVS9Wa1Vic1diSXA2eDA1c0U5ZWRPS3pCME5tN1Y0b1RlRVRhc2RNNDdY?=
 =?utf-8?B?Slh4ZzI0VkdiSk1SUXdWNXlaNWoreVI2RzB4bXY0b1RUeUpMR2xQaVRlaVV6?=
 =?utf-8?B?Y1RvdlhHTUdMU2tENDU4T3N1ZVhOdlVwRmF1aURZSGFsYWtOREErYWtZemdj?=
 =?utf-8?B?d2hMT2h6SHB1dzMyb1pYMmVndTJIMUlqc3RHS2hiWUVlQUQyZEU0V0g2ajJB?=
 =?utf-8?B?ZDlKRlJUcExkbWtBMU1ZSjl3ZzY1ZWJVN2xQVDM4cmhEQmJORWlrWU40TnlH?=
 =?utf-8?B?dm1HcmNvUkpzUnhvalF3QjJPR2s3SkNTTjZmbStSdmxvcGU5dDAvbnBmZGdq?=
 =?utf-8?B?RHJ2UXp2ZllwUlZOYk9UMnplaExOQ0NLeE5rdDNDQ1J4ZUtZRGh6NjRWcVZx?=
 =?utf-8?B?TVM5Y3dkNzd5K2h4M3l1L3hxdjhCaldhaGNtTDgvTDJKbGh2ZFhtUUZWbWFn?=
 =?utf-8?B?YVZlc0lWNjFIWXV3cjNTeGlWUzRQamN6Rm1HaStxcko2ZW9UTFdiRXNsUlZK?=
 =?utf-8?B?SHpXaGQwTm95eTBvdmtIZ0RmZ3BET1paZjFRZDV3VFFBUEJ6Y3I2VDY3b21C?=
 =?utf-8?B?cEdabTRYbUJxTkhGeE5rZ1k3QkNiekxnM0M3MUNtTENPMUlKbEloYll4RWJh?=
 =?utf-8?B?QUhTRFZFT0ZBQ2w1cThqeW9wZktlSk5sWDJHRllYaThieWNOd1NGZnF4bit3?=
 =?utf-8?B?c2tXbHh4T1VMbXZnaE85MUJRbmJJTS9TMm5kL2cyNmpjRDhUdkdTTkZTeXFK?=
 =?utf-8?B?UncyWFJqS2hxOGVXd1F6Z3NiVS9id29aMS9Ia0lXV0dSRThrR1VRTEhTM3M1?=
 =?utf-8?B?S0dIZXY0clJTL3pnc29aMGh2N3RUazZJQ0NnNXl6MmpkRlNWUnkxYThrV1Jx?=
 =?utf-8?B?N3pRU09naXZVRzRXM1RsaFpPL09Ec2ZOamJ2UElrNGZ1ZTMvR2RQbzQreVFX?=
 =?utf-8?B?OHBxMTRtOGRhUW9VR3ZwTnlxdGtyaHc1eXcxR1JVVjN5YjI2WGh3OG4zeFo2?=
 =?utf-8?B?WkhMdXR1RGxoZkZjYUxscWZXblZKSDR5bFFhY1A3ZmIyb1J5UG1lMityNEdn?=
 =?utf-8?B?MTlGTlVSSlo2WjFHSTZyVFp0dHg1UmJ1aDk1ZEZZcmNRK2VQNEdUd09zbzNt?=
 =?utf-8?B?ZHQ2YjFtdEM2Z3hHQVZ2TUp3SnlhalFxZGNtOGNnQXFEb1c5c0xBcEtYM2VT?=
 =?utf-8?B?NTFBamh1WVdiQUtMZjcyMjNMNHJVZFJ1TGJwaHlDVHNTcFkzQWdpQkNveTFi?=
 =?utf-8?B?NjZaNExVQUhrY3ROK0FROWRFN045RUJrNysrMjlWVnlWRlJrdTBpd1U0ZlJI?=
 =?utf-8?B?aG1TaStuQ1JXTisrNm5ZVm02NlE5cVViSWtXaG5YTVdFczExeDRPRDR1U01n?=
 =?utf-8?B?OWRXdy9XYXY0WEpjbWNOOXNZa0lBTXh6V3BLLzFZNGliTjZyWXNLV3V6NWVC?=
 =?utf-8?B?QWpvZGNlelBmKzRhaC9iYWFlMXFsanBGLzM2Ti9QUVRlcGw2Sk12ZnhUZlEx?=
 =?utf-8?B?V0RydVFUVzA3R2pVejFhL0xJR2dQckJNUkwvVUNQbUZHRE96L2tOZGIxalps?=
 =?utf-8?B?UmlDa0J1bXhoa3Zodms3ZlNmc2srQzdiNjNoTkZiMWJjS2MvcCtrV1k5TjRJ?=
 =?utf-8?B?NDFjd1VJcFNpMmZFb0x2dUt3TWhPOW85TTRSMlB2TU9IWFBaYVhLYTFTVFdi?=
 =?utf-8?B?Vjd0MkdtUXhvY1ZNeUNmMGs2dFlxdnMzUkF0dGI4V1drVGlCWHpMWndiYXQ3?=
 =?utf-8?B?TFJGLzFuci9OSnR6akYxVVppc2dyanE4aFlib29jNGtzRFhlTGk1eTlpS2JY?=
 =?utf-8?B?dXlVNGNla245OXNvOVlnMGNWZ3VqM1hOQk80SisrZldOMVRzZGhJK0FtR0kx?=
 =?utf-8?Q?ClEhpC1wKr2r4ofhpV5FfoLqY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e07734-6926-4dd2-4ea0-08dd02770660
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:33:58.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NIkcB+QPoeozRqTxOJffyCRv9x9Xsj0H91cfKPLiqVUOb5t+1C6rpUl+GaicJ9VDdfNCryAMWfjU/QsvkASYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

On 11/6/2024 9:02 PM, Frederic Weisbecker wrote:
> Hello,
> 
> Please find below the RCU NOCB patches targeted for the upcoming
> merge window.
> 
> Yue Haibing (1):
>   rcu: Remove unused declaration rcu_segcblist_offload()
> 
> Zqiang (1):
>   rcu/nocb: Fix missed RCU barrier on deoffloading
> 
>  kernel/rcu/rcu_segcblist.h |  1 -
>  kernel/rcu/tree_nocb.h     | 13 ++++++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> Thanks.
> 

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

- Neeraj

