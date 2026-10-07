Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020115.outbound.protection.outlook.com [52.101.189.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FB2877DE;
	Wed,  7 Oct 2026 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356976; cv=fail; b=gGP98sGVs+UOV1yEfkAQN+XmVACrUc4fL3HwzJuZquuw0WAcV2F12V7SAQX8Qy+vXG7gqrluH0efmIXY/CeNqH759LKJl+9lx6JnV6MMFujUv3oOgbawShJ/FmxZNyJ7uVZf1K9cnsWRlhDE6UCLiDq4iFGGp2MP9hqS1y9qR4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356976; c=relaxed/simple;
	bh=NLyzmz//dQ6Pibd1gVTD8ANQWVdAAd+93wL00lqACaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nkX+zpjOg2RxHra5kG1meUlh80g7cN/H95CbiUKm54nqxgHHmoJxV/57NqSTn6U8FhkeojeHQNEW7useeHrXvht7rotc5JWbvK0NFcjY4BQkELYhcXn5niRrG3q8FkAqKuCV1xoI9EpShxQ7aJLPkpyk1chyhB3cLkf7OBjNrO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nZkKrw8p; arc=fail smtp.client-ip=52.101.189.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nZkKrw8p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJKFMCgyxQspdtscQ7yy2ENYmBLr+YoZY/eOJAa/jurPWwVajf+dzhyHtuYEsjmyNnGdDZfIB5w33puteeGuNrj2+UT6F8Jc5Y6KRN/Sw56khtvLiIw/7Zk6NGurY4h6bYhxRVw2d5Ae5FUPK37+01ML3OMt3dZe4+1FvboeMsrz9Nzx7sKx3nhC6f+Ki2i/ds+pQgmL6Q94TQNE6SxmidLV4YwiFrefTtK+K7JAdyQbB6/rCbAbQNImeeduFKRmmRxe0tDBtIj6ffgUyMjF8yVYCZCxbWgpL8P5m0XZVQNh2hQvId6FAR/gMRDzEbrjOSUFgCaCZB7TbSkQwhpJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSa3x5gEUyQLpiIs81tyvT1YxO3O56f+uXI2fWXmoHs=;
 b=O6nkek8oQ1k2O6Pry50Pns5NxfxQWpCkPbnYeei3AWc5cbf8T6b8Qk0iqcFbe062ofEcj9S5wGBGLHzfxvCjFB97tSN9DB6WHyPo+vzodCEEqrTn1ly+hmc9oEtbepd7JST7jNT5ZLzDqLz9hxP/EGttTy/dFVkQrVh3GdNV0YJ/dUvIl4i/EIqTdWEs8Lesrm7JRXfTNE/HzHG4iY2RXWar3EjLknTEfK1WE0ARvr5Sfdu3EkvQgpd1ViroUJ4PAGiqmUV/OsR6EW9/8w73lDK+UN6ALmc6VIgknESREh5xcaP7HFUXHv3EsMYbucxHZsElXvXN8oJmMwGPpANIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSa3x5gEUyQLpiIs81tyvT1YxO3O56f+uXI2fWXmoHs=;
 b=nZkKrw8pRqn0aoWPyIzAdIOwH5AP1h0+rfiZR6+Cyvvyq4VkcPrOnsIWHjw8Zqdw8Qw4EzivP85kHUpzPX3aFkKvl3D+0SHjj+lO/A+rsNabQVgG9OI7xucwZuJ2Qse5+Mr7UnG89k1PDRyqpSaG3INmmcAxlS+bkfLR/7nfmKRbau+2Y4cy3eEG5gnNRMxqLqFuYNij+YlRu60hXpHnap468Cej4s0l7l4Pmqzg8D4bSTdg2m910GOBPx6ppuoHikuo80RLEv0SNtBtXp4L3oTIhvZGJmIAEXMfPCcEXOeP24XFV+34hmmVzfOxKr1RqIqzG7sk/ixsavf0QwixrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB11721.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:169::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 07:09:32 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 07:09:31 +0000
Message-ID: <5b5dbb90-69ad-4a8f-8583-f5ba162744d3@efficios.com>
Date: Wed, 7 Oct 2026 03:09:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Splat during modest hazptrtorture run
To: paulmck@kernel.org
Cc: Boqun Feng <boqun@kernel.org>, Kunwu Chan <kunwu.chan@gmail.com>,
 Wang Lian <lianux.mm@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Bradley Morgan <brads@mainlining.org>, rcu@vger.kernel.org,
 lkmm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <1f885062-4905-4d9c-9293-615c145d2d6b@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <1f885062-4905-4d9c-9293-615c145d2d6b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::8) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB11721:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d53087-e62f-425d-261d-08df2441ef60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7XmwoZ064E8/GY5LExWBaIhKuh36wOdqzkooii4p7NzxMfItV0i/D+u5QfIxhTUixbIh1MXmCVdkUlf6LE1ScfNqNFbplHpDIC2PwTkeLlrjDpDSudfk9zjrGMXfxEaLY7Rgp2xK90yk17QLgLEjlr3alKMBJsfM4UMBTIwVjxFz4ZVTDtO/wOdoflzjjelaaxHDT4TECLaBAdRyoThf8ZE1xjJ4Lw1C3GdhoKXO7ahxtEbT5FalOMhKhW3fLLkHQASbdJZ22Vnxj4x4NxtBt6rfqOOzm/Gn6R2npJS1g5H4JDNzvESdI+ClP0eXSH7/15Rz6j32Avgg1YjoEXZSapBnvYrHwmp5IVMXIKtZ9USuxaSKCfCXtrA8Wab4/5t4rdXhORbo7Bm0LRArwuCZfj3g9ZqHwzZbG50GIwVPPFSBifowo7PVHNT0AwNAA64scpNFo2LBznMd6OyYMzmdePlc2m5XUDdjyAUFeD4P5RrWJGIACOrdVjjnwxN1B+mFPcUmYGJTd2uIF/5rzXvF6T183sdqLtX+69H5FNmnVsvbYfET/2k1AZPDd9gWaIv62DMqsp7LCKAwH+0bhCTkJUScKB5ZF6HQJqyBr7oe9oY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDVuMS9pOUd0SzZUbkx3Yi9aVHh5b0xNcVducVRuM0hHWEVqVFJEdGpxNXhy?=
 =?utf-8?B?Tk1lQTJpalN5c3IyMVY1TWdFMkJ3VVJ6TWpNbkFPS20rcFBPN1RKcDVCcjNJ?=
 =?utf-8?B?VllxdHQ4ZGdGZlF3L2FoYUJ4SDc0bmc5VGtYek85T0o2OC9ERUlZdldyWE5u?=
 =?utf-8?B?UmxiUTQ2UFU1NENFRmdjU2syaHdzYjFEbk8zejR6eUZVN1A1QkRScU9CeXpY?=
 =?utf-8?B?b0dCdVNCanFaRTBuZW94QlVMV3UvalJLejRiZ05Ma2l5TUdZd2VWOXBvT3c0?=
 =?utf-8?B?VXpnUW9qSDRxM2NrdXlYRmlxVk5WMWVyT1Y4WHdycGR3QnBkQjRYUlZiTmlI?=
 =?utf-8?B?RVQ1bmNHbzdZNUxxLy9zeXd6K2xtT1Y2a005Mnp2WE5takN0N0c5ZWxyeDlt?=
 =?utf-8?B?TDZuVGxENytVUjVoNFNqakxSdmZVT0ZET2dKUDA2a1JTTFZhczFRdGFlRHBK?=
 =?utf-8?B?QmYvU05XbWhSQlBPMDRmVm1MTjd6S0RnL3dMdFlaazczYVpXTkFhYnBlRjQ1?=
 =?utf-8?B?ZThsRmx2Zlo2OHFOTFlOVGNLVDRBWi93bHlJZzViQWt2a2pGcDBJZ2tIU0t4?=
 =?utf-8?B?UGRnWkRGSkk1ZjJvaW5qRVBDQWp5bWg0bTY4TjF4cGg5NzI0NEpJdk9ET3FL?=
 =?utf-8?B?bjRjZUxYSFVnaVRQQWtwekMvbVVpWXdZTHMzbHhwdU1Wems5U3QyWmJ3QXhM?=
 =?utf-8?B?WXdkb1VQOCtCNGg3SnR4RlMwM1g0V2JPYjRMV2dGVWxqWW9wblVWSFNVTWtF?=
 =?utf-8?B?cXRXdE5oK3dweWozVFlzN1oyNGxSc09ockpDSmRuU0VqbllzLytCMW45NElY?=
 =?utf-8?B?TEJ2TTJiR3pRZEJLTXpyNVZGZDAzY3cxbVRKRDA3TlpaZDFvY2I0VTcyZUNU?=
 =?utf-8?B?cjZrWEhydEZmM1AzZmtIRTBIdDgva0oya0I0NDBCd2h0NVJUVDVrb1ZGZGE4?=
 =?utf-8?B?YkN4WlNjSFpKNDNDVXRvbVc0UVYwbW9uclllUEFJU1Z1TjRyWXd1NTZET1pG?=
 =?utf-8?B?L1huMzI2dGtxckNSbEpxbm1ET2ppTy91RVJjZ2s3N240dU1YMzFGTFJsV3E5?=
 =?utf-8?B?cU1uNCtNb24wRCt6T1NKdHovYzhUYW9UOWlhTGc1T0xVZGliV2F1eElUNWZQ?=
 =?utf-8?B?bGY2RitIbk5YSWNRWUxPTURVdWlwWlgxK3ZMUVlTTDhHbDFIbUNoTnBEdCtq?=
 =?utf-8?B?aldSaUdDZ00vSGdIVkc0dWVVdm5TYmI1NVMzdUNYL2UxV015dVBGZVJXSnQ1?=
 =?utf-8?B?RDNtTDR3dHN1K2JCbkU1T0NSbHVjS2hsSmtzUTJpUGFTM1dBNXYvRTBIejUx?=
 =?utf-8?B?eURaNXdUc3J6SC9mcGRLd2xZQUIrVEJVN2xTNU1ERlIrMUF6R0E0M0N0eEor?=
 =?utf-8?B?cVlJdFBTOWdLdEpjRFk0ZGp2ait4MHNlakZXYmlDN01wS0NrS1Nuc0MrNE5r?=
 =?utf-8?B?WitxUDJQWGNXNGZPbUdFYWRDcUhjNnA5Zm1QUlcwaG9sTENEVUh4UVVkdUJh?=
 =?utf-8?B?bU5lQW4xa0p0UlFLWHcxaFlTaXlyRHhqTkNJc3BHdjF6VWpKNDcyOEkvVXRF?=
 =?utf-8?B?OG81V0dtRFkwQ08vNWNUcDZsMjBiUHJMMGJDVStLalFzajJySW5BUWYwa3d2?=
 =?utf-8?B?Z1Y1ZXBFa01HNUg0c0hKVDZ1amI3akw5UlorZ2lwbDJNdVpSVDA3Rk9nSmRQ?=
 =?utf-8?B?Yk96RmVUWFJTWXNWdkE5dE9NbWZrNUtnNXpQbVJ1RWdFZ0xoSitUbGdXa0k4?=
 =?utf-8?B?bFpBUWRjL2w5NDkvSHhiTnVHbStjWnVCa3g1MWJWMGhXaFllYy8wOUpKWHFj?=
 =?utf-8?B?WkxTQXlhR0hoRFNrVUhsL1FUMXFFMnQ2Z0pvdnM2NnVZOVBiZlQ4Y3l1TUpB?=
 =?utf-8?B?UGEwc1FlMDBNOHZMWFB3NEFoQ2RmbmFzc211YmVwd2JRWGxKMEVISFdUbnYw?=
 =?utf-8?B?WDZoVy9QT3BIQ2NjUHI0WStTclFIRDVaTFFwQTF3Qkwwa0RKOTlLNmJtN1I0?=
 =?utf-8?B?WHo1bzg4UzdPdytERHpFQXVKY2dkcG5BY3FodGU3QUZscGJhd25LMC9jS3J5?=
 =?utf-8?B?SWtKVFRoRTNoYUNySEVyZ25qanEwSldIR09WcU9MRGErOWpuWm1YMEpvYkR6?=
 =?utf-8?B?aDNibW1ZRGJtcGVGVFNabFRXQTJ1NnVUZTNPWUR2VVk2WFRiUkROYWRZQmE0?=
 =?utf-8?B?N1MyTTh0Z3BkQmZoK3pNWkFYZE9aOXlpN3JLakdlckxSMjg1djZZRjRxQ0lC?=
 =?utf-8?B?MHVqNm5JVDdBd1RCVFR1YkRzVm1aMEZzNDg5S3NYS1R3SUtKeDhEbkdiZzN0?=
 =?utf-8?B?L1A3Q3Q0bXNEczljSEp2WFh6MkZqSnlOME5RRzNXU3BZQUhneU9YVHh3K0dR?=
 =?utf-8?Q?dpdpmzvdwDWqaD5k=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d53087-e62f-425d-261d-08df2441ef60
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:09:31.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSKx1v1tizRLgOXxsFeFmmOvLbk43v6tHjq6e9xbeB/RpcjB1Dd/d1Nxq5l4ZfQocOKIHpkA6WUogs1O5FwGnr4UFYMtJnY8DqpvRpF76zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB11721

