Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65729433C4;
	Fri, 18 Apr 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992623; cv=fail; b=WsImtoyXkLpvf64H8Hk3ZcxpuOJfyH4gI4JxFFrUkjLVaSLT/r1RCjV/e5t8RgcsaAMHFuceO87J212NrOWHlmPPHatFv1byqdl4lltH154drWKg4gRZ5ISTkNHuZ2GRgCD7mgL38JBdPECPfoolM0SDPrFNskIowCS88UwNvT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992623; c=relaxed/simple;
	bh=zikTiRDpXHQjbLuq8vwW4KKlhty85vmXycUBT85hvy8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HVM8ai3bOSZVImriEMpjtGJ3nRBVIsuLCEbB09Fn85gw7YJJI+XNE90yuncWRTmLPhzaAzBQD7UoWDFIFNW7Q7nO0G7n7fb/ZSau0NhkV/EoGVGsVpQHnY9qGhwbL6GzWpLeGVCD9sHuLtWnM+BcjMcaXilmP+Ta7vOZt0aszes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EEkJRmZJ; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EEkJRmZJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n67fKg/yAOlV+cekMTdvI2IMZAHoKatgW+xzSmTpiOhIsLb/O8VOYOm1NEXYof6y/uOcK1x/h4rxSWLnjsPkn7o/HUktDBvP3LDDn7FmO9JguTtmLYRiV/lgW2eDKBxI7bdp8Npxd1fBIdmO+5Vl1yrupKtdpBKtBmSZluBAFE8siewQQqF1OaSiaDdDEC75rLD6sAPJx3w5v8oppL7O5Y7kJ1S833rDbAlr3sVswIWH2Uco78OO+nAKxXoW+B+2Ns5knyWXkyWS7OCdNpIdarG14kX/869Ndc16JYRSttEzwZeiwIs5BSzQUha/IrsfIn21k7Az06LT18RwN/izqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQG2nxM43PTd54/39ZdQeo9k5bwpRE5Rq7m0iY+EOI0=;
 b=pWjgROWp602yiSFjtBbo/v5Nk59A0YfUrm+sDoYzURJIDT2dGJVrDpssaz/0VnEOEyOLHzet1/NPHBotWdS49BJ+nUDUrA3iIPOEk6SR9uCQd+bVbtGKVcqO8pd01yG1HSQYePZbCfYk/bwdSgRWWle+cKX8VFWW3VuRMudy6V1mV9fnsBdcm1mqg6JOakcLGjFRetl+20IRtvZKF2InylSLejysSSC7OM+0zq0k0qp5YgIJcer6Ssxa440pCkyNt+LdTkFVYDNUw0w54n0KFI+IYmjIGjsTWLmggzwCMHWyB29IIgpbQuybp8ervEWQ8eN4HB63VY09EYtNPgE7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQG2nxM43PTd54/39ZdQeo9k5bwpRE5Rq7m0iY+EOI0=;
 b=EEkJRmZJY2SfuYDDCYd2uu8p9CVGYFrJZ7TQfjUVYL758H/0LIkjixuMuElsTZzYzxCPF3u5dz3pRtPS27u2JYQTtIHvtKU1PspwlgtHAzjrdogIgyoYXVNGt0pMLxHtyXFL/hSqJHDYO0+YCOMhF9FLnYRTYAUqmvUGvBmp1bIgdl+tHeZfpgt7Kq1FA/X4Sw5kYG+gZushVgmtbqmW6ekZGDyIDmSEiv9AXwDRBqZVIR1tmyO0LAhiF+dLAsdPpWpX1WdyXmj+Gbm8XIlD6yKHUlBNMjQ3A/yO/p6RCRJSRhRZpBfd/bHmzSTWg6CVNrSiSz9tMf8Y6JKrDPH/qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Fri, 18 Apr
 2025 16:10:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:18 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	linux-rt-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 00/14] RCU torture changes for v6.16
