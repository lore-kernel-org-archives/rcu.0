Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF65AD21;
	Mon, 14 Apr 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643153; cv=fail; b=RXgC0TygweBcNh0kQ8En4MObHzoDQkTgVz8OPehSGK4lekzUwM8O6Uc+MBjGhhgxx+o1gajEgk+QqvGVTOxm/Y5DK1EJWJd8tYzUdM3p22Dhkq13JrhiCr5y+xk/9o2aHd+L6ylFUcLIAQyMuUcwzdHJX7Zt/nlZq0/Aqe+oHcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643153; c=relaxed/simple;
	bh=EfTx4hxKTfV1PncIU6Gl6XYwFUJFhnwWJYiD4VEt7DY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qrI3Wdj9u+xu+qaPhB/3JsGxy0slJVRAUIq6mBbJPjWIsIFsK2py9W9XjnxxiQELiOr37NsVdtr/pVDmCzEZ5AkyC7IuwwTCFOLJylu5kdTbkOyBBArVGplJc/VNzI6at818VE/O+YEhYiyuRfYO39GisleMko2mDsoPlHBhJK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pUt9gP+8; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pUt9gP+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N03cMbip5Lk2GzIC7eoT50lPbk3djthv9gsMXrsIwegjUYHzbj/XaxZxkCcsFJe1ZjhuuI0uN/oeDh19dkXe/6232tH7zZ10q8yd9pHXKtviLlYU80nsxMwdk6ECJtrszRyOr31MuzQRsTfuN7MZXi6vj39l1f9spyO1753scRhPhPb3CWPuvQo5RfhBBV5OCccGtlWCPyTWJ5RZnmy2NwEykvjapfH1K8kpV7JQIMj6gtbxe/E0F8ic/l9/kmq6gnEbp3nKZfmu+Xry99L2dZUFJ0o4yy0df/pLkRxWkI55ouxWotMR3gkk3OkziioxpU1QbjNgNFfWywEEjuM/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwwEuFVzCbWKLhTBM0SLvP59FZ1siv3RLKj+OH83hxI=;
 b=y8UU4bs5uNzpqg5mhNxGAGJFeGprMJEFVh5+KM0Gf/9dQP9LYPTu6F7ejRKRkRNEla4ss1icqlmudvYJF/lHygyT0PVGDLqdyDNCRFExPpwULmaQtNIOX/svu7Sm2mKSHklncqJUWwWlpcAWGnHSayOh/ZnmRqEBLZXk5KvzxqT/Cc5ZvZScm7EgLi9GX+Nngwas3HYG3fOJXTpec8wyH/Lvr2HxyIXdSkdvyMRyRJhtgn6d/JmY1WftAenpIMx2KFB2EEVA1c06H1UGZx4qqNScTK8EQywCV7ivBeEi1HT+WnkWM4+qomo7o/lECQ/9qCnMNRSgw2kkLyigwAZXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwwEuFVzCbWKLhTBM0SLvP59FZ1siv3RLKj+OH83hxI=;
 b=pUt9gP+8Ciyi0/9V3xBxz6IycFQK5io9xuAjohaQ/x9Txa8nrWvHOyeiN2WtoAG/XrURNBa/g26UN6ChiTLZBUgWzhwIXo6Xl2rdFvu22B4bqARZhgOL5LWLlVBz3Fk/jR78dFP1gQ/G5QKzEAbuVxFmjytZF51kW49jv4c9Bgc/O57r6h8fY2buQHedIIzpQyTSxGs4bXa1onKsZr2K1l6OKTiqQ2bbxGYC8C99B/yzzaA/7LcXpeFiU7NTbGjH6kRhgeg0aBY+3wwx6nPGYEwlesThcSB3g+hvn8g7A8av76dwh/s3hB2BlG1GuUXu0VNqPPpDcOaYzkCxPU8bIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 15:05:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 15:05:48 +0000
