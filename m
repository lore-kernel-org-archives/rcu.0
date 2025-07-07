Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35828A1D6;
	Mon,  7 Jul 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899883; cv=fail; b=nVUxMzHgs2cSMgcsqAxZkRsG03j1MFHL/Mv3cP1Wm5C4dVeg7KQehggZbSwvI9IR/PT4oPpV3WvOc/Ev+IDdA5eKMyfaDiVWlxR+DvWGXVzTs/AN+WCaJ31wZX3uHLs8gmBIlwi3LkOtNS+6AatO28oEr6T8ba2dTfFXcjnU060=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899883; c=relaxed/simple;
	bh=bY1ueSUSkVZvgAUs1wf79i7KRAnZCN/1swLLFbZ9qCo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KZIAjTSTRdI4UV9Jyt5fBJt6iKyxw+V//IV7It8In+MQ/URzPXitzfuH331QWEfyblk8oOBct4pmaXqT/CW3iQQYDUSZYnmABjo1IUAENJ5/LAPYml9mBCR/RCxoN+0d+3/2JW9lXwmqHaDMT3xx2Wz+Wzas5QFBqVMNRjm0qmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FIL0OLJs; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FIL0OLJs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJuA73a5z64tK7J85g6dMrBWRYwjDV6PSmqn9ITCYNQzTYzQi1syocoCHS8MVM9ldiIrWaz4iC1d/zwGXHNcct6OOdMQe1X61BDMtQ2SpPwYWi0NZx5bYmpx2nQOggSBUDHiozN8acl5SOvrak1gUzuljo1j9cV0KLpQuCMUvipa9pSyQL9JdSrGmRhoRRaZ49SZoGVgP6bnctRRbb68dtt5+rhGpCTQqMRTMIyfQRLL14Z9d7FYujmCL/GC9eTdyRfa70DOqb9Qy94iWiQyEVb/L4QA3ssG7C88C0UrY+lZLsX2XQBUMCYQbsfUERdYhnlhVfGzf13/qQwL9HsSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fZB8x5o3drHAvNurRnCAl+G3D/N21eVhnvR6jqUWfw=;
 b=zAjKVOpFgMAcWQaMBCBDpypzdazP3SjiayRoTjk8XcxnuqXRIwEnTMUoY3N8VqiMSuwfcyWjAk8615J+F2G6zouBcbX8lEoZ/jVLtDNT+mhtqu2S5DtKp3NS7LQQTkZwQJfwc5OYXTkyM4O14F+JJyU9+0sT/nrfAlXmOMJj2g39eG1LIELKwpO6HnloJhz1pja30otJztz4YmLHe52gI4dWKg9MUVQomhJl2o2rLNzzwybI40uRvGe+2lOXFHm1sarAKDOB6RWEZn0rFWrPkM3hif15c6MEZeUzre+7u0MarzTaKo/lGBq8VKRjJx+mVLsWtu+iUCiPMV3ry/4kNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fZB8x5o3drHAvNurRnCAl+G3D/N21eVhnvR6jqUWfw=;
 b=FIL0OLJsZjSPlpndRINF7gDx9JFh14wtF2WpeGCJj0/LX2c52EvpT73iG+vvTYi8rQBGmVtPyb6LC1RQMVqQaeKM/Qly9n9pla/N/LozSASMAXs9nZLK8Hf8bPq33/NgXcncBJrK2nr9izcNBFkFDZ2kHKptt4iYUOlzoauemrogFIOaPhzY/a9U0oCCXQjCLnEfG1B48zRK0NkWKcLEHYPQh0YwvSjC6WyX0WU8g5kjSkxWDUcfpOiTyzkHuQxKXOfsAI55exbV1zebgE1qryFDtqCc8y/hkHwPJdfhP0n5s8MYDLGK64u2+rMikmeAjduG2MUyUaBLZXtXzdnOcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 14:51:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 14:51:18 +0000
