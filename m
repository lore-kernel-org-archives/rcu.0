Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812683F7ABB;
	Tue, 31 Mar 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978927; cv=fail; b=tk2ydFeMP1EZdkvJpNa43e0Yo6u+3dq30e0c4NgQJTpgjCrfJlffFPOiV+yjlb6isaKs50JyjPhUL9jRNzcrlFvR/qq8rOnI/eyqaBTL/Tgy2+p44GuQ00icv4ndm0vyBZdf9nLolkZzaoqK6It+FLwQ5erQ5jXfYPjTuo/V8L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978927; c=relaxed/simple;
	bh=87jwojznyV7tKqEWfR6kB+dpbhfj3CQgyganvY0yaq4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qilV83l/hssNvaFHprEJyVUkjy6mnNBjLwk3Az8TJcuRzriA6+G71tl0iU5qpR35b19a8iHzDpYUgwTGWBGRNnLN0YyntzIbRm3j1a9xdlH/4Fl+zmbSLL6geT1lOiGhJyJw+rba2OSrzeSBg1JasMoJtmrO/WEoc+djw3moI7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HbSKp2QT; arc=fail smtp.client-ip=52.101.57.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HbSKp2QT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K93R0EIbIQig2az13D3u/BnTyCU5pEJ2BeHs0BlCap/vP//zoppnSkfODPOZdhv7L7SjQWNhj6HWQWK2PbFn/6oy/UUg6gDUVnBzYH6gum7jDbtqF5e+PIMz/Qh871M9v518NXhQliEojcEihtt2NELvLVU8UFOWm6XhRMcwpjfhx9YU4U7D+vqSA7OkQWhN1ZX1sdw8wmp3XEk7tHg38JupyPCNVj2yEi8Led6ti7aKTQPfhNZboy6KBaFJ6DIerImiZbTQrhIZ9PiPFRcfnBejMInmnEn066TTrwYuBDBXq9Ykon6JZUdWGtNWSrKB+I5jL5uSjvJUvmHogynBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4jBrHBvEf02kLxRhHX+iwjoHr7avukbfnW+WZyveqU=;
 b=VQkssASzSyuiz8uBEDWW5I/esFzCe4Ma0RkC/H4QmAmgQ90U2Y/Ym/Db7Nw9W7GZFVf8OTWhoaPZTXBl/moScDWcy90TK/iVFUHtCXP5HvZ1fNPD3ei5NJ5XCY3GJv09DkzgJRKfYVYZ/7ELK1sTrCc687XS6XzrbpQw9RXgtA4AndvhKlQ2yef0GP2qYhI18y7gFVUkF2r1whBtIXMeb/tHNI8NUK4tcUX4tMRsBBNESFNE12DFKKawMH+ha3H5v0R6KbSK7CDPavkM+bs3VCMVBfj12Ljm1mieQUHR+DJkXyqoMkGczYC7gaAwB0gqlpGhALq5u9hJja7Nr3/lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4jBrHBvEf02kLxRhHX+iwjoHr7avukbfnW+WZyveqU=;
 b=HbSKp2QTDykc+WWw1pk4949bYeglVa+yWSAkEqgm+fbZlsykEseHlG5fffWWVbO79M4m0NyWhd2GLV425rBM6/7GELma0FtjuzEFLikoJRiDulvJ05UaZBqkHF110mhY8X0gSEibICzHkqpE9g3zvxqF29gkn/WAvgEyNWOfj8SQsc+WmwXmay8SdVn94cKqj26PCcDXqAEnImwe9WKRuFXCwc+5IJNAVhogCF0f3hYUFmBYBPLFuLFev0J8HItUUcTC8smlcVYB5+RhByxzQovRfYpFTwFpFp+wKEY5TACHL2D9sY99ZLuIbzhFM8Hbr700wd+0QfPbrx+mXnEWEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 17:42:02 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:42:02 +0000
Date: Tue, 31 Mar 2026 13:42:00 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, joel@joelfernandes.org,
	agnel.joel@gmail.com, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [GIT PULL] RCU changes for v7.1
