Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CA285CAD;
	Wed, 14 Jan 2026 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411941; cv=fail; b=N1DUjqQo0SfEf/0tlbsesgtx6h5zmzI//0DRVZTpVT6bB4Qj8a+gk3hek/ILMPsUMPFqrU37vTgzQEt9Knr5ZcT1gNkGhT+Nm3p8DlmKj9w/bq9rtkP+y4hbH/9ezoR2jixW4riOo3wZ7+SwFuEuVsk2Ff68f2h3r52+1/Xr6Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411941; c=relaxed/simple;
	bh=XQnO1Viv2CUMkxGhK4jisE8ppjHrA3ROCFLIsMU4yLE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r6jN/M1jmiLjyVdORSiUPQINJ9E8Dwdk0Gq8aDnWDfZxuux3bhc7pSXKLRln+3LLQk8IDqAbaQElEeMOnUpireCruNTaMXmZDsaJdAWVwljxOw4BSY2buy6vyTIO+zh1Vhpwon4jSPscvPQVxVSnDcbElTbNimmI7XwUygtoIPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qEQs9H0x; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qEQs9H0x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNbbtFaNwo6IlSZC9aIKrOl8iH/VHLGXAnHDIaFDX0Sshx7bDerh3e/Pr7Gn8CiCshyYcA5rMoUu0LeLnF2pk/mMH49w4dSm7VThjWhjoH3aK0AZK/mzXKxtLLcCU0HmDk5N5QZWHYbcD0OPxoHO3JRLrjTYcfpT7TilAmIRl65UjyCu7qzx70GLEnMzeu07r1kDI+Hwv9IwqCBTUczBnge3vNvs2LJo0GNFA0bmKOOF/zWiIQE+Tnh1F7Q8JO7ukNl7ua7rAXCKnlQxL38MXm+WYZY50KcqQlQIO3eFpbXsYYO4Ka5hQWQ0tGVbry2Oo5++4XkKm7NkrH98XU/o+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xViThTMQAd5kKl1AtwBkiTVV/QoMU8vrotJe1dMuNQk=;
 b=DQpwHa8EHNaoXlRS1SX2TQAvAeJblPtWlqorOy1x7ufDkMJeHafyueF9ZoH4n9OxJeLnKwcXV4R0H6QGs6ZWFLfHf+/6eKVMtTJ9yimJ+QAW+bad3BLEwxpTuQw8QxeVrPTGWyYQb4+4RAoYjhiTfTSmCL++Z8XDropwH2upm5yr2mop2JfcXGSytJxnJ7K8TJGmlhmDHv3XKdm+P7oSkjMFuvM2mel4cN22jTvr9dYM1zmgU2v8l7K8ZWozRzWyFedXpBbKZ0tcM+tJ4i4dgBoYjYJlU6UARrqgUyAxQ6kXymQnvrjwbnYOYCEza6Q0eN1o6eF4FnpXQaOc8neqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xViThTMQAd5kKl1AtwBkiTVV/QoMU8vrotJe1dMuNQk=;
 b=qEQs9H0x13E4PnB/ts4LDVEkuGtrF0O9YJUecRe4yy6SQ4IszeK5GY7I4aaDqbyGz/plTaytmYkTxyiRIujD3oNGBGXJ9KqDG29UgWvbVMDNyfrvJz4llgdUtt3vAE45xcVLdYZo4pHAWjdelPeX96dtSKh9ztcKEdpIwoUa2u1x4i1DrrtyqFqSCG6ICyDAV2KjU9N2V65WlSIAxOD3EFcbnOrwUq3XYQRyW3c5MPDSsVbyMdiwfHsJeaPBreI18M44FK3c4rnVDQQVHFsrd6sdQmymAZLhDELDb7L37kXpzfoPjOFZf4hOKZa/b+JA49mDi2aPPl3Jq7IUshbEcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by LV2PR12MB999096.namprd12.prod.outlook.com (2603:10b6:408:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 17:32:16 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::f071:99a4:121:353a%6]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 17:32:16 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v2 0/4] rcu/nocb: Cleanup patches for next merge window
