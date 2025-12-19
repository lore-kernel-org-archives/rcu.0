Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231DD1D5CDE;
	Fri, 19 Dec 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159094; cv=fail; b=QzRJKsJ7yUmpovl7CALxBLYNDFYqUaqiZUgdkRTRRYLagjUBxRAJTxCzuArcy7Pda3W9AEX9vj08bx0w0A1i3OGX7pET9L3C67evPgD0tFG16/uTtaJgbIMlbzDsf1T9EhxNl6HMBrN7QPyy05YimsVnL7d6WNwKNlZ8VguA71U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159094; c=relaxed/simple;
	bh=mefzDoQfPX5wxnHvK+c9hPLFOnDE5Kr3MoijPyt4I1U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f7AdbzYOFqBi5l0NEVdLlMVAJNxzuXdSYSFoehLFmPQoBW1pTUub8ZVsIhmH8zn1CQCL3o5bmLfJEOsZ+pn/FYY+Hzw+Lxv0XaSugohjENiBpWBef8/VIDrxdofRZBGdheFM8aLFT7wwPccwyrK9DouyEanOfqHWeuDAMp/2u6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pfkNnm6K; arc=fail smtp.client-ip=40.93.196.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pfkNnm6K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJAEXFyp5YanVOHr7/jaNQvy5oPGfwCy6rKf65HkJs/d/fhT1E+VhKJSHkDVaY2ppGqNFBP16W9Sud9DWanevF6fSrotYO0EOczEan5v7uaPveGwXwSjnYxA1eplaHFDdLR2IMIs5wLRxTEhpcM3v6l/aVi2fTFmrp0+NtLrdWj71eihV8xk2jEFg4Q+GpWncZLFbXPXJv+gX03EfEBhu/Y8NvItOOLizpG2Q79nt1ppqwCF++HqRNXaRyIdZfdrcI/ecRPAh9av23r00R30YnzUXs22nYzTvetWLw5jLoGk46TNCTr6tU8ZEOVEuY75p6gwEZbyYDC/2yXElR2Mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlE+38LXfFcl/R4e1QiJQXv61ouj0BBIevvxbue9VBs=;
 b=uVK9SmE0KHWviDoJAdCzhllvO/UNswdfWPKSchMHtvED5NA2e36KA4w1N8ngaJDPK0muPxENy8lH8QecgPg7FJFeguEuD559uHD9uJsGeWiFgk+jgXg4zAzoUEmuZgSxe5mSP7lwOMpQvu/T2wN+RPJlT65N3APZiFKu47aVn2zsanB6RZUOi922o1mF11za74v9pzjF0SKtbCbwvRwynXD0DwoWKDQWSEeZHcD+r38jMgUAHthuiV8DKGsKrGHFW9HhlfCsMFdsLZFD1z16D56NGAUXuDUGmQncFwgHCapXI2Ea6aEZaBoPgOj12IPPAdJNOEpMDfH8Xhyq8t0JYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlE+38LXfFcl/R4e1QiJQXv61ouj0BBIevvxbue9VBs=;
 b=pfkNnm6Kx4YLD3324ym37Dg2Cyxj/cC5YLQGQb2LIfRtKWSS6eOQ6DCfCZ/fRMtfYUaYxZz3GYNVxl9BYWajZQAG0BwfQMoyM7Y78HiT+6TDSgmcvI9cKAlFnYW9J9CJ6D96/53oKYysSP6cvUobYArZuetQ1IauAy+HEhx7LMHjRtTBveop/ElaViInfaA/AwIpPNl/chxbQrDriqSWIy+dF5JaB7api2NAETo9wm6Z2bvCKbipZr33FaH/zmlvuxfY1wIzPJH2bw88RhWVN9w9ohC/tfIoK1pyG+zfy6LzusURRQhwDHXo4tgUe10V4XJmLF0dRByJRM3VOZyMxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Fri, 19 Dec
 2025 15:44:50 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 15:44:50 +0000
Message-ID: <a32ad653-1bcb-44d4-9802-bcfc2725d712@nvidia.com>
Date: Fri, 19 Dec 2025 10:44:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Fix rcu_read_unlock() deadloop due to softirq
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Yao Kai <yaokai34@huawei.com>
Cc: rcu@vger.kernel.org, liuyongqiang13@huawei.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, josh@joshtriplett.org,
 boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, linux-kernel@vger.kernel.org, yujiacheng3@huawei.com
References: <20251218074950.1936014-1-yaokai34@huawei.com>
 <20251219151400.GA820904@joelbox2>
 <16e20d68-8d19-45bd-b4a1-f2c067ca44a6@nvidia.com>
Content-Language: en-US
In-Reply-To: <16e20d68-8d19-45bd-b4a1-f2c067ca44a6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0298.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f989296-335a-47e5-f0ef-08de3f158b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmZTZkN2bXNmZU14T1dmWFRzSTNNWDlDM0FiTzlxaU5XKytZM0RFZDRZZDJu?=
 =?utf-8?B?Rm9uWkdiYVRsL1hFcE1IZlcrV3ZpU0dOamExVmJSVGVkOWlBem9MTU5kNHVa?=
 =?utf-8?B?T3FlbWhkaEhmZkl6OWpQOUlCT1hTZHlXVlBhcHZtSnJRV0RJYmdFWEpCbkha?=
 =?utf-8?B?YnpTc0x2Wjh3M1JpZFRFVUFhN2JFRy9EVjFvZmxSTHBJangzWGFnSTh0U2tC?=
 =?utf-8?B?Y1J6TllvUEZJK0d3MVpHZHRKL0VMVkc0SjhSalpUSzFHZk5NUHVuOGR4T2Jw?=
 =?utf-8?B?UmZZaVdSSmZnRjRjdFJQYzlPK1h1SlBKbWNkMmUxa0RBckNFdkVkQ1VyaDcr?=
 =?utf-8?B?RnlQWHBYL0RxbzFPazZ5eG5lN3Z1Y0hxYzB3UmlrNjBDQXZydjl4cllTNUtM?=
 =?utf-8?B?UVUwcjVHWlVUMDJFOEUzWk8yQUdXZzFGeGRDRlJPSDEzU083MWVraXN3SkxS?=
 =?utf-8?B?YU9CVitVaUsybHd3dUJiQUowSUx0K3cyK2NuZjYwcHBRMzFrdXphVVFSV0NX?=
 =?utf-8?B?ZkRSSGZacUZOSEdvV3NUYWtXNlBxSWVBTXdKT1NNc1BkS2VPWERVaitSTUl5?=
 =?utf-8?B?WjNSMUpQc016LzdpYU5rUUpheGNWalUwQ0h4cVVqc3g2N1FXQk01N20yNWY0?=
 =?utf-8?B?ZW9EakZyTUE3VDM3dk1JT1FWc3g2dzhhRlVPQUpXNUVkTlhad1hoQm9talYx?=
 =?utf-8?B?NS9EMDRuY2hPMlBvck83M21lNG4vbkM1WjdkN1pEYUN2N1V2Z3crWGg0anY2?=
 =?utf-8?B?cSt2NTByU0dIZXZHTFV2bFVZbk9kZlpzcFF6cStTaE82QTFvdGFGUUlEaUNu?=
 =?utf-8?B?QXZSZzliVUd2YkF6dWpvZWNrTHJteWZrUUxWWDNWeXFqeHRDaUsxUlNCZWJ4?=
 =?utf-8?B?QjRiaG1Ba1NVR0MwUnA5Z01pMjU2ZVcrclhpc2lzUzkxUC9nSHpkVStXZHo4?=
 =?utf-8?B?Y0ZsMEhNMGx6dndZSTB1eFNiZmEzRUtmYUpYQ2Npb2JHaUNldjBRUTJmZ3Q1?=
 =?utf-8?B?WVhuR0xOQ2R3Q2F1S0dGSmVTTXhjaHFLdjVpYjZQckJOQmt0TW1GaHpQUC9u?=
 =?utf-8?B?SE9RcHA2My9sZDdpS0kzWUp0dHhYQS9odjdxdU9TUVVmWU1xVXcwNCszOEph?=
 =?utf-8?B?Y3lNR2xzcXhZaGtZakpleDBtb3FIYlRuOVVaalA5N2dydE1BeDlod3VnNnJS?=
 =?utf-8?B?Z3V5RTh0UGpZTGxYZFF3RVEzTGk5RkI3c1pCaTZaRzVNVGp5VU1lbzlyVzBu?=
 =?utf-8?B?MEplSDlwZGhvejFCOXNkUjhWQjBnMmN4MXNJc2FoNG5zSExFS2lJN3ZTUm1p?=
 =?utf-8?B?eTdkMVA0Z1NRQjVmRGtScVgwcWN6VkF1Q1VTb3pyTW5ET3cxSExmNldGd2hk?=
 =?utf-8?B?U3VoWnYraExocldHVlBTTG5sVEozc1JxTzhOdVhXUnpoMHUzbllpN0xIOUFw?=
 =?utf-8?B?UUptVmI3SkVCOXZ3VE15dFU0anJrcDJCMG1VYlhsQkIySkNGOVpMVnJhWGZO?=
 =?utf-8?B?dmNKaHI1UEZxM0Yrc3UvZE9tczhwTDFUQ0RzdmFMcGUwZEZrY0Fpd1REWDBu?=
 =?utf-8?B?b3ROUGRENWxlMncxaGMzU0d1c2t4SDhMVTM2Y0FxUlJYWkpCOEZDZ3pCNStw?=
 =?utf-8?B?eUVNZHNmTnVnam5LK3c5WU1yTUdvR0xmYXpjL3dRMFRiZ2Z6TDYrYXZWUVds?=
 =?utf-8?B?Z0svQWVuMCtkZ1g3M2xVcitPcnU4bk1WdnpFZjJXa1ZpRzBGdmpidlZKTnIy?=
 =?utf-8?B?a25yaTR4VmlUdUhDcnNoc2lpZ1k0K1I2K0l5S21iSnllZlRMRWdqWFl5N1RQ?=
 =?utf-8?B?UkkzY2Y1VHE3c3lzdlJmRWRFUllXWS9ISkt2NVluSk9wK0xMdU1HUG9GZFFl?=
 =?utf-8?B?Z0p0ejNjeFVSUXo4TC9Yend4R0Y2d1k2bjM4cDFTTkROR2J3OUdsejQrS2lh?=
 =?utf-8?Q?icbfh7BikNhV3CzsawN1pATtGvr8KHk2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0Y2OWcybElqd29CQzk4M1lDSmdKR3N0K3ZTeG9Sd291V3JMQUpNTm05QThN?=
 =?utf-8?B?WWdaT1pLL3NlRy9rMHN2dVBXWGVxSHFTcW1zY3h4Z1NKaUZWVnludGpDSWpI?=
 =?utf-8?B?ZXBzQVpEaGEvTWdFK0JEOXEyUnNaYTVMNkRZd2MySDN2YjB3TmhrWkRxSlJP?=
 =?utf-8?B?cWVtWTViSTNjT1pJazlCaE9IMzM2WEphbVlYS2N6TWNuTTM2MzNFdVZ5d0Rk?=
 =?utf-8?B?TitOU2RxZ2xteU5PaG5HWU5GS2FXNmcrckFVaVkvVi9laE1HbFV5cC9wS0xV?=
 =?utf-8?B?aXNMdmJUaW5tRGx3UDhCRWdhOTFaTUpoTGJBM2tZMWt5MGI1QVBTTUh1YW5S?=
 =?utf-8?B?N1AxODBQQUpFRW1tS3FJVmxzN2gyRjNHaE9TcjExNG9DQ1RhNXFrVDRWR1ds?=
 =?utf-8?B?R2xWRE1tbTZ5aDEybk8waVdZMkt4eXlyaEFYRVVxc3FBSm5VUHF3eVVEak9W?=
 =?utf-8?B?aGtCNk9EYWMrbTJmdWVtaEVHR040RmNaVGFneEFNaUM2UTNaQkw1eUNTdWVJ?=
 =?utf-8?B?V2dkWlU0RGtkU0daQXFZaE5jTU4reFpPZXZNODN1TEp0ZG1sdTlDY21sdnhH?=
 =?utf-8?B?N3lBZzI3d3NKLzdFVXJIQ1dqanpNUFEwTzRKL3dUc2ExVlU0b2xDQ0krRnQw?=
 =?utf-8?B?OFNXRjB6LzZzV09HVk1uSVZJbGhUUEVRM2grL2JCSkFyaTR1TVloQ0dLTHZG?=
 =?utf-8?B?Tk1MZ3BOdjdwT0hBNjhhcG1JbHpwcnk4aUVlR0U2ZTZCWlpEZTY0QjNSdGE2?=
 =?utf-8?B?M0Z4ekZVa2lNTGhmMVNDNSthT1ZORUYvRTFsTS9iWjd0cnU2RkFzZHNxM09u?=
 =?utf-8?B?N2VzRUc5Nk9sWHVMOGFWSmJEUnIxS2prMytRWE1TczQxUGc3VzVPb0VTR0pk?=
 =?utf-8?B?ejFTTkRKdWJiNTZNRCtvcDEyNlJwQnl4QmFKN2QxeFJWME81STY3b1dqY0hT?=
 =?utf-8?B?RzZESmxUMFRSWHU0RE5TdjhiTUw5WFNIQ0QrbVpSclBsSVN1eXBabHdhTVlm?=
 =?utf-8?B?YkdFY0RnYjl5QkFzNG9PclhnTWVHTm9uczM5S3NOWWdIYTdTU1FkaWRoQlBI?=
 =?utf-8?B?MlYvUmM5TGE5cWoyL2dKd0FJTU5yWHRCU3gvd05maXFIMjhrRU9XV3hoVCtp?=
 =?utf-8?B?Rnh0TFVyaXRrQy9wQmFaTmpEVG54bGkydGN3Vm9WSVdkd1cwTVB4MmxYcGw5?=
 =?utf-8?B?TUVsU1RpeDZIL3FPVmJCanBqdExnSmYrOXlqTFp1VEwwV2NCRFoyYzRBTysx?=
 =?utf-8?B?Q3pSS1RCYWJ3Zk9PVEVUeDhSMzZXclJpN0pMM2lrQ1B6L2FNL1pOc2E3NllK?=
 =?utf-8?B?Y3prdWlhUDBlRmhSZEdhR0NEcmY2NEpLRTc0aDZCZTVSMkc1VklyQ2ROYmxx?=
 =?utf-8?B?VVB1aE56c1MxdnVHa1JSc3M0b0k3MlVVNytHQVgwSmlucnV0dXJPODlGamxU?=
 =?utf-8?B?WEdKVXNNNkxJUUpGUVNIOEhya0ZQc0l2bjl3YkFiaEsxcENLVmdVWHhyYmxx?=
 =?utf-8?B?WnMvc3pKZWpKVHlodUxuU1dKeGEyUmVFL2lVOTNORm44bzlDTFk3UXpWejk3?=
 =?utf-8?B?My9Bc2ZZR1R0NndxbDJ4K1hoYXlZNkpmSWREejBZeGxZM1NIMWNBY1Ntc0lP?=
 =?utf-8?B?Nms5a1FMYkthZ3RKN3FNanpqL2JUQzJjQlRPZS9rYnFNbE9Hbm92Y0Jpc3VY?=
 =?utf-8?B?V2FuRk5kK3JURktMaHdYa1M0ZmRqbDM0VjlUNUpZQWZLZDVYSVlzK2IyMDZD?=
 =?utf-8?B?bnBiOWN6TWJlZlM2Zks0VHlrQTMyM1RQSHZOYlo0a3ZreEsyYWl3cjdRNUhL?=
 =?utf-8?B?b0ZUNnZuQkFEVXA3TlNWZHVSRC83LzV6ckVrZDFsOFdEdTV2SXJRR29YdllC?=
 =?utf-8?B?b3pEeVlCT3hLbGZVUm5vbklLeWNnTkhuTmEwWHUyZG9seFZhVkxEd3E1Vm5w?=
 =?utf-8?B?dCt0S3grTEtHTE51elp5ckpOYjFENHozNElNQTZpY2pNaDlkZ1BlM1hpbzIy?=
 =?utf-8?B?QUNlU3BBWndnSjBGUTJET1NFdGFIdTFsVGs2Q0NMbnYwVHZpNmlGajJyUSto?=
 =?utf-8?B?R0RCdk5QbHpqNVh6Y3QramJNejR4bE5MdTBXR2wwTHFrdWlVU0xiUjBnalBj?=
 =?utf-8?B?SEdaeEpwM1c1a3VFUXpIbGZUY0ZDWk9UUnNWM1lDRzFiRmFqeWh0RGhaZUlX?=
 =?utf-8?B?WkUvZ3BCM0lLcEZMNDJBWDFuRE9lamJJNXNHYjk0ZFJ3aXRLSTRhOHNmMU9N?=
 =?utf-8?B?bm80NkNMT09zMVdkMWNPWkNsZ3BIWWxmR1dhOWc1bzBwekNEbkZESWp1VDJs?=
 =?utf-8?B?L0NTZkY1M1hlSlVNbEpnWlh3Ulg5RHZVT3VsdzJaaDR1L0l0YnBtZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f989296-335a-47e5-f0ef-08de3f158b92
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 15:44:50.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d51Lf8VSWk0oRRcnHwhDtOJHC9b7IIGcqeUw8tIKZ5Ki/owEDsGx21mKVG4W+6ZztFZuGdFUujHsJnHsWmNpbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496



