Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCCB1A9FAC
	for <rcu@vger.kernel.org>; Wed, 17 Dec 2025 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978169; cv=fail; b=uoTFN7nVTPzX9s7oPwnsFTcyS14hXYvF+5Yj+Yt5ztnnuRpItaO07HFPoNrWTYfQ1bOY/s5jiJYC5ZTILcnxFlnoIAkLovYl46dx/j1R/UKn4qoJej1Y3oruN9LdmVi2OU65Zb4J8MkfscFQHT/NP2VlMZnNQN2If37Yzcj84fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978169; c=relaxed/simple;
	bh=ftCxn4yYjR7v5ZoXVtUi4HAryrLdK9fXDgYJGAZsFXE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j17yjyCTPlutsMR+qfnHbdBU3HTqzTftg2vl9P+PzrDbUJ0cno7HB+j8qL5+3XFTy5Yf90KvF6eJKRuxqtNTWk+5ap3Rt2+8DOh/HobJIBWqgJor/iHMikbhNPxzsM6zgjxYcxBwpkxXlf2NB8xYBgAKDhH0V7tb3hpHo5pt6LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GCGx1Vlf; arc=fail smtp.client-ip=52.101.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GCGx1Vlf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raEmPcZwpokPxrcN4i9GwWK2UucSBlxiIrG1gLpT38JkdMXnIhONr05x74cv7JtJGs1pHoQMmVCWY4BHq2qEWU4OYvCtf9z/VwJUTyZVSaQKQWOBYkKBQo2mMXZ5d/kz5tveQh8pRo9kCrbtzLYSoqePUfPaKzl27xlcy5TqhQqCJP+UZoVeGa3pYvTbZKHSCDzQolKw0TNDIA6ixD3sJhPjBSF2GyacDYN8Qw3VlMB9Bl35ynprSMS8rhKeYSOMkYxrF0YuRlWz2O+kHFLx4yd2JyhGxXTqDIxiNGiEaDXRWTzjlAXe10OgSUXSuM4jjKefvCZ+7yElzFiNiV+RgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+LyqFCypApEUk7y8GQCktnrwJtWOyBKVYegbN2Gh1w=;
 b=rBv7x+JBbuNPmxULh5/W9Fk5qNfYzzg4YtgYOoriWQsVEJd7Esn22s6aJ2TjaREAwSLKcEI7kbSB+BSxQz7Yas/lIlK3ZVbVh3n9VKhb4Acb48YdCc9j8QYO4F8xOXI5JQ0CojI5c6j9EVRSAc4nXZGnLh8yARYUfx+lPdeYb9Vj80SaD1nBN97yNJ8nA7oE9lR4pAI5UPllcoz6jY85w2l5Wc24SFtvN6WjtYl2bmSCMMFGq0r+35E6ZuBefFNm3h7HZ+rThkHGxpp6Cw5hO69SXTeLvmBBKSgpUoQcjP7faVWEbaF8xfg7pDRllObzg6xkwX8/VcCdF+Rj24GZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+LyqFCypApEUk7y8GQCktnrwJtWOyBKVYegbN2Gh1w=;
 b=GCGx1Vlfzq3FFw9R1Q09jISlMOd6HIHi/gVKhDk4rUnpn3Cz37nuj3GAxsQL0jpo0ViIUKmQUkLWNBksJ2ol9Lq8/0/kpQL24cOJzQdVql2cmRRNjBKT90kLbgRobW6CB5YR6LOn6+W26194VBA6JeiD6rzthJ0QGslYbHXXPsWVoKq1/qw19+3SsdfUrfKYJbvlIeu6l0NvBRaNicTKjTQdBsJh30SIAYrNZMcss9Ng/wZeN1HL3I0Bwamko8s/TCAWSzXKd9lmzES/0DEXqCMPgvMpEBbNH4dMITXHNX/OIrIb0EulV0nlpUeHq/qilBg75nyB9DJ741XlbeV00A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:54:42 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:54:42 +0000