Date: Wed, 14 Jan 2026 12:31:50 -0500
Message-Id: <20260114173154.1701056-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0032.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::15) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|LV2PR12MB999096:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fab931-3dfa-47fb-7d89-08de5392dc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Zm3/Bq8ecpCvzw28orVbMz/OhecKk0Nrw1D0FC2PJX/CZJnEHwGMC77m7Je?=
 =?us-ascii?Q?IAm6eukddLjZScWD9rzmtgi+PY7Uio+YEqJ/oGmnBdRZDsK4CIsWoIlYa9Ia?=
 =?us-ascii?Q?lk1YG+Q/F8rypTysV4xPyE1BtU35YA6UHy+MaeJOfKAlEgw3sYRxW30BB/Ph?=
 =?us-ascii?Q?u1NYnX+B4LOGgzhG2GQIz2u3OFmfyVONR7TuY8EIfujw9bd+J5Kivp8uB6FA?=
 =?us-ascii?Q?ttjDXe+YtNQ2JQKIO0vg9lofQy8P2PbYclybWJQJRNa+hw0uVvoQOgvIKnct?=
 =?us-ascii?Q?YeM1RSqTyfcLRRNFPylPtCHZdeA6oB0vSdkgWzVV1ZAi+d8uLDcmX+MS6kA4?=
 =?us-ascii?Q?Uz8+Rbozp7oCRJYrx1v2JHoE0/0aCjT0Rf2l/1taoGgqIDhGY8lOclWhIQBJ?=
 =?us-ascii?Q?JaHAax4QbTobQgYFoT7KgB1vt4WxmQNGX88qPKh0HDS9xaGzwcbH5zu8UskW?=
 =?us-ascii?Q?PGR0XjpsIXezmNRhQ8yfaXSLOmjrjalmgr8gYRLCSSGfnqcUcag3l8tV+1Re?=
 =?us-ascii?Q?ccBbssSyLv1ZFV7e7jbmxT+03uCT/DTJJwJWOHZ+uVhOAEYmrXZoHj4wWAyT?=
 =?us-ascii?Q?Ylva1Wt55Hg6lIjAzBPytmFZNJMOKGRH9DiJHHFkWh7rP/lxqHwc/qHdMtu1?=
 =?us-ascii?Q?4bhIgOWvvxpzrto69C36cCsN40vp/1YzWuhC05HuMa3poSZ+zh6jDlOOojBB?=
 =?us-ascii?Q?9K0tzhm08wxKCHS759GQxnIvYi+omPriyuiCL87YSiNVD6dd8HuCfYRYL6X0?=
 =?us-ascii?Q?DvVUCbgwFCKGMvg/1FsPk79OhyGlTy0x++P9rDxRkjnvCGg7eg8a1JX+cEu5?=
 =?us-ascii?Q?X0qVR2i6DVl3n5YBZfPfYPU3n0hfgtHG0ne/v3ZyuHUQEms0Edp1Q+R1YPQK?=
 =?us-ascii?Q?w++jujZf1OQbTNymbJTyeO56dabr2HRGZ48OxBXo5NQOvGyY9grTuLw9Pj/u?=
 =?us-ascii?Q?8tbxiA0okBUJ9FUsKk2sxq1noS30q47l6UuE1gB6hr8c7ZYVgP+q4NqBK7w1?=
 =?us-ascii?Q?mgf+z/Buv4DG39LhwA4s4HBHCLAaRV4DNR7mh2vPn9mJaNNUJ0BjFRL2s5d4?=
 =?us-ascii?Q?wcO0e1viDMt717HEP+jy1HBIIP6udtEIOb5NOzr50aDIasyYYWQSPV48p1wI?=
 =?us-ascii?Q?WYspSjMf0aVyVSQ5k6/tbodnvKpPckZ6xgSTiRFJ1cRF4WfO2G2GiHOISWXp?=
 =?us-ascii?Q?+x/cAUJMNnRasTKMSf0zz0iQ0K+31cFppKTivZWGAe4VkF/18YyC6tY3UufQ?=
 =?us-ascii?Q?pOgauaWesN/iXu5V0cN3pihF91/4Z8WdwmdCoebtovCfGe0EYGJUTQ8/pD5c?=
 =?us-ascii?Q?oveypVZhHeqq/6q/31ypxpk2wDYMVU4nacYHr+jrHGfwUpLrRNIgJCqmYnHd?=
 =?us-ascii?Q?VleCb8Cgr0HdO0GEFi1Lniw+qF5/29Fh11wnWxmQd+bqzOlg3gSnvBfp8QqL?=
 =?us-ascii?Q?oydB0RGBOxRMJFNMQUq/Zd9/vZC8X04KiMH2zRbYhe71Byvk+YLQoBUJHikZ?=
 =?us-ascii?Q?1NfSTbsfY4Y1qjdhrK6YHuPTBgjrpCI3/1IKP9qsbeqR1z+J08GPdT6tcC2y?=
 =?us-ascii?Q?4y22qkcRvxwSVnfBY6w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SKHcUozxI0vGUbea1fJCPqyajtdxhtfgQ1Xi2SLNDDztnCDN7MKwx3Mhxy//?=
 =?us-ascii?Q?+K4WBt71GtHnQhSLiZlsV7eyh7l+QnI4MW5/VJNpbMeWVaQoiwAySI2hRKPb?=
 =?us-ascii?Q?ybQcg6TviCXuTW86BzT4aWeeaNpoL89y84XVmTm2gaJ3QtF8XEAGqpWM+XZv?=
 =?us-ascii?Q?yvGIKqF2xgyh2YMrHw+7nOa+WDQa2DerIxqesH2KgUc+d8ajyziEqcxNueOj?=
 =?us-ascii?Q?K/2+mDuDGu+Oa9jbkvHuXs2dt+7aG51NUYZRdZxAFkSpcEQ6MDbDYxgohA7H?=
 =?us-ascii?Q?8II/Ai9oMo12Yr1/AGF94ZZ75MAKhd0644lt15NaUIOoT2jAvpoQFsikOb5C?=
 =?us-ascii?Q?MkiHtW12jYjFu6sHB0oDkD4Bpoz8G/nlJZgPJMxEhIyb217E96EfTJ5I5PDV?=
 =?us-ascii?Q?2YSrefcc1u0K0ld/lRR7htJeHKedKQPjZkMaP8VdZN/pAyf3gRt+mC6TLrb8?=
 =?us-ascii?Q?uU4zgix5no/Xii+r0ysILlxCILXlqVnjPnqghHkdVjJ2L0Snq5fHyUqjrWGa?=
 =?us-ascii?Q?Xi+0Ju08rKx+Ys0YINVbLdq0e4dgR9r+EpK+OUwN6MMMM7ioqwycmor9RzPN?=
 =?us-ascii?Q?QCQC1c/mcZ5aP78fygphueHSV3mcreJouF0J2Kq3khpXIWUOlkycrokhguup?=
 =?us-ascii?Q?uHVgxqPzxWB7UN3hHrHtJAkFIzUe7Xr/Ndisj6FJ5BzRjiofDEQKSgEr10Is?=
 =?us-ascii?Q?hI5iLHmikkvBim48lG41a6Kv5SQMlJc0pa+2/4HHBVtAwO+DK2H0MpamnHUu?=
 =?us-ascii?Q?Arxbal/2CAZ/NhxF4AZSidSi29oiVSpkp/a5SGElKqYwQv1E9EjootZ7h8gU?=
 =?us-ascii?Q?nUHGApwa0fx22kEr65RwCiIQKsZJaQSsx7NvfVjzAwkDJryv9DkNGHhS/c7J?=
 =?us-ascii?Q?vTl6ccaMWVDgun/SHvtmeS3zYK1IPd26g/hjQIDJyLMAupUjsciTLyqQV+CG?=
 =?us-ascii?Q?r69+zcoqJGjfY81GimXNIL085K5nsDggnM8xcb1FZteuTGL0kb2DfE4DXVoj?=
 =?us-ascii?Q?MTab1CknVj7YPrLGhAWgzmVhjnkMqoaTTs03D/4wslXrBBHTOkZ5r1/DisYG?=
 =?us-ascii?Q?Qpho0CD2wRr8tu+XM8osP0bLUndjjrMhEwxKOI3Tfyoy8P/WPqi3V2XxfPYF?=
 =?us-ascii?Q?oB9ABPBmR5qK4kx0sEYGLkB47XK9Tx12con54xk2SSkNw6ChfN2r6BpaB/bt?=
 =?us-ascii?Q?Yp9RDRrE9ym8FQOgy+yNkLVGXKqKh0zSOUxdNk3Ljs/ADPpyaMDxPH0mHqbP?=
 =?us-ascii?Q?kjYw37Xr0PvNe9OIEPuvy0RaGcKQvS8Jeu1siIXthjxmM5RzOPPInYgcJiB4?=
 =?us-ascii?Q?OKljhPknFXiduZF88zub4EVoq9w/PNx21DLMPNYBAEK7l3fQ6PL6jh+Dr1kT?=
 =?us-ascii?Q?XQDkDkFgncaPBMUKKYQH7JG0GAvcq6RbJE3KJhIdVOVYcbIm7++RvxfxEM0n?=
 =?us-ascii?Q?NTnceFSj8HkMjZezAlVy7K7rshPM+cOrXNQend1/8rbFo6djCfKgWRHKHfzx?=
 =?us-ascii?Q?ZV/2YBTPQpa2yPKlQvWlD5DksPDuLW83toz4kGYVrau7uGAEZexsN5k9TgOq?=
 =?us-ascii?Q?c/fOFo8U56xpWV3bZpSJrjn60AQpYVnSrtNBZccRPyDVThCmlKkNPehbvevS?=
 =?us-ascii?Q?2HubORMOE1HZMkjMSmTKWhRQcx1v51Xr27koVpHgNUZRePW5ajlfC6GY5edp?=
 =?us-ascii?Q?P7HEp+0vU4JXzjVEq5UavGLY0iJKG487p7EHWoLbbe/mBL1K7oVa6Cw2NVtF?=
 =?us-ascii?Q?ZpxezKWwdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fab931-3dfa-47fb-7d89-08de5392dc14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:32:15.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51c6NA/Lbb/XoTKs41Pncnkjvv6VatWRntuFmDWYNW9NCAXXqCHoYZgKJD87Gen7Z9bD1pm/WOoYC0OYpCrHWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999096

