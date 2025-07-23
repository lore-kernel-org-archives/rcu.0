Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022115.outbound.protection.outlook.com [40.107.193.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083D2F548E;
	Wed, 23 Jul 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284221; cv=fail; b=iZzauiJP7aplZq+cN8XVvxACVeM8NqXf9ASYnbYyLYZ8AKDmE28LU7Iv2ohLHIFXXsq9C2cgIzBHOnD66Bi+LeVMNS+cQ0k08n8Tt0Qijht24U++iD6obHOMR7IjZIp2j9l+CBgZjJCVEOmfekx4KE0DmU+ABV26zsFxS+vIWOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284221; c=relaxed/simple;
	bh=kXq5OZP7XfYOGNG0AIRgu8PF8DgqkcdE8wfYxkFSgvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HG8LSxhwqjR1UgIpWkGK63aZKmDa4LXFnGlh+bN6CLXchptjBrsERZMmM5B4TQY2ahoJX6eCTqjjrqC5XJgbCjVDBNGt/b8PMy9GNn0X5plfIXHoGj2zqHohjAzZ4+y15+WIg3EUNLmapXadGURiOA7ZgWHnjg20MYMv4k7hq9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Lk0Mo8vV; arc=fail smtp.client-ip=40.107.193.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Lk0Mo8vV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlPRwIO/R2U/KXEmb297dSpjPlUYxTK2c/SPAedXhlZLRbRjo4gQNzRf/iUmVguHSxP4CTelicVJDVVSRmfxzYz3D9GwOva3wGWmrr+RER2kfkRZLN0PnlCB7d0kVWneN/bveTDCVT9JeR11sm3hcPNgYzMFRTrUJHsLT8A2eUpCS89AvwpANgpS/rDM+G2KptDJU2sTdLOZAVPbYrCKFFGo1UF+SpQWI7qq5XOxM5q+f49LD+OXPhq0jP8WzQPctHeF4jjv+5rmod2XD90ZyIZRuoOQGTlLGMj5FB8ADPc09T3c/Jh1WUPFiCgT0rayScs3ijHuFcshSqji/ngMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvtODRM32hkh0B3lg2Q1PzX+4BCnR7ovwaCrMCE3nas=;
 b=ORtYngYw1gm1RV9dIyiDBrph8aRK6dkmoW+qNC/r1f0EKx/HxpshcKehjmn39vyu6h9VBMUhqWkZMyVaVgn7kzrYk9PtGNniLyi8OeUVizjO+MPQpMAbrkZ9aXZGfVUalZgN3beJgcfie5XWSpHWF+8dj2zHOAF6PK6mucLwPF/YykHPkHpA1nc+RrGrrR9HS/NMPmYhf/HIL3agb4yuBr878xWZqELID0/pOKIAuZS4guj1KnpDRS9w3VQCbyvtwikpt04gVL6SMfwx/WCJEiM9/8c9JKAYI2c6oOwryHr7dP6pXCqzoyKOZSbZ8vndpxhKaUBfabBdUEWeoe18Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvtODRM32hkh0B3lg2Q1PzX+4BCnR7ovwaCrMCE3nas=;
 b=Lk0Mo8vVJZ/k+zhryZlSMbz3NR2qbdWX+8qk+lo3fhON32mMpnGqRwBvkgvgxJLebt0/XOQTP3OF02O+WpWbyBS3KCMVVy8o3RTdTgPw/R+Uod9YYRWAMi1VtZfxOTk9VbB9sZGN4WWpepXeg6FIJpF88enbFOs261Jqvs9WCmRI6+giNk+bIK9RlZ7QZsmIV/s0XrX9gN/kRASXhnS3/RPr4GauErUef/hW87rEf2IG9oJF7/IsRpoXLSNgkq5COUevYd7J7kVTbu5MyzJ2OGaz5uWMkEVOe07VgkmTbwXppEfHFM6l57XrUge44M7VmTlJq0AoKoDeQB5ThEp8GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPF9CF16A047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::66d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 23 Jul
 2025 15:23:35 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 15:23:35 +0000
Message-ID: <4a93cf9d-f609-4819-b902-9ddce71fa821@efficios.com>
Date: Wed, 23 Jul 2025 11:23:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] srcu: Add srcu_read_lock_fast_notrace() and
 srcu_read_unlock_fast_notrace()
