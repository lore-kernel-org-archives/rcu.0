Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA32144D3;
	Fri, 18 Apr 2025 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992955; cv=fail; b=VKtySzNLZQeFOhbMqR4DBFgDlNVZfIkaEqV3hc3XiwuiHDc03IXj0hjwxbZ73DdzzkpsusPSRjaV6Blki6N9PksXv8NbeTCzbQwUdEUmrVkapOrboknUt+sdrBU26s/mYnxIJ0NXJnqiFgHWi0x10LivO9uCTfG0ojW1xb1P4Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992955; c=relaxed/simple;
	bh=Y/AMffNgxDVjuBL5K1HxUJiQ5N95B815Cy8S6Idhv9I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z4SJ7BWX6AExuF6A+SHzAQzaL+BiZaGt8pHKXxFVqfZ3MHTixxPyAmf6K8hyLj9XkW127M+JFezhxBinfiLRa8UkZU0b+wYEyITaO/4z5GW/WOtpalmo3h1ClD9TAg/H53CmIo2biz+NIhhhP9dGnI2xdvILnzjm2rhRaiEhSSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6sNl3xC; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6sNl3xC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjpjcxsCT9pxnnoVKCvdDizhj8IsYRjN786nByplRIwROn4q37+gaSO6Ewjga6hotWCljz0j5RG+LbSNEDOOz3Gtesb9E4J7+2qpuO7/rtsg/sBxOoDGlXzf4qjrLqa0HbOP0kwyceEnnCFwYGSIquSzFy55Ye66CoMLjGw5Hcpkfwm06PFX0uDdiJZA9+c1ji2pqXyJxRlQ4TvVX83bWsG6xlMknRvX90KJHU+5Q+Nh3BEXO1wPoTHomJZ4yHAh7RljpxY/W0fVib4lMmvxBNK7tWZHFFM7azxIQwPECIfVWPsO5pIje0ofA2VvSPHmszetU3eT1ZsDt5o0Hy6mCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA71/uAKhcSp6zqVNPsfVb8B+5RghpA2TPa6pEXA8gc=;
 b=ToXEGpM17vGE1B2xy4xkFV1w3Tf5IWG5Z/Ca4SSs8s5pbT3H7jBbxJCmwo/gxhKg67zKorTSkx7Sons/PGimyJ4P04+slc2HDKLxGdgIfLe9dqGvc8UEyUNaIP0wOAg4h00I2c+ktoOf7vK/O0YToJEIJtu8vvcKm0GFkMTn1DLwNSvO3dLBXIxdkWjdnbXFIpY7yb15vA8H956A3+2zjS61bthTFY4dLQgoNE9b/0Yc+2XOt1VJJkpPzYU6+rENDHyUK4tb538YKJahEnIiSSKEJXrzFkCmpy12LDGUuyfs6UQyc7QiBOuhOMpPdMXWUO18jm91bWXYrqRjiJMSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA71/uAKhcSp6zqVNPsfVb8B+5RghpA2TPa6pEXA8gc=;
 b=D6sNl3xCNWzn8cpLEdkV0MtYeXzJHt+wbky/iaXNLjP9xE5K8ZwcMmUdfDTOCfmQk+cAJ6Dk4Z3rGgv5WUA5AdhD9DuWsIReka4BDwSIjV989tfttreWpHKlaOREZiRIomeAcefEqPtoFlz7vHmuM6yJ2AZQGByWcBlZhkoCS2IOhZomtBdTSCmPsEtOFIJPbDwY9cjlpQPPj3rtRnxOR9WpSvm0QKS6WmEusvhOsuNYZTTrV4GeTqry+PWq0wIT5MvJY3w2KbDQ50N4+Pf0amSPMQ4R+CcIasYAwzjU9ft7ZYJxJCc2+2o2yi6rZPuX05WcQs62lQS3qO54NcUmBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Fri, 18 Apr
 2025 16:15:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:15:49 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 0/7] Miscellaneous RCU changes for v6.16
