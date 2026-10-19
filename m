Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FDC15853B
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792369434; cv=fail; b=DDAOMxi1L3jOAGt1ZQkN42Ei5WIaUSSogXbqa152/cipBYS3bN0bpPfSYWI6Q70TuTYLi7Ndw4p5z2raqV4zv0WOM9IOQEcyJ21Vi34xFOQR0/ynyncp91w7qPGWGQqFjVM/KpJZ3j/4nUOFQ2Dbg3+EvYjVQhQ1d+RszoPvtz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792369434; c=relaxed/simple;
	bh=XlT7w0iLj43sX50z03VbPuPfwcvqOLxLG6qgtqcIPM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bnhaq48YUgZi8eC4jMjZ9HH273+3befwcMY8oWIC+Yv9WLOVX7mwzZrFagPLGBRRSjHTqMV6yxIPODw+/4yC+GFk2l/EQnU2N+WjkaGyFkGxIO0uTyaF8zaANouc6DuM1YsOblbYc+ZcZveY/nP36ZlvIfEE0POEGMU9h5LYWD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yd/OL7fu; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yd/OL7fu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTLJqnAChWhJYdat3QTQNtdECSC1ckdAikF/+7LfrSFaN/ck4hr8m3l9RnqXqLO5ORKQZPgvPsn2abztDscMClGvY3RQoyV09iDE/Q71kSAmcslcKVEeyt3DOWCRV1r1VAzqWatl32DysVKHXILQby+Slwj106U3G0tClCMRn/VD+C4hTsJNoFHT9WdUyzKdXi1xto6Xjw1C0F+fR7NrEcuado/bIOlUN465oCrp9ZG9ydpwxj8fmhYRrzCzW5LQjdNBX1SCscouVbxRvTfd4cnPS79aijc/KpkyN6mGEZwFIr3MRt66XQPfQjjOI5b7KUdhd6WPYPkmQtaMCmVdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSP22dYjTouTZfl+LiY631dzSxAc78FejPE0yLJlLg4=;
 b=oQ0X1bcJ/LQWPda8FF5f4jliQ3+1Mn4pRmu7DBnX70VmQDua091/aqI2R9OTggpIYTw6iFVRM9rSeXqeqYRu9Lu4SfP/1Jmt6mhOETW6YGEyGGUfSOP1i5zJUHVdeLySlgEDzvFAy0hQ9nBdywkAi6s6uOD112FaM5fvEmcaj8phlTDNp8OmpH2jwNK6lweMm+uyfjSHxpQYUDKp4lUPHSTgS7v0UBfljes/Xdqf+gCxnYtRMF6tV8+6UJ/bHheJ51LK+Gg5cJtI/n27UmlysftBwK5SHXqm+I3NrLwgQmfWoTsBKIgpFFcqij7i2UoaPM6cCDQA4c4HyGgwEIAU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSP22dYjTouTZfl+LiY631dzSxAc78FejPE0yLJlLg4=;
 b=Yd/OL7fuLPhQzMgH0EuTKAkUw17NgtPVlOAk2emB3GCDDKFT+fGVHTV9YYN+jAWvD3rZ5zeNViC3Vd4lfh9ixAZjk2lFzRrSGpuy1vYYHHykJYMPtO89hTY9YsLfRaph2RJwVx1TqUAviOfpGL00BuxNeUOgGIZoFZ2ODViK9QDdG7+ExvuA6zy/brWEQEf6qyG3TQVk0PJ8La/VUo2BLqHOs+73CvBAb5P1vRSlwPccgjsTOAx2N/VsvrRP8r1rToYMh+ZUSk0XzQvLxU0aAXJX73mMTNRnj6MElFPgDzByPpZ1q7C1t2oRN7mhCOZWPCnAbZn8fMyJEJ8pk2Ew5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Mon, 19 Oct
 2026 00:23:47 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 00:23:47 +0000
Date: Sun, 18 Oct 2026 20:23:44 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, rcu@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcutorture: Ignore KBUILD_OUTPUT in kvm.sh
Message-ID: <20261019002344.GA532276@joelbox>
References: <20261016102657.2347381-1-puranjay@kernel.org>
 <b18525e9-0508-42f3-8640-3177c5581926@paulmck-laptop>
 <CANk7y0i3CELP=xfu8vr4O4_-8ui9v4Odc3VimaSsw1nT16ub6A@mail.gmail.com>
 <d3d15a05-149c-4027-9e97-6adfb4659be0@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3d15a05-149c-4027-9e97-6adfb4659be0@paulmck-laptop>