On 12/19/2025 10:38 AM, Joel Fernandes wrote:
> 
> 
> On 12/19/2025 10:14 AM, Joel Fernandes wrote:
>> On Thu, Dec 18, 2025 at 03:49:50PM +0800, Yao Kai wrote:
>>> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
>>> __rcu_read_unlock()") removes the recursion-protection code from
>>> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
>>> raise_softirq_irqoff() with ftrace enabled as follows:
>>>
>>> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
>>> Modules linked in: my_irq_work(O)
>>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
>>> Tainted: [O]=OOT_MODULE
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
>>> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
>>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
>>> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
>>> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
>>> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
>>> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
>>> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
>>> PKRU: 55555554
>>> Call Trace:
>>>  <IRQ>
>>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>>  trace_event_buffer_commit+0x5c/0x260
>>>  trace_event_raw_event_softirq+0x47/0x80
>>>  raise_softirq_irqoff+0x6e/0xa0
>>>  rcu_read_unlock_special+0xb1/0x160
>>>  unwind_next_frame+0x203/0x9b0
>>>  __unwind_start+0x15d/0x1c0
>>>  arch_stack_walk+0x62/0xf0
>>>  stack_trace_save+0x48/0x70
>>>  __ftrace_trace_stack.constprop.0+0x144/0x180
>>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>>  trace_event_buffer_commit+0x5c/0x260
>>>  trace_event_raw_event_softirq+0x47/0x80
>>>  raise_softirq_irqoff+0x6e/0xa0
>>>  rcu_read_unlock_special+0xb1/0x160
>>>  unwind_next_frame+0x203/0x9b0
>>>  __unwind_start+0x15d/0x1c0
>>>  arch_stack_walk+0x62/0xf0
>>>  stack_trace_save+0x48/0x70
>>>  __ftrace_trace_stack.constprop.0+0x144/0x180
>>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>>  trace_event_buffer_commit+0x5c/0x260
>>>  trace_event_raw_event_softirq+0x47/0x80
>>>  raise_softirq_irqoff+0x6e/0xa0
>>>  rcu_read_unlock_special+0xb1/0x160
>>>  unwind_next_frame+0x203/0x9b0
>>>  __unwind_start+0x15d/0x1c0
>>>  arch_stack_walk+0x62/0xf0
>>>  stack_trace_save+0x48/0x70
>>>  __ftrace_trace_stack.constprop.0+0x144/0x180
>>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>>  trace_event_buffer_commit+0x5c/0x260
>>>  trace_event_raw_event_softirq+0x47/0x80
>>>  raise_softirq_irqoff+0x6e/0xa0
>>>  rcu_read_unlock_special+0xb1/0x160
>>>  __is_insn_slot_addr+0x54/0x70
>>>  kernel_text_address+0x48/0xc0
>>>  __kernel_text_address+0xd/0x40
>>>  unwind_get_return_address+0x1e/0x40
>>>  arch_stack_walk+0x9c/0xf0
>>>  stack_trace_save+0x48/0x70
>>>  __ftrace_trace_stack.constprop.0+0x144/0x180
>>>  trace_buffer_unlock_commit_regs+0x6d/0x220
>>>  trace_event_buffer_commit+0x5c/0x260
>>>  trace_event_raw_event_softirq+0x47/0x80
>>>  __raise_softirq_irqoff+0x61/0x80
>>>  __flush_smp_call_function_queue+0x115/0x420
>>>  __sysvec_call_function_single+0x17/0xb0
>>>  sysvec_call_function_single+0x8c/0xc0
>>>  </IRQ>
>>>
>>> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
>>> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
>>> setting a flag before calling irq_work_queue_on(). We fix this issue by
>>> setting the same flag before calling raise_softirq_irqoff() and rename the
>>> flag to defer_qs_pending for more common.
>>>
>>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
>>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>>
>> Good change! It is the exact same pattern and both IRQ work and softirq
>> raising are for deferred QS purposes.
>>
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Could you please update the following comment in tree.h to say "An IRQ work or
> softirq":
> 
> /*
>  * An IRQ work (deferred_qs_iw) is used by RCU to get the scheduler's attention.
>  * to report quiescent states at the soonest possible time.
>  * The request can be in one of the following states:
>  * - DEFER_QS_IDLE: An IRQ work is yet to be scheduled.
>  * - DEFER_QS_PENDING: An IRQ work was scheduled but either not yet run, or it
>  *                     ran and we still haven't reported a quiescent state.
>  */
> #define DEFER_QS_IDLE           0
> #define DEFER_QS_PENDING        1
> 
> And resend the patch with my Review tag?

Oh, and update the variable name in the comment too (deferred_qs_iw) :) and all
the occurences of "IRQ work" to "IRQ work or softirq".

 - Joel

