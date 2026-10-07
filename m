Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020143.outbound.protection.outlook.com [52.101.189.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291238B158;
	Wed,  7 Oct 2026 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389028; cv=fail; b=ZkCUF8IJq2fd0AAokIC+eezLeF9X80cJAH//rmjNH27jDsiBsUuSBtqCUAWFrwBfButZqM2IohEpnm0A5tdc7xhLzYlqcsb99hz23QnyDBhoNoIKcfYbBrekaKULmmrO0EBLwMJtJ71iA5Tgm7FnHfQnDoT3FddRZxXc0T0FRwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389028; c=relaxed/simple;
	bh=1lrlHQpO5jfDeFm0E/lTH8vejHMYAQNRxsuYuQsm0d0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p0xjpciVgJI84lq1wbVLZjBqqHVLACdvAw2u1rmAF69APKdrxdUXUfEUPZpQsVU0AUF9me4Brr/5NtORI4MYbC8JQTZW4PATClMIMvjhxD9dCxaPE6QzrbA9hlwCZH2QTDXdEX5wAX+/HLb9cqW66bkWsBc9gXF4ncdRfvW5CHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=MEV12MMH; arc=fail smtp.client-ip=52.101.189.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MEV12MMH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2mimLwy+m3fxWZaLlM82xpH8VMyBOIf9Y47+NlD/4tfLDkdqhSCmp8hZvDybq/vm00B8gei+LkMpCoCJKf/vf4Qeto2dXdsIteH0O5qzDrPequhJcv034sVII4Zdlu+2csSwzc8Tij5EBkAApMOJumo1+qfv+m6C7MfoF2BadbEV3QDP84bdqJOE5vunZXkf4WxLIslzkCyginoPp/RV2JRPCkRy5Bz4pI2tC8Qsd5sO9kAw9CEzO9oe+7KFrQawonYo4RMi7c3wigbgCEJy7jzriAw3edMHmKE274wki25hgTXAPU+DQ2S+BMLG7Uo3yhcwBvPC7UhTsPK0bjijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/202GdYZZR+uL55ZL9IoxBP+xnjoSG9klMGMxgVeKw=;
 b=cvH7DATWmlxIM92Qv20AN6cHO98AoszvCtUkSgCqzoB6lvyDlbzRzNF8DzDgPBxWcSWwIH3HfP7nSltGOm6vOHDRqPwZc3WaP4zfDrd+RJjivwF4R8tD0KIeGnGmLSbBS41y4tchuDKR68kQu91mmIEzqixhC+bs9sOe61ZdQA7jtaaX4P/XlUFvdyBeI4whd3DGgtsOOMHaN/w0sF6b6ISJb/HgARRYXRTdtp3YiOLq8+f1/jmDxjHcWGS1Ti4VD3lsCesQ97gKUPftSMtLbU0siybsTsyhLQnx1qTVflpyq/VSAkCMqEt+aDxJWVmDCN+ssSo8xRDQ/O8GMnLfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/202GdYZZR+uL55ZL9IoxBP+xnjoSG9klMGMxgVeKw=;
 b=MEV12MMHrnn8T+0rctkOv/ciWHRYGoIpvnoE/bdxX1GQVWIV+oHmMyw4FH/JBxNgMhi23MbgmCHT/xPuHLoVVCb9CL9UWW1Gg0tu/PQxm2WeukPxfuVYRaE1+a7XXYO65b54dg74ARy6aQ+LU6uiHx62u/uCMdh3xSvEvQ+5pW0j0ET4/ZP9XUCFsBqmbS8CWPcd+R1mwOqq9lhuabX0EwI2UdgK3UBNearOgzbA4iMEMFXdinqX7YSoSgQrjTE4XvEUTkE8ZE1KrTNiv3JjmMHTz9dV4dzNbGM9VEvPiAWJQIuIyhKYwiS7pQIL4c3LCKR2PYZq7CON6Avs4fRmgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB11907.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:179::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 16:03:42 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 16:03:42 +0000
Message-ID: <37deae99-c7b7-4640-8b7b-9b2811f26c48@efficios.com>
Date: Wed, 7 Oct 2026 12:03:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Splat during modest hazptrtorture run
To: paulmck@kernel.org
Cc: Boqun Feng <boqun@kernel.org>, Kunwu Chan <kunwu.chan@gmail.com>,
 Wang Lian <lianux.mm@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Bradley Morgan <brads@mainlining.org>, rcu@vger.kernel.org,
 lkmm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <1f885062-4905-4d9c-9293-615c145d2d6b@paulmck-laptop>
 <5b5dbb90-69ad-4a8f-8583-f5ba162744d3@efficios.com>
 <631c13bc-671e-4cf3-b466-0408d7600ab2@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <631c13bc-671e-4cf3-b466-0408d7600ab2@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0184.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::27) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB11907:EE_