Message-ID: <157988f1-ae30-4549-b5ec-f6534210e692@nvidia.com>
Date: Mon, 7 Jul 2025 10:51:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
To: paulmck@kernel.org, qiang.zhang@linux.dev
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
 <527a257218a02fe85571746d339a4c24f5564d68@linux.dev>
 <fcca6aa2-e4db-455c-be32-e80050c44c8d@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <fcca6aa2-e4db-455c-be32-e80050c44c8d@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::13) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 470e61af-4cf0-4596-37d0-08ddbd65ba7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFRvSHY1ZnE2dEthMm1hL1UvTkxiQzFMbTI4K0Nkdkp2VGNJYkVDVjAyTFZH?=
 =?utf-8?B?VFg0Qm1zdGZkOW1XRTNCci92SWpMeEtUYWhPUjhOVjhhSTZvL0dYNDh1Z0xV?=
 =?utf-8?B?VEFxTkRaaWI3TVdReDRVVVp4amhNYklPZ1pRbzFBWVJBbG1tYWpWWDFaMlNj?=
 =?utf-8?B?eXlKNUwvU29aWnVjQlh4UEhKT0w3ZW5VWXpKVXBOT3lLY0tqbktQRHRFbmRm?=
 =?utf-8?B?b2x0MzBSR3pBT1o0a1B3T0hNSmZHNVZNQWFVWGFzNkFLaWZKVHVCSm1PTnNN?=
 =?utf-8?B?aHd4STVBZWtET2dxK3NOUXdVMGV4bDViS1B4YWxZVUx5QXZuV1FaQkxDTlBC?=
 =?utf-8?B?anFHVy90RjhIZkhkZlFPMFFBWTNSQmpZd3U1M3VRQWtrbURuR0xRSUQ4MDlC?=
 =?utf-8?B?WmNMZTVscE9RNm4zd3Y4dGhwN0J4Z213Ulc1WFR1ckVGcUdsdG5XSGM0SU9v?=
 =?utf-8?B?SFFMZ256STliSHN1WU5LYW1lejR2SFAyYTBDTGNXZGJwYkhqRkpsbzFIOXRH?=
 =?utf-8?B?ZHRMMGZyK3k2endIN1ZZL3FJMzNGeDArYWt1Q1NzMzRMMTdRbG5pZHB6VC9I?=
 =?utf-8?B?bHBaam1wcGE2MzNoNTR0N08ybGZOWkFJdU5saWdpeUdLcE95WVVHUUFnUjRm?=
 =?utf-8?B?VUo4NkpOWWdqajNXK3hybUVPNnZkQmhmcjRET0lET2JwanRqYzMyMTZpTmpl?=
 =?utf-8?B?UWRLNGtHSUxxK0pLOEtudHI1L3VMRlVVbmd1cVU5eG96QkVtamp5QmdDbHNs?=
 =?utf-8?B?bEsrV3VWZU5MSE9mdTU3dEJ6clMwdHdiMGVSbFR6V0FXQUh0bDlhT3IwNmVE?=
 =?utf-8?B?am5wZGd1QmM4TXlzSHJGcW41ckRTbjEyVUZTNlBOTmdjeEkyZ2hLOTFwaFpj?=
 =?utf-8?B?Y3IxaWo4b292Z05WUlYzNUl1d0ltOC9nVHBFZmF4Y2ZWYldVWU9YeVBOUXc0?=
 =?utf-8?B?dWFLcmM5MWlUejZSaGxzSllZeGtGTVg3YVF0QWJ1Y1RwRWx2QkhmUWdBVFU1?=
 =?utf-8?B?aVEyVFFGOGxYdkpiU1BLbnJqeWtsVTlsNkpOb3lLRi9Pcld6NnpWSjl0TnlQ?=
 =?utf-8?B?YjVyUXRxZnFrTUNod3F0OG5yZURTemRLZkJPcTJJNXFlZFQ3c0NZeFVna1gx?=
 =?utf-8?B?K0srYU1waFo0RVJZajFZUlZPUGV0K3E3aHpxUm4ycE1ST1hBRWlFM0drUHhT?=
 =?utf-8?B?UHpJRVRTTmFVSmZtcUcxaVQyQWRWTElSYWFXNXRIK0VCeHllZGUrTmRiSWJR?=
 =?utf-8?B?a05abDVhU2RpMzg0LzI3RDRSWnlOVGpqTFN0MnFLVkxkWHVFQWg3Q2tvdVN6?=
 =?utf-8?B?YzJIWkxzWWgwWjlPZzdYaHJLUVR1SGJWcVRtczJZdFlGZTErdUswS0FTcmhZ?=
 =?utf-8?B?a2RCY0tFeVdSS2kwRUV0OFlCelAreHltU1cxcWI0UTA5TzhNZWZaWEdlV2NE?=
 =?utf-8?B?SjZlZmNNUzhaV0FIbmlxQ1F2anFaMDF2cDB1cjJGb1A5Y0dLQXRWRHpLbVho?=
 =?utf-8?B?SGpscjcrSmVyb0JPQ0N2eVlZdjczVUswZ0d4Nk1qWEk2OUlWVVpwNTRrcHk3?=
 =?utf-8?B?dDZ3RkJ5WmxiSFY4UGQ1NHI5ZjNiNFI2Q1FLSmdYOE9BdzQydVV6bnlzYjVV?=
 =?utf-8?B?cXV5RmhESDlUNEZsSENuc2p0NGpZZ3RUVzZ0ZHlVcko1QXVNdXdpclNvNnlF?=
 =?utf-8?B?MGZRMTQwMXFJVXVSb2xPVWZhZEowT1hTTFBoeWhNSzVsTmk3SkxNSFphTHpC?=
 =?utf-8?B?NyszeVNCZVBDWHk4L25lb1Q3a0FQWFc5NS9DYmdsUFBoeXRncDNydkM2bktO?=
 =?utf-8?B?ZnUraWNhVE4wMHVhTXEvejVwazhVTGIwdURmck1BeFkrMG00Slh4NGxLOG9N?=
 =?utf-8?B?ZVp3Wk55Zk84cjQzY0pzdXRNWUhoNCtxMkJRTGcxV3NTYk5SQzc4T3ZDc1Z0?=
 =?utf-8?Q?fk6kbG0kCEU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlZJLzFvUGNCdS9JdlZYbno2QS8xVDZRSnhmM1FGQmJUY1JvdUQrUVo4cStq?=
 =?utf-8?B?SFArZHRvNlZkeHo5VStEYUhsZ2t6NFdGcVlKOGtDck9PNCtNS1dlSTRCdDN6?=
 =?utf-8?B?elBCWHZWbFBFejBCK0ttVWxoU3cycVJWbWlQYVc1aFlWWElnNWVPWGlpWEpv?=
 =?utf-8?B?OHgxWldLU3JpMHJDcDFHZHVvclMwcGpNMEpneW1XZXg1dms4K0pmRy95Z1dK?=
 =?utf-8?B?d3RkL0VaeVJsSEwydXlSWnVTT0NQT3NYOWhWakxOTXVLTDN6bmc3N2ZFbTln?=
 =?utf-8?B?Tjg3NjZMczNJZ0E4RXJ4WTNUZVBUOFZUVmhsYkMva2RMemNXaENiSG8wZlNH?=
 =?utf-8?B?TXJrWjRzVUhBYXZ1TXgvSWtqRGlYWlpEK0N6ZE4vZEw1aGZjdTJ4WmZZOFFJ?=
 =?utf-8?B?QmoyeXZGeTd4bzBpR0V0ajRzNldKN3dET0FQM2RNSVJzSXV3aStISjVSNlVz?=
 =?utf-8?B?aDJYczhKaEhiY1I3RW5uUVFJNlFUKzVOMWdLVHJqWjc0TWV5Z1RtNGlRVDJM?=
 =?utf-8?B?d0NWdGNzaThsR0lVWFNDUVR2L3F0ckgydlBWcTRTSkJzUWwvZGY0cnlZcnBv?=
 =?utf-8?B?SjR2blZIZEdVSWpUUmtuQ2VhV250c0ZVazlxVVkxaE96RUZJYnJPWVRKcndI?=
 =?utf-8?B?anQrVVM5RG9nZHlUVmpsNHIrdS9EV1lPUkcwZW1uT1Vib1ViVVdGUlB4aWdr?=
 =?utf-8?B?Sm9ua1VScEhCNkFEL201cUVJRWlnd0JlTUdseE10YXlSS2l0Y21sWHVBYmdE?=
 =?utf-8?B?VGd4MzlwL0hrUWpPR1hCM2dCZEI3Uk5IV29qeGorVjZrNllJeE10ZTFKQkZq?=
 =?utf-8?B?TDVBSjdkcTM4YTNVMmdNQUw0ekpEOEhNeS9WVlFGajlKWHhoZlowZUlnb1JT?=
 =?utf-8?B?U3J5M3pQYUZMOENVQkEyMm9RUk4rQTNVcWFualczajlRdWdaOUpyQVBxSHdF?=
 =?utf-8?B?ZE1KNm9hWDhqSzhncjJLWTQ5SDhJUUVYdjhRbGx6TmRNQldzRGxwc0xhZ2FS?=
 =?utf-8?B?TnBLYzgxa1Z5dXc5TFFhN01VZXFZVlJoeGRVTlhUanVYYlNweVordHJ6NFRO?=
 =?utf-8?B?aVAyY2s5UjBYam9XbXhJbzl6bFhjaGZSaTBsM2lHcEVzVmlyc2ZVR2Y1TFMw?=
 =?utf-8?B?eHhwVlNma2syUW1KVVRMMjcyUktqOTdTenZWaTFnRERJaW1ZdHU5elh3Ym92?=
 =?utf-8?B?Z2JDUS8zUHZLK3ZUbHQvZm9FUGVwQ3g3R2EzMUJ5SlBpRkMrQzZxVURvT3Rk?=
 =?utf-8?B?RStRcUFzaDBmVW5rTDVpQURFTzIzd0JOZ0s0WCtuZnRQUEhEeWthTW5jYWNu?=
 =?utf-8?B?N2l1eGx4b3ZjV0p5Mkc3QldGd1p6TVMwc211L254MTNYYXFEdDQ0d25KelhD?=
 =?utf-8?B?Z3gwTmlsOHJlVzh3UmhTY1k3ZVBrNWdxeGV1Q1cydVR0dXZNa200ZnUzeGpL?=
 =?utf-8?B?dmE4Uk50c2x0WUYxWXoxcFhGZ2UvRFIwYW9MZFRkMDBPbENYTHhHNUtYYU1n?=
 =?utf-8?B?YlFNQmY5TkVTalYvMFExbEtCS3BPVVdPUWFKL0E5NTI0ZHUwNXora2JNR3Aw?=
 =?utf-8?B?UFJvMG9UTlVsckdSWURXVmdLeUNHRDdvYjFGeVdjRXcvVkl0aHIzcThwS1Vu?=
 =?utf-8?B?VmRhd253bjVLQzIxZUwxRUM1ZDJBelNGMG16MFZRRmx5eUJjd09Dd2lRbU1m?=
 =?utf-8?B?TnNKWVV1c0lUMlc3bmg2cDJnT1JTMlBhTmxTYjFmU080T3lNQ3hzenFnYkdS?=
 =?utf-8?B?b1hKZVhKbDFxdXVsb2IzSWswTHJhVDdUNlJEUU1vS25kTkhkZ2czdlBUMldE?=
 =?utf-8?B?TjdveFppZlYzaGl5amhDS3pmcWxZYVAvdWdWZ1Z0c2VBTElqcnlGSVRsMk9L?=
 =?utf-8?B?QWZnRTNFcStObm9jMytGU29qL1dSWVBNM1AvN0dMbEo5eWR6WlpORnJwaDR5?=
 =?utf-8?B?cWllRnA3bFMzRVBXVGkyNUlHOUVHVWxPaTFCNkM0RXU0S2dBUFpTenc3SEt5?=
 =?utf-8?B?dnM1Q3F2cUU5dkRIemQ1VW0wT2Nsd1J4QXN6cTFlK3g3SkdhVThlbUVoeDM2?=
 =?utf-8?B?MXE3NTZqRXQrS3hScyszR0JTaHlJcnhURmZESlFXWVJQSHNURzczaXlndXJK?=
 =?utf-8?B?Z3VtSW0yRENwanBlTTZGMzRIT2tOdC9LU0cyUTV5aThSTUVrMzRtZFVEL3Ni?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470e61af-4cf0-4596-37d0-08ddbd65ba7b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:51:17.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdSP1sSi86Twfjvv7ZBet/+VxtEiHLCwIArCGjfzx7WVCoPsoi7SrU+JLWW4L3fVOAd9oY0Mx2QpfqRyOyE8dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829



