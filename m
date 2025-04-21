Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4ED1E5B9C;
	Mon, 21 Apr 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745258008; cv=fail; b=XZP4H4pMH3qh5VS/niuOlE/klerAWvOmpdK3m23QE/U2uoxKIqGjWqYaCglDcltAtQEqzwHH5j2Xq9iumjUbhcFeJpRb8ZiMBnAoVvm8GnZpnuJ4tmCa+02MMhsspRmS169Un6+QKH8g+H0myPThwTmwnnZoBR7kx+f9UuZTaUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745258008; c=relaxed/simple;
	bh=CiwTxWqjjuXcqam9aTgL3iEdYt2TuK1tSAb3AOsBoHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4C9k/gtUg7LFihTgoOqdvTIVKVZ+u2qZxvu3YfRGGZF5W1f2/fVQrwuXEHjWQeoOSAAgDYnZyHBXW8vproGcUm8dUerM0KMnfawY7omU++KG+2MmyP7eEpZLp9n0ku88NvFK97sWyU5IZ46LcVLV82fd30Pn4yNkiksqXUJwXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hs+/uzUc; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hs+/uzUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAIUgx4IfQWyNnlkyT1nO1ig86d1tIOvjMwWNha7/xTcrqwRrwi1qiuTwp7g7UL6GIC+jmpHRNECtJtORLD+0IpX3K3zIlK7sZZyv0JTdCMfPywaMVgKPSfrbLLsV/fQ57JFxwJMCxP0/VBZPk4EtXVmvCH20ZgRFo3zae5SrQ29O8HHLmEITCo8IWc4atyU1jwzml0IcNbpkynBvy/9IfwsLyIg5sCkTs14nH5QW4uFf1NvZtueujWBSsfBLpZ9ljbAFYPD/8rvJabbAAS2KeTiqvv73rumWhe0bYLGSAenQ2Hd2SpcWrmVGEbjlXr7Xe8sjU+WqtHPbfitYBESUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyRH6823h20mjjiCd4kwc0YIH5epcrh5suHGh4PGbtw=;
 b=fsFqKv/OZl3U22BWVF3HDj7Hnru9nmf/rg50aCyFXYsoNFnccmqlwKQLOjb7vlbyJiqI0idGI879p1PdXpd9MOkwgBQpRDeQhInSrT1C1muRtn9ZoNIOc8WjHuQkB7FMGPwQOUOsCIXprH91iYn1Xet5NHzW/7TIZXwrVIBsCWiiidEtlUkENdQDDYGR37n4ej7XxgB+NzPi0il8nj0AWT/NcKRvQ3JLOe8ZoG1MaA8StBJrIQfr/ehHIg2AD9SVg41c9nOZ+PT1OcbqCG01Mrc88hEEvdOw0VehOJtww0u3+5aUQtQeOd3tGvhOLv0bYWLE1hsVpqt/8EJOegqOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyRH6823h20mjjiCd4kwc0YIH5epcrh5suHGh4PGbtw=;
 b=Hs+/uzUcMBiWFt+MRKqqN0jvZG1FCrV+JCh4sE9V2HGdFzdht6dDLv3d+2J4yECDw45/CpC5Ns63Fi44wxsLb9Q/YWydWZVllSH/9qpEGX7cS8U6OmN2sNQ/vVAvsE3uO5/x2Qov/dV9Arf3xowplxHXfxtwZ9WKDnM5pWoRQ78OpFnxePxifVJ6+C7Vhe8RSfHSjUlaAya73QzaCWXHRFdaUrpi8CnFLuaBZQVZRj5RZWm0PFO+65Wwq2aD8JURNPk3hVWL3kqfvRXmD9hGN9/vV0dBI9R9JImqUdVANmfkQNSf4NvdfkWztlfZn2PrwuKDgg705DozmASd+FagXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY1PR12MB9652.namprd12.prod.outlook.com (2603:10b6:930:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 17:53:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 17:53:20 +0000
Message-ID: <cdc20491-a0a8-4dfd-9326-797bb0de0f90@nvidia.com>
Date: Mon, 21 Apr 2025 13:53:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] rcutorture: Perform more frequent testing of ->gpwrap
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250421174717.3332525-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250421174717.3332525-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF0001640D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY1PR12MB9652:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdbb566-6249-4481-51e7-08dd80fd6750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9WVm0zTXVRTFNpY1VrQjc4T2NoSkJsbThYQ2w5OWFmUnV6L0xwNzgwaEJu?=
 =?utf-8?B?MVk4MzJSVnowaUVnYjAyTjhNd1hYS1N3R09XbWNTcjZBVm1XM2ZQdFdaUHNY?=
 =?utf-8?B?N1grSjZDeldTbnBvYm4vUVl4OWwzTENIYXdMTGpxQnkvdzBsc3luMmFVUGg3?=
 =?utf-8?B?WE40SVhlQktJQkR4SWFGN1Z4VDNJcUk1WkUwYjJpT1RGRUYvVWVzY0xsODdk?=
 =?utf-8?B?S0RJSVhpdmxEQ1AzOHp6eVdFVjFZbWZlNmpwdFByUjU3MEsxQWVXcm5xK2hi?=
 =?utf-8?B?eEUzS25peWJlekxSb3NzSVIyTHhJeEtwa1RnMldERFpPMVBtVXdpRHg2WFJt?=
 =?utf-8?B?UTU1alg2NDJ3SWpiZElmdVFMZ25WaEZDWnE2VGNha2pmOTgySGJ4OWhuM083?=
 =?utf-8?B?RVBDWjhGdm1XWnd1NnVBV1M0QlJlQ2ZtWGNGVEYvZlhIK0ZsdjZmTWF5OExF?=
 =?utf-8?B?bXEzb1F4Z1NyaERmc2Nyd0xXT1JyM3ZTUDdQNjd0V0VvSndvektmbjVtc1RG?=
 =?utf-8?B?TjFCdEVTa3VtSEcyUmVMUUZJRFQ2dVVPQXREZDNSUEdwUzNqSU1EK0NSQldV?=
 =?utf-8?B?YncwSVRtZFZvekNzM0RtczRsTWN6VkNHZ0dpVzErU1RFRlFQWDZtOGFndklP?=
 =?utf-8?B?dTFIV09GMjJySFVpR1o2aVZENG5OSW5qUU9IeWgrWkdhRi9LcCtVd0p0enl6?=
 =?utf-8?B?R3hXb0xzRWFIWFFwbHRXVVk5b3VoRVRqNW9QMjJORTcvRmlRaysvQzgzSVI4?=
 =?utf-8?B?VUlOS0pLVW1YZTVNUkFVdkJvN0MwejNPcEZYMDdjTmdyMjNxY0I0RE5OSWox?=
 =?utf-8?B?cUVHSzdGdHdsNmswM3Yyc0VONWIrdjg1RmxqQzJvWnJjUmJsbC93SGgxc3R1?=
 =?utf-8?B?ZkQ0dVYwaTNYNGZBRmFWSUJwc2VkQVpidVB4TVE4YTRhVWtYM0o4NnVxeHU2?=
 =?utf-8?B?ZVA2ZWJ3cWdsRGhqNWtSaDZZSU9lSlBkLzBBS0FFWHR1M0dPRXllTzVEVFlu?=
 =?utf-8?B?RUZqV2dvdjZSWUJvMnlqbGpTckVzcVIyK1hFYVQzN1NiNmhoOCs4OS8vRi9q?=
 =?utf-8?B?S0hKd2pMVkJwMHBDQlQ0WTMwNnlaMURmQmVtYmJZaTczOUJUUnNnOExkdVQv?=
 =?utf-8?B?M0h0QWt6TWk3Qm9meGIrUFkvZ2J4emovWFRsM1ZMNE52eW53Tkx1Y2lVaWkx?=
 =?utf-8?B?OEtQSUNxcmZRR3NsZHpuWkpyckg2M21jUDdMR2Nxc3lNSHJzSmpSZUxnNFU1?=
 =?utf-8?B?bVp5Mm9Ca0Q4WWx5UG9aQ282ME9kVGNxT3VJRUMzYlE4MnFXNTNhUk1TeW5R?=
 =?utf-8?B?cURyL3RORW1MUEtjdTVjdzhHc0c5WThpR1NsOEFuS1JDeFlpY21LcVFsNlVh?=
 =?utf-8?B?WWx3TmFCZE1ZcHZUZHVtZGcza3dHOHdRVVRSbHh2bXZYRFpvSnBtd0JZNUZr?=
 =?utf-8?B?VnYwMzE3NXBiQ2tmbWdvT3duaVFqL0tGVzhLd2VraHV4VXBsQllyeHJpNHlZ?=
 =?utf-8?B?aVA0V0U2UFZHZnNsTEZ6QmFFTnpGb2RmeWE1UTNLSnRyTk0wN0RvWWYvUDIx?=
 =?utf-8?B?V2NINkR0TEE4cHBaR2k4K3RTdWY1VHY5eE9ZS1M4dVJoK3E1VWlLRzRlZnlQ?=
 =?utf-8?B?Q1FqdU1XbklMdllkV05tZzZzdk54ejByamQ3QjVhaXh4YzNBTUp3WmlrUGVv?=
 =?utf-8?B?SzBEcEZrTDdseHNDMGJJNUtJdGtTL3A0dWw2RGtsVW9jdmppL2ljVzhRTHRG?=
 =?utf-8?B?SFlja0Q3K2phV1pNZnIxUURocTI5TVdkT2dNQ2V1a0NTK2h6M1dwazdIYjg3?=
 =?utf-8?B?S0wvQzVyYUZGVFBuQ3padnB0S3d1djhQWHQvamY0a2NwQmIvVlVwT0hqZTdt?=
 =?utf-8?B?b090UjB1SFg5QTE3aTl4dDhtUjErUmd1S3VFakJHRDZtck84SENqYXhCMVd6?=
 =?utf-8?B?YU8rSlBWcEVWRmJmODlzRm9WU1RCMi9ySkZhWWZveW5zdGxKMElzUlNYdWtt?=
 =?utf-8?B?ZXdVTWl2TGFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTVKY0xMRU9qZHdDUStFL2MwWk9kVGdITFBndS9rcHlrSTVMRllQNjd5Ym1F?=
 =?utf-8?B?cWlKVFFRM2hmMGN4NkpJSWxGRExuYytKbGV5U0hQSEZ5TWg1YmlnZktJWmU1?=
 =?utf-8?B?cHg5cTVCUEM4WVFOVkhQeThPSkowZTdHUkhvc0wveGtmODkzYmY2cloxQm5p?=
 =?utf-8?B?Yy83VE1tS2Nua3k0WU40V1BEYlNJRVFpNnViWVUwRzJTekEvVTNmSmdhYkxW?=
 =?utf-8?B?YUtBaUZqVVJIbnRoRmpuaFJZN3JZbWtYY0xJazcyUkhNVFliMGtPNG9DUER3?=
 =?utf-8?B?RmUxUG1WYVpSYktZVmdJN2p2bmpBUlorWTZ1TEU2NWc5eEcrY0E5NzhzS05q?=
 =?utf-8?B?VlFKSFlDb09QZ3dpRHlEb01SSTBYcFpGeFJJN1VxNmp2WjRJSzhmVms0SHNE?=
 =?utf-8?B?ZUZRendGeGJ2S3ZuWUxrazVEU3ROOXB4N3JCYUo2VnZvMGxKaEp0TWFSSURr?=
 =?utf-8?B?Y1hPaDVFQ1NnWTZYWE5vcUdkcW04eUo3cDl4Tzk1RmdKZ1k3UDdjSmp4cEJo?=
 =?utf-8?B?eis5c0VXWklxamx5enlGVlJlQzQ0T2srVVd3Y204eXJUcHBnNGM3T1pkODhw?=
 =?utf-8?B?eGxqYUlvdVlRVWo0L2VkUnlzb0RxVEVPZS83S1pVblQrQ1BBSlJybzc1aU92?=
 =?utf-8?B?OGxuWUd3bk9OWndPMUxnNm9tZVl4NEdzUkhUWThJMkNhRjRBUllsakIxTFFo?=
 =?utf-8?B?WWxPcWdhSlRDMU5tRnBBeG01RlQxR3R3VXBjcTJ3cU0vTFN0ZzFKWWhtSlRU?=
 =?utf-8?B?THZoZFUwejIwSSs4TmVxelppL0w2VHlacDVKaWh2cUowRkV4SVliLzBJdFkv?=
 =?utf-8?B?L2dvUEhxM08vTEJLSHo3dW1aakw5WjFsZ3JuTjRsVWZYMGdWL25vWTIzclZz?=
 =?utf-8?B?T3RTcG5OK2w4VEFEdVkzcDdndGJ6ak1zZXNMWWFFdXJxeGE5K2hlOGJWcklS?=
 =?utf-8?B?bnJleU9oQmYwWlpyTVRVQWdQcVV2azJaVEVUVEN3c2l0cTV2Z3c1SFAvdzhG?=
 =?utf-8?B?Q3BUS2lXVHk2OWsyTHkrQm4zcHNnNkNVekhEQk0wcEFYSHo5THF5dkRXOTZT?=
 =?utf-8?B?SGNVMkZLTk9KTzVCNGp5WmNoWDFqWGNBMk9QMVBMMWZ4L0Ewd3F3SE4zM2NC?=
 =?utf-8?B?TFFnZGVVK042VlRxQi9MenN4K0lQZ2ZpS3FxcXZjQm1WWmZYR1hqcURmaDNY?=
 =?utf-8?B?c0trenBqVEwyZWttRGlzUktoRDNPM01MMVl5VHB5ZmVUVXROOUFPamRMUjRz?=
 =?utf-8?B?L1Fzb3Zoc2htKzBQQVBoaU9ONS9DYlI4ZXNJN28rTWJvSXhCYlRXQUpPanZZ?=
 =?utf-8?B?SkJ2R0x0K08zbUpjTjRUd3FSUmMxUFNoR3Z5aUdGTmNKdXBORnk4KzFOckRL?=
 =?utf-8?B?TVFMeGxRVUwwcGs1cnVwYWVhejBxQ2JwQllyL2VSSTdkTm9OQitmenIzbkpQ?=
 =?utf-8?B?Zks1VU9xLzlqZlY0dVJ3ai9HeWRmWm44b2o2QytjS1FCdzV0QndyQUJsZnov?=
 =?utf-8?B?UWRKMUp3STR1cUdKWjFURGljaXFGbkdleXJiVWlEYUxTSkdRQ0Nvc3RXSFdW?=
 =?utf-8?B?VTJWR1NJNjVXbUFVdXltK3JhVlJyZnVrcmEyMHllYXU0Uk9iTTQ3Q1kvbit5?=
 =?utf-8?B?NitBKzZYeEdqSlJZNGpYVVJZaVNQQTRGM29oVzBVeFpxczJrNUxoMEVBTkEv?=
 =?utf-8?B?YnNVVjluR2ZDNFlPTlhzbXcwSDNQOUFoYXZZc3VWV1FDWnhoZW1CcXYwRXpq?=
 =?utf-8?B?ODIySE9LMFVmUngxVG4rWmdMUStSb3FZSitvaXBENHh3ak1tN0NKWGpHaEZC?=
 =?utf-8?B?eEoxcmwzUGFWVjdZUFViV3hnMzRmdTNka2FlTWJFbE01R0lOckRTeXpwVU5i?=
 =?utf-8?B?OUFiZ3psRkVGNUFEL2dKSWF3VUFEY0dZbVg1NG5UaHExdmloT3E2Y3NiUTU0?=
 =?utf-8?B?UENubkNtQkppblQ5VHdPMGpVYkQ0Q0RKR09UdXRtU1FZUzVyTm80bi9KazhU?=
 =?utf-8?B?YjdyOUhFUERvZVh1WXo5RTc4UkRQbHVtcFk4UUQzbkhNa1hjeWxsa1loL1lI?=
 =?utf-8?B?ZTk3MDM4bzZUSkdJT2xhUkNKcng1bENUZ3lqNzVkaVE4aHZYa0pRTWduNzg1?=
 =?utf-8?B?L0ZPNy9MckFMMmx1Mk95RDlqNDZyUXkvWGNMZW5mQnBKR2FMcnV3Snh0ZlFB?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdbb566-6249-4481-51e7-08dd80fd6750
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:53:20.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m0rvEYWc4/4s9ZlpGWbzWPzNndcjLfSMfDrPKDeJn7El/TfXvTQGWVFMQQTDMqceIbOFRDKJhgjVJQqNj+f4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9652



