Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692522259A;
	Fri, 19 Dec 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766183949; cv=fail; b=WkT+iWvpL7nTbP2p8GPeMPZU79TDAfFXNwe3fvs08rmRKPeIqDE62BFP+JppL9GRtMOU/RnMLsbk2QQS2upvFOOvZagqZtgc69OzWAXZo0VucJ6NCIO3xi9dB9iMjQsnUUAyw3V0ZYD6xHwLC6qAeupC2CDEeFTcYCRuQf+BvG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766183949; c=relaxed/simple;
	bh=c65hbip/ZAS3YDgppJPN64bh/8ZsMZ90EjjEUuq61+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LaEaXLxvtTerfW5ySOS5ZGWii6BbS/oEx7vvmvKdCepHQ2KHjQ5rc1hBzl9oNxJeJ4FjbZs8sj3ggRtG15BsxCfGtrX3OcIraqD6QOFZ5/iZmBewc5s/DrUPEzl8h3036kKl8L0UmFu5MA1lIp1KAT4gGpqNj3GDA4NQzmvuls8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e2cSsYmr; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e2cSsYmr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaqDre4m6wj8X0cWI0nuQ5dCqWM22AlivVIkyFCGMxkgdo3tfwfNWBc4mV1h1lLbF94CEBT2jGQGl0W+UNizoc0LM9xTixRfc7ELfr1kLhIY020fZvhirY2ysj9Mj5X+Gn2Lhqpvr2sYYjX3Fvsnpzin4OVl3wuJqEsNQwHNgrX1aIcXDny9YAWIlQhRpJ/CE815hGKVE4F7SliPFUQCzRr9mCTjZxcW1u56FS0Lv8TO7frK0B8ZQ7UlpfGVEXD5qhNzutrhbW+8CxWOntoDPF2yNLIfuWYeUu7WclOWzVoPCEURoE/dC3UnU7zsMmL+TJh+MGPQQ+0RU1+P8qF0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pNnZMtqE6o4bWUv0MYuR016PgTMnrQIxxjCWFe163M=;
 b=twl48xkHaZBcclvo6LMIYw9BaiTOCPotJx3I3aKi/sGXQH+Ha75UQpBhUf+yMUZbPVXQzPuuvewRTxq5gbn4Qfmg7HqIayURI+XHMec8KI5yDf03PnLmaT77/8+VUapdWDBTrxS5U/xPVmwPSXkPLX+EbAIDutyEngyLbaWKhJN8lFEkz27klnuRY81JYWP2EjSNZud285ha+MTrDWF2kz7bRE2kTmbpWJK/bWnrxwtNnvFyMzb0GJTKW2/uHpOoyscztRKYy1idCU2CW7Vd3OW8RHLlc9ZokkkMTk8z4zNRCcDCOHs+ipmSSfn6YxaqgPsaNBnYiCQKsea6hCwNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pNnZMtqE6o4bWUv0MYuR016PgTMnrQIxxjCWFe163M=;
 b=e2cSsYmrudZfyySU+voAEXhaUb2TKB18NaHdFeRBKoMt+B36dnc+jR+3bYphzBzGMS/SXipEWVDOU8KzdFmL0STEzCAzk5Ggp1hsf2zNE9TeWcTAlWjr40OMRmjBRza/g532PsxMnnvrMsXJnv0LwLjA2d4g8ttm1S9gmT66r994QlPTjc5ttrBbBzWFGtex2cT5PMjLSOjM7KP4V6tWvEHrGPCUn8/HJ0bGi0VmsuDLq4rru6Hv8orc8T9Tsej6wQcdCZYGK78dT4oBAMkfh1b8bGsp+wVQ/Sy4rGyp77SR6z60uqwPFWdjKqrkRTZHggom6ZqQ07dfLqCjRy+2jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 22:39:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 22:39:03 +0000
Message-ID: <38d05c17-c28e-4ec1-be30-e77fd7015b5a@nvidia.com>
Date: Fri, 19 Dec 2025 17:39:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>
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
 <6b27f3c3-47f7-402f-aa6c-b564e3db1d6a@efficios.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <6b27f3c3-47f7-402f-aa6c-b564e3db1d6a@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1801a9-09e0-4ad6-ee16-08de3f4f6950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUNRdmRJenAyN2dhV3RRUlpOZHM1UFFSQndkRE1ZMVRGN0dqZm1rcHQzRC9X?=
 =?utf-8?B?WEpGUm9nMU54R2hMWk9nMkJXc0hhN2wrVEtVYVpXdTNZTGNpQ1crUzk2M3pE?=
 =?utf-8?B?SFN0YVFGZVNkeFVWUzZ2aDAzNlNiaWFWQjJka0NFSDdXeGdlRWphc2gzQkkx?=
 =?utf-8?B?cEdCRElKZ2lsV21uQkxjenMzOUIzQnBZS1plUkFPZWozRllFU280NkZJTm53?=
 =?utf-8?B?SlE3NW04OCtxK0oyV3lGNEV4YllrUGRXRHZ2TGlGbmJ3ZytPTGhRSDNkMWF2?=
 =?utf-8?B?WHVtZjc3QXNSMFI3b3pxZnJ5MDZmR1F2eDZUNk11U1hYZ055RmdObnp4Kzkr?=
 =?utf-8?B?dERBLzVVc1F0R09SY1RJaGNNaW9YTTVTYmM5Y1ZGZ1loanBTVWI4YjJueDJi?=
 =?utf-8?B?UmZycWFZSnFkOHQ0bGlsSEVqWUJrQlVTdS9HUXplQW5DYXNqeTViYVZWb1lm?=
 =?utf-8?B?RFl5cENhSFkwdlpEZHZzOW9hRVZKRURzaENhWEtQN09INlVoOTZvajV1Tzhx?=
 =?utf-8?B?Qm9LYm1WRVZGYkQ1YlgyNlloQjg0QXZ6a0VzbkllTlFVblludjMycjFOb2dz?=
 =?utf-8?B?VWFhS2R4Vy9oTTdOa0N1WWNWRFcyQXJzNFNKY0JBa2E4YTBzK0dvc0VVS3RZ?=
 =?utf-8?B?YTR0a1ZSUG5na1JRMGt0QmtDMlhCWlJsTjZpeHFUSHBmT3djczFldmdlTkF0?=
 =?utf-8?B?T2lUMHVveFpoRWwyNWJ4VEhwUkpzbEJTYnI3Y2FmMUt2N0Z2TlJNSFVQTENV?=
 =?utf-8?B?eUtaZDlvTmpSQUNLK2g0dHhEWHFPUUFUSmhNSk8xK1ZKK3ZQd2pRZHhnZEVa?=
 =?utf-8?B?VG5UWm9FNW5YSWRzN2UrOHlVRVdvcW1ycTB2aFRJd2V2UndtemtMd1JPeTVS?=
 =?utf-8?B?SjdMbmlHRjliT0NWN0Q2MXNqbVJmZGFnTXBaREp5WldpeEN5cFIrWGlnSzdN?=
 =?utf-8?B?czR3NWxnUjdNbVMrSytVYjg2aTBKcUg2TnVuUXA2a1RUWEs4VDJEb0xuaFlD?=
 =?utf-8?B?c0JJRktCYVU5b3cyVEptaUlGbVRsZmc2cFR6YThpaVo5QmNwcFFtMHNxcmIw?=
 =?utf-8?B?UG5KdmlWSjh4NVl0Mm5BMVJ6eXdmN1oxcEhiNjB3OWd0UGRHdDNUOXN5d2Ns?=
 =?utf-8?B?bGZjTk1NOURhbzYxL2VQZ1k5aERsR3ZTdWhYaExKVWpMbVl5OUI0WlozTjE3?=
 =?utf-8?B?QkJtUXVUZVEzcW5YZ2NHMXl0QmV5QWJQblQ1UFk0TTNPS09uRmRIQ0xUcGhQ?=
 =?utf-8?B?cG1RZ2FMQ2FCaUtjbzNmbCtpZHp3YnEvN2xaU25CRVdpam92OXQveGgwckRP?=
 =?utf-8?B?SExHNEdtOVhYM1FYakd4RS8ra2xDT0lmZmNZbXQzUEZ4OCtIZlF1eXdHZmhi?=
 =?utf-8?B?bDJlQThqTno5ZHhJQVVUejVFb0pDWVppam5EOVd2UTFLVEhRSXo4cVFwZW9C?=
 =?utf-8?B?aVBGK3oxOUk1Q25oODdXMUthd2JaTEgzVFlTQzR1c2lFYUZuT01sVDNnb3JP?=
 =?utf-8?B?OE1RNkY0Y0hnK3ZvRjFDTkwvUXhYT0ZnNVU2MWJ6Qy93QVAxWFFVRmg2Q2t6?=
 =?utf-8?B?STZVa3VKakNaWjBpUEN6NUQwOFUvT3NGVzF6bWtXdTcyUk56c0VUQlRhQ0l2?=
 =?utf-8?B?V2JEQi9USlNiQlp3bjROUkF0Nmh0NFNWVmd1YmNNeTlsNGYyb2YvY2VPZEcw?=
 =?utf-8?B?Q2hpQXJMVU5KVEZ0TExPa0FBZFRpOFl4MlNIRGFPN05MUy9ONUE5Y3ljcGJJ?=
 =?utf-8?B?ZDkrUk5UalhsUkhHTWY1Tm5RQTYrQ080V2ZiNWlzTk91NC9mWVFFZTVHNGY3?=
 =?utf-8?B?QWhUalFJdVpQSDNLVlpZaUFrVS9RV2c3N0RSVnlyRGF1dFNpeTg4clYzZHVT?=
 =?utf-8?B?dUwySG8zeFVEQVMvMThzTHBzSVJMOTFvTkxyaFJZK2MxREZiTlhDTk5pNllT?=
 =?utf-8?Q?hG7yYwGSn/o7S1dLIGani/36iQgBAsiR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVhsNE9QWmdqalkrT29kVU1JUS9ZYzlCVzRtN0J4c3FUL0dkL2ZsdVBPOFRE?=
 =?utf-8?B?WGloOThmTEd3WnZ2TDV0OEp2Q1kxV0dpWS83U1RtMGpBSnN6eE44VXNGSXlG?=
 =?utf-8?B?OEd6T0p3Z1B0R0U2aFFBUzVyM2M1bUQ5RjVwc01wZDZScy9DdkJvNGtmaWN4?=
 =?utf-8?B?alA2WUk0Zk9JbWpkRDdkN092NHRsbG1kMFFvYmNRc1lTMjlMQ2szTjNqYTdZ?=
 =?utf-8?B?RlMwZFU1SnlVMlJaU2xTMmF1cGFDYUVCREpnVzVBTVp5NkNaaE9EMy9xczRL?=
 =?utf-8?B?MmxxcWEvNkVETzA2S2UwRUszMXlyd1BGVnF6RG90K284YmwwT3BvME92WFFH?=
 =?utf-8?B?dFY1SXRZMDZZTCtSancxc2NuUjlXSW1TSDg0cVIybTBQT05lNWhFT1VudjZU?=
 =?utf-8?B?a2NwdVFsMFc3V1hsTkhuUVFyODcybmhSdTd1c2xFV2VPNUlNOVVxVHBKOFA2?=
 =?utf-8?B?OHFhbXA1Y200UkpwUCszYXlxQmJscXZkVkdIdTM0ZkVSTi94TWhuV0tIbHNI?=
 =?utf-8?B?blp4aCtacjEyYkJVVUJVaGNqNGpKYTJhajArbHJmODh0SThFaGJZR05lWmxU?=
 =?utf-8?B?MzJJd2E4MGlMMUFtYnRJWFd5REl5U2ZJSUp5UUtaYWN5S01ialBFWkVuazU4?=
 =?utf-8?B?c0tIR1NPemRxSnV2d2lCbzVITE5aaFhXTWZ5QmNZWlpuQVZtR2d2bC9QT2Q0?=
 =?utf-8?B?QVJLMm01TitlMWNvb3ZIUUJENGRKbG9JejBUMi9ORk51ZE1iaFhVa2tmN0cz?=
 =?utf-8?B?SUpKRllGZ0RocVROK213MllPME4wL1cwMHBBb1dLTklhUVlsbXV2bkRmSDBG?=
 =?utf-8?B?NHlGakpXOVdIM3pWUWZrbi94MUl1dlU2d2FuTGdQVUluY0xwdFZma0t6NTBN?=
 =?utf-8?B?MU9waHAyTHFMcldsODFGSFNsaThNa1NPTUJ4MGMwMGtMRnROQjlQOGpqaEVi?=
 =?utf-8?B?YXo5R0hMNEhGcGx2SFV6bkxYbnJ3UE95RnNBS3VSOVNhdkJBOXNaclQxMWxO?=
 =?utf-8?B?bWNQeFV1c3FHU1YwakJMRnFGVTlJZVZUU21yMnd5SnA0V20yT1NGaDFrUUNZ?=
 =?utf-8?B?QnorTzNJbGZ0QkFreENKTHg5T05PVzVWNDZXR2JJL0hOMDhoeVdadzdoelB1?=
 =?utf-8?B?c3RTZVZNQzRpZXlnQjNmM1NrNm5YQUlsOS9YYXRhS05jZytrSXI1ZGZ1cTRX?=
 =?utf-8?B?YVVJc3lZRis0MXFUUlNxdkJBSHBRK1pZTnRJMDduTDNQZGVnREhLS1dDQ0JI?=
 =?utf-8?B?ckw0VmRycWxwTnY5RU5xcWl6Qk9OeUpzVXlGeUxEVlEyWXJsbnZiWGU4Q2hL?=
 =?utf-8?B?ZHc3alQ5OUlSbE16VFQrY0Vya3ZWeWtJb21zTDMrY25IUnFVRzNLa2JCMlht?=
 =?utf-8?B?cW4vY2JCdmhhTXdTL0NNakxsZFdBZ3plUExuMmFiZ3hEMlVQVG16enZrREV5?=
 =?utf-8?B?anl0aW11NlRWeklWTEJxSGk1OHlKc21jZzJpaFFIdlVBd2JIYTRFanV2bkwr?=
 =?utf-8?B?a1E5ZmR6WExJQ0dDbjJJOTZHUHFianBlVy9QU1NKaEx6dy9KUmZYbWUvZmlN?=
 =?utf-8?B?WnNDUEUrVlVPZy9rKy9ad2VqVG1HcmVFR3NnK29zVUR5TmFrQm5ITU5UQk90?=
 =?utf-8?B?NGZ4S1hrM21EYmFybDU5ZjJteXJqMC9qWHJrM0x4R3NoTFhRZlRaRXE4Rzdk?=
 =?utf-8?B?aE80aW5RVm5wWFBGTTd5NGZyNFRQb2h5b2djWFF6cUhvSjFFMDlOZmptaXJw?=
 =?utf-8?B?VStNRldGTHdhOHJZQWkxa3c1SjV1TXp5anBzdkkxaFY1ZHBIUEdTMng3dzdR?=
 =?utf-8?B?TkZTVnd1Q3NodkNpTzYyN3YycTltckdLM0htbVQ1bCtVTUtEdFg5T2pUYkpk?=
 =?utf-8?B?aXpucUNmV3NNdVd6dU44aGZzZTBaOSsrMkEzZ0pHSmxlcm11NjFwRUJiY0la?=
 =?utf-8?B?Q21YMEs0ZmhXNlA0MyszSkRpcmpBYjRvQUJaR1cvalZLMGpocDh1eHFTMTRS?=
 =?utf-8?B?eDZMQ3ZmM1FYQ2lISWJOUHgydmExeEhYQU5zT25EL0t6SW9TYVBxZ2FUVVR4?=
 =?utf-8?B?bFQ5N29zbTZDVi9iOVdJcEtwWG9WSWJqOThBUEpxYUVwMCtvZzduOEhqODBF?=
 =?utf-8?B?eThYQ3RZQmVUOG5SQnhrME8yZStjb1BLSDBlcmdRdFB6Sk9JSzg3M2JORzBt?=
 =?utf-8?B?OWpjRlh4ZWJQNm1iTHFrbDZ6cUIzb3ZUaEw5K25MY016cGVyOTJlOWJpNE84?=
 =?utf-8?B?Y3JrMlNRNXdVVS9nNkhaMEZ0ZHM4WlR0SWplbXZya1luNk11SGE4TzhIYU03?=
 =?utf-8?B?WDdFeXc0amVGenpLVVpCcVhjZmgrQUxudkh5Rk1DS05Eb1FGTjdpZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1801a9-09e0-4ad6-ee16-08de3f4f6950
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 22:39:03.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXw08JUWuQb+/unPnetnKDwXHHxRlLhAbAGsuxGVpnT5x5jKhy2iuVVfZYx1BSivSFt/XCJrU/oD8I+WYVTTSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695



