Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2115.outbound.protection.outlook.com [40.107.116.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098EF22069E;
	Tue,  8 Jul 2025 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003614; cv=fail; b=CjkD3t+o4ugB1v67w2mgyqAvST2Rh2qQrIg940nA5rUAfHJalGbp7kmfD3PEbTjR833R1oxZH1GrLMD5NoNHacoK70dF9h+KwLm6iaWbjsj2cZb/+zbAJwzlKsAB+em9YOPAiDN6oqqqAzLEq8rcpNaGOG4GU3XrKvvu+JJ1aUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003614; c=relaxed/simple;
	bh=iFKiEft9zisMRacn6rIea86EKOr4m91cb6a/2OYfazs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mk2rN4zsFYOX76ETllVmpshOctiEIBretzD/3kANrXb5qP4MSFWqWBtWoygEAqz/eOB8wlUb8Je0wnmlsXgSkDT6B66Peb5t2R3yY6DRoB1EpGfyqgyVZ5yNdpfKKwrfUvvdMMTBWJoKshnWNt9rursIC5muIeGnyB+l2NeRKNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nZBbBINT; arc=fail smtp.client-ip=40.107.116.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nZBbBINT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I26e91yCkwvkuXWZZXXdJhN6/HQWL5NUSiEiI6H4/seJCPbp8+Nk2hF52DNCJDNXxwRp13u65Taj9iY6jHMxXeeW6V1jMx0xIAMoLewJxy9+906KgCD2mCfm0iEOCk5b1eUtJtZLWsxQaU3+POh2SM0YDYvGnHd/HYeLM4icbzH8mZWadUHDeLOtVWnXCIwp86wCHpr3ouyntiC9KYthmKbKi2yaerMEpGOpw8E9nt324A1b9ZAVXjCqKB5jQ7jKHExWO0IsYPVZaoWqlyIhky0hCiycKLk9RMWbf45nBymdHI0tQfOebdhf86Blxj/pM61H5oygNoGA9YwB3fBhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+zmWb4hTKpQVKuZv0ZR/KdXbvLL1WHZn3oyjEXNHNc=;
 b=S8VX7ldvK/nX4HpC5yNvX7bisCTzvxr8G8fJga3qz3/L3KD9YFkoxNy2iOhS+etTe24CN9TtEi3atnjSX8mjsJ4BhhiaXFCwiuJxMzOcSUNeBs5n7zaeF3qQO6wiYMX8yNsDHrfROBCtrTvM8nXGfRoPNGl03OdO/16AqHOIhNNzTuTFYwzIwCYQKAe5uo0eZCy0OaPMV43tucU7tn8fJ6lMwhxexs8mSIWhV+LJjjIZIi6Wu05rWr4lxmrbZqKurmOB0gmgjFvCNgz43pyuTlOSkVSmevM306XFW8ltAs9u5rn5SObUiWSEhkuD1JX8mSvNrylRx2eHXy8L5Sz57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+zmWb4hTKpQVKuZv0ZR/KdXbvLL1WHZn3oyjEXNHNc=;
 b=nZBbBINTjW5XukJTnPZqKrKoJyqjyAF5NafUQWfMyO0mcBGxm3HY9aM0hSzm5xO/xdGkin/jo7S2vaSvQjqkzrdM7ttQ2C0dReicglD7uw5ORb947od78O7fRNSRkftPNzRTvhYTi9WjwY771UySKCKflRgV1m+PhAI+NKoucEU3wEXxoSvCzkALpxa9HO2NtBguK2qLDK1OMg8j6/B+JEmB4PQGPL/e/leCbBkHy3LXniv+flHQNmVkMBNT2wG1psYohfKAJBFTXPL8BU0wcA1eUJaicIsljSEvJVN+vhsYWBlilCzJGwbZWTv+hHScCPklTeOaFhuZ7nONargZew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6604.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 19:40:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 19:40:07 +0000
Message-ID: <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
Date: Tue, 8 Jul 2025 15:40:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: paulmck@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <20250613152218.1924093-1-bigeasy@linutronix.de>
 <20250613152218.1924093-2-bigeasy@linutronix.de>
 <aFL1pIGMDX5DG9f_@tardis.local> <20250620084334.Zb8O2SwS@linutronix.de>
 <34957424-1f92-4085-b5d3-761799230f40@paulmck-laptop>
 <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0bb5ca-329c-46ff-9ba3-08ddbe573e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmYvQmpKN3FOWkhRYnhNOWJ4NjkzNU5oanRjYWJMWEhMV0h1OUZVRkNCYUlC?=
 =?utf-8?B?c3B0bXRZUTBvNGZSdWpabGYvS3dlZ0FGQ3pRZWNDWkpPN2JZLzRudVNQOEt0?=
 =?utf-8?B?b3RaZTh0TFhuQTl5aEFxVkZDQXc1V1B2SkpaRk5CazREdHJnUCtiaFk4Q044?=
 =?utf-8?B?SnZKV2tFNXpBeTEvNjJWZGxKZ1plbVVnaVJSNUN1YzkySkNaL3VseTRCSldJ?=
 =?utf-8?B?VFZDL3J3Vy9FeitXc3R1dFhJS3YvTU9RVmdhalVhb01pL1dweUxIUmFWTGgx?=
 =?utf-8?B?dTdKUEhvOFR5TFF3bW5lTFJXclNzaENrM3lyVXNzbUwrdHZLMElSQW9LYktw?=
 =?utf-8?B?M2x1K1ptQjhTbU1QZ1YxaUY2M01ZWWR3QTlVa09xT2FYQkRZanV2bnY4enhx?=
 =?utf-8?B?U0JlaXc2VktkTkFnUTBMZVk3bmJwS1d4dU1La2FoaFEyRkx5NGlmMW5ObDU5?=
 =?utf-8?B?STRmN0lZODU0TlUwd2ttTm5tTnc0LzUwaFVmb05pa3ZxYStvTlJrbGxWcjZO?=
 =?utf-8?B?ZG9UUUJkK1VxLzdid3gwUDBtU0ZycDg5NjZiMzd6OHVUL2YyYUVXMkN1cElF?=
 =?utf-8?B?MUFUOVoxbllXRHFLYmRyOHhSZThUL2ZsV1pkMlNCclJzY1I4K1VGS2FKMVR2?=
 =?utf-8?B?NnJLajllYnRJcEhhK054Y0RJSjNhOUhLTXUrSC96dFZGdWs5SGNpN1U1T1Ju?=
 =?utf-8?B?Y2Rnanl2ZjVVK3NmaWJaRnNYdjQ0SjVKOXNKWlpqWlBES1JJTDkrM1JWRVNB?=
 =?utf-8?B?VjNsajhaS2ZoNUVQc2l0ZG81WFRwRXo0bEU5VTFsRlR1em51ei9WT3VtMXNn?=
 =?utf-8?B?WXk3WDNNTTlGUXFmTDhTU3BiMCtzN1VkcVJZdlkrTmc2eXZpOXQvSmEwWnlh?=
 =?utf-8?B?d0ZNM1FyaDk2bFUyME9QVzRqR1E4enA5cEpDdFNrQnByOFEzbXR5UVZuQkM1?=
 =?utf-8?B?VTI3ZmgwQ2laNmk5U3REWlE5U3RZT3NvQUZTSWtTSjhRSTVLVVFFNmJmY0Vn?=
 =?utf-8?B?RDBoNWZVbTc3bk5xaTAwR3MzVTB6K1JIeWQrZHpHVXVkWUNzcE9hcndqdDUy?=
 =?utf-8?B?Tzg3S01SaXFKWGg2a0tHL3o2OUhZSFZNbmhVWEZyL2NHeHhwekZzekRlKzNX?=
 =?utf-8?B?b0pKSFFpZldWdThXSUxEbHpjVjFsNkUrNTUvZ3RTS21Ydi9mTU1rUTF1L2xo?=
 =?utf-8?B?Mjc3dk5USDBKYnRlT3pQVmRDYllCekl3MkJlM0VkUnJ1T3d0UGY4Q2t2NUxv?=
 =?utf-8?B?cHFaOHJSZ0FzR3NTeWtpNWRBV2Z3ekVqL3ZtSi9XVDhtejhHcG1sMFJnbW83?=
 =?utf-8?B?MjJiSTc5Y2REem1EcVNRRStjU3FxUXpFQTBtNS93aitHRWZyeVRLd2NmT3V5?=
 =?utf-8?B?ZW16QjFpdnY3Y2dZMTBMcDRXU3ZRWlRaZ21OMVhoelR0Q2svVGE1QnQ1MXRZ?=
 =?utf-8?B?RkVPaDdOSExGSzEyOWlGcWd6emdzdUMzR0pOOWlDOE84T0ZIZXJSajBqcEw3?=
 =?utf-8?B?clFmaDR3a0VUY0VmU0RTenJ4dHpBQlZFS3hkeXRkK2lOVFkvamUvSVZFNDdW?=
 =?utf-8?B?dzh1MStZeHZoRVdTeUVTK0JzcUtPUXl1anZBa3IrZ0E0Vk1iNkN1Q2xVdWg0?=
 =?utf-8?B?TFYvOUxIRE9XTU1YdVVmcHUrYTV5Kyt5Q08waFN5cE80alZZS3M4TTBreHpO?=
 =?utf-8?B?MU9FcVRiM09ZeHRpM2RDSENDSTVnanJ3TE92a0hnRU9hUU5vTHNKRy9JSXBa?=
 =?utf-8?B?Ly9LSXlvRzlPZ0U3YjRkTHVnTzBWbU1qRWJOQkwvMm12a1llbVhoSWZ3ZW9Z?=
 =?utf-8?Q?17hlq5monc+wJV2jVmKF846oDbJgqV+Tj7u28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXJoR3RRS3ZwRGlPSzB4eE96WUQvYmNTZ3I0MzhoRS8vSmZsN015UjhRNXZo?=
 =?utf-8?B?R0oyeVJveWUwbThuUnA2UllmK3QxQi9RQXoySnlTWExwVWo0YithWlNvUDNM?=
 =?utf-8?B?Zkg1Z09uSlgwY3NUZ3lQaFA2WFVDVmtuT2R6OEhSL291UUpVbzdWZ0NJdEhH?=
 =?utf-8?B?d0VhSTVuSGVIZGIyWnVrSS9URGxlYUIrME1BdzB5d1RYdDhGVExOQ1U2bzFn?=
 =?utf-8?B?TEh6dlBwM2dwM3pLUVVkN0x4cmlXQTloZStoOXlnZWFVM2lSa0JIU09qdm5I?=
 =?utf-8?B?cWRWQUIzOEM0dk5Pc3QxSzZ3U0ExUjVJRDRRL3QwbWlMb3FhVnBSbXgwdDFW?=
 =?utf-8?B?V3RRVjZoR2N6K2YwcStJOUhCVk11NGt3TGNUamNtSFIvQUFXd3YvSzF6eTRR?=
 =?utf-8?B?M3NXdVJ3endQdklucCs3NE11NWVXNzQraGkzaGdkd2hnVUVCejBiLytCdXl0?=
 =?utf-8?B?cVdCa1lzajJxNG9iVGV0bE9XQyt1UEs5K0hLTDU0MkVlVGdhVjkremdwc3E4?=
 =?utf-8?B?YW0vZ29oNDVCQkJGdzU5aG1lSUo4Yy9vajZFK204bzBqc05DR3dMNm9TaVVw?=
 =?utf-8?B?b2RtZkI5Y1hHcFdIajRGZkozc0oza0FrWUFpSEJBVEFVRGQvd2k5SWlGVWRB?=
 =?utf-8?B?SXRNRW9SdlFwT05NMFBzUXlGRXAyNzdjeEd5ZXViODU5ZUdyWXVRakFGOVkr?=
 =?utf-8?B?S09oN0JDZk92QXhGRE55Wko2T1pKZFUxK1FjKzZvZUxacWM3SFVjVXlPOU5W?=
 =?utf-8?B?dXlSNWNtQ3RKRFM3dFg4WEcyeUVIQ3JCb0tsRHdTSVBwS0RYRHVJY3F3SXl4?=
 =?utf-8?B?ODcrSEt2VnRmZGVLWHJkZnZzektYSmJsamp0MFpuQVd4K1ltdXcyWHRzTXFR?=
 =?utf-8?B?UEMyNERvaUZodm03WTJYajQvUUF1Yzc5QUZiV3phQy9rVi9HV0RPeFdWSU90?=
 =?utf-8?B?TmRJMTRxUzlld0hhYnNEdjZXK1lMWnQvT0RhTC9ZM1o1Y09SbURldXVmN1hi?=
 =?utf-8?B?V1dNTFc4TFNPM3VNNTMzTVlLV1RpdWdORWlVUkoxOXM3T2Z1aEk4NnJJTWRM?=
 =?utf-8?B?bUZrTlVuS3pzcWxteHpSL0RyYk1lRjJOdXBITXFxV2V0Y3c1TlRVV0Nmamt5?=
 =?utf-8?B?Z3cyN1lxZWxzYU04KzJqV0lBQ3VpSzBFYWFzS2dNWE9kelNvL1VwdTVXaG5u?=
 =?utf-8?B?S3NtRVRSVG1aR1luN3pUaEtsazErY1lJVjA3NUQ2d00yeXQ2UWJWd1NXdTFO?=
 =?utf-8?B?MFB5S2dKNnZFMFoxVWY0MFRmZHI0SFNGQ2IraFZFQVVMbXozcVJkS29raWtt?=
 =?utf-8?B?MkV0b1h3bzhrWmJ5Y1VBQy92eFNCc2RkMzlRcUZES1R4NFI4andIR0VSazRY?=
 =?utf-8?B?WXFvZmJvK29WUFhVcHdkTTFxb1RKMnk1Si9neTg0a0ZDelNleVRYMjFKR0hm?=
 =?utf-8?B?N0xvRmZFdFRpTld3VHRTaDlPbCtFMEtjcDBrTmYwZVVwanZHMkhNZjhRQ3pi?=
 =?utf-8?B?REJVZjRGSlIzNldLM294cktFcHBNRUVLM2ZyV3lsQTlZRnBocTZ4S1NOTWVw?=
 =?utf-8?B?b2k1NWtKODN6MVdXODdYbVd2R2g4SEVFckxEZUhGWlVURDN1TjIrR2FKdGRs?=
 =?utf-8?B?YUFyMDE0TjhCWWlxNWJZcEFwNUxHc3BxQkNSSm5TUlFFK2xTZWo3WVhzWGVE?=
 =?utf-8?B?TGtqMEZsU3RyRm1jb256SldLb2dRbTBlWUwzcGJmS21IalZ6dm1waU5KK21j?=
 =?utf-8?B?YU50WTlySkFqSnJQeisyS1l2aE5TL3g1WS9rUUtnUEZ3Y3Mva0tvSWVrTTlx?=
 =?utf-8?B?OEJSWDFvZHkxZ3JtVGVLQkdqckRQSWZJZit3TVVCc29Nd3ZLRDBWdHdSNFZ5?=
 =?utf-8?B?VGdjcThiT3dDSWZHQ28wQjBLeHVBMld6Z2xPeXFKMGhrelVjb0xIU0Z5MXg0?=
 =?utf-8?B?NXlNa2lGMzU2NnVZWXYvNGRvQnNjV2FwOHNvSFJhN0d2TnIwRk13NkwvdURt?=
 =?utf-8?B?YmpRVW9HRVF1MUVjdWc5bnpIZ2N2bGh3OG5ZT0VMZ1JqREZybFdjU0pvcFBN?=
 =?utf-8?B?WCtQYVRhR29CK3FvYkUvdVNESzhzejZPVk5JMm85cDhCRnhkR2lyUGtURzkv?=
 =?utf-8?B?NjJSV2RhQnErTmczVjJ2SkpiRWkwbnRlRUJMTFpodU13RG9GZzc4a2N0UUdy?=
 =?utf-8?B?UjNRU2lNdEJ0K2U5MHNwZlRaQ01tYmZtaEdSblU5RllSOXZucUdkK3VRcVhq?=
 =?utf-8?Q?oQNNXW6RWGHXmdTkbYtF5VdK7+4GZbAK6WwdR44oEY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0bb5ca-329c-46ff-9ba3-08ddbe573e28
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 19:40:07.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kgSrAe9sX2poTQP2zb7O2oGQphha9Sm9/8XW6LRzlqZY1aEiil35fQF0gMVXyK8aPXr3bl9ilRJNbFRdc8krLtIoAkiP9TOgUblGWssIvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6604

On 2025-07-07 17:56, Paul E. McKenney wrote:
> On Mon, Jun 23, 2025 at 11:13:03AM -0700, Paul E. McKenney wrote:
>> On Mon, Jun 23, 2025 at 12:49:41PM +0200, Sebastian Andrzej Siewior wrote:
>>> On 2025-06-20 04:23:49 [-0700], Paul E. McKenney wrote:
>>>>> I hope not because it is not any different from
>>>>>
>>>>>   	CPU 2			CPU 3
>>>>>   	=====                   =====
>>>>> 	NMI
>>>>>   	rcu_read_lock();
>>>>>   				synchronize_rcu();
>>>>>   				// need all CPUs report a QS.
>>>>>   	rcu_read_unlock();
>>>>>   	// no rcu_read_unlock_special() due to in_nmi().
>>>>>
>>>>> If the NMI happens while the CPU is in userland (say a perf event) then
>>>>> the NMI returns directly to userland.
>>>>> After the tracing event completes (in this case) the CPU should run into
>>>>> another RCU section on its way out via context switch or the tick
>>>>> interrupt.
>>>>> I assume the tick interrupt is what makes the NMI case work.
>>>>
>>>> Are you promising that interrupts will be always be disabled across
>>>> the whole rcu_read_lock_notrace() read-side critical section?  If so,
>>>> could we please have a lockdep_assert_irqs_disabled() call to check that?
>>>
>>> No, that should stay preemptible because bpf can attach itself to
>>> tracepoints and this is the root cause of the exercise. Now if you say
>>> it has to be run with disabled interrupts to match the NMI case then it
>>> makes sense (since NMIs have interrupts off) but I do not understand why
>>> it matters here (since the CPU returns to userland without passing the
>>> kernel).
>>
>> Given your patch, if you don't disable interrupts in a preemptible kernel
>> across your rcu_read_lock_notrace()/rcu_read_unlock_notrace() pair, then a
>> concurrent expedited grace period might send its IPI in the middle of that
>> critical section.  That IPI handler would set up state so that the next
>> rcu_preempt_deferred_qs_irqrestore() would report the quiescent state.
>> Except that without the call to rcu_read_unlock_special(), there might
>> not be any subsequent call to rcu_preempt_deferred_qs_irqrestore().
>>
>> This is even more painful if this is a CONFIG_PREEMPT_RT kernel.
>> Then if that critical section was preempted and then priority-boosted,
>> the unboosting also won't happen until the next call to that same
>> rcu_preempt_deferred_qs_irqrestore() function, which again might not
>> happen.  Or might be significantly delayed.
>>
>> Or am I missing some trick that fixes all of this?
>>
>>> I'm not sure how much can be done here due to the notrace part. Assuming
>>> rcu_read_unlock_special() is not doable, would forcing a context switch
>>> (via setting need-resched and irq_work, as the IRQ-off case) do the
>>> trick?
>>> Looking through rcu_preempt_deferred_qs_irqrestore() it does not look to
>>> be "usable from the scheduler (with rq lock held)" due to RCU-boosting
>>> or the wake of expedited_wq (which is one of the requirement).
>>
>> But if rq_lock is held, then interrupts are disabled, which will
>> cause the unboosting to be deferred.
>>
>> Or are the various deferral mechanisms also unusable in this context?
> 
> OK, looking back through this thread, it appears that you need both
> an rcu_read_lock_notrace() and an rcu_read_unlock_notrace() that are
> covered by Mathieu's list of requirements [1]:
> 

I'm just jumping into this email thread, so I'll try to clarify
what I may.

> | - NMI-safe
> 	This is covered by the existing rcu_read_lock() and
> 	rcu_read_unlock().

OK

> | - notrace
> 	I am guessing that by "notrace", you mean the "notrace" CPP
> 	macro attribute defined in include/linux/compiler_types.h.
> 	This has no fewer than four different definitions, so I will
> 	need some help understanding what the restrictions are.

When I listed notrace in my desiderata, I had in mind the
preempt_{disable,enable}_notrace macros, which ensure that
those macros don't call instrumentation, and therefore can be
used from the implementation of tracepoint instrumentation or
from a tracer callback.

> | - usable from the scheduler (with rq lock held)
> 	This is covered by the existing rcu_read_lock() and
> 	rcu_read_unlock().

OK

> | - usable to trace the RCU implementation
> 	This one I don't understand.  Can I put tracepoints on
> 	rcu_read_lock_notrace() and rcu_read_unlock_notrace() or can't I?
> 	I was assuming that tracepoints would be forbidden.  Until I
> 	reached this requirement, that is.

At a high level, a rcu_read_{lock,unlock}_notrace should be something
that is safe to call from the tracepoint implementation or from a
tracer callback.

My expectation is that the "normal" (not notrace) RCU APIs would
be instrumented with tracepoints, and tracepoints and tracer callbacks
are allowed to use the _notrace RCU APIs.

This provides instrumentation coverage of RCU with the exception of the
_notrace users, which is pretty much the best we can hope for without
having a circular dependency.

> 
> One possible path forward is to ensure that rcu_read_unlock_special()
> calls only functions that are compatible with the notrace/trace
> requirements.  The ones that look like they might need some help are
> raise_softirq_irqoff() and irq_work_queue_on().  Note that although
> rcu_preempt_deferred_qs_irqrestore() would also need help, it is easy to
> avoid its being invoked, for example, by disabing interrupts across the
> call to rcu_read_unlock_notrace().  Or by making rcu_read_unlock_notrace()
> do the disabling.
> 
> However, I could easily be missing something, especially given my being
> confused by the juxtaposition of "notrace" and "usable to trace the
> RCU implementation".  These appear to me to be contradicting each other.
> 
> Help?

You indeed need to ensure that everything that is called from
rcu_{lock,unlock]_notrace don't end up executing instrumentation
to prevent a circular dependency. You hinted at a few ways to achieve
this. Other possible approaches:

- Add a "trace" bool parameter to rcu_read_unlock_special(),
- Duplicate rcu_read_unlock_special() and introduce a notrace symbol.
- Keep some nesting count in the task struct to prevent calling the
   instrumentation when nested in notrace,

There are probably other possible approaches I am missing, each with
their respective trade offs.

Thanks,

Mathieu


> 
> 							Thanx, Paul
> 
> [1] https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