To: paulmck@kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
 <20250721162433.10454-2-paulmck@kernel.org>
 <20250722221100.GA377047@joelbox2>
 <4ac56245-3185-414d-9ee1-2c4b4c0a9d5b@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <4ac56245-3185-414d-9ee1-2c4b4c0a9d5b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0045.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPF9CF16A047:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eff76b8-5873-4081-ac73-08ddc9fce3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGdJNmwxNFRmOWRqczhEaldQTXA1bHpTQXRnZ01wOStSaUJsQ2FjNVJFQ0xZ?=
 =?utf-8?B?UTZkV1h4SFhVTmlhYzhqSTI0V09GbExrNjk1R0hILyt0RElsSzQvU0pYWUZD?=
 =?utf-8?B?RzgzQjUzL0t2ZjZoT1lDODN3d01FdEVIUGphNXNSYXZ1b3p4ekNzalV1OFI0?=
 =?utf-8?B?VVFmRXlwZll4ZHJvRmc1Vm5rbzFkekdkS1pDQTYwQW02bmpvVS9RNHp2Qzdn?=
 =?utf-8?B?SnlqdG1PYktxWEZTSllqUzlNL0VGRlpZd3VJdWxZUGNNM05adDZhQlRlM1dw?=
 =?utf-8?B?TU5WTE5KUmNJV3pmdmxpd0szcVdIVDVEc3ZCc0t5SnJEZ2cvODBXTkxBQzRa?=
 =?utf-8?B?b1ljRjM3VzhlUkp2MHdob24xdmhtTUtUdzV2cWg4cWVjUTRCdjZKNnUxRi9n?=
 =?utf-8?B?ZXBNYm1OZnEzUnY1Wmd2ZnFGZHlCSS91QkYwYkxtV3lUUDhkZWlqakQ1KzZZ?=
 =?utf-8?B?VXFiSDVRdDRFckRnclJTdG1ITjBRbnBnTEZ0bDdEem0wdkhtdlFnZExvK0Nu?=
 =?utf-8?B?ekNXUDBQeXZhbVpxekh2Y2lGZ3gyODh3UTIrZ2VpUk5GRExjQ1g2VWZEelFa?=
 =?utf-8?B?eVp5ZnZtS0VUTEZwRXh3cis4bHkzUzZsd05VYThkeFFxaXhqOFJJUkRJVjd5?=
 =?utf-8?B?c0NYT3BjMEh5OW9TNWNpSkpUVnNIdDFEVWxBdjVPWUJ3R3VtbUQvN05YMURO?=
 =?utf-8?B?QWluY3RqdEJkblRFalVYUEFRa1lLbitVRnJXaTVOR2tVNXY3RWVqTmsySmgx?=
 =?utf-8?B?a2J4U3o0K2tWWGVHS0JBSXRzNFVNejk0QWRDc2pjZDROYmRkWi9KWVU2UWgz?=
 =?utf-8?B?UkhucHVZRXZnVmtHVE5DdmlnKy82Vkp2a05kcHBLRWk5UGljSFcyU2tQUkxQ?=
 =?utf-8?B?QXFWQ3IzR2ZGeEZtUmdIdnhLaysrNmVtaVFMSS9qVE1EYjk0ZDN5TXhQcTIw?=
 =?utf-8?B?dnR2V0lHYnFKRTdaZjFDUmxnbit1dmRsYXZvVWpXemxWdytTWlZXbUErazNr?=
 =?utf-8?B?ei9qbzY4cXUrQjF1WjI2U2I5VzE4aWFXenllZ1k2YUx3K1ZpcmZkbVo1SlVj?=
 =?utf-8?B?MUtsMHVla253eS9KcGtEM09wMFVQWU56YnpvbUpxTjE5ZUlyNDRLOWJvSko5?=
 =?utf-8?B?M0YzNkxMVCtNNXp4Vmd1SGs2bkJ6WGswUzBQZTJsb21UbW5zRnROaFRiRm02?=
 =?utf-8?B?YTZaTkt5SFMwS1RYZGdha0RqTmVKZWhPWmJHZEdKQVdFVGYva2xzZ3J1SXJw?=
 =?utf-8?B?cUUrNkhLK21DSlk3N2M1Rll2NzlSRW1OSVM4NTMxOWM4NEJEemRpNldLL09q?=
 =?utf-8?B?WlM2c2pnMXlkT1N4SE9hMUx1dE9ySDJKa1FWV2hUV3FJY0xzVFAxRTgwSk1v?=
 =?utf-8?B?OHBJZ3NrTGZVeU45YWxlMnhoeFRGMVhqNFJmUGdIWUJtbHFlNVZGdkxiOEEz?=
 =?utf-8?B?QU9pUHJKdzVxclA1b000T0d0RFJwLzB0a2duQXBIalEwd0pHZkptWk5Yd3hS?=
 =?utf-8?B?eXJRZHFKSUhXNzhUOWVrcHdEbHB0UW1VTEVsdm9CZk15NnFoVXZpWHhrMzN0?=
 =?utf-8?B?T0ZkSE5GSFFtY21pT3F1T25EdWpHZWNKSkg5VGR5Y2VNZnJLSkFNcFk1WFB5?=
 =?utf-8?B?dUcwYURZcWpic2NqcFpSOE5yK2lHYWFXdkNUYTBkaFlSaEtWdWRVUi83elRL?=
 =?utf-8?B?K3lid0o2djd3Y0R3YnpKK1hrZDdkeTd4aXlLS2hkTklXVDYzaE5LUnhDZmhZ?=
 =?utf-8?B?Vm1NT1VjNEFDTWVZUkVNV05RdEhxWHQrbFNreVlHZHFKMUVXSlZSaDdLNml3?=
 =?utf-8?Q?uHxcRgAXmmTNkCztkYX8pqkGNivUb2BdDfPEU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXJmSG52bW9CTVZwKytQa0xrbkhiQkFxbEN4UkFYWnhXZFo5WGlpNjRKWFpv?=
 =?utf-8?B?azFXLzZ2ODRocHRhNVBLb1oyNkZHd3QxdWtZRERuSFlNVkVZZXRrQ25jNUs4?=
 =?utf-8?B?d1dUMmZtVkVLbVBpRlhMaktoV3VkdmlFcHhpSmcyU0pKV0pLWUpiaVZBWXFm?=
 =?utf-8?B?YU16bGlYaGxPUEJDZ0VGOUhkRFltbW9PRm5LT3VpdGIzR1hxK1E1NWF5Mjdo?=
 =?utf-8?B?ZDBEKzB2USs5b0tQMENkeEh0bjhrcFAzWU5JWDV6QWV6QXdZR2tNZGxlWXJM?=
 =?utf-8?B?ek1ZcmdSVm1hdU9teUhpYVQ0UnhIM3JEVGxDV2dOMFFTVVRLVStYNTdud1VY?=
 =?utf-8?B?NGVUYys0bG9mT3RhQVp0c3lLRjZIOGFKMmtwY1E1R0pUOThIR1huYjZKY1Jv?=
 =?utf-8?B?Q08xbXdzSTI3NFk4MXFXbC9zRUtuRWNTQW4xb3pGaFRwbi83cGVKWVF5ditC?=
 =?utf-8?B?LzhCNTZjTXE4V3Vldld0Y3BsQU5aZ25VeEJHK3dGQ003VlUwREZrMk9zR2Rp?=
 =?utf-8?B?MU1yVGpoNER5eEdkZHlXQUd2SmVYcmI4cm0wbU1oV3RBQ1d0MEZ5LzRQUnlE?=
 =?utf-8?B?V2t0Q005OEovWVFTWStybFFMazlrNkFVeVRjbWdmSXNmdng5TWY4S0hqLzkz?=
 =?utf-8?B?OHloQnBwUTF2YUkyNFpkMW5BUi9pS0hWVjFiUXlhTllYd2hHOExQUEYwampQ?=
 =?utf-8?B?dyt0NW9NVjRKRkh1OFEwbzRMYjh6ZkZVSC9tc0hLSEZQK2JKcjNWamdiR25a?=
 =?utf-8?B?VFFSTndPdkFMQXhQWk5tcjIxUGUwVVZYalpTdXQ4VlpyNU05QkpQTWkyMGIr?=
 =?utf-8?B?a3BnS2F3NFJWQU5VVnlucHNMbFFvbTlESmhGSjN3YTBRZUpBaDE5bWhITVgz?=
 =?utf-8?B?UUFDUWJ2T2NQODdmeVVsVXhveUlnT3Q1d1FpTUZMaUJLKzcvUlE4djA2cGZQ?=
 =?utf-8?B?MmkvdkttVmlvVUhiZ1JqeU15OFErcjlneEtnbSsxWmJqdmZZa0V3WmtYcEVB?=
 =?utf-8?B?ZWdKVit1MWNoNmVKOStVdHdnemtKaXVWSitaeDh3dXJGK0FZTXJRVVYrSCt1?=
 =?utf-8?B?a1RXVTRlR2RIQ2ZzRityUFBwcEo5YWZORVZOQmRJYm5jZGRRMWhFSXE3ejU2?=
 =?utf-8?B?blZsL0EwQmdBZFU5blExK1B0bWNHWVRlMjMvWG45VVlGRnViQlVFZXU5b3NE?=
 =?utf-8?B?TTd6SGVGaUdycGNOa1FaTlIxSVNydEtQZnN2WUhjYmoxM3Z5Z1BGcU1rdStz?=
 =?utf-8?B?emJCUVFSL2NIUXJtd2xReTk5OWY5cWcybWdNemNGSWpiOUNCK1BvMU1kZmhM?=
 =?utf-8?B?cmRVcEZ3WnRSdklhQlB5UUZOcWljQnJtTUNhQzZKcFBGNVRiOVhCRlNobzM4?=
 =?utf-8?B?MFdUU1N5RGdBSmNyeXhoang1VlFLM3UydUdDeXd4cXFzejJ2d0trdlVESkxa?=
 =?utf-8?B?N202cThDQnYrWS9DdnVwaVdvU203eWRHNXo4TGVGTGRqNERkQjNWTFZCajVl?=
 =?utf-8?B?YjQ5cEIrb3V6TEdHaHlZd3ArTzJJQmVDbmJ4ZlFGQTZRbFNsR0JiUGRUYmYz?=
 =?utf-8?B?eHkxRGtFdWlFNGZ1RE43ekQvd0ZPbTE4RnVOMnJham1NeHhEUGMyaHBxRFJ3?=
 =?utf-8?B?QU1uaURDSjU5Nks2eWpXbG5LVXN6ckR0dklOcW5PTHFlYnh1UEQvcGZUbUJ6?=
 =?utf-8?B?M1FHcVB1ZnhId0laMkpNcjNaemRyTEFVaVYzc3pHUHpPZ1E2bFZYS2x3eXZB?=
 =?utf-8?B?OUU1ODVLbW5lSHE4cjRJT2R3S0FMOHZKemdMVXRnUXN6a3I1ZnZEcExEdVZy?=
 =?utf-8?B?ZlVsdHc2KzlSd0hHNE85TzU5QmdZUmppcGVDbVpLeUpwU2RaYW1RZm9ScFZ1?=
 =?utf-8?B?U3hYb2wvYVBMUXViQ3ZiUUsrWjA0ZmFmWGJmSE9iUlQ5YXNpNWtVMEJpZ3hN?=
 =?utf-8?B?ZVRmdStRU0UzSnZuV3dmNStZOGtsSUpvZGwxVHlQS2RzUW43d3lRejBudDVq?=
 =?utf-8?B?WTV5RkVyVVUyWVo5TFNrdjhqUFFPVitEaW9zaFpBNlBjYVNZWmJTNVBNNTJG?=
 =?utf-8?B?R0p0R3dsZytzZUNqcHR1UXUxa0RvQ1R3SGZWRzN2a01HV3YzRkVST29GMkx6?=
 =?utf-8?B?NmlqOVpGQkw1UFNpOHVGZENFNWpuMjFqMy9uTEdkTERTWGFEUTVMeThrNHRN?=
 =?utf-8?Q?drY5uuz3+ezWho2T0rNW6wo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eff76b8-5873-4081-ac73-08ddc9fce3ca
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:23:35.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2n3ykIyBK+PK5Dac+yp8YiH78caWTy3jF3ZcwymT0L3OqzUnWbeyJUe0ImWt+c+SAVqXdVo149wTLEx1U0qYPVWbtIVyULxX5/b+/55lfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF9CF16A047

