Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323648;
	b=bcFp7S9TeyqsxLgFN9eCm6KlejPAIeCQpFG8q9F7wHpR6+YglyJAt75IOfzL721LXvh/
	 KP33K/BrDMUAM9xbqM1VLwAUA6RJnQxe/2+olfA5yU0DlvcrTQuvczqUqZ+rD0Bo0mJHL
	 ONQO2IBXAYOIWZiuez5jarqhW6svYhI3ufHub9ErR6pPL1Nm/BsYNKhuZnJvhw96Tm2xr
	 Q3AAuugE9vKxmgMznXD5uuhwjrj+m8l4DnacGUDHdN+0dH3hnMryuIGAY/WYIm2s3TL/x
	 al4DUrwb+AGvdj6iTRUBQ6rHhAFsnpzTwlIBT6+OhnIqv5GrxeRJHeblIv1bYA3gJYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323648;
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
	bh=XJF8w20/M5CvGkoGiiOWxIiX34yr2V1ilwsoDthVZCA=;
	b=rLXVw33vWye84MT5i0GY9EmabK8sTYa08PQezUXvl5NIObQq4DYiR7zXrmQljpqcG+rK
	 +keyov/pRaEwMstwWcmVqwxC87daM+keCer4Wak73bpDE7RyEdzBcjCxk8t7n30MO5W+L
	 U1QdRCI56MnmZBktEAx452tztU/lZA2P/CUFNSCBE8ytHY14jaNzTc4sLSprKtft7kKTP
	 YiccektvWouH4wkS/WmlEn8iue9sj98G0N+wyiV/Gq7OvkKY9pJ3ngYALxK9KsP0tfteS
	 y79zYzffXUIbpAkyEJ41CW1NAlUUPaawGIgOAXAIPUuBlJWWvO2jOpNrl9am5/Frgbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PU38j0yi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.135
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020135.outbound.protection.outlook.com [52.101.189.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A34606A32A;
	Tue, 10 Nov 2026 15:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A34606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PU38j0yi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIybOzOxBvaCCxPSlbKp0Picr9YeVasRI2J8JtRvANDkIEAbv76mXWsR4HfRE35U6fXy0Ds4scXPS413lBnrPvtvFFwEjevQzZz0oZS6LtnHlc/cxQOsk0QPDbu1/6A48uMrTF/YIo6dhlS+C5I16b3VuB3tOE2stW6IDJkT1ufFWxR9TDINNEfH7/ihnvegx3hDjsjxGT3xMHpwqKBzzfQfXKUWUxxrmffNMDiCO9YdTMy5Jv+Da+gTGqRmXfnyHwL/DedJWSh9Uf81/hesOKitu5KH2BDGfOWHiUYuo/mmAu5uPSplp+MzRz7XyQzq9Zl2YdaUBwxwBy5VsdA8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJF8w20/M5CvGkoGiiOWxIiX34yr2V1ilwsoDthVZCA=;
 b=RdQeub+cWfQqXgi4LKSK6SERIE+wTd+Idl3luawWNJrxqisb8PljTPVVUaOgADtu7icUoGHA35vSfoRIp8iKzAzD9/UEbj+Qm90FCk7Uc/bXfPoLDYItu1fQPIkWfApj5uqmMS6J4uEiN+h65ORsyJu3FsL6U5HQthjrn+txolnqX4APDzthy/3tcRn/c2YYeuKiFfbInOCbCfC8DT73RS2DqcpuWFRQrSu1ZBWTnJbdlhY272rSB7weF2h/ejWI2AWX/NMNiMR4hJmu3dlxYfgv1RrPLMGjEsgZHU4P6l280wpbzsG23buTP0YLM2Sm9SxmvQ6T7Ek8R1Kmma4jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJF8w20/M5CvGkoGiiOWxIiX34yr2V1ilwsoDthVZCA=;
 b=PU38j0yinasi9fbpcxWB1okxwwPoZxh49uzu1d8ISk6q9mouU9uiQVm3Dk9ueQrJavG8mZBya5qu24FLZZX4woktDqPAdvzjbJu1a3KNm2516S6usMBxZRKr4rDR64bWw8xhMfWAYm4zY+PeOWNjLpcznh04mXowDjd/TOu4yaz9WPlaypaDUOt0aazk8OLri34teRrngWVR9k/SnpY827rHFD7kZqVJeO0cFDNk7+tE3StcZ3T3qqZ2O0lL6yDNic248tDeFtA8Ga82Wj2MVhhJgPr0Xbos9ddiO9mAsZAifkwrM0FYC5F3NNQZ4ye0g78HyqUxezET4nDcIdmvVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB215679.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:19a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:14:04 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:14:04 +0000
Message-ID: <cfc9a772-2801-4c31-ae5c-e034153fcbb1@efficios.com>
Date: Tue, 10 Nov 2026 10:14:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/12] rcu_txn: Test a commit from atomic context
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
 <20261016133319.433617-11-mathieu.desnoyers@efficios.com>
 <20261023182218.479327-7-puranjay@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261023182218.479327-7-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::14) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB215679:EE_
