Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039381F8723;
	Sat,  5 Jul 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751721158; cv=fail; b=K4cYdVsA4kDrghsHBUukqZDV6RQRNWQ/mvESHD2g4/zJo2wcY1zOaVrp5vUiDPbbQmil+XGZMLDUBFZWOba0uBcERDSKRiVROyLwFw8XZSOJbqxf+Wbtsm6PWB49ke1A+6g8wvD9hVKbg7Edqq4kepr6qY2+lZgPpXTt5yBCLUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751721158; c=relaxed/simple;
	bh=cbwVJs1lAtgAByzyZozyiy748h3LL4hocQ4FHC3Wnqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KC3U3toaEyeWvnXG98clVomVn+ZjRSRYn7gOiUZGNi7ZleoSmEJFOXf5s1beEC/4lggJ6BgpTVMTdszs7AqqHA+MsIM+LgksSjV84IO28x8jw3bVth1wAAcxNaq8nL7bVwjLFaX2tQRtDr8WumbnjwS2oFC5xoluYpjixe8yTBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RQ9fjDZr reason="signature verification failed"; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RQ9fjDZr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWgFFBSUg1yy4XiF1EzcLsp/sQsKrXK/46fRTDXr+tmuCKGq4zTww7H5sw5pyIgDE8qRtLm8Btz8PkQkv/Y0uybPQkO/kHN4HWJKzC3H9emWOYfO3Zgg7qxLtdq7QSeGN4/M8LCAOVNctUQ0Ucz/siezbroS4+45l5lSV7uWiAQMCge/7zqfXGiTm2+SJOXfRN555jBXPhmAyeL2CAkXdQ3LRy45PI72v8K7JVN3Wz1apiRnbMTiDNRfH2me5MfB276lIsQTLgVE/RK65DUcTs5QF+rKc1iCNAw7QsX6kSWJ6FDqNcXdkAj9SLCVqaUFdXmYCYY1pDNXsAa7vp26Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buuLYAe4SH4qG2ReIZPBKO1eB4lVQ0xCBA+1ZTXBZiI=;
 b=BMo2mzE6Zs+ruYuUQdHO9/9c4hO4HyvpKKYFJjdkeWG9poqTEzMwwKLhFG8y8i7DVHk/tdUtp5oWLnLkPKjvEd7Wt0PMvzFdana1ju9WOdJilucOFBoYaH7YBcTgom2xlb52HQzJUkEEAEVQqnpEgLgdgEJYHLxbTWYPiL5mkYNJnELKvHCKp8+eVIeEiRwP+15OgFrAsGflx6gbK8IdplkhnnBnmkYYjhEXUoeVuUINQrOnuDFj8IAmuBWvV7WqOebQnwwKGekxVNebfb/i6fUuXfF8xt25+ej3Ao0r0gbGBjoKZmNFD4ghlYAZ8FAzD4TijihMwXIRlfqMca/4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buuLYAe4SH4qG2ReIZPBKO1eB4lVQ0xCBA+1ZTXBZiI=;
 b=RQ9fjDZrIxzpiCD58ncDBjnWQXwmD6fOa24oZvJB6G6cZJedC4QKC5uSnYydORKZ8flRBILyMsb0FFVAdKiNBuLJyulUynR/KIdqG8whWDZBnHj1o7RWOHUNGqVv7b2tUFzmkvzW04LvxVKKIDfln9DIe92IzbvkI+PmXiS6X1xUwQM1vRYl+jc2TuRlfJa8lK25KZvuI6RDrn9TL7ya6k1XMysmjo1dSXk1cOIxlQQN7m+ktbutWq/YHyLoiL4+aDjk8gl7nMDAFLmj5g3EM4rr+jwwAso2SHnUJZeYc5IglzrCLv7Bw3QAyFjPbDpRtOwxbtG8vOV0pRGLjIxMAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sat, 5 Jul
 2025 13:12:33 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 13:12:32 +0000
Date: Sat, 5 Jul 2025 09:12:30 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Qi Xi <xiqi2@huawei.com>, paulmck@kernel.org,
	Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
	Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
Message-ID: <20250705131230.GA4059783@joelnvbox>
References: <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
 <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
 <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
 <506d8c4e-c317-4c85-9bcf-695596551d28@huawei.com>
 <166bc5aa-a715-438e-8805-c74c2b5fc83b@nvidia.com>
 <c16ddb6e-73f1-4eff-bbcf-c03b95f79fdf@nvidia.com>
 <8f5925c1-9553-63d3-d5a0-387c2395963d@huawei.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f5925c1-9553-63d3-d5a0-387c2395963d@huawei.com>
