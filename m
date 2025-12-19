Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021090.outbound.protection.outlook.com [40.107.192.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A491DFF0;
	Fri, 19 Dec 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154148; cv=fail; b=HI5lI1OGfQqZuIfnt9YTOVHXOLMNM1q2bcQYCkMsnJv2Y01eztyJZk0qdJsC5ECKCS/r/NqiJrXcmRJuSgGjNLtPo1Ynq82VlWraZ8mY1+g6v9jTOgKIX5A4CpLjFPPECOy2e66C6tmA/JDJJqkCfJPTCI8i560BElyMC8POaqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154148; c=relaxed/simple;
	bh=F8mOwZ3wXGSdyXsvDaJEMjHmdnoYLWJDf8IK71kSOZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jtWoF+vlSSqEy8mO0hhftV6OTFZe/yA22Wipaep5xiAhyCjRIQxmwocZrfgefekLEryLQQjbXIy/XW9zkNdfUiXmyKqhSlYN9fFfH6Bo7TUBGcHe59gThObjA/EF7V3Ph9BtysS1uVITp8qOYRIPzY4n8H3xOn+JzPCbx2LY6Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jt2PKMVr; arc=fail smtp.client-ip=40.107.192.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jt2PKMVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTJ5e9jnEP5ly0zGSWcpPpwCYNNy2p7NzhD5c59pCLVBnDIFkbUK6LtkEcgYvLQTY4IA17o/q2TqRFwh5+8Sww1C9fZk4qTjNRmsnOjp9JDw9gJ2KvC3efb9EdBwmNzodGpglzCDdpnSfX+vNdJuF44zczqEVuVTsvRk9CpeVSWitlQO59a0o955O1EkPxOckPi5ma+4xrenydy4I0DI/I83vH6eizCKn/TTcmJcENfn2VN62TpwTCJY5UvF1idYwym3M9Mdkt7xojXLtZqCYn7wcbKIu9K8I9ji8yI9EkkK4LU/ctjI34tdclr+N1MKT62HSvNaOrxZLVvx8c7utg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vePLcap2Km5z31jF7kDANZ1xoxZBFjTG1PoELWkQnk=;
 b=B6SOsnQO93TabXqVwaNti7pYR8QGM04Iq2kFNrIU7ow5xqlTa8cHuqIFqAKVYfdJgSNTSqABxemYU1vJHdeSZc98WoW+al6jpDLiJNVCJaNIc4q5BaxY3ND9NFxiZvqEmIGtTz0o/RbsVAGYOJ/WAi4G1WAL+K7uIUqw5VTVsG1Pj3dcEv8H8JF1X2zdj406BcgsAC4BMMq/giGNvb280WnpLCmwIByawY6AUoQK3lKNoX/aHuRkfaUTr9xTk18xalgzJZV8SrC407bjQi0U60vrbezC4AMRT/3aehsdbjM/CrJhl/HbFdcV9MvX3ZltILvZZdgcfRDDUnCo+yK6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vePLcap2Km5z31jF7kDANZ1xoxZBFjTG1PoELWkQnk=;
 b=jt2PKMVrp/Wk6OqJ9kTeBeOaexXx3ZflN049YHK5Dd5qu/AaKYeE6zienbHARC2D0VweYp/saJjTvP3Ia6NbOfFdms90zWWTbpXaQzNjipzJ7We1wTnxcBokZ+kRO4rHBDJ2pLg35K/CLJqklxIlyB9Glq/ESHIrf72BilOSkbHkgesKJ9t9vlg+MCZyJjx3/ZUfFpRObk+MJ/ACkWaw1OKesfdz7a5ASjWCOJqp4zR9oWuXh/aRmZMTm5S7PrrBzcAR3inOXiBLeseAOIJ/7+eKcMgTfmaZ+UmsowdlfVBfoxBtbzaLE9rV1Dmf2INXsU7vIwbpZDmlrEjP1iNrew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPFF80C66F7A.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::6aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 14:22:22 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 14:22:22 +0000
Message-ID: <6c96dbb5-bffc-423f-bb6a-3072abb5f711@efficios.com>
Date: Fri, 19 Dec 2025 09:22:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
 <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>
 <aUO9KRaP0FXpm_l9@tardis-2.local>
 <fcbc99d0-b7c7-45f7-9cf8-f5d3bfad966e@efficios.com>
 <aUSfu4V9mrD7BQGl@tardis-2.local>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aUSfu4V9mrD7BQGl@tardis-2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::10) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPFF80C66F7A:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3b911b-1bd6-4aec-16d1-08de3f0a0621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VElMSDRWOXk1MmFoSlk1QUVCYWtjMUhRd2VyV0RMdzdET3cvWW1QdFN2cjIx?=
 =?utf-8?B?Vi9MalZ6N2JnSXZOT1BvNmpmS01ReUpudENUR3ZDR2VOdHFwTFFjNkJkVkhv?=
 =?utf-8?B?ZytQTE8vazhpc3JlaWN6SG11SmxEZEZ2c0pPaHBTTXJ5Y1ZaK1NqTmczSnNQ?=
 =?utf-8?B?dkpDVG51bXZXSEYxcG8rQmIwMzhIV2hidkwxSGY5K0FzaXJTempTUDRGbGNu?=
 =?utf-8?B?SWNxcEFTQnFRTmxLbTZSSFg0RExrQkxrZ2ZNNHNpc3RnZlBIT2JJQS9nTk9M?=
 =?utf-8?B?R2FrZUdrMFl1TXlzL3JyTEs3c3pzcjRpL251S295cE4yc2FGRHlXbHg4Z1dt?=
 =?utf-8?B?VXM2NGJGMnY0OWdtWmo2a3FXRVBPSjNpQmxrdDZRUFhjbjN3NUE2RHNWd3Zk?=
 =?utf-8?B?S1hBclJRTzUwYVV0UEJvOUVEUHhBV2Vnd0xTVnBWTGhvbXRmczhrQUhJRkxW?=
 =?utf-8?B?UWJvNzVPQWwyWHlDQ1RNaXlheEJ2WE5aUU5QTS94S2hxR09mWVBVL2Y4dS91?=
 =?utf-8?B?Q3YrRnQvUnVSby90cU9ETU8xaUZmSmkwaXhsMWZIVEM1M3ZZbUVwMFRTKzFP?=
 =?utf-8?B?VEw0bDJTUGxZRXBhaGNXcVVrMEZldGh5ZzZMTFpyRllnVDZBT0lmZUFYK2F2?=
 =?utf-8?B?SEw0OGpVRUlHUWJXRjVLMXRmTWNpT2FSN3oxZEJYZmZYVk9nbUpmMk04OHNw?=
 =?utf-8?B?Sk5MTTVCK2hkSXVBNVJiT2k0blNVMVk2NnVpV0lMMmtFUFk3Q28xUnpFbncw?=
 =?utf-8?B?bVduL2NockxxcHU2Y3FmN1JFYWNmRWpranpOYTZqdW5VQ1I1eWlqNnJoSVlN?=
 =?utf-8?B?OXIvMXo4RHErWHJRb3hPT3ZVYVlmQnBCK29vMzRpRjF5SkoyVTVyZzJUb1V1?=
 =?utf-8?B?amZVUnBhUmFWT1ZWU29SNEkzd2NwTU8wMXNUV2ZZZEsySFB2dEl1dUhqMHN5?=
 =?utf-8?B?ZWFuNjN3RlczU0lqK0FjK2E5NndjTHNWMjI0elAreER2K1pMbGdtTGNKdE5H?=
 =?utf-8?B?OFVVS1hIdE11M2xKTVFIT3E5VmlXWE4vNlZuVzREamRDdHF0N08yeWQvQTh0?=
 =?utf-8?B?d3g2MS9hNVRNSE1jMm9XUVZoU2Y1aWZwSjNlMEptbitiaFh6ZFovWlJnUjB5?=
 =?utf-8?B?NEFlZi80YnNZOWk1Z1l0WW0yTTJ2anpnY3BxVERBYTA3S3RkbnJrdEhqSmtt?=
 =?utf-8?B?YjU5VjBOYlhlem9XcHZBQ21CeTZPaGZEOFMvcUZCdmZtSklzREM0YytQR2tC?=
 =?utf-8?B?Ti9MR3p3WURnR01HVEpnaXhMQ2RpbmxsZVBSMy9Vak00K2ROeDdzVnRCVUJF?=
 =?utf-8?B?NldvOExVZXE5dFlOd1NkTHV5ZkpJM21LL3FGNEZrY1A2Zk5FL1VON0dVaWNa?=
 =?utf-8?B?eExmTU1jMUhqS2dLQlJsWFFMa2VOYXBsbVJNZytTaWFlQkpMS2VmQjlrM1FX?=
 =?utf-8?B?WklTY0MvOXRQdzEwRHpzZlFTQllMejFwT3pVUzFpMXNCNXdvaDIwRkpzcWRt?=
 =?utf-8?B?eTVLN1lCbXl4ZmpycjYrbmZFNGd3Vlh4c3FReW9rSzBWYk5DL1RsRVRmZ3kw?=
 =?utf-8?B?SXpTRHB5ZW1uRWw1eDZmQ1B3VUQ5NGpxRTViVkE2aFpORzhnVmE2aFBGRzBD?=
 =?utf-8?B?VWxXbitXM2RQY01aTlljUFR3d21lYVlCV3F3dmxRK1YwUyt1TCtLOGptaEpG?=
 =?utf-8?B?QnlQZUx6RzQrRGR1RmZwL2RaVXR6VkV2S3pHTFBNeHNpdlU1cGVNV1JneEtq?=
 =?utf-8?B?UllFWTJEOGJ1R3N2enJwSFh6cytyQkljcGdmenRvaXFtNmlBemlic01tMHhp?=
 =?utf-8?B?OGdKU29jRU92VWhBZTNrcTVLWFNsa3lObUVJTTJ5UkxVOG1DeGUrd0c5cmla?=
 =?utf-8?B?SUVRUDI4V09hWm5jQ2p3ai9zcHl1Nm1nN2U1ZTN6UlU2N3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clZaam5HejBHTXh3MVlid3NITnB1a3JxL2RvT0JGSWFRVkp0ZXgzRW1PVjlF?=
 =?utf-8?B?VDNzU2wxOFI4dmRqZFlwN2ZYZTV3emxVbXV4TGhEdVh1L0ZKNEJ3SW9PdUl2?=
 =?utf-8?B?RmdBdFVrQ1dkcEhoOWFiS1ZYeTFtSlFSVWFLYWFFWXZoQis1MDdPQkJreDUz?=
 =?utf-8?B?Mjl5S2NQVzFldHdTZldxQ1NPQVgwN1RNbk4xL0x5am1qTXZPZ1Q4QlI2QnBL?=
 =?utf-8?B?MmVlMXY2bGxxUy9LVnpSblhjZFEyWTNQTnF6YVJweHVwUFFsa3pPUElTb3lZ?=
 =?utf-8?B?VlZPY3FCb2V3aFFxbGw2NVl3TXRZRmZ1Z0VqMVJPdEN6Znp6YnJFS1BOYVR2?=
 =?utf-8?B?VGo4MDVWYVhlU0oySG9pcm1KODcrMmJWeCtQc1lmQXZhRmYwWjgvbEtUOTZn?=
 =?utf-8?B?R0hJMDk1RHZ5MldkU1cyN21uMGxxTVhESkFYNzFwTnk0T2ZlRlNlMXhudWl6?=
 =?utf-8?B?YnE4SU9XWDhHRm03Sjh3RU91Mi9GYzJQMStBcnR3WU9FQVZCTlkvdFBCWkIr?=
 =?utf-8?B?cnZENGdLRlBkbllOdUlHU3loR0NCd2xqc1haOUNtcVZzVVFwUEcybTVWRG15?=
 =?utf-8?B?cGJMdHo3OW9qWVJGM3ZGaHByYkxUNXgyUzlyUkU1bGpvKzc5YjFoMytRRzdi?=
 =?utf-8?B?SnNyVnBuN1ExVW5ZTXhzTEdBQ2p3U2ttK1dyeDR6clRDVkxsQkRkNWl1UzdV?=
 =?utf-8?B?YzIzZVFZY2k4RlRrc0ljMzgwWFlsZDVESHJ3WW5HM0Rnb01sN2NreFRXMEZZ?=
 =?utf-8?B?V29CVkY2YmZXdlpVT2VSZmg5aWlCbUlsSWxKblA5Rld1OUNJdmM1UTR3SkV2?=
 =?utf-8?B?eExzQW1qZGt6Ujh1dVppMm5pZm1mZGxLcHJaNkFMdFVYblZNTURTd1B3OFg1?=
 =?utf-8?B?U3RWZG5JeFNtb25xVVczSDQxZy9MamVUYnE2L0FnRVJNcnJrSDJXZHlCanpn?=
 =?utf-8?B?SEdQYUhhOWZ2Si9McXliZElrL3lJQlJFZTBmNVNJbHZySDNoYzUyb2xHcnow?=
 =?utf-8?B?NWtmejRFajB0a055d0RXQm9LU0ZYc1UrelZZSE1tTjlJSFU5a1Ayd3FzVlNx?=
 =?utf-8?B?YzMwYXI4UmxnRTVSc2llQzFLZEdlb2RxaUphTmRsR0tvZm5GV2xWeWZYeGpE?=
 =?utf-8?B?Tkl3cnZuSUh5L3BOQnloZXErVXhNWllROXZPdk5nZnpOSVh3cXRaZzNHTFU1?=
 =?utf-8?B?cGo1azhHYTNtRnBaY1NRcVVMc24wT3Zxd1loVHptKzVOcTd3MXc3Z3NnMmpl?=
 =?utf-8?B?ekNVaTFoSkF6UjVrdys2SXFObkZaNlpqSXlqN2JtWDJzTWw3a3lZYWY1MExM?=
 =?utf-8?B?eHBWckY5SWkyeWhxUUh1V0dsakJTcS8vdHNaV01HajFkbHJqQmdHMU1zSWRl?=
 =?utf-8?B?NXRHaG1SUTdleUVLajB5RDhBTitHQmVHbFRHVW53M0RjK0NqSW85b2llT3hD?=
 =?utf-8?B?cEhUV3Y2SzFBeWQ0M2I0TW5pdVlWdGdSR0kyeHRKUmZETWtMUlI1MWxkQlJW?=
 =?utf-8?B?ZEhucXQ0V05tV0dQVkg0YU9DeGxwdlRwbDJyY2Z5MUZiSFVxWmdRWVVIZnpD?=
 =?utf-8?B?Y2xPM0xzNUJxaVpqaEtPYUVtazE2Ny96bWJMMFdUL3p6SEJ1LzREY2tKdndp?=
 =?utf-8?B?VWVNaUNzWDdUQVVDNXZkSUdMQi9McEZYWWc0eGZJR2wyQnhFb2MvRnlXWkZi?=
 =?utf-8?B?R2tKcXZXQkp4c2d2dHpQR01lNmpLMVlpYUdqUjVtUGwxblRPcCtxbno2M3BP?=
 =?utf-8?B?djN0UWpoaFZoTjUxYWtYTm02dFBkUE8zQUtBdnhoaVg3QTZqVHUzRzRWSi9I?=
 =?utf-8?B?ditkRGxvRkZGWGFLZ0V5M2RLYldZaWNZRlJ3cFlnd3JjOEk5bSs0Q1ZQcFZK?=
 =?utf-8?B?V0UyWDhzN0ROVDFTejgyOFN1cVpmVk01ZU1tU0h1QmZwcitWWWk2dlJ4OFBU?=
 =?utf-8?B?OTh3SWtyVEV1UW1nY3EvOHNObHVJcEhaQmk2bW9xeDIxa2QrQ1RNZVBnUmM5?=
 =?utf-8?B?c0haSlRiY2NEc1prWHcvOXE1a2ZzV2dLTU1sOFNmbDNpdGNNc0lWSjM1Q3J0?=
 =?utf-8?B?eExvSzZCTEFzb05IV2RUUGdHdVEzVFY1b2dPejhuWGZZYldIb2tTYzBkcWpn?=
 =?utf-8?B?cENtRUU1akRwQTAvR3Y1YXJmb1BlalFSWEtkbnlnYStkWmo0SW5iS1hyV1Rm?=
 =?utf-8?Q?BiJnup56XTGGx4M5MtSICqc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3b911b-1bd6-4aec-16d1-08de3f0a0621
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:22:22.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyodyKw+AmD5HCofS5yuRIEs2hEcbXrYAmahIW3a+Qs68Wm/a48ZcmDEL45Wi4htShrbTidSO7l7DedJnyu165EZlg4nSeAyXwyX+EL10yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPFF80C66F7A

