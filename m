Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C121DE3B7;
	Fri, 19 Dec 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107334; cv=fail; b=FJov7rHx//WDu3ehLa+lfnccL0cN+DqIHGis5AH4d/bXoqwomL2BxzUyW+ACkIYh14WTQTrt2hbY+nJa08gYrciMhnUpS5OKzcYus7hJy9RE7lyLNXM09jf+VQDqSKKvoY5WDVRC/vFw//2P2tnQWBGZr1BOjNzJ6Z3A14o1ht8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107334; c=relaxed/simple;
	bh=rULzLudPYrkGttaDc8e0QOen70wsSiiN4M/Y6Y5e5wA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NctAceTInli82f5Fye3usotWm336kRZBhDdC1/U3sLj9CKRM/rQN2+rErzjATmNkAHQdFfcZB+50DnQ5muMhkvdZbIlI0631nKWchH+9BZjhQAQ2inSpfTQZuNfQnvlGtR1ZEb9IYtj5IUk7B6e3o27UfScnQPd/WWAZ+ykaOcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sZ2nYLry; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sZ2nYLry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBPCd4TKaTOyiY36zfWDVP8ENZLd/KIIDqWLBvsaEWjdYWvBqv3oqd1KKjv/lAWpHo6rHQUVjlNE8KjJ+oD+TG8w1FUVeObdhRvF9kRiwfpQEHX12lXJccUtR5Tc3NhGgMKPbrIoN5zaHoU6RApbBCS9nawYu1pdII7Ty+LCxTy3o2Fb3SNadYbJZdKbbCnVZJ9hfFyoXPVKoUE7OQph8cKa7QyVTs15lrkFxyAU1V97LTLHw+TiqJ3BdHpuTBzOxModfAJBohJyZdNSNoPNIvOIkP8Rh/JZY28SBsZIdPV89bHAQDPii7q+zv7cqOHMF3XrxZKPMXku0Vk7v4YXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dct/EvUQPPx31Df+Pv+35vuARECsJYIvpaim9JfYX38=;
 b=yI/mOgRCWWV7j3hUpex5mR2SvsKBytKZmmx8P0vVWrXx9y61/FfzypR5pi1BA8fbLoqjD/+ayzmWqQLH4vxMqcAjoLwdVZVaEIF0+3hciRN02rO95WsYHQqM24hyTBynHvk5bXHHMSOwicgO/ZS4CX8WYGGAL0Ifj0oW97x8RkDYhxZna8MeMZwJaT6ebEOFd/xDsqEZP/uMT8ZEi1XZcvxiIzpqzgNexzBy8VPG6UOawUfwQB7V/rJ5DJaN8giZFMie8l5+g+0xSr8D6HPvkSm5AR1tCdnyTNVtcqnpu1ok0QrpNPbuYb9+rFZh7y64EDQopYJH8j4GjWYsXl9gzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dct/EvUQPPx31Df+Pv+35vuARECsJYIvpaim9JfYX38=;
 b=sZ2nYLryNseEsRwiYTJa2xOHkaSidlsuq00RuY+ih17pBqRMzBCN9RdV1uuJCjoBJLszB0U8W4N+b48F6COUcYkk4wCMAFzITrYBZRyOIGM0U7r1/TuAxPhTcTmod17QdxO03LEvlzyPlEn/Ry1PLGiu3qgZ9Isci0fLjSk9tYwlF7R/q24Yo5yIio9AnYvcfMhmusbC9bpEKKF1vgjYK2MDjIZtnGdxYKYWGBicM2i9ve28mPYz5+D9C0MPEKsFdCN/tuoHgUNauVkjStoO423W0YSG2/tgKCRRSL8wJ3x2V2vwnCoMFMgaP1/v33cEpsn37pNkhEunkWXAr51O6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 01:22:07 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 01:22:07 +0000