X-ClientProxiedBy: BL0PR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:207:3d::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d34cda1-c7e7-4920-d33a-08ddbbc59a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?NylCBEWlB0j/zD2jkkNWyIxRQrz1P6A+jw+IivXC3pFeBi1y8BUUbuemr7?=
 =?iso-8859-1?Q?OEp7j7bXUEB/8tK3T44sTegFSAP2qqUHK96gofhcpnK/TzE3d6a7PEmTGa?=
 =?iso-8859-1?Q?LuZiIB9dgwiMQeAOzSGkMCYsaIARyfmXeIgafhUnv6iWgMYJobV2xqWOnP?=
 =?iso-8859-1?Q?H3HcuPh+AG8mdIHih/ZsI0S68SWN3hnQp4/1XEEpDZ4XQ8xWhrAO+w92iE?=
 =?iso-8859-1?Q?9wgFLpmn5owwyygxuGnC49ypMSQZqAIVwCdklmZT2p+8KE1/DVux6EZImq?=
 =?iso-8859-1?Q?fI/VlY4+P8uW68JQPDVwUA9MySLwqqy/xMn6/zLtIAtC074z/skjeIsrCr?=
 =?iso-8859-1?Q?n/TlmUHWgFlusSTpimUlrIweWlK2cref/HQlUQmb3okLtUztfYs1wF305B?=
 =?iso-8859-1?Q?TYnhMuLvksk9eoB9W6z/cvqxRzXPS+4qVEfkbAPY3wqC94r38I1sKqYMwp?=
 =?iso-8859-1?Q?NuQpvXtFLVjQm5qWwEFs9yHN3G7TeV1PWNtb7JrbJs6NZqMQ51QEV/qVqx?=
 =?iso-8859-1?Q?g7q1oK4gIYjkrzJU1SFnyuUQDQvMWQYvdLkMa/2Dpi2p+7igEotMzm9pYp?=
 =?iso-8859-1?Q?EFn2FcPCTyCwT+j6JeAZwUC20t8L7BeNjYKm5jMr8sHmkJvvVD+vs/SZoK?=
 =?iso-8859-1?Q?f1ct17qY/vLH80/k0WsGnwnVbBCkE82CmsEXXlKMRUxYXyFIGbgz2FUWNj?=
 =?iso-8859-1?Q?ve3HJJnJCT/STL7+DGlKon08Bc8zTjzfnb1ws956PBVtccb0w1HrOl4JKK?=
 =?iso-8859-1?Q?rBCxPp6FEtB4UZ+to84DUBTXyCYFPugYUMCUuUsF10/jVfWwS+b0YgWcSb?=
 =?iso-8859-1?Q?cwOnepdrZHdtlbTvpUipx5awPZQtkGalgdPYO9yZ7rMht7OG7qQ5LjL0ox?=
 =?iso-8859-1?Q?ruBTO2ROzwi4BDePnQIhjLzUlqdJwtCRV+dnacyuj19KhepjFLshGkm+dd?=
 =?iso-8859-1?Q?4vyk9OuFk6Wd13XtSHu2Tr7ZO3JXj7349b4Qfp+0D8PZpfoNEXUJED8fVP?=
 =?iso-8859-1?Q?pf/5u8NRowCY/aIIBlcFs99zNhH3OtZKBz6mZz9o9TEXSIQ0vVM02YWbGU?=
 =?iso-8859-1?Q?TimJW3gGIChPgVPr2KdtMa+w5ogyjw5qatNjA/0mVSSyBywbdNEXIUgZkw?=
 =?iso-8859-1?Q?NOzva5Z2af7t/mNa6AxDsGF6KFUtELFYYu86K47jhHg3Gxbm1l/WFbyjUS?=
 =?iso-8859-1?Q?ElvX6a9F94ANmIX61InjjdsGNeqxTvoBS0y5u+Z8vZA/bd87HWB43Yf7Ck?=
 =?iso-8859-1?Q?4sa/gSO2NpsMSSkEFHCzWfypMVAM+W2XUU2jGo7gom51I6pcRz1ua2T6ym?=
 =?iso-8859-1?Q?d+ytxWoHe4H0Q/7SUJa0iA7kwwcMwWsp42hR8wCC+7fJBrt3/gDmgboHhP?=
 =?iso-8859-1?Q?1Xeg+28RXHrMOv1SA7rIpHlTrDzKPdW/dLoUxPsybkJLd+vCpdw7jVSwA0?=
 =?iso-8859-1?Q?gEAPLGD6+RlQVwAa3eN2XFH9OpXvMMVHUHcUsmks6A/ytFEJnJW6Cd9Srb?=
 =?iso-8859-1?Q?M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?loGKW/q1K5Fd0o33b40df9dtDLOUmuD33mE5hRE9/UsuGt+cE/M1F1o546?=
 =?iso-8859-1?Q?+McNolO/5k9mguDM6oExyWfKhWiTqNmN+FYUh6+FTIM0jweNPhz6NPfm4o?=
 =?iso-8859-1?Q?jZrGatxYBVs06XyB6JZSS2fbNRM2cDsj6eCayd2NumdywoCwVpUg8Xp8fp?=
 =?iso-8859-1?Q?gZfVAFWZAULf3A3iIXH5FtDXmaMsmE09UXLXyV0HIeVnhiKxdj5cCeVMXE?=
 =?iso-8859-1?Q?f3MlWVkFF0sPrnAZQAIgCMHjVQcC+gS9dG9xoIOaHs3mnEPOhkstKRc6//?=
 =?iso-8859-1?Q?EIz5HzzMvof4R6JV7g/gkgIA3sBvrUSpOBi1KLRUhSGrq95c/0gvtGhMnY?=
 =?iso-8859-1?Q?3DWphKKN//alAmaEUgZAeZxPRiUihGZM3AA8TVACuGxEn9/VpFwgkTrmBE?=
 =?iso-8859-1?Q?Ba+lifXLedWUN+Ob/abYNsht4o4FOJYnZEeagY1Su8c74XSPVkNOiaxBDg?=
 =?iso-8859-1?Q?w46GAMrpMTnxU5ncYWudQv99JRAs2aBJmdsM3ZGeWPHt15uaLdCMPiDW98?=
 =?iso-8859-1?Q?BMjlQ9igE5i5OLgZJJEvHLkHdFqHCpKWhHFG5q6uEHoOpHy6zpV8rE9QbN?=
 =?iso-8859-1?Q?KYqZ14lxgnCvKAEPDQphHSP3c0hMYtraooGRZKWunD0WCgUHRuob8kE5F8?=
 =?iso-8859-1?Q?IF6C1atgNHpW5yPLgY6w3n8KIKvsIABM68qA1AA4yeJYy9RtvvU1F6npUS?=
 =?iso-8859-1?Q?CJTQEYiVbHe+0R+cCx22c8IIP072sPFqrb2HRu+LPfptbdXUNuno2zFgoX?=
 =?iso-8859-1?Q?JnODhRrfnntv73qhUkYlxq8Hsj5EkJTDWhJxONncChkP07GVXkecBrtbLN?=
 =?iso-8859-1?Q?GdlVjLDFGV22v7wATGw5o7Xl8Jh7Qcc8QIBBAmP/3vNar6RPX4ukCsDnyQ?=
 =?iso-8859-1?Q?Q2EL6HQbpjYuUB0nD+MNZXmc+mTQ3WRR9asUPxCdojExOqCSwNd60idGFn?=
 =?iso-8859-1?Q?XqAbJHNG03TnrYsJuY0p4acGn534L1HbchTNcZ853DPuquCPCHzXOn76VG?=
 =?iso-8859-1?Q?+8U3tAMQXIeCnqczr2vTXj60RgbbqaSjlzMx0NTb6H0zsQX72D/JBHFAzB?=
 =?iso-8859-1?Q?iMv2wzJygssIYVEqlykNra8Z4d79iRqJM5ckcY9v53qlGlS1j0NvyRFSnI?=
 =?iso-8859-1?Q?+bpaOb2ON/VsUlcAJpBbULVFOxlgbf6OXxLO4B+CmKBh+DUKlMX8mo81x9?=
 =?iso-8859-1?Q?5d6CQYasrfDnJK2P+uTRMEmFANBGJXiBzMAtWaohE+nFyD8cybd8DdO8Qq?=
 =?iso-8859-1?Q?FQtMl2y/mu9XA6NYojsZCa0lV38Bi+5HI2Ur6mlt3MDgRpy2JYnIP+e9Jb?=
 =?iso-8859-1?Q?COadA0nD3wPpWiCBfL+sU89X30pEDzL9564yBT/QugUJGfVYhU0gYNuCpy?=
 =?iso-8859-1?Q?1RJn6U0EB4GSOrvLK5YhGzqIzYiaT5WZi+Rnuad2pc6CBIwEWzhJKikxC+?=
 =?iso-8859-1?Q?eRXaikltz+GH1z2mYGAp/Q56ew3UflAlrHjPJV/aMz/GbdVkcAw4v0F4Vx?=
 =?iso-8859-1?Q?2U6Hy1Cm3iyEh1glrDQyqZKhjWLxKg1F4qOoiG8rcN87A3wKYQgEqp7bwk?=
 =?iso-8859-1?Q?vVNXVnc63/mg0GTVf8GHKE6t4wJImI5zdID80Sg2VjKHcmd6/KQQ0Ro+V+?=
 =?iso-8859-1?Q?xaz90OBzliAZDRO/NGM3Ipk3ob8n5ugtS0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d34cda1-c7e7-4920-d33a-08ddbbc59a45
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 13:12:32.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnFmSxR9KSLx3ZSkqfTx5YIjXHwq8samE08m/VrDAMwxbvsejBaHdbJj6FVqT1aymbSblyJ/cjOB2ypSn3KRWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970

