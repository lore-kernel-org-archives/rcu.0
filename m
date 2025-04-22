Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C275242D6B;
	Tue, 22 Apr 2025 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362583; cv=fail; b=UH8Om8wcHanpr/NWqccJxYUovQBX5DY1u4dIMqgm+zGcgB3CmiwU0oPueWxVCYe5dg3CGhAcSf8Ug0/QP2J1tCG5XYLWEDU5fk/HPXtW4TioIAmjZr0tKgHlWJB48jhuBMURAl6Pm5x9QwkPE4OhCdaN1I5fa59l5I0jE9ZAZys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362583; c=relaxed/simple;
	bh=rcOGsKjmEbVFSwAVxc9KW1BPr1a8tbbIcVHCf1NRGuE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krlpSzT2gdVcr3FJgqYzYQuWSahQAbdL7pXZILNoCNzpi4XrDoQgiNdy6ixsQIFke5v//c2X773K/PqTS8D2Pd9OWCTzbd5tuV6C/SlbViS7iswzS7WVnMyfPSC9I8B9pYfmc0saUMXLD42oTpmbP2U3hlP2F5CI8ABlVwFmhNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGC8iBv5; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGC8iBv5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnBW6olN+48TUQLHMKrW6j3ViupIZqyXbLtgO0ql7qpdTDIyUyFxtcuUd5enrj8iSPlS60pt4tvzHw2Sxzn043BHMczbDb2cssLJt7BGAIZWZRlqEgQ9N67zNpbMZkl2BZ3H8bnKJGWeag3WH325xDPrzv9mcyOA1GPWiiB0AieKHX4pC7pw4Ls72cM2HgKUUlthwqPrtZoFwAE/cSSH2r0fWzG47MtIUud5Q0nKlhkjYz4/np/2CmYr1MicmiDDOnIxZJQnYjtcS7YHLDFdOpsPdD3P81fyZlZ8j5J2alno5EH42gxNUzfOsuhww/RKr9E/Uu+IIeSd+H2itSGQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHHCFhEXHfXV7LPalxRQ2KUU71JtAZiXfANN02NVOk0=;
 b=TqrbON5/KwjmmgktlpVUkBgNzyt8N2uv/F8jFrg3WsGeFwh0BL1dRcIe5Q3VyBlp747Vyvkj1Jm0JxBDZ6jj+banldOTSsUobXa92+9NWD4lUQ9qKIargQc/fh2vfeSkgQfgWa6V9tSPbXhPdBUUPcVz5m3RflwE6a73jG2rR4CbRtQAr/VbXI4D3v6zHbF7Bn1hk0/pnwhqhGlsk9Mscec+OIS7cPs6fB1FFpB3sav9sNoDdPoZXBHuI13sTcxXfzFvjzoZyHBtMdO7AYwz0KDyACePUPwCp33vBZYtxSu1trN8MVM0/L9bsxxYOq6XREVWgNouz7zk8ADID7QgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHHCFhEXHfXV7LPalxRQ2KUU71JtAZiXfANN02NVOk0=;
 b=RGC8iBv5moSTco7lNr6PIUS6NX8O6dO5B9Az6V2ED4N1wEVcNtXX3RWlAT0iDIagZeAmKs4lCWJXdtJS1BpZiotPhskesIepspBhQUysXoojUy9vmmARIPEr0KSONzxM70XiI2jaenE+0hNtPKdFwZLlqOfQbhPqlN7yhILTiFJK7jYoY3BZMkEZMx9o4TV4A7uAD6ZVLhCZU93wvThhMnpf0qulSDSZ7aZqnLRSkLzf3EU3f3JMHyS+pO4cJ3b2gz7w/+ukW5rZkVZh/wFZ7P8L9cmJLiHuWRUMD/y9CFaYwnMKlgwJKMOhXQooyqIpR+Z2jYD/S6bjjHPRTpF0SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 22:56:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 22:56:18 +0000
Message-ID: <fd718b41-a812-43a3-973b-b07a1381f062@nvidia.com>
Date: Tue, 22 Apr 2025 18:56:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model/Documentation: Fix SRCU section in
 explanation.txt
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20250422173830.90647-1-urezki@gmail.com>
 <1497ef3c-b1fc-4723-949b-28d92a3afb6b@paulmck-laptop>
 <1a9388fb-83ff-4345-ab2b-6c1825913d71@nvidia.com>
