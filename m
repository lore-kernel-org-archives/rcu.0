Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EA166F1B;
	Wed, 13 Nov 2024 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468139; cv=fail; b=tgBIqdWbSwg5B5MZSZXtbFbxmtt9pPWrdxGk3turK3XgJozR2pHLhhnIlN8wXFTL8rXcIC1INg8zH8A9ESrOIB5mdpi1d5N4yuVSLGm/1UkZy5FBFK5frPTYChmbzAFLd3cPTfJS4i2eUgCfs78P5RPQMxmETEyW8qIIHp32IRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468139; c=relaxed/simple;
	bh=Yxn1JY7+M4SIep1/1+v5MKvrlaX6NKZEPV8+GIkRDow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SnFXty1+E0AJoUyIAPrC0aKNyYo5GThqZFX2stiztuHqCyXTXWQUo8SxZp3/39c1BM9l44CzxHdV6PcMsBGe7PFYNTUAYXtlrLt8p2dJcquiCs8w849nTiCaUsN1VsAtNLwkVzcwd6yxIHo3Wf8TscOxtXve6Rl/Ibu5XNlBRE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5WyPffwC; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5WyPffwC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkQGnuV9VdQ8HMe/uez9Af13QHCQqKagk0mdZEIzk55LnhMR+rq2y9tfLAv7nxxTi0iZevc2+wHZXKNYwv8dWnv31Wiat8DaAMRQ+rVsz4StPgxDOFPFL9mc+gOt+/L3pG3N6OWE3vBhDeSuEaSqHkKceKNwmcHfpCARbfq2YxeZ97JDkUIUBMdJOtFW/i1KdP8N+MXQEfOcPPOYTMAwRPoNQrCoYuo60Ihj6l9QrWfNxltD3uP6b1NHR4kdg2ZfhrztrwahE1q5QLDjm4e5OJZQG99aSNCSOqPeAG6gShffOPIq8YhC38dBd1yNn+4owmkwVD4eLQ4JoBx9usUSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urr/ulcSr8NI7jTqe4wYKSqjjCe3H7uCYT7Eie7aNZU=;
 b=uxErmEQNNK9XT1puT+4M9AgYuOUkJcZY+qog0tE1KoK+nW5rHWRM/tbkvaa9jg6nBYYCKa1nAf3Yrx7kS/00XC43Fo2Z09/UKAldvZjUSO0yzKd0seDgwv307WUaRwlR2D4exUS8XrVHoMU2oNOnRz3UYkrNKToZUTpz/p6IxBk6IECy7eR5Pvhi6wxHt6PFNg9Mr0U33m/Kz0zhe+oWGRZpYVOhgEX+Tp9Y9UqDzlLeyGatYRTJnKkPDbYIeLaYnRlX6roLbnvsUOy4pgsow5c6iloRLm8u4AnY3/RcQFviYPZ9mGAjmKt9T/q2YAp8cOZUs6HjCESFeRAHTMA57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urr/ulcSr8NI7jTqe4wYKSqjjCe3H7uCYT7Eie7aNZU=;
 b=5WyPffwCT0D17iQtcBMVX+nT+k/l74OrxgQ9wJzU/qwGjMbCAJhQ1hmasMfSyU/VPS6Det1zX9r5f7B3hVnKKVapUmiWoTS80DyCV32jGMwkhkoaGHxQLnzmZKW0RIgHdrykqwJRNdqbz2wU9Gj1vvlQrO5n2mM9oDuWn+k2qMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 03:22:15 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 03:22:15 +0000
