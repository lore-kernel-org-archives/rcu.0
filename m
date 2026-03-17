Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC639151C;
	Tue, 17 Mar 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782581; cv=fail; b=orcgLnhyjWQwLGc9g43sz/yDajrxB0ZRurCiK+p7JuPCQ8KdP1lfQ8fFJi+OLcHBfVNlZpFYilvbdiiayP9OKnuylI7AsRXxzTTLx67c+0sxsY646a7K9mn5oZTRzpeBXpf0mgY+Lm2oG96IHUh0x4qizd7bdmsV+CnqrnEPxN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782581; c=relaxed/simple;
	bh=/xXlPQePo2cWDfwjAyVaEV40CmTu401Zr1A7a3aWPaA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tMtB1otp1ELV1TPNf7TBUVa88rfjFJrY+7U0VpzUIn/tzx7ZdH+rywqUhTiYL8ovaCioWWqmXLPSza2OoUTmfHTBX9qYB3pnqLL3VLGecQgQXARAOOBPbNfDj0Fmb1YIeLU2sSnJAJIBoGg6jsPv9wDeHlwCakDilw+g81Z0C14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qx5Da16D; arc=fail smtp.client-ip=52.101.57.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qx5Da16D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqF7ERAjF3DVcXC/AFHAlVo7xjCd5NHFYJBSxVRgCsfQw//mIPFFCyp3hv9SSjiMJK5MIKODLAtyCU2KYDI0Gr8SEWs/vBKYzqf0LIa7ycW/NfhII/UgfmMz0BEGu+g7IkvQiVntKE34BEBp30a62bfE3FDVIGLBBaZ5DcsjP0O9hpKbJIG5aAbUh/fzA+G/tVNiJXwIfESXKN0PPHxO4F961FAMs07YPTFcJPUjRxm6e4+WlrS/v/VPyle0V44PtmycNdWA7lMrXYh3s8lKxMN6x0oKOMPcGWDWRFpclGP5L1eWov6ItkhTq0ddcfgbqUwv2zD5qpySXAutaweejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/SHnrgluu4c5XYEutbemw9MkvgXfDcygBfVTH3gniU=;
 b=f2WX1tRVQPlU6+jNG67clYJ558uRW+WHQwy4ErpnM3GCAXnruQr8d8B5VWYXR7j5tMIgeh6dZCLbssyEJh6UCy86tm6qgI14pWYqVbnnq75Ae4JpwCIdrxk0L8omJgBCsX4SpzS30hnc9n5vWqBAe2bmne+/dW3aEIL4ZaSMWHCS8LI+0S4RMrKG4A7Wr3p4VFZnQM73F5nZVSXNGujaHK0cgXuMD/N74lu7FOr9Kkyl/Tm89OVTlRNB/kd/TIyFiII+cEkmqU5mkfMzrO1ictpRuBYNM8U2zjBWU6Mwu2AQ3H1MsGqVFwFEiynUHi//1eB9VznR0x9VLJtGsqHljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/SHnrgluu4c5XYEutbemw9MkvgXfDcygBfVTH3gniU=;
 b=Qx5Da16DQLWCOFcVvHvME/2EHo9G0hhGVITVXUkW7btJynxznGi6x/WhVKoVs0q/n1DTE27Si53fUtkbBIpa6SszRcJJONqBlj+i6svl3oFhnZ9qwETHQL0NW5Ko6Rf5uHOwKchzLIpsl/NmlHXBEQhnBpXX9WHjzhYyvRXZFZXHXPVJJUoLbyhtbhT3R9SpPgc37azpng9235HHkbammQTT3Z1pXLNCt7sKWkeTXu6we7d7t1t06AVKd9kpFbOUW5+Tn017S+BcPNIK7cKeQEQ1hBaxGsSNtq9H45Ffn0DWTmpw6dt4siIVj3aehFwuCr1pDmi6OEKsAsuUZreFgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 21:22:45 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:22:45 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v1 00/16] Candidate patches for the v7.1 merge window