X-MS-Office365-Filtering-Correlation-Id: e8409477-75a4-4093-c039-08df248c8ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|18002099003|22082099003|10067099003|13003099007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JZqwtrmQMhYd/jGTTWdPKuWPzaGKugNJ2ZLB+px3ip3MWNy+Z1gWfl9nMZ2ND3ewHmzG8NNPNDJkFIkZUiIWaP0KOmckOMCV1sS/JWHXa3hpPrV1CCUXCgp7qVpSLKelwZlxE9XS8VM+GlY/CTeeiCFjfvyAJrY3rs/mtp2EWTsB5jwAuMD1nxBZoa0o1+XphO24qIiQbcirRRqwLTk55cVedwrPZ6SISMDnHcT9eOpsKn1gZJAjpW6TP/bBztXUwZ5es6wX8ehnt+zXl61WM3IJUXyVrOARC8wmCo+IcoqP2u0ZFth1QhPp/wjZak2EYg43P+Z4lJi8vzbhlGhN6/bxNFYXduM9ArFl1TQlRvdkEXPcZmd2Z/XPDq7i+NVEspcADFDwavmyVtgATGEm400Hi+kfhJr/lTUrpMdjEBQ2eNtTSFfC28RRb0C5kowpn30eStSXBxBps+9Hpm39HfGqAUA8dH2fVjm2w19oK3569Y3yGI0nfRAI/RT2tbYWLuZBNBq9DVJL4EQ3Bsnobb396L88jkZhY7lYLb14eaGb9QXk6FtLQVnPZuT9YOPA6eaIaC5KgtU/j6/KrG0N8NYVO2O4wHyitvsHD+ryePc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(18002099003)(22082099003)(10067099003)(13003099007)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEQvcFJHWjRMMnBrK1ZEbWtIaHVIVjNVMThhMGJoekJ3M1J4SWVUYTZZNVc3?=
 =?utf-8?B?T3g2cm56dzV5M0FlL0N4eithTDg2TWZjZDZsZ1laSkV2d0o3Zm02R2pmNXhY?=
 =?utf-8?B?TUpteFZsNW9sMERUaGdjbkVuWStqU21KSWFjVnF1VG1oNnhPM1oyY1h5eFFW?=
 =?utf-8?B?TG1VN2hlK09vd3JXZ2tncFlZTERoYnZvblZkTVJtc0E0eVFia1h0NFhReXZV?=
 =?utf-8?B?Mkpja2ZnRDhYZGswcUNCeklYN0dieWVYUnVmQjZqMjJKV1M0OHdaaytGMHlw?=
 =?utf-8?B?MFU1WE1CYmYzSmZNUWFUTno0b1FwT3FyNnJXR3I5YTFkVVdKVGw5L2JOaFYy?=
 =?utf-8?B?Tk81bndUTDdaU2FybUJ0RFBNVzh6ZHUxcGxpUEJVV0pZT2xGNXYvb1h6ZVZp?=
 =?utf-8?B?ODZpZ0xCZ1Z4aVBCa2pDSHlVWDlnMlVzUkxUUEx3L0xXdlN0YzNNSksxaE5j?=
 =?utf-8?B?cFlSRUE4R1VpOFhITGJmYTlMdzQ4YjQ5TFUxcE1tNzAxc3NERUdCN0xEQlFP?=
 =?utf-8?B?OXJ1M1RYbTNxUFFQNUNyQnE4VEd0bUhaRWRZWlZ5a3MvcDlQQldYM0xCbHUy?=
 =?utf-8?B?OFpaanlJNjhyYWlKSUpBTHRvWFJXWTJzNkdwOEpybytRbjdyT3kzcWIwZXB3?=
 =?utf-8?B?cEV2TitIRmZ0VTVPYlFWSEJiNE5QMWdKVE1WRTRramZLajdGUm0xZmxiVDYy?=
 =?utf-8?B?OEtmZGJubFZ4SC9KVDFNV3BZeXNKdkVJVEdXMVQ4WVIwSjRqcnNPcEtkc1hW?=
 =?utf-8?B?LzRBd05STVVQcVJyTEVBNTZpSm1OSkFmWE9RQTQ1ckZqL2Y0b0VnNCs1WnBU?=
 =?utf-8?B?bTVKbUNDUW8wRmJSMVQ3VUpQVkRoSmszbkNLdWhKdGZ4aVZwemN3UmFvS2ly?=
 =?utf-8?B?alY3YzVYbWxwcHNIcGw1aFRweXl0ZHkrOWxBNVpHYS9meWtmTWswYk5oLzcv?=
 =?utf-8?B?VE85SlJNSHhQZmkwY3ZPSnVzMTNLaUxmVHFCSFF2NFkwYU9MK08rcG5KMDRs?=
 =?utf-8?B?RGJtcWp2WDQ4MU9VTDdHbGhFY0pQck5SOWw5eXJteisySDJnK1BCdEVqRmVn?=
 =?utf-8?B?WTdmL0J3V2R4alhseXZTa0diMWsyUmpCNUhXWVZYRzVtNVlFMm5lKzArcXJz?=
 =?utf-8?B?OFFtZnVveTdjOFlOcVRseUxVc0REUGhnVkVHZGFha1BSTHIxbXNmclhmc0g1?=
 =?utf-8?B?WUJaN05ZV0lES3A2ZS9rQW1NdTB2UTNxeXp0SDFPRmhnRnd4NC9oSVREZnBX?=
 =?utf-8?B?OXgvUS90dVNMU1ova3NKVUtLSGc0OHpHdlc2aEhFYzFVclNrbncrTDZMcStt?=
 =?utf-8?B?dFh6VmhzbG9XamRkMkFqaU81TkRJaDViZFNzUDVxa3JhdWtSNlZ1Zzc2aGFk?=
 =?utf-8?B?VDFycGFTMlN2aElsellhZVd4MldkQytya24rdThMU01wcWtDVDhKMzRIRTU4?=
 =?utf-8?B?QWZXc3p5WmNtSEg3eGQrWUZmV1kxU2NvaGNKK2hVMzQwWlNDNmpUblhIT21U?=
 =?utf-8?B?NHFHbW11SzZERlhRMnl2Z2ZMNmFWNU5GakdPcWE4WXl6bG5QYWwrc3d1Mi9P?=
 =?utf-8?B?UlpHWGlES3BJRnBqOVROSmZJVVdkUDkwb1ZhQVNZMXBaQ2NKQVpHNFJ6SDBl?=
 =?utf-8?B?bUs0ZFBWN2xYVzdlTUJidS9WS2tmMXpkS0U5d1ZZdHBxR0RDWlQwZ1VGdUlr?=
 =?utf-8?B?Q0ZCbTFNSnNoUityeUZCL1dJZzFIK1ZiRTVXV2JOc2ZsUk9UWWFGSklhSlhN?=
 =?utf-8?B?a05qZXJUbkxPcitsT1d6ZDlpb1JnbDFNSEpPaG9ZWFkwMUlWSGhoQmxHRi9J?=
 =?utf-8?B?ZXhLOWJRSVo5TTVld3lQUkJwb1FDODdZWlBFbXp5VWpZRTJDaURMcno5ZFNh?=
 =?utf-8?B?djZQemMvdjBmTEIyRDFCMDBxU3A0U2FycDVBZUU3RnYzV3dtbjl6ZXVQQWtY?=
 =?utf-8?B?VXczeUpMRUlDVFc3Y0ZOa0lsUTU5eXYzUExQaWtNR0JVbGFuR1hFWEpPMUNz?=
 =?utf-8?B?M1RRa3lkTDVoTEhTdXZ1TWRXMTVCOXBKdnJzRlk3N2xPaytGS3Z5ck5IOVJJ?=
 =?utf-8?B?YllzUnZ5Nm9BSGZPVmU4c2tBOU5WNUhaK2RhZExTM0hXWDBWaDg0WTRjd1Nn?=
 =?utf-8?B?MU56d0ZGTUVwMk1GMDRBL0NCVlp4MkxNZlUrZmRJVk5nWXZ5OWxnSGRCUHRi?=
 =?utf-8?B?ZUZvY21TNEFuQXFScXJ1bGlhU29XbWhGTjNTZktzRy9YRVRGb2laSjFLSFlH?=
 =?utf-8?B?RzhOVmRyakpSZUVKVWFWSVZ5c1B3NnZXQ1hUcW9yOHFHZVFGamJCeWl5Nmor?=
 =?utf-8?B?WGZDT2NncmdCdzZyU1ZtKzFXY2VuS2w5MG1WWDJpd1d5eU5rRzN5YXl3djJV?=
 =?utf-8?Q?HuqfZD5wsa8Sviwk=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8409477-75a4-4093-c039-08df248c8ef1
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:03:42.2855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XI0B121HvQh2nyyCAq/fZ/psbg84kEtAfSM6KfB86T2rw5Lbi8FkvAQJBIFtoPhlxOXAdGLG4ZKtSwjl4TTYtsYUeRLpoSANf5eNir7E++c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB11907