Message-ID: <6cbba525-3bcd-4673-a6a5-1fe16330868f@nvidia.com>
Date: Thu, 18 Dec 2025 20:22:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
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
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::6) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 9912051b-ebe4-4074-66d0-08de3e9d069a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2U0NElnd0Q1YWNqaTFhUTM3by9oNlorcnltMDlNeXRmaEFtdmtZMzdMcG8y?=
 =?utf-8?B?R0crYVJUMi9jNXFtbUlGcFhNY1NROVUyWjRBYmViSHFxMGJjbVlSa256cWla?=
 =?utf-8?B?VHpGWHl3aHBFWE8xdGNLZXdFOWNJSFBFbUdUT01yeTI1WE1kY1N4S0V3MGpw?=
 =?utf-8?B?NVAxQWt1RUVrUStLKytDcmJEK3J6dXFkNWMwbVpZWnZGYkltS1hkRUUySitD?=
 =?utf-8?B?NlFrZnBxMjRqSUtldVhVTmw3bUFxbWhOYXY0YzBUQ3pWSzJWR1JNTThTVGJX?=
 =?utf-8?B?NnB6VDFma29ncWFiZDduOHA3NHVCdXFyK2lUcS9LQ1VVL1FmZ1ZHcTg4SWZ0?=
 =?utf-8?B?b01Md3F0Qmc4Sjl6aXp0RWpsMlZwSm16dEdBZ2UvcUp0VEhiekJyVy9hTk1x?=
 =?utf-8?B?T0NkbkFSTElNWG9DWE1yT01JY1U0Q00ralBUSlc5aHVqL0xLM3B5cTRMN3cx?=
 =?utf-8?B?UVBITDNPbnowNEswZjlyTlNMdjlqbnlXTU1Mc0thUjJzeE1RZGpTaHd3Zi9w?=
 =?utf-8?B?SWVZYXh3aWgyUUhlRXRuUkpWNzY0SUVzQi9BWmROV0ZjQ2dtdjZaaEluSjdo?=
 =?utf-8?B?TkJCRVpFeHhSb0JQQkRlNmI1Q3puNm5uc2ZnNTFOSlhGUXhLUnIrMzdyZGMw?=
 =?utf-8?B?ZzU3YlJxZEFvcmc5ZmNDZGY1NklrRy96WFUxQW5UMFNlay9pVENhRFpRU3pv?=
 =?utf-8?B?cHoyYlRIa25rTktqT1BtYkFGOExGR1J3VE51RkdJMlJYb2dwYXFldE9TaDB0?=
 =?utf-8?B?TklXTkY1eCtDS0dvU2l6L0liVHJBVGtTTy90SHZ3b25zQyt6bVlmeXRBdDl2?=
 =?utf-8?B?bkRPWm13ejdBVXZkYmNQRkpkNXFBSjNYRGpJV2RNUHpyMUxPVG9qcU9hdllG?=
 =?utf-8?B?Kzd3UmRZdHFxV2xSQ0xOS3NEVS96SVNZTDhBelRSL1d5M0F2aisxaXhQd2Nw?=
 =?utf-8?B?azlFaTQ4bExGRGlGa0FlSFZJUlA1UG5EU3JCYUxydzVWTTd0c2dteVc2RENj?=
 =?utf-8?B?QjRucVkzZm5XcU96ZWFkMklDeGJ5a2VYbUN0dmpMcWJQL2x2ZGlQNWJya1N4?=
 =?utf-8?B?U3BPTzIrMlBFa0RVcHpJdDlvY0dPWm1zQnYvMTd3dkJWcVBmY3dud1VYSkFR?=
 =?utf-8?B?NkxoZzl0VzFYaXFSb09lc3NHZTlmTjZxbjJJWTNSN0lpcExYNUd0RmdZTVNV?=
 =?utf-8?B?SVVGK1dPME02Q2ZrMlc5Z1VqZTMxQ3lvTUlNaFNuRlViUzJqb2U3RHovQzFF?=
 =?utf-8?B?UW93Y0J6K1V3MnlGUVdSSmwwZGtqdlBDdFUrM3ZOVHVBOXdaTTAySGdQaXJB?=
 =?utf-8?B?dXZ1WERYdXc3a0M2YzlramhqVm5OWVBuQ3c4RS9zQnByN2xtQlVvTUNSWUtB?=
 =?utf-8?B?NnFkWWxnR1JWMFo2WkJYeUdEZXpuS3J6RTA4YWpHYWJyQmhzdUVGTVlTVldF?=
 =?utf-8?B?WEJMb2VPNE9CODJLcjZnakkrOTJnKzdWTURZUGtRUzZ0SXVqcHVsY0Fyam96?=
 =?utf-8?B?S2JTcTM5MFRpMnZCaUVjSXpaSTcrd0ZQWWJZRWVTOHdHd2I2cDBmb2sxVWVp?=
 =?utf-8?B?MHpjL0JoeHUwQUFvZUxCWEtaSFpNOGwxSFpDTVZEeENHK2l5U2p2TTJ6VEFv?=
 =?utf-8?B?ZUhqU3dndEZFTVBmNGwwYzJXcExmTTNIeEliaGFDY1NSWUY5R2xiaEFZQ3k1?=
 =?utf-8?B?TDVEUFdxeW5tUjBZN3lxMlpDWVlZdk5qVmVKUmFqN2FvNCtBaUxZakxHK2Qv?=
 =?utf-8?B?ekgzOW1hZ1BObncyWjJBSVZaQzVjVHVtM3lPYXdyNWd6TjhaemltcWE0UGgz?=
 =?utf-8?B?RU9kWkJtazdSY2FJeXpKdnVOSXNYNmdnZmZ6ZUhldmY5ZEVZQzQxeXdCT2U4?=
 =?utf-8?B?T0pyc01tRllSTjgwVTM3eEdEYzhad2xSU2tycWlFTi91WlBIWDdrajZCMlkx?=
 =?utf-8?Q?V3omLGTD8PEsBc69X6TFAy/c6JGi9jIn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXlMakxPODlMMjdMbmlLWlJRY3dqRExMQS9GRDEwblRPeE9vaXV5aDBWcGRE?=
 =?utf-8?B?UnBNRHNHOFV3aFlHRjgxV0VyWXdWSWNaR0JDazlZMTFuOERPWW45WGRJVE9V?=
 =?utf-8?B?d1pJN084OG9PWExRMjkwSUlBcUdCRllIcVk0ckpjb2h4S2NQVTBtOS9sRjNM?=
 =?utf-8?B?d0FhZ1k1SWtacXZpR0Z0WEJ1Wm1mS3RHZ3NaRU1pWTgrTVNRb3o5N2lNZEx1?=
 =?utf-8?B?dXNNNnBUTFNEbzUzUVJVeTJZWHFkcXMvaWJZY29KQmg3ZUJpQ3owYmR3aFFp?=
 =?utf-8?B?a0hOdkVOelZUMEV1OXpXb2VrY3NDTUFOQVJZdmt1Qy9pMmhyaHdSNDQzY1hT?=
 =?utf-8?B?S3g1THhBUVlBSFFmVHlDNmFGVkppWFFkRE9UbUNFSkN4OHJRRW1lcEJiUm5j?=
 =?utf-8?B?aGZveGpWUlhqc2duYU41NXN5RndScEw3V3lVcHpzazNOMyt4R1lNUFFlUk5k?=
 =?utf-8?B?NXJIYXdxNEpPUGF0eUtlNlppcE9XRWQ1Umo0SVI2ZXNBRWNQVCtaSG9qZTNP?=
 =?utf-8?B?ck1FYU1SNVYrcHFQVzlsTVREOC9ESHlqVFlMVG9GZjNPWndnclR3MTJjNUJ6?=
 =?utf-8?B?UWtPd2NZY1FhV3hQQTE5d3MxenN2R3pGMWl6VVQ0SklmbWNma1VNV0lwd1Jx?=
 =?utf-8?B?N2lnQ2tTbWFmcDdkWHRuM2N5NEdEV1F6dVV2bEw2eGZyeEZzcjJXalFTeVg0?=
 =?utf-8?B?SS9lRWtFRjNlRTFNNFNVZjU2djcwcWpKSjNrOGR6QW1oUEloTXRLWUIxVXVN?=
 =?utf-8?B?WWFlcURvZUlGdUpJQXBVQ0lpVHpvVDNhZyt4OU1sNXBxSGlra215U2QwaHFG?=
 =?utf-8?B?NUtxRWxoa0VZaHBrcnNrcDlvcG5la1A1VUhockc2VGdDQTBvUXI5Rjh3ajMr?=
 =?utf-8?B?eVdrSTZhYW5UK085bTdLTjVOekMwTVFkT1g2anJYNmVFSmRENzV2eFRSbEZn?=
 =?utf-8?B?Sm5BOThmc1I3UXZPSlNpRWdPRHJ2a0hUWUV3cm5PcHRKWm96Y0poUVBuS0gv?=
 =?utf-8?B?M2g1UGFHa2VTK2FVUGpvRzl2Z09XeFZFMFBmVUhONEtkREpuUUREMXhVVVR1?=
 =?utf-8?B?K3g3REh1MjRDd202RVIyWEg1a1d5alFZMzJ2UXk1ejQyWUVKS0k2MnFBZElK?=
 =?utf-8?B?VTRXWUp4VmphcEl5RUcwZVpmL3pLTVpTVFlYdVpURU5zS1NtWXVoV2dMeGNO?=
 =?utf-8?B?bkl0WXJKMGlreklzUkl6NzZoZmhTMDZWVW8wSWwreHBOYjNiME9saVRueUZG?=
 =?utf-8?B?Y0RvSlViSnVOSGFiQStGczNvbTlFMHNtbmpYaU10aVpVcGtkcDh3RU9wcldU?=
 =?utf-8?B?VFlSOVExSEx5N0FqZUZ6Y1J4U21DZVZyOHdYVEVzc3ZjbDRWMEFQaTVPcll1?=
 =?utf-8?B?OTc5eEFDL2UwYVk4dTl2TDdpcStpMTB3ZWhKTFQwTVhQb2UwelBNaXB0ek5C?=
 =?utf-8?B?ZGREU1RrelRGQ1FFTzVxZUNRZDdDOHFIVnZYcE56d3dqRmNwWjNRRkNIZVFD?=
 =?utf-8?B?d1V0c1R2M0NBaWI4MWVPdVNMT1pFS004czhrOVUzS0dFUTB6WTk5OEp5U1pD?=
 =?utf-8?B?RDZ0ampUelZodFYvajdRQmM2NExhN004RXZRZTlPSzYxeFg3MFRjbW1PV3Iw?=
 =?utf-8?B?Y3ozeE81TlVXUVFoRmFDRDM1MHRkUDVRdTIycmhGSlBXVFl5ZXZFRWtaUjdl?=
 =?utf-8?B?Y25VL3AyUjlJREw4NmFWNWFVdFlqL3V6T1VFMGo2NkpkUkVyYkVRcmhpS0lY?=
 =?utf-8?B?VlFvdmZyNEtFd3ZoK1FBZStyNHRhRk41YUJFODZ5SjV4WHlVejJhSGM2aEhD?=
 =?utf-8?B?Uy9td3djM3VmbnpxaGFJVytRVUNOQm8yWnYrb3puWVFIaWhPdmV3OHBlemtx?=
 =?utf-8?B?dmlkaTFIRkx3cHdnVysxcDR6S0VoL1RZVjZFVVJYb09JUVZKS29DcExpcUcy?=
 =?utf-8?B?TXdvZ1E1Mi91K3FzcUNCcGdVRmdUYzRnZmJNcGFIcmg5ZHlpcG1sbkJOMHVQ?=
 =?utf-8?B?Vm5pTTM5Y2hKckZGQ25rNHJwdk85eml0WlhnNWxTbVNOdGVwL002VDJKRHJR?=
 =?utf-8?B?WnNYaWRKTGQzYzIxQUVVUFBQNEhGdVY1UnJVRHFMOFppL1BuTmt5VGEwcGdx?=
 =?utf-8?Q?C8lBGpxp6w/f0MPH6XVqelspR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9912051b-ebe4-4074-66d0-08de3e9d069a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 01:22:07.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eg+qWSm+0k0ZpV5JSTySNOmtKBNmvpDBy0nPq+zegi4SsDk7ghsyQe8ncoxbV3QFgnFz5Y5ESjhNTBni4PKwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111