On 7/7/2025 10:04 AM, Paul E. McKenney wrote:
> On Mon, Jul 07, 2025 at 01:26:56PM +0000, qiang.zhang@linux.dev wrote:
>>>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>
>>> ---
>>>
>>>  kernel/rcu/tree.h | 11 ++++++++++-
>>>
>>>  kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
>>>
>>>  2 files changed, 32 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>>>
>>> index 3830c19cf2f6..f8f612269e6e 100644
>>>
>>> --- a/kernel/rcu/tree.h
>>>
>>> +++ b/kernel/rcu/tree.h
>>>
>>> @@ -174,6 +174,15 @@ struct rcu_snap_record {
>>>
>>>  unsigned long jiffies; /* Track jiffies value */
>>>
>>>  };
>>>
>>>  
>>>
>>> +/*
>>>
>>> + * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
>>>
>>> + * It can be in one of the following states:
>>>
>>> + * - DEFER_QS_IDLE: An IRQ work was never scheduled.
>>>
>>> + * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
>>>
>>> + */
>>>
>>> +#define DEFER_QS_IDLE 0
>>>
>>> +#define DEFER_QS_PENDING 1
>>>
>>> +
>>>
>>>  /* Per-CPU data for read-copy update. */
>>>
>>>  struct rcu_data {
>>>
>>>  /* 1) quiescent-state and grace-period handling : */
>>>
>>> @@ -192,7 +201,7 @@ struct rcu_data {
>>>
>>>  /* during and after the last grace */
>>>
>>>  /* period it is aware of. */
>>>
>>>  struct irq_work defer_qs_iw; /* Obtain later scheduler attention. */
>>>
>>> - bool defer_qs_iw_pending; /* Scheduler attention pending? */
>>>
>>> + int defer_qs_iw_pending; /* Scheduler attention pending? */
>>>
>>>  struct work_struct strict_work; /* Schedule readers for strict GPs. */
>>>
>>>  
>>>
>>>  /* 2) batch handling */
>>>
>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>
>>> index dd1c156c1759..baf57745b42f 100644
>>>
>>> --- a/kernel/rcu/tree_plugin.h
>>>
>>> +++ b/kernel/rcu/tree_plugin.h
>>>
>>> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>>>
>>>  struct rcu_node *rnp;
>>>
>>>  union rcu_special special;
>>>
>>>  
>>>
>>> + rdp = this_cpu_ptr(&rcu_data);
>>>
>>> + if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
>>>
>>> + rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
>>>
>>> +
>>>
>>>  /*
>>>
>>>  * If RCU core is waiting for this CPU to exit its critical section,
>>>
>>>  * report the fact that it has exited. Because irqs are disabled,
>>>
>>>  * t->rcu_read_unlock_special cannot change.
>>>
>>>  */
>>>
>>>  special = t->rcu_read_unlock_special;
>>>
>>> - rdp = this_cpu_ptr(&rcu_data);
>>>
>>>  if (!special.s && !rdp->cpu_no_qs.b.exp) {
>>>
>>>  local_irq_restore(flags);
>>>
>>>  return;
>>>
>>> @@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>>>
>>>  */
>>>
>>>  static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>>
>>>  {
>>>
>>> - unsigned long flags;
>>>
>>> - struct rcu_data *rdp;
>>>
>>> + volatile unsigned long flags;
>>>
>>> + struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>>>
>>>  
>>>
>>> - rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>>>
>>>  local_irq_save(flags);
>>>
>>> - rdp->defer_qs_iw_pending = false;
>>>
>>> +
>>>
>>> + /*
>>>
>>> + * Requeue the IRQ work on next unlock in following situation:
>>>
>>> + * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
>>>
>>> + * 2. CPU enters new rcu_read_lock()
>>>
>>> + * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
>>>
>>> + * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
>>>
>>> + * 5. Deferred QS reporting does not happen.
>>>
>>> + */
>>>
>>> + if (rcu_preempt_depth() > 0) {
>>
>>
>> For Preempt-RT kernels, the rcu_preempt_deferred_qs_handler() be invoked
>> in per-cpu irq_work kthreads, the return value of rcu_preempt_depth()
>> may always be 0, should we use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw?
> 
> It sure does look like we need "||" rather than "&&" here in
> rcu_read_unlock_special():
> 
> 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> 	    IS_ENABLED(CONFIG_PREEMPT_RT))
> 		rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(
> 					rcu_preempt_deferred_qs_handler);
> 	else
> 		init_irq_work(&rdp->defer_qs_iw,
> 			      rcu_preempt_deferred_qs_handler);
> 
Yes, or could we always IRQ_WORK_INIT_HARD()?

For more context, git blame says Z had looked at this before and added
IRQ_WORK_INIT_HARD:

commit f596e2ce1c0f250bb3ecc179f611be37e862635f
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Mon Apr 4 07:59:32 2022 +0800

    rcu: Use IRQ_WORK_INIT_HARD() to avoid rcu_read_unlock() hangs

    When booting kernels built with both CONFIG_RCU_STRICT_GRACE_PERIOD=y
    and CONFIG_PREEMPT_RT=y, the rcu_read_unlock_special() function's
    invocation of irq_work_queue_on() the init_irq_work() causes the
    rcu_preempt_deferred_qs_handler() function to work execute in SCHED_FIFO
    irq_work kthreads.  Because rcu_read_unlock_special() is invoked on each
    rcu_read_unlock() in such kernels, the amount of work just keeps piling
    up, resulting in a boot-time hang.

    This commit therefore avoids this hang by using IRQ_WORK_INIT_HARD()
    instead of init_irq_work(), but only in kernels built with both
    CONFIG_PREEMPT_RT=y and CONFIG_RCU_STRICT_GRACE_PERIOD=y.

    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Btw, once we conclude discussion of how to handle it, if Z could send a patch
based on my rcu/next branch [1], I could apply it to post for further
testing/review.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/next

thanks,

 - Joel

