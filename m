Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C321578F
	for <rcu@vger.kernel.org>; Mon, 12 May 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062488; cv=fail; b=BNP+y6/mG+A9rLQPB7QoBFIZ5KbNKopHBvGTqwELaaQ+piAzAXdsB6H9/5kqPCVEdG3RJ+TKZrKYHTuIsm1X3if2Gzi1WonpMIJCuLfxBP8ONSHRXbDT3KlA8vKTTmvCoWnqSPeFwNCyEzvcqPpMakrPM/qq17IYAwCvFMldAjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062488; c=relaxed/simple;
	bh=1U8hVrF3Itewo58CF3uzJ7TQizoz1zE1X4h2EGM5kzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/bG4gD8fRJg5UAkiQfeNP8eRXNdQIJS/JGZwCZyH49gjM2cwhBovCy8da26VGIR4CktDOxLN8mnnAGQuIYg4XPLzcgfOaTIA/mVxOUnLl4hIOFdcgSCSYAoMp15D/8f4Njpk/y6bgwska5KGPEg7MC8VyfplSoK1SkYHNGyeuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JKp866yb; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JKp866yb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaOlOqetf3zpADvtaYiA7A4a9lc6wIP6oPMcPUXs3BvlcR3wC30zTmFdvWikzGe0/mFe+aVeXC87q7K/U6CvFHue5qsKKlzVsH+urRkps+1FhgE9BS7Jf0deytBZ+1Q1FhjFxbC0byr+fFQWqxDau6gLues3+kFkOACV37b6+sV26rDa6RzAqwi5USMsJ/9kitbnlcop87VAixSpJOgLPx29OSb6tvv762fpeLWG/XziFupcgiBPDEeQTWMQtl2Ett4eDFJ/kHJCLWK7gFMCXqKhrdoi7clGrP+ZuoIztNI4tqh3nGzalWFtLcwHUtm+8HUmBdIH09jPC38Vz9g6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx38D+O8jFDXg13davozb5Xg4n9FcsmY0kimqKxlhaA=;
 b=hSP4uhmVV8JuP8siBqoC7H6KsEnYNWZl0YZN29ZW56ISJ4LptJPgRGXwSER+Iovrtwjf4WjIydo64MgTA9dvtNDP9CsyrWYaVIwPqD0fI7MKXDN9F//OoFAwMPwcMRwrlbZ4MEtkSEZ+SOxVAR7HF16bXw2wQGmfZxvSXbr9GJQBdfUzKjiluu7rPe2rub0AnFdhbBJufwf2Fg85ok2Xf67u3ysdQKoR1bbegB9FbI6y2TFzGWruLCtyl0OkhWTb3c+V7ZQI+/IC2qA9x0gF9uEbak7qiAB2MRqJWc1LFN1TbAhA7CxrFzrcv+Xf2fL/DSVGxZfbxVjqRqOSoCQ0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx38D+O8jFDXg13davozb5Xg4n9FcsmY0kimqKxlhaA=;
 b=JKp866ybMONYo9YyH+Wo8LvjN8SjTLOWbnjvHIcn1mxDNPFf3xAE8GYMN1pXRGtI1DL6ImbAjS0WJzBIzcLBFOKzx4gwSwO6efV2AGJssurooFFWySss0JClOF0m2oB7SA7u5Uh3/O/VmEr6Qwpdl9UkEHdgZ8aO6FU351dzx+U6OKn4Py9Z6AcKdooV4M/RXncauiI+XjEQcljZ63LgLxFPiJqwjFKeDzbq6w5uFiqQRm+ZR4fh4rig8l/vPlJWFQ08431YuajC0IvoyiR5h6EfMbhmmaul4q861VX7uLrgL7ahABPCeZZBsUgzCpP1qZfSsCDWQo3UcwdkVIuA9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 15:08:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:08:03 +0000