On 12/18/2025 12:54 PM, Mathieu Desnoyers wrote:
[..]
>>> <mathieu.desnoyers@efficios.com> wrote:
[..]
>>> Here is a revisited version of my Hazard Pointers series. Boqun, Joel,
>>> if you guys have time to try it out with your use-cases it would be
>>> great!
>>>
>>> This new version does the following:
>>>
>>> - It has 8 preallocated hazard pointer slots per CPU (one cache line),
>>> - The hazard pointer user allocates a hazard pointer context variable
>>>   (typically on the stack), which contains the pointer to the slot *and*
>>>   a backup slot,
>>> - When all the per-CPU slots are in use, fallback to the backup slot.
>>>   Chain the backup slot into per-CPU lists, each protected by a raw
>>>   spinlock.
>>> - The hazard pointer synchronize does a piecewise iteration on the
>>>   per-CPU overflow slots lists, releasing the raw spinlock between
>>>   each list item. It uses a 64-bit generation counter to check for
>>>   concurrent list changes, and restart the traversal on generation
>>>   counter mismatch.
>>> - There is a new CONFIG_PREEMPT_HAZPTR config option. When enabled,
>>>   the hazard pointer acquire/release adds and then removes the hazard
>>>   pointer context from a per-task linked list. On context switch, the
>>>   scheduler migrates the per-CPU slots used by the task to the backup
>>>   per-context slots, thus making sure the per-CPU slots are not used
>>>   by preempted and blocked tasks.
>>
>> This last point is another reason why I want the slots to be per task instead
>> of per CPU. It becomes very natural because the hazard pointer is always
>> associated with a task only anyway, not with the CPU (at usecase level). By
>> putting the slot in the task struct, we allow these requirements to flow
>> naturally without requiring any locking or list management.. Did I miss
>> something about the use cases?
>
> I start from the hypothesis that scanning all tasks at synchronize
> is likely too slow for a general purpose synchronization algo.
>
> This is why we have RCU (general purpose) tracking hierarchical per-cpu
> state, and specialized RCU flavors (for tracing and other use-cases)
> using iteration on all tasks.
>