X-ClientProxiedBy: YQBP288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::27) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 193a12f7-2134-48b4-55ae-08df2d773e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NcfNR/+9fzlpvM1kilARol3heqtwA3VbfOhenJrofyZEYfl0n8BgtTlsxhOakSTz/cYKn0FfvgM1nHnysFulnELqGAPwdti8zO0oZokvVNwStVfnNsk+WetwDlnI/ZarrHYnLUmSkHyH4zZmhKeeh3v1CxVgc14CaQNpLjPVYb6dLX1aHQnW0tnjaanaLxsePfzHABHbc7b291jBj10+4P7k7JJ9uPAD425Vq1yzBqDxMPJDhHjS2lLPvmb0aVaahgtNsgRgOj7lEgXZrMCFZ+d/IlFH6qImkcri9Zua6ZWD4IBFqI36xg+dZFKaqIcltQIg6pO+HEgmGa2xLX4oxRLJeVqtiqUCl4Hec0p6ClckcME5SmoOMvgHCc5EJstrNEomy4fEeinodh3k1D4TR4mglUl+KPZ8/vGkVqWAtFXpiGnGS9E/6POjS9I2ukonHQixuF/7vl7OfJ2JR+4bilrMkOsKDjA9oCbnOzyrQqwfT/oE2vpX4ruPoEr9JdY6X0Q6jJhLhO0Rg8FpUGuHFH+sFHum1RiTCclccy3aVthGTg0aIJ7irqFoOjO7jq3rBm/VlqfRiK62hVGBnCp0Ut2mHUvS12AV109lChYMk/T9/yw9Ad2CyJEc3yO6idL8FKOKdq9JXUY3l1zNIdfrLw4fryMFIyFL/K0mjsqv0oI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXlsTlRwa0grMHZvcS9Vb1BDK3drS0EwY3hsOWhNYXB5QjdpS3ZabWoxMkg3?=
 =?utf-8?B?NVppSWFtY1pZM3l5TDFyQURWNytvRDFzMTI4aXpvZ2M5WlhJTGVJUGpUMHly?=
 =?utf-8?B?ajlMZUdvODlQdjZMTFUyb29VdkZ3dkpVLzNTTTBQVWhuSFQ5ZFUyYzhXSE0y?=
 =?utf-8?B?WHRYS2VaaE5aSHZZeVdURkZDYXBxWHJSMGtyY25oUlJ5M2RpWVQwYVEzNm9a?=
 =?utf-8?B?bzRYU1lBdDFwQklDYUFMbWtSNHNmMnY1WjNqVFdnWEdmUFdibER1SzhDSXB4?=
 =?utf-8?B?TENtWldyVEhJd2YzSm1iQjJlVDA0U2xjYXBOZDNlbnpTeE42MDlSZThueEhD?=
 =?utf-8?B?MzI1dDgzTTdmd3pVTDFsK3dLTDhzbFN0YVBCK2syOVp5cFJybTlmZVBVUW5o?=
 =?utf-8?B?OUhYMUVsbU9EMXJkZ0YxWnlVM0sxWitiT3ptdEFnS1hqRnVBcDg1MXU5UlM3?=
 =?utf-8?B?cjQrU0tab25CeXZqREJwSVh3SnFreEpyMkZ5NHJvclRqdzYxaUlTVVRqNkJH?=
 =?utf-8?B?dnlKZVZIelRLYUpkOU5NQ2c4aHZLTmp1R2Y4Qm9idUE5RVlBeEdHVm0zTDN5?=
 =?utf-8?B?M3JoNzBMWS9NMjRobzQwbkFFb0l0R3RNQkY4UnlYQlVha1RCdnFxQ3A2MVp6?=
 =?utf-8?B?U2YvUGNtL25hWGtaQks3eTduYStKSGsrVDAzTzloVk9lR1ZKK0dOTUgvek1B?=
 =?utf-8?B?dEt6ODRaUlEweWpxb0h0anpIc2pzck56Yy9CbHV4U3pROEl4eGNXblBncUdw?=
 =?utf-8?B?VzBEWGkzL3RoWTZGYi9JTXZDSlhjVHRiWWtwWjNFNE1ZdWxzdHliT1loMDM5?=
 =?utf-8?B?QTRtbTRUdWZCVEVCRGE4L3dsSkJac09HYW5GaUhrd1ZnV2Vwa1hNUG9rYURz?=
 =?utf-8?B?UkV1WEVnR0U1c05iajVZaG9XYkNDeHpJSWdzS2UxZXZrZy92L2t3cmUwUkg0?=
 =?utf-8?B?SHN0ZFlNTWdXc084Sm81UHhRRmpaMFY0WUYzS0lDWEdRekM1czc1VHdDbG9s?=
 =?utf-8?B?MGZrTTN1YkZsN0orclJiYXNQcm9IbnJaNll3c1RWV3A4OU1aeUxHVm9mYUhz?=
 =?utf-8?B?OHZ2S1JwcDF2S0lxbGhKTm5aTEZuS0c2UXlmOGRCcDlNbHRSb0VoUThkdlBr?=
 =?utf-8?B?U0R6VzNMczB0SWdLdU9zOUhDN1lvYndhZmFuYmFEbkViWGlXUlU0RjhJVHIr?=
 =?utf-8?B?OGFzZ08zSC94bEdtTUhXTGJrU2c5dkoyM2g3aGpnQVdHR0lwRURtSjdkU3NX?=
 =?utf-8?B?UFZyYTZUSUR4SG93emdjamRCUjAwOHBLSDBtUk42aFNkaTBEYUNpdXAxZDhU?=
 =?utf-8?B?ZWRGUTk4VUxQTmQxak9YektUbW1FZGhjRElpaWpmL254ekpoNmFwZE95TkIz?=
 =?utf-8?B?U2MvMVhtU0lMdE1TUGI3VGZjYkZobXE0M3JjeWU3MDhBNVI0TXpnVkZ3YytV?=
 =?utf-8?B?S0lIL04xYTZ3Y1lNZWM4N2lRb3Y0bDFXWkZyOStIVGZhNXdYampNVzAza1ha?=
 =?utf-8?B?eTBVZ0dnNDNLenFBaHB6NG5jWlp3RmNYU3NyT3RQZmFLQTZGci9UWlc2c2FT?=
 =?utf-8?B?V2tHWHk0dkxWa3I4RVJDajFuSUhOVDdHdGczamY5K2Q2MjZwNmpiQnBpL1pw?=
 =?utf-8?B?Z2VWV0p6MG1DR3NVYS9FRzBRZHBvc1V2T1FvSjBWSnBqeXB0MXRseFhhMjgy?=
 =?utf-8?B?Zk0yM3dQK2RMVUZka1dJc1I3Rkd4VVFtd2VTcFhTY0U3ZkVQVzdaQUowSjVa?=
 =?utf-8?B?R21OaGVLVnRlSnpvM204OWpCbGNpajdBY1FiaHQwNEcvcm1VN1dhNEdSZWYy?=
 =?utf-8?B?UUt1MkhVWTNPMXpmdVYvbHdCbWc2ZEN2Znlsa3B3WGdFeXB6djhXOFp1RkRi?=
 =?utf-8?B?dlgyY0VUWkpHNnZ0RzFjNXZ3ZlNmcjJ2RlZJc0JjQ2VXSERwb3VPWUdmOGRM?=
 =?utf-8?B?ako4YjFOYmd4RjFvcjFtOGUyYUYwNUxGbVZQUjN1TmxoRjJtY0ZVUit6Vk4y?=
 =?utf-8?B?VXpSS09JTWZTMld0RU41ZFVNd1Nzc1dRK1Q1dmIxNE40QkpIOG5rM05FeUEz?=
 =?utf-8?B?TDJycFRoYlVnQlp4N3FxWUNsSDEzSWJIbFhXaTlyOVVFN3dTZmpoU3ZGWURO?=
 =?utf-8?B?RGZZWFNFaVMzRGdYZjI2RGNxakE0WHlLVjBMcitiYWozV3VrZUR6YzZvZkUz?=
 =?utf-8?B?WDJ0MVpzcmJQaDV5NkN0eCtLVHBwQlZGanRycVRaYlovSGxESVpZMG9qeGda?=
 =?utf-8?B?ekxzYUtSMDZvam5jQXNPYUZiUkZKdzhJNThjaVZDM1U1dFpaZlZveEhycG1Q?=
 =?utf-8?B?djJsMk1Ea3NEZkk2ajQxSTBleWRPelJXM0VJYlI5UnBpc3ZHRTVDUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193a12f7-2134-48b4-55ae-08df2d773e1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 00:23:47.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1RlK2Q4A2CMFSiw8ZWXSM0+Ex3iU8ay/wE2UWhv21wKxzIAz2jza7CDjzAMGZVrAGAZGoYywxW15WR/RapcfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

