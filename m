Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A32F745E;
	Mon, 19 Jan 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857235; cv=fail; b=JJCBdd7ho+3R7M/GBhZJVFp1dHrLmsrAULoEgDhATlsLx1I/1CK3Uoq8c1Hexka5ipbshs9q8o4Dokza5PhZg1x2KhiJ7O3GR7jxn12GDjImpysjtwFmNMluK8cjLI/SlxwBiR7N3Xs824WaBY+BgyOAZ0hc7TdKYjzy7OoI0Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857235; c=relaxed/simple;
	bh=eVTY8zed6tgUm7RSynGT+/TBKi/nd6hwncH17nKxnUk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Message-ID:Date:
	 Content-Type:MIME-Version; b=npStG9CpfM0J2tVkYL9dvlmRcK1vZZUb810/rmEJ0bclyd4oUM7IgFf0+sZjrRMGcn76vVto1J19gXC9b+GfNX7rLqXqrwAzTg4+zxioOUWe15U0C+8qlZtKPzWiqk0k6CgL2oWhvfXhRyH2RkmBInJuJF0WCDkPH1Hj4ymSRmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DHJ6kasE; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DHJ6kasE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J15qFFm0Gg03AN0iazvHD5ZT/zQQxHZ7foEtJagLvii906dmEOaFXEZkQEca4+zo8qPtZ55dsv/abTVXoQ2lXBEZikUCjVfRAcudkmhF7wM9IabDFkWp3+57PAXT2lr2UzyqFaQ6+fgzh8/BC3E+bOBfOlNKWNAhjxBkFzFONQnbWlnrUP/HNQuXJeOFquDi/VdDLYxA9GoE7zPLNCrkSQgQygBk6yNAiEExd6zVAynl/wNuqR6YYLAH54kgVYAo2CUMJq2zCVQL0Q1Rq/pbkmzQSDq4813MCUCx8KPEhnOTSDlTukAMAu3s26z4ixbNWgMz4WH+RP0uAvFYomolTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv4pDiaxzO9TQFJyo8Ca+fsxdP9nj4nlIQG7Fv77+/w=;
 b=iTviOIzvASyMiU/jedXy71PD+rQXJxjA3fbmunHPBFRPh3xt0L58N5THK7tlgrENnAxutMb5+WCgdWOV4XRjtCC2MbrZkEjY9ZQ+lAkOLEnOTgG57uraml6vNcA2TfDups/cJtm2+nYXpPI2oq6X/mImlWobYzG5uZA8NZnNhi/Dj8ftLgtvp3vT33/TvnSg9pkxswmDw6zLpYnzaNQNX4x1M0Dy0c9q32EwdqZ46ZQ1tlnMW01s7KZsH0oXkhcxer1pJLxfogU2h8bVKlfOP+fdB+1+vVVQCMTLUdhaxtKrfQRFTktVlZjYviZDc2289nRDAWnr8Bka9q3PsUr4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv4pDiaxzO9TQFJyo8Ca+fsxdP9nj4nlIQG7Fv77+/w=;
 b=DHJ6kasE4l1UCCJFL/VHomSqY3kHYgHtigTFSRLtKAiYRXeHL0gB3svRf849uMs7Jf1YRJKfs0gJAbjmWfwJGsf/kLsZaXJA8n1EgV3QWkedkB+hq2/t9YrqlqiRj/qbL4R8/IdDVkLSK9LEBgMqdBrx1kOTRVzMJtyXav/igjepPsfG9h1x2IDitBopMtYGvswJCuL4N/Qfi4H3p1YKigRpVe9pI3OFscMw4kAz0KCSiFXF0R72ossO8NEaR3ZGx6t8bHTvnlwAEM6glGNKF0Lj2HTHVNh9js5T8PC+sJK7BbpkDU9n4K5LF/VVgqkvqa6+nlyJwm1/EtbH8/7uww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Mon, 19 Jan 2026 21:13:50 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 21:13:49 +0000
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug operations
From: <joelagnelf@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: <paulmck@kernel.org>, <frederic@kernel.org>, <neeraj.upadhyay@kernel.org>, <josh@joshtriplett.org>, <boqun.feng@gmail.com>, <urezki@gmail.com>, <rostedt@goodmis.org>, <tglx@linutronix.de>, <peterz@infradead.org>, <srikar@linux.ibm.com>, Samir M <samir@linux.ibm.com>, Vishal Chourasia <vishalc@linux.ibm.com>, <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <90ff4c0e-bef7-46e5-b183-54b2ded3b00e@linux.ibm.com>
References: <90ff4c0e-bef7-46e5-b183-54b2ded3b00e@linux.ibm.com>
Message-ID: <0299355F-E474-4892-AFC1-11C63B6F4FCC@nvidia.com>
Date: Mon, 19 Jan 2026 16:10:48 -0500
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:208:32f::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f814f0-3e3a-4060-0528-08de579fa407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6RQIQceWmPUjw+KpDblLVX2srzOTfvM2AgeHexR7sM08yR/zzcLufxfQ6+wN?=
 =?us-ascii?Q?S88f/TJz+ygCn/nc+tjpbIaji5WSk0B62SBYkp2MS4fUXTA2i1JhalOoE/hc?=
 =?us-ascii?Q?G8Q1+g698l4rnmQUjoKFRI/A8YzasucAxRIz12xgs6xvXmKNc/B3LmyqRrgl?=
 =?us-ascii?Q?7hn02miIJM0dcJKwew/NDP/efS20JGdOoLkhrs/+OazK8NMHp8a/7zLJzWQM?=
 =?us-ascii?Q?o7dcY3etqUHQmxQSydDN2qHEAj1dWMEb7DmYfpy55Y8L/PxPoCpzIjb418T4?=
 =?us-ascii?Q?r5ipNM440graS+3SPiIrPjY5uO0FAZKHRQrx2yPBhSLCaB59Lgdoy9+numKk?=
 =?us-ascii?Q?snQgRycBnYEcN4zt2taSa3KW+BmF0u6AwQ5bx55gLMed6+gDcESfDUpbgpjs?=
 =?us-ascii?Q?l9K2fYxWeAozcGESHTuHvNM98pXBMRbXbat/t+sstzHN/qLpP0OfMt2Q0OlK?=
 =?us-ascii?Q?KBVOxN9+MMxazDzw7zd9/PBy2nIs3+hqjgVg12IfA+qAl9y0YROHIi6hkUny?=
 =?us-ascii?Q?aFBB+VaHxdV5phjg5/6Mm4UvLVnz3LFOPJ5pXjx8rpkSIIBQHrztaHBV17ky?=
 =?us-ascii?Q?YARy5TxLVlWbYVyNUQGneekGMT/3Uw+jaKTj3+YmoMAmAAEnxNfTJmZJxB4l?=
 =?us-ascii?Q?bhdzsGlayzHhUaRC6iL6eT20SIhCHlEOJ0Vztjd4ffnZbUVu9rz1ZdmK5Mx9?=
 =?us-ascii?Q?HU1irvnE8y1LUvmtgiqelXKwHGf2YpnDeAxFVzQqFEsBsPyrDQwSBcNx4fof?=
 =?us-ascii?Q?tHtIFi5wR/CykNbkLllU/UqFTZ+Tc4WJ/CydTLAOYn+7UKl137xNhONJGMyB?=
 =?us-ascii?Q?jbmehe7e3nHexqNxCttLZvGGWmE19cd+zx82sP9JTpk4tsoZ9+RVa3u09Ifu?=
 =?us-ascii?Q?yeXuqFCCZLUlRyOYKKjCXtIuN6gk19HtanTJjl9DGDv/5uTC1w7LVZEJRgHI?=
 =?us-ascii?Q?CwLKCkb0/ipmYZJBBolCT1c9ma1Ot5pNFoSn712rDvSUYBc65lk4Ht3csKFn?=
 =?us-ascii?Q?JXxMFe12W1uyGAze7pGaesKf+Q93O36Z1BLk96K2KihAqvmC1tjI0Q7kUxc2?=
 =?us-ascii?Q?XjrCJF8Mn2hV8tqygbXGOu4xmxRWGO+VjmOJusMYMyCKy1Djija6UsOI++Tc?=
 =?us-ascii?Q?MROxBHKDwCYu0fsxZ5ZfSVIQcnXq+3IWKhQsxc+1PVzYhqbKmunOTaOpCOAo?=
 =?us-ascii?Q?xCf8GV7JvxgFhVAmQzV32g50vy+NxgI9qtj+KvUnGhvHYiD8EvPvUHp4CPK9?=
 =?us-ascii?Q?3/rpZSr3fpGaOGDTjpy0Ikl2cMGWu41OcXrajVKxg5A5AQSqEBAK9vZCjad2?=
 =?us-ascii?Q?xFpM0/eOH9dHyqmUT71pKJ+gkFhoGnvKlbPf8/ofdFcP0/2J9dfqsePaE8oC?=
 =?us-ascii?Q?eni+jge/0HM+fzBKoDQMypV1ndH4sYeMYulAtJipBYfU6PM9Unckdpcuk9UV?=
 =?us-ascii?Q?IdKNtNnvJzHuo7iqFZ2Te9Nf4+cjZU7jvbeAOqNSsr4l8t0pkjlxd1HcPEND?=
 =?us-ascii?Q?bpG3I9U9wO5QYuQGSQmwB6MAMm0HNCq10AxMXdXXHAa1zjzPR2FPyGTDyvXn?=
 =?us-ascii?Q?dh+aEFFnzk/5eapT5w4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xpBk+c99JzP/bNQDZ3WhaLK+Q4V/7McWLgntY7dIG5GegKVijZO95lu3vgw+?=
 =?us-ascii?Q?rna5joVp8OTX0VLo06eHupH4ERR/84ljomX3Avc8g2AmQWOyvpM7YGVdiGOe?=
 =?us-ascii?Q?a6+XLdZ1XCXz3mnusx3Wq2daxMsQ4M1deEhJ2/5jPupNoM+uJ0jE/tfB0tfD?=
 =?us-ascii?Q?pjZpqHRYZE5fveQU1lj9pKvll19Fon4maiOFX5xN0qRn0k70y7jFnQf4AexL?=
 =?us-ascii?Q?qCUxKeCgkkFIbgvdtWGrv8VknowQzUka6KhIckmeqE0gBeT8MwlKysamFVNF?=
 =?us-ascii?Q?Uo/OvTrclKudP2DS/dVH0EyqNSfiJtrRrqmBlfR+Cgvtd08jCC+OoEBINx/G?=
 =?us-ascii?Q?W3p3n1CZc1CvS8HfZG/YhvDeWmWYbn8HkRAk1W450IXwy57hcf65QY5HiY0L?=
 =?us-ascii?Q?UAIdrN7+gj+JVsrB0727IEBnEYy69XJEMKOcLAnXP+GCUX2+6FOtQ8kP29yB?=
 =?us-ascii?Q?1/rAhflhVG2zAn7MUrFN3IarwVXsHxDtGhuUdQ9sZ+PFjyJlUF8mWAvfccey?=
 =?us-ascii?Q?HX2fDih9GihKaZD23IRVk43bgiyqK7qFEn3heHqEBPJxCr4wUbGqsDfPYEQv?=
 =?us-ascii?Q?r8ZAPvJ5lUooqEoXW44jDkbXV3a4+kUuBir7Edd1CFoeSP8eBT1LmfgtAWhd?=
 =?us-ascii?Q?Of4cyx1T6sTTJuknx3FzIKtMnOINraLc9+JkGAKX24DtVyvOWg+HJplK89eX?=
 =?us-ascii?Q?WhaOher7fuR1dAVGJBgl6ob3+1dowTxff42tBzKZ3j/Cxa0OYpMK7bggGMRX?=
 =?us-ascii?Q?D5qYJE4j1TI9pLEJRdwi59g/uQRTDvapETr/J8Mv9D4PUsn3glAp932dtkPO?=
 =?us-ascii?Q?w6Tm2AddW3nWyzd+4/4Lz1Vp+5pj2fgyMLOBU+JsaE+XSavTNjh+EtZ81By4?=
 =?us-ascii?Q?/vJ7OZeRo2PUp3CfmN4Cr7ECCvOeQEMKYey+W0yIMpLYmLLFeUhlEQEO1fua?=
 =?us-ascii?Q?CNWRgXAoN94RetivxW1dYf71YLvkoAjrTIbJDWYmGlQKxoDzd2Qzfvh2zNVH?=
 =?us-ascii?Q?q8LusFTWDN8X8Xj/dD+jfAqHtrOzv0/7AsmuDVQ3W2buT56MmAMzLwIN8Ezg?=
 =?us-ascii?Q?7gRhrPHSlDWJteYNahWYcYFALWB+2hyKu0VCvM8eDUfR8xZjV2hPqisPCRzF?=
 =?us-ascii?Q?jcScEnBHRCpthTjTdtJ9tX8ekNzgvy/EqaBGlegRANGKnatLqCuyC6WzeQnd?=
 =?us-ascii?Q?JwsF8Iae8njDK48czsvBO8Yf6Tev5Ein3W9FdGqV1GJHhpJEa5oAyrJ6V4jS?=
 =?us-ascii?Q?LBQQlpC6Pw/OcQNzt3wAd3xWgsqKEX0XgYlC00UUT+Qi4CiqgEhcYumZijNs?=
 =?us-ascii?Q?A+SMIiDW0YZqfvAj4c2IV1vVLHaKW97GBFk8Xp3hzdAfquNrfROFZ0qocXXg?=
 =?us-ascii?Q?NKx5RsQ0of+jWnKweQQmDQ5zr2ya/w0wy/UrdVTaRZ4WuP+KVlcT2EFMXmSu?=
 =?us-ascii?Q?7KolPPMRIlvvPmdSru8khPmaYeZ4VyqNkrhk1koIO39YJSbzqk69fwEAgsQv?=
 =?us-ascii?Q?0BEWfliE3Zb5hpeDDh2m8VBS2RClz0xrDg7t1lRsvk/HfDV+MT7gprN6zt7m?=
 =?us-ascii?Q?cJNnGnMSnb9RVDwILlM5sCPfOTdDXGhJJHE68ihFu3wxW5FmxZyIU41uGiVR?=
 =?us-ascii?Q?Ri7LMGajEGz4yD3axTHOBQnMjM1Cu6q31sa/Gl6LYv3of2v0Aps68+2qDD7Q?=
 =?us-ascii?Q?j4l2xiytSV1POhTbErAvuQmCRy+UdCZg+SI635ISU1OcRTAxwnOBsXh3JdHN?=
 =?us-ascii?Q?WRBtiisRWw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f814f0-3e3a-4060-0528-08de579fa407
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:13:49.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9v0D2Dzqheuof7TB2q1/JhyM70sEZdDqu4qwAtOtr4VEMtEOeGoAyV1MBODjMiNcUTe0x7/Q6fRofgwUDl/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226



