Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF0734A3D0;
	Tue, 23 Dec 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511506; cv=fail; b=dECg3qp0Zk5I1XjVX1zJIUAInyqTFRV8JIzGcR6ys1uM5e7Oqm5FUah9nVATt7iLCH1b4ZLUN5/BUFmXpoAjto/KDWPAoI+cHNRznjYWv27hitjATzdKmAB5esWgo/G6+lZyRZsOlI6lp9MTonGg7DlOeseppZaCOPYLEMMDouo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511506; c=relaxed/simple;
	bh=iZ956ArBoxDorl/M7IXikOU9LqGULTtWOqkgCjZwmGw=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=jf/Yan2FT1c34Vv7tCuCg8ZkyZYuigtzeNLndI3yVZfpCZEoxwvhZy9p/ToUlrXO4w3bIykr3q7r+Rz0VAuz50opAhlJgcc+26zzCeVxdczMiinQlXDx5kYjTvUSq1TFO8mIToU1GNA9bGGSquTQvjFuR7AaYSjHdPKn9i0O/v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jUSs+z/m; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jUSs+z/m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKuNrtGZ/iNwsx+M3hpiRi2n3J1FrI7a8167eVORbxLZjIuMIgljXY0K3tzr9axkCwZdoZxe11qWfauVWeZ2jiPJjVYJjGRxUMPPCNZwAtaC0Vq/kqqcuPNvji/NPSHJGLdWJLD/95bSRMQLa68NDco1SuvEUETZO7P6/HXTqDMtRTamYfKJ9ZWS5iGO0WdwDt40k3R5UQUQUqFfgxKWdio+nAmPz6BDKXsK6L1qqoecmGVwbdxemxk0mNiqlCLFJJpU0yCKyLW5gKZeQtTBa4FZangreqM1AmcAyn7CLAKdtR4vt2nBNavJtqXLOk8sSsTtro7Y8Q23SdNWyeY78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ956ArBoxDorl/M7IXikOU9LqGULTtWOqkgCjZwmGw=;
 b=EbVUn98v5hZxL/NZQMxBH1c+2bPBuFv8P+ExGCm+OgF+n4u4scMmaQbguxkmKfN077so8gLRZe6fymTfAp7aBWNH3U6+qW0e/kNC4SQiqVmN5wLBnlmXwPaXMNloFzlMrdc60Exs8EvM2IdcS6Lk6Met9RoAvhHcAvKztQ6cG+ndqCNeqtjeMvXICdvAC+HilFi5g75BiExkwTMxCaJ3/ueHA/G+gnOhNP0ZNqYmILg+Zs4IWgFKBQAqdJ9wv13fsmmJhrAS5gtqbjS3xvfPR0RWwVK1DbIEXgYEn9matoRnu2wmYWsoX5yhynnOp8isX5nCbnMtgbyz1lSj4rxe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ956ArBoxDorl/M7IXikOU9LqGULTtWOqkgCjZwmGw=;
 b=jUSs+z/mMzSR/fKGure9R5YipWGa971lzCvI2w2uErzVtIcjVY/EMxQG9zUzAysZRJa1FtwQrMh0EuDh5JVVX5BgfC+MtK8UlXwWbxxl5J0lBQIk4+/rB5ksBROuHtpXNiVpFrubcYmEC7D1HTJ+6PnV0qWG/ZbM9D7a91mNEUGVH5aMywsZsuevTq19qsaICL5aMbE0IZj1tlbQjYR6JUT/nv0MoBvdRirkI00zhvNXPaK1yEDsJ8g6VREMlV5EWqV2mWfjypfivV+ZvKuhdUxONLZT/IEBDoU04WjZa0hJSFFpBcsPrl0EsDBoYoTeL106mo+/IoXfmZCMWAoJZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PPF52B16157D.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Tue, 23 Dec
 2025 17:38:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 17:38:21 +0000