On Thu, Jul 03, 2025 at 09:04:31AM +0800, Xiongfeng Wang wrote:
> 
> 
> On 2025/7/3 1:24, Joel Fernandes wrote:
> > 
> > 
> > On 7/2/2025 6:59 AM, Joel Fernandes wrote:
> >>
> >>
> >> On 7/2/2025 5:14 AM, Qi Xi wrote:
> >>> Hi Joel,
> >>>
> >>> After applying the 2 patches, the problem still exists. Compared to the previous
> >>> fixes which did solve the problem, the difference is ct_in_irq() in the first
> >>> patch.
> >>>
> >>> I am wondering why "nesting != CT_NESTING_IRQ_NONIDLE" is added?
> >>>
> >>>
> >>> (previous fix: problem is solved)
> >>>
> >>> +bool ct_in_irq(void)
> >>> +{
> >>> +    return ct_nmi_nesting() != 0;
> >>> +}
> >>>
> >>> (current fix: problem still exists)
> >>>
> >>> +bool ct_in_irq(void)
> >>> +{
> >>> +    long nesting = ct_nmi_nesting();
> >>> +
> >>> +    return (nesting && nesting != CT_NESTING_IRQ_NONIDLE);
> >>> +}
> >>
> >> Oh gosh, thanks for spotting that! Indeed,  I had changed it to != 0 in the last
> >> version but applied an older patch. I will fix it in the tree. Thank you again!
> >>
> >> Neeraj, would you like this as a separate commit that you can then squash? Or
> >> could you fix it up in your tree?
> >>
> > Qi, Xiongfeng, I am currently working on alternative fix after discussing with
> > the crew. I will keep you posted with the fix, and would it to be good to get
> > your testing on it once I have it (hopefully in couple of days), thanks for the
> > report!
> 
> Sure, we are glad to help test once we get the fix patch.