Date: Fri, 18 Apr 2025 12:09:32 -0400
Message-ID: <20250418161005.2425391-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:408:fc::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: dd56d939-6526-4435-f6ef-08dd7e938350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wt54lblgPMvRLppuZFFe209eJp1tVaa9xxnKPGB+mCVz0lUceOIAEAdyDIJ6?=
 =?us-ascii?Q?fxVhu8TLnkXfwOxFO1qYtdx1G3WHTTe35wgfjK6cfkef/aNXO/lBKDL5ONBB?=
 =?us-ascii?Q?MPcin3TciLbBX8F7VgUSCPNcd1VX3EFrzeIeGwV7UpvjbhC9Dr0w3pi37RpH?=
 =?us-ascii?Q?HWYzUE/Zi1AOiNZlcZM4fxRABOfscj7vLoTKRonXGhPPdeKlaDO3QG1/umj+?=
 =?us-ascii?Q?UFmUcqq3IIf2KBLo+hC6YW7HZLdir1G+KdS5qxoWCEAvBTRyQapCKTOhArt/?=
 =?us-ascii?Q?J93iIilUnwMTHW0swk12OwonrovcRn+lhVU/55nhyzLzOzW9fEpC1dUtfZLr?=
 =?us-ascii?Q?OglZzszEWy359NbB1Yw22/BQ2gr8ulSYkoEJJ4ZY30dMOR4uueFlUX5UK5Iq?=
 =?us-ascii?Q?Y+/RniLs8WBHHOtfyKRNk0Txg+GSAfsHO+21fNMoUhWufUEzhrKfdjecJxQY?=
 =?us-ascii?Q?5CGouTr1eoPpA4vNV9i3MZywZG4UW069wib2kJE2RNpjb8M4MERZGIjfYEhL?=
 =?us-ascii?Q?FqfoxouWS7Fu8fDPRHF8XglMjlUHB0RDXrSL/zgWS8pmOsHLD4aU7CkwTs2B?=
 =?us-ascii?Q?TsXoHzHHnNUjDU44vjZ5NrYbtGl1+0TlTvu9kNx4VXnOhI7OzqE3yX0Ryz8b?=
 =?us-ascii?Q?Ha6ae+sTVWh4gay1xpxY+Nu2HToymz0uRb46sV9NDkscYQ5J/GijH+xHrQrJ?=
 =?us-ascii?Q?wofqhnZB/0P8xdhfKvdV/HNgiL+rnFkojKahNtQF9NEU6b++PhUsnP2+VkkX?=
 =?us-ascii?Q?b9NLlldjorMlo1OrIIG9XIz1FKCEVM5f1Ek2sDOGIQGmpsWApbr6NSvN/zXx?=
 =?us-ascii?Q?iPjLVBkrUlsSq0Pd+UureLx7szKj0pEOsFL0knKE7LKntooQ9YMs7NguCiY3?=
 =?us-ascii?Q?6qp0hAqcXDv00+Z7/J4aOWApRIGl/IbH8qy+ScJtd3hsmZ6pvxUYziJcNm9k?=
 =?us-ascii?Q?ZqazCBhFYvwKCMNoHyV9lTg8Mk/5wqxuiU6bpEauDkt+f3RQxl99wmX6SbgK?=
 =?us-ascii?Q?y2Yigi7FCLTzqLJ3hIz2AX6k1ebL/YK9GbylKzbeHk17ORIxCL2uD9K/jtlD?=
 =?us-ascii?Q?Ob62uVMOnWjgJdkVhPcHk3yFnKYjNAy7gKKRAx3baWtV6ui4qbbxUXZvduxf?=
 =?us-ascii?Q?HIAZgN/hbRKgRVjqryo7i7/N43lpL63OUm9ga8tE2zxLSBO+8i9ohmHnISTC?=
 =?us-ascii?Q?xfiEWX1dcK/1Y/DZyb4DqvCKH7zxJzGX/WmeZX78wCAihes7A+4FQj3exDVs?=
 =?us-ascii?Q?VIOcrsflJlF9bBW/DbTddtNIt00d1GtJbC8W0LCUKblqVMSCOCJIi0gfWLyk?=
 =?us-ascii?Q?Gay/TZ0kWDAW0Uf93ntMJVgxZxcRhnAs97QrNlaeGg9m+Z2Wkza9OT8twkSe?=
 =?us-ascii?Q?NKrZcvqRV7x+Q+Pjxw1PzeOg5EavmVOTESWQuUpxyYQi+EzJZX+5s5fI1VSC?=
 =?us-ascii?Q?igWZ2qRqVLrbMiTBm+yggmhlOPmmLPsSfowcM+ZyGLgAoEulHH6BIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5/AgNigZzPQeLykMWwefAEWpfM9aloR2hFPzKB7wyAkUOBi4qSW67Iw9U5Mz?=
 =?us-ascii?Q?lrpwECtdWrWiDV/6B0hCE6LGNkOl94rHjmO55Z3Z5X6IZ4n9MbeNIC2XL1df?=
 =?us-ascii?Q?4O/kQwT0cxe+IsNrLeC41tfq78Uk2p0fRrP7ZzjS4pysxy4tQzOtXMfjj9eQ?=
 =?us-ascii?Q?Eh9/0UCnPP94fN/aQ5CqmjsMlmJEVV1UIY7PJqR1/fYoq1UUgXoQ5E+QkJpQ?=
 =?us-ascii?Q?nvK8O1mNRA9thHtZD36vFEaN47ir2R1FDzxwfQNa2djoqoYvxtCbjuYvAiNq?=
 =?us-ascii?Q?I5kWqdZNAW/5tcNtORaazA3sC0veLGNDYOuk+BGSDBxLwdILlytV+hv5O9Qh?=
 =?us-ascii?Q?+an9QVgQdvbsT4r0MFUZ3pWBOUkPF1kTPoGM/dKES/fQK11xZ44hNfbUT2lO?=
 =?us-ascii?Q?XvuPhWB+5/jasNk016/0rJMh2ifHtiRfzYf0pSiN2CN2Lj/T1Vqb0eQUIRRt?=
 =?us-ascii?Q?N/NN2ZTzxNgHfmzycuf3z14Kxq57HJuTdB86FhXwW9QS44SlP1ccAUKA7SNR?=
 =?us-ascii?Q?sMoHTdN6b4Y31IlEfgtzD+XReS8LX5W9Cr45Ih0lWgXoivmaNFLY2/aqNshI?=
 =?us-ascii?Q?nqob7XaKRsMDFloQ4OIR8L9F9/kQ7itVF0PBa0ZDPW7cYCuuJpe8tt78ui/w?=
 =?us-ascii?Q?WfVCLc42ZWXKkC98dLhKYqux2muoUw4W3WMjUPYN+rVtgucc+uX58Y3mFTg0?=
 =?us-ascii?Q?S2tYARqs2OXKgyNInHzSX0ARU3FO3glRzyLhT22z60m7R8LdxRgDYGFlZbuH?=
 =?us-ascii?Q?HQpZfX/7YBAyDAhfJjVSYL+mWuqC1b7OnzNAuc72R508Lxmwn6/A0Mbl2DhE?=
 =?us-ascii?Q?jz3eQkjWQSRa/sLAW99lHH/GXKkqjFHlOMnzkFsR0XK3XTzYdysX7oC6Gn/S?=
 =?us-ascii?Q?jzIA7bBXhJNB/cp2q5XFnrm2tbL5TWenB5V6f3juY4VbsQCYWvc3luXszX82?=
 =?us-ascii?Q?9pko0Rxl3Fqtt79YET44iYWOezTbIbT6c8VurY5WYS2r3HBCBF7moYksIUuU?=
 =?us-ascii?Q?EYKDbrZo/4ZL9nAU8kzyfcV/TT4p/h/OannPkxonTQd44/ATFkuUYEnbQ7gP?=
 =?us-ascii?Q?p1kS+DlcIJM9ta5dMLefiXZSAJiNcbP6BJ6tRIBETvC7nRb2Qidje13l86Ua?=
 =?us-ascii?Q?KiLI7FRWMe4kHcCk4b1EsOoi5V5M99ZdsahIy9v5yua7uQIT08snp9ZBOexY?=
 =?us-ascii?Q?yzTCfITsVA6s6WOpyoazWHkHoNZC+nj0J1ZC0LWcYUdy6tSX+SLF4cDIZe2J?=
 =?us-ascii?Q?ht6U9F+ggHQDslHFoW3cctP8jQXELn7qC9Qc+RRRiPQdUN6atkvEtZEsiTph?=
 =?us-ascii?Q?RzKInSoZbQbfvt/0ls+tYA5XjhlgKd8lvUDu2EteX30DXiMdeYYDB6kZuyBu?=
 =?us-ascii?Q?feI7SVtNOmc0QtxbXPzVgTvitDuEzKymy4wnR9h2h2fK9hl6CWKM3nP3gqNi?=
 =?us-ascii?Q?imfSL0cxTfOFZffkHZUdVf4vTu5CqlgGndNzvaEnxOB6M/XOi+lnUIHpgiB2?=
 =?us-ascii?Q?3PF2yZnOY5wo9pTWGy0uPz18wLqXCjFr4iftqnb7865dFgcenis9bG7mNTA9?=
 =?us-ascii?Q?3gnX1HrLSViEDM7eWTsgLu0POtOuhfKNwWzuQPGD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd56d939-6526-4435-f6ef-08dd7e938350
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:18.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbifYnn2oBWRV7RMqXE5cucshmblhfZlR0DwZOzxs2E0qmJpX4oxAGekaT7aFXl1KkLzKOwAYgv/gkU7qU5RLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654