These are few nocb related cleanup patches for the next merge window that I am
resending. The fourth patch is trivial extraction of duplicate code for canceling
deferred wakeups.

I did not hear back about opinions on "Add warning to detect if overload
advancement is ever useful" [1] so I will hold off on deleting that code path till
the next merge window (for now the patch is just adding a warning).

Changes from v1:
- Added patch 4 to extract nocb_defer_wakeup_cancel() helper
- Add Frederic's review talk to "Remove unnecessary WakeOvfIsDeferred wake path"

nocb rcutorture scenarios passed overnight testing on my system.

The git tree with all patches can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: rcu-nocb-v2-20260114)

Link to v1: https://lore.kernel.org/all/20260101163417.1065705-1-joelagnelf@nvidia.com/

[1] https://lore.kernel.org/all/654e3bde-764b-49ae-8faa-bab8199b1f15@nvidia.com/#t

Joel Fernandes (4):
  rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
  rcu/nocb: Add warning if no rcuog wake up attempt happened during
    overload
  rcu/nocb: Add warning to detect if overload advancement is ever useful
  rcu/nocb: Extract nocb_defer_wakeup_cancel() helper

 kernel/rcu/tree.c      |  6 ++-
 kernel/rcu/tree.h      |  4 +-
 kernel/rcu/tree_nocb.h | 91 +++++++++++++++++++++++-------------------
 3 files changed, 56 insertions(+), 45 deletions(-)

-- 
2.34.1