On 2025-07-22 18:34, Paul E. McKenney wrote:
> On Tue, Jul 22, 2025 at 06:11:00PM -0400, Joel Fernandes wrote:
>> On Mon, Jul 21, 2025 at 09:24:31AM -0700, Paul E. McKenney wrote:
>>> This commit adds no-trace variants of the srcu_read_lock_fast() and
>>> srcu_read_unlock_fast() functions for tracing use.
>>>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>> ---
>>>   include/linux/srcu.h | 25 +++++++++++++++++++++++++
>>>   1 file changed, 25 insertions(+)
>>>
>>> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
>>> index 478c73d067f7d..7a692bf8f99b9 100644
>>> --- a/include/linux/srcu.h
>>> +++ b/include/linux/srcu.h
>>> @@ -282,6 +282,20 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
>>>   	return retval;
>>>   }
>>>   
>>> +/*
>>> + * Used by tracing, cannot be traced and cannot call lockdep.
>>> + * See srcu_read_lock_fast() for more information.
>>> + */
>>> +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
>>> +	__acquires(ssp)
>>
>> Should these also be marked with 'notrace' attribute?
>>
>> I am not sure what the precedent is, I do see a few examples of 'notrace' and
>> 'inline' in the same function signature though.
> 
> Heh!!!
> 
> There are six instance of static-inline notrace functions, and eight
> instances of static-inline non-notrace functions whose names contain
> "_notrace", not counting the srcu_read_lock_fast_notrace() and
> srcu_read_unlock_fast() functions currently under review.
> 
> My guess is that I should add "notrace" to handle the possible case
> where the compiler declines to inline this function.  I will do this
> on the next rebase unless I hear otherwise.
> 
> Steven, Mathieu, thoughts?