I wouldn't call HP as "general" personally, it could be (should be?) usecase
specific. That's why I am not opposed to the per-cpu approach, but I am not
convinced that there is no room for a per-task slot approach which is simpler
in many respects in the code.

If usecase has 1000s of CPUs but few tasks running, then per-task would be way
faster. It would be even cheaper than per-cpu slots on the read-side:
1. Unlikely to overflow relatively speaking, since plenty of slots distributed
to tasks, thus avoiding locking.
2. Preemption also doesn't require saving/restoring and locking.

I would look at per-task HP as a more specific HP implementation if you will and
per-cpu as more leaning towards "general". There's tradeoffs of course.

> One of the highlights of hazard pointers over RCU is its ability to
> know about quiescence of a pointer without waiting for a whole grace
> period. Therefore I went down the route of scanning per-CPU state rather
> than per-task.

Sure, but there could be room for both flavors, no?

>> I did some measurements about the task-scanning issue, and it is fast in my
>> testing (~1ms/10000 tasks). Any input from you or anyone on what the typical
>> task count distribution is that we are addressing? I also made a rough
>> prototype, and it appears to be simpler with fewer lines of code because I do
>> not need to handle preemption. It just happens naturally.
>
> It really depends on the access pattern here. If you want to replace
> refcount decrement and test with hazard pointer synchronize, a delay of
> 1ms on each hazptr synchronize is a *lot*.