X-MS-Office365-Filtering-Correlation-Id: c705248a-26ff-4739-890c-08df3f3d41e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|56012099006|22082099003|18002099003|10067099003|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	am3zyjtwBiYgLSrzm0GI/veh3dDUPe6DExCbfhxBzYSL7o0SreV+0l7cHWPkQweHpqb18c4QvJRDPQi19WyS2aVDk5r4AhrErwNvEv8oMFI+z1ASSL1SCj0++y0eiNYBKKuEchWDDUtmFkIkCml5FgB0/h5GHHjeJe8QPifczPE67ZNPo/8uS0TtuBTXAYlVgNbFm9/U3O2oSyVy3UxyN5bnuO8YMZxWL2C+4Nh9AQtwZdz0phQ8lQ3rINmEtmqjACcqufEE27U7rdmHzEQrEn3d1efjpslU2H+P/7mwNeZB2Nii9ERYg5XjGYuiMgc0WoTnhJVkRi16Gg3ikhXBUTEAV+S71ABrPUVHfC7sYd7s/84ySU5pHrjoWLYUAI3sUapCbALDCEGhso2+iUVA59iDjAXeCEw+GCLRu3nWPDtApwkMXhEkgyA5PY7LuwrEoKa6d5IUlni4dk57xeskROq+njecB8YAMkd870eBb4MrjdOuvgKCJxUARDjufAuVFGgty+7z4vQiPnans6tUbk/WjuJpgFRoKrlj6T9WkWaVwbqAlVckHKXuuU0v/yw2yIBDSbUtFHZYhAKSZb8QL0WXeZuLAR4+wQLp5T1SHVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVZmRXR2R1d4MEpuYlZzcUw2VGhUdzhKYi9ibjdCNks1WlJ2YU1XZEF6cElU?=
 =?utf-8?B?OUN6UldnajlieFlIZnIzeDVRdFQ2VTR6Z0VFQ1ppcThGZjNRbDBoZVlQdmo5?=
 =?utf-8?B?VEVaUm52MnVJZkdXSVJUN2lWMjFXQmJCV0czWXpWMVdMTGdma3paYjFlV21t?=
 =?utf-8?B?OEtIT2VGTUlXbHN5Um5rYTVMWjhJUGE0bldVTmF5VmR5SXViSTgyVVVOM1dq?=
 =?utf-8?B?US9UWEZnNDlid3Y1ZEVSRWVPUTgrYWxCTmJGRDBSUFZYS0ZLVlpNUDlvQUZ2?=
 =?utf-8?B?Wkx3bm9hNUhNK2ZBR2VNMlAxbWFYRGNhOVBUNUJlV3p1STNPR0w3YVV4ZEZK?=
 =?utf-8?B?NzV6VDBVUWtncTZ5NHZmek1XRDUrYzdYOTJGL2NObDBqWSt5ZUtLdXBBeERy?=
 =?utf-8?B?bnRaam1ZS0ZRZHRPcnJlQUwyMldVVzRZRWpDbDFyTTNzL2owUk5GWEc3cVNP?=
 =?utf-8?B?bkNTd094K2pqcmx5cXdnbkVQcGhZeE8rSTlWWmthMzYvblB6Sm9pYjlwYW1O?=
 =?utf-8?B?SzhUUWNWZTY4WXRnWGFMZEF1eWRkbmZBbCtZYzNHY0tRWDNIYXpFMVA4Y2Qy?=
 =?utf-8?B?eDc0OTAvNGdjV0hQZ2FZWFJvTTFlelFXYm9HQkl3dXpBUnQwT0dGRGtmKzZE?=
 =?utf-8?B?VGp2N3gzSU44TGFncWhRY1BJbUVjT2h1dU9ybTQ4S1c2cjNDbC9qWmlLYVF4?=
 =?utf-8?B?cFZBQkJRaCttWC9TNHdqMDEyVnhjSUhmK05wQVdPcG92YW5rYlU0SSs2L3lx?=
 =?utf-8?B?akw0RVZMUFpXQmVEU29ydElodk0rVGNDQ1N2T2QvYUJ1cWZpRU05M01oY2Mw?=
 =?utf-8?B?S1NPY1BXRkV4MHVueTVEQU85N1g3VHBRRVBWNWVFT0x4SlNzQkdBYlNObVVi?=
 =?utf-8?B?ZWJuTWFGczVBWmswaGpXYXM0eVVxZEFqNy90VTNXZFJOMlZqRjJmd2tMUDZJ?=
 =?utf-8?B?aWllRFhMWHJaejBuVSs2cVY4QVJaZEh0Y2RHVXBkNW9WQURzZkthb3hNL00r?=
 =?utf-8?B?YUZwdnlZWlkwOWU3eUhzU09lanQ4ZXIrbUpkaVgvMjBqTmRjaU9pVUZJa2Z4?=
 =?utf-8?B?SFcwaU9DbkVmT05SVGJmZjNwTEsvVld0S0lVRk1FN3owd2FKQUp0WEhiblYr?=
 =?utf-8?B?ZUx4ckgvRlpGMmNieTQzakxqUTFaeEtrU0R2azMwblFxN2puUy90ZWtoNUR1?=
 =?utf-8?B?SFplS1MvUUVrc2srTXd1SUtFQjNVblNJbjdlMGx0QnNQQWlRR2pkWms5b3Zy?=
 =?utf-8?B?YlVQNDFGRkRVcVh1SjUwcmt2bXlTTW55VTZIQWp4bFpmaStKa21mYWpuRHRy?=
 =?utf-8?B?VzI3OVMxaWdHdVlpVmkwUXBkdVh1T1FHbjNnSW5zYzM5bTNtb216UjZHSTlG?=
 =?utf-8?B?b0FTTDFMazBsZGlGcStDMVpyakwvRjFJVmF2Z1ZmWkRxdmdMUyt0MFRtUHIz?=
 =?utf-8?B?WVhmaE1kY1FNKy9lalZ2Z0prck1ocUZKQWt4b1orMEJmR0hVUUtNMGR3d1NP?=
 =?utf-8?B?cHdKTVdWTXo1aWpoYW96UVhaNGdMZThvVlBPRTEwOFFSd3F3WXBIdFAxUjdi?=
 =?utf-8?B?WUFpR0wrbDlUcUtOaDdUSWhWR2ZKMmRmVHNMT2pxVDJQTkpiUld1ZkpkYTVY?=
 =?utf-8?B?MWs0aU55TVFJZGZXWkFBZWVPZ1BRL1lCTmxLU21nUGcvZ1NtMFBnUmx4Szg5?=
 =?utf-8?B?dGpmUHhsNkFPUndPMFg0SDJISURIblhVZVVNaSt2YkxQc0t6U1FHckR1Y1p2?=
 =?utf-8?B?Qlg3ODc5NE9KZkx1VSs0S2VmYmJoQTBzUHNjd1VQZEpFbWV1amJZQVhJMEVM?=
 =?utf-8?B?ZllQMlRQcnBoYWpNbSt4K09TMmVqNENIclRuVWlWMnBFTlJmaWFPdmtuMXlM?=
 =?utf-8?B?SjJGK3FpVVlNWXpPRGpQM3I4blBXaklNTVRPL1ZWbDBVZ1kzRzltSVBHa1B4?=
 =?utf-8?B?YytQNUhSWXFXc3c4cmlCUit4WFZKdmlydnhTWXNUaGFiSzYwaXgxN1RNMUk1?=
 =?utf-8?B?Mnd6bGhlUDJuMjM4T0hxamJFTzBPVlpma2w3ZDhDbkcraFVGNWRHeWFlQXlO?=
 =?utf-8?B?RkVjZ1E3NGxkZlBSQmpqMzJlbERRRXV3L3Q2RE5Sd0wyZldpR3p5dE5HWldW?=
 =?utf-8?B?ZEl6M1JkQ2k0YSsxSWFZTnhDdHFLRmdlMTB6KzV6NjNZSVN2MTYwTlVmTXl6?=
 =?utf-8?B?Umo2SHpESkVvMks2R1A0VWxFai9GTThKYVlhVU5GdzQ0SDlLTi9XZzJKOTM0?=
 =?utf-8?B?cGtQeExyUjBhREMwa2hBTi9jQTJFRC9tMUpXWlNPMlNMcEtGY05SYXpRRGNF?=
 =?utf-8?B?VDEyVC96ZU1jWXJPMTYrU0Uya2RkZURiZS9OMGEzWTdYVkwzTjI1a1prZkpZ?=
 =?utf-8?Q?iGP1PHl4EM45gKNm9ejkqyYy3/iNCkmkxd8zX?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c705248a-26ff-4739-890c-08df3f3d41e7
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:14:04.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFD5DizEYvuao9hKYaixsKiMO9kS4EQ+dXNXl8zqMJs/oajCIRHrfTTqQAqt/B/JrV/nYwPK/3tk5BbO+MIKFpEABP6UtSSxrm7mkO4pD5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB215679

On 2026-10-23 14:22, Puranjay Mohan wrote:
[...]
> This matters on !PREEMPT_RT too: there, a one-record commit or a cancel
> under a raw spinlock calls kfree(), which lockdep can flag (see my reply
> to patch 1).  The test can't catch that as written.

Agreed. The next version will fix the free in patch 1, and this test
will catch it.

[...]
> Running the one-record and cancel cases under raw_spin_lock_irqsave() in
> a loop would catch it. 

My first try reserved and committed one handle at a time. It did not
catch it: each kfree() gave back the object that the reserve had just
taken, so the sheaf never filled. As in your reproducer, the next
version reserves 4096 one-record handles first. Then it commits them
all under one raw spinlock, and does the same for cancels. On x86_64,
this gives your barn->lock splat with kfree() put back, and passes with
kfree_rcu().

[...]
> A kunit_skip() when PROVE_RAW_LOCK_NESTING is off, or
> debug_locks is already 0, or TAINT_WARN is already set, would make that
> visible.

Planned for the next version, with these three conditions.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