Hi,

Please find the upcoming miscellaneous RCU changes. The changes can also
be found at:

        git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git torture.2025.04.18a

Thanks.

Joel Fernandes (2):
  rcutorture: Perform more frequent testing of ->gpwrap
  rcutorture: Fix issue with re-using old images on ARM64

Paul E. McKenney (12):
  rcutorture: Make srcu_lockdep.sh check kernel Kconfig
  rcutorture: Make srcu_lockdep.sh check reader-conflict handling
  rcutorture: Split out beginning and end from rcu_torture_one_read()
  rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
  rcutorture: Add tests for SRCU up/down reader primitives
  rcutorture: Pull rcu_torture_updown() loop body into new function
  rcutorture: Comment invocations of tick_dep_set_task()
  rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
  rcutorture: Check for ->up_read() without matching ->down_read()
  checkpatch: Deprecate srcu_read_lock_lite() and
    srcu_read_unlock_lite()
  torture: Add --do-{,no-}normal to torture.sh
  torture: Add testing of RCU's Rust bindings to torture.sh

 kernel/rcu/rcu.h                              |   4 +
 kernel/rcu/rcutorture.c                       | 440 +++++++++++++++---
 kernel/rcu/tree.c                             |  34 +-
 kernel/rcu/tree.h                             |   1 +
 scripts/checkpatch.pl                         |   2 +
 .../rcutorture/bin/kvm-test-1-run.sh          |   2 +-
 .../selftests/rcutorture/bin/srcu_lockdep.sh  |  42 +-
 .../selftests/rcutorture/bin/torture.sh       |  89 +++-
 8 files changed, 537 insertions(+), 77 deletions(-)

-- 
2.43.0

