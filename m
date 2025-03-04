Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6896E24EAA7;
	Tue,  4 Mar 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101538; cv=fail; b=mPLN0DImS/y20qAhVu0rE4Q8zVCYIb0YSAkCK10svlQNv0x/8+pE3zNEpfws4zOMeC2m5HrJmABuPXTZbHG/vemAAaKky3xBvVDtuJgtNpaTDdGPw7WpilQrq/67G8ZmCSXg0shAL5FW3d2XWaIG5WnFYt+lE4fDupmEMoF/lxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101538; c=relaxed/simple;
	bh=iWs8eg3tizLMXkHjStG5O1++L+k+BlAMSVjsilzLyXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p5O2AXIt6+cKyFIELACKyCTW/UZPQ5BcL6ATC7BcCRv4BQ4N0r4Ujb0+89Jp5SYMzs/864ugt14lOzaEHquvt1B01mLcV029nEwXChYeQymnt4RyE7QQkVVJi1vcPuBhI/Gi2bPi11rxtC3ATd2sgwgNpP9c8/pUyOBjllYTEXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxQ9Kkig; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxQ9Kkig"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4gANMQSfC+1tG9fXP+tbRm03zYVQaNfMDqzNoU0YLU5k9k0VGCmli5ilVxFO/y3zwI9b6LPA+AlXvHCyOGMgw25VN9M6TM4i+JE+ID/wOyXRTK5lzD3tl5Hkh2uPWJwgpEH+ExfqqjfnUmwcMDtbSLj9bb3BkHebkOy7PffdWtXrLkMp4ZONxV8BwcZXZGJ1/qmLSmwjKhLqczBkdzboyqFqfgirwZXdIM9ZIjGAoXui2RJpVX4ofgmpYCAqUOGF93eL28fd5NC0j5hD1yjPZ7nEMdv3dldDv23u3H/L5c1AjSjAgLT2a4vJL5Zsw4bMhIIbLviNJuWYbqxFd57Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA2PKfuIzhDtrPavFJI/YfFjpp9v4aFBPdDP4+sfQEI=;
 b=E5000x8LW3qgx7Tp9Fit9Io1dlKFwmAP5ST+a5aQ4OHubfwgDQcujX89P82BWBccEvi1cGTQJkj4pvVlPbNcx3ZK31ijyElh8YlBVvmAG56Y8X+blRwWcn0IUI/klThUYHkfrAPqy9yOo8uYxeFUXdEcFw+zQcetjhBuMw+s5y45VOgu1R7pKmZyosWorjZVWJKFx9Wsyk80R6CzWvefSh9qR3Iw6y9bA1Ah70On9pj2kEZd+HSpGuZ4MW/z8snVPYzYA6fKQIj7jqpGkz5BM8n5Ai3Db577t9VAvd97rpH2HYDgYLOI0zVDGFmmCBuanE4ShDYj25Xp2LkRKKnY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA2PKfuIzhDtrPavFJI/YfFjpp9v4aFBPdDP4+sfQEI=;
 b=kxQ9Kkigp1j6QP+8GxXclNd3GncBf5mo13aXvA2/rPqYLIECXL+9e9Krt40hI5uZkcg6pAtG2qvEFrZNcPmfDlj8YHNg7aSuwHDmsdwiGwR/mbzLi4yRDc4CFhotv6mbJEFqkNWu/2Q18kOUB1s1QmA8+wH59CnW+CuAtqt3KW+qgNi0vdkxIOaRCeVXUeaDMYjSiY/8WkXOyWcy43ehX/Zzqak75/ANbjb+cTWZf2jRO/DVy12i5dqQW1dyTU+OTfO6vbgULfMQXmB0gVmWVeESyojNhb8rhMe/EwHIlq6Fu7SKirnV85hXgO5ftjXuXdlnxM3S/+Oh68Yp8te84Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 15:18:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 15:18:51 +0000