Message-ID: <1efce983-639b-430d-a613-03baef81c416@nvidia.com>
Date: Tue, 23 Dec 2025 12:38:19 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rcu <rcu@vger.kernel.org>
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [RFC] jiffies_till_first_fqs off by 1
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::29) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PPF52B16157D:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b065805-6ed8-469b-30d7-08de424a114c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVBzYktMeE5ZVmNtWW0rNUVXOTVXSS9INjNZN2IrakxwQlV2RmVjbU5QbjNi?=
 =?utf-8?B?RXJnSTUwTzBFdjJmSDFjcHlHWnVmUWs5M1EzWEdJbG5pVXpqOWtkYXNtVjZV?=
 =?utf-8?B?b2R2clc2V0RFYXpSSlJudklmU0p5Z2E5bTFObnNER1JoVmdESTdnYjBXQmpU?=
 =?utf-8?B?Skd1Mk9aWXJvSk9pSGR1VHRvUHBzMWl6c1FqaUJUV1ZHWlNBajhCOHp6Nlp3?=
 =?utf-8?B?YW9rY3U2OVl6Z1VwczdHK2hwSUFRTEJXbUEza3I0Q1R1SWtPbVA3K09jQzRD?=
 =?utf-8?B?OXlIWkFQQ3R1TGE0TTZqT2EyaGlaQ25NdXFJQloyWlpCbm5OaXpLbGZkTFgy?=
 =?utf-8?B?Mm8rQ3RZNTljdnMzV2FkSDh2S2dZdllLaWhxekVmZFF3V3lFcUdIUXhmMWZZ?=
 =?utf-8?B?b3JMWUt1aVp1UzRCK3lqRjVKUE1FeDk0VGp4Qnl1WkpERmZmMThFenBieW1r?=
 =?utf-8?B?cGpkMEk3eDI4L3ZVckV3bm5TUGJsTklwUkNBNG1EU2pOY3Urclgrdko3QzBu?=
 =?utf-8?B?RzdGVHhhUnRPd1VON1dCQ1BadSt0K0R3b2NOMjBhU3FKcmRSVHlNNHJZL1ox?=
 =?utf-8?B?bDc3MytDSlV0SkJjL3pRWEpnUlEvZE9XVXp2bTJMdzhtdFF3eUdJWkFWbjRN?=
 =?utf-8?B?NG8yM3hzeWliS2RKSldZellIeExYL3B5SDZnck5GNmMyNlBYby9XTm9sZGZO?=
 =?utf-8?B?S1RlQ3JEazBSMnFqSEdpdFF0QW1udmFQZ1FISHZwMWYrR0J5V3piWFBPSWNy?=
 =?utf-8?B?VVNuRk1jWFpQdVowVDNMMzRjNmZsdFg1TlB6ZC9jSHc3am16VW1BRzdRWkNz?=
 =?utf-8?B?cEwvajFtMDJuTTRiMmVxTTFLcTVjc3lWbVN3OEFQRDNRMmlwWkZJcUx1a0JB?=
 =?utf-8?B?QmpzV1hpWmZuc3dWS2EzYnR3L3lNeXZVaDF4aHc3cmd4T0FFdWI4bXlmMXlH?=
 =?utf-8?B?K3VCejFKMzVkdHNoNUtzSFBqQnpkUHBST2FXaS9Ed2VQakxLRzVobGE0a25R?=
 =?utf-8?B?bitHaXZmeXVseEFnQ04wV1hBTVM4cGs4WEtCeGRIWE5zRk90VGt2V3U5YWJM?=
 =?utf-8?B?VmVEVXN1YkNpblRSazYvc0pyVVQ3b1VLTzlMU1p4ZVlvZzF2UytSYnZha2p4?=
 =?utf-8?B?Slg4cWhBS2hkK1liczNDU2hQMWhjWm1DTGhzazFFV3pUVHM3d2RJUDJYY1Ja?=
 =?utf-8?B?bE1wZS9BRDhWT0wyNXkwaXZWMEg1R1o2M2ZmcDc1NFJmMlFEVVhOWXRTcFdh?=
 =?utf-8?B?VjViV00xSkJjQTVBTURudjZSU2dXZHh4VHZXY2lweFNpWS9NdWJ3akdlQldO?=
 =?utf-8?B?SEM2Nkg4dmVaeTQ5SGs4S0tjSWVlVFRJZzgrQnUvRkNQR2lUTXdtU013VFk5?=
 =?utf-8?B?Mm5oaHVuTUZkeTlvd0NVMWZqdlhUMWxWdFZNTVlKMWlhSkt0TTQ1dlovK0pG?=
 =?utf-8?B?TDhKcStNSFdSWEUvWno4UjhQckhpSTlxM29obXFMR2VuZ3R6eGpTdGhoQng3?=
 =?utf-8?B?N0twVU14K1hsQUNsM1U4dHN0b1plc0M5d3N5K2R1S3Mwa2JLWHBBcWRLeFF0?=
 =?utf-8?B?bmZ4TllTb1NFRDA2L1RWc1F6RjdKMjV4TXMvZnIrSlhiUXNzWkNMM1ZPRFVX?=
 =?utf-8?B?T2dBb2lqS2Y0WE1ubXl1T2FmSVBoWktrZkczQTlaaENFZlYxcTc0SSt6eHh6?=
 =?utf-8?B?WkZRUXJqbXYyZDlUdXpzZUJjUXNxaytRVXNxa0ZRQ1RGaU9LL2NsTnF3aTNQ?=
 =?utf-8?B?MHZBQitHdXpNaDZoRS9CbkowVXQxT1FvK3NIQytJNWFUa3lDNWdidndoMjND?=
 =?utf-8?B?L0lLMFkrUWdGRGFNUUdHUml3WHF5Z2lCdDdoWXlHdjBKMXp0aW5FUHBsRWRp?=
 =?utf-8?B?cDdYWm1Sc3dwdkNwRXgzVVBtV2xKS0lEUTdtSTFtSzZCMmxWaWV4U0o4S2d1?=
 =?utf-8?Q?RGqZsPjremFWIjFHROSeZg6KCm9KSE8c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emhweTRQTzN2MjhYdTNneTROekJkUDA4ZUp0S0MxUC95T2NSVW4wYmFWOWlV?=
 =?utf-8?B?cE94Wk1KczNScUtmYU5zaEY5eFVaSU1NY0kvQmtzeGpBdkVKZjg0SXFEeU14?=
 =?utf-8?B?VVpVMXFYQmJJQW5yMG0zbEQ2RHI3bXJZa0RmUDVoRGQwbkZTTmhzU1ZOb2JD?=
 =?utf-8?B?OEVUeTVmTlFuOWFQL21wY2JVeUlaNmF5VjVBNVlpZ1lReGNJUEw5MVkwY29I?=
 =?utf-8?B?MkFna3ZFRVpkMzVnaWdLakVZVWdNOG1qcjRzU1greFpUbTF6d3NONEt2VjFT?=
 =?utf-8?B?UG1ydGtTMkpPM3gzTTIwR050bWJ5b3lpeDN1b1VOS2ZKenBqRUJxNllkeHlw?=
 =?utf-8?B?YXpGVDBhdFFxTzZNbjV2QitrTk81ZlZzNVJ3WWFHeHo4Q3dOWm9zc2M5Q3hH?=
 =?utf-8?B?eFJzdkNudEl0QUpXMFd0RFMyVktiTGpTTkZXUi9WVHpvQWFEVlRvblpwVTNs?=
 =?utf-8?B?UjNVUWwzMTBJSWVaVS9uVElycHIwQzc1N2RKZDNKZ25OdTllRzVxM3NwOHdV?=
 =?utf-8?B?RGdOaWtjcUlPcDZ2SThNcll1Nm1TSVd2dlIvRXhuSUNtankycjlHNHByN2Y5?=
 =?utf-8?B?aWMxdVAxZTZVYUY2MjhNOTU1Qy9PR3RKdVZRVVZlWEZJai9kMUFtOXVERi9W?=
 =?utf-8?B?amQrMjRDOVBvNHRmSDd6TGNYL2hsNmF3WGwxeVhLeTU5SmdmYVQyWisraXcz?=
 =?utf-8?B?R0JaVGU5Qk8yT0RUemxTaW0zeDF5QTR5eDJmdXJOMWlMaE5PWDgvcUNCanRx?=
 =?utf-8?B?Yy9EY3Rwbml6THU3by9mNk9MU3ZGZ1dGU3lqN2NDREloblpJa1lpN2YzVjJK?=
 =?utf-8?B?OXovTVpEc0d3ck5mQmY3UUhYb01mc3Zya0hmU2w0Q3lTLzhNMzRKeTBTUGxM?=
 =?utf-8?B?MGVNdnFQRUNTZXhib1FCYTFtQ1BiQTQvRUNmRFBqdW1STVhwaUtNMUk5bFJL?=
 =?utf-8?B?Y1E2QzFQUk5rUkd6VHFLY1FFVHlGUDROMGFjWXJURDBKbFNrQjhtK1FNc0hJ?=
 =?utf-8?B?UnBXYnpwQWlpUk80SmdyOFl5UEhrM241SnVLN2dReG5zb1l3dnp2NnBEdGVH?=
 =?utf-8?B?cUxJL0FMTHE0a2F2bTFZM2Z5ODU5dEFodFJENC9kaXo4NlhWMHJ2MUNITG1T?=
 =?utf-8?B?amIzUFFFUllpS1lyNEhDUnBSQThYK2hNUkpaTzFlWUwyMmdjTERQc3pqUVVr?=
 =?utf-8?B?LzY0US9oWkx6bjNVNVYvN2V1RFNHdmtFTkk4dVpWdEpPa0E1dEVldUNML0x3?=
 =?utf-8?B?dUs5KzBWbWRScXJEekdURXBBMWlvUzl6ajJuN1hYdllDbFMydmkxUHlLdXBC?=
 =?utf-8?B?a3lYZ2pva21mOGpnZ0hmWXJWOFFKa0ZpTXhHUmx6VWduMUFBZjFEOGFaTDJ3?=
 =?utf-8?B?VHNkOCs2T1pEeVJPOFdzdnVMSVVsWXlXMG9oa0cxQWVOMFZsNzl4a3kvKzRK?=
 =?utf-8?B?NjErWDhFOFRIbE1iVjVSU3lULy9idERYcStpamdzcUdrZzFMa1FsMHV0NUM5?=
 =?utf-8?B?RExRS0N4SVp2MkJYVW05b2xGVDZoZGhuWFl0ZGFIdGxTQldidzlidVZFWk9z?=
 =?utf-8?B?Y0I2TlVhK1lzSDdDdGdSV3BHV2FWZmFRZTdaYkVzNWI0SXdwWVRXaTJqbXJ4?=
 =?utf-8?B?b1hDUGNYVHZHNTZ5ZVY4TC90ZXJqMGxXSGVPVUJMRmJDaDliaXJzSUpWaktw?=
 =?utf-8?B?V0tyRHhXVlpmSXN5UE9BVXphb3lIOHIzcnBCVTk5MFVMQ3h5S3lNejNhenov?=
 =?utf-8?B?cjlYZzR2NS82QXhDN3hRNUE4ZnlvYmdIeVlPTlhIQk94L0doa1JMR3RPY09l?=
 =?utf-8?B?dnJKbzY2ZTJBYXpkUHBSVjhRQTVpUnBZb0xhemJVQXJ6WmpQVHlYNG5TQWdy?=
 =?utf-8?B?b0NaVGVITC9vVklEQ09NbE03bTJGZHBOdUUyNWFtUEVHT0ZyNkdYSm5GOUMr?=
 =?utf-8?B?K1A0S3VNUndvVW9CK3lYNzNSZ3FwZDVRUzEzNjNQK2wrZmxGTGlhdG8zYzdX?=
 =?utf-8?B?MzRjangvREtENXNlUE05NHNVMHJwVGEwZ3ZWNTNvRERLY1NPeERZVGxoNksr?=
 =?utf-8?B?cjZCRmwyM0R1ZnU5S2V3ZHhHaVl6UlBGa2w5Kys0S2lJL1VGRjJ4THphYTZD?=
 =?utf-8?B?cFBKbzNpZHlnd0Z3YStHemZZd2NORFo4U2ljT052d2hqcEtsL2p4eHJpUFRP?=
 =?utf-8?B?ODlLbVl0dmxZY0I2MGpZWXhSNUxvamdoM2JNL3hERy9tSkdQaTRvUUlVNDVk?=
 =?utf-8?B?bnFtVmpVNG5XQkE2MTJwVWdzSVh5bTZZOHpTSXRqVGVWNTh1VUtvZG02eEJ3?=
 =?utf-8?B?b0h0V0FBNEkwVzNRMUdtUmRqSGVWQXQ0QkQ3SDduQXdDL2UwOEV0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b065805-6ed8-469b-30d7-08de424a114c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 17:38:21.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHHdeZmn0nFJGnYJLxwLPjgV/f88xg4hxSS2NWUz/ejzQrGMr/LN/f0JNcY0vTX3fmqOkBA2096wuo4O4d6bFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF52B16157D

Hello,

During studying some synchronize_rcu() latencies, I found that the
jiffies_till_first_fqs value passed to the timer tick subsystem does is always
off by one. This is natural due to calc_index() rounding up.

For example, jiffies_till_first_fqs=3 means the "Jiffies till first FQS" delay
is actually 4ms. And same for the next FQS. In fact, in testing it shows it can
never ever be 3ms for HZ=1000. And in rare cases, it will go to 5ms probably due
to interrupts.

Considering this, I think it is better to reduce the jiffies_till_first_fqs by 1
before passing it to the wait APIs.

But before I wanted to send a patch, I wanted to get everyone's thoughts.
Considering this the RFC.

The other place I found this was when call_rcu_hurry() is called, but the GP
thread takes a tick to wake up, but this isn't related to the timer per-se, it
is just that we don't want to wake the GP thread too often. So we just wait for
the next tick to notice callbacks before doing a wakeup.

Heh, and this means synchronize_rcu() latencies will multiply when HZ < 1000. I
wonder if this is also what caused Uladzislau to investigate it for mobile devices.

 - Joel

