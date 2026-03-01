Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6244430BBE;
	Sun,  1 Mar 2026 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772359919; cv=fail; b=Pjwwiwj0VmkjnCp+n40XNIqRXcbbXa9wXuFjQH6/FsFjaygdkRbcqZnz8Mk5oUths2EKyC5lP/8s7cg4XZSuddsHkvcQONzrT59ceXZZGL//Ot7fR7THRiZfSO10St2yHVCVus+PnTpcIHmOjoxBV5zZySgmVAp2snZQKf6tQ8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772359919; c=relaxed/simple;
	bh=EHe0UE0bRmkATUy0Afdf1ihQ874anly/Q9Y01/bvLQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s5lcbFy3soSbQaD36Knw+ynxRbnoSULMkaP/zjhUjcsjf22COh/MqTOesobCGeQ5wI/jiL83jICu5iqa6BdXuUutq2CKx1Y1mHlFayp3Bauv5Lt/o1m0IA0WgoWaMXydka6gBm10ucWdSvTMZx/+5lVn1W6Yj0VnkiuN9qY3W4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WV5SfHI+; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WV5SfHI+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ml4bBRenO2+ScGHhEwHTZ0DJMGyEz0CmTr0G/Rf+OCICq9fPLYLnmdWoaAoiYwyh1+YJoeeNXahEvyBQjnynlbfgA6YV2CTGp1xXs03J35bZndXwwXYNNALxT78PeLYbRThq61EJ2/a/1hX040oQ8GTkas4HDOW4PAgyPimGpa7JvneW//SS6aTcjNxsZajT3nYZewPZ7ObJ5OG6tJksxk39ICeTbZb4eOsyh+am9+ZVkHbofFyW9WsTdNRVu45vSEG38S1oKliD5tsidjSOUd3kMXPQdia6gwMLN7ZZpCiVNmKVvmC0ABrjSEmDP70RjODPWfM/RtuH3LZwu9pnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l5cQPY6HkLJpA50vPh1NiHWtsxMdwHiIWyzPKBnx6c=;
 b=udJsoBIL65+VjJzjM9XVy49QeUz+eKusrn9+6f/uo25GIX1JQCoSuNgGbntTyyytMf131VoBMh7i3zcw75gph6T5pcLGyBp2gBNm5GH6D2AOxzTLxz2kItJ2eNSNhbctmIfK9ZGnlzbcVvSAQUSOO5uEoArPvvmAsGQQM/e77LgG2WZW5Q3fQ37kIePT0MS8MZnfZCN94XVeB+FFIHwN2QoDstY/7PJYcSLwq3Pr9Cj3oJsoD2mZXI7g4iHUyxoKSm0OWJV4h203efnpx2/u7VhHQ3J7d4abklr173Kv6Bh2hRJEXWxXWXcntaHGeJU0JTYx2TnRGBzIlOrXWDmY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l5cQPY6HkLJpA50vPh1NiHWtsxMdwHiIWyzPKBnx6c=;
 b=WV5SfHI+RrUoNQgVz1VYyUeiyL+CwdbgpwXNicQe1MclgtekV0P5tL/bmIi2SCpBXpXLnZRm1dE6T0BWJ9IaRcsc6B85hy5vVmMrGCkGVcvEEIFWVq6HezZ1U/X1C0bopHJKiihLFhUi3phWrnWprfapeu8ivCq6mqZ9v6gljeLc0iHxCPM+/T2tOPM9619X4t7PGrFr+syfLAF8Ss/MD5ZfMrn3Z7ggEkbodVuYKMov3Y1pI1bsuEqZjcyB7wnJ11QGtzEZ4JG50KKar4CgfRwdXojZYzIW2Z5C6ob0FEKIf5DW+YIBAHdf+XZbZZ0ydFSc5lWkipp6t6dcb7CQQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sun, 1 Mar
 2026 10:11:53 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9654.015; Sun, 1 Mar 2026
 10:11:53 +0000