Message-ID: <b0a52bb4-9f5a-4b52-8209-c585228ca28f@nvidia.com>
Date: Tue, 4 Mar 2025 10:18:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: KASAN: global-out-of-bounds Read in srcu_gp_start_if_needed
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Strforexc yn <strforexc@gmail.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>
 <20250303114711.12716d05@gandalf.local.home>
 <20250304035732.GA128190@joelnvbox>
 <20250304101150.0eb83618@gandalf.local.home>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250304101150.0eb83618@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: da990a40-00b1-4ec2-cfb7-08dd5b2fde76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkpmYjBhb2FNcFdRQVJwSU5meHo4WENoa0JFblE2Nng3cnBHb0dPN2M0elJ1?=
 =?utf-8?B?MnQvalBqRXhNRmhVRHJ5ckVjUXFlcEJEQ0prRnJmUk9UUlFSaTdXWW8zMFpG?=
 =?utf-8?B?RGtCL3IvL2QrUGV1am9UQm5zVTM5NlZUcThmNkpaWGNQTFg1eG1PR1A5R0p3?=
 =?utf-8?B?VlZsbnkzL0ZBTFNybkVsRFM1TmIzd1RiZ0FBZFUrZ1diQnpteTgwWTZicko3?=
 =?utf-8?B?MXRrK2ZBMXFMRWlIVlNZcWQyNjZPVURFam5oSGZia0JycWl0cmRjMlZycHo0?=
 =?utf-8?B?MnlJODdNb1VaR2dqQk1pSnl0R1YzRGpWemVyT1EwV0RUbjFkR0FWYkhQUk9L?=
 =?utf-8?B?OTlCckF3SjdPSmZOTkJWajQzOWU3SFNSUG9ocnB0bEkxWCt2ZVJDTHdDdTJx?=
 =?utf-8?B?K0Rkb0FhclBrMjJYRU5QRkZxd1NHZHNSQ1dqVlFpdWFtUmlsRlRBZm5oaS9P?=
 =?utf-8?B?Tyt4ZFJTZjFXUUpBVnRsdHdOb3NxUFVTdXhjUEh2Rk1USldnbTJpQ2lvZFBo?=
 =?utf-8?B?elAvQW1zQ1AvbmFQTVM3M204bVg3ckxYSFRDS0srMklLc1FFM3JyQ2w5MU5k?=
 =?utf-8?B?NUU0OGZ5ZDhmR2JvZFBsd2FQRS9udFBQR2JKSWZnNG9TM1Q2OUgzc1BqWFBR?=
 =?utf-8?B?OW9TeTVUbXdLZERrM05SZ0RCNk12b0RpTWJPcG9Fa3N3L0F6cjJsei9FRmRY?=
 =?utf-8?B?K1Z5My93bGRCSTRqT29lOG1CWkFxbUVkbW5aUWgrWkhGRVFnK21BUGVKT1h0?=
 =?utf-8?B?bDdGb1JNNnYwNzJRYnJHaHVMc2FFNWtkZEJWQ25XMUJsTjhDRDFDNWZUR29Z?=
 =?utf-8?B?emxLZFBrS3h3TUUzN3lQWjhjcHlFWkM2clBZVFFjYXBBNitueElsakVsSXBZ?=
 =?utf-8?B?aU1zOHRVczdTb29lSUgxZEo3TllpTDVjNFBJbHRtQURteDRzd2k0a1U5SWk1?=
 =?utf-8?B?UUI5akhRQzJJWHd0TjhIYVA0dGtVM2ZLQTJoYTc5ckZXeXhBZUFXbkpCQWlr?=
 =?utf-8?B?NVRiRGJBU0JTelRWc1BWV3FPVHBtbjVyKzFhTWxxOTN5eTA2SmtwbWdyL2tF?=
 =?utf-8?B?MUR3elNFWnVEZXlkNnpmOTJQcENhSmZLU0MrdW9ibEpJNHkyMGN0cGZITzBW?=
 =?utf-8?B?Szh5aVZRSllOZlRKa1R5Q2lUWjN1Wm5DdTBTc2hvRi8yMzlEMEYxZ3ZTbUlL?=
 =?utf-8?B?UTNXcFZLeklDUGtodFIzM0l6ZkJKYTE4cHJBc0c1QVdHS2hmdXFQdGVhb2Vm?=
 =?utf-8?B?YnlJcGRXa2c1aE5valM4QUZLcnFsUFBCVno3MWpVZEVtbE1jZDJFaU1EZ1BU?=
 =?utf-8?B?SmcyOG9HZHZOSjZiMGlEOENzVU10T1VuWktDcDJ2bVYrUWljd28xSzBvRlVv?=
 =?utf-8?B?SVhXMG02bEMxcG9yV0ZtTmp2UHdsUGRLTW1Vd2pQb2hrZWhQQnpsMGRaWFZ6?=
 =?utf-8?B?Qjh3enc3eWxqdyt4ciszRVN2RExJM3B3M1pXTk9udVBRMHUrWStmSXdQcHEx?=
 =?utf-8?B?cTNZeHBQdDA4ZGsxVXhORnhuYTJEbjdpSkVScWpPaEVML2tKRTlSVno2bnNh?=
 =?utf-8?B?SE45VGZZb0liTlhHWkMrQW11Y2cwS2M3MEpKNXIzYnJ3ZFBOUTdzQjV2ZXRh?=
 =?utf-8?B?VDYvVFllNThhVTdKT3ZEdkxLT0ZhdndpR3JXT2NUaWw3TnNKWUR6bFoxM2wx?=
 =?utf-8?B?T0wzWGpVWGdYeStPYWJQRFhtd3lvcmI1ZzNYeFZ0Wi9lMCtSU3ZyMzFPMEEx?=
 =?utf-8?B?VXgyeTNBd2xwQXN1NFFJMTJ2eTEzQ2pLRU5GUWplSHYvdnBHdHJsL05wODl3?=
 =?utf-8?B?K0x2Z1RlVUkwdWpTY1hqb0xCTzhpUHBIQ2xvTHVRcXdMY3pkVEdNaVlud2l5?=
 =?utf-8?Q?UV4jth3O3Bvg1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1Z1NHlDeTNUck5tcUx5UVBENGtESklYZ21RVEduWmgvZ3ZNWVhxeXloRjJZ?=
 =?utf-8?B?aVZVcjhBQlF3bVBPZTNwWFlpN1huQmtUSWRyN1lkTmJmNWk0ZlRSQ05zM1VR?=
 =?utf-8?B?SUJ0Tk9PS1dNVUFaQTliUWczN2FYSlpNRS8zSm9xMTlHbFd5T2xhVWlpcDBr?=
 =?utf-8?B?bVlyLytsa1NNVnNaT1IzQjd0K3ZiUnpQYTg4T1AxcGpMRnV1SVlUOEpRT0px?=
 =?utf-8?B?bzQ5Q1NCSkZ1R0xTYWFYL25PUTFWNjBNdzg0NUpneDdqRUEvc3U0UG1kMEc0?=
 =?utf-8?B?RGdQM3h6UjZmWmFrNVRQa1lZRW1FTERPVkZDWTcrT2VNS29sYldvZkorZEJa?=
 =?utf-8?B?d3llb3pVdzVuNG1xRlAyTmNYaldaRGp3NzNkSnMwQkZ1V09oRjhwMytjeFdP?=
 =?utf-8?B?b1I4N3g0NU95TUpoaVprVGptRlUxRGVGMGp0bzVVb1RTWTdnZzQ4d2NtT0M4?=
 =?utf-8?B?QTVrVWFLcXM3VVdVN05YZXZteEVITW5IQUE5NG5XcWVsK3J6L3FINFBacmVQ?=
 =?utf-8?B?ZmdJL0xKa2p0Mi9EVkdwNGhkNzJOVmR1d1VESy9vWVRBbEVSTnp6MzJDRUFW?=
 =?utf-8?B?Vk10TXl3WGRSZnJvclVRaHJVTlFoRkNvT253ZHY1Yzhpa1gvL25IL3gxamlR?=
 =?utf-8?B?eTNDMkI1VlZ3dGlHMDVWRE5DZys0YmU5VjdkcXp5ZStyTmp2U3k5MHRZbGtk?=
 =?utf-8?B?ZncyWVBDMFFOZVVIbUZpWjFvSnVHQUp0L3A3UHJlK2pCT2NGNGFPRjNIWlRR?=
 =?utf-8?B?c1hMUlJVSjVZbzF5ZUprdTBLUUJXSkFja2lISWtsMFNtQTRISXBrN0c1dFAv?=
 =?utf-8?B?bHMvb1J2U2M4MmEzcE5saGN5SmhyaW11VE9yWUdjWTdzMFcvSXB3RXBzSVhr?=
 =?utf-8?B?SzZGQkQ1ZndPMm90UWowazkwWFJsQ3Y0UFB0ZDRHUWFyTEJIbVdQemVTUVJG?=
 =?utf-8?B?RnJGU2JtOVg1SWkvY2k1VlFLU01OTjBMTnlabWNYQjNNblhrOER5cy9oa2U0?=
 =?utf-8?B?QmNDQndnSUlKeDJva2JpUkR4YzlHK0lmWEVMbFBiS1VlNFFldkdnMFRXMGZ1?=
 =?utf-8?B?eWJUOEN5a0d4a2JLZUo5ZWE3NTF3RTkxTm9qSlgzSkowWjM0bG5UZzJPcnln?=
 =?utf-8?B?Vm5ueEl6ay9kYkdNais1eXNJc0dISXFrT3N2OVNkNlo1UUwzVEFKemhacHBN?=
 =?utf-8?B?OURORVROSjNjbEtuWjJmdHdqSThXanphUmx2cThCQ3lRUk9rRzhtUzE1WGlq?=
 =?utf-8?B?VUNWRHNuUk5LdGpCbk55a2JMSitjUmlwaU9vWUVMeXBteldxQmRCV3lVcXZ1?=
 =?utf-8?B?eTBUVWtyN1JYNUJrUEZ4ZmNGcDU5YlhmZ1BxY1dYaVFKSTc2Rm9TL2RoTVM1?=
 =?utf-8?B?RVFiWGpyTlltd25BRHFzK3pnRlVycWxFaEFVUVdqV3hjTXVOTXpjYzNVVzlZ?=
 =?utf-8?B?azl0VFJtYkR1a290Z1J5QjNtN1RPVDJNaFBiZE9zUUtjdDFOUlRiVERlTEdQ?=
 =?utf-8?B?UnowRlNhQ2hUSEROQnoyUDNrREVQZ1FyckVZLzRoMXViSTRGWTlreXo4TkZn?=
 =?utf-8?B?RjJDRmxnT2JwVCt4Z1pFNjMvTVZNWTdrVDMvcUJyZGdYYTJTdGx5bE9aaTN1?=
 =?utf-8?B?bGRmeGJJYnNXMGF4aW5jS29wempHYTIwb1FVY2F3R2IyWHZGbjFhcy93Umcx?=
 =?utf-8?B?T3F2MHFaQ01QeVRXWUhXL3luZTlLWEw3TTJmNlR3Z1ZMSVRObitRRlZOaU1L?=
 =?utf-8?B?TGt6bFVsbUVBVkd1UG1XY0xENlpsUkYwQ0U0MFJjQy9UaHZOQWFCQmh4N1lB?=
 =?utf-8?B?by82T29pMEp0Y25Cd3dZdWR2TjRiSnBhSUxYSlh0VURMNWIrOHU0ZkVhZ015?=
 =?utf-8?B?T3hBQUhkOEV2NWVLaGEwcTBqdFRVMURUeS85UFViblhwbHdvS3o2TDdpaDR2?=
 =?utf-8?B?ZC9WY0pOQzU2MWc2a3l1Q2l3dzlmb2NlKytXSVF5NUhZblNhQmJrWEpUVzhx?=
 =?utf-8?B?QUxpSkZ1ZDlPcjh4c3NRUnhMNENhZFJZQUxDTUEyUUxUb0hGdGFURGVqMEpU?=
 =?utf-8?B?OW9sanJVTk1LRzFFdFRlb3dPUjhKMDRPeVRPTTNTdDF4RTZmczBhR2Zha0Zv?=
 =?utf-8?B?U1N5QTFCZ3grc0kzWTNiRHhSbXo3VFFGc25aR1NnOXZ6aWNoV0lQRC9PTnNz?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da990a40-00b1-4ec2-cfb7-08dd5b2fde76
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:18:51.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6c8nlFfwb0Axy7iyck6aT76H/XU3M4nU7mivxD75re1girw12DDexU+CJByDuGkc6w2O/pUgALtXHIvDQZeTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488