Could you try the following patch? I tested it and it fixes the issue for me.

If you prefer git, then cherry-pick the HEAD commit from:

https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/irq-exit-v2-no-task
(cherry-pick sha a58cc91fdca766cb719fb8beee3bb10ffe8e9d58)

---8<---

From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] rcu: Fix rcu_read_unlock() deadloop due to IRQ work

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        | 11 ++++++++++-
 kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3830c19cf2f6..f8f612269e6e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -174,6 +174,15 @@ struct rcu_snap_record {
 	unsigned long   jiffies;	/* Track jiffies value */
 };
 
+/*
+ * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
+ * It can be in one of the following states:
+ * - DEFER_QS_IDLE: An IRQ work was never scheduled.
+ * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
+ */
+#define DEFER_QS_IDLE		0
+#define DEFER_QS_PENDING	1
+
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
@@ -192,7 +201,7 @@ struct rcu_data {
 					/*  during and after the last grace */
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
-	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
+	int defer_qs_iw_pending;	/* Scheduler attention pending? */
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dd1c156c1759..baf57745b42f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	struct rcu_node *rnp;
 	union rcu_special special;
 
+	rdp = this_cpu_ptr(&rcu_data);
+	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
+		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
+
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
 	 * report the fact that it has exited.  Because irqs are disabled,
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
-	rdp = this_cpu_ptr(&rcu_data);
 	if (!special.s && !rdp->cpu_no_qs.b.exp) {
 		local_irq_restore(flags);
 		return;
@@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
-	unsigned long flags;
-	struct rcu_data *rdp;
+	volatile unsigned long flags;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
 	local_irq_save(flags);
-	rdp->defer_qs_iw_pending = false;
+
+	/*
+	 * Requeue the IRQ work on next unlock in following situation:
+	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
+	 * 2. CPU enters new rcu_read_lock()
+	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
+	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
+	 * 5. Deferred QS reporting does not happen.
+	 */
+	if (rcu_preempt_depth() > 0) {
+		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
+		local_irq_restore(flags);
+		return;
+	}
 	local_irq_restore(flags);
 }
 
@@ -675,7 +690,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
+			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
@@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				else
 					init_irq_work(&rdp->defer_qs_iw,
 						      rcu_preempt_deferred_qs_handler);
-				rdp->defer_qs_iw_pending = true;
+				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-- 
2.43.0

