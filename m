Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A801FDE31;
	Tue,  2 Dec 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764679202; cv=fail; b=qUnLpqKhJ3EGayY0wui5/JNWBnKTvnR7XhMCUmtXd+Jpo8SL0yHtiWbk+H7Yk18yh0546lchUUGeSRzD5+YTf3ltMGAZtRkSRiLjqKxniOxMyE9eJ3fyiyhqNHfXfLOJcWmlaoX1Pvd9cqZdxbjaZ+sNol+qoqPHkPimKwn4ais=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764679202; c=relaxed/simple;
	bh=YOfFOsWj8rxRkLSTAyHz/khVlGEXoUb91c/F1skZhdY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Osd6CJe+hXcOFcYf1iiXLr4Bjv8ZKfQsyBUzwt+y9QzBiBsiPipCLcp8TlRtGLAth9DPpkXtl6GODTsLVPzRmkagfVkhkzfKvCHawmk9iaZGeVkF5aL/kowaQmrNHh5aj4O2Y1adpDe2n1NVsFjW3IHWtd4TVgn5mmg+cy0NDH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yB7YglbX; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yB7YglbX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHVa8Ba2VKJ7jd1orVau3caGCYFUsA7NhyJy6HtRQUXjKjgc6uzcUX5gtz9HWn8GGIE/6a+ihAs+Fy1A72rJskkuBJ6o0i3KiWmS2CpzbAGAk5GGRlg8LQHB+yq0PWT7D9/W8cds/eXhbQLogtTH7tMEJt4TUA4yCWwti7XbrIBEfwWHIocpQOcbmCAh6JYVA5wH7bmNS1zNddhveB0KYj9r8AqJBdQX4rlGo2vX1jpbOgTO31J0ISPbRw9yWEGbYUDrITl5YC3dz21msURtyN3PiH4nByiZpyCRUGNeD0Cx2TCvqzZAKwBTEnm+J/IouSH8jabo4HRKvCGnZEWn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwUhqBk1moMW83f9sS8ZWEjWOuchXmcfvEJMU5WICTA=;
 b=d8r6jH+u56poX2l52geOG4EhJRAjiiv0tpWFQjzJd7Fy37mFIsPJ3vkWRPvgkMTO5zAMmANihBXUmoT/V7x0b3/j8v/NHp2AokyRVEKc2sMiX6/3LtVpFAtqWtXKGu+niR1OxEbiTBovBMC0yJTjRH+hgOniaMklfgWX8nk1mDscWUaOcz5zsqql1jKxxNK0LTBsvUbzV9om+Lfq139SeuYaSTLvLQoPUTDIdFaaEbJzhXWr992aEfgNTIAXRS9Xl2nPn37mfxjkmh5wSl+gUd+vE1jWfN55Bbtii88kHXsy6Qa5UhIq9K3FK5aqzmRJUqPGjJ9WmbNr932VruEQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwUhqBk1moMW83f9sS8ZWEjWOuchXmcfvEJMU5WICTA=;
 b=yB7YglbX2xfarowMXkp3oqP0acT8M0SqxW4Ksxr2VQhFWNFijzahMq3tTU2yjLtzbSnFlTzQtVW+eAYOXq/imOx8ZZXkwiICRDMbrm0X/rPKlNJ7mWyThYnHakW92eKIolzA7j2rDsUYZ34iuxdSgzt+sb8NUftSssQ92FXjAZB8ZdhlN0B2ECLKAoN5nYqSKRkfUBfTf09W3jJCM7RtBTtiR2DE3rRou4UYXHi9QkZXlNQlOOzbGUwfdyvwnetH33YbKolojVzIveVgb7dImYUJO54/Z/5uZF60cJyROjShZfecfzddIBbZOIdafs7KA7icHvvp67FQGXqr78fpYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5647.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Tue, 2 Dec
 2025 12:39:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 12:39:57 +0000
Message-ID: <afbd1a03-0458-4c06-a96a-2d5f34e2632e@siemens.com>
Date: Tue, 2 Dec 2025 13:39:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] softirq: Use a dedicated thread for timer wakeups
 on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 stable-rt <stable-rt@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Pavel Machek <pavel@denx.de>
