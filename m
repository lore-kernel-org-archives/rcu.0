Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323479;
	b=Lkd+FySC5S5zF7OMEEVxi5Qmjym8s4lzX+9v9Gq9B39FxGQpLurkcbDcyCoRvPI15V4B
	 dUUtB26xOUoQvVs7nciWyfFD0tAywtqVKzKhq2POejsm0l5ESIJh7a6hIuwMgF5FFeMvi
	 wJJ8PoBDvkSjPH9I1HHjCxeDWJ4baPfncuivcCbE1yLAG6biGg65m0wIHois6SYmKxRea
	 mAtuaPemiVdrBIYOxV8eAAT4AXJv8KjFFTZKETL9HKsqRIeeM3ezZhValMrJ2oElmRXjh
	 fyQ3e9gRsuAwzwGtV9UBNuvxGLTO89CyyEiYrv268pyNBoR3ypNmzVOuev7PbCHAscA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323479;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Gr9yAq7pJak8p8Zi3exCjb0FexD9MYA+/3oW5RPat5g=;
	b=TBivqquMrIIOl9qVgDJcXmz/YtaYlTfnWwSIUO/Phs4HAuIItGqLEwqATPrq1qihTLqU
	 ygcHwczpEqHlLWw197DjIfxcCaHSGvX23ykYg1tz4kWMIlWvq4jCgGrfRnhPCW2Afnb9q
	 GCDXIyw+AqgkG7IUODx9Zy4EcKScmFEBSuDBiMuL7Q9xc/pKnHrMZ3YMo9sTuRkKAdpZm
	 oNxdd+6VyBVUJIVz5b2oo1mJBzYTmfxU7Tiuu5oXFwNrlC2yHP6e0+2iRrK1584vO6zVw
	 M9HE+PNW8EklgXbCPXdT35r+krH76dSvMcvfYhIJka+gwzKQhiV2daF0N7o+t66ymxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=neyC7pOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.137
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021137.outbound.protection.outlook.com [40.107.192.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0D606A330;
	Tue, 10 Nov 2026 15:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6C0D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=neyC7pOj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGrqCV+vw7T4EQHmxrBWQDp1dCC2BfCkLqH+ZlHWHSOuVdHlx1nuR0vw3c4iD7zEC6dBt9q4Dz1CHJBg3vM4ofvnOWfZAmlx2mb85p3uiNAqNvgwaptnN4wFMgb7wziWYLVRviuj12MX4BonvORtlM4J3+GsjRPQPnQVge1QUybH5lI2gY1OPuW322aPcE8wLrhwTVwMMOoceJE6ore/qo3FFXrckwtn5uKFo0V93HP5r68YG/tsQqwgz8aeYAdMAJA8Cyp6rORdNHhSEK5kYtyrME/Guwllprsk8gnbHCeXlZYdWRoTN3dbT1bR9Y4AYHILJ/eXFWyvjDQUNxLnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr9yAq7pJak8p8Zi3exCjb0FexD9MYA+/3oW5RPat5g=;
 b=YkFZ59QeneR3SOf4rMPXYozJDuiDB2ctObJ+tv4Yo+KHVkYMM66hsxoJ3+Bo2SVH5iGBCoOs5gcBGLJFTWJcv/gwW5DBxwv+MbxG6T6eD5/SpRmkpjs2fPfno40ur7AEHKgNHEuJk/Z09R7yw+/+yyLvrqPjARcWuPUBBbd8VGV0iigr7WnsW3opsN8SAwkzTu8VTPAaI2lGMiVVUS/haQ7cUwFtkDSs+hKkgpn4Qo0U848AoyZ188vbiupmorZmnYoie40u8ahdhhvsZbcCfyPfBmz5kEX3w0QnFtvIG7jOpNXJKcmnlFdULyOl6OK3oXatj6xLgfAKKZWaNr/33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr9yAq7pJak8p8Zi3exCjb0FexD9MYA+/3oW5RPat5g=;
 b=neyC7pOjyfG40AuaMLCV9gejNqM0WbVhKdPzw9McETTcv5eg9CXCw7LCFNjj+igjMbtAWKo7ElmZzia4cxckjjKe/d0ZL0WrlEY39Uk3BQ2WlJ8xJjLw8CVpj+2+XJCFRKlm0cTTzcbFYwIgomhbztZhk2aVtmDqOIyPgvgjYAeG/u/PE2UBBqob5KUOPhansoTQD4jsIKQZAmEfWopjkslOiTLnVt9GqkLrqyMF+JGnMg26VpPIa/EhvPk8nMdD1Wsc+uilz6N6p5aR/a6UOvrBzMVxCc8eKcthLJWarNumo/cKbTylXmgYB/sfjsvdjn4rwB3w/4O9nwWQ/OGwdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB324135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1cf::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:11:14 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:11:14 +0000
Message-ID: <ba93b677-ab72-4a85-a7d4-a77aef6dc746@efficios.com>
Date: Tue, 10 Nov 2026 10:11:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
To: Puranjay Mohan <puranjay@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Liam R . Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, rcu@vger.kernel.org
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261023181940.457424-1-puranjay@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261023181940.457424-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::16) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB324135:EE_
X-MS-Office365-Filtering-Correlation-Id: 091b6c6d-be03-4a9c-423d-08df3f3cdca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|56012099006|5023799004|22082099003|18002099003|10067099003|261009223027099003|261102123227099003|261026121527099003|261022075727099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	xgPPEszXPdBF0RJ95XhdqiKD3ZH0PWBY4txRDaMdKainwpRVjEPLJv9h419Yfux5qtMa9cvQvwjB7IzCwKZN+C7Mnnopmq48+0kjdk+7tgExVw7WRqQGnudo7dHqf8ug6L5BwzAV6pYF5Cam8E7+ToHfXTQJcbYPs+6bKPImvXL79hV8q0OpCzp8K9YQNsVnM1ExGnpmYTV8Hbi+e1sZXp34bKXGW4cr6GXR4SIBXK8lc2MTpBll6taZhz/gjZXQrE1qPoa4hLPeHZSdzg5VmsOJjzHACyBo90kjGpCFsq+lrA108zy7by2G2TTTe+BjDCOFyGZ1Cnk8emd+rTXgB8Nafml3MKshNchAU02jwD/I6KVKBhF0ney4VDVaBZpzcYleoPm4Mq6CvHs39SDAly+kQN18XgRU32Ih9IRN+m1ErJ1vwYUNdnrtAVXf+JqEJA33ja/KQZ2IXvlZgerry8RPJHKby2T5WaYYqs1Umji25lL6juWf+VL6ddqiC+oLFNWCYqPyK+eV+/p8GqOeDJcbd1Wn1eiXxTc9TsYjyvHaPDG6NCvuiwABF1HaiSw/UsTc83u6qT2R0ERamsm1L2qDS2lMzRAniruVZ5xBzFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003)(10067099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vy8xZDZrNkZQekR0S2wxd2IweUo3Yi84TXNJaytaSGpFN1FLSlEyamtXWXBz?=
 =?utf-8?B?RFRxR2xEL0E4Ry8vZWtXMzdhclBUaE5UMGRLODFGakZNdmlKQ1hmYWVnNW43?=
 =?utf-8?B?cDZFbGJXdDNVU0xoMnBSYzkrUy9sQ2gxZjJQbEJHeXlrc3p2ZzEyVFFkQUto?=
 =?utf-8?B?WXYzMS93bEM4RUlLV1c3S3ZTTVppK2xOc3UvZkExdWcxcm9aRlBXQTZvQTY3?=
 =?utf-8?B?b3VONjNKbWFJbHFIMkJFK2F2WUlOcDNaMXFnYWtBS3hJZVh2MzM3N3BvZktn?=
 =?utf-8?B?NnphelU4d0htMURhZUZrdTQwcS8ySXkwTDZla1h6UHZJUHA0OHJVYWYvNE5n?=
 =?utf-8?B?U1BHKzh6b1BDblZWVFRsTncwR0IydjcxcjhjNHUwd05xLzRmdVVodHdTQ245?=
 =?utf-8?B?QU1vNWNCUWloNEg5K1lpb3ZLTlBReFFpYlNxUTdwa2R1Q3FtWHBUNHRRcEVX?=
 =?utf-8?B?WVZJSVlIWTJWcHV6YUR4eEJvOTViVlpycHRzRTBXU1JCcktXYmdaVDlhVGgx?=
 =?utf-8?B?M0k1ZWZIalNWRzFtMmJWaWpyS3JaWndTVlJGT1cyRCtKRHpGdzN3VDg4UVZU?=
 =?utf-8?B?TmxIMDhlLzBJWnJlekE4VktyL0ZNdUJYUW5yYVFJWXJCYjZoRHE2aHpVK0Zr?=
 =?utf-8?B?b2lVamdVTHI2a1lmYy85SkJYVHpGWlVWbzFkd2NRbVNrWHpwRDcwTlJpVjk4?=
 =?utf-8?B?V3V1YzRhZ2VYcnNlcmRVTEgvYlYvWno0WklZWlQvUHJuejV2bW1oSU1EdVoz?=
 =?utf-8?B?YW5PNHB4WmhxU0UrSkNHeFhhTXdFR3R6NXkxZzV4bGhtOVMvRzlCSGVLTlkz?=
 =?utf-8?B?MERNTkxSSGd5eW9jZWY5dlNRT3AvN1JhaW5DUVc2Q0xTTVYxMno2MlVtcGln?=
 =?utf-8?B?NDc1MXhhRFQ1RXJ4VGdrdi9EVllQNlk0eUVJUkFhTWRMVGNkNGM5anBiZW5j?=
 =?utf-8?B?U2pqUytuVW9nU0U3UUxDeFJjdEhGWVhBb0pKTHl2d1Uxaytrd3RDTllZTFJm?=
 =?utf-8?B?T25XVHhoWUtOMEhhbVJDZWF6ajBvS2hoNG9EbTNxUmoxR0ZXMllnaDhlYnMw?=
 =?utf-8?B?N3M4OFpyaE5kNTU0dGo1UndMd010YTFFS1MxajBRZWhGdWhzQ3RrMnVncVly?=
 =?utf-8?B?ZWcvMlNwTHB5eG9qMERnSlpVeEt2ak5pM1E1MDRtckgzaEU5YWR6Q01jQ29j?=
 =?utf-8?B?aGJIQ1Z1RjdzSzF2d1dUbW55TnJyRCtDRDJnckhMY3AvYk42ajl2M0M3UnRL?=
 =?utf-8?B?eC9wRkY4WE1XUUQwMk1xellNcVNoVUVZWHR2RUpGWHFKNVFOZ0NtZ29SR3Zs?=
 =?utf-8?B?RWg1YkdXRElFRDgraVRvWHMrSlhuMGVjZ2dxNnY5TkZWQndMMlVYaEVwV294?=
 =?utf-8?B?YzQ5c3dFQjBuTEtkSkliTHNGSEp6VVMvUllGdllreHZvclp3SGwrWndpbVpS?=
 =?utf-8?B?blBiUlN6bXZpYi93a3NGWG9Zd3ZNbklBNlVuQWpyZk1UUUhIZWdEUGx0US85?=
 =?utf-8?B?YWFmM1psV1hNU2xCcWRveWtDT0RJR3k5Rk9LczVPWjhscFFYbmZjaU1YVWQ5?=
 =?utf-8?B?bGd2L0YzNEpHemE1Y2NOUm5nbW1KUzBVRDVSVjJ0Q3NQNXBaSFJYQVNSRFIx?=
 =?utf-8?B?ZmJEZ1NCS05IOU5TYmlnWjhZRjhkL090R1k0ZkVDRjYrdHZ2UjBHc2cyQ1gw?=
 =?utf-8?B?MHY2RmU2SUtRdlVWVUFoZTNNZFdSZ05oSHlIOHk1ZUpWNi9tTStQNlVqVndw?=
 =?utf-8?B?Mmw4WjZzVmxGbWJaVENtbVNySzhUVi9RQ2VMK2NDNlVUY3BDdkJxcjJCNjF1?=
 =?utf-8?B?Z3hwSG15amw2bmNYdms0cGZ1VlVnM0pvYmNIM1luelVyaUc1SHlrdXZtN2dF?=
 =?utf-8?B?THpIQW5uclRXYnpMTGFTL0FaK0NZaENpRUxsQjgzVjM3NXRhTVE0VE9uWVUv?=
 =?utf-8?B?TmpiSXZCUnVVcEQ4a1BhNTFKT3Q5amoxcUxUc1REV01HcHRBR3V5Y05GY3Er?=
 =?utf-8?B?b2Z5eEJGVExFeFBENkEvNm5FSGpVVlRBMnFobUlRYzZXeVJEUWNNVTlqck1q?=
 =?utf-8?B?akViemRsRTJqSGgrSFBwQ2JmSTRPQlROVE1ubTdDcDhyMjNmOHNNbm8rMnQ2?=
 =?utf-8?B?QzYwRC91RnNtOEZGb0Uwa2hzK2NsT2FTdjBDUkp6VDlyUDNFZ25lY2ZCa2VC?=
 =?utf-8?B?VGN6aFhOQUdGQ0dxaEVOWjV6amFiRjdOclp5aGk5OGRyUG40QXZCUTJ6ejhI?=
 =?utf-8?B?aWxrYXVPVVNtTHdRR3grZ05PckQyRHVUcVhaaUt3blQyZnVCaCtTL1p1UlYx?=
 =?utf-8?B?S3BBSnNKTHdBV1VBSlJXQVZGV20vaXkrWmlGcXZTZ2xzWWRHQXN4aXA3QU0r?=
 =?utf-8?Q?1eB8cdWkNceDAquTQmNUWoZJCXNtZw8ens2+5?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091b6c6d-be03-4a9c-423d-08df3f3cdca9
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:11:14.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PQlmJ/VK4AaM7VfoFYONPv8ya3IbYa9CH+ZZ980BT3lL7PUmLe81WDosJ4yxL5pj7Jp3vgReah0L5uGxI2hSWe1EbeDWUanvVWRc/Ey2FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB324135

Hi Puranjay,

On 2026-10-23 14:19, Puranjay Mohan wrote:
[...]
> I found two bugs, details in the replies to the patches:

Thanks for finding them, and for the reproducers. Fixes for both bugs
are planned for the next version. I answered each point of your patch
replies in its own thread. Here are the answers to the rest of this
mail.

> Location: either works for me, but CONFIG_RCU_TXN is in lib/Kconfig and
> CONFIG_DEBUG_RCU_TXN in kernel/rcu/Kconfig.debug; I'd keep them
> together.

Planned for the next version. DEBUG_RCU_TXN will move to
lib/Kconfig.debug, next to RCU_TXN_KUNIT_TEST.

> Bloom filter knob: I wouldn't add one.
[...]
> I'd drop patch 3 until something needs it.

Agreed. Dropping patch 3 is planned for the next version. Your size
table settled it.

> API shape: every rcu_txn_list add, delete and replace allocates a
> descriptor and frees it with kfree_rcu(), so all of them can fail with
> -ENOMEM, delete included.  That is hard to use on teardown paths, and
> reserving first only moves the failure.  Since a descriptor can be
> reused a grace period after its commit, have you considered a small
> cache of them, tagged with start_poll_synchronize_rcu() and checked with
> poll_state_synchronize_rcu()?

The next version will implement the design of my second reply. It is
planned as three new patches:

- Readers resolve a proxy only within a resolve section. This
   is a short section with interrupts off, counted per CPU. A writer can
   wait for the sections in flight without sleeping.
- A local transaction takes its descriptor from a per-CPU
   pool. The pool holds 16 descriptors of 6 records, 5920 bytes per CPU.
   Preemption stays off from init to commit.
- The _rcu forms of rcu_txn_list run a local transaction. They take
   no gfp_t and return nothing.

A cache alone does not cover a burst. A CPU can run more operations
within a grace period than its pool holds. When its pool is empty, the
CPU steals its own descriptors back. It waits for the resolve sections
in flight, then reuses them. So a delete never fails and never sleeps.

In the steady state, descriptors go back to the pool through
call_rcu_hurry(), with one rcu_head per batch. With CONFIG_RCU_LAZY,
call_rcu() can hold a callback back for up to 10 seconds. The
descriptors would stay out of the pool that long, and the CPU would
steal more often. I chose a callback over start_poll_synchronize_rcu()
because start_poll takes the leaf rcu_node lock on every call.

> Separately, a one-record transaction
> never installs a proxy but still allocates a descriptor, 256 bytes
> unless reserved smaller; keeping the first record inline in struct
> rcu_txn would avoid that.

I would rather handle this in the users than in rcu_txn. A user knows
which of the pointers it writes are followed by readers. An update that
re-points a single such slot needs no transaction. The writers are
excluded, and every commit settles its slots before it returns, so the
slot holds no proxy. rcu_assign_pointer() then publishes the update.

This covers more than one-record transactions. Each _rcu operation of
rcu_txn_hlist writes several pointers, but readers follow only one
edge. That edge is published with rcu_assign_pointer(), and pprev and
the new node's links take plain stores. So none of them creates a
transaction. Recorded through rcu_txn, the same update would take two
or three records, and an inline first record would not cover it.
Patch 7 documents this in Documentation/RCU/rcu_txn.rst.

The rcu_txn_list operations change at least two slots that readers
follow, so they need a descriptor. With the pool, they will allocate
nothing either.

> Subsystems: in dcache the hash buckets are hlist_bl, with bit 0 of the
> head as the lock, and d_unhashed() tests for a NULL pprev.
> rcu_txn_hlist hard-codes bit 0 as its tag and has no unhashed state, so
> I'm curious how your userspace port deals with both.

The hlist of this series is for tables locked some other way, as in the
samples. A bucket with a bit lock gets an rcu_txn_hlist_bl:

- The lock keeps bit 0, as in list_bl.h.
- The proxy tag takes bit 1.
- A record of the head carries the lock bit in its tag and in both of
   its values. So the head stays locked from install to settle.
- Readers strip the lock bit. The engine is unchanged.

It is not part of this series. It exists on my branch that converts
the dentry cache to rcu_txn. The userspace port does the same with
other bits: tag in bit 0, lock in bit 2.

For d_unhashed(), the unhashed state you asked for in patch 5 is
planned for the next version. A removed node will have a NULL pprev.

> Also, the only
> in-tree user of list_bidir_prev_rcu(), kernel/nstree.c, walks either way
> but never forward and then back in one walk, so a user that needs that
> guarantee would help make the case for patch 6.

The node-lock sample (patch 12) is such a user. An eviction walks
back from the head to the tail. Then cache_lock_entry() reads the
tail's prev and next, to lock its neighbours. cache_plan_holds()
re-checks the four edges in both directions. If the backward chain
disagreed with the forward one, the writer would lock the wrong nodes.
Your reply to patch 6 makes the same point about LRU second chances.

> I can send my KUnit reproducers as patches if they're useful.

Yes, please. They can go on top of the next version.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