On 2026-10-06 19:40, Paul E. McKenney wrote:
> Hello!
> 
> This is all new code, so the bug could be anywhere.  So you all need
> to know.  ;-)
> 
> I got this from the NOPREEMPT variant of hazptr during a nominal
> "--duration 60" run of torture.sh on x86 with the guest OS split across
> two NUMA nodes:
> 
> [  137.765104] WARNING: kernel/rcu/hazptrtorture.c:658 at hazptr_torture_stats_print+0x25b/0x4f0, CPU#1: hazptr_torture_/136
> [  137.768647] Modules linked in:
> [  137.768891] CPU: 1 UID: 0 PID: 136 Comm: hazptr_torture_ Not tainted 7.3.0-rc5-00661-ga1f1e4890d1d-dirty #193 PREEMPTLAZY
> [  137.769683] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-6.el9 11/05/2023
> [  137.770319] RIP: 0010:hazptr_torture_stats_print+0x25b/0x4f0
> [  137.770735] Code: 48 83 c4 20 e8 86 44 fe ff 41 83 fd 01 7e 23 48 c7 c6 6e 85 17 b0 48 c7 c7 db 27 17 b0 e8 6d 44 fe ff f0 ff 05 76 6e 0a 02 90 <0f> 0b 90 4c 8b 64 24 70 48 c7 c7 73 85 17 b0 e8 51 44 fe ff 48 8b
> [  137.772061] RSP: 0018:ffffa738004ffdf0 EFLAGS: 00010202
> [  137.772435] RAX: 0000000000000004 RBX: ffffa738004ffe08 RCX: 0000000000000027
> [  137.772950] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> [  137.773455] RBP: ffffa738004ffe60 R08: 4000000000001236 R09: ffffffffb01727df
> [  137.773980] R10: 0000000020212121 R11: 0000000020212121 R12: 0000000000000000
> [  137.774479] R13: 0000000000000002 R14: 000000000002ffd6 R15: 0000000000034f03
> [  137.775000] FS:  0000000000000000(0000) GS:ffff999c2e502000(0000) knlGS:0000000000000000
> [  137.775578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  137.776001] CR2: 0000000000000000 CR3: 0000000008830000 CR4: 00000000000006f0
> [  137.776512] Call Trace:
> [  137.776700]  <TASK>
> [  137.776863]  ? __pfx_hazptr_torture_stats+0x10/0x10
> [  137.777207]  hazptr_torture_stats+0x25/0x70
> [  137.777508]  kthread+0xd9/0x110
> [  137.777751]  ? __pfx_kthread+0x10/0x10
> [  137.778017]  ret_from_fork+0x1bd/0x220
> [  137.778285]  ? __pfx_kthread+0x10/0x10
> [  137.778560]  ret_from_fork_asm+0x1a/0x30
> [  137.778849]  </TASK>
> [  137.779007] ---[ end trace 0000000000000000 ]---
> 
> I have not yet seen this during a PREEMPT run.  Line 658 of
> hazptrtorture.c is the WARN_ON_ONCE() below:
> 
> 	if (i > 1) {
> 		pr_cont("%s", "!!! ");
> 		atomic_inc(&n_hazptr_torture_error);
> 		WARN_ON_ONCE(i > 1); // Too-short grace period
> 	}
> 
> Any thoughts on what might be causing this?

Hi Paul!

Can you share which tree and branch (commit) this is running ?

Does it include my fix from this series ? That would be patch 1 of:

https://lore.kernel.org/lkml/20260927155134.4740-1-mathieu.desnoyers@efficios.com/

Does it run the additional series from Kunwu Chan found at
https://lore.kernel.org/lkml/20261002170847.3653663-1-kunwu.chan@gmail.com/ ?

Thanks,

Mathieu

> 
> For that matter, can anyone else reproduce this?
> 
> 								Thanx, Paul


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