Message-ID: <a61d791b-540d-48ab-a20b-83e2ba71226d@nvidia.com>
Date: Mon, 12 May 2025 11:08:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] rcutorture: Perform more frequent testing of ->gpwrap
To: Akira Yokosawa <akiyks@gmail.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org
References: <20250421174717.3332525-1-joelagnelf@nvidia.com>
 <24beb2bb-b168-4849-804b-033c20ca352e@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <24beb2bb-b168-4849-804b-033c20ca352e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c57b488-d4c5-489e-56d3-08dd9166caa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE43NTkwUDJTZ2wrSjVHVFNrSXFncGJwN3pONDZJL3VUWGFoMVZreVcrSTg5?=
 =?utf-8?B?cGpwVjBmV0dWaHFleDNwdVl1akpneWQzVkFYTzcyd3dFUGwzSVYyb2FtUCt2?=
 =?utf-8?B?SkNNS0Z2Wk1KSlk2U2lRbkxxZE9CenlEaVFFZmRpbnh5WG5qTjlJbjJyaWJ5?=
 =?utf-8?B?bmVkNlZJZ0c5QjBCeVFMUW1yVFozRS8yWCtLTHZOMmtNRG04OWEyZjBQOUtu?=
 =?utf-8?B?dE56NkxkN1NCUTdsRExvcG1kQ3gvemQ3Wis0dlEyeFV3S2hkelE1MjdKdEJT?=
 =?utf-8?B?T1N4UitDYzRrZEJqN2NZYXB0RXBCdU9lQ2RXZmZPTDVJb21DRTNJczY3VDZj?=
 =?utf-8?B?OGJnMWg4RjJpSkUyQWZlejVZTHBGM21zSmpKZEo0cHVVc0pnanJOd0RBQnp0?=
 =?utf-8?B?bkZ6dHoyaFVob1ptLzdrVFdSTmI4cld0N3FiZC90NnQ1dVExUHdTOC91d215?=
 =?utf-8?B?dGNuNERRY21UQVFJUzluZmUyQ2RZQnFSVHR0TWVzS1RmS2JEME9QUURoOVhE?=
 =?utf-8?B?K0J5NVFQaHVlVnBrS3o2RHhNcGtvK0JVcytGLzZZSkg3b3NPNkdWbWJvNzdB?=
 =?utf-8?B?RWVhVGVLUExTWGZhMm5XZ3B6RThxWDZSWGR1bHBBVHBUeis1S0IrdHdKMlFR?=
 =?utf-8?B?cVRYcFpBczNFNUNKbHI5eDNNRG9va3BONzRMZWhZZ1dReGZiK1hQQUxXSmlk?=
 =?utf-8?B?SVl1ZHNRZHIyVGRrS2tJOUdXOTNPZVdGVTdxVjBXQzlHYXVHOVRtdWJtRmV5?=
 =?utf-8?B?Z2EzRWpHbVlkQXZSMm9tUEpIWUEvbkZWY2lHR2lzR3BtbnBMMWltMVZVQWVz?=
 =?utf-8?B?eE9Ka2xQMUtrdlFlTXJDZ1BnV2tLcVRJUkVoUHBuam44dnBGMDFmMkpjS0xQ?=
 =?utf-8?B?czFsY1QvNUxwd2hlUFoxcHEwT29NM1hXYjkyQkFwMTdRS0lYN2VSdWhyRWdl?=
 =?utf-8?B?cmpTZGE3MW9QOUVKWU1ZaDJ3TnhKVXlQL2hTd2dXcFJtRkNwNmwxYTZzeDcw?=
 =?utf-8?B?UnV3aU9mcFkvQXFaU21XYnAzZklQTHNtbDJBb1h6cmlnR0RteEp5ODhidzBU?=
 =?utf-8?B?RTNHQUtESEh5a1d5MXh2dGpUY2pKelB0bHRtb2c1WW8vdjRRNzY5UHBRZEZ1?=
 =?utf-8?B?UkRma2lxSTJHNTkzQUpDeUlhdEFXV0phREVIdzJudEp4VXJPMDJueC9WL3kw?=
 =?utf-8?B?alVTVFRnenJQbzZBVW5uQjFxWG05ME1BYmdIYWhMbHJ5VWlhTWxEVTRsUFgv?=
 =?utf-8?B?YlphZkNEWnN1L0dqdWFTSG96T1A2OXByRU93dExYWnpTTXVMeWM5blR4bE1m?=
 =?utf-8?B?SmcwRnBBblhiZlpaUHhMT253MjM5NUdvQ3BXaWdwM21wVGpCa3l3OXFQSS8v?=
 =?utf-8?B?bmhvNFgwWlY4WnF6dk84VWFxaDM1cEdtZWRwalMxYWFWSUcwa0lHQlljTnJX?=
 =?utf-8?B?SGdVd3VvTFdoQ25RNzhvQXZTWVZsWVFKK1pBWVNkZjRocEliVE5vQUo5cVkx?=
 =?utf-8?B?N1p6QUZ1NXgzWmxwTVNYZlZHcjFvaWNuanMrL3JjaG1XaUpPZkxVSDRNd1BX?=
 =?utf-8?B?bXlGLy9xY1ZLWmJmd1JQWXU0d1NkSEg1RkptWGptZktFbGFKd2lnVWxEYzAw?=
 =?utf-8?B?NEE1NTRqaGxMeDF4cWxzOXhJVVVWTWVPaytyWnZmQ3BjS2Nvd0Zwcld6VXNO?=
 =?utf-8?B?bUlyTmNZT01uYk85U0phSlEwZHJGRURSVktCa3pqcXljemEvNnY0dXJ2THE4?=
 =?utf-8?B?S2lrTFpRQ1ZUYUdadGNMTWFUSnRvQjU2ZEZjWGcxWTlWQXFIZzVGNjdwbXNn?=
 =?utf-8?B?OTVyMWJIWFRWTXIvandhYmpyZ040L3gwdXJxRExlTnlCcGs1cnNGanNqeU84?=
 =?utf-8?B?ZUdxS3VNVnc0eW93TG1FcDlDdW9hcXZsSC9QaWlyMnMvM2w2c0J4UTlnZ3VB?=
 =?utf-8?Q?vd2U0/fTgXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW5RL25MOEdtYkZLZzlSTWFEUlhFc1FGL1NUOU9mdWFReGZBSTZrZnVYNzNM?=
 =?utf-8?B?SDlTa1VXQWltaWdFREF4SEg3YlZhVXd3NGIzVGp1MnpNQko5YUExRS95OHBs?=
 =?utf-8?B?ZFpNa2tpWHQ2MkpzdDBFcW51djNkMlZoN0JLUFpGbDlVWVloOFY4Ukp2NFll?=
 =?utf-8?B?RGt2cVFKNFkyNmQ2Ukt3ZkRuUW5LRll6b2tGQmdMNFNkQmxBMEV2bEdTYllN?=
 =?utf-8?B?dFk0NGJyTStEYmxSYUtsUUhLKy8wZXg4NTk4cGh5a1hIQ1I0Z2lyZVU1R2Q2?=
 =?utf-8?B?NElpMkZnZVZqcGJqR2lOMk9RbVh3VzJzVXNuVDNFSjdXdk9oK1dqTjR0M0Zk?=
 =?utf-8?B?aWlxZ2VtOVJQNTc5Vy9NMTBCL3RHSWxxOGJWMUY0STlJbjl2Y3c1ZmdHbitX?=
 =?utf-8?B?dG51cnU2bmtJbXNVYzMyYm11WnA2ZTZRYVNobndKWTZ5R0J6LzdHREdoOWk3?=
 =?utf-8?B?VHNYcEJSOGdKbnpQQi9GL2NFeHNJMzlhdDdKbVFzUXdScWE3ZDY4L1lGdW9h?=
 =?utf-8?B?RzN0ODN0RUw2M1huUU4zTURrbS92WStwVlJ5WU5EcElueHB0MEJKR0Q0b09u?=
 =?utf-8?B?RkxZWnRlMTUrQS9mc3Yxem5NR2xoNkVQdWc2bU50TGt2RS84Q2x1dHdvR3M2?=
 =?utf-8?B?bnVWOW9XT0xSMFdGbGh6MyswV0FvME0wR3RUVDN2TjZnNmk4TktPVjNNVjY4?=
 =?utf-8?B?YktPMGxDZnY1Z0R0anUrY09FSXFuRmpscUMvS1JFaDIzVzJQa3J3WkQ4ZHVK?=
 =?utf-8?B?Qm14MTJjNzFxSjFWMnFTOHJxYmtKYk1VQzJodDlLYjJoRHdYZ2JXbVFEbEtH?=
 =?utf-8?B?WWVDUHlHSUZ3SkVIZm5DeUxCclYyR1BOTmhrUnpSUjdGdjJ2WW5vRUVsTmdn?=
 =?utf-8?B?TW4waDVRRzdOM3Z6dHA4NmVxNDVGUzZsV0xLNXVpbG4wVG92OFRKME9DQzl0?=
 =?utf-8?B?a1Y5N1hBWG9PNXpqME1hdUcyd1p1a0tTK1RaZHBDeDh3QWhxN0VzZTl0UnBq?=
 =?utf-8?B?amIrZFJzYXVFeGdhK3VYOEwvK0o0aUJuZDdjUGFrbWJBaE5KeXEwUmJqK3ZR?=
 =?utf-8?B?L2hoOFBoNnFnVDh3NFpWS1pJL2dDVWFacFQ5bmVUT1IvSXo0ZVBKTEtoSjJx?=
 =?utf-8?B?Rkg0clphK2pBZGJsSWRlYnBYL0VTWnBTSVhFblRBbVFYbFBYRVpGSU1leVJ6?=
 =?utf-8?B?a1RlUUNTQmhYd083SkE2ZWtPemJSRnhIcm9CbWVQL3VHc3BwY3F3bmkwWU1G?=
 =?utf-8?B?dXhOdnp3cVVsaU5zVTRRLy9ZUlVoV1BTcHlFM3RKZk12RXRDaGpzM0lWRlhN?=
 =?utf-8?B?Wng0cU5pTVAwVHkvWGNOVi84cnIyOVVtdmw0MDF4R0tDVFF2Q01GQ05jUUlo?=
 =?utf-8?B?OE9HY0dENDZiMWdQcW5PQjM2RWl5UXpuZUlvWFhOTWxZQ045dkxBVzhjeVA2?=
 =?utf-8?B?eEJYcnFGUVZGL0FwOWdVRnZiZGhyRmhQanB6YmxqcW56ZzdVMEZvcEp1NlJH?=
 =?utf-8?B?VFdPUHdwRENoU3VnYTN4UVptalY0RXEwWmxtclA1K2Vkb1Q2QjdxZkZQc1c4?=
 =?utf-8?B?MEkzVVo3YWVPbVc3T09RTStXQ2o0ZWY3YTJBbFZwbHZHWWg5NE5zR3VrZG9D?=
 =?utf-8?B?clZQVmZZc1l0eXdqV3l1UjhIWEpYcjhvOVFtOWdyVmkyREZMNWQ2Ty9IcVJa?=
 =?utf-8?B?bjk1c1FBTk80QTBURWY0TlhKbDdsNEZUaWo3T0taREM3bHMxN2VTMnFJekRu?=
 =?utf-8?B?OExYWHRtS2tFVHByN2dzNUwzU2hvLzlUbkhyVjdDalpCS0R1NDRobVNxakdh?=
 =?utf-8?B?YkRHelFZc2t1Z29IQnFZLzlFSWx0ZS9NSnFTNVZOdDJieGhZTVRCMDI0V050?=
 =?utf-8?B?OEswa255U1dnemU0dVdodjFNNkJ1K0xSem9SSFdBNTN5TE9iUVVuVW1lVW9M?=
 =?utf-8?B?cGVIWWZvWnNvOEM5RmxkNnQrcEJtVGRQOHp5NFcwOE9lZ0R2YUV5TVgzVTBv?=
 =?utf-8?B?bWxIUWs5TDhQSkhWK1FjTm0xenNKRGUzNnE5L3lFOEQ5QzBEbGxrZ1VtOERp?=
 =?utf-8?B?QzFzZTdPajdVSldhemlMVFpUWVYxMEQxQ0lPamlMdDVmbE9ROGtJekJ6bDZj?=
 =?utf-8?B?Tno2bThTaVdZSyt4UGNJanA1WEhlTGpCUnZCVnpaMHNEYVU2WU05TFE3M2lL?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c57b488-d4c5-489e-56d3-08dd9166caa3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:08:03.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5+Sdg399EvqTO5wa6qmzZmHKdW6bIjofh/mMjMJYk3yN/iOZqVIBp2xLmCc4C8WcjsS3JCBp6NaEHyB7Ap9HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960



On 5/11/2025 5:27 AM, Akira Yokosawa wrote:
> 
>> @@ -757,6 +766,25 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
>>  	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
>>  }
>>  
>> +/**
>> + * rcu_set_gpwrap_lag - Set RCU GP sequence overflow lag value.
>> + * @lag_gps: Set overflow lag to this many grace period worth of counters
>> + * which is used by rcutorture to quickly force a gpwrap situation.
>> + * @lag_gps = 0 means we reset it back to the boot-time value.
>> + */
> This kernel-doc comment should be in front of its corresponding function
> prototype so that it is recognized as such.
> 
>> +static unsigned long seq_gpwrap_lag = ULONG_MAX / 4;
>> +
> , so this static variable needs to go above the kernel-doc comment.

Thanks a lot Akira, I will fix this now.

 - Joel