Message-ID: <f5652447-9471-4d2b-a589-54bfe6e0def1@nvidia.com>
Date: Wed, 17 Dec 2025 02:54:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Handling large numbers of hazard pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Joel Fernandes <joel@joelfernandes.org>
Cc: "paulmck@kernel.org" <paulmck@kernel.org>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
References: <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>
 <31331836-E9F9-46DF-A8EA-010379A56677@joelfernandes.org>
 <EF62E36B-7A3E-402F-ADA6-A1D443DA0ECE@nvidia.com>
 <6661a53b-918e-474e-b3d3-ffa70c39d667@efficios.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <6661a53b-918e-474e-b3d3-ffa70c39d667@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0013.namprd15.prod.outlook.com
 (2603:10b6:207:17::26) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: a18c71ec-c138-44ae-a05b-08de3d418959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlNWbXJLSkE5bE10ZERpQmpTYjk0Sk5iLzRManZ6T200L0l0U2NxbzdzaWtF?=
 =?utf-8?B?a0Mrdmw0TVlxUmtDN1dETDIxZE44TzgrMXgxSi90b283YkhENmh5bFB3bjFy?=
 =?utf-8?B?MXN2aTRsZmRYdjFkNEJFdE9oOHNZSjVPWHBhc0s2RzhaL1o1S0V6cDRzbjFu?=
 =?utf-8?B?SUVRdDJGNUhrZXU3M3VndnZhV0lGM1YvY3hTYVY1U1FmdER5MTQwY1pXaFNE?=
 =?utf-8?B?c1FlL2hnT0ZDWHRLcmRZTUNBbTVzeFl1TDZQaWVvbkJqbHNpOXhvcnVVRXBJ?=
 =?utf-8?B?akxzYnhKT2c1U2FjSlo4RHkyYnByZ1M0K255cXJVaDJuSzNNVG1oWFZGRmEz?=
 =?utf-8?B?MlNGeUdvRkVQYTJVUEw4SS91Q2RKUzZjR1N5TEZ3QkF0SExvNEJ0NDh0bFlC?=
 =?utf-8?B?QUVYbS9Pdk5xb0lTSFJXZWNRamZMcXJXMVRONC80Nm81V2RCTTZjSFlucG9x?=
 =?utf-8?B?aWxIWDliekpaZmxBRGxoRENRU251NlZaYmlSSmRtTXk2am96RFpNellVQnpl?=
 =?utf-8?B?QTFVNEtDSDdWNml2V3JVR1Y1TWh6UXF1b1ZTTzlVTTdza0JCQ3QwWjlrL3F4?=
 =?utf-8?B?MzAxMjlQekxQd2NxejFIVlJwOTBmN0Frci90cTkyTEJPSkZBZnNKaldNZ0lu?=
 =?utf-8?B?ZUpsc2tFcGVsL0FDT1pnZUg3ek85R0pmOVdRazAxWjlvRHFkbWZEUXNuOGZQ?=
 =?utf-8?B?UWkveFpQSmNIS1BRSGEzOHVieHpuUW50elZIUnlzWm1yeVpyempmV0dtNjVh?=
 =?utf-8?B?Q1hxOEZBYVRXMURDam1xR3N4ckcwSFdWTi9nNlB1eE9JY2ZMTFltYVhRR2tx?=
 =?utf-8?B?M1grNGRMbFJyZVM3cit0REtGekJUV0kzTVM2OGh6bEVIRkNsZWRDb1hmWEl4?=
 =?utf-8?B?SmxGRmM4c3Y3QnJBMXQvQ2hBVFBUTm9wa1JYcy9uSjN5bGpzT2xSTFlVejdw?=
 =?utf-8?B?S1JaTlN6eG9oam9RR0N3NVJXb0ptdm9BOERubi9zcldUcCt6MHAvR2tzRmJF?=
 =?utf-8?B?U3lvVC9wRCtPdGM1UytONlJud1pmUWdrNmZEbW9mUEFpbjQvTTF4dnJvVzh6?=
 =?utf-8?B?RjAzenNabGNCbmxRN2ltUU9XL0tJeE1wdmRZM2dOZ3dIVThjUmVWem9ycnFZ?=
 =?utf-8?B?K1E3Vm9Hc3lRY3l2UjNnY0NoOGhBTGxmeWlZaHVNZmVCNFRDS1ZiUmZyTG5w?=
 =?utf-8?B?ZWZVMktsT1dEK3Z5eEo4ME1rSG9uKzhNS3grR1V2YzNxOXNGMDZQUmZ0azh6?=
 =?utf-8?B?eDFoeFFnaTFvMmlteGluS2FTOXNFcFFFdERqSkpHZ3VoL3dOMkVaN2hzNElV?=
 =?utf-8?B?SnhIdVhoYVpUUmRjV1RjZHFHdFJzcmdPUEpZM0xRU1plaFlZcGVKWUc3OW5J?=
 =?utf-8?B?RnBsZ0p1UFlvd2xwUFBKdUxMeUtXL1ltbDdqNk9Eb2xxNGVkNVVZZzgrZm5F?=
 =?utf-8?B?SEN0MG5YTGd3RlV3TGRWRVhETUsxZ2FDM2d5cC9oUEdMTXVpUFoxdk5uQ0dp?=
 =?utf-8?B?S0t4NEREa0l2YUNkK053TmRsRHUxSGwwUDh6SlRLTUhmeDlsQXpXT3gzRjBa?=
 =?utf-8?B?bkRnOSsrcFlmbHBpRGpiQXBPZ2pJNllNUHRCUEppZUcvZmVpV0FnMWtKdlF3?=
 =?utf-8?B?V1RkRWl2L1BTOHB5K1JVWnRrSDZocUc5NTBiSHdnV0s1OE5ydzVHNHl4dE0v?=
 =?utf-8?B?ZzU1OEQzLzZ3cTM5Z1Q1K1B2SWhFWlRUTXRIZHNWM1Aya2F6Qy8raDhubVNF?=
 =?utf-8?B?STFDZXF5TitIN2Y1ZHJYMFZXSVB1N1RyTTIzdW8xWEJLYnkyc3FKY1FhSXVi?=
 =?utf-8?B?QXhuWU1lbFhqZjFoeXVQVm14b3B0RnBYMFdISm53VWNKU3h2QXp3TStwNFF3?=
 =?utf-8?B?L09Md1JUdEhRZVpFOTBoK1QwcHBVbHhDeEFaN1Z5Z0owb2xvZXUxTXJZR0lL?=
 =?utf-8?Q?cPEefLRbfFP854oNGkk/QDkt17BDLnbW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEZ4RzhBUHZGUzJEdkZHWjlyQTFLK2ZRMzJhSmF4VjBNTDY5ZGZzYlk5anJx?=
 =?utf-8?B?S3pkTDN3L2E3UlErZmdLRlFHNVYzNFkxcUlJNEhhcGFnN09NWU9IYjRTZXBx?=
 =?utf-8?B?dUEwOXFXS3grUU1WbVcrYlAwdDZPMzJTdzFnWDA1Wk1tNjF1dHdZNjdhRjBR?=
 =?utf-8?B?UGJ6NlpXYWhYcHgvNG84aTV3eEkyQXoweFd5bUsxenFDQ2h1bS9EMzF6aXh6?=
 =?utf-8?B?emZQQnZXYXdLQW5vSzRpbVR1NlZ5Q25taDRyWHNLcFUzVXd3cnFOWXVtR2pU?=
 =?utf-8?B?M1BrZ0RJNWhjRXllU2ZITzJCck5UYlRxSVkvR3k4LzRId1BWaDNCcWlEdnhk?=
 =?utf-8?B?RmY1MXhsWDZSNEVhRGIvMitPRWowblp0akEwSVJRZDVyb1c0MFlKbG9PNE5Y?=
 =?utf-8?B?aEhYWXZ5azJLTVNsRjh1RjVpTitqYUl2V1dhSmx2YlhmNlFzUmZaOWNFTGNq?=
 =?utf-8?B?d1hmZWptM1ZWS2djTDNwbWs3bGloMllQempIV1R0a2RFUEtxbklYNWRBTEY4?=
 =?utf-8?B?SUh1RUlPei8zMjJxUEp3WDh3V2tja1FIQXNtNmx6NWVDMWhjZkxsRjcxL3ZP?=
 =?utf-8?B?YU1TdlllVFMzSG5yZ0lPSEN3dkdaSWZDQlVvYWFpZ0hyVWQrUXhWemZjeDBF?=
 =?utf-8?B?TWkySXVGVzBnTjhkbFN0QWJ1UFpXUzVMQXJDL0tsaWkvV3dJWURoTTZ3ZUc4?=
 =?utf-8?B?c0M0VEVFUmxtVWJnMjJBdFN5TzFxc0hvaE0rRWpsMER6alBpVDVNWXY2MDVX?=
 =?utf-8?B?aW51MnIzQS9rbEZLN2doeHM3b3JDVXEyZEVhQjBTQmFJZ2NBbHhvT3htUERq?=
 =?utf-8?B?RnJEK3Q4ZmtKM0xBMjBsaFhrbjhtblVTKzNkdHEydEZUb3NDK3QrRHFJUVFL?=
 =?utf-8?B?QTNDajUwaUlYcFAvUFcvc252S1lIcGVtVENqVXM2bTdBVG9PQ3V5WFpyNmJ1?=
 =?utf-8?B?K3QvMkMvMjdGN1IzL014dkZxRTZSK2ovcXNFTHdPUG1vb3VpOGIvcUFzSWxY?=
 =?utf-8?B?c0EyUjlWZU9XSE5rVXVDbVQ5cWFwZTdmbGtzRWhQWkZtdXQwcUdmbWdxVlc0?=
 =?utf-8?B?eCtVb01BNXdoZ0hMMGtrbXhhQVR4eUNuTktBQ2xGWEo1ekFiSnN3WVFFcXNE?=
 =?utf-8?B?ZWdxU0JzUHpZSXFMcEh3N0lGRkI5UENIejBIRURQS0lLVmk5YVhLT0lwVzNq?=
 =?utf-8?B?NTkwMm1GbTRXQ3ZwdE9UQmpDLzN2Q2M1VzB6bGl5dm5zMnNBamE3Uk8wbThO?=
 =?utf-8?B?ZTFvSFR6d2VINlE1cE96SGJCcDNyQWxGMTF6Unh1NlFxUkY3K1plQ0haUERt?=
 =?utf-8?B?Q0tFcU10S1NwMzFEa0VvZ0E5TFlNUVRrWks4Nm5HaXNtNDViOVkxSE5qZ0xX?=
 =?utf-8?B?SXh3ZHdVWXY5Nm1aVHpienBham4vUTIwQ0RrOUhMR1B2djVPeGFETkdQT0dn?=
 =?utf-8?B?cjZBbHpIZXkzSmxFeUlkOG5sbTFzNnl0TlRlQlFwNmt2UlkyWXF6djNXQmlW?=
 =?utf-8?B?VU83Z3JxME8wL04wb2lwSi9obnk4QTdsV0JTeFlTaXhVWnM0WWo5VFQwTVJr?=
 =?utf-8?B?Zk9yaEs1Z3Fkd2wya1cySFd3NDg2dkJLdlhGNHFSQjVXNm53TTNOallESnJa?=
 =?utf-8?B?bGYrWjVvN25VWU9pbE8weDIwa2pmc0F6N2pIbDJKS3EwKzlzQXRDOXZuZ1Iz?=
 =?utf-8?B?QTBCQ2cwZVRlODVKUnA3VldCNFhJaCtWVFkwZzQxTHF5TlQ5OXhobzcrbE94?=
 =?utf-8?B?dWd2T09yUnJGQm96ZTMyNTZ6UGZCeEtTaHpDcStETncwRURSbEhoTlVsQXpI?=
 =?utf-8?B?VzQ2aE14KzhlQVVEWTV3U1pUcGtuYmxKSE1xdGRYczhjeXp0Ym5uR29uckRD?=
 =?utf-8?B?YTBTeDgva0MwckUzNVdQWS9HTjVNT0kzd1lJaURzZnNQSHlzYmxnTUxQbDlQ?=
 =?utf-8?B?YnpEZnZidytjV2R0N0JIQWVqVkxobi9lTlMxVzRKSEgzRkhsOTJaWXRqazlO?=
 =?utf-8?B?blRvR3ZsTjBPVlc1VGwySWpXT3N3WTVTb2pKanV4aDgzMnlYVm5pajErOUx6?=
 =?utf-8?B?bTAvRllOeWtZYWVoekhWZGRvZHBjdHlPVjgvQmZnVEk5aG5BaE1NOEV2Vlhp?=
 =?utf-8?Q?PvQKsd/nA1NTEteCpkZ7m65wB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18c71ec-c138-44ae-a05b-08de3d418959
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:54:42.2289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3G1DfliLwZ6hbn94qLK3woGS06e/5Nsha5j7Plo6sHK1IKSDKoLPQmzAzEYK0xIv3nAPADAtQ0qPFrkLPo9vyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975