Message-ID: <1774978730.3972500.27807@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BN9PR03CA0892.namprd03.prod.outlook.com
 (2603:10b6:408:13c::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec50c6a-63ef-41c0-c466-08de8f4cd0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|4676001;
X-Microsoft-Antispam-Message-Info:
	Gjnow+OeTyGzr9QKJkv920FLokwNdvxfa0Ssg+/av/H7iUu2K2muZxi4LJtKw4XijIllNAvL0+LmJ9E/7VkOdHYebpN0q3QyFlMoH6VG7dJFlhuFDQEcoyg7++kFehqYYgHposC0W75zTsNnRXfDVqtIjHu+dkr0D4Rfgx/QYJ+TeOcPDaa53RjmYLAeUXO+E1mnevVPaHBTvAd6lqLnYf6zrvgzi6vopPx8L+sv7NRNu7IJszfeE7vJCgJdmq6gOXopddNLUN9Su5PMl3TUPvHcPNd+h3gCmV8yFJ1s9kb2SWZ8vQT044R0/di4A2KC/e/SueutHIzRKuaq+8jh86/Ma61wNngt7mQZioPv9WJ541sGjYiBTd3cBk5xWk7dfr82u+ztkKsPvdvkmA+3bFROei6mjUazYXarROViwzMLaDAoaAdcOmFTAcY4DDKA2N/p/G/RZ/XkU18vamGE1NRho8fFjAugjeG0hJKulSO5AEUo0W2Y0CK1ddKTcG29z99qYhs5qiXbMyQciwYJufzfUTPyaxAsUSTo2GVI3rtUgNHklMtvFp47vba0FlziAih0F1PUmqErLcHyoCaSDbycEy1PPEhS/AWDVTYmVLg92k/D8VE8dvbqi6zpWzKKQOQTRQ/ifmU70dbpvA07uOlLQGUI6iJ9JoKgFsOhf+HXc80AbQjOQJjuna3SOKtUPryA/QQGaIfQkPro9xc40ED2iNm2K37NbP/4VW9kgLGBaQUhAR6TpoL2eVAqO0oHO6LkjXnRl1zjV/mUFSl6NA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(4676001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ez2wKZKrnBqR+d2ztGJXDTFedGJuX5FQTX/oo8P1Wts5aBxY+dY/VTFu/rzB?=
 =?us-ascii?Q?eSsxrxncc9hDjCqIXMR1NyIABlynFULKdJ103dYTokYSkYdHTOn2R1qjANt9?=
 =?us-ascii?Q?V2AHzpLtXqYgoW2LSzBkSkFMXTvpZAg/7iYlUe2lTBp4M1t6t6YsGgl12dTa?=
 =?us-ascii?Q?+t+xje3Bm2xlO22Qaa1JWnd3biwYat9DzldZjqNo5gtBzLieXT/azggDGE60?=
 =?us-ascii?Q?zusm2DHh0dBtCrYVUUGbegABLWSILJgJGvJeMBzyYmSl+nVR1efiatTlkAkE?=
 =?us-ascii?Q?1usqe5E6tvz7MbH70xS19Ly5GoX6j/zyllwZFDTHd0Sbn/pzd00iXo1KuX5D?=
 =?us-ascii?Q?fVGbkj4Ps/5sr+jXDCGyaNn6pPmN8C5+DfSR+wQTK+XyNoczRgAljAcbySmb?=
 =?us-ascii?Q?rHodWg+zHjmj1elxp847HJO9YwYq7umK4PLotnuCeEQn0/k3XZEV3qUhOvJp?=
 =?us-ascii?Q?/O6TKtKDi0yFNRWa6xde96huPLWymkz2MThnCqWIMa41w10Oy9S1RnPx0qEk?=
 =?us-ascii?Q?jpLNUAkww3q6gKDLiBKv1owPhcxZZBYtL5vlyo2zkBf5x2qwCNq9I/Z28GGD?=
 =?us-ascii?Q?HVnb2qZRtWJ0ORY8aXxHqd1RHMEYSn2mN3C+hrFry61vOz9W18KWRRa6kduS?=
 =?us-ascii?Q?uv0C0texZNySYB4aYNByph8NhwQfXNQHxvzaN1ZvQunRWKM4RilSqh8LRjo2?=
 =?us-ascii?Q?4sro0M3Sbnm4Ub722a2LBgAG0JlzD5+6Ax6eRzZLI3wuXmS8pjbOPlZOlKYq?=
 =?us-ascii?Q?V4qPbmmHTEsxhYGeIqXa5qCl1KOsU+CJHMWYIOk41zcSlpZUlUheml+JhIv0?=
 =?us-ascii?Q?6N/n2x0mFPSQymXSIkiXYep78OyKpyxcxLgsoKvxt4pEpWOK206+17U/4Uzk?=
 =?us-ascii?Q?Albo3UTtOCcWUyMdXzAyHvBzlHp0uujZsNZjuiDcz2qczki9EQ+yn7odUtAg?=
 =?us-ascii?Q?OL4fh4UWByIpfmYMpJFOlslk6wmBtz2eNCPS30eZEcRUaM2PXU8Hqwb6lScc?=
 =?us-ascii?Q?EOKkubGWafYfJJmX9rvPStJ/xvBgsvHMq6aNezsar2qeRgwdLF8a8KfHsP6i?=
 =?us-ascii?Q?hmxBQdcO7dNeevMjCliAtwVC8JrpD+CDNWdsIzs3sNlb7low8Y2unQ3uLy6I?=
 =?us-ascii?Q?/ZT1kevY3d7hJhn6HYiQnujqSM9wqEW2XQyF5dkO1AvWqGPWQDSD67djH9U6?=
 =?us-ascii?Q?MO4u/GIhRaWdBcf+5SKKipuzPL/dsISKiAU0afjg0KKt/+ZK/M7gKclXVyki?=
 =?us-ascii?Q?qJXYqBjJd5tM59Af9OB5FUYi/TruFZNsZCsOED/BKtjlyGW68F1Zc9HLETlq?=
 =?us-ascii?Q?oWcJQe2sz2LDayf3Z91fAXfRKh8ni+/fOQVP0712xyb00cjnJxXvfj/YxUwq?=
 =?us-ascii?Q?W0aLypkEtD2davX3xoj3yKJIVmoysSy0ZPQbfqXgC9o9UhlGdHOi1OziDXaw?=
 =?us-ascii?Q?0UqHhvd9qwjmJMMoHf0Pf2bvjYqMxIbtiVSEE/WcbZE+NU68CCpw6nuaWsJ9?=
 =?us-ascii?Q?HbzsW4LEDC66jnHN3hVzrMqWJAsLlCxMekilVzrEcYDqyDZK/+0ptq6bxDQa?=
 =?us-ascii?Q?amSCNlyWuynWtGKpG/IrMzSeJ9BpxlUhsnsgycZPNpTZ2N1vc7Gk7fW/ug47?=
 =?us-ascii?Q?isxmTZLjG8/dbQ6L/vT/NkoC+klFuKkSy9qLEMDR4vG1EzvLy1ZdJvhXcGuD?=
 =?us-ascii?Q?2uO37ybntvPTh0swMiaHjZDcP+l0f+/nrrTOaDLx0THdawPvP3aNFo9zSwMg?=
 =?us-ascii?Q?jIUt3nElUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec50c6a-63ef-41c0-c466-08de8f4cd0ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:42:02.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyqsbYgZaXz35A/8g27dSQrgSG9soszCf08NghKWnaw3ViPd3UiHDkcWk68Bj+/0WTEauBj++mElbYlJZnC96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

Hi Linus,

Once the merge window opens, please pull the following RCU changes for v7.1.

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.2026.03.31a

for you to fetch changes up to 95c7d025cc8c3c6c41206e2a18332eb04878b7ef:

  rcutorture: Test call_srcu() with preemption disabled and not (2026-03-30 15:48:14 -0400)

----------------------------------------------------------------
RCU changes for v7.1

NOCB CPU management:

- Consolidate rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() to reduce
  code duplication.
- Extract nocb_bypass_needs_flush() helper to reduce duplication in NOCB
  bypass path.

rcutorture/torture infrastructure:

- Add NOCB01 config for RCU_LAZY torture testing.
- Add NOCB02 config for NOCB poll mode testing.
- Add TRIVIAL-PREEMPT config for textbook-style preemptible RCU torture.
- Test call_srcu() with preemption both disabled and enabled.
- Remove kvm-check-branches.sh in favor of kvm-series.sh.
- Make hangs more visible in torture.sh output.
- Add informative message for tests without a recheck file.
- Fix numeric test comparison in srcu_lockdep.sh.
- Use torture_shutdown_init() in refscale and rcuscale instead of open-coded
  shutdown functions.
- Fix modulo-zero error in torture_hrtimeout_ns().

SRCU:

- Fix SRCU read flavor macro comments.
- Fix s/they disables/they disable/ typo in srcu_read_unlock_fast().

RCU Tasks:

- Document that RCU Tasks Trace grace periods now imply RCU grace periods.
- Remove unnecessary smp_store_release() in cblist_init_generic().

RCU stall:

- Add BOOTPARAM_RCU_STALL_PANIC Kconfig option to allow triggering a kernel
  panic on RCU stall via kernel boot parameter.

----------------------------------------------------------------
Gustavo Luiz Duarte (1):
      rcu: Add BOOTPARAM_RCU_STALL_PANIC Kconfig option

Joel Fernandes (4):
      rcutorture: Add NOCB01 config for RCU_LAZY torture testing
      rcutorture: Add NOCB02 config for nocb poll mode testing
      rcu/nocb: Consolidate rcu_nocb_cpu_offload/deoffload functions
      rcu/nocb: Extract nocb_bypass_needs_flush() to reduce duplication

Paul E. McKenney (12):
      rcutorture: Add a textbook-style trivial preemptible RCU
      kvm-check-branches.sh: Remove in favor of kvm-series.sh
      torture: Make hangs more visible in torture.sh output
      torture: Print informative message for test without recheck file
      rcutorture: Fix numeric "test" comparison in srcu_lockdep.sh
      refscale: Ditch ref_scale_shutdown in favor of torture_shutdown_init()
      rcuscale: Ditch rcu_scale_shutdown in favor of torture_shutdown_init()
      srcu: Fix SRCU read flavor macro comments
      srcu: Fix s/they disables/they disable/ typo in srcu_read_unlock_fast()
      rcu-tasks: Document that RCU Tasks Trace grace periods now imply RCU grace periods
      torture: Avoid modulo-zero error in torture_hrtimeout_ns()
      rcutorture: Test call_srcu() with preemption disabled and not

Zqiang (1):
      rcu-tasks: Remove unnecessary smp_store_release() in cblist_init_generic()

 .../RCU/Design/Requirements/Requirements.rst       |   7 ++
 include/linux/rcupdate.h                           |   9 +-
 include/linux/sched.h                              |   4 +
 include/linux/srcu.h                               |   4 +-
 include/linux/srcutree.h                           |   2 +-
 kernel/rcu/Kconfig.debug                           |  35 ++++++
 kernel/rcu/rcu.h                                   |   4 +
 kernel/rcu/rcuscale.c                              |  78 ++++--------
 kernel/rcu/rcutorture.c                            |  64 +++++++++-
 kernel/rcu/refscale.c                              |  51 +++-----
 kernel/rcu/tasks.h                                 |   6 +-
 kernel/rcu/tree_nocb.h                             | 137 ++++++++++++---------
 kernel/rcu/tree_stall.h                            |   2 +-
 kernel/rcu/update.c                                |  22 ++++
 kernel/torture.c                                   |   2 +-
 .../selftests/rcutorture/bin/kvm-check-branches.sh | 102 ---------------
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   9 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   1 -
 .../selftests/rcutorture/bin/srcu_lockdep.sh       |   6 +-
 .../selftests/rcutorture/configs/rcu/NOCB01        |  21 ++++
 .../selftests/rcutorture/configs/rcu/NOCB01.boot   |   2 +
 .../selftests/rcutorture/configs/rcu/NOCB02        |  20 +++
 .../selftests/rcutorture/configs/rcu/NOCB02.boot   |   3 +
 .../rcutorture/configs/rcu/TRIVIAL-PREEMPT         |  12 ++
 .../rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot    |   3 +
 .../rcutorture/configs/rcuscale/ver_functions.sh   |   2 +-
 .../rcutorture/configs/refscale/ver_functions.sh   |   2 +-
 27 files changed, 334 insertions(+), 276 deletions(-)
 delete mode 100755 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot

-- 
Joel Fernandes
