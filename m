Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020083.outbound.protection.outlook.com [52.101.189.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086924582D6;
	Sun, 11 Oct 2026 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747751; cv=fail; b=ipJLMdnq4y67q8anmTuAod1ZHSyfAihgxbJFlIzAVmfiwK/IGHZgBFLFR9hKZCVaJaXfI1BOZNRTWVEKZdQ2E1Iev6VOQmrnF6+zMsVCMfSTz0IshqKxNi3lHYSDKWU+dCrKXhYKBcP162SNLz6JAveV9/4+eEqlB+EUkvPlzPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747751; c=relaxed/simple;
	bh=KhyCkBXijh9s98JrplsNSCzd/wNy+E3QkDm2CFpcp6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mYL82mkIShThlbyzfhLpFsi+OIk/J4rD4p9j1IQ+lRAhb5mqP+BV/a67eD+qNG9p9OqOxd5lH8uiTyjQNAI6z3IqD40zCm5JVIQJ+9XM1w7jJVqXAzI0yQ2DMOBd52FMSydAcC6mQNSfnz8VustaMhuLhrXUClXZ9uAoQV/0t9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=IFQgaxtL; arc=fail smtp.client-ip=52.101.189.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IFQgaxtL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAn5HcAQFxmbTTouLy+k/t/k8UAJ5bfp482eCGEDRPSAyvFfG5atEy4YSjIOff5/v6Uw4LRWkxmEwQR/Qg0McpnCoICayumn2RLZSYytOVEJyTpD6PcwIQyO+0CWeVdSD7Q2QJQJoqpxotLzyGx7ssUsIitFbz7M3ve3Xo9exoiZHRtafy82h1q8meiWWZm7NNIoYGdFrbksYKqsRDUSoR+2iFPJwy6QqjsW/VMZzbfz7K4OtrfCdQJRxcIFd6hqXHDTbje8NFula3CJDw3HjW7rWDtYyPL9Fm6uKb1TZWrajnV+VOD6FkgTpN0WNRtVgrH5m0MiqNo41v/riLFi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMVVSAfz5M54lz72oU91TCzAgpiJqyERLUOngmmAo1g=;
 b=qoW03433XwMavgswAAfua50FxfHxUJ0L1nRfyB4PYsVh8Jw5LDV7WNFs5TiZQDEE7SmFoXNaugP1E3xzKjIcyJhAd6DRdx657KIiY68P6CNj9/Bf4vKszvEE+lYIctXbhAFDapTvIByuX1ehv6QlJEEcVmfphuMwRsfmg7D3rsu8SUgfEWR5P98s/n9bh67G3kmljZCJoPRsTg1AcfrJ1sttmVWb26bdDLuDpfr+0Eo2m94cyBeVZFzHAZeCZrM6cGeQ1/UmzRpSCQ3QazrIblCasyDfa+e+GmMtdSmsOEbcNev+jDEUMegK9urskXPWRIwNQkLZtbvJxD/Tmeyl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMVVSAfz5M54lz72oU91TCzAgpiJqyERLUOngmmAo1g=;
 b=IFQgaxtLatlTjyUHMb/9KS1YhfzJzTiEDSxGiVWepie5upvF3sKjbZP7E30eVelDE48vGl3/lGB5TwtRIpnOaAFGOYH7C/FbXNkBY7HtDXeTitDoU8uiLAj9RZDoVO2hnHIFnmMe4sgrmFhsoZlBGpdiUnVzdONGR1kLT8V1pJHx6JPpX3s3UntEkmSmKOsLgdJOlaK5VdxYMsWvQckzn/rdlXH6tmw6dIPDmL04ucqwtNR7jWa51sTmOnH00qzcPlSPglscX6eOgOOdQfECGNUb9rsLiXfxYgvK8xor6guBxJOrRAfzvmEoM73QUVKw9bIPL+pHe452QSmZkUoshQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB11270.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:145::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Sun, 11 Oct
 2026 19:42:23 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 19:42:23 +0000
Message-ID: <ae7d5e92-2b64-4088-b3a7-a4d02176f861@efficios.com>
Date: Sun, 11 Oct 2026 15:42:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hazptr v2 2/4] ptreq.h: Introduce ptr_eq() to preserve
 address dependency
