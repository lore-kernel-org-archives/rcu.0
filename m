Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323582;
	b=qebbiUfjUirDurAQDtOL8ebKXDGu1NvJBRtd/2yGaL0a5q09z/7INMsZr8UC7FlAP/GB
	 LUdRh5LZMl8uN8sxGzONjXq/+IheDkQwnjlJW144EYKx6EzLVSudJtAFYdUnGia7hWrMD
	 x1D8ZRCw37zy7eNzCFlVLO1b7keyDHCrpDuuFqRB5dbA48Z59/qH1g84Vf4a+hCF7P6Mh
	 SE6kFGEbsmJmf3BNLUlWMXqxn2ztz0llQ2979m6hAULR5I2AJ9bbUEBwU1temOpdzp5K9
	 iyR1/Cbm0LAFtuGa7hpT02WH03ERe0RBw7ZaOxTC/8PHhBwlFAEuhvASTMfKmo2I8eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323582;
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
	bh=MyUDlGoFzkb03ezR1urYEGMK6bXqFbHvHYNhmqMVAUw=;
	b=tGyGB0JIHNtQP/v30xB3IAH82SGw989H/+6u/fjkH7oPrtpk4SsTDccuc3zfmUs9L08E
	 NaMjhc3xVtR9PIXhV5YMipbEAls+jEJ4wroX/KgTNO7Dc0dAsHunpfGnibJCdgW9N2Al5
	 KIjwIBkkRkj2p4JUFHnJFPR1bcCzGWpMFcNIFTJpUYeeIMq4KaYwujCMnVztUNALTF/9k
	 +1BTAuczdHzByVol0SpzsnPGU1lD7gMZ+GpgU35DzBDaqFnaXwImM1j7pQVYq3pVrJwFi
	 eYqtDk48qGjCgu8XHCjHOlYUce/IbgtltVsd3PxrYNvLYcWV2bZwj34IYrEEs7PHcLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="BG8iu/ex";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.76
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021076.outbound.protection.outlook.com [40.107.192.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F946606A31C;
	Tue, 10 Nov 2026 15:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F946606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=BG8iu/ex
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKpGK/i+wx+7jdJmliwsRHM+LHGP7zdtpYnGic62qqlOubC2Z4iYS475l2D58znDcTE8JTkBLup07Dzn42cjT64CdHZ4K5ffGhgb3Uv4hOLSing2iBS5vCP0QGPMgWvH7gMNSzYB+bFAGm8nX0a5uJh9771xyDLqtCsClD8M2Ph+exRoHYx0B7Zx3SIV7p25jgXsWmiA9Q4Sb6qb8cCHlr4mHY0PatvS6XSdl4kIgefDH7gzINRY+UgNxNhkyKyhsE9MhaUxBXREsqc85th36yLexN/BYGMoGwTVK2T9yT7XourjB9iSOqz48/0n2DhzElSb52a6d7UY+xHURcwrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyUDlGoFzkb03ezR1urYEGMK6bXqFbHvHYNhmqMVAUw=;
 b=FzLLT2wIKs5ajRATfzCvvCY9HSSpwaOf5wL+Wl9pM9Tw4pliqIPRshJujw3D0Cg0XkpFPo99G07GXEt/pykzeHdYCMzCHUgqLm56Uvx8wNvhAqf2WUUCrZftWrTY1uZbsr46b9RTyd6HVjAHXR9ejCLj7FbX36OtyG4vR1JzklSjzjs14IInhPysBoO6hKQmHnhPuGSCUU/sI+P65iOBx5g/nCkcQBeZcV/fH+0tisP6SQXHBJNMTGWpg+6I1wzvH3d/QHJBFfgCzE3n379rdanp5cfy8bNRMLIiMhuf+QzI16T4x87B6Cv22kD/oxoPHHQ0g/Gth7OmWHImKCu3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyUDlGoFzkb03ezR1urYEGMK6bXqFbHvHYNhmqMVAUw=;
 b=BG8iu/exu0FKZ7h9N6oOpbgvUJvunDYAXcAglCqpWxqTl7l3lr7fNu/w9JrOZn11FaqL6+GSptpD5hBM/PxBOXmf6qPNLloGSv2LO/ZxqTWr5StO9HCFebEa3ySe8Or9kKC49CaHl91lxCX1Y5zwepBc/rRL9Jgx4Q7mRU1RTbcoWPEgY4G3eHC6OLMdoYi2laIuy2aZwoJayQsYRKyl7QFB0GvZcI5Dy78WuKg4L3Rbrk9yV1OawQCM4EV+zfaYOXYynZxuTbm2BzTle2RPmCuCDKnvxoiXQlrcwR2bVIV4sUKfOcBBmMcJVOxfDZeIxa57A5X6J+qFigAvvDzmeQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQXPR01MB5460.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:12:59 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:12:58 +0000
Message-ID: <9d5ac760-d8bc-4856-b24d-f4daa827396a@efficios.com>
Date: Tue, 10 Nov 2026 10:12:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/12] rcu_txn: Add an hlist edited through
 transactions
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
 <20261016133319.433617-6-mathieu.desnoyers@efficios.com>
 <20261023182218.479327-4-puranjay@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261023182218.479327-4-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::7) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQXPR01MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e7a903-ed00-4c2e-3a71-08df3f3d1a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|10067099003|4143699003|261009223027099003|56012099006|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	d95wjI/Xl7eeMZUn7QHpSzI5Prqv4whKn6C5wjioZV512PUUh00NxPVnyJN/7WpJJGNTRHqxmwlhDXp5fFkWSS5y7alxo8jBgSFi0npwNUot+3vPUzxkaJ5dPX/8cDoTXp/zF/9HRRGRFAtAJNVGtip7UiwY6O0udb3HmmjM+fYUv29MWtIsEMVAgwBgBZqAbe6/nuP9KIeFY6NIFaFc0QuHK9/TsuyhmS42KIXVd0vzBWNpvY+79rZRVCZ5Cja9zCrEtXKFHFE1JyI2TGGYk0JMzFhMe7NC8ApzVYIHyhLTbPRW3Kl9HqgFt16pLoVoV/WfLkv1rv5RbQ8kxjKSNUFKRghhDJcAO8NPZW0qz3RkgtoZut76vnQg+aruaJBTjaQ0Zoerof13dlnvhvq+4XrTukYLBuG8A1w5k+eOsYEAgZ8OOJ1I/RuH8pdyKt4SWi8BesKMUan1cS2KnEqqvpLvIdjuUu2HtrHZIGuTRJcl5Hf5aq94LEvjap3Z44xDrWivEbzJGy72H9oeogMyXO4ABp+HkyE6g0SKzOIBGI0XnXK8hAB330q+SmWS9jg6wG/k/DTuesg/WzJHqethhXxkUOP2RjbeR6Pbf5bifEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(56012099006)(261021123027099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXB5WDlQcy9Tdm1ZWldTTFkySlVudDNJYkw3K1d0RlE3NGdycHlMYVF1NHZn?=
 =?utf-8?B?bjRXTWZkejFud3VpRVN1Qk9pNWNyU3BkWjdLQ0dHUFpQUGdMc1Q0Q2dWaCt6?=
 =?utf-8?B?UFVZWE5mT0N4eVpiRGxZek5aZHVPZjlRZHRMZmJBTEhVUHU2YXVKSEh2NW5l?=
 =?utf-8?B?UzlNY2VuU08wWWkveUxyLzRza0hKUWNvRWdrbytNWEpYOFQ3YlY5UzNyV28v?=
 =?utf-8?B?Zzc3MUw5ZHZMREdRS3VPMzJpOGxid3IrNDJha05BK0IxMGc0SjdBUi9UbzJB?=
 =?utf-8?B?SGczWXZPbnpoWjd3dEExM0lndWpwZGdrek5KNkRqUGNQRmcvd1JCN0JGYWhT?=
 =?utf-8?B?aG44YmUwTE1QZThpa09zVE9YUVNGNTJ2MTc3Y2pSbFJQUDJ2eGljR2JSUDJC?=
 =?utf-8?B?czZkM2ZUR2ZzSzQrMEpLbHgzeURIeXA5UG9ScndpZEZCZjF4VUd0bng2WFJi?=
 =?utf-8?B?eUliQzIvWEJ4VUxYNzVvcDA0MVhXbC9VQ0d6T0hCeFdpNnNQRDUydW9Zb2hk?=
 =?utf-8?B?T04ybjBDL2UvNE5ZeWQ1Z2wwb2s0UW5aVVh0M1laTXlqKzNRL3R4dktZU1lj?=
 =?utf-8?B?YUpoQTdqVURYZFFyeGFnNTlReE85cUtiQjBtK1c2YnEvNUlEOGFJZE41WDRN?=
 =?utf-8?B?UVZzQ290UldMYy9jQytDd2tPdTRGMGxGL09jN1cvVExaUXl0eU9CT2F2ZjN5?=
 =?utf-8?B?clZObTZ2Qm5kN3FOcVNvbGJROG1aeWRBTmRHQzZDcEtBR1J0eHZUZWZGRHk5?=
 =?utf-8?B?dVFPbFZtZStSQ20xODRWNVB5RHYyR1BXeWF6YUhvNC9pWFhVaC9HWUM4b1dz?=
 =?utf-8?B?RmxsTm56WGtrRzhQNWNyUXdjT0dwdTcvQUMzbW5pbHhoT3hHTnhUd1d6dDFC?=
 =?utf-8?B?dktHRUxYT090N1ZpZXBxK09mYWM1ODkxNTZhWGxGU0xpNVVGMW0veGZUaUlu?=
 =?utf-8?B?R1JMb2lVYUx3S0dpVDJ6T1RlUlZYTk5PdWt2K3ROa3FSNE9WdHNQbXlYNDlt?=
 =?utf-8?B?a3hwdVNlZFdnbGtOWlNCOUd0b0UxM0NkeDRBVUl0OHpZOG9kWWNldXFGTnZQ?=
 =?utf-8?B?UmpTNW1XVjV5QUVidUR3ZTJCMUJRMTZtb1VrTWZXUkZ4SHZYVzA4YnFiSDV5?=
 =?utf-8?B?SHJOa1V2aXZ3eXd6MndMeDhMU1pQSXVySHE4VXdhN3Y1RmJUUGZPa3UzVEF1?=
 =?utf-8?B?TUdTTVN3bURzNzNyL1E3dXBNUGhNeWRJWmhramxRRzRSV1RVQ0wxaFIxcFN2?=
 =?utf-8?B?ei90ZXl3VFF1MWw2Mzk1emtwU0x1ODNyek1kcHBKWmtJbXdJMk10ODRQZjcv?=
 =?utf-8?B?bmxvZEh3Q0pmaEtoVUhjbjZ3bkpNbDNzU0FRdTFlVVhUNGhLbVVxRkY4R291?=
 =?utf-8?B?WVUrNFFYMnhaaWVvczVMMGhOSU1CcFBZZ2o5RXJHM2ZiRFVXTFd1dEQ0bGND?=
 =?utf-8?B?K2svbHBkdHBKWllVZHRmUWl4d3ErTTgvaXR4eXAzczJtYU9BZ3k3MmNaSG1r?=
 =?utf-8?B?L2p3NVl0bk5XazZieGgzcmFLZ3czV3RwbHBMV1MvdkRlb1Rib0lURmcrNTlU?=
 =?utf-8?B?MmNkTHY2MGQ4a0JzT3VVb1pHMkJ3UEpkSlFpcmFGN1lRK3A1QWVtdytyZk9l?=
 =?utf-8?B?ZEpiUkhNc3QxMllWOHcyWFZlUzBRTlhuUmNuR1VGeElkaTFENDNVc2lGeDFC?=
 =?utf-8?B?VUZYRHBCcmVUZElPRjFNZGhYd2V0Q2hOMGNRS0NmMGlEM2RZL3ZFQTNaSmlm?=
 =?utf-8?B?L21xRFJKZ0g1b1RFWFczSjlpcXRoN2JOVDI1NTRKWloydDJtTHBhTW9BWEFD?=
 =?utf-8?B?NmFSMHdPQnJaUERrWkFaY3BEZVBzajNMOVRUMmxYNFRqYzYzY21ObENPcXVa?=
 =?utf-8?B?MTAzOGZBRnhFNXBLNFU1MmQydmpDYnd4UHBnUTRZdjh3WTFvMXkvQUFBcURB?=
 =?utf-8?B?M1VFS09kaTlkUVdPOWw0UEI1YWI4MURKcVdKOFdXcXZIS3RKUjEzSWYxVk80?=
 =?utf-8?B?c2E2VFpSNFhSeE1ZZW13TmlJRkVPV0dqMHU0R2tQTldlNnBPd3M4M2Rta3F3?=
 =?utf-8?B?Q1RVdGZRVDBEU0k5VEtvY1Z4bG1GdmFEYzEzM3IxKzUvS0NPckN5Vlg0dVU1?=
 =?utf-8?B?eHgvUGNiMG50N3RYR0Nzdk5ndjlLcnNXVC9CVlZxWUx5UkdoVERJYkpyUUpE?=
 =?utf-8?B?QjMxTWZwdkpGYWF1UmY2S25PS3VGZHIwV0FQL3dMYkZ6RGVyaGFUNzdVM1VP?=
 =?utf-8?B?MjBEaGFFa0NOMTJFOElZdStidk0vU1BlR3BKbzhIWktGbnh2ZGJTRGhWK0Yz?=
 =?utf-8?B?TW1MVHhTTVlhNHBKdjZRbHRFTWNEVWJYdHhyYU93R1N4OERYanBqZGRndmtV?=
 =?utf-8?Q?iIc8mSJUY2WgEFYSFyOqqrjEEKSbQCDG/s6ak?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e7a903-ed00-4c2e-3a71-08df3f3d1a9c
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:12:58.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6NzcoKAXlup+x2jIgQ8dbXWYxRFJ6/QfnNNyz3QWmhs/k1z+KA59l/fba2/fO9+DxCdWNir0h42olfUn7dwRhH2+aEQCpV8RcF1wd13ozo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5460

On 2026-10-23 14:22, Puranjay Mohan wrote:
[...]
> dcache relies on d_unhashed(), i.e. a NULL pprev, which __d_drop() sets.
> Could the _rcu delete and replace clear pprev the way
> hlist_del_init_rcu() does, and could there be an
> rcu_txn_hlist_unhashed()?  For the _prepare forms, del_prepare and
> replace_prepare could record pprev -> NULL through
> __rcu_txn_hlist_record_pprev().

Yes. Readers never load pprev, so clearing it is safe for them. What
you suggest is planned for the next version:

- The _rcu forms of delete and replace will set the removed node's
   pprev to NULL.
- The _prepare forms will record pprev -> NULL. A cancel then leaves
   the node as it was.
- rcu_txn_hlist_unhashed() will test the state.
   rcu_txn_hlist_node_init() will initialize a node as unhashed.

A second delete will then fault on the NULL pprev, as hlist_del_rcu()
does on its poison. With CONFIG_DEBUG_RCU_TXN, an edit anchored on an
unhashed node will warn.

> That costs at most one record, though a
> lone delete or replace of a bucket's last node would no longer be a
> one-record commit.

Yes. The samples will reserve five records for an unlink.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
