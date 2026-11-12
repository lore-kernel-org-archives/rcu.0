Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.115
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794451832;
	b=pD22+TnsUwnfqjExgPb9arPgR8nOiAb6TmneIFJLGagJ0F5C/LoedGhGWYk3Js6fzM45
	 GXnc9kNVtZnVUK4x/NbZ/Bc1pltOOczJ/4VHrmNUBNnnWKCyJujA74bwyzQU/l9Zir9s2
	 ZuKBfp+PLne9k27J+NbLRrrcPAN0T0hwPqM6sevhkKdx4XwPWfxAkf/B/gMpzLcbhE4Nm
	 EYqbpcZV7cvPOdfbFMHpiTOME9Rv3QA+9VeASFDL5Qyg6jRxMcsLbzHIyzgyNe5jZGZlr
	 bg5PsgBysMrGyAGE4JCQIFtGe0IZ+lvleKGZXROGoj8PEBSS7m0emtU+mpeObVvgb1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451832;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BcJHjD2OoyPgat8vix+7AEutK7vRA2CV3VcISITycas=;
	b=cNAZ5LwgRq9hr5JJFtEwPdTb6dUge6a2jL80j4jjpBwnnDz90AAkN2uWLGLIE7ukHfZW
	 d62n//QPmqQtFpqkcHky2M1heDZ9ankauPWs+SDNXfzx6i061r9bScqCa6G4/YqVFOa8O
	 R7oZ5ry8npAxzqrAAw5eHY1KhS1mgNPqMWFuklhHOGZdBPL/inhEgJNxEfMOL8GM/8aYi
	 3r2F0ewXkCL4VcM75bNLrXjEah4jEQcDd6/5T50gLBhJvVI0PFTjLvaDWdrfK0Y+4kSrR
	 3bJnoNgtIFW1+rxgj1+mKHeSEbuCdxp/fwX3dLIBGgtZLXGKAYCi1aeyA16Njnv2rjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=n4hXTvTJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.115
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021115.outbound.protection.outlook.com [40.107.192.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A269606A31C;
	Thu, 12 Nov 2026 02:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A269606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=n4hXTvTJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdVY2EWYBYU2EgPCH0Rl8mh1KXw7ZYKDQMyjxULLUy6pRQNh6e/zm5YBumgpcRDLFmYDDAs9fDarMtO50G5WYgTpU2mSUbb7s3OCjWiHwj/oVP0hLtYN6hRD0GODBg6vokBDrRsZExIfizM8JXTRAPmxMUvbTBFYVEWiH3I4QVVhB0X1n41UtqcZWlDTyc/3t/v9aylJXcHDpm1dCfe70cKV45p3UKhsfCGVWRKybl5xKSSFZYBAznGB6ZACAi0Miqgap6ejjW96rOscOzwjs5yeZs+ql1j7hBOz87yjJchZwISAZ88wtpQ8AwokuYwGwl2HB6JNuuhJITOfvyfVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcJHjD2OoyPgat8vix+7AEutK7vRA2CV3VcISITycas=;
 b=NnG+9+oaatWH3STYTvQ5Fj6SSmbAqq8YCjsK/pe+2iUz4TJ62I4nlivQ/Zd2mGUuGROQEZuqtTgnvhwbWk0mUm1movI03ZSK521ebinh6M7gtca96r3C/Py+K4bgzsskffPrK15zp1XGUuaAXSx/93Rw49tDg8uls6fZ9z5M32H0Cb14tj/nWi1hal7HA/hSHOWg5D1T8eCN1IFU1l+8db2SjhXxtk+e6Ahak8ly37tYNMqSstHL0gkqOlGfsADHYICCvlSjmphsk527dmyse6mlYFWpVIMeO+P3kS8X6xIBUKM2xfZhWHF0Gb3IKGtGSseO2IlzJYpq5TrnCmTT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcJHjD2OoyPgat8vix+7AEutK7vRA2CV3VcISITycas=;
 b=n4hXTvTJ71StOj7COa5bg/0i9zDM7istmIICQdDTeE581efoxfmk4ijwsn+3RCOPuXx7T0LYlEChORDxnEgSSsUBj4ViwVQE3F9MUZgsg9fLD+7eOe0XSDSI/5LX9smoam5rOi3d0BNUtT2WgmelzMng8nIlW4p4nGEtdMobCwnziqcuh4/BwaTTxFlXvgLAT785c5/FMpv9vvHFuZCQPvf7s9gibGyqZcbJ8v0h/4AXTgQl2UbpMvPZHFPa4v6ohlikr6ubPy4QNdrVjO5OJGRz3ELB/duxHO9NRhCKHjEIYUGH1GmSJBZ4abHhAiHqifZBVTVzGEISqDbRMoEMzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB587270.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:cc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 02:50:28 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 02:50:28 +0000
Message-ID: <b81abda5-e882-42e8-b780-6db34fdd0092@efficios.com>
Date: Wed, 11 Nov 2026 21:50:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] srcu: Add irqsave variants of the atomic SRCU
 readers
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, Kunwu Chan <kunwu.chan@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-5-mathieu.desnoyers@efficios.com>
 <0f5b9d22-353a-4e30-91e1-aeea47461583@paulmck-laptop>
 <31ba97d2-f02e-4c43-a9a6-5ed49263c511@paulmck-laptop>
 <9207ad1c-fe1c-4041-80c2-52723bc58486@efficios.com>
 <9fc742ab-457c-41e2-ba05-0ef0bb15d00b@paulmck-laptop>
 <fc1bbc25-a410-42bd-b5b9-d734d2444b70@efficios.com>
 <78c1a437-ee80-4e83-8806-a7f7113a4b63@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <78c1a437-ee80-4e83-8806-a7f7113a4b63@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::8) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB587270:EE_