Message-ID: <5ee46103-caef-46ac-8660-4b9f4bb5e4f0@nvidia.com>
Date: Mon, 14 Apr 2025 11:05:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rcutorture: Perform more frequent testing of
 ->gpwrap
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
References: <20250410150329.3807285-1-joelagnelf@nvidia.com>
 <20250410150329.3807285-2-joelagnelf@nvidia.com>
 <11caaa93-7acf-417c-9223-1b14a76310b2@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <11caaa93-7acf-417c-9223-1b14a76310b2@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:208:fc::46) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 377c155b-a888-4a04-b56c-08dd7b65d700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1ZmRjJNL2JyYnBZdmR0VFc1S3NhS3N4U3BwL3YxbVZkcjVpaXNlYzg0VUhS?=
 =?utf-8?B?cmZOR1ZLdnZOemtjR0p4a0R5L1MrTVgwT0x2VHUzQ1FVQ3RQbDdmVEVoK1B2?=
 =?utf-8?B?b0pPcEJJWk5UM3RJemV5VVhmRWNwcExKWms4ZlFNV1UzcW53WGdNZGNlQVBy?=
 =?utf-8?B?WU9JTkNGQXRPUWpaSHFiYUlROUdWamtvWVpNa0lINUxFN0hpRVVmV2hhRlFo?=
 =?utf-8?B?TVN0V2pDS2J1TjJOM2NiS3hRR3Z1R2ViSDVqOFBuZjdueEhrdTZxK3pKRTNw?=
 =?utf-8?B?bndkU3ZmSGxERzF2T0k2b2hVK0d1MThBT0tGTWJJYjBpNW1nM0pOVEZiR2J4?=
 =?utf-8?B?SjdDUno1YWNCbGFLbHF5RU9PQUZad1dlRm0yMTdPUWJNN0VMR0phdUdJSTFm?=
 =?utf-8?B?MER2Q2hzYXRXdDAvcyt6MTNRUWV5VU82QjZ0Ry9EUVgwS2RqRmlRSEpjV0Ri?=
 =?utf-8?B?dXJaNFlQZEtnS25Ud3E4YVoxZVAxS2taQnAwdFVKVU1qNlVXOXFIZUVyMDVn?=
 =?utf-8?B?QkMxZXh0eERGZ2psRmJmVzEvaEF6RlArSkFud3VhMmRMeVZaNGZSSitNaTBT?=
 =?utf-8?B?SzdrM01KNVpneGJGWm0xaEV5ZjV3SmlKNDhSK3d0K0FSUDQzK2ZWL1NqcDZU?=
 =?utf-8?B?YVp2RjhnSDBEWVJsWk9FZFJuc1ExVHRrMGNSQVVuby9JKzd6b3JlUVJERytQ?=
 =?utf-8?B?aEY2QUlFRDRDSW5KZ1ZWNWlsajl5U3Q2TXc3ZXpvM2lydFZxUHRmUHFUK0o0?=
 =?utf-8?B?Q3ROQ2k5ZWk5czNUS3pwcVJWdzU0WTRFaEFJVHU2M0x5MnloNDdiRXVLeWJK?=
 =?utf-8?B?UEdPcE96K08wSWIzREhCRzc2YjdhdC9VMjBMZzBwY3M5Rm9BZmtnMEpWWGh6?=
 =?utf-8?B?T1l3RDl1cHJUTFkyZVhHQ1hWSkk4TUZReHFsazBlQmVBMUpxQ2xRNVluQ0dH?=
 =?utf-8?B?U1pDbCtqV1VwekV4YW5Hd1JLQXVXZXZEY3hPWkUweWhYMSsxeUQrNlJ2cE0z?=
 =?utf-8?B?VmV6blJlSnZCNWsvRGsxWk5Ec1c1MUtyS2tEbXQ0c2taOU9PNTZ2cjcrdmRM?=
 =?utf-8?B?cjNNc1J1Mjk2R0thYnE0cjdyOFlMNXZlaEpkOWRhVmtVdUt4Yzl4Zk9TK05E?=
 =?utf-8?B?VjQ0alFMSlNsaUovTEk5OFVyc2VZd2h0czQ5QjAwd0Y2K2lISDN6QXYxMERz?=
 =?utf-8?B?M3pCYmZSaE03MWRCQnJ6YzhZeHd5ZVpSUDJqb0hBTVd5K050NWt5eFRKTTMv?=
 =?utf-8?B?bW1HNkpKSmluTWErNk56Qzl6QUE5Nlo2Vm5SVzBsd1JFeWdsSEZ0ckRmV3Zr?=
 =?utf-8?B?Y21ZRGdicTR5RmFCRlVyQlFzZSthT05KQXFKaFgybjg5NWh0REYzRzhHVzJS?=
 =?utf-8?B?TU1GWElYc0dPUndtZmhvcFhJSVgvSG9jK21tempuUHJtK3dGcnJBakRMY0hR?=
 =?utf-8?B?K2pmMFNkNjl2aVFoaE1KRlJsVTFyZjlrTU5VRnp6TW14eDZ5a2JCUThyMnE4?=
 =?utf-8?B?QjNpNG1JWlAyaDV4STRxRE93c0Y5QjhZTXZzTTUyM3hQOGN3OEhPK2ttZk1U?=
 =?utf-8?B?dDZUTVRGMEpKYS9pZGZUMUdnTlh2OGtNVGJURTNkbWtyRG8ySnRQek5qaDNl?=
 =?utf-8?B?K3hmMzlPNGlxd1d5MW1MTnVyQ084eDNpQW00MzBwSW1oUlZlMXhkTE9xR0Na?=
 =?utf-8?B?K094Vk5ZUzkxa3pDbklFRnA4bFRGSTVWNSs0TytxK1A4SEhlemNSR29SMTJS?=
 =?utf-8?B?eWhtZVI2ZU13RXVtV2tGcGUxNGl1bGNTSzVkUkJPOUp2T0tXaTZwdWpkcm10?=
 =?utf-8?B?SW8vZUtnc1VTU1lvbWlwNUJXUkRtTldJWUh4empXNTI0RkhDSTRMZGpJbFJ1?=
 =?utf-8?B?ejYrdUVpTDBiWm5wN2N4Q1FPejQ5LzIzekFOUzdtZW44dEdsWUlLYWo5TnZC?=
 =?utf-8?Q?2u6D4dOWJEY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHo5cnE2a3o0M2NtU2lJWm00bEN3VWJTaVZ2aUwvMVZDMkxQR2F3WUZwY1Vq?=
 =?utf-8?B?YzJ5R1N1bkM5NWFsc2plT2g3cUJ0Wms2OW1CaUZWQjFjOFpsL2hjOWRzSDNP?=
 =?utf-8?B?bHRxYUg3a3RBNXYwTzExVlNoL2ZyVUJFc2M1SXVVMFBPT0MvMTQ4Z0dCaUZC?=
 =?utf-8?B?SCsyZ0p4amQ0d2s1bGxReXgzajcrWW42MVJpbVh2MTlLTDVCZVdWYys3TGlq?=
 =?utf-8?B?SW5Ya2RqWWNHa2NrK2lXT004RjQzMlNyTG5zaWFIZDB6YWxEaWVmV1U0cUJY?=
 =?utf-8?B?ZnVReDdhSEkxN1NMOEsyMk5GWFlmQ1NycTQrQzc3eXJRQmFsQy9TQ3hEWjh3?=
 =?utf-8?B?WGFNWXZPOUNEUFBvcmhidHM5TDR1N1lVOG5ZSzl5VVVjWVVGUmdSZ3FDOVBp?=
 =?utf-8?B?SGhpbUZJaGhlMGZjNnlZSStjZWw1Tm1qNVlPUHQ2bkRVQjBPUm1qWVJtU09v?=
 =?utf-8?B?bCtFYXVuT2RBN25TNnM5S3dxeXBjc3pLMkFFYXVMQ1R0TFgrTnhrcTRzVU9H?=
 =?utf-8?B?UFZRVVg3bWZITHNzWUgrTmJPdkFmVU9QTDQxb2lkQ21zZ1hzSTBHVEhkZXl3?=
 =?utf-8?B?eXoxUnRXWm84OHFyRStDOGphTnFtMEZxOGhkVXk3YVVzeEVCZk1INEYzOUpt?=
 =?utf-8?B?SEpDVmZsNzVRUTY4aFBRd2hCb3RTejVPRmJ3TjVZMnkrMWVyVWlrUXIweVNx?=
 =?utf-8?B?MVBFeHFzN2gvcXJFQmhkT1MxU203dm1mYmdPbjV3Znd4SjZLMndiQmZLSlRa?=
 =?utf-8?B?a2V4elJnNTJCaVlBYmtaZXFVbGhvdisvdnJqVkREQkUwM2RIcVB6bTRpNkEx?=
 =?utf-8?B?TVpaUUdzWkd4cHhuNjZtUkZ6dG1hbDQ5NW9hcDZpekZBNjhMTGZ6dTRFd05D?=
 =?utf-8?B?L3IrMm03ay96REVvZXJqK0xScUJoMDVIdUt1T0xFUzU1T1RXeTc4dnAxcXdB?=
 =?utf-8?B?aGlleFdLU0VsOHdWQ2d5U1VJcm0zOTdqRzNlTCtxVnNmUEFNV1kxY3p5RGNQ?=
 =?utf-8?B?cjc2U0F0MUFza0tLdnFSbk95eGxoRHlETVNEZU1Jd0dWdVU4dk56cHM1b25i?=
 =?utf-8?B?Q1BPdlo4NUFaRnl1MDU2WVVlRFdJTU9NWkFFdnp3VTBLNXVldjJnUHRhV0FY?=
 =?utf-8?B?VnVhcGEySE9xUjc3MEcwQjVKaGtZZ3h0T3hzWjZ4QmtDR0ZndndEa3dJWUFS?=
 =?utf-8?B?VDlsK3R3SFBzeUMzNUx3SFY3ME5OMlRuTEVuRU0vSExFcktWNGtXOGRZeFI4?=
 =?utf-8?B?SlR4STU1cDdnL3RMNTd0TUNEbUN6WEhsenhkYnp3UTlXbTB5Rldoc29MVFFH?=
 =?utf-8?B?UmpXRTJPVXJwUUhCWjFqWTl3N0RFZktQMHdsMlhIRlFtTlBmMTZZdTlGeVpO?=
 =?utf-8?B?VWloWUxnZkdXZklGRW5qUlZ4TklnR3MwZzdtUkJkZWNHWnhQeUFDRzlPakc5?=
 =?utf-8?B?eVlCSUF6RVMxUVN5R2RDeDdzc0tGcFJKck5VclMxQVNVWHVodFBqWkFvM3RS?=
 =?utf-8?B?bXlYN1pCenFwUGJac01OaWd1VlpvMTlnWGY2NTVzbWJ5UjFOa05EV0x5ZDYz?=
 =?utf-8?B?NWlDOWc0SDRNK0hPeWdoczVOZHlYSzVPM1NMMGF3ZERuYWFFYXZKN004cHYy?=
 =?utf-8?B?NmZoN3Fnc2dNMHAwUTMxN0p6REY2UEl3ODJMQll2UE4xbGFPSDN4d1RVZlJ2?=
 =?utf-8?B?VEVTT0JDdWNGT285M3ltejZDWHpOWDJiR3lxTmEzNDJLbUJSaE9FbHFsZ1hl?=
 =?utf-8?B?RDZBQ0k5cXd4aGZZZkMrRGZ5SGJFc2kzS2J2WEZmSmZVcVRLVUlTY0xWd25I?=
 =?utf-8?B?SnNYQklXYldPVXp3dDhtenQrYW1mTG9zck0rdldvcUl1MHpTUEpkc3dsU1dP?=
 =?utf-8?B?dkltMFhrM3UvalIvdFpnbVlLclAyZ3doM2grbHE1QWJsRjdCNmdZdFZJOWJ5?=
 =?utf-8?B?S01sS1RSeVR0ZGJCaWYyUmJ3U0dvUWxEdkFtQ1ZwaGt1b3BCRHQrQnMwVFBt?=
 =?utf-8?B?NWYreFJLRUlidGRwaU9wMjk4WHAvUllrQU5CblV0d2lmZTdWMVM2dE44U1l1?=
 =?utf-8?B?L3YwYWdmakZrK21uOEhmazluQUtZM3BVUS9wMHFrZ0lhVXFiemJVNmcrVlZa?=
 =?utf-8?Q?yLLlSU0dapbawzJ4Yh+jDwolZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377c155b-a888-4a04-b56c-08dd7b65d700
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:05:48.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tquCGznr3zzmIIgogaV9iHOiesFiTUvOeEY8jKSw0Fhx/UI4V6sg96JRy9Sz2PxKSJtRsP3esvJjOWy/7llZ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

