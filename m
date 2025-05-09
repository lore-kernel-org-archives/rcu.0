Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34524113A;
	Fri,  9 May 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816984; cv=fail; b=K8ugVmDLF+q3Klnsxejnr3Umx0Tar7LG+YQn5klLX6zkSH7zq4CYPJ0ZOw1V/f5GRLwkvDX2QNkdqehEz4x0RWBrQwv9QZ0pguDTwIxT0M5lj6glV2HALUdxFQAIuH45tSAWVWyM/DekBqu+26WPVNAIml3UwE0EkUEpIxBcA+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816984; c=relaxed/simple;
	bh=FANrQOk2UvaQmmzZ7jQyiAkzBE7qnaxDdzEfLXfwBCA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NaH+/JTbQiyBX3jACRYfiszne3MQ8eqPiaG6+/pCjMte+oV/q8kALk6QcCFL+SyJGxZ5JS3XK98On6Ri1X/InlLwTV2IiRxnYkxPWzAnAqjpgKkaQtSCo9VXsc64u8GeL8TGyFYUAc46v8K4OT3trBPtDjXJjiAa8/d+XTB67X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PTNCq0pA; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PTNCq0pA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7M4Vu7IJVhBZ9EJErDx14yiJbWwl0LLM16Rpto9uu3+o2J2XcnvFcMHgw0WidqzbI7L/p3Xgzq6CrUsBOEIo7NKGL6g7tiovtfaZcFg5CVyCecJTgPuZOKgLWK9Ttk1cm/fYaCH00qqWZgjNV9WBREAn6+Nn4zArRh0kOO0yeZ9SR10qiwBRVwQWGHR/RLBTIayDGrgEGwBcEBuvq9I3b3a2BZqOdeY27FcKzavfSmeG6JsqqPc6GsqJ6iIW8EmlidIY8IDYhumu3H9aXFbPAqkEsf8mhiVwF0L/okEDeAv1fzJ9LTLZ57yWjt0Fz7STnaamXMCoHBXXJV9iM2Adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kIQEqluba1Yh8pCFDKWkOt3xXb77Bbf39/RqARTQ70=;
 b=oOSpyNVTE3bZqzCVIX+qhFOIpptvhA3xWW1WZYg6bCFK/yeq/Qw7lWgFexszFkEBzH8rWzpEdISg0BUTRQhYYRtPvZ360OVoD9RQG6R224r+a5gWMzhOaQIVTkVgZoU6Rqfv43mZzXI7aIikMUU/8q+R4Dd8ec0KpBr9JJkPJUXvm/6EDHKxqSMZacHCsccxpERM6FYLaFWYLZDnvve6lMWsO6FgUtHQ3mvk9EKdecbIoO+0JXxkNxSfLJjt0EAIcu17vAU/Sh/tiCMG1umWmnLkLACVIlOm9ii7Ow0anlAsgrjie5qQ0Ya5oTvGSoyZYRq4l1eOVHBl0gPCWDhG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kIQEqluba1Yh8pCFDKWkOt3xXb77Bbf39/RqARTQ70=;
 b=PTNCq0pAfNeb7dBDZ3Lf4vxto1GaCaVRFqW12qx1SIBDzjOxVui9XMUtiv+67QygJimLWYPJQ5sGCsYYr2L5lZSotjmllJSJcfki2XZqY77XYgTNIOFRomMZEoLrJKccJvb5eulswgv1BOau1UvzcDLhoB2BWgtqqJKNu91mH5h8u6ZAMLunQLPKMMrSFCeW15DImv/ytHIxX314F5XL2whPoG0D7joh6cAEIyY0j3keOIQsWMMnpfDBoQq7Edo/LhbhOVV3McOLNSNouRzqNlO9P+v/zg4/5kEt9vEKCw7aIYjLrWCJADePpVXxWoK/ov+ufCms5FEnKFThmrv48Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.37; Fri, 9 May
 2025 18:56:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.035; Fri, 9 May 2025
 18:56:18 +0000
