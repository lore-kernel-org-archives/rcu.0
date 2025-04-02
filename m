Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DFB18C910;
	Wed,  2 Apr 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610760; cv=fail; b=ge8IFeoME/CXeKLjIvfhqCEBFKUQMe+hQYmdOogj3iFh8UJFCO0fk5F7hbNEVrG/WtRlaqt8B3khvbjK0hNqkhcOwuMHwfMTtAaq9nDsuPcKxde2jI5X7tlR9PSEhGgBNQB7nxtjIvqkBpYCumjmbSNuxbWyFEUkWYtOVDLrxak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610760; c=relaxed/simple;
	bh=UdfAU7VyOmUwHHCjEtwCpMWgwUecJbxaAZF7dZRlTOw=;
	h=Date:Message-ID:Content-Type:From:To:Cc:Subject:MIME-Version; b=Vpwe/aKcOFwGDrBX7E8UFN/q1n03cIwJIRo+CRT2mga8QoxWccf7fzW/KgtB+iv5Gbyx8XbhWs66gQNEU2I5Uqs+VqIx2wnCXWyc3cjJkNavimZ1hBfqo2X0Y6hdInYQi3FU34BWoWn3QKb2MB7FFGSag/SUdqPW87ADDriyLu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b2Ed5aZW; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b2Ed5aZW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GulVPRG0O3jrWBlIRR0D5Eb2+Ije8JMfCiPYNm3KHKVMJT54drbSUSlUpMOZ3s8tWQy1cy1TAibWXXdgl32ptHH4QZbD8NXQa8SzUb3OVXClnG3OtLWUbp1a/k8C3WSOHPnpHjzYn7JDo8c/YuALwXjTgCuL2y2Z+REzwWJIOu1fYuaDrvxlYbzYpGJ47SGCmwc5PU3hQW61PZ425JpZP9v241/8nYVhECgawAzHJhZptZtM5INyv1NKjGsGfM5WE2hclir0ZuAuk4qjozYhIptwVnJCSMH7rB0RZGvaOUTAKbPvmNOnfdNCU3zxhjircET0u+ckZzXfnXZK6nDrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo9WI6E5KFrq9Z9Zu2tHto/I3JQM0I/h0zCzHHweaFA=;
 b=FTnlNtJLpwetGGnPF3E44QSxje2QjLU3qFyDZtwURJzaRaIz8o6IfN5ePQs4zSjKImnNJ4ofTCqD+fRxoGZufCDt/A9DswA9BCYqHFoAk4mMENirwVZONYPbPRVi47d+aJZzPHn4nZ6HF3NbFj/bcLj6KmIx1ubrt2Wxla0m2gvb+WoYfStXBvC2Q2itYLjxVeC2ISQa9xkJsKsLq/4RNFBHtt6OEzhTTgag6JpUPzkqj86cHzjjjAhXLOZY+Yh3MI1o2iq8iGS/8pXTstQTm7bB7ovssjQeVGfHXM8ux0hWScnb6oigiZjnek4t7Z0WLJsfy5bdpt11UxThHSp+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo9WI6E5KFrq9Z9Zu2tHto/I3JQM0I/h0zCzHHweaFA=;
 b=b2Ed5aZWnxaRQ7xW628XETrLe4UJvhr9aj7pzciKlrYlA4C5Wnu+7G0z/caL5rrXZb548LAupwF4sHA8rmvEiXeO4JlyAo5ySBFabiMfcKmJE8M0KktDn6paRRMZcZ8GoLH7ZxPRwJoQi4ZqVZ6tAnSJanCnR8umjnfluZsAijERZbPZucZsNnDmy9RfyWswdbYMrPdM0/ykJfS50PDHnOJkhQlB1paxGEXOLeswYgrq+qiHNNkgga/R4018PB+iMzACeePI8NQCrjJliRq+/Q0W4HO7AmgYHukN0Nh2ZyLt596hXe7pdIo5gmRIPV/ltHjW48+ifQFefCuOaRtM2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 16:19:14 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 16:19:14 +0000