Date: Sun, 1 Mar 2026 05:11:51 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH RFC] rcutorture: Fully test lazy RCU
Message-ID: <B0408540-C5C7-4AEE-AF5A-545EA50CF7DD@nvidia.com>
References: <a7dd04f0-52ba-4543-a159-f989b851906c@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7dd04f0-52ba-4543-a159-f989b851906c@paulmck-laptop>
X-ClientProxiedBy: MN2PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:208:239::15) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dabd6f6-ebf9-4c81-61ca-08de777af5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	GMIc9sZY4JNqAAJwirFe+zU02/x49B+AjVQOvbz8ZCbzmU2fHwUiLivENv9eCJnaGtcxWK387QkMLqyu85hymtYOfGzmKzz/K/B8Eqr787DJAJFWRIJPsUXQykSb4S3bWx+Y5wJfNHS3IGW0pmeyQKUNjgvh/3YkNXVwBiyxNSLYGeEO53PszkPJ6FEoRzCAM86vecdsCiUZG9snGmNvEF5f2cw9IeqCfLaWhhT2vcL3H8XZuBG9DYWjPQuVYiJ5ROARHUDbtE0xH2Uzq1QAvspTUItAj0lqQZJfOXdpCvY0RXElAuM8eAi6NkCk6Q6I8d9u4ACWZFvuWH7uI0tlW+pOf9qtm1PAKVzfxa+vqywCUXkH1iU3JxNyPQVe49LZGg5Dk+6YKotEyNcpF3prJzQyXbLZ/Mf34CUAGjw6rFvaFoiIySAH7OFDj6JTSMDFb51UoAHNkB682n3LHtKjJB1h45zwVKKj5INHO/3nKKVEdt9eJ5+YQuT0bUNskPkAoPes/YVZDT5e/XvAISNfwM6+8CVnU4Edjov6ChmOMfcwvgl23SkIT79kSqohbhchOsQ/d7nAf0ku1qk9xvnsZARf/8t4ZF9PqHgRsNFWOUu4lhfUF2qLSGVQu/S4godGf6XvdD8P4Cj/dxfbMBXzP3YDS+41NBgMsH+ZyTWwN0b0FPLP3z0S4jInk+y/FkBNmz0TOTdambDiIMnjA83022u9rP4D/cWAWLr3xhblXBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDvj0psMnftvOnqbL8cjTcDjasbjXmydx0PtxjWtlDz4MCEEcNZohRUpM8Fj?=
 =?us-ascii?Q?OGDsO681DnKmG5ibZa+NlyzpXPBur2NpMjNTnzMjh8uDXaEBYbxjxB9e10Ti?=
 =?us-ascii?Q?nDx6gKyhNGfJJEVf2lPr2CCgYkDDRYntUav7d7PDiMMk41cxSbzZo0hn//OA?=
 =?us-ascii?Q?y15IspAvWtYhuFV/Tca54XyD8J5fLUiLGxF3fJcxfZaFSOeThYJ8ktPwqjV6?=
 =?us-ascii?Q?XPNJ5XonKRZJfBKnT4mRAf5XxMaQLF4AtDazTTlkMKp7nA/VY8k/9x8XrDRU?=
 =?us-ascii?Q?ADL1RK+pO/PpcSbmZGT8dUE3UNo+z1EfCiD3VXcNPu/7qTKXQQHO7HRhdk3O?=
 =?us-ascii?Q?xTHUfAwvk2kVC0LHobIExDl5yrLSXcKYmmJ5wfUXcKLw7bf53B1Yi6gW2Ew2?=
 =?us-ascii?Q?y2r7hdTTwHEunomuXUy2lX2Ziag8QnqmQgwl74u7wTvXTEpAtQlcrxLf+5gA?=
 =?us-ascii?Q?zCLlwDe+iGiuWxtiIBRQVLRObkBOc16lryGKZrwh1mLp8LlLsgYmt4iAghuP?=
 =?us-ascii?Q?GqpwLCc0Qw6gvA++zu8qSOT/VWfGj5Y/dn05XuEZAnOe03Ro+ujvK0FbniJg?=
 =?us-ascii?Q?3wjjcsn06pT8aadfQAr4mHtMQSjjQChH6LegDbtxy342wq0sqE3KG4TvwRbM?=
 =?us-ascii?Q?/4f0WPejn8dB8Q3KBGCDKB69VRPeJ88TR8BXhFlQ5/jbuZPrzcFhdMCwhyZQ?=
 =?us-ascii?Q?nwU/a4nRCI3AJoctwT8yzIW7OBTDa3AhnJu8Yo5U4hNC/ORKLE1T10RXOEmo?=
 =?us-ascii?Q?t1bMDShQcyxOCRqYetj78mOPTa3WyWiiTuLKDcCXbKMaMIluL4arC9h8mdHx?=
 =?us-ascii?Q?F3ZGg4Bs0N16JJKVvJBpgITo46N8nYIgDJcyuh9586cpiKJe4bdt4H6fOJEH?=
 =?us-ascii?Q?hkMErtf6EZ8qluhSqwfWEUJ5zf7OdVvP5owGc3dYitKqtQrjFx1pS2Cz2ezS?=
 =?us-ascii?Q?njuxsMkXpXTBris86LC2X7GfbsQ3WkA0DrXCBg21ycb8izFY3y0D0DVq0ULH?=
 =?us-ascii?Q?g1goPy1NPHNDCwYlWH4w+7vFBuZQesXw67LwFLzdt+e7t0XXY1Y25Gv7MY+g?=
 =?us-ascii?Q?vGQOEXoyiF/SoXzqrE2Y/xYuN+C6wPcwUNzfx7PYxCNO7fFGXBqNwOiOTFqb?=
 =?us-ascii?Q?uwhcu236RGR3slFXwZm9YT1E4hmSVGV1U/s2dnoYzhPdAxqH/YBTdWCJdFJH?=
 =?us-ascii?Q?hYUCHf1JMMj4azjGOuE+D4F7rFKTkfDyHcVZ58ghu4e+FyQpafXqwctrFBgp?=
 =?us-ascii?Q?BuKr0wwUAyzhtVA1LFL2+iFvUp6eOgrQee/bDz+z1IlRvlpF2JzvKKxj9MgY?=
 =?us-ascii?Q?+PRk9ZxtursO062rrpLRYP9BX+kOqCmhTQyr+2U+0AxKXhD01eAIwo4AhCYp?=
 =?us-ascii?Q?w/FOGh/13Gb8KyykeYaTfDO5sXKq5JtwUgMdWNsBPdubXdngiNTiosaUXe2t?=
 =?us-ascii?Q?4Gqqv7RrVH0gXLXmlNEifUeSfYRauWOyQMHKSocdp5CLVJhA4nl3L2qCbPP8?=
 =?us-ascii?Q?+5VDoAymm9NpiUuh5qvWJYNBaNh+vnfazS3cnTU/UjWEY8mC4CY+3C8zUtK3?=
 =?us-ascii?Q?bkYylZT/I7wE2qNZRyVLeqXIwbTTOslqCRy9kwruET6f+Y8zQFqbYgwJpvx+?=
 =?us-ascii?Q?QmT9+fcKyWboUK2WmwPxVfkvQxYzgqUV8N0Rr8vEUiPc4AygDf//xpg3kiuX?=
 =?us-ascii?Q?VKdqJxmWG6L2lNp7mNpcRb4m9/Nxw2fVXnYV4sPCBPwBjVksa90nQ0AoosGE?=
 =?us-ascii?Q?F+H6jCUjRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dabd6f6-ebf9-4c81-61ca-08de777af5e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 10:11:52.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eF/w7B0zKG2Lnw5LjUaeSmY/mbaZ4qf76N7iAtnGKUICan4yOrvJEzo6kmarNbpOum3KUJof7gCcic/mnYLZ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

[...]

>>> 3.    Does the rcu_torture_ops structure need a ->call_hurry() field,
>>>   and if so, why?  If not, why not?
>>>
>>> 4.    Your additional questions here!
>>
>> Do we have a reproducer for the splat? If there is a link to the
>> report, I could take a look and investigate.
>
> The splat is on an old kernel where rcutorture does not yet have
> call_rcu_hurry().  So this patch isn't fixing a bug, but rather allegedly
> improving lazy RCU rcutorture testing.

Makes sense! I take it that on a newer kernel, we do see a splat with
just replacing _hurry() with the alternative, but without any other
changes. But either way, this is a nice change, so thanks!

-- 
Joel Fernandes