Hi Mathieu,

On 12/15/2025 2:38 PM, Mathieu Desnoyers wrote:
> On 2025-12-14 18:26, Joel Fernandes wrote:
>>
>>
>>> On Dec 15, 2025, at 7:36 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
>>>
>>> ﻿
>>>
>>>> On Dec 14, 2025, at 10:43 PM, Mathieu Desnoyers
>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>> ﻿On 2025-12-14 02:14, Joel Fernandes wrote:
>>>> [...]
>>>>>> We have had similar issues with kfree_rcu() and running out of
>>>>>> preallocated memory there meant we just triggered a slow path
>>>>>> (synchronize) but for hazard ptr I am not sure what such a slow path would
>>>>>> be since, since this problem appears to be on the reader side.
>>>>>>
>>>>>> Perhaps we can also pre allocate overflow nodes in the api itself, and tap
>>>>>> into that in case of overflow? The user need not provide their own storage
>>>>>> then for overflow purposes, I think. And perhaps this pre allocated pool
>>>>>> of overflow nodes can also be common to all hazptr users. Ideally it would
>>>>>> be good to not all the api user deal with overflow at all and it
>>>>>> transparently works behind the scenes.
>>>>
>>>> With the preallocation approach, how can we guarantee that we
>>>> preallocate enough, and if we cannot provide that guarantee,
>>>> how should readers behave when they reach that limit ?
>>>
>>> Sure, see below.
>>>
>>>>>>
>>>>>> I think we need not worry too much about cases of preallocated overflow
>>>>>> nodes itself running out because that is no different than reserved memory
>>>>>> needed in atomic context which need a minimum off anyway right? And we
>>>>>> have a bounded number of CPU and bounded number of context, so the number
>>>>>> of *active* nodes required at any given time should also be bounded?
>>>>
>>>> So the "simple" implementation presented by Boqun at LPC2025 was limited
>>>> to preemption disabled context, but in general there is really no need
>>>> to require hazptr users to disable preemption for the entire duration of
>>>> their hazptr protected critical section. This means that tasks holding a
>>>> hazptr can be preempted or blocked, which increases significantly the
>>>> number of concurrently active hazptr we need to preallocate.
>>>>
>>>> So I'd rather remove the preempt disable constraint across the entire
>>>> hazptr crtitical section if it's not too much trouble. And it appears
>>>> that backup slots preallocation is the only fundamental reason that
>>>> would motivate this constraint so far.
>>>
>>> We can remove the preempt disable constraint and still not require stack
>>> allocation by simply embedding overflow nodes and any other context, in
>>> task_struct right? This is similiar to how preemptible-rcu tracks readers.
> 
> This misses the nested hazard pointer use-case, e.g. one function keeps
> a hazard pointer active while calling another function which itself
> uses a hazard pointer.
> 
> Keeping the backup slot on the caller stack frame takes care of nesting,
> which gets tricky if the backup slot is in the task struct.