Yeah true but I don't think *that* is a fair comparison. The slow path is always
going to be slower than an atomic refcount no matter which HP approach we talk.

I think percpu_ref_kill is a better comparison which triggers a GP:

  percpu_ref_kill()
    - percpu_ref_kill_and_confirm()
       ...
       - call_rcu_hurry(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu)

> Of course perhaps this can be batched with a worker thread, but then
> you are back to using more memory due to delayed reclaim, and thus
> closer to RCU.

If you have millions of objects with per-cpu ref count, that can go into the
megabytes. With HP, you can negate that. So even with batched worker thread,
there can be space savings and fast read-side (at the expense of slightly more
overhead on write side). Sure lockdep usecase does not benefit since Boqun wants
to speed up the write side in that case (synchronize_rcu_expedited) but we
probably don't want to discount other potential HP usecases which want faster
simpler read side while having preemptability, small structures etc and don't
care about update side performance..

>> First of all, we can have a per-task counter that tracks how many hazard
>> pointers are active. If this is zero, then we can simply skip the taskinstead
>> of wasting cycles scanning all the task slot.
>> Further, we can have a retire list that reuses a single scan to scan all the
>> objects in the retire list, thus reusing the scan cost. This can also assist
>> in asynchronously implementing object retiring via a dedicated thread perhaps
>> with the tasks RCU infrastructure. We can also make this per-task counter a
>> bitmap to speed up scanning potentially.
>>
>> I am okay with the concept of an overflow list, but if we keep the overflow
>> list at the per-task level instead of the per-CPU level, it is highlyunlikely
>> IMO that such an overflow list will be used unless more than, say, eight
>> hazard pointers per task are active at any given time.
>
> The PREEMPT_HAZPTR scheme achieves this as well, with per-CPU scan
> rather than per-task.

