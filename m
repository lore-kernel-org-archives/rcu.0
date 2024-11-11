Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC21AAE08;
	Mon, 11 Nov 2024 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346517; cv=fail; b=pUayEy6KImuvsd923tfTjarQcZwSkU67SkFa/bT65POy11shQQiTFbM571x1gEtTf5NikWbmKSB0AF2Q+xrbqECL/qRvx/rBUg+Afv4axwADIxqWKFGQEEUE6n0AyueE07xmApnXgEE42ltaMiEG3Sb3LfP+JQXZTjOGQKV5fDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346517; c=relaxed/simple;
	bh=7XdiREE228ucJwhYHHrys3aH4I3cSlVflvvcN1bBvaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W6on3UT8AZkiY1awNKbWlXQMh7dP6aVpn+dURsI4MGQRYa3C2VePJeRDRaodjP9R4xPw9lcSrwlPwy7b/P8bobrFkq0TMJEpASTq5FEG1JjnNkyF9LwQnxn3ptvD4s8eHfHiE3t0s6yilOqgiNgIEovcq+1UWMsMebzbqmt9CZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QrOMYPG2; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QrOMYPG2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQOQDXTkwwPRYnRogvaMJIQ8HjPbEPuQVMkOo/8Pgi87v51wafM9RrD7B8wKQ9wLLCFHN3iWNf2524NABz3v8DV4I66oVCMiHhnNVMVGaM6jIiyXoADKvyxyIJWLV3cWigDZoK92UEbFbQ8laWELMoTm7kMgP8ttB00EH2Ju5MoF+r6/4VjKbhfNNrPmMchcSkW+foh0SkApsvaYiNh0D/wNpLk6Dj/9cV1NiDyDSJAmHAu9CTpt8uoy4OyHWwzrMZjb0vAvJDg3F8cCrDM6tpny+bBNAC9RDOSYW3vWq8HzqYgWEcX7GuXn4lYa1cicJvUFDBM/FZ5AkbU0arc+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH/m9T2nxyAr/5qGqC7P08BqiEEYVHFgCzRjJsLflEc=;
 b=CJFc5bMEKi7fC/I2fdMHl+1/EnYTvuGgXqOUwzBLZ3c7SqM4d7EA26rJnUc9baaDZVnawwiUjya9NMVCSlXpGv7MQTcSlEu6kFm0XzYGLgPp8nqyCRkVPqJl3fSqGYCdpaLzhZ7nId6H5Ux6TX/t3MslwZM9JPjPPvgIe/EkC/q86h6PR8E/H9DJHbR3sta1ut1aeO1FDZvj1oEsUXUmnLD0IyWtXrIDkuPpM+aIKuQT8VzghLYBwpQciPXr57sR8AbDYV6CJmGnlPHtmqfdivcfk2IANd7RrKOuiBRgAIOlOGQmnO5QRPKcnNtgzwwwvEG7dMu9ewx9+gNA5QWHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH/m9T2nxyAr/5qGqC7P08BqiEEYVHFgCzRjJsLflEc=;
 b=QrOMYPG2rX4ygNn/OnVZ2HZzEEjXKzHjeZ3ehDdJ1bsaFqyFB+FDM8wTOqZxZPS5PZsA9zyVx89VFXHl0XngZHpKa1RLX+N4ASzhCpoxpuIeWBvuKYTrIqSNH2Ab51DqqYW3I9VQMEo6Z0vj8BNwCfT4V51IrNmk6wXk+UxvrMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Mon, 11 Nov 2024 17:35:13 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:35:12 +0000