Content-Language: en-US
In-Reply-To: <1a9388fb-83ff-4345-ab2b-6c1825913d71@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:408:e8::35) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afa87d8-c23d-4bb2-cc9e-08dd81f0e492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXdpN1RWMU5GVFZiMnFlcDloWXV4Q2RuZVdOUXk2cERDNldOSGRPMGlZeFg3?=
 =?utf-8?B?SU5hSU1mT0R6TFFlTG5tdnJqMGhDT3hXNDRRbXEyc1dTOHoxRmdCYmQ2WUxj?=
 =?utf-8?B?QzBtUHpsOFdGZ0Q2bXEvZ25ZU2o0WFA4cG5GSWxKZ3NJWEkzbW03Mjk2cVAz?=
 =?utf-8?B?OVY2VnhSbG9yd3hyUDdMNnV3eGI5QnFsazJUNFZTeFYya3V4Wml2VXNVbXM4?=
 =?utf-8?B?SlE1dUpjV2tUMmsvaHEwQXN6RDE2U1EyL1ozQXhXbXFEN0NNVll3YWo1bitz?=
 =?utf-8?B?ODZRSW9iTVU4YWMrZzdjanlWQ1hxOXM0TndwRmtkRWdBbWlNekhKaTAzRndJ?=
 =?utf-8?B?R3FZbHhGU3hXU215NDlVVXdIeWpubkZqV1JRTy8yOUluMkMyOTZrTldWQlh1?=
 =?utf-8?B?SEg1YURPMVAwR0hmNmlkdlFMdTRoVm53WExnMEMwUlFpTjdFei9QZXdFcEs3?=
 =?utf-8?B?RFc1VmpUblJDZ0RwdVpyMUYyY3NXV2grQStHeDNONEdmM2ZPMFQ2SHhGWU1M?=
 =?utf-8?B?Vk1HVThqeHBCTW9DN0V0Kzhxcjh6TVNKc1dEYmZOK2M3cVhHbk9TYXlEdmJI?=
 =?utf-8?B?a1N2ZFplbG5Jczh3RmtSSU5GK255UzR5MVFmSU1FYzlLL0xtZTgyaVlvaWpi?=
 =?utf-8?B?SDMwK21kckZOalphWGE5Z1FhTHRzZFhPMXNWTzBhSjRoM1hza2tEL1BvYm5j?=
 =?utf-8?B?eHpiZGpWYlNuRWozOFg5VzlBY3ppd0VzTHVQdHBZS2cydjZiY3RXd29lNzVR?=
 =?utf-8?B?MGdwTlU3WVJPbkZYeVdQQjlkYmR4QUFKOVd3dEFjblIwVGF1cEsyV0IvMWV1?=
 =?utf-8?B?VndzcndaTFJuRDIzM3I2UzdBSlZJUDVzak1ERnQrdVBoMFRVSFZyMHZmQ2wv?=
 =?utf-8?B?QzFhMHVvakdwcVpqVzhhTzBUTjNNM01aTUczbnpRcXh2Y3oycnBZYlZ4UzAv?=
 =?utf-8?B?Z2g2bGQ2M1BGODhIL1ZlamFxRXFEYnJrdXF5YzJFM1lFMjV2THdBOVZnRjRm?=
 =?utf-8?B?K3RLWVNqQzdJVFpsMUdDTk00dFhwR3lRYVlRYXVmZm5YVytYTDdvUDdDTUpG?=
 =?utf-8?B?UHQrclNPeW8vM0xUNEo4Z2VWWlhVVXhpcFdqYnlSVHl2bFlZbjJLNW1NZDFn?=
 =?utf-8?B?WEpxb0F5RG9WcWVwNVJKQ0F5TnJLQ2l3OUp0NVYwZzZJR0lac09hQ3pBQkIx?=
 =?utf-8?B?SDMzQmRGdWJWVlh1VHNxOWxTZVhCclJmZ0lHK01XSWtzWnVKd09yVmFydW4y?=
 =?utf-8?B?YW50RWprSCs4Z3l4RVBNVjhUVmpLb2NDVXZiT01wbHNTaXBlSmpqc3pKYTFV?=
 =?utf-8?B?Yk14Z0NvMmMrUFVNL00vdEEwSGF1UGlVKzFhbWV3blJCUTJMUW0weWdYL0J6?=
 =?utf-8?B?ZmIrd0VTZU54dG9HZHZoTGJhalhTWWVRZkNxZlJRQSttOG54c2pHa2J0T0Nz?=
 =?utf-8?B?LytUUHk5bEgyN01KUWxSR09ROXE3NUF0eklId1BFay9QQnZFSjhKMXloMkU5?=
 =?utf-8?B?TWVFVEtQcUw3SDFpVXJKS1Y3QWJ3T1RYcXlySk5BZGpHU1lKRURiM1BnK1pR?=
 =?utf-8?B?R3ByS0hRaWc3b1M3NUovOHB4ODFFNUZqdXRDeWpUT2V4QlZYVFBqTkxZTzdk?=
 =?utf-8?B?NjJuck1adzR1TlRObFhmL2FFTzhjMzRoK1d2UjZBa0tHeUVCeXNncVNtM1J0?=
 =?utf-8?B?VGZNbXkzWWJYZy9Tejlsc2d1YlZXMVNEM3lWek1kcE9vcGc0MzcwMU9MYTQy?=
 =?utf-8?B?M1VWVmV4Z29CTHQvNVhTbnpZWDZNclQwd2RGVDZxcEowQU9qL1B0TWJsMHN0?=
 =?utf-8?B?anE2eXlPSVdRb3RvaWxSa1AzdEIzek9KRzllUUhWYW1RblFLb1VrQ0FDTEQr?=
 =?utf-8?B?WHBkc3hST2pjQ1lnTU5YTkp3OU5ReUNMQU5IcGtrR2ZHdkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUJyVjFKd25ZVkRvVkpXSFN1U3VXY25iNnR2ZzZqY3haYlM1UXJ5WTYxTnJ0?=
 =?utf-8?B?TnpCNWp5RFpJa3FCVVhTQ2M3NWovYitNUFpGUWFzZHlJZ1Z4NG95MGU3dVN3?=
 =?utf-8?B?TDR0SmJIdXkzbW5rVXVnMWNHNnNzMlM4Rjk5cXk5U0R6K0tWM2hKa1J5MWgy?=
 =?utf-8?B?VnlTSUwydWZyYWVZZE1FdXFJN09hRkYwYlFtS1FvNU1yV1VNU2Zma0xDbFhB?=
 =?utf-8?B?Vi9HRGdVRUhXVVpPRVVmZENwd2FTWHNHRHdaZlVBamhrRlExSGVJNTM0bUpK?=
 =?utf-8?B?dkw5R3UrQ1VMTmd4Y3hJWlRFZGt4ZVB2VzlWeW1FMi9lV1BCdmdqNmJUaHYy?=
 =?utf-8?B?YS9IV2xuYXVaRzdQVDMwclVTa3FVbXFjNHZrakZma0hNQWxyR3pIWW5ET0dB?=
 =?utf-8?B?bW9JRlJ6R2lMVlhNaFo4UjlBd3RpbmVjNUY1TktkWHlCLzROazhqbmFvV0Y2?=
 =?utf-8?B?MkcwZ2tVNGl0alBER1dCajU4VjFkelR1bm9Qd3R6NzdDVis2YXFXeDJFWm44?=
 =?utf-8?B?bGh4SXBzenpqL0FmaGJyQlpRWE1PeHhKek44ZGNnZkEwVnVmTTdKSW9KTFUw?=
 =?utf-8?B?QzlTRklhdjJDNHNFZmk4NEpWVDRxaElFNm1ramVwNHFSTzdRZDhTWTNjWTFs?=
 =?utf-8?B?UlNrMTBvTHJpWFZldVZqZlpBTUhsUUNTSWRrVlMvSXh5MWhDc3pKNHo1Q0ZK?=
 =?utf-8?B?WkZMSDRiQXpBT2VJeHpoY2g5RGIxZTY4TUpWNUwydEF0bnlCRDFSZXQ0YzB2?=
 =?utf-8?B?aERWdmxOME1uTUpPT3JqR2pqUVlEQlBUb0FoS0VMV21GWEZoVjNJaXFyMmh4?=
 =?utf-8?B?Q1JQaGMwZkVucitaNGF0NlJaYjhGeDZ3anpPUktvdWJTNjNSbStFOGozMCtw?=
 =?utf-8?B?VEpzT0l3eCtvcnF6bUJCWFVmeGRnYzFSdHJ2MlBuZ1RWcGFjVmNMdUlZZVRW?=
 =?utf-8?B?TXkyTnRkNWtOU0R0eTRGZjJFaGNlcDJoQnV0a1pyeWRucW5jSWdyUVI0d1Yv?=
 =?utf-8?B?RmhyQndDQitjUFB0clQ0RUQycGEwK1d3UmRuZVU3cFhOUlEwem5hT3RpZTly?=
 =?utf-8?B?UjRVUFFlYzc4di9YYVVuOE9GVXFzWDVrRFcwbHQyY2RNZ2Q5eFRuTUlSM1VZ?=
 =?utf-8?B?RDJENmJnWVI0RHJtMWlKSW9Cczg1cE5KNmt6WG5EYmtqdkw3U0toZ2M0T2FL?=
 =?utf-8?B?blRnQmM3SHNLdXhIdG4zTFdGZmNJdEVBMjlvTHJ5TTRsUnpiVnU5dnlNZHk1?=
 =?utf-8?B?RWM1Nk5XUEVzMVFvSVZUVko3VG5Wcm4rMEFVeFdteUZoNHdndXNTM1RpNlhK?=
 =?utf-8?B?dzFWTkhyMkk2aU1ZakRON3NFUEluOXJaYkROc0hINGdMam41K3pENGNmOWVn?=
 =?utf-8?B?Zi9KQ0lyNE5Zemh1OGExcWRQQ0UrVkJMeGViYndTdGxRNkdzL2NacFYrUDd0?=
 =?utf-8?B?UGIyVzJELzR5NmhwalhzcXViVVFtYjJseWJDYWxIek5QOEJ6Ym0zdWJkdm1Z?=
 =?utf-8?B?dGN2NU01NGFxdkhZSlVlRWpzVmdWQVBDam9IZEw1bEVDZE1qblRSMGpYRDd5?=
 =?utf-8?B?T1IrT0VtTGY0QkF3NDlsWFlBV3ZOTzNOTlNVZ0RGK1h5S1BsbllEcEdoRHR3?=
 =?utf-8?B?SmtYYUsvclRQcFMrd2VXRE1pRjdNYUFPc1FMS2htWGVJRDhMSU5sMmxSbS9O?=
 =?utf-8?B?a2czM25vYjFGaWQ2cXZXdWY4SkJqQzdwUjVCZkJaNC9DSEtmU2QvN3NEdDlC?=
 =?utf-8?B?a2cvWUMvbUd6Q1dKZXZhS0pwbmV4bi9EUkZNTHQvSzBDaGQ1Z3Q2b3FmWHBJ?=
 =?utf-8?B?Mk5Ebm1haEhrbndYTlUvbUVRbm54ZHNZcWVHbkFaLzMwOWQ5N1dEWkEreHNW?=
 =?utf-8?B?ZUo3UUg0SUU3U2dkZEt3UmNnSDNmdnhjMlBmNXBkRWRBZkI4WG5mVDBVWW1F?=
 =?utf-8?B?c2tiRVFXZTB5dzdFZ1IvZld0R2V3TVJDcUdHa2pTekF5eHExTUlmblpzUXJr?=
 =?utf-8?B?L0c4QU5kV25oRFB0RXVWUlBmaTNkR1Y1SjBNc3Z0Wmx5dTg5eGhRSnJTOC9Y?=
 =?utf-8?B?Qm9kMkhUbXNDQVNlS1BuRVhjL2R5MUpoNWx6dDBRTCtxQWNsNTB4bVpaMWpG?=
 =?utf-8?Q?e6rxrUYIahe4xMTFLz6xeYxl3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afa87d8-c23d-4bb2-cc9e-08dd81f0e492
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 22:56:18.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ooBKt3qKp0D+ILzi4YcM37n6AeRJe+qQ+rn/DoeAa0NgH79rrZMleAtO9iw1pxaIGRst6n1DpQDrN0rO+lzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607



On 4/22/2025 6:55 PM, Joel Fernandes wrote:
> 
> 
> On 4/22/2025 1:56 PM, Paul E. McKenney wrote:
>> On Tue, Apr 22, 2025 at 07:38:30PM +0200, Uladzislau Rezki (Sony) wrote:
>>> The SRCU read-side critical sections describes the difference between
>>> srcu_down_read()/srcu_up_read() and srcu_read_lock()/srcu_read_unlock()
>>> in a way that a last pair must occur on the same CPU.
>>>
>>> This is not true, the srcu_read_unlock() can happen on any CPU, but it
>>> must be performed by the same task that invoked srcu_read_lock().
>>>
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>
>> Good catch!
>>
>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Applied, thanks.
> 

Oops, though this is memory model and not RCU per-se. Paul do you want to take
it or should I? ;)

 - Joel