Sure, but with additional complexity and locking that per-task slot does not at
all have.

>
>> So its lock contention would be rarer than, say, having a per-CPU overflow
>> list. I would say that contention would be incredibly rare because typically
>> hazard pointers are used by multiple tasks, each of which will have its own
>> unique set of slots. Whereas in a per-CPU overflow  approach, we have ahigher
>> chance of lock contention, especially when the number of CPUs is low.
>
> Contention on the per-CPU spinlocks would only happen if threads are
> migrated between chaining of their backup slot (either if 8 hazptr
> are in use by the thread, or on context switch), and release. Do
> you expect this type of migration to happen so often as to increase
> contention ?

Is that really true? You have contention also when you exhaust all per-cpu slots
not just on migration:

+			/*
+			 * If all the per-CPU slots are already in use, fallback
+			 * to the backup slot.
+			 */
+			if (unlikely(!slot))
+				slot = hazptr_chain_backup_slot(ctx);

>
>>
>> Other than the task-scanning performance issue, what am I missing?
>
> Task-scan performance is the key issue. Also you have to set a limit
> of per-task slots. How would you handle the scenario where a user
> needs more slots than the limit ?

Sure there is a limit but I wager that this limit is harder to hit than with the
per-cpu case. If you have smaller number of CPUs, you might be hitting this all
the time with per-cpu approach. I'd have a overflow node in task_struct to
handle this. Billions of Linux systems have 8-16 CPUs.

>> Another nice benefit of using per-task hazard pointers is that we can also
>> implement sleeping in hazard pointer sections because we will be scanning for
>> sleeping tasks as well.
>
> The PREEMPT_HAZPTR scheme takes care of this as well. Sleeping with a
> hazptr held will trigger the context switch, and the scheduler will
> simply move the hazard pointer from the per-CPU slot to the backup
> slot. End of story.

Yeah, but the per-task approach does not need that at all. In fact the hazard
pointer context structure is smaller.

>> By contrast, the other approaches I have seen with per-CPU hazard pointers
>> forbid sleeping, since after sleeping a task is no longer associated with its
>> CPU. The other approaches also have a higher likelihood of locking Due to
>> running out of slots.
>
> Except for PREEMPT_HAZPTR. :)

Ah you mean, because you make a copy of the slots into the task. But why not
just keep it in the task to begin with :-D (your points on task scan latency is
valid though..).

>> Of course I am missing a use case, but I suspect we can find a per-CPU ref-
>> count use case that benefits from this. I am researching use cases when I get
>> time. I think my next task is to find a solid use case for this
> before doing further development of a solution..
>
> Let me know what you find, I'm very interested!

Sure :) will do, thanks.

>> By the way, feedback on the scanning patch:
>>
>> Can you consider using a per-CPU counter to track the number of active slots
>> per CPU? That way you can ignore CPU slots for CPUs that are not using hazard
>> pointers. Another idea is to skip idle CPUs as well.
>
> I had this in a userspace prototype: a counter of used per-cpu slots.
> But I finally decided against it because it requires extra instructions
> on the fast path, *and* scanning 8 pointers within a single cache line
> on synchronize is really cheap. So I'd need benchmarks to justify adding
> back the counter.

Interesting, makes sense.

>> Have you also considered any asynchronous use case where maintaining a
>> retired  list would assist in RCU-style deferred reclaim of hazard-pointer
objects?
>
> This would be a logical next step indeed. I'll have to think
> about this some more.
>

You might be able to re-use some of the RCU async processing machinery for that.
Or maybe using timers/workqueues.

Thanks.