Message-ID: <48fb8365-ef0b-4fa1-9cc5-758c5705fb1d@amd.com>
Date: Mon, 11 Nov 2024 23:05:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] RCU torture for v6.13
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Uladzislau Rezki <urezki@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
References: <20241106160223.42119-1-frederic@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241106160223.42119-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0053.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::29) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e72021-73c1-4e92-542e-08dd02773262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmY5UkdncTljYmpFTzJkY2dCSS9TVVZzRGl1eCtTMTBodE93cE81ejFkWVgr?=
 =?utf-8?B?L0RPMC90M2drZTdRbndYbjZpWEM2R2prR3U4NkxXKzNjc1YzMHQ5c1AvTTZG?=
 =?utf-8?B?c3NML0pRdFRsR3BLby9BdklDK1BKZWx4eU8xeUJFb0hUTDQ0cm8ydmxhRHBJ?=
 =?utf-8?B?NXdyRE4zRDFlNXIrZEM3SFNMcEJrelRYM2JzZDV0ajUyM2lWRXFBVWRtdlNk?=
 =?utf-8?B?NGN5Vlgzcm9EdEFZQzBKbEl2NjA5ZXJCb3hJQmQ2ZDlVYVFsQTcvemxMb1BM?=
 =?utf-8?B?N3pOYjFnazRsaTg0WFhIVFRoZThwTWYrOG5Ga0ozTm90ZElvdjZ4WGFOdmx5?=
 =?utf-8?B?c0diWFZEejVTRDU1bWhKT25IbGpRTDZnSG5zeEl3U3U2M1lPMnIxeXN6UzYx?=
 =?utf-8?B?dmhsTndESUJURFI5dUxZc2RFNXVKeDdRNVF6YlFBY3h5cTB6eGhuaGJVSlRr?=
 =?utf-8?B?MzVib21NRVpSL2VRYkxHOWpkWTErMlNoNStPc2NQL2ovK0ZZOEg2TW5veHNC?=
 =?utf-8?B?cUNpVFQ1WGN5M2ZPVWQyNlRMTVlFcU9raDdwYWJ0Q0RjMEoyZUdhc3FBcmRJ?=
 =?utf-8?B?K2pLUlVOby81THMwSlcwdWg3bnBEejR5NmFWR3F3YURUcnpNaUs2bUJFUE51?=
 =?utf-8?B?eWtTejIzWG5rODMyUCtSOE5VelNjMkk2dzB1bEhBeGlWRkNSdXJ5SjNGS2JO?=
 =?utf-8?B?UEtyQTdmNWh3eStPQVJ6K0JlSUNKTitIWkpHdEVEeFJrdk9hS0RLNXRzVWdS?=
 =?utf-8?B?b0QrbU1jZFBvazVYRHc2U2NyNUoxMWMwUThwWHIwQWVyT3k1UmZPVCtnNG5r?=
 =?utf-8?B?OFFWcDFGdmxoNHl4ckgrUGdzVEUrOXZNTXRlUmxqemFMa2dJeVJjRkR6aFpO?=
 =?utf-8?B?Q0RUN0cxcW50dGI1NEw5MVZ2U1pNd05OcXZjd2Q5c3B2K1MvU0VJZ1FiZkEv?=
 =?utf-8?B?aE8rRXZxVXYxRll1T2k4dE1nOWxlZTVOaHFOQ3FlSHRnditYUDFiZjR3cHhj?=
 =?utf-8?B?OExFNTFhOHg1SkdNVkhkWi9JNWZGeDBXRm1sbjl6WHVKaWxDMGx3Sm9NL2Z6?=
 =?utf-8?B?enBmeHR5UGpNbW84dEdDOCtXSldja2VIb3RXNDUySXdZQ0FsMnJVWEVRZUdZ?=
 =?utf-8?B?K3ZpTk9WWnpNOUcwb09raWs2V3c1aE5iSFJEN0s4enQwbmcraWxYeVBvY2g0?=
 =?utf-8?B?N3J5aTJ5RUo1VkFyZUtoaGhlTGhuWitmZ3NhTW5xNG1DQVV6Y0RGY29hcmtW?=
 =?utf-8?B?eUtrVElCS3ptOEhWRVpZYkltS3JjMVpaVFVRU1RWeTZ4bThLcUU4NGtNcGJ4?=
 =?utf-8?B?KzJFcUl5ZlZJUTl6WEdrWVdnSm5xenAxZmRxYnVPUjRiajBpVSsrTktDRGZt?=
 =?utf-8?B?ME44Y2dsM1dTOUpCei8rU2pRMGI3WU50c0kyQTRLOElwWW9mTkVXQ2tmSXNj?=
 =?utf-8?B?VGZsUTZtRUVyMWVDSCtHamxwWElJWjJoNzhYdnF6bU1MbjdVeDNiaUJTYlgy?=
 =?utf-8?B?RU93eU04ZCtPNm9rQmZHRHh1dGdPREpkUDd2RWdTTnJ1V1FWOWRBR2cwSHEz?=
 =?utf-8?B?cC9SMDcvSkw2aHI4YXpMUTlkREV6VzRIeVlYcnNLQmlHQmNOWVBUM3BlbGhM?=
 =?utf-8?B?RTVsMGtzcTR3eU1XSHcyVElvYVIvTXF6S0xFdnNaY0Q0b1psNWpadWlwUG5S?=
 =?utf-8?B?L0Q2VTJ1WWhzTnpKVzhmQklOT0VDRnBROFJ4ckJ2NExuMmV1d3RVVWQ2OXFK?=
 =?utf-8?Q?PVCgPECoiqCyD7JTqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEsxZkxKM3JhY3AxKzVYSFNsaDV6eXlqOGJoMnJBak9mbzFDeGJ4SHhoWklP?=
 =?utf-8?B?TkNHMkxpeStET0RZNnErdndURGVkSEEwWHZSMjMrb05KWjlFa04ySHlHWk52?=
 =?utf-8?B?Y242M0t1OUFRYkIyTk9Xak9YT3ZmU0p2VlZCdUlSSC9aNHVLQTg5R3RoaXFY?=
 =?utf-8?B?UTJ2YzhVc2RFSlVPbk9MQlJHdkpFY0V0THVvMll2cDZNd2piTEpvVHlVYklX?=
 =?utf-8?B?emdrSXR1cEZIdUhtSWlDWXRLV1RvMHJLZWh5Q2VOUzh2MlFHMkNxVG1jMGZT?=
 =?utf-8?B?aE1GS0l6cU9ZRlMzTlNZc1ZnTkhTMW11SjBodit2Z1pzYW55RHIzdjlONDZT?=
 =?utf-8?B?UlNiS0hROHlZVEZLQlM5dUZab0dKSzJYTnJlNG84MHdRSUNrWm8xLzNJRHA5?=
 =?utf-8?B?ZnNiOW1jUk0xNTRwUEhwWjVMdmpMSERNd3hhd3gwWXh2M2ttOXBQWkM3NGhD?=
 =?utf-8?B?M2Zvb0N6ZCtTOHNhQ2pxMi9JbU9ZSzFBMERzZUxIeDZKNWRySEs2NE91c1c5?=
 =?utf-8?B?cjY3dlFYcDlhOFk1MDVtMTFqNFFmL0NjWEQrdmpZVkRydHp5am9zVDZtTk0r?=
 =?utf-8?B?U1V2TW5ZdENicG5udVd3cSt6THJtUlVHZmVVZjJWU1poSTZlSUpXNEhGbDBJ?=
 =?utf-8?B?NVlydVJndEthVmlHaUFFbFNSMEV1WFZiM0JXY1dJbG1OZGs2MjZEMlJCNkdE?=
 =?utf-8?B?QWQrcXhGQjd4R056T29JUVJraENnbHM0SlE1Y0N2WUFSekNUQkE0eXF3djNr?=
 =?utf-8?B?ekFBVDkyQW0wcFRWclRKWDRmVkR1YkRMT01iNXRkMlFTRzd4b0FxSWxJLzFv?=
 =?utf-8?B?YzJiM3pWZHNVMlRmeDVLNlk3RnlEN08zYU1selpEWmwycUVKN2pUSUpBSmpN?=
 =?utf-8?B?c28zakJ6N3hDZ1FNQ1VFc0NHT3dYMWoweWhkWjUyMURDVFF4Mml2SXFpZSs3?=
 =?utf-8?B?TjNYbDRaNWZxalVMVU80MXNRbm0ySUIzMFFUc2dCZW9RT0tWWW1OYXdIZ2p1?=
 =?utf-8?B?ck5zSHU3azBtV3B5UzgwSWVjWllLTVd2TXZjczIwQ0tJZU1WVThhNVJWOURX?=
 =?utf-8?B?WmpzN0xwZlZGZEdhSmJrZVB5YmROL29tZjVZd3NsMmdibGg0WExLWDhjbzRN?=
 =?utf-8?B?eElycU1lWjNhci93Y2VCeDJicU4vQ3pzM2Ewb3pBb1BxcDhLUVRYTk14cmtl?=
 =?utf-8?B?STU4OFBlQ3JFUkJxTVowK3dOOG5LMGVXWjBaSmFzWk15QllNUGt0RGIzaTRU?=
 =?utf-8?B?ODIrdkpUQzNubTdMMlFVZXZIMFlKNm95d0d0ZzlSQldSWFdab3Q3SGJHNm1W?=
 =?utf-8?B?eDJtMlJJNDhVZWp0d1A0bGlJOENDVFlPRkNsVm5objdXNkNTU1NxMWFyUDgv?=
 =?utf-8?B?NEh3TWRROFNpTGpiSWI0YjJOY3RacUJob3Z3aTA0UjdNOXcyT1Fta2JsV3VJ?=
 =?utf-8?B?UXlPVlZVWjI5YnAwSS85Z0crWkkrTnBiRzlXYWpkaHQ4eHRwa3RvZ1VvOVJr?=
 =?utf-8?B?dHlBTVBuVmZ3MTBPQUdaTW4zam5zM3RhRldvVTVKcGNXZEN1bmxIOEd0aGI2?=
 =?utf-8?B?RzVsamd3dzdZRVVRVWN2S3NmUWtZZlZQL042VnhIM0ZjSmlYY1ZOczBxbHVF?=
 =?utf-8?B?Y2IvQ3VPOTZyVUU4dnk1bUpqM3lGYnlJdlp0RG5jVDhnaktiV2xqaHZDQzdm?=
 =?utf-8?B?eGF0WHRQK2s1SThnRTRMVncxc3R2YXIra05GUk5MNjBxUlNHSjA0RDFvWHpp?=
 =?utf-8?B?QjRUZWJVSmZtQXNiNEFqNlBNZHFRY0s3QVRWWUVlc2J4T2dEYjdDdVlKc3FX?=
 =?utf-8?B?MzVRUFNtRTlVeWVxSFBISC93VzFIMVlwU3dtWDhjMXdQaEtYNHc4bUNlMy9s?=
 =?utf-8?B?WmpleDJQdngwUDNESjhhdnN4cG9IVG1VcDFwaGJYU0YxaFkxc0oyS0FyRHdT?=
 =?utf-8?B?TnUrbDZlblNJTWYzVFF6NTQ3ZDNodDMvWjhJcmRZZUNLbHZJT3I3VHg4dDkr?=
 =?utf-8?B?VWdjTlpHbEVYSHhieTVIR2NWb1RjK2t2NlNidmthR292TWUzaDlZMG5QRFdn?=
 =?utf-8?B?VHkweGZrekgwWjZyUG1IdGFJV3BKaDJsWC9teDhHeWlpbXBqN3ZRbHcvNkVt?=
 =?utf-8?Q?VFwBa3+2fX2b5DVgo7WO2F86a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e72021-73c1-4e92-542e-08dd02773262
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:35:12.7595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GE2szL6Oh5OPeJ4v/XTWtABRUeWFMYbiTsvHbbCV6SZJzaLxm2Oxh4UeKg1H+QAn5V3Dw4ZgFSK4npk2sOkVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036

On 11/6/2024 9:32 PM, Frederic Weisbecker wrote:
> Hello,
> 
> Please find below the RCU NOCB patches targeted for the upcoming
> merge window.
> 
> Paul E. McKenney (4):
>   torture: Add --no-affinity parameter to kvm.sh
>   refscale: Correct affinity check
>   rcuscale: Add guest_os_delay module parameter
>   rcutorture: Avoid printing cpu=-1 for no-fault RCU boost failure
> 
> Uladzislau Rezki (Sony) (2):
>   rcuscale: Do a proper cleanup if kfree_scale_init() fails
>   rcuscale: Remove redundant WARN_ON_ONCE() splat
> 
>  kernel/rcu/rcuscale.c                         |  6 +--
>  kernel/rcu/rcutorture.c                       |  9 +++-
>  kernel/rcu/refscale.c                         | 19 +++++++-
>  .../rcutorture/bin/kvm-test-1-run-batch.sh    | 43 ++++++++++---------
>  tools/testing/selftests/rcutorture/bin/kvm.sh |  6 +++
>  5 files changed, 56 insertions(+), 27 deletions(-)
> 
> Thanks.

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj

