Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A93914FA;
	Tue, 17 Mar 2026 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782577; cv=fail; b=D/hKo92knRsbTSByzDImCcUTeJn0gUhp5coLtKXRVWa0rWWMFB/ok4LmLL85GYFMZuv0CUHfyXxFPVt4MPhUcALCJ4eEEivlMILgKekb4WeLr9BPdGTdVYN9Wp05xwvr/ViiB4GiqI9t8rJbrda854F2yyd8r0MHKkCvfQ5yiP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782577; c=relaxed/simple;
	bh=AEiXMlQWEp8LP6eQr+pWNjWw9hVV1gRQNTexmzDsIAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=joSod0l1eiEX04XtBJ3hs1TAVJOCbT/0ctoQwzMHNWu7XF4XA6rU6TcdexqlAmUWG2fAU2Ibl7w4vy0tz2baehsOTsczq3WwN/8T1+71BLEmELwZgQVRuLVJjedxmcdonaR2B5VjY0JHtl5QaqZbVvS+OQcFTYRbFcIgoq0Ciq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ORxSSGzU; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ORxSSGzU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hux2AgOpnlymG5ZRzbssRxsg5CKxwUb2UB8fwg/wukt64UuzqnsHnQGXCpXzi6olSkyX6fV6UC+23wdca5lJG5hVEugCoU3z2eMw6ek7+fwkr0czkUJtroxI46MvbPfDK1lvm30tjSIwQJA7SU41stsOlXyAUUFMWv7RNypX8LPwoe0K30xTbr2RTqcsPHZqU2IqpHLFrZRbZ/klpguyl4vWcODkqWpSE5HCJWfK173vYh08TNCkmghtlwJXYJwIPZvKyW8o6qPw0jgtm0WTWCYO74wIYa3ok7chTzx6EQRBvYAMwlg+QJg1W6JOspwdyEaTYbmH4n3e6XJMLmBFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=johDCN/8J8x0u8T3tPAD9T+nVp5ukXPmXStOfPO8/K0=;
 b=mPkVaSkHcQ6QHbAojiU67HB5gR7/46xQ0WxGuawJVu4lvLjG1SMS6hZdZKDzXJz4KMsaR+FDk+84bj4rk3srfOxbtBmLMeB4WGAlmyG/0OI9c8KJDKai8tXu4hFf8WJ5ikL0Z4X4JxKDFcge1o6nU/BjfvvwuSCHJrXli1qTN8pXit8xsAKkg0JIalAl+ViTUhwayI+KsfyFz6CwdBI28oe62LZNI2FrclJhBEpzYtMqlzPLsE6sGnYPVYapN96Jp7Ybd573F7W9FdQfkSX1g2JT7uTYZyoXvRZjgflBAef7LyjtTFnyAls4wbxxHHq6Gj5djMOHLOCJMYvPuMlplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=johDCN/8J8x0u8T3tPAD9T+nVp5ukXPmXStOfPO8/K0=;
 b=ORxSSGzUQQwktA+chjAnNyDhVURi/L9PbVGlSX5y1YZqJrXBf60DMGac9DbIci7dfWIruSUVvYGRfsKjbHTRgzKoxqxRoOhJoMOQ0F5JLJS92CkaeA2QF0bak7oM+j/fRucgryu78Nb7vL9myauYfI0x4T8FimLZJhhU/wmnx8znBBoTdBUYghsVJBrKAzARQ/CGaIHk4P/8FtsrC57Val+zr+I1VXReclmvtUpVGhpDoOcaLpuLMCEYPQBIclugEMHPca+kEerTZotXZ1G9kWcB2xAc8yE7aBLHcGpf+lgT2aFjNN/23v459r9xFbPVopzUTKDPAiO3MnUqA6lfSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:22:53 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:22:53 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH -next v1 02/16] kvm-check-branches.sh: Remove in favor of kvm-series.sh