Date: Fri, 18 Apr 2025 12:15:33 -0400
Message-ID: <20250418161542.2429420-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:408:ff::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: cf187f59-27e9-4fc0-43bd-08dd7e94487c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XYmYDYr83TPotvGcKjZFc1/e3TN3wge+Pd2VY3f7YYQAJooNe/l3gxQkZgME?=
 =?us-ascii?Q?A8Z6paZEPeNAAzJGp08c09zIapDgUmGiKwgfTXY/6EPBeZttPWaGIMwrSOSr?=
 =?us-ascii?Q?EsATAMH9v7z2GAI0kCQk5hJZjc6PcAIJmW24G0wlVM3fI7HlngLzp4fz1RW9?=
 =?us-ascii?Q?wojKWTKlWZSawAJ8TjqKpK5WVjafEHTR9iISBbuFF3hzdPQNY+qjIpeztIa5?=
 =?us-ascii?Q?QtGdorh8Sd+iqNUoUeENRgfXqkYq2sHK1Eoc/0bqLR92ZuXT6uDPNvOR7KoT?=
 =?us-ascii?Q?QPclofW1nUE22Ip5k26Ni2H/EmYL4+o71yM7IHOy0n3qEHBdFp0D9EAoISeY?=
 =?us-ascii?Q?xWbStx0Zfj6DyjAffNKFveqSSiLbbFNxC8wk1hoaP17eubSZwkuQ/JZ5dfAK?=
 =?us-ascii?Q?ne65fNae7vmaS+mbFdYAprTK8QgEgwBwAcHxH+IMVvqJ5FLKhCrZaU0Jesk7?=
 =?us-ascii?Q?gc4clVafGRH/SOM7qsDvrkRzc305eWZiUOX8jJ55vY295wkxBSAF32cXFVUI?=
 =?us-ascii?Q?UEHhN5igz+0cswAf2JjE058GqVHmyHze4qQwJsvnvravAAJuydLsN/GXjZ1c?=
 =?us-ascii?Q?CXxodnh1hs+TpuARDE2FleZ7pKNf98cjnKFpY0T16d0nmpCnXmS4n84X+GI9?=
 =?us-ascii?Q?bll5t+CA4S5gsv8VMjcuFm94ybxuUw/h+UWb5ju/xBR/ydwoLR9RsqcGGnAP?=
 =?us-ascii?Q?G4/hLWwrM8RbZdB2dEyXg1ddBqVQ63wQloQc0Y3L3FbE91zb7lBZwEuSP5IN?=
 =?us-ascii?Q?gQ9QoyD8pMgvlebZRSktGquRzJdlV+6bduGuxx1lwdabt50JyoejIYPRD1fj?=
 =?us-ascii?Q?Zdt85iRNjGAc8KbZ6KqIxxlJg6xqFZ6B6G2NVZuQajyDHFG2qEuxnkcF3qDA?=
 =?us-ascii?Q?mdzxsxrb45xZ50xLUMXvZLdHkAEWA6WfQtfIV5UTY7whDPMCov+mbFkuhlFB?=
 =?us-ascii?Q?lTn3CP9rAMGp+YtUaKwFXLhPwRtaZbDxgc2uLt4A3/iEuGsTyr7ol5upBHXc?=
 =?us-ascii?Q?PVpadGFjyX6TxtiIWf9EC9aRQMqJkxpFKlCf8L8B2G8OpXeskk3RclLZZSTx?=
 =?us-ascii?Q?efm1k6Z0mXfRx4OaAF2KuFu+3IHCHaWpEFQ+SYtPO+Hanh93vdTD4JYvtMz+?=
 =?us-ascii?Q?H/iTdfKx1Lrq1zsTzHM1qvGpRrM7TqmAz2M9gB1et7FAB5Nw9uLiX6aHsUiG?=
 =?us-ascii?Q?xK0c4QHqAhQrHl3T4RCMBEmYus2yYMXUqJEe+Eefn2BNeQp6jo7Rt2GDltVU?=
 =?us-ascii?Q?lzb+5unVsAgYXTsfSQleiD96pVOQTSnLAQ2IPPg2QJFJ/jCtsxUkVAGK8ycu?=
 =?us-ascii?Q?/zYbxyXuga/detp5S3/cN4We6uFg7CNSHTIt/8ahdEfLpJFBxeRLWY7jB2uI?=
 =?us-ascii?Q?GVpneIo5jmD1TS7wX0AxHnluALjYkE7rpo/WUJOQt12jVD8KxkSl/USUeoZO?=
 =?us-ascii?Q?YSoRjdco9wUcpQBLum/xJhCL6rS5vAasC+zacK8LXPSfJMkg86oAMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMRC4kvUEcCbKc5U872DYIzFL6es2Ir5Ym5yX/Brt268s/yGwiTEfsLx6DdV?=
 =?us-ascii?Q?HXz1dZa97lmuvgYoArU/2YudBkoB5k9dpWgTFOEPsSdbVi73Mz/nLAPYMEiZ?=
 =?us-ascii?Q?Q1t5flx6gYUggEdHQXtuVUL9MlIadnCVF5f5rMXyQKq/aSICbO8a1X0u0dOd?=
 =?us-ascii?Q?a6VK81zeTTau08srvD8Ka3xl1PyyZjGhQZyN1uUVWgPx/HLnWcx09gl46jX7?=
 =?us-ascii?Q?nAEcNRSylFyNj8vGuHo5PjVdocl4xci1mXakAisGDqsN/uqeUWxzLrbwntu3?=
 =?us-ascii?Q?FAiC6EenUDoMZ/bz+nFu95rwnsVmdZo8PoEqb6qzvniKEcWBI4EZmqHw3kCr?=
 =?us-ascii?Q?S3FLETJotkgPqsNBpdaKs6bCZk7QnMaz43xYW92ytljvdyUIfDm0Y2C7penS?=
 =?us-ascii?Q?NkmecycrZScoMo5Gw6ctDI6yC2KX3QPPPA9IKIRZDlzop5vPVNXCSSBcnRd5?=
 =?us-ascii?Q?qU8uVg1UJ9PFbIrNxfTJAJuz4tJQ3VLv+w2vbazkKj3N6bfvyE7CeYY7DDIp?=
 =?us-ascii?Q?gB+Fzyi3nJcEX5n6/Jb74K34iIOhUIN36i77NVpu5j18BclrklFMDyNITZsB?=
 =?us-ascii?Q?+9i6EgRl1z1oFNGZTh7W++8J1Yt3JMnckTOx+J656tDWxb9Aw9IT+3PArzyO?=
 =?us-ascii?Q?p/glvH0j8qFFaoQD88T6StUCBHTkffv9HIhb5P0rfbO6IxcVFYhf5kgaDqpJ?=
 =?us-ascii?Q?/K2KQrnBFurhmjiC86mSduw9TN5MGhkzX5dJ21vtuzjQ63wdFxF6GB4i5926?=
 =?us-ascii?Q?u3CXizjdTuyF8+yvmRQ3ctDMyvLjKjXTqY2DANzTHjCPf+PkMR6Wtum4JTGL?=
 =?us-ascii?Q?qosTRaO+3E5ZjWbPUFNnmEc7aTkdZrX24hdrh2DQsv4dJuOo+aqLfRpZOr3+?=
 =?us-ascii?Q?yXHh1wDcdetmAVK7M3xAxGiklbjMouEMDwLpZYhRP5dcGpIMNUMcX1DNqbx9?=
 =?us-ascii?Q?6mG6e6GstcAXlzT4sfo0Ms/Jd6g+LjOWxzg/+vxlVs6GSv37HIVb97mLBtpA?=
 =?us-ascii?Q?zT/H7zJjeRtj82utZZxdVDQ0DGThRsQitFoZTxsfepn6q6MtWaoMSoV1PYx5?=
 =?us-ascii?Q?vVZcU3IN4VlEW0r8+89jhzfgMEDglZRL58QRxlXuSAXMHIMTWNHvbCm9sRO1?=
 =?us-ascii?Q?MLRCDY8sXT3lUX2td3F7yvEZbhPgb2/TRfFNTLPorTnFeVKza0TIOarmXUhG?=
 =?us-ascii?Q?bHgAr0FoMgjuaOubGHeUdgBOpfDlO0Sae/TvFMjZUbM98AzPobLO8qwa1Dd0?=
 =?us-ascii?Q?qWk1L2285Yj7PvtR/EfKESS5dTSyq1sLV48rcqK9vs10i6rOz/A1/gDx3F+s?=
 =?us-ascii?Q?cvf4pah6oSiejkKO5Gmjh0165qCvHrNiS5bAqeXxWTLO+cLVhrx7UKEcVWxi?=
 =?us-ascii?Q?3xqBjXA6IYaFsRNJHmZhkyWUTynl/yYLyq08N7HmptdmU3QBP5X0ryVuqYWM?=
 =?us-ascii?Q?oQWwVMs8tRcYTS/khUpC8A6750f4vgmimzwrXH8XBAWHpbCKrv6bWnYuhZcZ?=
 =?us-ascii?Q?0VdJs26HFagA6RS6QUu6+5bnIVwfBPIxY6+2LrE2n+MOJdldQUbBLe+wm2Uz?=
 =?us-ascii?Q?B/ODFeP3A72mWrjLrkMG/oJRdpdXcYRtSgN8oQzt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf187f59-27e9-4fc0-43bd-08dd7e94487c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:15:49.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tvhwbo+l61ibaEPh3MbbdX8TrBBi2w/W13elC2nkfw7Y1LbaC7w5mtRFIdt53Yh4UM33L4xRhHDR9gqVqN31Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843