AFAIR, the always_inline gcc attribute takes care of making sure the
notrace is not needed in addition.

So I suspect that kernel APIs need to abide by the following rules
to be usable by instrumentation code:

- if it's a function call, have a notrace attribute.
- if it's an inline (which the compiler may decide to implement as a
   function call), have a notrace attribute.
- if it's an __always_inline, then there is no way the compiler can
   possibly make it a function call, so the notrace would be useless
   there.

So you may want to choose for either:

- inline notrace, or
- __always_inline

Depending on how much freedom you want to grant the compiler with
respect to its inlining practices.

Thanks,

Mathieu


> 
> 							Thanx, Paul
> 
>> Other than that one nit:
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> thanks,
>>
>>   - Joel
>>
>>
>>> +{
>>> +	struct srcu_ctr __percpu *retval;
>>> +
>>> +	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
>>> +	retval = __srcu_read_lock_fast(ssp);
>>> +	return retval;
>>> +}
>>> +
>>>   /**
>>>    * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
>>>    * @ssp: srcu_struct in which to register the new reader.
>>> @@ -394,6 +408,17 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
>>>   	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
>>>   }
>>>   
>>> +/*
>>> + * Used by tracing, cannot be traced and cannot call lockdep.
>>> + * See srcu_read_unlock_fast() for more information.
>>> + */
>>> +static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
>>> +						 struct srcu_ctr __percpu *scp) __releases(ssp)
>>> +{
>>> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
>>> +	__srcu_read_unlock_fast(ssp, scp);
>>> +}
>>> +
>>>   /**
>>>    * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
>>>    * @ssp: srcu_struct in which to unregister the old reader.
>>> -- 
>>> 2.40.1
>>>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