Date: Tue, 17 Mar 2026 17:22:03 -0400
Message-Id: <20260317212217.1527644-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:930:8::26) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 744fbafe-e446-4ee3-32f3-08de846b59a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	osV7GDoN/aI3P+jvQ18d6ryXZbK5mOw7RvSQjpSNSLZz6Wva+ZoGeMvsHGZQEJNCMUO9QdsmMs/GVJv/s4CaxhaRLtVXl4mtkrrWQTg+b7xJttNLIK8ooIXe88bqycB4QOj+tWy1hmckEoMq7Ra1uj2eh7ugu1ckTrAoPiBdpnHUI+LEpj1gRGrMx3RdRsOV5MS3l2g28gQnHb1HO/9ZiXPVlojA34EOoVSuw0yTn5JHu+uX+hveiF1RPRwHNoCcJgVEXYXkKmd+CnRNFvx6G0la0p4lRUofX8/8mUbQpRArvaDJ/qQHnmSEZ/Re+aQ+SuNab1nW6aeprUg7SMDDiaj6UPJl1mMEwlDAhjqWqYvgXx8VcpFzk8kBmSYAp/I/qKtB18/beWxRZEqJg8Al2iEDNKD8z4Hsdh8e38hi8S3o+C5A1T2XkcjvislZENkJ8MEY2KxyruWtcZII1qQXiaRpbVJyhcGp9u1YDBw7gsgkof3ZFisE21OV+7JT/v5K4pLM9bobG0qZU7gNash82/DyUUCW+HaLKDq0z9v6W1reMmHfH4p6qSUKB8zLsbxDwQQNUccckaFHXWLWTxO9C0W6232u/zBPJku/eHI0SI/oVBWr9mrP1bXXWTsAUhYI6dJdCQoqRhj2CvurMxzVjJLbF7MC4L71G0p8tS8+ZFVCdVIgk9iYk/f5LNsNX2OR5TBZdee/SrtZbQ8GIBdjSQirI8dkwZSgIHZqr+aUPlo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RD1F4LK2Go/pflMseNMDYpBoyNvnhSgJDrTwtbiv8cF7E93SQcrlCWg/sW0a?=
 =?us-ascii?Q?Nq4kZ6Bo8ckaAmnUi8rupUYB/SJcbGrIVl7xfTwMVA2L02I4h8Y3W0o4m4Go?=
 =?us-ascii?Q?BcgEQJHNUzif8/374t6hu9DrvqTosexDfQizE396Uz+OGeMNVS/3akX6cY5u?=
 =?us-ascii?Q?/uNhaCwN8Q5VzZtFvmG/DoVOdh13EbigvQr029VTzQby3GXizDhR7uETE5pE?=
 =?us-ascii?Q?QWRNwPB9EXl+q3kOEffyqYCPx4mg/VNqMADRJ/Yq2xVc9KsRO7El7yDx6Tcx?=
 =?us-ascii?Q?gR7JXNEBIlxIPx/3RYyuQD747XdQF2fmUeQd33iIkFCOYCmrhimc7fZs80Td?=
 =?us-ascii?Q?dJjx64zDlFG7ErQ5oj0Wno4ec+HXwzhQVhRli0EupWBO0y7Xwz9ZZF26doGb?=
 =?us-ascii?Q?9SNs0kpBQDWmtEAk9Q35JuH4X2dFahFLWniEIglpivBGHnaO6q0tijY/ZhAI?=
 =?us-ascii?Q?04IfOC84UpLWz2+jaeH0iqMKb6fhHjnUafbf+Z8q7I37ZnU8EW78RFsLK1Bn?=
 =?us-ascii?Q?VE1TfoGuBnrFGK1N8Pj20wBE/g59obyrPL+nrUPull9Fhd1mnkG+DuMCBFmI?=
 =?us-ascii?Q?C7a1H2gKdZRSmV78NcjcZ+NsEl25YxeS//y1dFJ048r7ZGWLakmxBvyP2ynb?=
 =?us-ascii?Q?LqAj9o85EerS2UdMcfKdBdsVf7z02xwlBHIMVVufN7kL3tyT0imkcZSEMWZe?=
 =?us-ascii?Q?Zv3LaJPyuOQPYS8+d6K3rmKso6XWroxPJwRlZBimY5iWiyrEKyHRr/vxDuNN?=
 =?us-ascii?Q?fYkAHwV8row/ue6Zw3Lvg4gONeuC/3h9alIXnA46MZyOafnW4fpkFFwWYL7X?=
 =?us-ascii?Q?LrMhfwqpYTk04mUe56aGi7KJL0LVgI+Fca4UmgfZa42ckcXXcvqvNqmtUvmo?=
 =?us-ascii?Q?zdv8js82gchrYvO6uujyrKwOikogHH7xibkeObYIY7wowPT8sIP315buUDHs?=
 =?us-ascii?Q?Rj6rdZZNQmH38Iy2iR2rLrlzGSspOe1gig9YrAk1ISPe2h4YwLccWAK78fBI?=
 =?us-ascii?Q?qSGfjyXc8N8KrUY6IdoJePqE783oXfDcBFS7mrNzq+4lBlR/Lxao3SyZ/17x?=
 =?us-ascii?Q?40ZEsJqktbp7YMlLO1aZg7OQqA2sa096ZXCbxE7R74zFwBSXHJ3PfPuuSZGd?=
 =?us-ascii?Q?tCFu5UR4Ia2q8xHp+G1y057ik7TmH9cofLsQJUbw2v1lbgdiUEcgTCxq+sit?=
 =?us-ascii?Q?Md+6je58r310/T1XgMjht2Ad/FYEPrO8RXqeYtlm4xOTBkfzCy2KCO1n/Sgf?=
 =?us-ascii?Q?cQJOn4vnQMo14qN2aHy7hhl5vxkDu9H3HlhKsqk+w4p852+OYHT/VtY0XfcE?=
 =?us-ascii?Q?z/z8WEXY72MzUUFYcwgCqiACjwUOIjXJdQXncJtyAc5MVhNdCmRpZejjh7WE?=
 =?us-ascii?Q?SDmZj/p6uYPQIfidmiIteqkGt47r0/XgPql6uGuS5R9aESOSByl4K31BBigZ?=
 =?us-ascii?Q?fShl3oYChGWFGqT2c9rI1QzkUNO1PUx+TMxrWvzxd3tONstYZ3Z5y/UNG5Vj?=
 =?us-ascii?Q?YGgnoxG8qblYaWL41GDxqVRDHjBePEu+ghSFZhhWITErwYO8na5VBEbhMZ7y?=
 =?us-ascii?Q?z1tXyj9buS1D+Zl1NIuhKaC8OhSvzdqhHmj30wUwqEPXYWa4KAW9VkAhMC91?=
 =?us-ascii?Q?kuXs0di2xcEq/ZCJY7DCv0U0aEBa+q0sbFiGYJjk5hAbJG8gxFXMf82TsFgB?=
 =?us-ascii?Q?bv8MkEC6HVcA/eC127EYEqhAjtXtrIARfGeVhBwp3xkGzz/hT7LY6lBvFkYt?=
 =?us-ascii?Q?+3+C404BEA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744fbafe-e446-4ee3-32f3-08de846b59a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:22:53.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuwAdwY8ORd1IMFds8gutVRrycOYXpRGOL6m9tUKvIW2U8aSd0go1nUfs8pUx7RzsDrr7LBnSfNm7Hy2rS7hHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