Could you share any example code for this part? AFAICS, all the multiple
functions have to do is pass the hazard pointer slot pointer between the
functions, which they have to do anyway to know which slot is in use. You have
to do that in all cases, no whatever what kind of memory the slots are in right?

> 
>>>
>>>>> ... By the way I wanted to emphasize my PoV, that requiring storage
>>>>> provided by the user seems to negate one of the big benefits of hazard
>>>>> pointers I think. Unless there is a solid use case for it, we should
>>>>> probably not require the user to provide separate storage IMHO (or make
>>>>> allocation internal to the api as I mentioned).
>>>> I think the solution I have in mind takes care of the negative aspects
>>>> of preallocation requirement. Here is how it would be used (see
>>>> [1] for the current prototype). The "backup slot" is within the
>>>> struct hazptr_ctx, so from a user perspective, it's under the hood.
>>>>
>>>> The user just has to provide a context variable on its stack.
>>>>
>>>> (untested example below)
>>>>
>>>> void *ptr;
>>>>
>>>> void fct(void)
>>>> {
>>>>    struct hazptr_ctx ctx;
>>>>    void *addr;
>>>>
>>>>    addr = hazptr_load_try_protect(&ctx, &ptr);
>>>>    if (!addr)
>>>>        return;
>>>>    [critical section]
>>>>    hazptr_release(&ctx, addr);
>>>
>>> Correct me if I am wrong but I am not seeing why stack ctx is required if ctx
>>> and any space required can be placed in the task struct (and hidden from the
>>> user). For interrupts, we can just use per cpu storage split by context like
>>> qspinlock does, I think (unless we are going with the wild card proposals).
>>
>> Oh, I missed the chances of different threads requiring protection of
>> different types. Maybe it will work if hazard pointer sections cannot be
>> nested. Or we can wildcard them or something on preemption.
> 
> Nesting of hazard pointer users (even within the same thread or irq
> stack) is my main concern here.
Sure, as we chatted briefly on IRC, if we have the slots in task_struct itself,
then that takes care of nesting as well. But I could be missing your usecase.
Either way, I will implement something like that with per-task-struct slots and
let you and everyone know how it goes.

FWIW, I am currently testing out the context-switch benchmark on the following
machine in our lab:

Vendor ID:                   GenuineIntel
  Model name:                Intel(R) Xeon(R) Platinum 8352Y CPU @ 2.20GHz
    CPU family:              6
    Model:                   106
    Thread(s) per core:      2
    Core(s) per socket:      32
    Socket(s):               2

I had no luck reproducing this on a single-socket, so I am trying a dual socket.
I could not get the exact AMD machine that I saw the reported improvements were
collected with.

 - Joel