On 4/21/2025 1:47 PM, Joel Fernandes wrote:
> Currently, the ->gpwrap is not tested (at all per my testing) due to the
> requirement of a large delta between a CPU's rdp->gp_seq and its node's
> rnp->gpseq.
> 
> This results in no testing of ->gpwrap being set. This patch by default
> adds 5 minutes of testing with ->gpwrap forced by lowering the delta
> between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
> configurable, including the active time for the setting and a full
> testing cycle.
> 
> By default, the first 25 minutes of a test will have the _default_
> behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
> we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
> this is reasonable since we at least add a little bit of testing for
> usecases where ->gpwrap is set.
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
> v4->v5
>  - Added gpwrap_lag torture param to turn off entire test.
>  - replaced references to 'ovf' with 'gpwrap lag'.
> 
> Will move this to my rcu/torture-for-6.16 and update my rcu/for-next branches.
>  
>  .../admin-guide/kernel-parameters.txt         |  5 ++
>  kernel/rcu/rcu.h                              |  4 ++
>  kernel/rcu/rcutorture.c                       | 72 ++++++++++++++++++-
>  kernel/rcu/tree.c                             | 34 ++++++++-
>  kernel/rcu/tree.h                             |  1 +
>  5 files changed, 113 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 76e538c77e31..e1d11b6595fd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5657,6 +5657,11 @@
>  			are zero, rcutorture acts as if is interpreted
>  			they are all non-zero.
>  
> +	rcutorture.gpwrap_lag= [KNL]
> +			Enable grace-period wrap lag testing. Setting
> +			to false prevents the gpwrap lag test from
> +			running.
> +
FYI, I added docs for the additional params here as well:


+       rcutorture.gpwrap_lag= [KNL]
+                       Enable grace-period wrap lag testing. Setting
+                       to false prevents the gpwrap lag test from
+                       running.
+
+       rcutorture.gpwrap_lag_gps= [KNL]
+                       Set the value for grace-period wrap lag during
+                       active lag testing periods. This controls how many
+                       grace periods differences we tolerate between
+                       rdp and rnp's gp_seq before setting overflow flag.
+
+       rcutorture.gpwrap_lag_cycle_mins= [KNL]
+                       Set the total cycle duration for gpwrap lag
+                       testing in minutes. This is the total time for
+                       one complete cycle of active and inactive
+                       testing periods. Default is 30 minutes.
+
+       rcutorture.gpwrap_lag_active_mins= [KNL]
+                       Set the duration for which gpwrap lag is active
+                       within each cycle, in minutes. During this time,
+                       the grace-period wrap lag will be set to the
+                       value specified by gpwrap_lag_gps. Default is
+                       5 minutes.
+


Will push this to my rcu/torture-for-6.16 and also update my rcu/for-next branch.

 - Joel