Date: Tue, 17 Mar 2026 17:22:01 -0400
Message-Id: <20260317212217.1527644-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0115.namprd15.prod.outlook.com
 (2603:10b6:930:68::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: e20ffeb1-396d-4134-405f-08de846b54ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ojnrePgmLkaumwGaNch8gEX/Z/h3Wy5u/gmzjocO46VmP1dh51ptf8BhwFIQD2wzEFpZscq2Yf3+G6faqDN3+V3Sxk+qTgKA2YmZSqRESWcmxsowyhlHGVKuSzuzqOKmuGaj5YS0mZK5JlwCke1p/8+T2IBbQ4Sfyal8JfQ9Lx6O+HZYJ9J0GU4ChjVdklxWLxm4Pyq+W0UYHOgVlxgKxsMsBpuA70jS953GeAHpwapsbs4xR004D1ANtYflUpsqlUMazEzqd0ofsjCFXdVyT8RnaL2KCg8J4X6raottzUvmlGase5sOC/VN/Qr3wfjYgePPt0tz0QJpcuEVZJk8VHZcfvaZLZs3/hHsMLUpfxzq+LiwfibMnUnmPy17XSkcyAm0+kazJs9nDTAJ+7EXnA1rpA6sS15rJrdv3mt1V/gb2mhgXxgYAQFhlRxwoiMcCJwCYovppoU/JW9z4XNymTTrE+OQcobv5QbjQtI/l915BGsTVphR5s0nCKS2SxVWT1ASmLcm/zwpUy0R83vCpd2wDTJmMVsMiAM4gYbkdyb6JGLlmrCxdagsirwRFEPPrYtewsF1IR3FneQeZKjIznU1ZyoHVG5BfnA3y2ZDH90Bgpqubms1NIw2iXrYwS9zUutsGrSLP3qggx/IYlX42M/1x04PrGvKSYnSNtwoDC9tZeB8YfKZunfXnPP6DJK7WC/51F9pmF2WS5rdsdYRadn/9QRZIPCxmgn/sdFCY9s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u8O1N4bc4m3Ub/PzL6mfmCAlz4KnIWD9OK7cQZ40Oxqb34x1NbAdFBns4Yoy?=
 =?us-ascii?Q?vQC8/2rRqQaPzvRQtKlD1NPiSKlZ0eNgVXxY1ztn/hdLkH+TKtLvAu/gWHdI?=
 =?us-ascii?Q?t/iaN9O4yZ0VBcC7mjFnG9zpXfowGDc2vNezANDF6nDrefOoV/OAgEphgN4J?=
 =?us-ascii?Q?Adgeh8zVXVpuiZPuvbMgNQ0hBmBrF++WmMpjAhfkZp+SmFXmkNZ0yzSP0ZL6?=
 =?us-ascii?Q?2b2zAEBwMi/JvJVN/5pa1cjT795H3jpXWnpceRdFhV9QqylVdtNRTv+nxBEk?=
 =?us-ascii?Q?vc4hNlyMBeGNRXoSDPeAqzynsfFAjcpHR22w7UeVY2XQl5bes2Nd+H9sGQDa?=
 =?us-ascii?Q?cen29BTay4VlQ89+5jr+YnC62oQLWdnvsghdHAKz1APECfFqeAPYSD715YFZ?=
 =?us-ascii?Q?B3fRUElD5WR+AEvFXi68bmitZ0TYm6sB5XLmuQQjebL+c/zeV02KzvXjLGae?=
 =?us-ascii?Q?i5ocXVhkbNTOn+jZEWBeWNh7ywE8eKrnxZxUPTNdsMmmANncMvNDQzLfXGma?=
 =?us-ascii?Q?VU3pTqyzAq93mRJpkdmI/YZ9nKl5HxRUxSdyXRbIjH34BHJW59K4e3jb+roU?=
 =?us-ascii?Q?UuQnY3MgyU73l2aS7t0ax9hpocRjmyhROKKyJrniC7oWJG9houOI7NXNiaU/?=
 =?us-ascii?Q?QLoiYEtQdYPiU+AN6Buq7aVwnMNGfIqUY6mI4dJZXgZWtPXdOV9LwiTeSzGZ?=
 =?us-ascii?Q?/QnxO1snidToRvXlCu6dIZe0bwDXRBpfj5YJiQQXMdMY6sW5l4MnZxaUMgY5?=
 =?us-ascii?Q?r74Bze8W8UhFUMB2tNLbbIOAnlX7p2TdMUyqfb2sx5j88IBuqhhsHELpBa7c?=
 =?us-ascii?Q?DF4H6TCeQ8knFc8fSpKO0vTcWXwnejuzylR8tusK5WEvx3jCMi4q2BZDLZf6?=
 =?us-ascii?Q?wwem4X3kVSPwonyU77CO6V1K8PqPBztjR9tbWYP+Qs/Fw4lzTc+TAnj8t5cC?=
 =?us-ascii?Q?4A8dAp31jEeeZ6Ykf0n+3KfcWRkTlHKl8dm4akDzyjgvZflz/DGn8MOhTuyW?=
 =?us-ascii?Q?WHIgIsNzJwkbrFC+42jwdiY9n3stDd5L0P8sPiXmVpDOXeVrcBuoLHUBPyUg?=
 =?us-ascii?Q?13kPbY4gttvSbjrHKv4OvVKr7XdWxIZJVKKWKhFNbOPvgExd52P5DuQrw1/4?=
 =?us-ascii?Q?jMnepIrKa4RcxvKf+ZzT5sm5p3fervn6qd9tT49O17mV0EzZkwRwVp1fDTHf?=
 =?us-ascii?Q?V2L2P54At161qs8TbnWGzqRIkoRyUkm9+oNGLPX2BBKF6bIRW4Nd12UzxUZ8?=
 =?us-ascii?Q?q8ayrA+dPpzycp+wQ3ZygRLvoRhvsV22BivH/BpnyMiuObHfqR7eAkkxMW9r?=
 =?us-ascii?Q?sOJ7V4VnmaBVtx8pDQqYEch/2byv+Vw1HJcgSrmMOLmbbwvn8M+oJmlBR/+S?=
 =?us-ascii?Q?keDdAzQ2ogzm2vMB+gizpogZJarEb3+PDbYs9vvJNHI3onofNqoQx0y3osRY?=
 =?us-ascii?Q?S97IfqQs91Zsvriz2nRQXiP6BgXmMYKL4hv2khjw6IbKKktoG15gT1r7VL4k?=
 =?us-ascii?Q?J6XD1+//gNvSs59637y6WBmBSTB20pzfHmi7IuoCQRCOm4pZSoGiHo428+JT?=
 =?us-ascii?Q?hoppGMLawawf727w7WZPmfFAhogibeu38ypTbEovqGCtY4O+8sAl6+xCOR5M?=
 =?us-ascii?Q?2V1ULLqwiHcGUFC0IyfuehuIMYFYL/06ebVsv7L15s1w1kkV/3W3yVO+uOt9?=
 =?us-ascii?Q?Pdvla0qA5pCP2zb9BAxDsm4AtcBD9hvQT3Q7DQFquGGVynFJ/RtmLnt4xFm+?=
 =?us-ascii?Q?RQWNexky+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20ffeb1-396d-4134-405f-08de846b54ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:22:45.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RY5+WOQ+INjm05BI9XXkrMNWV9fqjJSHCyzMvhneO4S6OVjsPfBzUr6ozdMbdwUA5pIsCt/wida4IH7WmOeSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379

The following patches are candidates for the v7.1 merge window.

The git tree with all patches can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: rcu-next-v1-20260317)