On 2025-12-18 19:43, Boqun Feng wrote:
> On Thu, Dec 18, 2025 at 12:35:18PM -0500, Mathieu Desnoyers wrote:
> [...]
>>> Could you utilize this[1] to see a
>>> comparison of the reader-side performance against RCU/SRCU?
>>
>> Good point ! Let's see.
>>
>> On a AMD 2x EPYC 9654 96-Core Processor with 192 cores,
>> hyperthreading disabled,
>> CONFIG_PREEMPT=y,
>> CONFIG_PREEMPT_RCU=y,
>> CONFIG_PREEMPT_HAZPTR=y.
>>
>> scale_type                 ns
>> -----------------------
>> hazptr-smp-mb             13.1   <- this implementation
>> hazptr-barrier            11.5   <- replace smp_mb() on acquire with barrier(), requires IPIs on synchronize.
>> hazptr-smp-mb-hlist       12.7   <- replace per-task hp context and per-cpu overflow lists by hlist.
>> rcu                       17.0
> 
> Hmm.. now looking back, how is it possible that hazptr is faster than
> RCU on the reader-side? Because a grace period was happening and
> triggered rcu_read_unlock_special()? This is actualy more interesting.
So I could be entirely misreading the code, but, we have:

rcu_flavor_sched_clock_irq():
[...]
         /* If GP is oldish, ask for help from rcu_read_unlock_special(). */
         if (rcu_preempt_depth() > 0 &&
             __this_cpu_read(rcu_data.core_needs_qs) &&
             __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
             !t->rcu_read_unlock_special.b.need_qs &&
             time_after(jiffies, rcu_state.gp_start + HZ))
                 t->rcu_read_unlock_special.b.need_qs = true;

which means we set need_qs = true as a result from observing
cpu_no_qs.b.norm == true.

This is sufficient to trigger calls (plural) to rcu_read_unlock_special()
from __rcu_read_unlock.

But then if we look at rcu_preempt_deferred_qs_irqrestore()
which we would expect to clear the rcu_read_unlock_special.b.need_qs
state, we have this:

         special = t->rcu_read_unlock_special;
         if (!special.s && !rdp->cpu_no_qs.b.exp) {
                 local_irq_restore(flags);
                 return;
         }
         t->rcu_read_unlock_special.s = 0;

which skips over clearing the state unless there is an expedited
grace period required.

So unless I'm missing something, we should _also_ clear that state
when it's invoked after rcu_flavor_sched_clock_irq, so the next
__rcu_read_unlock won't all call into rcu_read_unlock_special().

I'm adding a big warning about sleep deprivation and possibly
misunderstanding the whole thing. What am I missing ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