On 12/19/2025 5:19 PM, Mathieu Desnoyers wrote:
> On 2025-12-19 10:42, Joel Fernandes wrote:
>>
>> IMHO the overflow case is "special" and should not happen often, otherwise
>> things are "bad" anyway. I am not sure if this kind of complexity will be worth
>> it unless we know HP forward-progress is a real problem. Also, since HP acquire
>> will be short lived, are we that likely to not get past a temporary shortage of
>> slots?
> 
> Given that we have context switch integration which moves the active
> per-cpu slots to the overflow list, I can see that even not-so-special
> users which get preempted or block regularly with active per-cpu slots
> could theoretically end up preventing HP scan progress.

Yeah, I see. That's the 'problem' with the preemption design of this patchset.
You always have to move it in and out of overflow list on preemption even when
there is no overflow AFAICS. My idea (which has its own issues) does not require
that on preemption.

> Providing HP scan progress guarantees is IMO an important aspect to
> consider if we want to ensure the implementation does not cause subtle
> HP scan stall when its amount of use will scale up.

Sure. But if you didn't have to deal with a list in the 'normal' case (not over
saturated slots case), then it wouldn't be that big a deal.

>> Perhaps the forward-progress problem should be rephrased to the following?: If a
>> reader hit an overflow slot, it should probably be able to get a non-overflow
>> slot soon, even if hazard pointer slots are over-subscribed.
> 
> Those are two distinct forward progress guarantees, and I think both are
> important:
> 
> * Forward progress of HP readers,
> * Forward progress of HP scan.

Maybe I am missing something, but AFAICS, if the readers and only using slots
and not locking in normal operation, then the scan also will automatically make
forward progress. So both are forward progress of readers and scanning related.
It is your preemption design that requires the locking..

Btw, I thought about the scanning issue with the task-slots idea, and really
synchronize() is supposed to be a slow-path so I am not fully sure it is that
much of an issue - again depends on usecase but for per-cpu ref and
synchronize_rcu(), both are 'slow' anyway. Again depends on usecase. And for the
async case, it is almost not an issue at all due to the batching/amortization of
the task scan cost.

thanks,

 - Joel

