Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020104.outbound.protection.outlook.com [52.101.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995B1487F6;
	Fri, 19 Dec 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766182804; cv=fail; b=mi0F33fBxg3j2uIaPeqhYPa8jKnisb5oGV20Ffp+g5ZGUByRykrgPll9SkM+9Df7f6RKeYcNxxGk/k4CugNWUj2CMkuaLYAsEcNpbvC5/o97xNInuSTy+AerXWCF+DOwZ5uCStwpdEUeRIVHrg4//sW72WZiS924hW/JQEK1J+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766182804; c=relaxed/simple;
	bh=uzDK0RvzGSKmOclM5xI4Oum98Qyu2iO7kwRhNwbmXKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aFJ6VWjXg2l4qW9IPOb3dR2Bb9bjBWE1Eo45SSYVPlycxu6Fn7zZWnDA3xn25iqhpVXOeahB9rhCe1v1ar3dZfgg/x6BjMVpzmdNymmFoZunH5W54I8bL/JDNOwKoUVbcowOFBNSFmv8AmyCO4WV2y9g2eyH6icOannDiryK9g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AetT463n; arc=fail smtp.client-ip=52.101.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AetT463n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzuXn0xbBeXSu6cPcFPJ2n6k5fVN5ImEZ9PSRqD4busa2+11tkl0JM2UBtCvswGjcLjjHwkHCSxUf26FWemutgXA/HvdEA5vIg1WWT52EBb1PErrG0AauC8kIpYmFvO5gLuSm3CXiYI2sO1x4VcyccUFuoapBJ8z1PAIPD1gsYlzF60KLlSpMZgztDdkLXU2W0ixq1rLcjcif/5Ee7RDk6aSSZZJj9cC9/5D4WGFSOaMCcOK8X2yjLssAwvJX68tclQ6Xuhw48JUbdt7EiajDHKAh/bXgCHkOjo41TpRFv0VVSG659tlAmXxcCIVD175R6zdlwLOWSDUYPgHkvuA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXuMjAi/dDOoJ+FlWX63zmylJR8XnOLQUg0J/KcGFck=;
 b=pQsFxlxiqrFd8+3IFn+SuusXLnR9EUk4xpU5ZaGIe/OL5Qi+1hCLZwjJssabqEorNaYCWpJO0UiL3SUFU+kmUq8/ZmaVsSfnZ1hCQnC43zNSsfzFIA/dxRejY6RTwaSBkT7dXsFTikB2eH27PHWMULBUUk8hasnB3wr11NgQ4oBSO/QATZkQL5ZA1gxmgqRWgFKAj/hj8TBUblKT/L0ftyrN6G3AVCHrxIZ+n3x6H1Jeub3ctpHEVZN6HFP7AGV324GZXZAcDMgdZ7pPjrF1iPB9pQKSMfcZE7blTp03OGFP7MH+9dY+qFjIxm/2Aq81ugq7CwYz84TIlZHJcdhO2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXuMjAi/dDOoJ+FlWX63zmylJR8XnOLQUg0J/KcGFck=;
 b=AetT463nQQEFAeLaOh2nLkqtZZkEVlJEd8S6iol3jDRxy3JQTvdo/9P8E9ysvNGoHjQ4P7ZF05qxM9oMNFb6mUjauC+D3OJclgQhTxHu74TNJrYk7rPLPxI65pKmVzScw7yxPeH3yTW4S7CCp0Tr9zESVxL4dhfntp5AYz73D/BOEkpxeEj8qL87Gf47pgpyN5PtntrGPwfSLidDRD8HsVK3F1IM3l5/JfRAMpnOQsaRMUGlzCCrKpo7HzyCcDn+SznCcjk1uC2u10IOvx/p3UExNyHKwkxt9xntyzU/hvi8w+X3NLuyI+3rfpOfo/oPJR/wktOX+Qx5rnd4NFSo2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPF4EC3187EE.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::23d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 22:19:58 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 22:19:57 +0000
Message-ID: <6b27f3c3-47f7-402f-aa6c-b564e3db1d6a@efficios.com>
Date: Fri, 19 Dec 2025 17:19:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
To: Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>
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
 <aURihbmjsKi8m7MO@tardis-2.local>
 <42607ed5-f543-41bd-94da-aa0ee7ec71cd@efficios.com>
 <aUSbhiMgluudbVEG@tardis-2.local>
 <edbe45b3-0f85-48d2-8d4f-784781a8dee5@efficios.com>
 <6353feeb-c2ab-4ff6-9ea6-04ae5102641d@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <6353feeb-c2ab-4ff6-9ea6-04ae5102641d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPF4EC3187EE:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f6a193-f126-4522-a442-08de3f4cbe6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEY0SndLU3hpeCtBUmF2WUtCR0lhWGpITjJ5d3NxMzVQWDk1K0UxK0dNU3FT?=
 =?utf-8?B?MUFnS1hqbzVRMFNQc05RdUs1Q1V5c1g2M2g5R0I4dnJvNTAwZEhFM0dKVDF5?=
 =?utf-8?B?U3FRMFZMZU9SdmRDc1dCT2J4bmVhRkVVUGRtY2JmY3RYcUNNMXExZysvbk1i?=
 =?utf-8?B?NW14bm12d1VNOW9qYmJENFh5K3dvZkVKRDBaZkNkTUtyNWp1b084anF0M1Fl?=
 =?utf-8?B?ZU1PVjhydnJmRVlETlZtZkpiZ2ZpajVmaXRIWGo4RUJlYWo4dU9CcC92VXR0?=
 =?utf-8?B?aTZHWTBrbW1jR1FjN052Q1JDRVk5ZGl6TnZLdzE1eDVYZXZKc0hUSURSN2kz?=
 =?utf-8?B?c1k1V25tT3JmcURuU0NTcXZhYUhFaDQ4b0pSTk50dnJvR3lHY011SWJMWmpT?=
 =?utf-8?B?aU1aK1Q3ZU4xTFYxQU9PZnh6cFJkSm1oUXF2clpyQ2VnTHhUUDVpZWh4Z1BH?=
 =?utf-8?B?TjNzTERETUdIRERDZUo1bUt5aEhzMFBSOE4rOEpOYWc2bWJjNjFZNDlJOEFx?=
 =?utf-8?B?eVJLMDhrUHZ3czlUcjNadzFrZUR2Sm9NMFVRRHRwdDNYYlFFU3FvUS9qZmo4?=
 =?utf-8?B?ZGkxRHc4R3NIVUFEN0xIQVNoaWk2OFlGcWJ0cktWTkxTNXdGdlNTdFBTMDM0?=
 =?utf-8?B?TUxoV1Q4THJ3WW9mL0NZY3J1NGlpWHIwNGQ4R3FsQ3IyKzZ3MzdSQVdTRkF3?=
 =?utf-8?B?Z1FLeitjYk1XUVE1ektuQVp0LzdFZjgrQjdveHF2MkhmdnJMVFRHcTN1QXYz?=
 =?utf-8?B?U2NQMUNwQ1Z3VVV0emtoNHJoTCtMVm1YUnZRbEZiRWpCVjdFZkxYbEJDTE02?=
 =?utf-8?B?TitSbzdQMFgxV1FDOHpNUGk2K1dkbGsyREZCSjVIeFNMdjVRTGJxRDJ0TG1H?=
 =?utf-8?B?UUNUUzBLLytUTHYvK0NuUlI1ZFptVE9wdisvYS9oRm9xc2NBcU9VUjJQWVRI?=
 =?utf-8?B?TnlTNUJEQXRRMHZWT3BRQjA0YnI2ZUVWMXhId1BkaWdLYTh1bEtIYStZSFFX?=
 =?utf-8?B?bE1wSEhHeVdiSDBMRHFsSGVod3ZyU0RXK21pbHRvZHVMQmZGdTZkQ2ltMzBo?=
 =?utf-8?B?Zkx6cUFOb2l1V2ZycUdLTDBlMnZCSVJQcDVQUS9NY0xkWHdOalFYQm5aZlBy?=
 =?utf-8?B?VW4zOHNkWlV2MXJWNG1sb3k0dWZJZGZ5VmFhbzE0d1ZCMWUxays3djYrd0dk?=
 =?utf-8?B?eVpkdTZRL014cmpaQ1Bqc0xWWlNjZ2wvQ2o4V3lzZDVmSHlIZ2RrU1RubzdM?=
 =?utf-8?B?VmcrRmRPZ0J5RnhYMnFLUkxXMUI2aVMzZEUyZ3BIdlBTeWNvdUlMOWVtM3RV?=
 =?utf-8?B?V3JjQVRudHVTM3hueHU0ZnBjS3ovcW93YmhFb2x4V3BEcU1pQklIdFRQUWhn?=
 =?utf-8?B?bkRaMStxM2pxM1Nhako0eXlrL2lQcjM2WHhsZmFxSXVDQm9rWHZKN2pQRElx?=
 =?utf-8?B?OGM0STlrL0NTakNybFZDc1B3K2xXSFk3RVFEVVU2V21sWlVFa2J6R01QSDhz?=
 =?utf-8?B?MmZ2T2djd1dhblFuL3pNMERCRGJmSEo4c2o1U0VnTUJTc3B2VlNBVC82a2k3?=
 =?utf-8?B?UDhrN01Ob3ZDQUlENDdBV0QwdDAydFpVbGd1RUxrd0hLTjkwZnFad25rUkJG?=
 =?utf-8?B?RnhSNGdLN1FyOW5BcGhQNGFHSVBZMFJUSy9qaG9ibk1Dam82VUlpbFZxN2lB?=
 =?utf-8?B?VG50ZUZuT094QWU0bTJQdFd4VUo4ckJRRjJaNUZ4MkF1TGFSb25MTHh5ZVZ1?=
 =?utf-8?B?eittOGlsc3dnL3pTZDhPbFV2V1FDQ2txY01OTitvZEdaalJpK1pxeTFaU1Ay?=
 =?utf-8?B?S2xoVUplZUFFdHQrbUpJZWlGZkI2VTRMUkw5N2psSDVWNWRGQ1lYRG5oL0pz?=
 =?utf-8?B?Z25lZzNWdFBuN2ZBSGpaRytlcmhNNzRJQ25obUpwK1lxNnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXo2bUZ5Z1JkeklrR1ZmREdHYkx0Uzc0Y0NhWHVVRWF6K3U4RmczQnA2Q1dh?=
 =?utf-8?B?a01UOXBhVHNmcmVEMDhhaEhsY0l1RGJaNkdML1pVZm83aEhzekY0TXpSdkZW?=
 =?utf-8?B?Y0gvaVdxU0tjUENnVERzVzNKRmsxVDQycEZ5c3pxUVlRUTY0emJiVXU3TmRE?=
 =?utf-8?B?QjFXaHc5SzJJMjNyKzR5TnUxNWg3MDhCakFuSlpEcjJJN3FVYit6YTI3VHZW?=
 =?utf-8?B?ZUQrYklmcnRUbnV5ckJWbUlRRDQ3bTZRcmN0Vzg0YXRJMjJFVDdQNWhTZTZ0?=
 =?utf-8?B?OTVtSEY2US9EMTRiMVRGYWl5dG1BczUrS0xDZExKUGVuRkQ0R2pSeDVVd1Vz?=
 =?utf-8?B?dzQycGVsams2SVY2WjI0SkZOMmhSRVVUOE5TQnZaRWo2Sm9hd284NTVPOVVB?=
 =?utf-8?B?Z3IzK0NXT1N1Mi84S1E3Z2QvbVdvZ0Q4UGVqRlYvSXlQTVdxQklpKy84U3Bl?=
 =?utf-8?B?UGN3WFBQZjludzhUWmR2ZXBRbDFXVG43dTVUV3JzaVVhRm9Md3hFRTFZbmxQ?=
 =?utf-8?B?QWdoYjNZa1l6VGlLUHpCVDdnQW0xYWt2alduc3pxVWtkWGFuNVJnZjk0RUsz?=
 =?utf-8?B?SHoxM28yVnkrZ294SjJFc0lUVitBYW5DalR4T0NSc0FQMlFCQWg2Qmk5bjhi?=
 =?utf-8?B?RGJtV1VvajFRelRlT0p4VHVVUHZxL3FVR0RTMHBxbEtHMXVmUXNjUXpNQ2FY?=
 =?utf-8?B?akhZbk5hdXkwWUZSd0RhS1VMdjZMNmVsSTBGblBLenNFb0h0QXpyUFRXV3E0?=
 =?utf-8?B?Y3JkbDNaa0dRblM4QWI4STRKZ041RFhvWVNiRTRIa3p6QW5sQU4wM2YyeWJK?=
 =?utf-8?B?dmQxV2NwNWtQNVZYSld2eGlBK1hhMVhlQnVjVmFNcnZ5elVHMWdLQVpYYkNu?=
 =?utf-8?B?MVBULy9mVk9IazEwTEtFMUJRdnBKd1ptbzJiUEFZNzN1dS9KRHhQaENKWXU0?=
 =?utf-8?B?UHE4M3pGWjhNSkNJanNuKzZFbjdLQkNxK04veEk1NWdrTWFrdW9hc2tEWVQz?=
 =?utf-8?B?a01vazVXeTQ1NUpoRXhEekRXVHVZQjdRUDhRSEc4cVl4MXloWGZuNUNpSjRF?=
 =?utf-8?B?eFppSkc2bGZUZ1NTdGp5Q1VTdWV6QWVBUUZURG1lVjZ4YWF6OFdIM1BFbG9M?=
 =?utf-8?B?WC9raFMweHJicEh6R2tiT204bysrRnQzUzB1NWhTT2szeTRXanRJYUxXTGhj?=
 =?utf-8?B?Qnoya2NSUm15NWJDWXlucGRBeHYyNVJWR2V0VThXK1pieHpHMklVZllnaS9D?=
 =?utf-8?B?bERiZDFrdEJaT3BwR1REMGpGRFpWL2QyVWhVczRRenVkNWtVdnMxdWNFOXVW?=
 =?utf-8?B?WE03aG83eE9ycVpPdjBGMlZBeUVhdW51R2hScjVhNjFHaUc3bEliYzRqbTlu?=
 =?utf-8?B?bFpjaExYWlBwQ1RSQ1RTc1Y1N21YOVdWRVNvZlN5cmpReWMzUU9uMWNIRTJv?=
 =?utf-8?B?S3BMd2d3QytHZHJnY0RpV2V6SmVCSlVjR0tlZWhxL0t3UW5xSTRyYXFTQit0?=
 =?utf-8?B?K1QwZnZITkc3Q1lML21Mc25vMExTTXNENEFQbE9odmF3OFJxS1MvMDA0eGdG?=
 =?utf-8?B?cDA4ZmQ5Uy93cm9kZUJucHFmdGd0UFdmN2NHUkdldE1jY1Bid0svVGl6NHR2?=
 =?utf-8?B?bFd4QVM2QkIrWUNXTS9lblNUZXMxS0RKaml2MWhpRGIwNFdJUmhnbUJWdzVY?=
 =?utf-8?B?SENyOUQwRlBTeDc5S1FXR2g1aDhSeVM1SWd5TjlhRDlQM1lKYXg4ME1vVC9O?=
 =?utf-8?B?dmdMcTVnZGpDR2ZDcDZHcGgwcXNMR3NwUmg4VnY3UnI1YWsrMW9TWlhKRGMz?=
 =?utf-8?B?bkpnZFc0RVIwc0hhSERhbkd2QldTaHRNcHhHQmNDV09sR3l5WHRHM1RMZFpL?=
 =?utf-8?B?NHdKQjVLRStRMFFDUldKbkFPclg1cVhSbnVkRWdnLzlyeUVXUk5meVBwUm9Z?=
 =?utf-8?B?Ym9TOGtybmZ2YUVtZWJFcGdaeE51NThXUFE1WFJabXBRRWwza041OXRsZklB?=
 =?utf-8?B?Nk8weHF5cmlJeU9GQmo2eGsxREFNd056THIyZTVCUGMxSjFwWFZFSU1zL3Bw?=
 =?utf-8?B?Yjd1VWF3YUNhNWF3NjhnNFNOZlBTN3FnNXVxYnpBa29IY2R3d0pyQ2tUaDFY?=
 =?utf-8?B?cXpZVXg0andNeDJtc0NPRXJXekFheTQyWFZINVhJRG1DN2VYSlBhajg0NHJs?=
 =?utf-8?B?cGtEU0REakwwZ3hsQ3ByZW9yWlFYZUJmNTh0K2NuS2Z1dGo1YlE5NFg1d3Jn?=
 =?utf-8?B?UWVMd1dkbzVsUHNoUTRJS3hvNkgzWUVZNEMvOFo1QUJJZjYvdzBROVBBZ0Uw?=
 =?utf-8?B?ZVVzWDlHemhTQjl0M1kzT2RHbFhqQVV3RC9CejduNVNRWXVuNDArVnVDd3d6?=
 =?utf-8?Q?gMGmPwFsbni2ZSJA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f6a193-f126-4522-a442-08de3f4cbe6a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 22:19:57.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM2HaGSyz2hG+d6eGoyQc/1ZZ3ZNQ5TZgbdoidLVbXi8vN1DjiIOMCrFGorffeBcsxbMthWVE2zUJGfBQXfmfVZLFLAzYIIKkknlOA8XPsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF4EC3187EE

On 2025-12-19 10:42, Joel Fernandes wrote:
> 
> IMHO the overflow case is "special" and should not happen often, otherwise
> things are "bad" anyway. I am not sure if this kind of complexity will be worth
> it unless we know HP forward-progress is a real problem. Also, since HP acquire
> will be short lived, are we that likely to not get past a temporary shortage of
> slots?

Given that we have context switch integration which moves the active
per-cpu slots to the overflow list, I can see that even not-so-special
users which get preempted or block regularly with active per-cpu slots
could theoretically end up preventing HP scan progress.

Providing HP scan progress guarantees is IMO an important aspect to
consider if we want to ensure the implementation does not cause subtle
HP scan stall when its amount of use will scale up.

> Perhaps the forward-progress problem should be rephrased to the following?: If a
> reader hit an overflow slot, it should probably be able to get a non-overflow
> slot soon, even if hazard pointer slots are over-subscribed.

Those are two distinct forward progress guarantees, and I think both are
important:

* Forward progress of HP readers,
* Forward progress of HP scan.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