The kvm-series.sh script is an order-of-magnitude optimization of
kvm-check-branches.sh, so remove the old script.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../rcutorture/bin/kvm-check-branches.sh      | 102 ------------------
 1 file changed, 102 deletions(-)
 delete mode 100755 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
deleted file mode 100755
index ed0ec7f0927e..000000000000
--- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Run a group of kvm.sh tests on the specified commits.  This currently
-# unconditionally does three-minute runs on each scenario in CFLIST,
-# taking advantage of all available CPUs and trusting the "make" utility.
-# In the short term, adjustments can be made by editing this script and
-# CFLIST.  If some adjustments appear to have ongoing value, this script
-# might grow some command-line arguments.
-#
-# Usage: kvm-check-branches.sh commit1 commit2..commit3 commit4 ...
-#
-# This script considers its arguments one at a time.  If more elaborate
-# specification of commits is needed, please use "git rev-list" to
-# produce something that this simple script can understand.  The reason
-# for retaining the simplicity is that it allows the user to more easily
-# see which commit came from which branch.
-#
-# This script creates a yyyy.mm.dd-hh.mm.ss-group entry in the "res"
-# directory.  The calls to kvm.sh create the usual entries, but this script
-# moves them under the yyyy.mm.dd-hh.mm.ss-group entry, each in its own
-# directory numbered in run order, that is, "0001", "0002", and so on.
-# For successful runs, the large build artifacts are removed.  Doing this
-# reduces the disk space required by about two orders of magnitude for
-# successful runs.
-#
-# Copyright (C) Facebook, 2020
-#
-# Authors: Paul E. McKenney <paulmck@kernel.org>
-
-if ! git status > /dev/null 2>&1
-then
-	echo '!!!' This script needs to run in a git archive. 1>&2
-	echo '!!!' Giving up. 1>&2
-	exit 1
-fi
-
-# Remember where we started so that we can get back at the end.
-curcommit="`git status | head -1 | awk '{ print $NF }'`"
-
-nfail=0
-ntry=0
-resdir="tools/testing/selftests/rcutorture/res"
-ds="`date +%Y.%m.%d-%H.%M.%S`-group"
-if ! test -e $resdir
-then
-	mkdir $resdir || :
-fi
-mkdir $resdir/$ds
-echo Results directory: $resdir/$ds
-
-RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
-PATH=${RCUTORTURE}/bin:$PATH; export PATH
-. functions.sh
-echo Using all `identify_qemu_vcpus` CPUs.
-
-# Each pass through this loop does one command-line argument.
-for gitbr in $@
-do
-	echo ' --- git branch ' $gitbr
-
-	# Each pass through this loop tests one commit.
-	for i in `git rev-list "$gitbr"`
-	do
-		ntry=`expr $ntry + 1`
-		idir=`awk -v ntry="$ntry" 'END { printf "%04d", ntry; }' < /dev/null`
-		echo ' --- commit ' $i from branch $gitbr
-		date
-		mkdir $resdir/$ds/$idir
-		echo $gitbr > $resdir/$ds/$idir/gitbr
-		echo $i >> $resdir/$ds/$idir/gitbr
-
-		# Test the specified commit.
-		git checkout $i > $resdir/$ds/$idir/git-checkout.out 2>&1
-		echo git checkout return code: $? "(Commit $ntry: $i)"
-		kvm.sh --allcpus --duration 3 --trust-make --datestamp "$ds/$idir" > $resdir/$ds/$idir/kvm.sh.out 2>&1
-		ret=$?
-		echo kvm.sh return code $ret for commit $i from branch $gitbr
-		echo Run results: $resdir/$ds/$idir
-		if test "$ret" -ne 0
-		then
-			# Failure, so leave all evidence intact.
-			nfail=`expr $nfail + 1`
-		else
-			# Success, so remove large files to save about 1GB.
-			( cd $resdir/$ds/$idir/$rrd; rm -f */vmlinux */bzImage */System.map */Module.symvers )
-		fi
-	done
-done
-date
-
-# Go back to the original commit.
-git checkout "$curcommit"
-
-if test $nfail -ne 0
-then
-	echo '!!! ' $nfail failures in $ntry 'runs!!!'
-	exit 1
-else
-	echo No failures in $ntry runs.
-	exit 0
-fi
-- 
2.34.1