On 2026-10-07 11:59, Paul E. McKenney wrote:
> On Wed, Oct 07, 2026 at 03:09:27AM -0400, Mathieu Desnoyers wrote:
>> On 2026-10-06 19:40, Paul E. McKenney wrote:
>>> Hello!
>>>
>>> This is all new code, so the bug could be anywhere.  So you all need
>>> to know.  ;-)
>>>
>>> I got this from the NOPREEMPT variant of hazptr during a nominal
>>> "--duration 60" run of torture.sh on x86 with the guest OS split across
>>> two NUMA nodes:
>>>
>>> [  137.765104] WARNING: kernel/rcu/hazptrtorture.c:658 at hazptr_torture_stats_print+0x25b/0x4f0, CPU#1: hazptr_torture_/136
>>> [  137.768647] Modules linked in:
>>> [  137.768891] CPU: 1 UID: 0 PID: 136 Comm: hazptr_torture_ Not tainted 7.3.0-rc5-00661-ga1f1e4890d1d-dirty #193 PREEMPTLAZY
>>> [  137.769683] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-6.el9 11/05/2023
>>> [  137.770319] RIP: 0010:hazptr_torture_stats_print+0x25b/0x4f0
>>> [  137.770735] Code: 48 83 c4 20 e8 86 44 fe ff 41 83 fd 01 7e 23 48 c7 c6 6e 85 17 b0 48 c7 c7 db 27 17 b0 e8 6d 44 fe ff f0 ff 05 76 6e 0a 02 90 <0f> 0b 90 4c 8b 64 24 70 48 c7 c7 73 85 17 b0 e8 51 44 fe ff 48 8b
>>> [  137.772061] RSP: 0018:ffffa738004ffdf0 EFLAGS: 00010202
>>> [  137.772435] RAX: 0000000000000004 RBX: ffffa738004ffe08 RCX: 0000000000000027
>>> [  137.772950] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
>>> [  137.773455] RBP: ffffa738004ffe60 R08: 4000000000001236 R09: ffffffffb01727df
>>> [  137.773980] R10: 0000000020212121 R11: 0000000020212121 R12: 0000000000000000
>>> [  137.774479] R13: 0000000000000002 R14: 000000000002ffd6 R15: 0000000000034f03
>>> [  137.775000] FS:  0000000000000000(0000) GS:ffff999c2e502000(0000) knlGS:0000000000000000
>>> [  137.775578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  137.776001] CR2: 0000000000000000 CR3: 0000000008830000 CR4: 00000000000006f0
>>> [  137.776512] Call Trace:
>>> [  137.776700]  <TASK>
>>> [  137.776863]  ? __pfx_hazptr_torture_stats+0x10/0x10
>>> [  137.777207]  hazptr_torture_stats+0x25/0x70
>>> [  137.777508]  kthread+0xd9/0x110
>>> [  137.777751]  ? __pfx_kthread+0x10/0x10
>>> [  137.778017]  ret_from_fork+0x1bd/0x220
>>> [  137.778285]  ? __pfx_kthread+0x10/0x10
>>> [  137.778560]  ret_from_fork_asm+0x1a/0x30
>>> [  137.778849]  </TASK>
>>> [  137.779007] ---[ end trace 0000000000000000 ]---
>>>
>>> I have not yet seen this during a PREEMPT run.  Line 658 of
>>> hazptrtorture.c is the WARN_ON_ONCE() below:
>>>
>>> 	if (i > 1) {
>>> 		pr_cont("%s", "!!! ");
>>> 		atomic_inc(&n_hazptr_torture_error);
>>> 		WARN_ON_ONCE(i > 1); // Too-short grace period
>>> 	}
>>>
>>> Any thoughts on what might be causing this?
>>
>> Hi Paul!
>>
>> Can you share which tree and branch (commit) this is running ?
>>
>> Does it include my fix from this series ? That would be patch 1 of:
>>
>> https://lore.kernel.org/lkml/20260927155134.4740-1-mathieu.desnoyers@efficios.com/
> 
> Ah, no, I somehow got the impression that this series was going to be
> updated, so did not apply it.  Apologies!
> 
> I will pull these in.

About the patches introducing ptr_eq(), I plan to handle Linus' feedback
perhaps in an additional patch and have the "generic" ptr_eq()
implemented under asm-generic, and a x86-specific implementation of it
in assembly. Are you OK with this being a follow up or would you prefer
I fold this in the original patch ?

> 
>> Does it run the additional series from Kunwu Chan found at
>> https://lore.kernel.org/lkml/20261002170847.3653663-1-kunwu.chan@gmail.com/ ?
> 
> No, but if you are good with it I will pull it in.
> 
> May I add your Acked-by or Reviewed-by?

With LPC going on, I did not have time to review it, sorry. Not yet
please.

Thanks,

Mathieu

> 
> 							Thanx, Paul
> 
>> Thanks,
>>
>> Mathieu
>>
>>>
>>> For that matter, can anyone else reproduce this?
>>>
>>> 								Thanx, Paul
>>
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
