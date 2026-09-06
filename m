Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022102.outbound.protection.outlook.com [40.107.193.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A031355B;
	Sun,  6 Sep 2026 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700204; cv=fail; b=gSl7xt8Y+13/aOdPWdNK2obPqh5SS5iBXSnXNucz4HesJ4V4yC1P+mxnRuvgi8dKio2/eBxTNdHTjsGUgS+FTt6SgjLegVJX3xDvLWAmXOjf0/U2LDY2Pxg1dyAJac2mUNfxUcrcTLBYbr/J7ImU8jnzy+YxzG1QhpLraebklgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700204; c=relaxed/simple;
	bh=0Q/v1/3lO+0+6pQZfhXywMWX3B9nrrKc/nPct8Wluo4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vBM2+/x4zh4NMU34JpvKMmDA3bV2J0b2AlKToqGLVBYDmgvyLDE5517+3U+l2bTbOKMhe2gX33Y7bMbKabZREHWFonNZjIx3nakStntSEbF9YUtn76bpUpOsK+q0gsWTSQJTY9zzedtVuRu/yBDXZ+pCNVprnrihqi122TnPDgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UC0m9Cy9; arc=fail smtp.client-ip=40.107.193.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UC0m9Cy9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeVuZAWfMf2L2aS6z1JQMYxIfikAYh/IuEZlR06KxbzC0uIcDAC+gAAyO2JmXBLGHW/iRmEwDlzvbT3gp4Jnlu3AUFS/UEZJXebRomsB4sT36ss3DMU1MJfmPqSbO7J6nvcXbSuhVE+4f8awNyX6CgkZXh9kwstXrBLaGqSlA721j5Vbqv2LZtIgN9Y16qCxebd3FhfRxVxzkTSWK8hQHx9KE2239I9mwO4O9266DmKQV3INlUaZBbooZG/f4XHWQ2TcAv9yhpz6P9gIrIie5okJOGoPT+BRdwI7jjAXXCGmTXS1J2wwqLtNxph3gsnORjK2D9U+Hb9mD1TKKcgJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MdVUEGiR6DIgTQj+tLgtGmCek0X05J9woYdZIa8Wtw=;
 b=oApJ4KP/3qa4sA0pgNtZhx9apJAp93GGVpJGwGrNW6WJsKcCByy7AykXliMIPVba0EycMLwtEi5CWzYJzDqpEWJ41hE73DQcEJHzoBJyCW3EsFtD3IArJCra1nIG9Bt0EAqIm/She/oMeWCrlR4/No6Fz0Nw2yTnnLCDLtiCbelQKCfBdp7rcXdbbZ/q68NQtGTFcSthBIuHelV9mt1i8uPTgEWtZelv/ReZNJtk9b/FcLopSB/88kv7DMCULdfOfh0zng6Ryio4XWaCUu7iKvvIsFRvQzqBNnedl158NaSbSI7rF1O0r573EnnqcFFVa9btv58SihnWG2cgfupZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MdVUEGiR6DIgTQj+tLgtGmCek0X05J9woYdZIa8Wtw=;
 b=UC0m9Cy9vvRWzwXuwonQV5U53Hkupxb0P29x5od8POxvK49/IquASDEz/rmbZUR5jJVfp7i6k67tA92H8ByCz8vcJsszuoNQPPu1mv4/lOcV6XF3XN39JidcLQh2Hxq1F0uNdp7EXcFQ33mPmQvW8TpwrRwFjjtst0OUb5j0gO4gHUDWbjtypGbIde6/AjnjeGSqDe6LwbsXNF6bhoEBNYp3ItGiX8AYm0KX68lb62S+wz3R4KrEBPbcvArAyZuUUU6Sa1QzfMJnhiK4MIiivqn8cAjwbeOqdmZvOQBmaSaZsht3RbcmsqZivc49f7Ttkmz8w4Y5Rsw5Ndlbe7XdbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB11331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:124::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 13:09:55 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 13:09:54 +0000
Message-ID: <28838ba4-8618-45d0-9994-3efee251bce2@efficios.com>
Date: Sun, 6 Sep 2026 09:09:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hazptrtorture: Fix inverted sleep condition in do_pending
 kthread
To: paulmck@kernel.org, Bradley Morgan <brads@mainlining.org>
Cc: boqun@kernel.org, frederic@kernel.org, include@grrlz.net,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
 qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
 urezki@gmail.com
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop>
 <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org>
 <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0342.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::11) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: 578005d6-8e91-49e3-e749-08df0c1824dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mwcgjIX2ayDaWTJa/FGHvkMbM6J5w4lW/V2GuIVM3RcYfTTp68jNzEHXF80pdemVd5bVVcJODbhJt3ZMm/jHJMCLVtouY8zOO1qOlo/M1PV8SnfbiEzBcx3BpHuhVk0V47sAhTnxDbT/QcZ12kGPWT9e5/m+GdLAV5It89z1YJA7ETJys29Gs8Eumhfqv0yh1oFF0g73eiD5piT6+g6dPjriB4CYMca25fGyCfTRU36uUmNdIS6O7r1BpIZfzsj6XAk5/L03BkIMFS0wba7KUHeUuqYkVoAklNeKNHm+NwRxV6n5HAT94OjNmgg0RvQrCk8AXPK/u2zIHei0UmPa8cuujhxKOptz99JXAZp0WZ8cqy2OzIBuBr8r36HEVGAJm1F5d51Ar65DhaPLcUSSti1vhLg2sH7b9krsfSFIHkBWTKrs8dyVy0jyo8/mtx2wv4uMkwzUhQGSM2IP/xgRcN+ECm1khV2odTsQ7zSvb9QXyxYWw/DHe0MmHs5cdPqI2BzqJUX9qsNQ8dNUd5YvrH2ukZAoYU9/G/C6hNqPpcRKfnhCyauYZGh7KY8SS1Nc0tIiI+urmpxeBYyNeRuueBvKzPeDV+PIRPN8EfLQ7F0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVpQc1VIeVV0Myt5Sk9iMk1hQnhzYkNKYUxrOWhYbnU5TVFJWmt6OTVFaVBC?=
 =?utf-8?B?NmphNTdPbnV0TnpVWC8wRTlRMW5RNnMrWnNVNFF0MCs2ajM4M2ZMY29PaTZp?=
 =?utf-8?B?Nld0TmRnL2EyUnZxMGVHS3o0aWZMTE5oZkpwbTZJclJWbXR2M0UwUWErTGpl?=
 =?utf-8?B?aVZQZTBMQS8rLy9keHVnZ0ZSSG1TUEo1V0t0VlFFbUVLaHZaamVyRzZuaG16?=
 =?utf-8?B?ZUlkTk5KbC9LdGY2d3p0Y0dSeU9HNFhiWTNaazVmTlNHRnFubXRPcTJTc1Ri?=
 =?utf-8?B?bTdSN0VUSWc1alFaa09JdStFWWR5MEFrTXpQL1Y0RmFFenM2YytaOU40NzVh?=
 =?utf-8?B?TUNRM1Vxby94TExGdVhSb2lRVG9JNnAvbHNldjgvNkJXOFNjc1MvWFpRTUxG?=
 =?utf-8?B?YWFpVVFZNVBKQjVpb3ZvS3VVMi9PamszZndhVW9oYnV1SjBjU1RwVFIwUlY4?=
 =?utf-8?B?T2lYdU5mbzV6Zlh0ckVOTnY3VmFxdjNrblk5NWpOMnRNbUxJVmZaZkIwODh1?=
 =?utf-8?B?TlRDSVNyaU10UUVhSkRwcE1kMFNjTldBNVMrWWI4clZCNmx4TUV6WHlpd1NZ?=
 =?utf-8?B?RCttOXRKOUZ4WjFIQjV4LzJkN0d6ZFZtTGp0b1U5aUlZNVliNjFvb0lJUFBy?=
 =?utf-8?B?cC9EL1JCRDRMdkdXUTU1aGR5VnJ4bU5LN1VEWjdCL0JZemNGcndwcWk1T2xx?=
 =?utf-8?B?aVFRUFF5eVlOSExybDBVYnFFWjdYSDJadnA4Y0V6OGNUSWFZbW0veTJFTHRR?=
 =?utf-8?B?Sy9EUEUzRGpDOTVzNERWUUNCRG1MUXlTbnRsRWthUmtpbG12SGZqSjNPaEVE?=
 =?utf-8?B?ZzRPdzhCVVVvaitUdDJsK3pRQ0QvRHc3cjRCekdHWkNwUklpSS9qb2pIRHVr?=
 =?utf-8?B?VGhHVkswZXhjL09GM2RhSTNZYW1EdmVoMGFZbjdoOExhUHE3QTVES01vUmd3?=
 =?utf-8?B?U1JKL0tseUQ4ZjhyRFFTNVVQUmtuT1VGc1I3Nm5ZcC92MVdGUlV0T1lkanhr?=
 =?utf-8?B?cWY2cWh3V2NxWGF0OFZKdmcycVQ1Z1d5NkNlcmY5TFh3SVBMd0VlOHdYWm9j?=
 =?utf-8?B?cnZGWS96eWprMWpVcmV3ejRTVGJYMk5pQjNodmI4ZUxFNk9BWE5mOVBldGZp?=
 =?utf-8?B?S0V5aFpnM1hHcXU4d1RtUU10UzdET3kzc2pjMDBnM241eHcrWXk5OW9MajV1?=
 =?utf-8?B?UnVkR3RtSG95alcxSkhsZm1pUXZHaTNDWTcrY2FUM0Y0VThMNDJhZFd6UnFa?=
 =?utf-8?B?R3U4aDVRRjI3bTVURCtZZE9TVktCYUsvU0dFeTFpU1NjZVNEZUx5Yng0Y3RT?=
 =?utf-8?B?eDRCYmlOeDExSUpPSkV1a1B1d2pvNEx6R3VWaTM0SUhCVzEzckZ4a1hRWDBM?=
 =?utf-8?B?VmpoMkdvc2FqaTVwazM3SzNtNnhwMk9pRERscmhneW9lVG4zdldrL0Y4WU5s?=
 =?utf-8?B?Mlk4UFF4ZEN4cVJXNERwZ0hST21vYWFWNEY2RVhlNzhIMjdRa3E3SnRPNC9B?=
 =?utf-8?B?OXE4K3hZTTByeXlZTVZTMlpJTm1UYkNxQmxpM3psQUZ1aVhJUVVZVlRIUldD?=
 =?utf-8?B?bmkwMVpleXBpVXVVdEZtZHdGV0VKYS9UbklobDhiM2t5VGdlUWtOakNsSm5r?=
 =?utf-8?B?WHNZbnVpNTR4NmNLMjAwRkVZSU82eGF5MDRUQXhLWm1FZlcwaDhPVExEVUxj?=
 =?utf-8?B?bHg0aThYSFhNNXpGZ010RFp4SStWaGxiQmVZT3ArQ3FWd0dQQnhYQTZ2cGFO?=
 =?utf-8?B?ZFRzNk9QNkQ0TlVkRW55Vm82NlhYV3I0UVhGenV0K2oyU21Nc3ZUYXViMlFy?=
 =?utf-8?B?NGExZERseVgvQWdhcGl5d2tHQnNvNEdlcU9TYmJWMjdkMzRCeEU4OTZUeDJY?=
 =?utf-8?B?a0R3bFlPaHl5cVFSSy9zMjUyTG1mZU4vN0IrdEYrVXFrU2xKS3NOdVRjMGlu?=
 =?utf-8?B?VTdTeitCbHZsUnJpeWJINTJQbVE4R3R1Q0JPRUtEMTBIS015TEFqOHA0M0NB?=
 =?utf-8?B?TjFmRHVnTTBObVdaSm1ONzdKNEI4R3BLdjJDSjBXVmowTVRYNUFyUS90UGN2?=
 =?utf-8?B?emJ3RmhkWEJSc04xbXBCRzlCUkVSQVBkNXlZc3RmWFJwTkpYQ25ycFZIWldj?=
 =?utf-8?B?UkhQcGpkeUdpUEFvdlNmeDVVQnQzUVBESWh2ekNKZzZ0TFJNelVBOXJNTmJI?=
 =?utf-8?B?TGtVcHQzUVJaaS9nK2JFV0pxZFFtSS80NGo4N25Yd0RaM3dBaTlPKzl6UnBO?=
 =?utf-8?B?TmJZa0EzeVVwYnp4ZkpjMjRPRXp2WnRMbFB2R0l4ZVlSVnRxWVN1OVlkYTUv?=
 =?utf-8?B?SEdiYThjTE1udmpmd09IcElHKzU4c2ZWR0JKWlN5ck9SQmo2dHRmaGpBWlQw?=
 =?utf-8?Q?vGDnUUxHljTcMCao=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578005d6-8e91-49e3-e749-08df0c1824dc
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 13:09:54.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtnLHo9MX4foMX5xCEfGnkcGBjmn/XZpHEgnGp1VHnIZnPBlXSjz5b+eqz20C25gEXcD5w540NzjLeF6JAZXAKp/dBSbdILEcUCwVAzlxIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11331

On 2026-09-05 16:40, Paul E. McKenney wrote:
> On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
[...]
> I would not say "no" to a fix for this issue:
> 
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

I'm not sure this URL actually points to a relevant issue ?

> 
> Once that is in place, I would be happy to put this back into -next.
> 
> At some point, we will need to get rid of the concept of wildcard hazard
> pointers, as those end up instead emulating RCU, but I don't see that
> as an immediate obstacle.

I already have the implementation which eliminates the wildcard if we
care about this. It was part of a previous hazptr series version.

Do you want me to resurrect it on top of the current series ?
This depends on:

- ptr_eq(),
- then use ptr_eq() to compare the loaded pointer (pre mb)
   with the re-loaded pointer (post-mb).

See: https://lore.kernel.org/all/20251218014531.3793471-1-mathieu.desnoyers@efficios.com/

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
