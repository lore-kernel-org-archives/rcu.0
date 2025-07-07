Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8DC2D8DAE;
	Mon,  7 Jul 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898484; cv=fail; b=ILODhed+VwzWUmLH9X6ZsE21cCif4728dUVcUcWqAhEyMi7vkOFy4Azz92ODRqye3P8IzK3ymxjMUtHlJqhOq+NrUsqMNLN3WYipQ1mHgI77iOQLps+MHPM1xPWhwgZa9a9y1WyU94Q0lp6LtNrXJ65+EydiUA/bVhQFmuxhTro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898484; c=relaxed/simple;
	bh=wJLq41IoUhONL/az4bo3tbM93E2d1GRcD3nNSxTCdwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXKaYeoqL3W5AJhoU0GjuVSwOTdzyFDzCVSB26xV5A0M0QLef03Q6P8gvB5y6fe7t/hRYqxxa8wWeR7Io29Nq5KQINKRbMSNnySCd+p3bmurgscA9FuG0H7ZhbV34x5Pl1H7YmSO1drViJXozdh2+DxtfdEP6NwGxEYhSdu42L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jJspRIqL; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jJspRIqL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6/QPYLnlKy6pANdeSitiCY4W6gYEvc/yfp0B8DsFrNVXOO6OK/yjbnw+hbHs9iyIc/GZ0Iei9ClqCNM+T8Eibpn/SJa9IuqC3lcIzOFE6yjofhjqSckCXsUdX3+EwhS+JaPQ+UkvqKGDhDlTRwRiAa2PZh2RhEJXcvjrGs8jhe0maHs2o0emse5o7Mgcd8aK/uT+ZKP/17GGFSjMMa9U1+LeqXJ2NqcRuchE2yxu8DQ4i73yayRM/opfBPmzau2258RWRNP8vjDSW95Bgx5IF3N7fSDar2mbz+xncHkpyH43nxGs/o5Yz3qvn85J7CjzF0OO3TiDJ3QTHn9qe7fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFG5nqK33DCZmzqd5zQC3aPYpA42C3sMBAq5PRMFxzM=;
 b=cGKztBSxUq9URFgN3IU+LXT0HJOnwtTxjSoFVeyQx/8fWzMloidmOHA5si/03sYWpSW0IgSjBEL1cm3TZVJWDTGDTm9gyM6HyTIAmeCuepPgK2s1maikaRVis0IzqxKH8D/gUqpi8+3sBpXTs7/SSp8G7AToIf5AYB5aBOA3lcIOjG9hYLENTaECOnPj7uH/U260rZiuS3F6VBBAmKvOQhnW0l2HSYAdvIHYf4oC07vTiMbxVGbCb3VsyHwvTDu9E9Slllwx3vPMQMH3wVrDoO11Unl8byUr+rOQ8ZHqGwQ9h4NqtSaY+cbbDtm4rpq289/tiIqTFh0Tazkp05icEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFG5nqK33DCZmzqd5zQC3aPYpA42C3sMBAq5PRMFxzM=;
 b=jJspRIqL+0PJ0u7aIPoin3EXqZs/Ga9IDqvtHymCCWP9mC2J9c+o6aUaI0bmVPH6qJ4wYkv3+ZsnuE2Rqs8kIsUpsVxK3VfYXeNDNM+dMnpwrJFx1vB6pIWFbVnhVSEQvrZgKQPVqPaGjRWauulOHwh977dZwAs+VKm48BXcrB1YzwMW288OCEleS5qjV04fviUj9KPJF96hl+0HpEyzbsTA30V2IE4/sgb3crTN4t4FkRfcZsIhO3CQBruBeU/ZpNOZRpGBzfWZOSnfUriLiqdVYqQKnuUtTsl10LQh3MN/W29DKuti+16ecM999yvxhuXlfgxGnxtPuTZ7q7mvBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Mon, 7 Jul
 2025 14:27:58 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 14:27:58 +0000
Message-ID: <21a8edb5-c0b8-4249-b31c-4c9cf080609a@nvidia.com>
Date: Mon, 7 Jul 2025 10:27:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Document concurrent quiescent state reporting for
 offline CPUs
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250707033208.361677-1-joelagnelf@nvidia.com>
 <aGvYEFikpNdX-lGE@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aGvYEFikpNdX-lGE@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe1f693-c576-4cf8-f7c2-08ddbd627899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2hKWFdsdHJJTDUxQkNBd2lGZlB2bEJjY285TXBSbVZ5NlR4aHVVT01mS2cw?=
 =?utf-8?B?MVlmQnRKczNqdGRzL0QyRUpSV3UvWnVMNWNzWFM3MWtJamhneC9iYVdOayt3?=
 =?utf-8?B?Y21lQkd6NVZnUUMzaTZyWFJWM2NsN1VFOGdJUEtyU2JUbEhvcWZqTnc2OTRt?=
 =?utf-8?B?YUF5MSsxWVRyQnN4bms5QVdyUWRCMmRCa1RvVHVqUzJldHRDRHhqaVRqbnlD?=
 =?utf-8?B?NFVxK3ZWZWYrdEZIUHU0RVlzVEVtaG5mMTIzMUprWjdCSXlydmMrdnpzUUU5?=
 =?utf-8?B?ZlVtYmxSM2RqK1RvOTh5R2hwRXMySndzREhibkZUT1Y0U0hmQmVmb1lRMlEr?=
 =?utf-8?B?YnlqVXNTLzJBT1lvZ1dnTmFiSHJvd1dicFNEem5EUVhFRFNFLy9pWHlIVVJx?=
 =?utf-8?B?VlR1MHhTdUEwcnNnUFBEWXExbS9qU0N3eDhXVmFYUnptWXdGVUh6WXI4UWV4?=
 =?utf-8?B?d0FqbXpUSHE2SmhLazBzZmhpaVdPa2dKUURyd0pXZWNwb2dkSE1URS9YbXky?=
 =?utf-8?B?WjMxSUlTZVBQV01uYVV2clVxTHVkbW1KTjZ0U3FBZEhTd1M4Wm9tYXAya0tz?=
 =?utf-8?B?VW9aYy9SVXRwL1pzRzBpTU5QaW5Ld3JxMjdib1BuMHRpNkUwcUt0ZFpsbXNF?=
 =?utf-8?B?Mld1aS9kbk41dmJHRlowRXVyV0lzM2dUZjhrK0F5UWxWVjZpYTk5LzdzM1lh?=
 =?utf-8?B?MU5TNGdXN1ZUU1RCTXRKQmNVN0IyOXZwdUlucjlnVlZhTWZVTVBabzdORmVU?=
 =?utf-8?B?NHdNVEJOOXdKaExpSnlYTkE4VnFBRzZndUxlbVNwRkJRZnBVL2x6THVMcG1C?=
 =?utf-8?B?eDJZU1JPQXlkMUZleHdMT1ZpdnFmVnRKVXlPakkzZ3NDa2YvZ1IxSEE1RjdJ?=
 =?utf-8?B?WHRKbEw0bi94Q2Y2NGt4VVlJbmM3b1IxNFhTVTc5Q25lWDVBVEZ5aXViOHZK?=
 =?utf-8?B?eEtyazBzTFJaY3VrVGk1TUdua3ZEYmtwQ1RaL0IwZVhDOFFzTENYTjFieENG?=
 =?utf-8?B?TWN2aTZXR3pLbWpvOGZ3am9rcSs4TFNPTnFmVTEzTWV6T1JwZ1NZSm9idTMv?=
 =?utf-8?B?N3hqeHVQYmEzZ3E3T2V6Z01UYkVvVXFnMUpyak9iZWtISG8veEFhQXRBU0VQ?=
 =?utf-8?B?WHZzSFl4SnkrMHFYS1ZyYUJSVit1VlA3K3ErSVpuZ2Vtb0tOQ0FQc25uNDIy?=
 =?utf-8?B?c3dQTFBVWjlSaXFZK1ZnN3VuVFl4eDVtVXdwYXFOQmxsSFRneWM0TjFBcDVK?=
 =?utf-8?B?QUUzUFhWeW1oRSs5WnFQME1HMmpLWmEwWERITUdleVUxYTdlbW1LQXI1czJE?=
 =?utf-8?B?Y0oxZzR5Um9KMkt0cXNPOXBSWHl0aWhkbld3cW9idnEveHlwVVV4d00wdDgy?=
 =?utf-8?B?ODhKTlFlWTFZeDlnaWdoSnI3amdHREtaMEJZL1pmbHJ0b2FkZG4zWE1STlRR?=
 =?utf-8?B?R0VLUVp3Vnc1Mjl2SWZBRnFzZGtodEdiQ2U3QWh2Q0dlRXdkZnhMVWVBcE1u?=
 =?utf-8?B?VlB6UkwrbGx6UEdzcGdIOHBZVWlMK2xmb1VoTG9VMHZneklvM2NWZ3lqejVQ?=
 =?utf-8?B?YlpKbkRrOWhaQTg5OFJMdDhQTVl5aHJGaXpYeE5SMTJhV1B6dGFTUDdZcEph?=
 =?utf-8?B?QmthNzR6VnVXTStySVBSUDFQR2ViNk53dWJ1Y3BVMmtnQXpNOEFKajQ5Ym9Y?=
 =?utf-8?B?SkJxblFZemk0ZDNNbnJ4disyZmkwWVhoSXkvQnpHZndOZEVrQlB2OXNBdnpH?=
 =?utf-8?B?L05MQVdjaDVBYjJ0TDEycG4vWkt5Y1prRDZGK3VsamhaRVJrb2R1eDByR0FG?=
 =?utf-8?B?alZyNE12SElPQXlQQ2lBeFFJZ3RITXZ3NHdSQlhOVUJNc3RUc3ZLTm1yM1Nj?=
 =?utf-8?B?SXd4dHVDLy83OVZlN0RyYmNNYmdGcGZORzRLV2JkMEdCWUZobklYc3hPWHBk?=
 =?utf-8?Q?lj5l3E91anA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWpQaXM4dVB0NEtJVE5PeTd2MktqRVhRdk9YK1RxVGpWVE9HemdyZTdLblM4?=
 =?utf-8?B?eWw4bGlRMW1GYTFSQTVxcGkzSjVHOVBBcHpGZDJIdEIzMzh3T2thK2V6SDhB?=
 =?utf-8?B?dXBtZDNXUlR1VytKV0FacUNCa0gxWWJKWGZmQ0dhSlltM25xcHZ6RE5FSzN4?=
 =?utf-8?B?dlpmSjBJY2k1MW82MWc5T0h2bzVCNEUxaXJoV0R4ZzNjK1pKSFVIdXB6UjFR?=
 =?utf-8?B?a0tNcmpJa0JaMjJlb2FnaU9UV011MXJFaDFiYXgzS0JKVTIrRmt5eUhDcXp5?=
 =?utf-8?B?NVB0anFqRGNqdkVYYWdpTWtZQS9JVmVnUXdNZ1VDSGxCZ1ZId3ozNFJFRFYw?=
 =?utf-8?B?K2RDd0dHSXREYyt0NmkxaXJxUlpsdU9xNWJzUm01UDUzK1A4cnV6SGdXMDRC?=
 =?utf-8?B?NHl3U3lPR2QvNEFIanlHRzl1OG5IRTM4WStTYmk4VDhpaHRKb0cwbmt1c1dw?=
 =?utf-8?B?ZzBjd0dkTzZ3UDRnSVU4R3craDdPdWMzLzJ1Yk5rZzBad0duWGRNZjVVaCs0?=
 =?utf-8?B?TTh3MXFwTmdWVy9HSEZiVmhMU2FpZFc5Y0dobVZjUjNtd0NKblIxNDlSa2dD?=
 =?utf-8?B?VEd0b3NjbWRYWW0xcm1BblVqb2w0RmhrL0FpYXdza2hsVC9KNldSUVMzaC9K?=
 =?utf-8?B?b2RTejI1VVRVUTFpbzJRMDN1cmM3SjBHSTI4dUVnNy9icWVMb1JmNHgzd1gw?=
 =?utf-8?B?YWRGMDBVTUllcWxCNWMyUWY0RlUvOHdPYXVrOUw2aEpjK0pTRzcxWTl6K0Zq?=
 =?utf-8?B?SmxIRFFRMlBjT0Z1L1p5NW42MTlwY3RIb2lXa3JjRWZ4bkI0dVFmeFJPRW1a?=
 =?utf-8?B?UnNBaWdGd3dBbWZ5RUp3Q0JQcW1waVlnY0VoR3Nwa2tOSzVZNVhjRzhSMjZ1?=
 =?utf-8?B?Rk5RdFk5OW5IQlErTUdJTHNwRm1NUFZ3dmR5cW5qUVVFck5mMkRlVlpUQmxp?=
 =?utf-8?B?SlgwVUhXWWxBWFo2d1JFWTdIaERJaTVCT08waG1RMnhxTmUvdDhib3VTNnVX?=
 =?utf-8?B?d1pIZWQ3dko2MWdhOVkxMjIyY21FTWV5TVJyNmlNckxTVHFXcDBXdXhaZnBp?=
 =?utf-8?B?bUJDWk5yMDAxMlQ3citOeVNvK2ZCdWxaUmN4OUZiTEdmNU5uUU5MYWNqYnRJ?=
 =?utf-8?B?ejNxZGFaMUZOV2JQeFpjcjV6b1ZFMnpzTWlkdFlVeDIzVHErVnZ6U1NaeU4w?=
 =?utf-8?B?ckpkMEROTUs4UGpOcEtmOUJtT0l3ZWVrY2NCWlY5ZWRJMkV1cE1lQlRWUmls?=
 =?utf-8?B?QXhVTEZ4b1d6Z3JCMjlkNG5vTWx3TFlibXBYaTEydTZ4N2VQSTYzMmo3OUtX?=
 =?utf-8?B?NFB0KzdFc0s3MzgwTjJFU1NTMXIvMlNKeWZoK1UwUmtNcFd1R1E5S1RYKzJY?=
 =?utf-8?B?Qnl2eVR6VmZGTUJjb1JJWW15NnhLUWxVTVJIeWRMa3NvdUxoMzZPK0VKVDhT?=
 =?utf-8?B?ZW02VmliTUg5V2V2RGdUcTdabE1uT25hK2IxTWFncGRGcEx1UzJhc0VsU013?=
 =?utf-8?B?ZUI4MWltVkNqTlh2RFpsOFkwU3hCZnB4ZlRNakc3c0VpR0ZPalNIL1BaRUxL?=
 =?utf-8?B?Z3dlZUdGRHlwYTNsdXUrWnVsSzVFc2FjT3RaR2YvU0J5TUtyM3BxMGZwSWxm?=
 =?utf-8?B?UEkvdEZobVZqcFZveDVNSENpNVN5ZVMvNTZJbVJVSjQ4TEUyQXFKNy9NME5y?=
 =?utf-8?B?VUhIbUtDQlRTNnl4V1VsMDdhQ2NQQXA2ZytRazUxRnlhWHN4Wm9YY3QzUCth?=
 =?utf-8?B?bk11eDNNZWh3WlJocVE0WUlsSHVyWGdXUCtlT3dJdnY5NzBsK1IwZ0FlRnZX?=
 =?utf-8?B?US9KZ2dnRE1Sa1VoNFFValdlMzlBd2ZwM0daaFZrWkxtOUV0OHJraWpCRnRY?=
 =?utf-8?B?T1FwWEovZS9iUWdqQ0JJaHhiSlg3a0JTMnB3UGNFaXlkVUs0VURMaExQTmx4?=
 =?utf-8?B?aGdZcVpkNWcwdi81ck1zM09XMXBnRkgzZ09OZkh6am9PaklOemNtVW56RFVj?=
 =?utf-8?B?MEFmUFpSOWpkTG1OVHROaXdHQ0piUFZMVnNOa3dDVlEyeTZmZENDWTRTSnJk?=
 =?utf-8?B?WmZYVnNWUmhPc3dZTnhjUHoxTjE5aitNa2RnQXRoR3hVNWZvNEcyUjc5V0I3?=
 =?utf-8?B?TUNybFJweHE5L2hXNEo0YTI5MGdoMnlOMy80M2xLQWV3WUZrU2c5bmNtZlF1?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe1f693-c576-4cf8-f7c2-08ddbd627899
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:27:58.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LE1Ckgpin/FOFEAJEpSrK2zdGod6n/JibP4z7WgvtwXOUwF7spaXIUpWnJtPTYz83jbPvMK5iJYJfL7quRwgNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059



On 7/7/2025 10:22 AM, Frederic Weisbecker wrote:
> Le Sun, Jul 06, 2025 at 11:32:08PM -0400, Joel Fernandes a écrit :
>> The synchronization of CPU offlining with GP initialization is confusing
>> to put it mildly (rightfully so as the issue it deals with is complex).
>> Recent discussions brought up a question -- what prevents the
>> rcu_implicit_dyntick_qs() from warning about QS reports for offline
>> CPUs (missing QS reports for offline CPUs causing indefinite hangs).
>>
>> QS reporting for now-offline CPUs should only happen from:
>> - gp_init()
>> - rcutree_cpu_report_dead()
>>
>> Add some documentation on this and refer to it from comments in the code
>> explaining how QS reporting is not missed when these functions are
>> concurrently running.
>>
>> I referred heavily to this post [1] about the need for the ofl_lock.
>> [1] https://lore.kernel.org/all/20180924164443.GF4222@linux.ibm.com/
>>
>> [ Applied paulmck feedback on moving documentation to Requirements.rst ]
>>
>> Link: https://lore.kernel.org/all/01b4d228-9416-43f8-a62e-124b92e8741a@paulmck-laptop/
>> Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Very nice and welcome!!!
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 

Thanks, glad you like it. I figured this stuff is better off in the kernel
documentation than rotting in my notes ;-)

And lets continue to keep the discussions going ;-) thanks!

 - Joel