Joel Fernandes (4):
  rcutorture: Add NOCB01 config for RCU_LAZY torture testing
  rcutorture: Add NOCB02 config for nocb poll mode testing
  rcu/nocb: Consolidate rcu_nocb_cpu_offload/deoffload functions
  rcu/nocb: Extract nocb_bypass_needs_flush() to reduce duplication

Paul E. McKenney (11):
  rcutorture: Add a textbook-style trivial preemptible RCU
  kvm-check-branches.sh: Remove in favor of kvm-series.sh
  torture: Make hangs more visible in torture.sh output
  torture: Print informative message for test without recheck file
  rcutorture: Fix numeric "test" comparison in srcu_lockdep.sh
  refscale: Ditch ref_scale_shutdown in favor of torture_shutdown_init()
  rcuscale: Ditch rcu_scale_shutdown in favor of torture_shutdown_init()
  srcu: Fix SRCU read flavor macro comments
  srcu: Fix s/they disables/they disable/ typo in
    srcu_read_unlock_fast()
  rcu-tasks: Document that RCU Tasks Trace grace periods now imply RCU
    grace periods
  torture: Avoid modulo-zero error in torture_hrtimeout_ns()

Zqiang (1):
  rcu-tasks: Remove unnecessary smp_store_release() in
    cblist_init_generic()

 .../RCU/Design/Requirements/Requirements.rst  |   7 +
 include/linux/rcupdate.h                      |   9 +-
 include/linux/sched.h                         |   4 +
 include/linux/srcu.h                          |   4 +-
 include/linux/srcutree.h                      |   2 +-
 kernel/rcu/Kconfig.debug                      |  11 ++
 kernel/rcu/rcu.h                              |   4 +
 kernel/rcu/rcuscale.c                         |  78 +++-------
 kernel/rcu/rcutorture.c                       |  57 +++++++-
 kernel/rcu/refscale.c                         |  51 ++-----
 kernel/rcu/tasks.h                            |   6 +-
 kernel/rcu/tree_nocb.h                        | 137 ++++++++++--------
 kernel/rcu/update.c                           |  22 +++
 kernel/torture.c                              |   2 +-
 .../rcutorture/bin/kvm-check-branches.sh      | 102 -------------
 .../selftests/rcutorture/bin/kvm-recheck.sh   |   9 +-
 .../selftests/rcutorture/bin/parse-console.sh |   1 -
 .../selftests/rcutorture/bin/srcu_lockdep.sh  |   6 +-
 .../selftests/rcutorture/configs/rcu/NOCB01   |  21 +++
 .../rcutorture/configs/rcu/NOCB01.boot        |   2 +
 .../selftests/rcutorture/configs/rcu/NOCB02   |  20 +++
 .../rcutorture/configs/rcu/NOCB02.boot        |   3 +
 .../rcutorture/configs/rcu/TRIVIAL-PREEMPT    |  12 ++
 .../configs/rcu/TRIVIAL-PREEMPT.boot          |   3 +
 .../configs/rcuscale/ver_functions.sh         |   2 +-
 .../configs/refscale/ver_functions.sh         |   2 +-
 26 files changed, 302 insertions(+), 275 deletions(-)
 delete mode 100755 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot


base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.34.1