References: <20241106150419.2593080-1-bigeasy@linutronix.de>
 <20241106150419.2593080-4-bigeasy@linutronix.de>
 <0d66a966-0b89-416a-8712-6a6131af355e@siemens.com>
 <20251202082458.m12SBi3G@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251202082458.m12SBi3G@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b7437b-bd2c-45d3-6fab-08de319fe6c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aklLUEpPNlRuUkNwdEJkOE9ocFloTW5aMnZySUtkU1JqRU14YlpHVTFSSGph?=
 =?utf-8?B?dnM0emtPUDdnR09zeVJvVWR1cmpxMzBoME9Wd0FOY216WGZGQytpaU4zdUty?=
 =?utf-8?B?VDBGT0FPMWs4R2preXdYRWkyV25kVis3Z210TStaZzl4Smp1K2JYTkdSU1Aw?=
 =?utf-8?B?YkpaS3dmSzlueHV0U0xXRVUrcHMvS2VSK0h2ekttbXlEaUZYd1pZdmpXamZE?=
 =?utf-8?B?YUFmRVcxOW5oRFY0VjNsbkhCUSt4K1NiWHJ4T2gydFVVZEpvUnFkQlZ5Qmt5?=
 =?utf-8?B?WlQ5ZkZEV3VZUmo5N2V5YkNOZ3VVNFR6aWhtMmdxM1djN3cydkRpbDltQmRJ?=
 =?utf-8?B?NS8wYTIyNGFHUklJdEtjWFFoTE1NdDBoUGVzdXlIRFJ1Y2ZncW9TeWV5VXpW?=
 =?utf-8?B?UzJaZDh3c3ZRMFpuSmxUaDlVS1lzek85c1BrVjlUalBjQkVzdGVvVy9QOWZ3?=
 =?utf-8?B?bms1SDZtcGlUTGNxU3dKOW1HL2tNc25Iem1Xendkd1RQTkhIQWd3Mk1SN3Rl?=
 =?utf-8?B?OUV6dklud2pvQnpKaHo0azlGdTZFKzN0RGJXa2Z0RFJMOFlJVzZMbmJBdUFN?=
 =?utf-8?B?ZkhJd3VSK2VYSlNCWlBCTXl4RWswbyt4TlMxMHc3djEwS0IwMW1TY2pnVmlo?=
 =?utf-8?B?aVhjcFRRSk0yRHIzZ0tORVQzZkt0ZEs5YndwQ2d6Y0trSUlCREdnWEdtQ3Rw?=
 =?utf-8?B?QXdzdjc0aVUzVWF5UjM4M1VjbHQ0QXcyb20vZWYzdFUrNFN1ekhaZ0MydS9m?=
 =?utf-8?B?dC9ZUFhBUTlFVmxTYTcwcFhLdkFzVjBWTldBZ0Z0dFNuMi9INzRxQXljdUFK?=
 =?utf-8?B?QWVGM3RVN21jK3U0WlY1dE5rUENGRTJLN2JrbzB4NjNCaFdBR0h0MitvWlcr?=
 =?utf-8?B?aU12dTVOY3VqRnVaN2RYWTlXK3Zvd3FrRkR1c1FmTnBUcVIxT09BTzdjQjhE?=
 =?utf-8?B?bU9iWFVUWnRUa0tSSTA2ckJOZVpRd0QyUzZKUVJJaWJRbVBzV3lPNGlNbVhp?=
 =?utf-8?B?aFErVGtUelBuU3QrSFc5anYxU2xwSDQvNW1ZaFV5M25wL1ZGa09BWERrWXJs?=
 =?utf-8?B?MXBIeVFZMU1ZNEpRMUpReVppY0hldmdqcHNveXM0eVNSazl4VXltdnBCdFpW?=
 =?utf-8?B?NWEvazN3T3Racm95eGJYU0d3Z0dqMUZ6bmR0d3I0Wm9hNHJhcC91YVRqcnBL?=
 =?utf-8?B?aW1QSVhRb1duNi85ZEZlMVcvQmE3ZTMzcExMSDVsZ3VhR2ZrQkdWMkdhT0VB?=
 =?utf-8?B?UGdCcUdmUGI0K1VRakF1YTBQL0dubGkxUyt3bXk3RUFyWWN2Qmw5NjNXOHFB?=
 =?utf-8?B?MVhsSW1YVGRPY2NPeUtaMzBkVENOSnFBZTloekJNcG52SjhJdThnT0szSVM5?=
 =?utf-8?B?R0FuTXN1YU1qbDBGa3pyOWZCNlltZ2xReVA2NzhYdEpaanlISUJydG0rR2Vj?=
 =?utf-8?B?SGRVVnEydzk0cUR6RUpYVGNVdnZNbGgzbkZKaW5IejVSdnpMaUsyeFpwaUdh?=
 =?utf-8?B?dUhIMWc2V1dvT05QZDJKRkRuSXNGZE9ZMko5a2pvUDlISEgyTFRiblZ0QjRW?=
 =?utf-8?B?YzhjSERuS2FlR3MydURSU1hEWGd5NzI4L0pVbVJCdjlPUHNndTlmV2VtNXFB?=
 =?utf-8?B?VVlPNUh3TWZyMHN4dVRmVmxTcGZ3QjN0Um1hcGM4ZE1SRmF6QnN6VWFnOHgx?=
 =?utf-8?B?VXp2V0JaYVFQTEZDRDUwQnBxWFJ4TENyaVdBNXBIWUFQSVM5dk9WWmJlYW1w?=
 =?utf-8?B?Umo0Tjd1TlJqVmprNkgyOVdXY1ZTelR6SUxSZlFQNGEzRFNTM3ljUTlka2Nx?=
 =?utf-8?B?MTRtMURZTk5IcGZYQTRYMVZ2alhWUjJSRi8yL0lyaUZSNjVMcFBTM0srT1lY?=
 =?utf-8?B?S24rNldGb0NISVF0N0h1YWpNUXdTZ0ZmZjN1VW5tZVA2bkhORkJ1WGRoZDEw?=
 =?utf-8?Q?FUXeNx7rSOUkjkfvTturc8pE4NSgAMW6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHpweDRMTjBHOHFLb1QzbDdaMVpDdkFwNFlMUWExUjVXbDJSV1JQYlhIeVlW?=
 =?utf-8?B?cHJxN1FtQ1cwaHM5SXVmdU9SSTBJbHFyaHdvb3QyYnk2ajEwTFRwUTdKelRS?=
 =?utf-8?B?SkdNNVpsYTg5bmZzalRWOGJIVWxUNHB1bE5mQ0tEUWlYb2xodEtNQkRMelQr?=
 =?utf-8?B?cndaQVNORkZoNkpkeEdRRTVVSFRWUi9DV1NGSnk2bTl0RVZKNDc0UGhxek5J?=
 =?utf-8?B?MVNPSFlsZ3h4ak5LUDNxd0RnM2FuRStYV0pLTllDNVEvME9TYURmTzFLS0RK?=
 =?utf-8?B?alBmZS8vN2NJbWs4QmwxM0V5bzlGVFB5SFJlNUJKNW5YSHZ2L1kxY0hST0ox?=
 =?utf-8?B?bWlIUlpFSlR0VHJ5UEJzZ2pzY0lXVEVsaDNmSVN3Yncrb1Z0dnlFYUc0UXIw?=
 =?utf-8?B?YnltdjJMMGthR2x0eTQzQWtubUt1RmtDU3MyYkN3RkZPalpuTnlkeFdCRC9C?=
 =?utf-8?B?NVQ1TVRQa2svY2hNajRidTl6RExBVzVZdER2MElyd05Vazkybm5TQzRyeGNy?=
 =?utf-8?B?aFB6Nisxd3U1K3RzOE9RUEtMYnM5ZmFxbnFwMGxwRDVsMXJIUzd3NHhlZldH?=
 =?utf-8?B?OURpU09IZGRjNXVqa2xtK0VTSzczcnl3Z2U5VHRmL3BNaCtIY2d5RjBpam12?=
 =?utf-8?B?L3N1MUpaUUZERWwzMXpDZnJqT0pIWlMxL00rT0o3bkhKY3Q4RzVLUWpBVUxl?=
 =?utf-8?B?QmtnWmtwcmYrU1UrRnl6dUhvQTJkQ001TlA5VjUwY0IzSUtJUm5zc0twS3F6?=
 =?utf-8?B?b1NzazhYd3dvMEhJdFg5UlJndzMyRWZ5dFNqSnFvV01ZMndYT1JZWUJ0NG9O?=
 =?utf-8?B?Vk1MR3JLN2xCZGJwTlFuSGNLVFl3ZFBHR1hvdnNXYTlqY0N4VGQ1YW1KM01L?=
 =?utf-8?B?WlpRVjFKVEVHdVpFRlEzVFNJcFRpNnNpWVJrTUliK1lHL0xPYkxTSWNXSG9i?=
 =?utf-8?B?eFpsMlE1b2Y2NFk5ckxzWEhuUlpqWVZlbUZJMU4ydThsM2t0TGQ0Y21wdXVF?=
 =?utf-8?B?OEFrTFZSNTEySmlmakR2WWprUkV1OHUxMEsrMlI5N1hKS2FpOE1oNXRIcWlC?=
 =?utf-8?B?YWQ2b00ySUlodnpoYU1MZU9aVTNYM3hKaXp2OXRhaGpDYTE2NlMwZzY3M1I5?=
 =?utf-8?B?VWlhS2JXWVI1alp6U1pXK2xodFhiQURXUEs0Q0UvajBHcEZKbWhhbVpJeXNM?=
 =?utf-8?B?UDdVcFNVanprUnJsbk9vYVJRYXFVNDBhajliQ3N6UVd3SlVoMnU1R0xZRkd2?=
 =?utf-8?B?UXNibTFYNDZNSVQyMjZETzJqaTNJcmxUN2R0QUV3SmRQc1BPSEFKQU5YNFBm?=
 =?utf-8?B?NThUeENpcko5eitzZjJhdTNQWGlIRkhVWHRDMWZSUk84dmMrUFNWMUZ6cVNx?=
 =?utf-8?B?VTVoUnBtcHVONm54QnRNeldMZGRPRlhjeUJEMm9yZ292V013YXZGVUQ4emh3?=
 =?utf-8?B?TG5USHJBRVZ4d1IvTStwdFdXQlJGd1Zod2FUUUs5aHNMVmVidjdYeE9Ja3Rx?=
 =?utf-8?B?WTBBeEpmY2t4L01zQmwwUlV0Z2lQb0h1V3lZSFF1TDZrTTI0TmlNVVN0SGh0?=
 =?utf-8?B?M3hUdE4rSzRsQVFCb0ZBbFVibVBmcFZQejNZNTg4UmFmaCtyR2dCSno4NzU3?=
 =?utf-8?B?L1lDMmdLTzFvaUI1QVdPOE9aMzFITUxkelU3aytWSVozWXRjaWk2ajJDWkZN?=
 =?utf-8?B?U0dBT1BvQ1F3ZG1Pa1BMai9LNVpXQkM3SElMS1MyaWxROGkxWCtmb2lQWGVy?=
 =?utf-8?B?RjJRM1Y0ZURrdnloaU16SEVZOGpleUhVemR6dGM4UTQwTnB4SkJpVWt4NG8w?=
 =?utf-8?B?b1dUS1VZZ0hFVFdoNmlOb2RFNzFtWm5hd2h6MjhDWng5MXBuanlPbmxDL3Vh?=
 =?utf-8?B?eHRaNUN6UHdrNDNDVXY5T2toZUt4VkwvK1VSbG4zWjlMdEVTVTBVNmdtVjRn?=
 =?utf-8?B?cUNJSDdoL1Fwd1ZZSXZQTFhHZFJ0VkplbDV0Q2U0b2dIeUg5K3NVTUVSZS81?=
 =?utf-8?B?RnljcmM2QnMyVDh4RGkxSlpDU2pzSGxBMFFybk45Mm1XQnFPTm1Tc0NYSWJF?=
 =?utf-8?B?a3pBL0tjeWJmNlVZQ3FtNUs4aXBqNVpXWW5SZWw0cmZyRDZBNWlXKzNJQ0pm?=
 =?utf-8?B?RGhiUmM4Y2dDSmNzVmx3cDJQWlkzOUFYZ1h2YnFPdWV4UVhlRnp3TUFxUHhH?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b7437b-bd2c-45d3-6fab-08de319fe6c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 12:39:57.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtg3KI4iXEa+vAlJVejYnsND7EMbtp+WANJDtPXSUtFqRLYaBagEL+qVcbVBbFJvmZJQ/FXuAQ14T77eALZClw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5647

On 02.12.25 09:24, Sebastian Andrzej Siewior wrote:
> On 2025-12-01 22:51:50 [+0100], Jan Kiszka wrote:
>> How should we handle this? Consider 6.12 mainline with -rt and cgroups
>> as potentially broken, asking people to user 6.12-rt? Or port this back?
> 
> If you have everything in v6.12 for an useable RT system and this is the
> only missing piece I could ask the stable nicely to backport this.
> 

Given that this is a fix for potential lock-up... Does it have
dependencies? The other two patches in this series are optimizations
only, or should they better join the backport?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