To: Gary Guo <gary@garyguo.net>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev, Nikita Popov <github@npopov.com>,
 llvm@lists.linux.dev, Lian Wang <lianux.mm@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>
References: <20261009182142.6311-1-mathieu.desnoyers@efficios.com>
 <20261009182142.6311-3-mathieu.desnoyers@efficios.com>
 <DM0N5L0LG9P0.6IFXMJX60P92@garyguo.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <DM0N5L0LG9P0.6IFXMJX60P92@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB11270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f808eec-e2f0-4d5d-c778-08df27cfc547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|4143699003|261009221227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1rRlFe8f7XoDVY+g8oCZIPD/EWsKPc3FxmKafLSQlkqTApsJZlBGE3pnPyNyB8xMZDc8+NUrgjg7VDvt2u7L+glEBIs6GvBCrOt050sL99ppRAw025spH1e0wvbdAZdFU0wyo+AbHsEbZasTU/7kukrFG/8WJHg+Wj+2PXZw98fOMm3IvMJhJfpEPvby1/M49gN6bsGQ58KY2end82YNDrZyLKXjAzo4LHS4OqrxfC7QMpF6pUcgg6hvJK/9T0488rjoMkb86c+PXsko8HYHyPTXu5K7tqohcDw7Uod9c3yS5V9Goot2tnmWkJrr5Z5wevqYRBRmVAKWsWsrrA1ItRRq9G2k2T3Eizds8ucFLcgxXttJEVju+d5q7MaMKIagGgRRWjvnDRPjcbHNsXynt7O+paFsR+0MUCyyOKmA/CmQVX735cxFGuH/AJ8XYrYoqTfoz0gxpDxv7BMBUnR4hCm9r7WnqzpgfmFAd+HMggqTzuc0LqbPxU5EzMhbSl0PDBnOnrMovIAd6sycpI9ZiN7WSI0tCibnW7s0SQ9WB+Olf/zNulT0Bt5k/2SxO1ADixmA5G1BGANKOsy5wL7ryjUNotlm09GnDwzY4PQoeq0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(4143699003)(261009221227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFN1Qzhkc3lnN2VjT3MvTGQrTzEwbGZRam5GU09wVG5NYllOY1VRb2JlRU1n?=
 =?utf-8?B?bytpc29lYTdZZXg3SVdKOVJsNUprRy9FUVRNUE5VZkRTckxKODVYc1BCcUFR?=
 =?utf-8?B?cEo2ZjNFSE9Ra2pIT2MzSzJPMGRuKzlwdXpaSjc0Y3JhQUpVK0NKWnIzU0NQ?=
 =?utf-8?B?UlN2RmdialdmaHE3THczeWR0c1JZSWRiVDdLL1BsRVUxY29vZjZNakpKbWYx?=
 =?utf-8?B?djZsMXRFaWUrbitSTVdkU1R1bnYycUpmY282UDVGTlQrTjByZFNpTHVmQWVz?=
 =?utf-8?B?RVhKQVlsV0NySXJVKzVCbGRYVzlMdEpTcDFSdi80QjQ4S1BlN080TGdaVWZN?=
 =?utf-8?B?bkpNRzRGNkZJYzU1Ui9TNnl2clk0cjgyTW11K00zaG9QS2FZRFQ1Y2lCeXQv?=
 =?utf-8?B?aEhmZC95Vk44Nlg4c2NHUXgrLyswMTZDam1DUVNMaUJQVG02a0hIQ25UZXVm?=
 =?utf-8?B?TUV6QXVTUzQ4QU1NU08weUsydjMyNXFMMUhhSE80aWQ3UW0wVTVZUUhNZ0Qw?=
 =?utf-8?B?MGt6cnlBSFBDRG5RZ2F2MlhQMVRpQUpYbWxPWkUwUjlsY0VGUW12eVkyYzlG?=
 =?utf-8?B?WTBXQ1dJeTQza0hjL0tTOWpySGRPSGNPN1BNYS9pWjV1Ujl0Z3c1T1JnZGVj?=
 =?utf-8?B?N1p3RGdETFZFWDVpbUMrc1IvQlZaTUNZQXJCdjhReDd3N29NaWo4elVlbG9G?=
 =?utf-8?B?M0tobndPUWZQbVlTWTVDWmc5ck5tTlFkODBpTU5wRmd3MHJsVUVVUWlaeGhF?=
 =?utf-8?B?bkNkSjRQQVNkU0pURFlHRUdBREpkTmJwejVSbmZpZ1dES3pvYzl2NXZKL0xx?=
 =?utf-8?B?anNFaUNxN1hWVFJrdStoUC9LZkc5MjBydU4vejl5bzJwVjNHelpIK1NNWllF?=
 =?utf-8?B?eVRkSlo4bmxFa1VySlpRMWlhYm9SNkVGL3kyRUVQOVdTQmppNzkyams5MFI3?=
 =?utf-8?B?VnF1bUIvOE11ZHdGM0RGR2VpQ0tPdWMrRXhyMUFYK0JBeGlROTVHWmdtT2hY?=
 =?utf-8?B?T1I5NVdSUEVnQkRrR3IydjBNQmszeTFkTFcwQVNRbytDcUlNSjFsV1FHOGtm?=
 =?utf-8?B?VWtyUkJ5eVBXMytrbG9GQ0lyTi9QQ1l3ZWN3WDAxeW0rc3lRMkFmOWNWN2Jq?=
 =?utf-8?B?ZWtQVk5nTGh5WTNpYlROeDdsRy9TbEd5WU11KzMxRVdiQXJBQlFEM1NJekNJ?=
 =?utf-8?B?MHhpamZKWnZ4SklmNlUvSmxFSnJwSkRUdEIxelBGekVuai93OC9GaUFPUVIv?=
 =?utf-8?B?bnBBenBUempJemNZYm5pV25jclh1UWcvbEhmeUMrcHM3ckR6b1pUL0UwOEYy?=
 =?utf-8?B?eTd4S2ZTZzdlYkVGQnZtdjlUWHNpd0dGdFg3NnNySkZrWXZ0Ty9mQ0V1aERm?=
 =?utf-8?B?TWk2T3h6RFcybEszWitWT0VJT2pKTmlxaVNRSmkwMHlRNUJpVE94czdyTVQw?=
 =?utf-8?B?ZDhNZUQrQStQcHg3WmlMVDNIQld0K1dGWEZYck1NeWNVMVUyc1E0eUJ1VGhL?=
 =?utf-8?B?U1orSDJUNEFWTG1NWTdqYUZLMHUydjZJcjFLbXlpVXdNWW5kSkMxNUtMUDll?=
 =?utf-8?B?aTBQVHpOVXdNSXFNbTFNQ2c5VDArd3VmZ283cjdQWnRyYmJOQllVOEpsMmxU?=
 =?utf-8?B?T0JOQStvSFdEa3U4M29MaWk0Y2YwY1Z2bTFtd1Y4L0RrUGlDbjhGOVd3NlNT?=
 =?utf-8?B?L2t1ci9RYzhVdUN1N0ZDUnkvRFhXcm96cnpwYnFXTzhWS2ZBaXo1NU5ES29K?=
 =?utf-8?B?bFNpUW5nYVBmQUkrdm90VVEwKzJGdDdLMDBwN0hEVVFHT21wa0FaWVpKQzlt?=
 =?utf-8?B?SEVJRzRoUm1XUVd4Z1hrYXBsZmJ0cldMZEpVSUxlam9FSzhEK0tyRitCdytP?=
 =?utf-8?B?SmxzaTllak1uZHA4L2VYd0tDWlV5RkwrcEZrV0JNUFJBZEU2QXVsblpQcFNY?=
 =?utf-8?B?dGpiMHpWWDJVVDlVTzJTUTc3YjBHUUFPK045d1h4WUVhVHQ5RzJ3RG1HREp3?=
 =?utf-8?B?b0xieVRuREM4VWtvQUFMRGRYQmF3ZzBnd1B6Tzc4MFNMVzNqOUFjRzJWZ0hU?=
 =?utf-8?B?UVozMlFOczdTU2UrYnE3OXJxcXdjdTZTeEpVMFBONm5CMDZlcTQxaTdaNk9i?=
 =?utf-8?B?aXF3WnpMZlBEVlZ4N2xHMkN2ODU0VTdSWFVoUWsrcTY5OWVwS3dzK1F2ZnQ1?=
 =?utf-8?B?MXVtcUlWNm40anNESHlUc2JtQmI2OHBzZmxkS1gwcGExbnZVZEdQSWpScHp3?=
 =?utf-8?B?b1l4QzN0QmNtQ3dhZTJHbWV2SnpFeTExekRQend1MVFuc2F4OWhCRTZVcGhx?=
 =?utf-8?B?RWdEWlJBa290UEVRa0hZclRVL1JOYUdMUzMrRFN4UzlIUnhzaHQraDFPZm0w?=
 =?utf-8?Q?aq7/BEGCcBoOiM80=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f808eec-e2f0-4d5d-c778-08df27cfc547
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 19:42:23.2902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4U4KhuOjxkf2dOxsJD8MiW8lZ+al/TWyS6bEJkT4fYDQ1v/ntNTwKIH8vBMqER6DmRurVPLuGU83mexHJ1AYhMt4lWVQuzGeGr5EN9M+UQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11270

On 2026-10-09 17:55, Gary Guo wrote:
> On Fri Oct 9, 2026 at 7:21 PM BST, Mathieu Desnoyers wrote:
>> Compiler CSE and SSA GVN optimizations can cause the address dependency
>> of addresses returned by rcu_dereference to be lost when comparing those
>> pointers with either constants or previously loaded pointers.
>>
>> Introduce ptr_eq() to compare two addresses while preserving the address
>> dependencies for later use of the address. It should be used when
>> comparing an address returned by rcu_dereference().
>>
>> This is needed to prevent the compiler CSE and SSA GVN optimizations
>> from using @a (or @b) in places where the source refers to @b (or @a)
>> based on the fact that after the comparison, the two are known to be
>> equal, which does not preserve address dependencies and allows the
>> following misordering speculations:
>>
>> - If @b is a constant, the compiler can issue the loads which depend
>>    on @a before loading @a.
>> - If @b is a register populated by a prior load, weakly-ordered
>>    CPUs can speculate loads which depend on @a before loading @a.
>>
>> The same logic applies with @a and @b swapped.
>>
>> The header "linux/ptreq.h" is the expected include target. It
>> contains the documentation of the ptr_eq() API.
>>
>> An architecture specific implementation of the pointer comparison
>> can be implemented by each architecture as asm/ptreq.h. The x86
>> implementation is provided initially. If no implementation header is
>> present for the architecture, an arch-agnostic fallback based on
>> OPTIMIZER_HIDE_VAR is included from asm-generic.
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: John Stultz <jstultz@google.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Uladzislau Rezki <urezki@gmail.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> Cc: Zqiang <qiang.zhang1211@gmail.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Waiman Long <longman@redhat.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: maged.michael@gmail.com
>> Cc: Mateusz Guzik <mjguzik@gmail.com>
>> Cc: Gary Guo <gary@garyguo.net>
>> Cc: rcu@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: lkmm@lists.linux.dev
>> Cc: Nikita Popov <github@npopov.com>
>> Cc: llvm@lists.linux.dev
>> Cc: Lian Wang <lianux.mm@gmail.com>
>> Cc: Kunwu Chan <kunwu.chan@gmail.com>
>> ---
>> Changes since v1:
>> - Move to linux/ptreq.h, implement x86-specific comparison
>>    and asm-generic header (fallback).
>>
>> Changes since v0:
>> - Include feedback from Alan Stern.
>> ---
>>   arch/x86/include/asm/ptreq.h | 16 +++++++++
>>   include/asm-generic/Kbuild   |  1 +
>>   include/asm-generic/ptreq.h  | 16 +++++++++
> 
> I agree with Boqun that this should be ptr_eq. There is no need to save that
> character :)
> 
>>   include/linux/ptreq.h        | 63 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 96 insertions(+)
>>   create mode 100644 arch/x86/include/asm/ptreq.h
>>   create mode 100644 include/asm-generic/ptreq.h
>>   create mode 100644 include/linux/ptreq.h
>>
>> diff --git a/arch/x86/include/asm/ptreq.h b/arch/x86/include/asm/ptreq.h
>> new file mode 100644
>> index 000000000000..593b45f80451
>> --- /dev/null
>> +++ b/arch/x86/include/asm/ptreq.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_PTREQ_H
>> +#define _ASM_X86_PTREQ_H
>> +
>> +#include <linux/types.h>
>> +#include <asm/asm.h>
>> +
>> +static __always_inline
>> +bool ptr_eq(const volatile void *a, const volatile void *b)
>> +{
>> +	bool ret;
>> +	asm(__ASM_SIZE(cmp) " %1,%2" : "=@ccz" (ret) : "r" (a), "r" (b));
>> +	return ret;
>> +}
>> +
>> +#endif	/* _ASM_X86_PTREQ_H */
>> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
>> index 2bc00c67dc54..e1d95dea09d5 100644
>> --- a/include/asm-generic/Kbuild
>> +++ b/include/asm-generic/Kbuild
>> @@ -47,6 +47,7 @@ mandatory-y += percpu.h
>>   mandatory-y += percpu_types.h
>>   mandatory-y += pgalloc.h
>>   mandatory-y += preempt.h
>> +mandatory-y += ptreq.h
>>   mandatory-y += rqspinlock.h
>>   mandatory-y += runtime-const.h
>>   mandatory-y += rwonce.h
>> diff --git a/include/asm-generic/ptreq.h b/include/asm-generic/ptreq.h
>> new file mode 100644
>> index 000000000000..db5a88628b1e
>> --- /dev/null
>> +++ b/include/asm-generic/ptreq.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_GENERIC_PTREQ_H
>> +#define __ASM_GENERIC_PTREQ_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/compiler.h>
>> +
>> +static __always_inline
>> +bool ptr_eq(const volatile void *a, const volatile void *b)
> 
> I suppose this is `const volatile` to take advantage of implicit conversion that
> adds cv-qualifiers to be added implicitly. Might worth a mention in somewhere
> (commit message maybe) because I was confused for a second on why this needs
> to be volatile.
> 
>> +{
>> +	OPTIMIZER_HIDE_VAR(a);
>> +	OPTIMIZER_HIDE_VAR(b);
>> +	return a == b;
>> +}
> 
> One thought on inline assembly. For RISC-V, branching with comparison is a
> single instruction, but there's no instruction for obtaining the boolean for
> a == b.
> 
> One option is to do
> 
>      static __always_inline
>      bool ptr_eq_likely(const volatile void *a, const volatile void *b) {
>          asm goto ("bne %0, %1, %l2" : : "r" (a), "r" (b) :: not_eq);
>          return true;
>      not_eq:
>          return likely(false);
>      }
> 
> and then the optimizer can turn a ptr_eq call + a branch to a single
> instruction. This, however, would require likely + unlikely variants.
> 
> Alternatively, we can just not have all the complexity, and just emit one extra
> instruction:
> 
>      static __always_inline
>      bool ptr_eq(const volatile void *a, const volatile void *b) {
>          unsigned long diff;
>          asm("xor %0, %1, %2" : "=r" (diff) : "r" (a), "r" (b));
>          return diff == 0;
>      }
> 
> Thoughts?

If architectures end up needing the likely/unlikely variants we can
do that if it saves instructions on the hot path. How about we do this
change when we introduce optimized support for riscv ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