Message-ID: <871708a9-52ee-471c-b36b-35209827d8c7@amd.com>
Date: Wed, 13 Nov 2024 08:52:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rcu/nocb: Fix missed RCU barrier on deoffloading
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zqiang <qiang.zhang1211@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Uladzislau Rezki <urezki@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20241106153213.38896-1-frederic@kernel.org>
 <20241106153213.38896-3-frederic@kernel.org>
 <68c39e33-6281-4978-ba4e-131c6336aa7e@amd.com>
 <ZzPKlujDt20gMkY3@pavilion.home>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <ZzPKlujDt20gMkY3@pavilion.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: e02239e2-a81a-4d40-329d-08dd03925f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTZjdUYzUWU1QmFCVDlmakdra1dkS3k1V0IxS1F1UmhVV3dZM3NuWEFndXlr?=
 =?utf-8?B?aUltZ1hTZXlBRVdvMXhTRmJaOXhhM2FIQVN0QkJGejQxWFprbzZKd0dhbGNX?=
 =?utf-8?B?bDlQcWZFNmFyNWdGUVFFZFJrZzBtMnQ0TzZKaDlMbGJVV0d3UG1YRXk2amps?=
 =?utf-8?B?NzlURDlrL2lZTmUzRVkyb3V3Z01XQXZGTXJTMlhTUTZYaWVoYnVuZWR5SFdG?=
 =?utf-8?B?NS9GS2lKUVgvNjR4RWlLcWdsdEtBeXBRVjhIYSs0QkFWN25iWERKK0dxSno3?=
 =?utf-8?B?QVQ1bEthYjZVTlZDOWZsWHlDWWpkSVZhTzRjRGd4WXBSSDk0U0VFekRxaUdq?=
 =?utf-8?B?YWZnQWZndGNENkxvUDVGRURya0N1UW1STGJPYUV2ZXMrbG1TV3M0Z3hIOXNM?=
 =?utf-8?B?RittQTZRcUNRdlJnZnBGY3dDUG5pdVdKZVA3d00vRGt6Y1lLQWhDT29yZnJU?=
 =?utf-8?B?YzBwOXY5QUs1YmlTamthQzJPMXZCRDEvVFo2Zld5YWQyTU9RT3FaSmJSYURK?=
 =?utf-8?B?dGlhM0wyZlRRK0ZZOWRFcGZ5T3NITUthK2VmaXpFMnpRcHN1aVNYd3pDeVRS?=
 =?utf-8?B?ZENPUzhaVnZXdHpJdE5JV3o2ZlVaSE8yWDBSUUFGaGZwR2UyaFl2U3ZqNlNK?=
 =?utf-8?B?VHgvL3hKVGZDcktvYTB1N1BTQVN2WU9meWFuSUc5NEY3OXFwcERDMnVPcnRQ?=
 =?utf-8?B?MjYyUTVxT3g0b0hUMEpVci9TWEcvamJZbFhlbmdnZEdHMnJmME56UktVOXZu?=
 =?utf-8?B?N3IzZjl5ZnZEYWk1SWhzL3IvZW9FZTZmdi8wWmdDbm9zblh6VTY3ZHM2RFhV?=
 =?utf-8?B?SGV2WnZKRUtGWitBZjYvay9qNStRczVDT0JYV3NGM1FVbUpzQ0VJSEJ3OGk3?=
 =?utf-8?B?c2JHUHdFOEhKMEdjNmNRbVlXSk4zVGFhUjNacnBKM3ZZeFd2UnVnMHZpOFJi?=
 =?utf-8?B?MGpaZWhaM3k5UXRiYkgvK242M01BTDNwc3BrQk85NzdiQ0FwYlZ1ZFJxR3lu?=
 =?utf-8?B?bDhtcjF0Z253Um5SQ25sWXNmVjQ0Ly9CcXc1NHpIWGhlYm1IRlRnenl4MnZm?=
 =?utf-8?B?S2xtdjRNUUtUYlR5cERwMGJNYjZpMklacXRGcWgyUFNCOHRnWDU0Qzg3TXRY?=
 =?utf-8?B?dzhFV25XZ0xyMkw1THpIa1kyQkI4aGRMbmJCd0RObGVlWHoyK01USUljVHda?=
 =?utf-8?B?RmRBNHhtUVVVZ1pmWW5vOThab05zNnlwWjJpTlphSGluVld2STQyblprTVZG?=
 =?utf-8?B?Tm43aWJZMG1nZm1nSS9KLzg1TFJyZUlzc1V1MlpGejN0dThPVEhmeUJYY2Fp?=
 =?utf-8?B?bzkrNmxXUUp4MkEyTkZ2dFFJamNGeTFsZEc3QlkxWDdVMTB1a1p5bUVxeTBW?=
 =?utf-8?B?WmVPQ3FCNWVxWnhpeHJZcW9GdjgzSEx5RFk4Z01rQ3NIbUxNQU0wdWx3RFY4?=
 =?utf-8?B?SHl1QnhkakxjOGVkUHJ1ang0M2JIb1JuaWd0K3V0YnljMjY3NytldTNMbzJG?=
 =?utf-8?B?QUpNeW1rZEtLYUJORzU4Z2JiSzFHa3l4dG8zNTJscThvZUllMlhlUEJ1dVFQ?=
 =?utf-8?B?Ymk0UnVLNXVENENScUJIbWhBZDdLVW9Ocmh2a1JNanpaN0pZSEhYdG9kRjBH?=
 =?utf-8?B?dzg0SHFhZVZrcGtYaTJzVkZEMzRXWVhQOVF0Q0x0TE5xajNDRDE5MFFKdVVD?=
 =?utf-8?B?THBxREZya3RveU81Z1liK2VmTWtEWDUxWG9iV3Frdi9FVFRhT2l1SW9XN0FC?=
 =?utf-8?Q?DVCerIhHk9YERFhJ2aG+E2h9mL0Dm1eH8ZbXgl4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3FPek80ZmlWd1B3ZXEwcUloSzNpU28zVmJlUlF6b2lJek1LUFlKb0lZTlFB?=
 =?utf-8?B?SWVKOGhKNzFYMHozcjBYcldDSDJLQU03bGFJbzRVRFZNRHRTZGNkSnZ1NWdr?=
 =?utf-8?B?Zkp2WTdmWDQrZDJvUTcvSjBLWHRZY3lCMjEyOXkxcVBBdTdqN2doYmZKMEtS?=
 =?utf-8?B?b3hVL0xrVzllY1VpeVp5NkNjWUwzTVpRcWtnam1PMDdqWDRRQmphNzhraldP?=
 =?utf-8?B?bURlWnpCeHl6OER4cThlUmh3MzV0bnlxTmtFSU1mUFA0NnZDVkFwalIyeHZu?=
 =?utf-8?B?c0M1NzF6TWkrbHRTNDhzQlJQRzFGcHBqQnowRVQ3T3ZtTTdYSDEwUnVsaUFz?=
 =?utf-8?B?OTMrTno5L051VmpxWGpob3kyN0k5dW4xSjB4ZENxZFZ5cUJHYnJDcHFsRUJS?=
 =?utf-8?B?Wkw3N1I2Smo2aUtWdDUybGlibTJzazdEM3Z5VjU0S241WWZWMll5ZUlHRWJO?=
 =?utf-8?B?WUF1Mm1Qd1AvQ3pmTFliYjhPd1F5THhodnY1Q0JDVE14bmJwem56S3RFazA3?=
 =?utf-8?B?VWtPeDJMUnlleUVIczN0aElkUGhVMllIMjBscjZVMGZ4MUZYbmd1ekZDY0tl?=
 =?utf-8?B?cjRXVit3NlZXOTNOK25NL3Z0YWQvUkxSL0tiTG5tSzhic3ZVRWpieENzV2VO?=
 =?utf-8?B?bUJveEgxWStSZHY0WFY3NFh5b1E2YWc4L002QkNnU3lOWUJHODBLcUJMRGty?=
 =?utf-8?B?bVFINXlZYU9oNjFjQWRxK21xc2c1TFYzWnpDSXdiTVp1VVMraEtvQ0EyNXZh?=
 =?utf-8?B?MndjMGtOQVRBR2l0WmlyZ3RydWVsUXkzdVpCRE5VdFBTa2xqSFNMdGZKTVRL?=
 =?utf-8?B?TzdEWEVpTVNuOU1Td3J3dVdzSzVCMjhhUDZOMlI2cG44a1N6M3pkSUQzOXNB?=
 =?utf-8?B?cEk5cmRZditZMDV4QXZ2YXhCSWI1MjE3bS92R2hCU1Z0ZzZ5NjFkZkltamFZ?=
 =?utf-8?B?SWFyck1XeVRhc1lHNTFuNngvMjB0cy93Q0V2TGJ3NlFqZ1BydEtxSWtjVFRz?=
 =?utf-8?B?Q21CQXprOTdCeXMreTJ0RlRUUmJZZkZkallsKzZCdmRCVVFqUDR0dGhEUlpn?=
 =?utf-8?B?TmdMbkNubnNrU3RzVlJRM1VjWmhWVDZUMzhPZnNpaWpBc2FDUTlUdFArZThW?=
 =?utf-8?B?dk8zMlp3NkNVeC9uSUhha1p4di9xTFpMZWRERXh4RUsvTWVybmVJTStDWWdQ?=
 =?utf-8?B?S2swaDVsSUljYlRQK216RlpIREl5emNhVlJDTzk3SDFpZVhRK3M1bkpEREJE?=
 =?utf-8?B?SE5pRUxFa0lDNURyTi9hSGFlYnI2cm9RbHcvOWZUZnJCU3VLa1JFQytOQmIr?=
 =?utf-8?B?bjM2MGZvcForWCtKS1A4RGlTVGcySjJML09pZ3JLVnlpdmdBVkkyTlQzdTFn?=
 =?utf-8?B?SkxEQ0dSRE9pSEtlbmVqWFlRTU1OVzcyR3hFTnZLOVZvQ0Q1ODZ4RHFOcSta?=
 =?utf-8?B?eG9hR3o1ODZpcWtNNlQ1Y2JicCtJV05aVFBFMVVGRFNjd294ajAwalNpelJS?=
 =?utf-8?B?MlNmbzZCc1F1VDhVK1pyaUN2SnJUS2pjUHBDSjhCeDYwOXZONWF3MDB3NEN4?=
 =?utf-8?B?aUJOazJTSkltN0dtUkdFZU42NWhRUGJjSGZ6TDNZajErWFNiK1I5cVdzeUIx?=
 =?utf-8?B?WDhJbmxqUDlsK0FlR08weXloQU1KbzZHQmRtZVRnTmowZ0RGTm5EQm1pclhp?=
 =?utf-8?B?bkZ6aEE5aWQ5UTZhdnlVRUVaZlgyNXB6RVNXSlFTVzFwU0ZENVV1V0c0bnhu?=
 =?utf-8?B?VXY5RDVjWGJFTkRzVFl2c1dlUDlCUFVmTll1YlBXYUdocG1aYloydGl4d0hl?=
 =?utf-8?B?aEoyL0hkZGhNTDRreVNJZDVnck5lSlAyWWFHcWFmNTcrSldSRnYwcndMQVpM?=
 =?utf-8?B?ak9RT1QrVVhUQzBIT2tMYktJYUwyRFN0akpxSXN4Sy9hMmtiaURPdGdqYXBn?=
 =?utf-8?B?WDNaVWJLODhMRWNBZENHTXFQWHNNRW1Ib01sZndVaXdUcXhIUzczdmluU2Jp?=
 =?utf-8?B?WnNXRk9CSklzUWJNTndpb2dkWVZCZmpFQzY3N2Zic01MMzFnSkYyMFkxQm1O?=
 =?utf-8?B?TUhFTXhnMGNGZ0hlcjZOQUFsMFBkOXVweU1NeE9BUlVjSE1IcERYUjhMMUdn?=
 =?utf-8?Q?mUfN1O9mNQpIzDZ1Evq/OJQ/Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02239e2-a81a-4d40-329d-08dd03925f02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 03:22:15.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GivO351GEpvl37Ilg8DBEnkU5Rrii7wk52MTRJdTbEH/hmy8E+oiTi3knzi6GLcHs6iIzSgN3EvuzTQ8mAHpSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156



On 11/13/2024 3:07 AM, Frederic Weisbecker wrote:
> Le Mon, Nov 11, 2024 at 01:07:16PM +0530, Neeraj Upadhyay a écrit :
>>
>>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>>> index 16865475120b..2605dd234a13 100644
>>> --- a/kernel/rcu/tree_nocb.h
>>> +++ b/kernel/rcu/tree_nocb.h
>>> @@ -891,7 +891,18 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>>>  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
>>>  					    nocb_cb_wait_cond(rdp));
>>>  	if (kthread_should_park()) {
>>> -		kthread_parkme();
>>> +		/*
>>> +		 * kthread_park() must be preceded by an rcu_barrier().
>>> +		 * But yet another rcu_barrier() might have sneaked in between
>>> +		 * the barrier callback execution and the callbacks counter
>>> +		 * decrement.
>>> +		 */
>>> +		if (rdp->nocb_cb_sleep) {
>>
>> Is READ_ONCE() not required here?
> 
> No because it can't be written concurrently at this point. The value observed
> here if kthread_should_park() must have been written locally on the previous
> call to nocb_cb_wait().
> 

Ok, got it. I was not aware of any other flow (other than the one described in
this fix) which can race with it. So, asked.



- Neeraj