Hi,

Please find the upcoming miscellaneous RCU changes. The changes can also
be found at:

        git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git misc.2025.04.18a

Thanks.

Frederic Weisbecker (2):
  rcu: Remove swake_up_one_online() bandaid
  Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"

I Hsin Cheng (1):
  rust: sync: rcu: Mark Guard methods as inline

Joel Fernandes (1):
  MAINTAINERS: Update Joel's email address

Paul E. McKenney (1):
  doc: Update LWN RCU API links in whatisRCU.rst

Wei Yang (1):
  doc/RCU/listRCU: refine example code for eliminating stale data

Yongliang Gao (1):
  rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture

 Documentation/RCU/listRCU.rst   | 10 +++++---
 Documentation/RCU/whatisRCU.rst |  3 +++
 MAINTAINERS                     |  6 ++---
 kernel/rcu/tree.c               | 44 ++++++---------------------------
 kernel/rcu/tree.h               |  2 +-
 kernel/rcu/tree_exp.h           |  2 +-
 kernel/rcu/tree_nocb.h          | 10 ++------
 kernel/rcu/tree_stall.h         |  4 +--
 rust/kernel/sync/rcu.rs         |  5 ++++
 9 files changed, 31 insertions(+), 55 deletions(-)

-- 
2.43.0