> On Jan 19, 2026, at 8:54 AM, Shrikanth Hegde  wrote:
> 
> ﻿
> 
>> On 1/19/26 10:48 AM, Joel Fernandes wrote:
>>> On Sun, Jan 18, 2026 at 05:08:44PM +0530, Samir M wrote:
>>>> On 12/01/26 3:13 pm, Vishal Chourasia wrote:
>>> > Bulk CPU hotplug operations--such as switching SMT modes across all
>>> > cores--require hotplugging multiple CPUs in rapid succession. On large
>>> > systems, this process takes significant time, increasing as the number
>>> > of CPUs grows, leading to substantial delays on high-core-count
>>> > machines. Analysis [1] reveals that the majority of this time is spent
>>> > waiting for synchronize_rcu().
>>> >
>>> > Expedite synchronize_rcu() during the hotplug path to accelerate the
>>> > operation. Since CPU hotplug is a user-initiated administrative task,
>>> > it should complete as quickly as possible.
>>> 
>>> Hi Vishal,
>>> 
>>> I verified this patch using the configuration described below.
>>> Configuration:
>>>      *    Kernel version: 6.19.0-rc5
>>>      *    Number of CPUs: 2048
>>> 
>>> SMT Mode    | Without Patch    | With Patch | % Improvement    |
>>> ------------------------------------------------------------------
>>> SMT=off     | 30m 53.194s      |  6m 4.250s  | +80.40%          |
>>> SMT=on      | 49m 5.920s       | 36m 50.386s | +25.01%          |
>> Hi Vishal, Samir,
>> Thanks for the testing on your large CPU count system.
>> Considering the SMT=on performance is still terrible, before we expedite RCU, could we try the approach Peter suggested (avoiding repeated
>> lock/unlock)? I wrote a patch below.
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git
>>   tag: cpuhp-bulk-optimize-rfc-v1
>> I tested it lightly on rcutorture hotplug test and it passes. Please share
>> any performance results, thanks.
>> Also I'd like to use expediting of RCU as a last resort TBH, we should
>> optimize the outer operations that require RCU in the first place such as
>> Peter's suggestion since that will improve the overall efficiency of the
>> code. And if/when expediting RCU, Peter's other suggestion to not do it in
>> cpus_write_lock() and instead do it from cpuhp_smt_enable() also makes sense
>> to me.
>> ---8<-----------------------
>> From: Joel Fernandes 
>> Subject: [PATCH] cpuhp: Optimize batch SMT enable by reducing lock acquiring
>> Bulk CPU hotplug operations such as enabling SMT across all cores
>> require hotplugging multiple CPUs. The current implementation takes
>> cpus_write_lock() for each individual CPU causing multiple slow grace
>> period requests.
>> Therefore introduce cpu_up_locked() that assumes the caller already
>> holds cpus_write_lock(). The cpuhp_smt_enable() function is updated to
>> hold the lock once around the entire loop rather than for each CPU.
>> Link: https://lore.kernel.org/ all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
>> Suggested-by: Peter Zijlstra 
>> Signed-off-by: Joel Fernandes 
>> ---
>>  kernel/cpu.c | 40 +++++++++++++++++++++++++---------------
>>  1 file changed, 25 insertions(+), 15 deletions(-)
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 8df2d773fe3b..4ce7deb236d7 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -1623,34 +1623,31 @@ void cpuhp_online_idle(enum cpuhp_state state)
>>      complete_ap_thread(st, true);
>>  }
>> -/* Requires cpu_add_remove_lock to be held */
>> -static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>> +/* Requires cpu_add_remove_lock and cpus_write_lock to be held. */
>> +static int cpu_up_locked(unsigned int cpu, int tasks_frozen,
>> +             enum cpuhp_state target)
>>  {
>>      struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>      struct task_struct *idle;
>>      int ret = 0;
>> -    cpus_write_lock();
>> +    lockdep_assert_cpus_held();
>> -    if (!cpu_present(cpu)) {
>> -        ret = -EINVAL;
>> -        goto out;
>> -    }
>> +    if (!cpu_present(cpu))
>> +        return -EINVAL;
>>      /*
>>       * The caller of cpu_up() might have raced with another
>>       * caller. Nothing to do.
>>       */
>>      if (st->state >= target)
>> -        goto out;
>> +        return 0;
>>      if (st->state == CPUHP_OFFLINE) {
>>          /* Let it fail before we try to bring the cpu up */
>>          idle = idle_thread_get(cpu);
>> -        if (IS_ERR(idle)) {
>> -            ret = PTR_ERR(idle);
>> -            goto out;
>> -        }
>> +        if (IS_ERR(idle))
>> +            return PTR_ERR(idle);
>>          /*
>>           * Reset stale stack state from the last time this CPU was online.
>> @@ -1673,7 +1670,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>>           * return the error code..
>>           */
>>          if (ret)
>> -            goto out;
>> +            return ret;
>>      }
>>      /*
>> @@ -1683,7 +1680,16 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>>       */
>>      target = min((int)target, CPUHP_BRINGUP_CPU);
>>      ret = cpuhp_up_callbacks(cpu, st, target);
>> -out:
>> +    return ret;
>> +}
>> +
>> +/* Requires cpu_add_remove_lock to be held */
>> +static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>> +{
>> +    int ret;
>> +
>> +    cpus_write_lock();
>> +    ret = cpu_up_locked(cpu, tasks_frozen, target);
>>      cpus_write_unlock();
>>      arch_smt_update();
>>      return ret;
>> @@ -2715,6 +2721,8 @@ int cpuhp_smt_enable(void)
>>      int cpu, ret = 0;
>>      cpu_maps_update_begin();
>> +    /* Hold cpus_write_lock() for entire batch operation. */
>> +    cpus_write_lock();
>>      cpu_smt_control = CPU_SMT_ENABLED;
>>      for_each_present_cpu(cpu) {
>>          /* Skip online CPUs and CPUs on offline nodes */
>> @@ -2722,12 +2730,14 @@ int cpuhp_smt_enable(void)
>>              continue;
>>          if (!cpu_smt_thread_allowed(cpu) || ! topology_is_core_online(cpu))
>>              continue;
>> -        ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
>> +        ret = cpu_up_locked(cpu, 0, CPUHP_ONLINE);
>>          if (ret)
>>              break;
>>          /* See comment in cpuhp_smt_disable() */
>>          cpuhp_online_cpu_device(cpu);
>>      }
>> +    cpus_write_unlock();
>> +    arch_smt_update();
>>      cpu_maps_update_done();
>>      return ret;
>>  }
> 
> What about cpuhp_smt_disable?

Doing this is not that easy on disable path, AFAICS. Considering that the enable
path in the performance tests was much worse, I wanted to contain it to that.

This does not have to be the only fix though, but one of the cures to get there.

Thanks.



