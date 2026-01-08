Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020094.outbound.protection.outlook.com [52.101.189.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0529827E;
	Thu,  8 Jan 2026 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890716; cv=fail; b=mLxtDokcwfprtC0IMtASu2GsioEQ9hfc3dXf2MdjdGdyhURN+0bxs7ZEqP7bk/0X/hv6IKVNW3qbInFVeWnj8g2tXbId0toBOPFjXJzvcgHZEOP1ELs3NioSj6febQbBoC91nJ7rkYZ6YMF5+UPUdvCX+1XLP2EWSb3JjHDmEUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890716; c=relaxed/simple;
	bh=Wzhpw1QUWM5A78baJfmefinqggxCHK8YXb3sHgvsv+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nDJKC8AAnquOp7ymkr7rIom2r9GRBL/qwWu5BWX/iEFzwG3L2j4wcr2hlrSph9wztpvjiydU4fLAWtXh9hUFR6mLaIY8raZO7BH9qLZbAyeRXlaV5dv6OpVCilRAV/L1wP24xQwr4GNG5rm+AEVRwPL9eAJQUF+AmSxfbaDN/IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=t805U/73; arc=fail smtp.client-ip=52.101.189.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="t805U/73"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLr3FacOhDHEFwNcRYP9P2DbVmI4JyPMiiWJr0XWlkXJoS78vK8MkK/ObjO9iHmDTFXJrwRWjQo5nwWiMNUVeQcdwFZIiYiJFES17SNL+Q1qmSFE2L6LSY4nUA9SRkjJOnL6DlK36PKHrW+Rqcf0vncJ6vaP9iyY7d6CKL3jS2+H4zijEdklJ7YydXlQ6rrCx3OLHwbaWbcDOmYkqmjLJBR2Ofvq7aWo2zDc5iW3/SF3arbrcWqyOPZT0g9N+G5EMvndcI1fPruscgqs5LdJGSUlaW8AWSWN7wtqu6J6JaPdkNl2PGkg5GS4msfU1W18LvQ7Tb+LVEz1Q324WGAoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQRsfdiHtQlOsfPLtu1EBiC8HHE5rV8i/JxC+Lnyd+k=;
 b=VJryQAlea4hVR4xoYHf0HGBhmTPtfqy+al9H7nXZRcsS6vNocDoUM/UYTzWoq8BDaeMnZ7h/9rl4OlQz258vGb31g5n2wNJ780dUL4VragF1o9GajDBKKNZkUs/tJad1eAj9hQ2WqTrq1qYp7/qjLR5ddUqyOaM6SB+/MqYjU26Z/iINg3HSoWPzlC0ghlgj5B3D7sKBcOKLU9vdeyorPT1deTxxw7GdITymDTxN++6OmEWNlHnlAEyuLmGzYDwgGVms25NaaTQJ8u53BtcwUtrDTHpJQslZOubSiio6hddzKjs0mrBs5asDQCPi84Yu8BogUWTumk7SyKmcXrV6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQRsfdiHtQlOsfPLtu1EBiC8HHE5rV8i/JxC+Lnyd+k=;
 b=t805U/73sQ2govQdHspY5q9ptsr9pJBk4aDyTM/65+n6h0O3L176fXxgEGqFUsOfRhYftSBGtYZBGFlI1p9tBCDkdyc72lomh+pfHLbwwbrqiKnkCJO5rtWJyET+b550KyohooG/r06urw5H7JybC+HOT6qPD+E22esoNS2ETrR1lTMYvJ+1XMhupghphhcb1rcVOTiAMEiN/jRynoiFCpt6JavemfAJj2RSAK7cimH6pUzNxbCywumUd+s7mecBxQpoEqJ7SLPY7KlhTFtZrzD6cJICs/9tVW8Dzrk47ukSDYA/8W7oANMPJXXh7j91bMbEtLJRs+agvTvSQwahYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8578.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 16:45:11 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:45:11 +0000
Message-ID: <fc0eaac9-930f-4692-b913-80e48dcdd301@efficios.com>
Date: Thu, 8 Jan 2026 11:45:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 <6c96dbb5-bffc-423f-bb6a-3072abb5f711@efficios.com>
 <aV_cms1mCPYq6jah@localhost.localdomain>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aV_cms1mCPYq6jah@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0314.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: fb14e212-da20-45e8-7b33-08de4ed549fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2RTc2VqUzFsWXFYMW8rYnhicXY1cm5zN20weDJtMndic3gxcFV2bVg3anYy?=
 =?utf-8?B?OU93YkUxSTVraVpzZDNvU1Z3ZVBqSklTWHRwR0dBbC8vTStBNEZBZzE2c1pJ?=
 =?utf-8?B?bEF4QVAvbExZREozM040ZFNWSDk1T0F0YXI0UlZBa1gyRXFIYktUQnJKLzN1?=
 =?utf-8?B?RlZwcFJCemh3MXc2S1FLZUh5QWdHMVpSTnBFbWNpbUFtYTJmZzZlSDRlNU5P?=
 =?utf-8?B?VU1QY1hidWhuaUdwdjdTRlQwWnpxeWovVVRORVFrSnIxeFg0TzU4VW0xRWti?=
 =?utf-8?B?UUhJb25nQ1ZkWlBtNDBwaGdETHBwOW9oQmp1dExkdmpZVHdITXF4Yng5emRD?=
 =?utf-8?B?SnRESnNnRzIxb0g4cVVwUkxqZEpvcmFkSWliWkRLMjdLMkFtYmY1VCsydlRM?=
 =?utf-8?B?L2s2RFpFNUtqSitaem5jQmIvZGpJcU8wSUFJMHhCVmdNRnpGZWIwYWRUclRM?=
 =?utf-8?B?alNWeVpwVGo0UFNENE45djJrdE8zSlhEZGxwZS9aZGlFcm5CejlyTXBCZ3VV?=
 =?utf-8?B?ODI1L1ROemVueHFBcjc5N2ljWEJrSng5NE9VSHRyUFlVbmh4ejhRRVF2Q2s1?=
 =?utf-8?B?TUZYd09BNjQzNkJpYzNjYVBzVEJBRkpUQWhiY2pTbGRJMTduVnhpQkZkUDEv?=
 =?utf-8?B?YVViRHlhSGdoSjBNNVQvbHZibTBRK0x1SEo4MzJLNElsSG5paVNYODVXc0di?=
 =?utf-8?B?S1d0Q3ZKSWxzM3Z5MVVPOVBKUEJKTmNkQkNzb1RzeUVhUmdWOTUxTnBreUhU?=
 =?utf-8?B?NEoweHZxSkN1ZVNQeWJPK3Rkck8rS1htMHhNOWxYUDgzSEM1OXJDaVMrK3U0?=
 =?utf-8?B?cUM4SUljcTJNVnlVWlBsQ2o3TDFvQ1E1M3laeW1Yei9temxsVWNMdHBOMVEz?=
 =?utf-8?B?QVRZaXlDaU5IY3JFTFM2NEJiWXVQWHUvQ2ljOCtPaHVXMzJIVWlFeGNMVXVW?=
 =?utf-8?B?MkQvdm05akcrWkRjUS9qTVluWHFFa1h3Sm9WUXZ5R2V6YUJNaXkzaG1IZEkw?=
 =?utf-8?B?bXVGYUljOWhtOFRDLzFNR09SejFjOWZBMDhaMkdqaVVJZVdRZU85dVMxK3k2?=
 =?utf-8?B?OW5pUnlvTEFWaUFrZEpRT3BYeHdvWDVoWHdKTWd3Vk5uSzFZbXBwdmM2M0tm?=
 =?utf-8?B?NUk0WitWWFNTc2hrZDdhRXFSeFJRblFwNHc5MjVIcDBPSkpya3h4c0JGVnZj?=
 =?utf-8?B?dHR5U1lSc2E4cGl4YlEwdjdwSUIwNlZqRXljcjN1MlBhU0Z1TVlUQ0twOXYw?=
 =?utf-8?B?cVQ5NElJRjJqOThWaGJoZnZZdkVmUVV2dXR3N2lLK0hDQlExcDFjTHNlZ1FX?=
 =?utf-8?B?MDQrWGluRDFENW5EcGh5Y1cyNDczWVlCc0ptanlNT3ZvY24xOFlVTytOeVZ5?=
 =?utf-8?B?VjN3a0FLbDdUNVFSU3k1ejRuUm03aFdrS0QzaEw2enJXckhNSGVPOEorcmtM?=
 =?utf-8?B?UlJLNHNPcGViTDRVemhwTTlIOUN3VGZjMFJXTzdmMWhreEFVMWFRY1VTQlpL?=
 =?utf-8?B?d2RRK3lWcFp5cDdEeVVCTTRQMzF6amxTc1llTEpOWFU5VHhFWmhDSk5wZDVa?=
 =?utf-8?B?RnV2YS9laTF5T3lZd1N0dnZ1NkRNVTRhYU0wMkluc0lhKzk2L2FJRm9DY2hy?=
 =?utf-8?B?N3ROeGpLcFRlQmpHc044UE5WRFpzZzltV2o3ajlheFpybEVKTi9tT2xzSWhT?=
 =?utf-8?B?Y3piRWpuR3J4UndHUjIrM0hxekxWWU9acnpGbFZxQ1RIbWxNSDdLczh6RmxM?=
 =?utf-8?B?UHZYMGt4NldxT1pDZWd0TjZsMFRVa0VBbmJiNjZyNUN3ZThxWlMxVjN2bUVr?=
 =?utf-8?B?UzdDQkNFSGlFWnpXbDNFTFkyYXFzdzZuYmZyRUpWMGhYTm9WSUlBNEpkdS81?=
 =?utf-8?B?b0RMUlJmSFRjRVhTSk9ZaHlaeWZjRXNldEh0VWxPUDM0a3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk01WmhwelV5SlEzU0h4aHltQzdWMDFyMktrMVF3RmZjVDkvbFBwSDBuTWpo?=
 =?utf-8?B?UDFqSGFZZDdKNmRheGQ1SGp5cnp1dXlVb25ZZk96blB0YjUvbVNxREE3OUt2?=
 =?utf-8?B?OHByd0s2QVVDMkhnTy9xaXpSVGhJd3AwMGhqRVBTRGw5b1ZhdnJud1NTZkZl?=
 =?utf-8?B?L0t6UHhZNmFVeG9pby9CVXV5WDVKUnJLb2JMU203ZnpoMlErcEhVdm00SVp4?=
 =?utf-8?B?ZUJQbVNYVDNxemljSVBvS3E2eXcrVlVpOEdibU5ncWZzTVN3M1ZXejdONHNX?=
 =?utf-8?B?UlFSajE2N0g1WGRqQTNNblN3OW80VWNEbHBLWTVudkllbHNUbG5KZWhtQVA2?=
 =?utf-8?B?Yjc1KzhHdit6ZUdxaVI0YkdVQUxyNVMvTkhsVS81dzdmQWNCN256MEVhTnBx?=
 =?utf-8?B?ZlBySjFWSFNkekZSM1lDVlZ4NXhTb1FlQjJwNG9yOHo0anpMWmwxS01BN1du?=
 =?utf-8?B?OXBmV3h0U2lzM2tYVEdKbjhKNUVuNWZMK1ZSQVpMQjYvVUI3RjZmVUVMK0Jk?=
 =?utf-8?B?b0VuWHFQRTFJYkJjTWVtcHg2RSs5am5DYVVFZDdubGk2d1FSWm93d1ovRFlr?=
 =?utf-8?B?b0FKM0Z0NVFPdnRiSXRnWGU1emFkVEx1RWsvYThLb09yUi9rS0hRQkpDaU9z?=
 =?utf-8?B?Q1YxZjRBL3JQeXFWMUdHcXhlc1I4QTNnL2lCeG5GRlhpcFBIKytQM014bm9q?=
 =?utf-8?B?OHhpVEEwNDNYa3lhNStmOVV2aFVPNk02UWRYcC9rL2lQbm9wRGNkeURGMm84?=
 =?utf-8?B?VjZtUVFuQ2VYem5Gck9kWnlhdjVPSFBxV1AvZUFza0g0b3FZSXVnbklxcDk3?=
 =?utf-8?B?ZnJCTHErdHJmUjZLM2I3TE9TVXZhbFc0OFVwVWlqYVdON29kOGxHSEdBS1Vy?=
 =?utf-8?B?YThSZEdPZ1N1R05NaXJMVU15NCsxd0tpWXphclJVdEd0T2R5cG5iM24vT055?=
 =?utf-8?B?WUxteUVjWU1vSVI3a1VsbmdjdTkxVm9QSnNmVzZhd3VxZmMxUWhRNi83a3lN?=
 =?utf-8?B?TTdkODFRa1U4S3FXMEx1bWVtUmlveVpJWjN5Q1JzTnhWM0dCRDIzYVRUS2V4?=
 =?utf-8?B?dmVrbytwZDk2ZFZkYWlJZEdhRW1zWEE5bWptVFlQbisyR2JHQWVVMkJGL1Bu?=
 =?utf-8?B?Z0R0M2Q2b2Z1RGpEc3RGaGRrWFpjUTNUOWg3SkZzc2tBUjZHM3FTVlpDWVdj?=
 =?utf-8?B?RTdrM2RtRXZPSTl1RzFsTXFPZ2ZHSTh3SHZTaGFJZHpJRmt1N3ZCR0pDTmpH?=
 =?utf-8?B?WUFtT1FCUmdYOUVVNzFXaWZJeXpLb3gwR1hMdW1aY096d21OM0xkZHMyRDcw?=
 =?utf-8?B?MHlLeVErUzQvMkMwczFzSDQ0M1VuVDk3NTdnU2lUQ3R4bHlXa3pML1g0VnFO?=
 =?utf-8?B?WGpsaXdMVERZbml5eUh0QU9PaGJBcHJSSUJMbUplSzZTWXc0UHM1dEFQenNi?=
 =?utf-8?B?RGw4VFdjeXZVb3dtS3lEVUVYTkhnazhUajVoOWtXV2ZNckFNK2hXZ1F0TjMw?=
 =?utf-8?B?UERzVnlkNXZPQ3lZb3dubms4Z1NLT3dHdTJiV3lOWUJZdjdZdDRrS25ZRkNT?=
 =?utf-8?B?bE16RlNIWG53ZmFHWm9WMkliK3RPRlVMRXVTMWt2bXlsMjYwTFBMVlpqNUJp?=
 =?utf-8?B?SUJWdmZ3TUlibTdlbzYxLzNhNTZmaUhsekdRTkhOSXdZeDBKS2VLZTRoeTFW?=
 =?utf-8?B?bGY2SHFHTTFURmNNZk5zS3hmVEdmeDBHMzRCNWMwQzgvbFM0LzZBMEpWNGU4?=
 =?utf-8?B?bWtiSGZid29sTGlRaFhXNExmK0tiVVhUVTBNaFRYRThZOWxqY0FNR3Z4eEQv?=
 =?utf-8?B?bmE1cElPeksxMnU3WXlmZDFwV1hrUDd2cjZQYUhFMmVnQ1lCV1BsZUliQ25r?=
 =?utf-8?B?V1ZrTEZPa2RSelhmcVpFNERpb0g5QlBzb1JmKzVjQ0tHNUg5VjFCYXFrYzhz?=
 =?utf-8?B?eDZjUDJMY3NNWUdqbUdxbXpzVElBV2lpRWxBa3VFcEs5b0sxR3RRL0VZZlVV?=
 =?utf-8?B?ckRQbWRNU1EvOWxtb0h3eS8yZWxMT3RVdGVSM2YrZklOaW11ajZKd0d5NVAr?=
 =?utf-8?B?Vk9KVHMrU0ZiVUFrZ1hzamRxVDN1VUEyZnV2R2JqQnIxRDJFTDVlSlBUZXVj?=
 =?utf-8?B?VDlzMlltbjlERHFEbHhBakFiakttZDVGZkZwM0lPU2JaOVFScmJYRXEzVE5l?=
 =?utf-8?B?dGkvcGZSdktlNnI5MSs0NDVwZC9IMUdweVBJWFh4cXgyUzhNcFFxc25taWl5?=
 =?utf-8?B?TzBNWkR0Yy82N0NDY0loL1RRajk1dDUxdkFUajNwdnB5ZjZENjFNNnBpUjNv?=
 =?utf-8?B?MWV0bkV1NDcwTDg4VU1RRWdGYkFxN2RXS01LNFdjeU1IRHRWQnRDem16d2gr?=
 =?utf-8?Q?SV2zswepfAmHjkSUeJLqa6F4RWo1ZlIS1klwW?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb14e212-da20-45e8-7b33-08de4ed549fb
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:45:11.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcVnGe4KZ2Ep1WnqRe5pj/BPO0Kanehc+RWCS2WwQkxlsrZxHS2AjVzJSkd+MVSp61ZB6C4fs/4Q8OQtfGXa+tsjinu/djiEMsdiVCq7g/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8578

On 2026-01-08 11:34, Frederic Weisbecker wrote:
> Le Fri, Dec 19, 2025 at 09:22:19AM -0500, Mathieu Desnoyers a écrit :
>> On 2025-12-18 19:43, Boqun Feng wrote:
>>> On Thu, Dec 18, 2025 at 12:35:18PM -0500, Mathieu Desnoyers wrote:
>>> [...]
>>>>> Could you utilize this[1] to see a
>>>>> comparison of the reader-side performance against RCU/SRCU?
>>>>
>>>> Good point ! Let's see.
>>>>
>>>> On a AMD 2x EPYC 9654 96-Core Processor with 192 cores,
>>>> hyperthreading disabled,
>>>> CONFIG_PREEMPT=y,
>>>> CONFIG_PREEMPT_RCU=y,
>>>> CONFIG_PREEMPT_HAZPTR=y.
>>>>
>>>> scale_type                 ns
>>>> -----------------------
>>>> hazptr-smp-mb             13.1   <- this implementation
>>>> hazptr-barrier            11.5   <- replace smp_mb() on acquire with barrier(), requires IPIs on synchronize.
>>>> hazptr-smp-mb-hlist       12.7   <- replace per-task hp context and per-cpu overflow lists by hlist.
>>>> rcu                       17.0
>>>
>>> Hmm.. now looking back, how is it possible that hazptr is faster than
>>> RCU on the reader-side? Because a grace period was happening and
>>> triggered rcu_read_unlock_special()? This is actualy more interesting.
>> So I could be entirely misreading the code, but, we have:
>>
>> rcu_flavor_sched_clock_irq():
>> [...]
>>          /* If GP is oldish, ask for help from rcu_read_unlock_special(). */
>>          if (rcu_preempt_depth() > 0 &&
>>              __this_cpu_read(rcu_data.core_needs_qs) &&
>>              __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
>>              !t->rcu_read_unlock_special.b.need_qs &&
>>              time_after(jiffies, rcu_state.gp_start + HZ))
>>                  t->rcu_read_unlock_special.b.need_qs = true;
>>
>> which means we set need_qs = true as a result from observing
>> cpu_no_qs.b.norm == true.
>>
>> This is sufficient to trigger calls (plural) to rcu_read_unlock_special()
>> from __rcu_read_unlock.
>>
>> But then if we look at rcu_preempt_deferred_qs_irqrestore()
>> which we would expect to clear the rcu_read_unlock_special.b.need_qs
>> state, we have this:
>>
>>          special = t->rcu_read_unlock_special;
>>          if (!special.s && !rdp->cpu_no_qs.b.exp) {
>>                  local_irq_restore(flags);
>>                  return;
>>          }
>>          t->rcu_read_unlock_special.s = 0;
>>
>> which skips over clearing the state unless there is an expedited
>> grace period required.
>>
>> So unless I'm missing something, we should _also_ clear that state
>> when it's invoked after rcu_flavor_sched_clock_irq, so the next
>> __rcu_read_unlock won't all call into rcu_read_unlock_special().
>>
>> I'm adding a big warning about sleep deprivation and possibly
>> misunderstanding the whole thing. What am I missing ?
> 
> As far as I can tell, this skips clearing the state if the state is
> already cleared. Or am I even more sleep deprived than you? :o)

No, you are right. The (!x && !y) pattern confused me, but the
code is correct. Good thing I've put a warning about sleep
deprivation. ;-)

Sorry for the noise.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