Message-ID: <c40c36b0-d8f3-4012-8e5c-eedc7343c33d@nvidia.com>
Date: Fri, 9 May 2025 14:56:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu/nocb: Add Safe checks for access offloaded rdp
To: Frederic Weisbecker <frederic@kernel.org>,
 Z qiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-2-qiang.zhang1211@gmail.com>
 <aBuJi3jhcp4dCbSY@localhost.localdomain>
 <CALm+0cWyWrEcsYx+6nDT9XjMdLBDwx27SmAXTPUFLB59TbEc3Q@mail.gmail.com>
 <aB4EKfvicJ558J7A@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aB4EKfvicJ558J7A@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:208:234::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 992e4f3b-e69e-4a0e-4aed-08dd8f2b2ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTRXRmJadThXVHRJSjBlWHVBN1R6RU81cUdyQUFtak5NKzY0YmRjcW5hV0R4?=
 =?utf-8?B?TUFPZUQ0anNaRHJVa29jeCtvcSs5RE9jYmp2NHZWekJpamRWSEtBSjZSdGo4?=
 =?utf-8?B?dmpseEp5NDJjUjZib294bHBxVzBCMVA5R0ZTVFRVUTFYUklrNWpQWW9iWmdT?=
 =?utf-8?B?RDh3NUd3ME9UdUtZREpKN3E3UTZ1dU55SVZrcm5iRnhUcGhMQ0FyMEhNdlBQ?=
 =?utf-8?B?K0hWV1o0WGZ5SisxVnRCNnFYM1h0WUkybnIvY2l1KzhINWtOUldtb0l2RUNP?=
 =?utf-8?B?bVhhenh0ZG1nLy9yTVduSFl1WmNsdDI0NU9ZT0xvRjZNemorOHNmRjNXNVV5?=
 =?utf-8?B?VVBlblpoaEhnUW5Gdng0SU5Da2wzZnJ0RUM5LzIvSE8wbExJM0RBbDZwMG9u?=
 =?utf-8?B?QkZTVXpMNTcxQ05VYjd2ak1RcXNZc1dOZHpjM3lVSjlCLy9FeDNkYU91T1l0?=
 =?utf-8?B?UXN6YUcxQ1dWU2dxSXZYaUdka2tiYmkwOXh2eVJXY1V2a0FDdXRHL0hBaTRn?=
 =?utf-8?B?T3VYSDFQYlVmZ1VWNjhqRU9vTlF1NmYwQnhtWVVQbVNpQmtzQkVFeXo3S0t0?=
 =?utf-8?B?TDhoS1paVjJSMk9ucG1QR0RBVHljd3JTRWFsTGNwdmlvS3BPWVlXY2RZNUZy?=
 =?utf-8?B?cWQ2ZDgrV1crdFk4U0tEQ1ZzSktVZzVRWlRXc0doMzhacGhwQ3hoRUMzc2gy?=
 =?utf-8?B?SjY5YnArZmxQZnBORnFKZGVocHJacERaLzY0eHZRV3YyTkY2TVdZSUk5blJO?=
 =?utf-8?B?cDBIVDlmZDk1NmQwdTlmZktWVWkrRHVyQVZTVUhpdVVYWnE2NnBxdW1Rd2Vz?=
 =?utf-8?B?NFZySHJ6NjBJdHlHMHo0S01kTnZLd1k3b2s4MTI1M29Oc0VGR3ZLNHovNnFS?=
 =?utf-8?B?YkRmaitHOStLL1ZnbWZOL01zclcvRS9zdnFHdTBWQTFISk4zT0xkM1F2TEpK?=
 =?utf-8?B?UytOZDZMWnZBNjUyRTZkbldvK0hZazdoREZyajlIOE1uQkE0cHMyczFqaHpR?=
 =?utf-8?B?SlFBdGo0Z1hPbFljNGRyeUZ3OSs5dG5xT3lEY0tqWHp5MlAxRzQvclBzTmtl?=
 =?utf-8?B?WU42eDErYVduU1RGSmlrMjY0QzlWQ2N1SDhrSlpDMi9OMTZpb3lYY09TRFNJ?=
 =?utf-8?B?ajBwOTVoNVdqZHBpT21NVldVakRUbVc2RjRvWTZjZlRpTk0vVW9sNVRwdUdT?=
 =?utf-8?B?S0ZVenBqWDgrVE11RWM4ZGwvLzlRQ3oyazVZM0dBajBjWXBMZDRpQ1BGTmVt?=
 =?utf-8?B?ZHZabUtNcFY3ejBzT09KUDk4RVJTd2NWNW5aaHQ5ditQV2JDRGtod0lRTkFK?=
 =?utf-8?B?YlB0K2IrT2VudjBkUkZZTkNabDgzZjlndmV0Z2RGNWNvUzIxblRxMVZvZHZX?=
 =?utf-8?B?RDJXaU8wTCtXS2hENnEvM2NVU3U2S05tRUlyYys4c0wrLzVRbG5oSGcyRmhF?=
 =?utf-8?B?T25leTdOVExqMS9zWkpZdGxRSUlBQ2pSK1ZwUTBoVmYrdmVjSWNSWHdvVndK?=
 =?utf-8?B?QmxlV0NsdXp3Wi8xc05vamRReFpQVXVHdERUak80RWNBWE5NTysrYkF5K09R?=
 =?utf-8?B?bzFhOEI3ZGRtZ01SZ1RZMEREWElmcHNxQkRmT0ozL2FMT2w3cC9GTlFPcDBX?=
 =?utf-8?B?ZTExb2tVUWhMT0I0Z2htNG9WWmN6VTA4UW9CNTEyYU1Cd2s0Z3ZiS1QwT1px?=
 =?utf-8?B?WnhJL056cS9qM0ZxVkVFTHlpZjROa3k2bm53MTlwUVVzS1YySWF0Tmt1U3Vq?=
 =?utf-8?B?UC9UVWVQS3Z1OW96RDQvalFoV2VlTGRGK05hbmE0TTA2YXBpWjB1amJaUVNI?=
 =?utf-8?B?bFBwOUVtVkkzSnU2TUM3dDhCYnd4VFlXQkV2NXpxSG9PZEZZNXJzcEtqUXV1?=
 =?utf-8?B?Z2FuT1JoZDFkOERmZ2lZYnllYnpQNGI5dTU2VXkrQnVjY1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEVyMktGa0s1bTA3K3A3clpQMXNpR2JmcUJ3S3ZFMFIzNmNWUHNkN0VPWUtR?=
 =?utf-8?B?YzUrRWFlZ3N5bW9CdFNXVWs1djZETGNOSmlybk5RWk1wTjc2NDhPOWl5enpu?=
 =?utf-8?B?M2ZhWEdkQVBsUjBFb1pGRjJ3TDh4OU16dHduR0w3SWZXbjl3ZFJ6eUl6QzVr?=
 =?utf-8?B?NUswbnN6d2kxRVVWaWg1VVFqRHhPak9hM0xhZTBnRTBXeUZlYzE3RUxEMitW?=
 =?utf-8?B?cXJpNk9sMkRRajZuN0pmYkdJblJidUNpZllpQjc2Qm00VTNleEN1N2t5Vk5W?=
 =?utf-8?B?aHlBbW9yRFNabmZoSldZejdBWGdub2IzWEgwMG5uWjRMWmROdlY1MVBVbUdM?=
 =?utf-8?B?OFNqbGI1Q3RyVGpkanVrVTFoT2xjUjF5VGNFcHVmOEpmN3RUVGtCRmw2NTgy?=
 =?utf-8?B?aWF3QjNIY1N1ZWx2YWpiaDF5aHJkTGk4VnFpenhHVlJleW5Odk9FekRsYTE2?=
 =?utf-8?B?NFJaN2ZTQmQwK2hsQWYzT3crbEZJaTBGTjBSdVduZ0ttczVxZ2VlTElmMlZ6?=
 =?utf-8?B?NktNWGx3a2FDWlk3UVZLMCsrQjRTYjRYQzAyOVdpNFBhTHZNWjJKOTAycVNo?=
 =?utf-8?B?T1BQdFNqNXpReFZEL0tXRGhaMmxuL0FsTmtrSTdJem9LZExVMXhTUGE2RmtY?=
 =?utf-8?B?bDVjZWVRZC80TGVwMEpSOWZKRXF4cnVKYmwwaDdXY2NrMzVGUjl1OVpoM2Zm?=
 =?utf-8?B?dm1lMnJ6dysvd3lSdkRoSWVySTBlYWtSQ0o2a2dhTk1rNnRMTDExWEs2MVp2?=
 =?utf-8?B?MHl6bkw1T2VwZFk0aS9FQVhvcC9TYjEvRnUwdzI1SWJxME8vZTd5U2NwSTU1?=
 =?utf-8?B?c1M0bnZ0aHY0L2VwdDhCM3pQdVdEZm5RdzdGcmNhVEVDWGgyNWRNc2dZUUtH?=
 =?utf-8?B?NHdjTXRVdWZtckUwY3pUTFlQVEh0QU1TL0NNV2V1YlpqNXZiWCtlbDlNZm43?=
 =?utf-8?B?SUgxNkZFOFFQbk9oQWR6M2RuWmVaMmIrV1dwOHdDQTh6b3RaaGNEeFdIYzVH?=
 =?utf-8?B?RTZxUGFtbnArcHprQU5LNzBZOG5oNjFTSEtiQ1RSbVFtcVF1dmJVK2Z0K0s0?=
 =?utf-8?B?aEFJbnRNcXhvakw3MjFWVnBFSDJ6bEVIaXZnSnlIbWNCYkZRd2ZSYUtmQm5P?=
 =?utf-8?B?VnIwS2RCV09sUFpxNWRJNlFheGV6WUJYOHRrNmZ4RXJXNW1lTSswMm9ZbUNl?=
 =?utf-8?B?RHE5WDZoTkFhcXQ2OEJIS2ZrbmlqVlpFT0RDYzZMemVjSENCRFFJZmw0ZHFo?=
 =?utf-8?B?R0pZNXJ6ZE9iekFkNmdqMTVRcjlTckI1dURtK0NqTjYwN1p3V25HYm45Rm5x?=
 =?utf-8?B?V0V2Nks3TlozYyt6R1J0djRkZmNsZHZLT0Y2bXBiLy9PSGU3VkxrOHYwMi9L?=
 =?utf-8?B?aGJpdjE0TTIrYmgxQzlEVmR1ZDRqUmNmV0xWQ2lYOW5pcERIQ1VZV2R3YkJa?=
 =?utf-8?B?dWlVelhHMTYrZWtiOUVQa3B6QlZDVy9iRUlyQUR3UzZGaTJDUlRybFBLMjBO?=
 =?utf-8?B?eWFkSDVwYUNpWUJ3T3JKdEExRmVYZmU1NjRNZDFQYWtTM0t2TzY5RlJmY0o4?=
 =?utf-8?B?MlAwMkRLbU5iSUdUMzRpVEFrNzk4VGdQN2pJdlhiNHRyOXVpMDE2ZmNERXM3?=
 =?utf-8?B?dFNtY1Y1VldqamlidjRLbGc2em84UlFvb29BVkt6S25WaTVhcVRqa1RxN3NH?=
 =?utf-8?B?Uk9DcFZOZW84b0RET1Z1SmpNektBTk5tOXo1Uk5CUGZpOVVGalpTazdqaWNi?=
 =?utf-8?B?Qkk4WXVHSnpGWklBdlVTZnRwMEtNbmhJZ2lqQ2hLZHFyY2dPZHRLWVQyT0NQ?=
 =?utf-8?B?NHhtcERxTno3cEh3STZZbkxGOW90aW5WMkxyYjdidUVwaWt1Z3hRUi9NNC9I?=
 =?utf-8?B?TXBoMWR5WmZZYS9hUzQrdFMzOGdINlM0L3I1aFljWjltSjFwMDcwWGdERTRj?=
 =?utf-8?B?SFIwZHNlVUJaR3BSVENTdzE3Nit5UHUyeGxvVU1SOHFRYzkzVGFzRUYxdFE3?=
 =?utf-8?B?TTRlWDQ0YmV4ZUk5WHFjNVQ5WDR5Z2gremE3Rm5VbWJiRHZZejdvaEg4Y1JF?=
 =?utf-8?B?aWxXWmw1MnFNQldJVmhJMVViV3pkQWtkdXdseE11RVk3T3hSRktZOUptanYx?=
 =?utf-8?B?dXA4ODVpam9SV1BNUklzMWp4ZFZuV3B0Yk9HY0tlckgvUUdXR1VqZzczMER1?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992e4f3b-e69e-4a0e-4aed-08dd8f2b2ea7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 18:56:18.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXlDLsuYz6uBOzl5C+Zn7r3Pdi+jofgOy685xI/GEvFiBTsaknmfST34OmKfZMzUBXlzGHksrcnGPSg40Pa8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262



On 5/9/2025 9:33 AM, Frederic Weisbecker wrote:
> Le Thu, May 08, 2025 at 02:43:11PM +0800, Z qiang a écrit :
>> On Thu, May 8, 2025 at 12:25 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>>> On a second thought, isn't "rdp == this_cpu_ptr(&rcu_data)" enough?
>>
>> If the CONFIG_DEBUG_PREEMPT=y, the following code will cause
>> a warning in rcuop kthreads:
>>
>> WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp))
> 
> I keep forgetting that, indeed!
> 
> Looks good then, thanks.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 

Applying for v6.16 with the tag.

thanks,

 - Joel

