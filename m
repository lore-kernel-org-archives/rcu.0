Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.99
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323542;
	b=VebheYbIYjLV5rl8cmgAaWkudFvxJTpbxuTumObEALuzTcHWhTZDgR6PzCQ662z6N2Bz
	 U4mxSiq0d2gLM43IitPivFQr+ZtQY1iwroWDaxKQO297m2/nSPaptqDhKQVkA/b+CXwVH
	 L5ITtu2dKvYDgCk12GMbZ4uzEmXzXAHoPT4aqflgQNUzsTVygq8iiNxyJcoJYVLUlRYYX
	 M6e73iWaDsl7NZED/l6C1zrOTbhrZccHZNY4NzvisuK/cDdxAsrKF4F49PmFaYBTdgWP+
	 l+cGTkYLCQ82toKrD63sbR2NUQFCnDgrqzOBGoeMc+njXhmxwDIX5d4aGqOkqKW+0vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323542;
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
	bh=dNjWeTnJWAtqOSFmKZ07VwnrDVziaD2HnlwfsZCAyKk=;
	b=crCgoDKZtLq2Q0+aIF/JAFY5SldSXR4zfnxZrXEtreV1VamBjz3bQ1CdBoAq24HalGSI
	 cQ7c0J3TFONTaMYnx0xrmSxIoesPhrFoYw5eb7XyzrCEXRt4avKEo1AGj034v20NK94NE
	 Z4WTL4bcmrpaeUFnh/g93rJxXgGWAzVQmjeiPaHUAEsMUgA5/Jea4Eqhb8mYKhXffdN/4
	 yEUohdRk6F/ElGox9v6OtxsujYd/19cRufxGs4t4Jzm5TCNF+LGzVG1BXM3bfJiz+T9tK
	 kLM0VIa/7OehazjEVXljt/38dpKIWitJWTSmMwbF8tmR8wAwwIM9T2WqJ1sFgF+6afw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=q7RmYGwD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.99
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021099.outbound.protection.outlook.com [40.107.192.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB02606A323;
	Tue, 10 Nov 2026 15:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFB02606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=q7RmYGwD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiL1Li7dVgl/aNSs1T22Uv/tQsVKw/8FZbESdTYd/n6nxB7yBJCFCfZiiCqN78yMMxMuuqhm69gA/7ZeS6YF/Q/OfvgCyxMmyIDKjUoCrQLbQLBR0EjS582gFfMc0k01bwvj2K60OM41TVMVPbOV0ZSDoRCkTjOVGydEhYvQHWTj2Pg6eoLJgrWE71RZ5U+fuuDTmizet3ZC1rES7IbvoADd3sSHxYKMUtQj4M3NA7ONGtFuDSZgTPcVOdY+Qv4Z5SCocHMP8v7SGFIYsah7pqUQuoDtihSdvS+DdIWndzDgjoun9YMzpV6iFzJUrjbsqx7e1JImhWfA99W4eQZFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNjWeTnJWAtqOSFmKZ07VwnrDVziaD2HnlwfsZCAyKk=;
 b=L5pqa5dp0u7Sn47WaQ6ahZyOav7xYVf6rTelt4ZVnRM8lAJjWhXrlKzfTKrkL4g76qd51GrZYv2OfVk9yBG5ZZAKHgGU6Ju1+l7zRbNYjpHacCEZstBkPbxMj7759CZuOVN7LHcrqH6oknzLSJMo1G89NLNEfbKQ864807FwjsmkHoXtKKsAjegj70MwuGe0k9fBX/PwW7SF0SPIcRwd/Ep8zzRn94sVxqm73k0UHwXh1t3Q0hoyvvK5h1cVNAPLJ/YvrekbRgxMaG6txWkcooRxcpB3Z+iw0ItrUznTdlgE03BlVqjFuUaFTcT83OfyDTGEzy9LxGci86/HS4P3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNjWeTnJWAtqOSFmKZ07VwnrDVziaD2HnlwfsZCAyKk=;
 b=q7RmYGwDy66WdaYUnSIHhCSBvR+1jOWF0VwyBAcIJW8olWvRaMPUQ79O6zByR4aBLUCH5El0HKvrrr3xs7LdOJdythE+3C4x4J9tFvHxWRHNAHdUKNfCkdGhNfQZFuHdSH88shTlMb/VCdJeMomTVO3CnguMwzDGvhtBRasxwgQn3tDV81ZJd752tc5ZucTJKbeCpRdg43bC0aRypM2AxFvGFpvJhx2l7sZc7j47u+U3aaVXePo/UZk1xgPTHNn/btwKuZxAqyHhbZIS9vDoakosb8AKL5VSUFQIoGcAH5bWjabH+s3EiZoKNXIwQQK1xHoBi+8GVd3ZXwRKygh6yw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB6179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:68::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:12:17 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:12:17 +0000
Message-ID: <0f3f0170-5254-46e1-8244-2d6af615daf7@efficios.com>
Date: Tue, 10 Nov 2026 10:12:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/12] rcu_txn: Skip the record lookup with a Bloom
 filter
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
 <20261016133319.433617-4-mathieu.desnoyers@efficios.com>
 <20261023182218.479327-2-puranjay@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261023182218.479327-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: ea63e4d6-127a-4733-9a87-08df3f3d023a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|261026121527099003|261102123227099003|261021121427099003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8aaApp57KDkFRwfoRPhUz3LB/RyxoWiy78xyHMiMPKKHmi+O5DISrhKvKXk5F0Jv0XwsyyWlyAVBVh5pGLWF3R6WiOEZTIb8UzhidXd8vdH3Es4EMj/Nz2PCEphe0kUXYMED/FLf+UeXUyjCxrabcAL1TRgNU95q41+CwWifebLUp4lGvxfUamZeTyiDOCoUh0NIJsQv5kPMJsbG0RDwjZn8ZQKyQY30C5I71B0nj1Aed/lsnGjQfFfmgn1CXbEt1b9+Jmxi6XXYNOZcjzxtiaLxSDOj2iatLNqAkOD7wTTPPRwFbdOtv/hmjzqUphHwdaieBaxwG1I49RfcTnXrSjee3/bgQQrEEkMHElKd6tEUqiD/hP/69ADkqL4GY1ICyQsCzSTTHjBhSzGCHXrnlgpDhPsCwjUYiKYJ+NFe4p2/4HRjGYY97BQFQ0gK+ah+N2WuTYkVYyedmjQK5ZzPRuOh54v+rc9wvQwp//rVAv8bRadeF45JOkY2FltBmG6fenGi+o+Q+aGrNv1ARQKdJ1ycMJaLOwY8wPF71lM96fW3i2xe65kTa0hi+qQ4llTHf4ygia0Hx7sx8kf7sTeEhZpC9cF3STR2M6Fx0QgywYs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(261026121527099003)(261102123227099003)(261021121427099003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THBlWjE4aGpGQmVZaTVUMTV0ODUrU2JaelVyYytHZDNWdFNrSlJZdFNmRkJj?=
 =?utf-8?B?emxIQk5JTVNJU1NTaWJadjFqV0pSdWtjQWx0UndkclN1YlpCeHRaTkhONEtj?=
 =?utf-8?B?RVJubFBSK1lHeG9RK0xLVkxBSGxnczgvVW50OFlkaGdUdVQ2U1NCUzlSaHA3?=
 =?utf-8?B?TURzMkUvSjhBaVFGbnpQRVltUExqRDJvdTgzZ2NKU3l2R3hxRjhMY1B2R2t1?=
 =?utf-8?B?dldwd093bW5HdEFIaktidC9hcUZ3eUpReTlXaE9RbUZnZ1IzdklEeWYyNDFT?=
 =?utf-8?B?MXJYRzhFUGhycDNEa2REeEFuYy9oMCs0VVB6NVppVmgwSTh6bTB1UkpuT2lr?=
 =?utf-8?B?UzZobEVFQ0tDeDFIeERhMTNob3pIUzB5eDBMRDJjMUVqeDdOSzJzUUpQZHJO?=
 =?utf-8?B?Wm5ZYStmUGlUekJ2RHZwOXAvV0ZOcGs2ci9MbHN1SWhaa1ZsaU9qSDVaSGhV?=
 =?utf-8?B?bHE5TE1uc2pOZTNwZHNNZUx0RklUTHk1VFQzRDM2WG9vVFF3bk00ZG5iQlpw?=
 =?utf-8?B?Z0QzUGtuUE9NYjZLU0pzeksybTlaSXM0OTlxVkdmaFZ4R0xHL2FqWlZMUnlE?=
 =?utf-8?B?a2NyNGJBbHlRTVQ0cm1iK1dHQXpHZkljV1pvdVNsU3QwcmZyM2ZNN3VwSlp1?=
 =?utf-8?B?dllpVEYyM2d2ajhEZktHbGwwcmhldUE4RHZHZnJpVnRHeUQ3SjJLL3YxY3hv?=
 =?utf-8?B?SXoyV0dYMDZac3dCTmtiUDhtc24wUEpyVmhkSi9ZaXNpMlRXUlF3bllQUW5a?=
 =?utf-8?B?ZzE1S2hxV2V1eG9FenhJUUlxSVJ3NUVqQVMzZWw5ckZVbzZVY1IxMk9lblY0?=
 =?utf-8?B?MTh4OTg2KytTeVhBZ0Q4T0tsVldDcTlCa3pheFVUbWhDcE1PL1JuaEhoT285?=
 =?utf-8?B?aVNTV0I3ZHRROGJkQlA4d2RaMmM4U3VhSUl6Z0U2UjloVStoc2lUOTF6cWsy?=
 =?utf-8?B?ZjhUemNHQkhRcHpnS0JXb2p3cjg0UThtVXphQ1QxbEswbWlTcWNEeHgxcHBD?=
 =?utf-8?B?bHZYaEFpbG95dWRJWWJ0OXVkYSszVkZ5M3hRZ0pXei94UWgwMFg1MmF6MWV4?=
 =?utf-8?B?NGQvUkJmdVI5TWZ1TzZLaUJNUS96R2ZWRms1UG9kbEJ3TE5iaUoxRk5LcXFz?=
 =?utf-8?B?R2orMnRwZjBtWllyNzZ2L05VcFpoNDRFbUFCNmJUYWFudGNWY0ZMUStRb2VE?=
 =?utf-8?B?MSs2UVZtRWhvQTNwKzN1d1ZmZVh0YjdYclZTcmFaUWNwdkhXaDQ3UnNKd1Ux?=
 =?utf-8?B?KzMyQzg2ZGE1cXczMm85NnB0MGZKczdkT0RCeXZ0TUR2NzczWGRXK0tMRVcv?=
 =?utf-8?B?ekdyWHJtRitrUmh5VXNUdE5kS0p1cU1ORE1mMk4rRGdKZkhUUlEwQlFPWXJt?=
 =?utf-8?B?RjhkblovNjZTK1VHSVViNkNGdWt0M0tEUkJJQVhuR0lmMXlZZzNRSUUxL1lx?=
 =?utf-8?B?TU1yZFlOS2tTcmozamtjUHRQRWhhSDVGQ2JQWmVRbGFLRUErZFFSdFdmTmM2?=
 =?utf-8?B?YURTNUREUFN0NHRTM24yMEt2RDJXRExzNEFrYmZyQ1RNdHpUY1BjNDJDNjRw?=
 =?utf-8?B?MlV4R05GczNoYTJPbnZlNEtTdzNOcnZEZzBEQUljRFVmeWFuRmUwRjJBdHRr?=
 =?utf-8?B?UkZKMWF6TVlrQmcrdzJab3VoQzBVSEFwdFhnOE5LMForWkoyendQM0lXL3Rq?=
 =?utf-8?B?QjVjT0xPMHpheUI2WUlxQlJpTHdMQnBGc1NHQThSUTBOOFRURGZreDIvc2Jk?=
 =?utf-8?B?ci9HdWpudnE2VE1DeDV2MEZoWlMxNzJvaGkxeUtpTGFVUkdMVnVqYVh4UTcw?=
 =?utf-8?B?VUNrWVNvUlV1ZzBIU0pMNWNOZzRUbWt2b2QzWkVaNW9QRkVJS0FmZHdFWFli?=
 =?utf-8?B?Ry9QSGxEeDFMai9XTk9wVVljN3E4eDQrbkdHWVVNaTY5bWw2bVcwcDRrVnhn?=
 =?utf-8?B?NXBEV1UramdDQTJtZy9PNklNY0hGSGtCSXRGZ2hHMUZSZWUyVUkyT3U3cURn?=
 =?utf-8?B?WU5WazhKWnpIMkNEY0RuS1l4UUQydERrd3dyUTFZME1IbkVIV2J4a1FqZE5B?=
 =?utf-8?B?ejZGcnhqUUduQ2NtclMxa05qZzBNOTRxdmwvQ0NtTXJwaFlJdHdBMmU1aGgx?=
 =?utf-8?B?eHJmcWVjTGwxc2Fqd2JabS9JdTdQdE1TVVBQblpIMnlCTXE0Qm9HeHEwOTZv?=
 =?utf-8?B?M0t6Q3NNWTdBUFg5dVZiZUNmSWRRN1cyTmZrUWNCcHNwUEpuM2JhZlNicjlr?=
 =?utf-8?B?K1FpOXZ3WVJFQWppcjhzYXMvMEI2Y080eXl5ZTdVODFIQjQ1NVI2aXUyS3cy?=
 =?utf-8?B?YWtSbDRNU3YyZ2Y1TkhWQ3lIQ1Y3Tjc1RlRjVXJocS9RNTJydkxZVGZmOCtw?=
 =?utf-8?Q?JH41zf+c0V4ck+fWtM7qzfICJVHy/hbBoB/v/?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea63e4d6-127a-4733-9a87-08df3f3d023a
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:12:17.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yhetcGRVHWUv/yrcivClPFc7rupTBZULyyH5ol9Tkft72OTzrOQKJfHfbSmmwCSgIrqT0po9b43CQVKFIzyCdJ/BWTBNyWTIip99lzDyKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6179

On 2026-10-23 14:22, Puranjay Mohan wrote:
[...]
> This patch adds t->bloom_live, but __rcu_txn_done() never clears it.

Good catch. Dropping this patch is planned for the next version, as
you suggested in your reply to the cover letter. The NULL dereference
will go with it, and so will the order test.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