On 3/4/2025 10:11 AM, Steven Rostedt wrote:
> On Mon, 3 Mar 2025 22:57:32 -0500
> Joel Fernandes <joelagnelf@nvidia.com> wrote:
> 
>>>
>>> The lock taken is from the passed in rcu_pending pointer.
>>>   
>>>> [   92.322655][   T28]  rcu_pending_enqueue+0x686/0xd30
>>>> [   92.322676][   T28]  ? __pfx_rcu_pending_enqueue+0x10/0x10
>>>> [   92.322693][   T28]  ? trace_lock_release+0x11a/0x180
>>>> [   92.322708][   T28]  ? bkey_cached_free+0xa3/0x170
>>>> [   92.322725][   T28]  ? lock_release+0x13/0x180
>>>> [   92.322744][   T28]  ? bkey_cached_free+0xa3/0x170
>>>> [   92.322760][   T28]  bkey_cached_free+0xfd/0x170  
>>>
>>> Which has:
>>>
>>> static void bkey_cached_free(struct btree_key_cache *bc,
>>>                              struct bkey_cached *ck)
>>> {
>>>         kfree(ck->k);
>>>         ck->k           = NULL;
>>>         ck->u64s        = 0;
>>>                 
>>>         six_unlock_write(&ck->c.lock);
>>>         six_unlock_intent(&ck->c.lock);
>>>
>>>         bool pcpu_readers = ck->c.lock.readers != NULL;
>>>         rcu_pending_enqueue(&bc->pending[pcpu_readers], &ck->rcu);
>>>         this_cpu_inc(*bc->nr_pending);
>>> }
>>>
>>> So if that bc->pending[pcpu_readers] gets corrupted in anyway, that could trigger this.  
>>
>> True, another thing that could corrupt it is if per-cpu global data section
>> section is corrupted, because the crash is happening in this trylock per the
>> above stack:
>>
>>  srcu_gp_start_if_needed ->
>> 	spin_lock_irqsave_sdp_contention(sdp) ->
>> 		spin_trylock(sdp->lock)
>>
>> 	where sdp is ssp->sda and is allocated from per-cpu storage.
>>
>> So corruption of the per-cpu global data section can also trigger this, even
>> if the rcu_pending pointer is intact.
> 
> If there was corruption of the per-cpu section, you would think it would
> have a bigger impact than just this location. As most of the kernel relies
> on the per-cpu section.
> 
> But it could be corruption of the per-cpu variable that was used. Caused by
> the code that uses it.
> 
> That code is quite complex, and I usually try to rule out the code that is
> used in one location as being the issue before looking at something like
> per-cpu or RCU code which is used all over the place, and if that was
> buggy, it would likely blow up elsewhere outside of bcachefs.

Your strategy does make sense, as usually bugs are isolated though FWIW, we are
in a monolithic world leading to some definition of "isolated" ;-)

> But who knows, perhaps the bcachefs triggered a corner case?

Yeah could be. Anyway, lets see if the complaint comes back. ;-)

 - Joel