On 4/10/2025 2:29 PM, Paul E. McKenney wrote:
>> +static int rcu_gpwrap_lag_init(void)
>> +{
>> +	if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
>> +		pr_alert("rcu-torture: lag timing parameters must be positive\n");
>> +		return -EINVAL;
> When rcutorture is initiated by modprobe, this makes perfect sense.
> 
> But if rcutorture is built in, we have other choices:  (1) Disable gpwrap
> testing and do other testing but splat so that the bogus scripting can
> be fixed, (2) Force default values and splat as before, (3) Splat and
> halt the system.
> 
> The usual approach has been #1, but what makes sense in this case?

If the user deliberately tries to prevent the test, I am Ok with #3 which I
believe is the current behavior. But otherwise #1 is also Ok with me but I don't
feel strongly about doing that.

If we want to do #3, it will just involve changing the "return -EINVAL" to
"return 0" but also may need to be doing so only if RCU torture is a built-in.

IMO the current behavior is reasonable than adding more complexity for an
unusual case for a built-in?

On the other hand if the issue is with providing the user with a way to disable
gpwrap testing, that should IMO be another parameter than setting the _mins
parameters to be 0. But I think we may not want this testing disabled since it
is already "self-disabled" for the first 25 miutes.

Thoughts?

Thanks!

 - Joel