X-MS-Office365-Filtering-Correlation-Id: af3b0937-b625-42fd-d33f-08df4067b563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|10067099003|4143699003|56012099006|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H5Pwf0BLk1uwk25rkvOsVs5B+47eS75AqGszNjK+ovLf9ofR6IaSrLp19fb0tEJbl5GR+trJL+w2oeRC2w60rv2bsqbDehJukwY3WsNSTOzch2Kx+HZiO2UVkgk2jgT6ZH3ZU3mvjyhBFjm6HIFv3cwBAqEF5BPtLRWA6y84aK1MZ5locy9TfA1j91cBBFsnosTDZ3AOB4Im/O11ssFg0N5TpP4aTvulCp6Z2JrBrPjIqyUDAiOEeMVWI3kBmHKA4+aLK44BM+12FDTUKQCW26tEf/ac0nFjqoX+0O774w7dFt10l6h5eqEaS81X9ZMgf2a2f5nyFXNGxzcIgI/Eb4uOf0luLoFieQO4V038FCPX7W/zq+mL3rY2/NX0ll2WTAVQ1OoS6PaoaamKETKjQ5oljPAwgSsDysXC7FZ0O+CS5gSnEFiIRSzwsRyyC/lYtvYuyQUKVd35MakNW+pLDFFVBVXj/y5OZlUGXLh3SoNvml2UiY5pjk9J7QBJhxr4qj5QoytQXPlUyplElU8s4vjZhJBI1OFdUj5qKt0XCAwzpImjcXYuaWhrVidWyw+CnqWr+KL3CDWL6sVpxjy1f/BDDbiA25SlOAZ3Raplhjo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(10067099003)(4143699003)(56012099006)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmZ6VUE3aDhSd0drZFlnNmlPMHBwMmhBNW40TGh3bmkydWNqdkxFcTJacTF3?=
 =?utf-8?B?d1pNN2xLTDMyZkZsUExHR3BzelhFOUdsNkxBT29NQ3BFaEhwdERPaWtua3hl?=
 =?utf-8?B?bnc0Qy94MllMOVpNdmptcCtRanJKYVBJcVJ0TStEWGk5VnlXdm54RVlNclJB?=
 =?utf-8?B?OGl0cGM0dHpBT25FSEtBd0l1VklNNnEzN1QvY3pQWStVelVsMk8rb3NZdGZX?=
 =?utf-8?B?aXN5U2pHQklySFJJM1pyVkVTQWthRFJLVTltUnZZbTlJTHFxY25rQ1pxSmlm?=
 =?utf-8?B?blQ3eXhNRmNLN05hS3FCYkVDWm5xNzBocjgvRlAxQm02SWFEd1g0M2xVbDhs?=
 =?utf-8?B?VHdMbUxpSTJsSW5zYVhFTXF6RE5hZUxwQkRjT0p2S2w3bWVqUkI2MUJKa1Ey?=
 =?utf-8?B?Mk5vWng0N3RGVHlaRHA4TWg1dFVZdEJBbkppM2JxQnR4MEZjWXpNb041bTVh?=
 =?utf-8?B?b0JaTExRbWZiMUoxZkdXUll3Wk1BbHluMzVwTGYza1FuWUZyUmlib1dDaEdv?=
 =?utf-8?B?OGw5akw2TThzOE9DbHVMeCt1ditnaFdXVGZrWlp3TEFIeU9kcTQ4bU1ETXNa?=
 =?utf-8?B?M2diVXJIY2tyQ0RCMExtTko5WC8rNnhHY1JFNWdUZjBVbFJVU3ArR1RWemlm?=
 =?utf-8?B?ZTVXSDgyTkwrTjZsRklNZzdHQnlQUFBaVExTUVV3anZmVFRNNVNjWFpUdys2?=
 =?utf-8?B?RTR3QWdCMFVERC9Ea3FXeHFwMmp0K1Z4L2xoUEp3ZzhIK0dTRVIzZm44QVZz?=
 =?utf-8?B?NXpmL2lOZDF5VGpmOUE5akhNYUZNNlJvdFl6MmVtL2w2NncvbTJFWmNaSktV?=
 =?utf-8?B?M0pod3ZDdmZoVTQ5dnVqaUcwZm1GdjBjSmt0UlVTZWJPZjdTelBFZ05WcjB5?=
 =?utf-8?B?TnNrS3orZy9YZjFiRWtRbXRQVk4rT3BlbUNiTVRmM00wcFNCMy9aVytjRE1C?=
 =?utf-8?B?UjVwZldJSzREUFgxbWNidkwzSDl0QmVkcTJHT2JST2M5ZWFNU2libGtWeWQ3?=
 =?utf-8?B?OG1HQVlmSUhNcWZNSFBraWNXZDJqUEtwQ01HTlM3Y3A2ODRJdzI3ZDhDQXlx?=
 =?utf-8?B?VXZMTDlndjUxclJwZVFBUUw2RTlkTS8vN2NrcGZtVnBEaENlaEpCWTdWdmpV?=
 =?utf-8?B?ZUVoWVRqc1BlQ0VocHBvTStUVlJoL0xqUmpLMkdFem9TZDlRaGk5SFFSKzlY?=
 =?utf-8?B?UTM0ZlRzV1RwWjlsSi95enBlUUtIejFrV3VBQi9ydDZqbU1neEt4OUJZenlM?=
 =?utf-8?B?OXJVTE0xc0QvQTVwY0ZWRFdyUzRUMzRDS1ovakZ4YVNRT0Y1ZnBvWHV5ZjZp?=
 =?utf-8?B?WCs4Qys4elBTVmlvejFENVRocFkyV3N5L2VNSnpiWW56eHJqb3VBTVMwbTA2?=
 =?utf-8?B?YU1kakphSTN5WjZHdytRdk1RNWRuUWtVSGM5dUNxRjhpTGxLbXAvclN1cWR1?=
 =?utf-8?B?YU9GMU1DZFFUQUw4V3RSb0pIVnc3akhBRC9kZGJpaFFaTjM2MFFCVUpGVTRk?=
 =?utf-8?B?K0k0UGcwT1ErSGZHVkxjK1p0V1hQam5WTGZTTXZsNEVLaDI2WkUvUW9YVFZz?=
 =?utf-8?B?c21XR1VEc2FHeHlOODBmbm9mQjg3OG5CMkFnYytpUWNsdHFLMUxGSlRZRnNM?=
 =?utf-8?B?My9vVmFPc2k3VmVlWGdUbWtZUmpTTS9MakdWWVQ1TEY5UlJ0cThKTFowM0wy?=
 =?utf-8?B?d3E4azR1aHNGUTd4blI3RnAvcGdHRHBLWlZRczhLbVNtc013dzdLd1VxSElw?=
 =?utf-8?B?QjBkMy8zS2dSWWE1aTYvc0pKd09acCtDQkZJbnk1SUpmRnU2ak9RU2Fxc2xQ?=
 =?utf-8?B?cXo1T0N5TlZwa0hoN1JqSXhxbUJpV2loS1hKTXZoWWdleklBS0tMY3FDbHBN?=
 =?utf-8?B?QVEybkcyUmhpL2JoaWRhekRDd25vM2JXNlF0YU5WbFRCbUdqanowTU5nc3pC?=
 =?utf-8?B?d29ZZTVUb3Jzc3F1SkZHMS9rQnJGcS90eUdsbFREWTZjcE1EdWhzRmRsdmFo?=
 =?utf-8?B?VHRCZjRsSmVQcnAvS0kvWTdQa3dUVmJobnpXYVdzYkRPc0xOVkZsajlxMU5L?=
 =?utf-8?B?cUZBc3ZOUjA5bmE1NzNaekxOTVB1bFltL2d6T1RPTzlaT0x1eFVWTGJGb0dq?=
 =?utf-8?B?M0Nldk9Vd242WnZ4WXVVZHhVaXE2eEd5STM4c0tKcGlFV0Q4c2h4ZXQwcmtv?=
 =?utf-8?B?d2JRZE1NZnRza2h6Wlo1M1BRZ1ZqWFd0akk1LzRiU0ZpMEYrVnBUZ2pvYmtS?=
 =?utf-8?B?L0l1ZTNnb0JUbHhkM3RwTlliUTRLMGYwSVdWdW1zbFRjZUlOWkxXUzh6dUtt?=
 =?utf-8?B?b1lIajJ3clZaQkZDY2lEOUtFMWFicktrWGFSd0phRThEUDdzMmJ4ZndaMjdj?=
 =?utf-8?Q?M+7lwm3aiuUcPW7mMYrslyiN640Dmq2Db6aeANKpk7OHp?=
X-MS-Exchange-AntiSpam-MessageData-1: GaA0c6OIwEI3AchAyXrrPXFkKhM25vtjNuE=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3b0937-b625-42fd-d33f-08df4067b563
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 02:50:27.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/SSHPbnOgxtU7XesTsyAzMieXJzYKbQP0hX+rn1EfUBZTLUTuuWeuiiCX59Rc0fj6zVR30gL6gT45GB+DOooZlMExDPhOkfwVeuHvadjts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB587270

On 2026-11-11 21:13, Paul E. McKenney wrote:
[...]
> I used the same trick that I have used elsewhere, keeping a separate
> variable for the tag ("--qemu-args") and the argument itself, as shown
> in the diff below on top of my earlier patch.
[...]
> +             --configs "SRCU-P" "${qemu_tag}" "${qemu_args}" --trust-make

This works on x86.  On arm64 both variables are empty, so kvm.sh gets
two empty arguments.  A kvm.sh --dryrun with "" "" in that place stops
with:

     Unknown argument

Dropping the quotes does not help: the value has a space in it.  So I
think this one needs either the ${qemu_arg:+...} form, or a test around
the torture_set call.

> I will add it there, also.
>
> And to the --do-rcutorture stuff as well.

Sounds good.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