Date: Wed, 02 Apr 2025 12:19:13 -0400
Message-ID: <5da8ff7a10670359647fc8135668be7c.joelagnelf@nvidia.com>
Content-Type: multipart/mixed; boundary="===============5329838231541635669=="
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>
Subject: Re: [v2,04/12] rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
X-ClientProxiedBy: BL1PR13CA0440.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 7144b290-558d-4edd-77d6-08dd72021c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JXM9zeZe4CTls06iLng8ah41HXeEcMLue3kWDS57g+tnZ9Ng6Rbs5A8Fqv17?=
 =?us-ascii?Q?6GHpozQxQ6BXlhqiYPEWlipsD0c3PHTK7BjunURFpusx77x+RGkxcXnK0t7Z?=
 =?us-ascii?Q?C2SmzZHBqJrThNXVgYJ+GSa/pc4DoqC1qsw7MsAarN29RufK3k/+ghTmXpqw?=
 =?us-ascii?Q?7FfvA1IhH6X0GNIB6agtI1jKPhC925P6o8tfwQiEWJO8btqj8OHzV+FGNj93?=
 =?us-ascii?Q?bP5C2CBmSDtSWZ+pYGl9J3wRUuZtykjOiao9Yd9EKNznP5m2zF7igBP3HilA?=
 =?us-ascii?Q?gyC5ZkVbB3LFHJErdGTkJombWf/PYFDjz/zeomZxGR6MWQcHLP8xLMlXdeU4?=
 =?us-ascii?Q?GGIiDWxOa1pL2ss1hYQjyJmwWx0y/v/wLwu1er9aOBgkWfvT+TRA2tBtNhzp?=
 =?us-ascii?Q?pyE3OLrD6zX1E4MAp+WmcDdhP2G6Nxg88V/euwaDxSvFggyLy4tynMJv+LUQ?=
 =?us-ascii?Q?oLoWXjH3PvhxEdKKtsb5ipXJZrYNFuw4tsThbT+9GgvTB4p7GXqskbb3JIVR?=
 =?us-ascii?Q?utH3XePFZyYicjJ9u2ViS7SxN/doitFPmQ7/AR0Aeay/Vjbmwaqz4SJKCSij?=
 =?us-ascii?Q?msNm3355TzVSpeC0muBBQNKIQGmtqVIjJcIPXXNSrrNA2acUKRXxSJTMnoRp?=
 =?us-ascii?Q?sZ9UemPrQVZZdfvZI7W2EOZrkA2eGmWT6Gs709j3PWpyuZLaYw1s63dEUxRb?=
 =?us-ascii?Q?65EwityT8agMfXaSjeDKO+yfD5mtaC+c1od5C7qICPgn0zTOERDexOxZOCJV?=
 =?us-ascii?Q?+mkdu22Gc+QqRd32MePVhNawehrqXJSNnx6/YtoUUFPk+PRnKb4JT7BmMotv?=
 =?us-ascii?Q?5iZwI2AQbnfdRKAc93YSLjzbWT9gT863lnIQsl7pVM5y6j8cXaXClDTNbQZ7?=
 =?us-ascii?Q?125xOigvJQH08sKz+GHRvOtRF+kJQErNNnNK5YKEvm6QrZ1ZpFwCxQGQXVx9?=
 =?us-ascii?Q?ev4U5L7Xt6boFIGqU5Z191xXE+jrZRiOZdUbeppig8pCSsb87lO+Cof6cswO?=
 =?us-ascii?Q?Q+8/ANzZmNfMRO3uYqYHzBfVY7wScvVYtxpYZqrKQmtN02rh5MlyGSZiCUTO?=
 =?us-ascii?Q?d4bdWZP91fogWxQo/fW/luEVbN5xq1YMHoK7mhsBJxci3EtB9TKvcK7Crkby?=
 =?us-ascii?Q?IkK/z366mbimEj/lYxp2f4Fqk+oWNTH2wr+i/+dl7exuUnw9kA5c6bwWg19u?=
 =?us-ascii?Q?mDuoqtLY5nfonIm/RqEwPS6CsLMxlSkLQl8F9BnxokavB0+PLuA1RNQjaI5s?=
 =?us-ascii?Q?AiPnofkVhXW4IKTlYgDTOQM7FyscciX1CDJBVO8u0efkiRFLlR7i3nmuYtKQ?=
 =?us-ascii?Q?tDNlAik/1/67e+xZ9qNXNZ1lkRyhw/0kPxL5v1ogz3Dd9ONroPn/OC88raSI?=
 =?us-ascii?Q?B1PcZ6n0XgNmLm2phwbe2lLrEsph?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FGvYmw7tm/A/Y+yPyn7GVkpGE6nHRbkDfMZUrMpVuEUNvnkEzcwCmOBRAjvb?=
 =?us-ascii?Q?QAp7NiY+MdLNe5b3BnhFwKXTdsHLxuzhFd28/lJTOPJezyVb5IACBE/gWXA7?=
 =?us-ascii?Q?wa+LqRHb/TB/BtC50iZnxuAL4cSs7vT4ofK0qhH4DXscfHzM6xef4IP9toqa?=
 =?us-ascii?Q?GBRpnKrJv8SdHS3b3am6ks3w/SNAr4UwEHBqucv++J8LioOXTZ3z88DGpvub?=
 =?us-ascii?Q?T1CwfyPJMKVV08eSQ9DTt+XXJ461XRcfxFhLu1ToCJB460+oWdJ/nucVH0sm?=
 =?us-ascii?Q?Cmg3dDUdr5Um96+94VErg/Upp+yeOhFiRa1GNYxCp0/pOTwWj0jRrz+HEmt5?=
 =?us-ascii?Q?TIvEdn7+21icl4bnFaBkktxa67DmRLOOinfEo7PUjHSM0QykrotBRlISy8Gf?=
 =?us-ascii?Q?gLS4JrIsDroOQbvJMDIob6b4Zzcn5C9QX1IsBJrNbbKE1+4FJq5P6tIyj+RO?=
 =?us-ascii?Q?5sx2wkLc+KxNMUAcTytg1sA8CjCKMQeHNJ94Btjp62oIlqKR7r5lpRqzw6vi?=
 =?us-ascii?Q?Ah1THJvL9uFc9NorvDwLDopAmwwIRE8Bpv5R+H1Cb2PJeLjcuSyiRxHPZ+bo?=
 =?us-ascii?Q?eOfZupGL0rxV3PEcFOs1L6UllYDmePW19zlcC8S1WJmF111lag1EryjIx9VZ?=
 =?us-ascii?Q?s6kaT+Q6wYUvAv0pAWpcvKl37YJRzPnvlUqn7uxEE3CzjKYsa8gsB7go6Df0?=
 =?us-ascii?Q?Ex9woptN8opxEUgw6BP/960gOiFMm2kVsTGa7rZcJiFez50Lyg6mEooeCoQt?=
 =?us-ascii?Q?MJi+iXQ0MfDzi2yOiRq8fkyYmYqe1uBmdDLGzv+4P1IEZgM1iZkxdJVDYrZT?=
 =?us-ascii?Q?KsgPqLjvup5Ku8VwkfRSaFFWRQAS8lBZPq8ZJCLtYUKwoAqudfeZG9TEe+4i?=
 =?us-ascii?Q?GGn1aYqwNsRM3hYW0hbNnzYI1gHIqK0g1c3Y+Z+6BALIVC0QopQeTbr0JdGj?=
 =?us-ascii?Q?IZhG9Dqz+/n8ydvfA6EyiLTIaq//gVPgMDZCLNfkRkbpWaJW7hoVHS4GOk6e?=
 =?us-ascii?Q?OZbnpEjajv2pr0vfcA07V/YHGyxfd68HG4sPvmOgXTOFQmjcqe4s+uydhs08?=
 =?us-ascii?Q?FZR32mpLG4dhUOTe/1CfAmtPnWZvv5WMp3sChY7EzJtEtqVLLTUVZbfsuP68?=
 =?us-ascii?Q?+M0MSXuOFdfUuu1gDMQwFIOgRLmY06CrFPlWP2WK5okXwqKWNBoZz8NGLxYb?=
 =?us-ascii?Q?smJED7tr5YDD8iZKSznewYgVXjnQhudnGEyJCGhPWYmJvQWh7ews6Rh3WnB+?=
 =?us-ascii?Q?mYXtCdLqC7I5+nYq4KFsCQu09m1KQn6wO8Vg1uTKkmmf3JYn9lEXEq6MUYuH?=
 =?us-ascii?Q?X5fj+j6jiYVc3TFkggRUCep4MaDdkbRNb2B7DK1FMvIgUzsAjQC1ER+zaBX3?=
 =?us-ascii?Q?pc3oAqVmrMtaR6qwtPYEGp3djOoG+7/wGw1R47h34wdaFeqVq48k7ky/KnP6?=
 =?us-ascii?Q?W1Lqme9QPMQJ4o30MA5YPcEBVDRkOFOXFcw2jpQbgacsEIyFaxdwOOjWuEuY?=
 =?us-ascii?Q?OHYXbBgRJYAyumaXXOGl565fltl5GUKci6GnrDaohPMhek1/9azWiDBzugT6?=
 =?us-ascii?Q?cU6Dks0urDy4ABN4j/GjQKo1vIKvOGT0WbRfOTuz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7144b290-558d-4edd-77d6-08dd72021c32
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:19:14.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2BMWpdGZWIrU9YhutPq3x4mNlhh0OUXbXtZseRdbxSXLNMIdKVcpgV3HcBfIV72Yd6aNYksmI1ReUek5X4I1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201

--===============5329838231541635669==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Wed, 2 Apr 2025 16:17:06 GMT, Sebastian Andrzej Siewior wrote:
> On 2025-03-31 14:03:06 [-0700], Paul E. McKenney wrote:
> > The torture.sh --do-rt command-line parameter is intended to mimic -rt
> > kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
> > mimicking more precise.
> > 
> > Note that testing of RCU priority boosting is disabled in favor
> > of forward-progress testing of RCU callbacks.  If it turns out to be
> > possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
> > testing of both, both will be enabled.
> 
> Not sure what you point at here: You can build a PREEMPT_RT kernel and
> RCU boosting is enabled by default. You could disable it if needed.

Yeah, RCU_BOOST has default y if PREEMPT_RT.

Paul, should we be disabling it in the --do-rt script?

thanks,

 - Joel
--===============5329838231541635669==--