On Fri, Oct 16, 2026 at 09:50:32AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 16, 2026 at 04:22:03PM +0100, Puranjay Mohan wrote:
> > On Fri, Oct 16, 2026 at 4:12 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Oct 16, 2026 at 03:26:56AM -0700, Puranjay Mohan wrote:
> > > > kvm.sh builds the kernel in the source tree, and kvm-build.sh and
> > > > configinit.sh expect .config and the build products to land there.
> > > > With KBUILD_OUTPUT set in the environment, make instead writes them to
> > > > that directory and fails with "The source tree is not clean" or, worse,
> > > > clobbers an unrelated build.  Unset it so kvm.sh works from such shells.
> > > >
> > > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > >
> > > Good point!
> > >
> > > Should it (non-fatally) complain if KBUILD_OUTPUT is set in order to avoid
> > > silently surprising any users expecting build products to go elsewhere?
> > 
> > I guess I am the only one!! :p
> 
> Well, the only one who has complained thus far.  ;-)
> 
> > If you think we should do it I will send v2.
> 
> Please!
> 
> The other alternative would be to make these scripts correctly handle
> KBUILD_OUTPUT.  Which is probably the "right" thing to do, but might
> or might not be a reasonable thing to do.

It may be risky if a new script is introduced that does not support
KBUILD_OUTPUT then, I think the above suggestions to warn and ignore make
sense.

I also feel kvm.sh is not a 'normal kernel build', so I think maybe
respecting KBUILD_OUTPUT is not strictly needed.

FWIW, I typically setup multiple worktrees for torture testing independent of
my main source repo so I end up not having this issue as I do all my testing
in-tree.

thanks,

Joel Fernandes

