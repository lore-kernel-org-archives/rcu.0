Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794604944;
	b=CuL+wHKRJ+RWZmHdBA2ijffAhkdlhxLFh8dp82eS9HH0A6jA7P0kaGK5RL1B7cpKFx7p
	 2RLQKKOa8Dfif37vjQ0/GMpXsn3SjTepWdh1G+OyNe0zHezLtX2lFdLWDJ8whoFLdS8FT
	 +qtxqbZW33L/xfcYYV7HCGWBKdmIWxH5lgGWJucEStrcUTXAwgTvh1bggpcMx1M5nr+Sv
	 9lR907byzM8cOEgGYDQkRADp1V6ZA6B0uPc345PRdBLLPEVDf+RzpwWJRz64UkXrKFmV8
	 VTGK0STUMHaomGD6dtVWSM9SC/Z8qiX+9735whBfuJtX/lwhg/xn9DmMxuPbJHdFXAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604944;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=iUUWfOIisgbrCVW4YUkL53arxf4v09B5XfJcE7IY+wo=;
	b=V+KIhs8YFsOKvBOkeSVntUBGhq8SRF6HGaw8qj4Oq5lwZaCOjEOXZaPXiVyMzRGz1j63
	 nofF+ZGlvwyaQEPaEgb5s0ML2mDKaLBYTrQaQjpvZWxrJQ63J7QKQTB37JWbfXbAMi+ow
	 ldv6ZWtr1pqLPkbyOo+V2z4+lLnP03rNozDCp1ohK6MnH4JkOli0FJtcVO9GpJS6AqSzM
	 2oJ7/ZilF4tl85Cy75q/Ggis1e87qhthHdwSlW72tPwrTkomPcQv0tlUP/0nlVX2gc8uU
	 wbVIHZAnGV0WYS25CrrNAfwWdod3m+PH7HL6RCFpJIxQSh5LsIYqtTDUGWyTLUqMErg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hPrIO+RI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.65
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB353606A32D;
	Fri, 13 Nov 2026 21:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB353606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hPrIO+RI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrJV41DC+LA63t5QptakcjmO2QlY+O35CFG+nxrhjYbB3oPKo9YtourrAU4j3RYCqjR1RU4TshNYar1Z+LVbU8kd2KK8C8wke5txm6Tl9V4IseL4fdESPABpqZ2/l3n6OUiS4pOvIddYRE7qnOH+L8JTTH5aqyamNyBZGhrNpdxn9bAB/Q3utRvLQ5E1VK6HqF6EBldis1Z0+ZUxIsOzom8zMUioDNabG9t0mc6WiW5AdEEO/pIw7pjnR2fUcNVtFKpzRAMAFCiW44gGa9eqX39yt+U7uRRJIk91e2fSK6hGKG2ZgX/BfBQqkD0ap1p8cIFIt3+lE2pkMzARan1N6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUUWfOIisgbrCVW4YUkL53arxf4v09B5XfJcE7IY+wo=;
 b=iU5ZUs5+P4/ksE5EzXeYjhI+XoioKqTC7/W2dNPWvcqw4j8zhvjXKkEEDqyj1vBpSr0wRqq4NQsfMlxUa1KQRQFIsnyLKFTpAu3gZeMVWMl0f688YRmyPzRkaNHuIkGKBGSNYcJwL22Dj6BsvgdYV2BVVggjfwl1LwV2+CosTAfN6HTzPibAxgyLyaOBntPG7wR9afKKXawUC+Bdf/ePyZftnlKUOyzTki8Ip5gyUtICV0/2Lb97KW7og2ejVtljvsIlhXVmPHUeOdrhFjAPCprrFSqg5XFpDilOazfnXvnhWSe+PiaM6xOdiM6FCvarH2Zfpf7mzX7cxoRkkWgvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUUWfOIisgbrCVW4YUkL53arxf4v09B5XfJcE7IY+wo=;
 b=hPrIO+RIknyNjW28tMYHKpKfVb3Gu5KUF6VHY+aDkDTQFLjirH0aFA6owz0vqXQK493Lz2mjccormEClslkGV38PLNY75q65wsnAenlz99GnFcz0v66KY6ed/3gi8FWiMl/3FCP7ejM60JBZCR3f4xcy3o4wfV75h+YegCk0CMFlYqxtgr5Orio3bv0O6lGwI1ikTB9SZ1bP4YSAIq85ljc4bnHSenQ4gsi4u1SjLO+cKs4finBNf2JFJ2RtAtfxjEMM1Oug16qafwyGFVouRHbNDSHYOhgrqBvnzKnxvo1kG23S1q6/02YkhdPPcMBrw8owe93tVy4EwDwZ/E2fIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com (2603:10b6:61f:fc00::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 21:22:18 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 21:22:18 +0000
Message-ID: <29fffc1a-081c-489e-b61b-3b37b2bf8bdf@nvidia.com>
Date: Fri, 13 Nov 2026 16:22:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/7] rcutorture: Stop disabling RT throttling for
 boost testing
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
 <20261111213826.2035045-3-joelagnelf@nvidia.com>
 <20261113155622.3SM4n6rp@linutronix.de>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20261113155622.3SM4n6rp@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:208:2be::34) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1765e600-a438-4588-623e-08df41cc3214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|10067099003|4143699003|11063799006|261022105027099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MZ2k1vQfgJo/5lwkZNru3uNc67WKwOqFs5HOcOUhYNmTsssz7G3EkNXoqrPMk77zKLPP9X3UIy5N+kwXyVGu3pULQnTe12ApFXEnCq2adYeMxJEK4FrpHoHjQ6cdMJC8B/UoZoEjIxQZKgeNWtwNVgFSOATI7t51oUn8mhW1J3SivoWJ8d/7dpP2Gu+sbozIQE/azDk6mrLu7M7TaW4Z2D95X73ky4CjWLt6hXu24AFTmOEFWhTCnjjTvgEzjH1ruzwAhjU25JQAxz7hzGP4gG4p8MkV157ch1PMLAPTZD4vRIxnyil8EMTGjMIzSrYxwKnAvRUujur0rCBuPZ3vbOsYnq7/5IB/hNUnhbZaiFBFp9+NlC2d4Vc2kcz4TZNmcGCUFkgZTQHWg5wf2VDlWAdMZI8o0zakZeq8XISCIY1k/TzkiONB00JxjRD2jtbRCcSlPF4HYdFwccbw8/+edTOYD1QFBuFsoibF1tugCaqfZvb3dSgCKt+ndbWAfdGj5SZDP9hsz6O8PWDWgQqXwMBw6JE/amy3Xl7V3BpNou502mMCK6gIE4e/tuC0mNCMwfr9LXfzdE6EYvSE3W1yKETsQcm0AiiL+yfhIljnvLH7uMAhhrNQ6x++uXp/96y2UNKiYaIc9ZpNmSvWcmNjBt9cMvNJ3EqP+g7hcsW8pfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(261022105027099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzlwWTVwR2t4OVJXUkFSS3ZNMWhabTlEclVodDRsdTJjU3hlaFk1KzNHaThj?=
 =?utf-8?B?UVNXQTB0MWQvcHJPNFk0bmRoTkZpdkQwME51QXlta1hnZG1lZjN0aFg5L3I5?=
 =?utf-8?B?d2hlWFFRVnFtTkI2MnZLOXVVWmdKdDZaanJrU1BYZ1pTSVl2NmJ2MzdGZ01W?=
 =?utf-8?B?Z1dtVGhLYVFaRWlYSmV4SmhKL0dvckxLNk5BdjlzanhmWWJUaitLaEtrai8v?=
 =?utf-8?B?NlM1WnIvV2dXcDhwQ3NwZ0g4bUJwekhWakVrQURhTDJsVU9Tdk9ncnNHZzdJ?=
 =?utf-8?B?WUJWalVvUHJoVDdPNWlRamo0ZFppb2t6NnU1S3hqRVc0NmNvYmtQU1FlSW9t?=
 =?utf-8?B?emY3MExKNmt3RkVTNVFqRXJudm5pakhVMENwdDZIQy9qamM3MnJERTl6Z0xH?=
 =?utf-8?B?VFRDYnVRUmpyMjE4UFNkWWZuSVBoUlY3aEJGcHlrN1BxNERZd0srMURpMzlG?=
 =?utf-8?B?S3JYM0RqcUR0TUkyVFFndStNV1NwZ1A5MElUN2tBR0xNUC9SbjhxUEhRNDcz?=
 =?utf-8?B?M3hVeWtkTHU5SXBhbFl5OEJyZTlldFJYL0dxemxrcWFQVUp3NlgraEdiSml2?=
 =?utf-8?B?RnpiaGV4MGtHTHhOa3dCL2VPVThOZTdBWTltMzAzNnFqME93NWdqZjBkanlC?=
 =?utf-8?B?cWZ6YS9HQnRnb3h1OUprWWIzOHBEcEs1TEI0SHkxY0l1R0haYmxZR0txRVFU?=
 =?utf-8?B?TVdBQXE2M3M1Q1krUFJ3TkZPblhsTXhwWmhvc01EZDQ5UVNIak8yWU9UWnZN?=
 =?utf-8?B?a0t0T3NPV3FsazY4bU1CcmhyUU9NNWZxQ0ZZcTVKb0Q5K1FUZEYwaDJsc1B5?=
 =?utf-8?B?Z1dCbzJhSFF4SjY4RzVEMTZNdm1HTi9WMlBZbGFQNXVwazYxUktpb3h5cXZ4?=
 =?utf-8?B?WDBuKzJDUW9BbjBCenByTTFMU29IUnFtM0YzeUpLVmRNeXV3amd5WGNoeUdZ?=
 =?utf-8?B?L3FuR0V3VXlOTDB1Z3o0bXk3ZjkrNncvZzFoRWtaTnJrLzRJNzZuWG82REpQ?=
 =?utf-8?B?T3pqMTNYa2NGbFljSm5WQ0kyN1UyMEVYUjFrR2VvaUIxUlg3WXF0WkdHRUJM?=
 =?utf-8?B?elhRKzFVMndabDRFWldlNzgvWEtaVFJ3M1BvQlNqdjM4cXdRMHJlVTh5Tysz?=
 =?utf-8?B?YjJldUZzd1ZnZ0xacnhubnQxbFZnNDN6V2lrdUxiZC9FeFljeVhrVjhXUEdl?=
 =?utf-8?B?a3k1VFRQNnlCdGc0Z0dwUCtqQi9OSTliUi9yamFGcVF6WGdqZTNoOW1lSm45?=
 =?utf-8?B?S3B4SEV4M2FQd1dTVEFOZFdZekIycTJJZjJqUHIrR3VXb2ZKU0JYUzZuTDd5?=
 =?utf-8?B?STJsZkNuSm1kank3UEVxRzVOMDF5Z3RnMkhMWG1BQVhKM3lUQndvMkV0VmIy?=
 =?utf-8?B?dDdXSzMyenMrdlQ0NDBkZVpGdDdqU2ppcSt0V3N0Q0NUQjlzUUtRbTh6OXE0?=
 =?utf-8?B?cDUxVjY3c2tvMWE0YWZWWDhINk9wT3k5MkE4L0swQ0pVQlgxUWM0TnlxWGJx?=
 =?utf-8?B?Wlg3Y2pMQmthMWhXL2RuUWNFYzlOWGZkb0F5S09SYUkrRnNDU3NuR0NPSzRk?=
 =?utf-8?B?b0cydEhVR1B5enRaRzF0TEEyVklWeVNFbENENUZVVm80NDU2OUI0bElib290?=
 =?utf-8?B?SHg2VDFIa2VvenpCY1NMeUVLbW9naEJqcEw5TkNhSUJMUGJ3aW9BU3hrL3Jl?=
 =?utf-8?B?N1Q2NW04dm44Z05wNDNCVHNHelZWU1Ywd09peWdqTmJCZFQwS1I1NTY1VStI?=
 =?utf-8?B?ZXZzWms2Vm8xQWpwdVFYanBrcHVzaWxSVzJsR1ZxMko5UnRBNXl1TDhvMGFP?=
 =?utf-8?B?QXBWN1pvSzdGZk1EblE5SEZuWnZBY1FtZ1JaUkl6VEdZNU5VSEF1SXo5eFdm?=
 =?utf-8?B?Vm41M0FqRDRCbUlXYmhWUjJUeXd5dU1SdjdnT1VsbnVZUUdDdFFDNFlMaTBI?=
 =?utf-8?B?cWFmempaK3BiRGN1VDRkbGY4ZVRhWUF4d2M4emJEUGRNdE5qWW8xa295c0Yy?=
 =?utf-8?B?ZHE4b1lPQkh3ZkxuV0tPc3BBQmMxam85V3BLTHR3YnFjSjNkdUgrTXRGYnY3?=
 =?utf-8?B?b292eFdaTkd6L1IzQzc4VE5RcUxRWjRpWTc3S3YzTWcvL2Z1US83YVEvSEdK?=
 =?utf-8?B?cjdRUU4rVGljR1Uxb3ZaMDNwZThQZXI3NUF4Um5KczZ3WFZhQ3NaU2IrYiti?=
 =?utf-8?B?SFJIYWhlNjlwN0pOM1dFNkRpelZ1VGIzUHR6ZVBTZW1lN0VDVzNGWFhJUVRI?=
 =?utf-8?B?TDhhNUVsbUdLNk9ZTGt3MmRvTVJhbCs0MldjVEpxd01McVI5bm84L2dTZDNC?=
 =?utf-8?B?OEZxODZLY0RRSXdRMSszQmVZTjVYQVRQR2pMbmFObFIveWV6VUd5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1765e600-a438-4588-623e-08df41cc3214
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:22:18.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxYx8HD5CKYHMY+4XOo5K2rqKsDCqvJp9ZHulbXlY6cJqDROgKdz/yC8VFAFiF2+sLUKKKGDGZWhNJIsrzn5ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859



On 11/13/2026 10:56 AM, Sebastian Andrzej Siewior wrote:
> On 2026-11-11 16:38:20 [-0500], Joel Fernandes wrote:
>> The CPU-hungry-reader boost test depends on RT throttling to bound the
>> CPU time an unboosted reader can obtain, so there is no longer any
>> reason to disable it.  Remove the code that does so, along with the
>> now-unneeded sched/sysctl.h include.
> 
> Can I talk you into replacing this with
>   20261113-sched_dl-v3-3-a76ffa1cdeee@linutronix.de ?
> 
> It removes an additional declaration in RCU's header file plus (the more
> important part) it explains that it is not doing anything rather than
> saying it is no longer needed due to the rework.

Sure, I will take yours instead and include it in my series.

thanks,

Joel Fernandes
