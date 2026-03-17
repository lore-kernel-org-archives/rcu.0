Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11758390C92;
	Tue, 17 Mar 2026 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782583; cv=fail; b=go0bDFa3FOVB5s6oUJ6FMzJKB4uO3dX0fSHf5C3h3x7LeGXID1z+sIfaT0H4xTtvfhF45RI9SO6ENUfUaH1C5guKr9bV3+8duZqHctv4z7hrxRqg6fi5W97MoqnB7mbyNaWW4tULKodyf8H2IjGCOneY2nek9uQ5y/R8lvkP+O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782583; c=relaxed/simple;
	bh=X/AAQgGk123cs3uC5obN7GlnJTpY1isFBjJsXKDW7yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=As1WagwXe0/FuSlNEYn5iQFO3m+BiVix7h0Qw7y9EKBAOqVCYfPES5WY8gFagzOO0Vdl0HIj+XhvTPV6034mtaRlzVvMuWZj8GKk3PqXevsIZsQsEQ92dwgKhxLSLEqGJiQeb1W3MJhC5+4lw4N4jN0tLj92cPUnhtZidjD0uSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bhIH1TU1; arc=fail smtp.client-ip=52.101.57.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bhIH1TU1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6aixX89AO/SW9lbuvao2CNI4GT89vnWGiDCmb8wKQ7k8DLbZv+hGqD2fTJT3+6/HOs2hQ1+QVLg0br0QXBhXzJoLmZgeA/8iPGD1w6FpYwsec9TvrYDJaKyNRAlt0h2tNaFA8C0RddPro/MWNzv80iq1tiNICG2daQF08iq7UQrZgzXvXJxd2nsdO9SxnrhW8nPlxAz/vcJU412wI2NyGV7G6aiZO+rTl9ifHdjmRke4ry4yOesdlT8GGJT0KuYHm3shcwefgg5hTn3NTptRdNva/yRSrJDbAquMpcazpF3d6SlCvBbRKDNaCJvy1eU36mVb3t6kGlktoBjz8Ue0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qM9F66fY64HvxIRDLKNZJ7FDqwCet6c5vxb0vHgqNBg=;
 b=A+SFhUw3jfp3byIHQBiTmCPF0zMFLJU555YZhFku3ix+nePXFNCNQVxxwbZO5Iy4DZiHDrt5CfZan/jdE6TyrJeRijJ8Y0UVr3eMkjHCBrl/Eiv0MEwQk2UKrjn19CKTILLs2bQbtWKl5Yk8rAckOhz/YRVfR6QCISiYrEcpiN5DKQTMxUk2FZqD3g3PUGc71+KNU/yLzUIDr7+hyb+fuikqwUw+Fy2JGmnqBKNOI1uXHDKYemvQ7BkQWN7aUlXDgF5eKWh9t/mW77ie2Ai40tmPiYB0zZ85j9u7v5a7hMou72HWa6u8RMCviaWRuiJVG22i2swFsKkchL0J1GPp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qM9F66fY64HvxIRDLKNZJ7FDqwCet6c5vxb0vHgqNBg=;
 b=bhIH1TU1CCzyV+eS9OwMuAX5J6f6QmDSDvutYDOsIZrhnR18iRDEMyBfqCyJI4xZFhDJZ/MrgONVLES0GKjAXEVIxJkMNf+JS8nBU55QrrO9Hw59MKnrpn07LC2wDGxMuTaWeNTjvhTDvb+1xvTNt+QHybDnWEzKCkM20AzBqvH9I8p+s09MII/QKqLgLaEjPqObXuJi2goomVjI2Z3siyWnMM/yi2q4vHiZBWSTvlisbk9VQcvIQ71jbdOWKDSzJhHfhfsXnoJjhA5hTksxqb3zNZxe6bvPqLe8jkGI3In6prdKNiCOK0gknlvJ626NGLya01FUycqNHMi5qDwDeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 21:22:55 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:22:55 +0000
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
Subject: [PATCH -next v1 03/16] torture: Make hangs more visible in torture.sh output
Date: Tue, 17 Mar 2026 17:22:04 -0400
Message-Id: <20260317212217.1527644-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: f1af8d4d-94a1-41f1-a684-08de846b5aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4WVbdfcCzO1l2g08hNO6yeK2vsxnu5RgGqH/hGGf8pCbxIv1KD8xtM/N10WNZ654ZqNElsozZI5E+feLotl7ucGu83ElucN42EpeKYzSfjk+wh3VtzMgS0mYVpI6y6ew4Ch1aU7iAF9k/wFQkLtj7J5VSQt3UUcUgvnjG/8PMZlR6U5yHoJnTtEvPG+i3Lia8IVj2q8q5ZFw8OZu9h9q8t0WJxo++PA3ORuX9dlUliku2Bw9tjJqX10qNf8SfkIIjPWgBBxPaVwws55op3DPf0v4iDVQilU8MzeR/rfPHoRs+J2xtS+LpmJ1QaybvzqT30uy2F6Wv7qZeSbsSn6E/2+97xn9J2wVat1xYZOUQWLqj9kSNLADrieJP2KNSm869m5fDpD5Lbv7WtKHrP+FVV2L6v2u40lHnvwTJ72zZMMR6529d+qDoeUBvuq8CkorR9PzjjgW1mm05b6EOQNQD26MW1hLiLzkiccLSfxiEy0e9bMtaGncgQO2Zt5iqkfxIqW+DrTYAVuIEu7Qv+vol+R+48BVtzAOZdMqDYxc2QafXtwg3aeHtOgw0tVVMoCR6aCCRvGY1EGMP3O4TQSCcNSSjdjfKflG3xJTi2M09NrxgpcXUzlNw1bzksiWacMFa7poT1MLK1yUnE0dHGp755FBc3aqdcYF8pIdM1Alzky68x1oDbdOldiiHbI26MtreQY7mZBZ0kK7+E37bZ0odJqPhgbQKSi+1bhNwMm8Djk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XyT550w2gLxuqdbyYRwFyjmFDhLT+lVQvaAaZBd6NDDsSHqqpOz4sxWN+sE/?=
 =?us-ascii?Q?MjKJgEnE7p5q5cFG8oNr3bkw+58UYcRPGnmPukOiO/aS3ngsyjihKCuClZ2/?=
 =?us-ascii?Q?4EG9a6rSVB+CsF2WHMNNXL9k3nXzqdH1prht5LETDWURd7tY/Ic2j2i0DX/x?=
 =?us-ascii?Q?2YD93to7MnKZdrF7J79Up+SxTHEZGbYoHoe9RvE8sv9cWgmoukYC4t21rVBk?=
 =?us-ascii?Q?aX4+Z9ptPni4EcWfjvu/MUu7oIOghTvGR4K8oc4uDWzPRykrOJRC7Af9pAbi?=
 =?us-ascii?Q?GDbhG59pmE9Ly7Akdu9iIdpA8f3WDKX1c0OhDgeX5BqY+vLup8/TMDQnw3TH?=
 =?us-ascii?Q?Ssjzv3H5q+QXLOhglCxlSkN+7CHGl+50BaQBdqmQ8+FBZuFX3PYYBoflhPxu?=
 =?us-ascii?Q?QsBNknwEDedbm9wIpwM+ax1DbtKXDgd1/Q5wAkll9Qr0ZKO3DSxZhmiC1mOX?=
 =?us-ascii?Q?XvtT6rc1S3uEwYKlrEMWuyRCWODdEQnVijBQsQVmn0+Pj4zfu9k2eXSrfR1U?=
 =?us-ascii?Q?vj0NeGscQoED4PoLcjudgcmlJHk1CtzQVQ3/FA0UWhL0LeCqWC4zoOyKYs9x?=
 =?us-ascii?Q?8Uc75CQKLq2S61j91rGLEiO7HHZ1rkqo3T/49OfM7mJFEj3VC7ulkbizYtRA?=
 =?us-ascii?Q?J3Azpff83TxbMLcIXLZq1yMqVYx9DTh25RwgGRdzcf71jyCy7ph+K5djVUYI?=
 =?us-ascii?Q?FGcPOPahsLPDkbnJhEAIoidxt9CRRO87EOMyxwoznxYjCvS7UgKO4co/V1N8?=
 =?us-ascii?Q?RjHyNWFv9sX3IoLolTUos8w9dSnoxhNWu12UaZkBCxFrMgSRUyD7Sd2wPWHD?=
 =?us-ascii?Q?vBhL/QRAxOSKRtUbOzlbSEPTJywEQGn1TfAKbK66DyQJXd6NcWF4q7ZwoE4f?=
 =?us-ascii?Q?ekGF4oYBaJ6v9SuY/Qi4IWWXbgrURXbOPTFbuotsiZc3WSWMP5bM+EN2kBK3?=
 =?us-ascii?Q?p73tArD5I+1DSXUwGyshwis5WXfAyk31GUIv6rob8NtSjplsGvZhRNalMSYH?=
 =?us-ascii?Q?9mHtm7UXyMeMIjtj6eTgtVA4KPD3vrUnhjp3nAQ5MKeeKjzx/+T+rbG5fU5v?=
 =?us-ascii?Q?rcWN6Yhr1k1ch8WsXV4gZx7bWz0FdbCp3YrURjQIkxmcc9374Yhj0NHEK2tb?=
 =?us-ascii?Q?vXGk8IEe9VxK53C8IXQJ6CiUVJq6FIDH+NLmbzL5ZKKGnvIrIKFpKTYq5FJR?=
 =?us-ascii?Q?ZukOke+TsbJ8BWRxrqZXmYTz5KzheiaHmW7WmZNUiy0oxO/a6nxoWX4trNgf?=
 =?us-ascii?Q?y+Q3xw0N/guTA7b2kUYTbi73t6sOuQyWL9IIoYs4Nd9ys/6PfYJpmuyPZCKE?=
 =?us-ascii?Q?TBbvW1CzcTcbNN8k5oLpHb0z8vmBPbMSIZyhd5EMs9uANiBUZS6PnWF1emOH?=
 =?us-ascii?Q?nfi3wEivlJCWWeo64qmIJhDilxQY7VMR/V99yE5b1kStEnXpUTniEYKlUPIB?=
 =?us-ascii?Q?D23EuKrHIrZNWE6+AKmL2F7RSbwORfB5gsSNkJnNmYZis+k+capeDHHHB9Hd?=
 =?us-ascii?Q?lfIH9LcRcOO5YofIqbZmTVbiKEEegri6Yhty41AsAzn8pJOfscYjYuRlNiMr?=
 =?us-ascii?Q?Lqko4ul3siniY2jBSar79kKirBpwWJlmyLN/XdLYHXeNo0zyKEDGrYWS7Hlg?=
 =?us-ascii?Q?hu/jqCsNJ4Y/Wwodw9G8mZCsjrXBj06oQ/zBJiDkpnDyVfSjzH3M2ANJDijZ?=
 =?us-ascii?Q?PBbkpco4hZsQjsNi1bPv7Xt+z4Km393WJS04vtXkLSsFtT0SaXTopoEHK6wA?=
 =?us-ascii?Q?Ex4/tTZXIg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1af8d4d-94a1-41f1-a684-08de846b5aee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:22:55.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ry5k/9eQcl2JubBxx7lPo6Spk2Z/iqroqAdw1XC+bLgSYkb4/hIXPiH+S+hJYaMMOWC4Afzqu9yD1Cm3jCRHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit labels "QEMU killed" lines so that they will be picked up
by torture.sh processing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh   | 2 +-
 tools/testing/selftests/rcutorture/bin/parse-console.sh | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index de65d77b47ff..4791774b8485 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -49,7 +49,7 @@ do
 		then
 			if test -f "$i/qemu-retval" && test "`cat $i/qemu-retval`" -eq 137
 			then
-				echo QEMU killed
+				echo "Summary: Potential hang (QEMU killed)"
 			fi
 			configcheck.sh $i/.config $i/ConfigFragment > $i/ConfigFragment.diags 2>&1
 			if grep -q '^CONFIG_KCSAN=y$' $i/ConfigFragment.input
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 21e6ba3615f6..be1e943ca4d5 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -113,7 +113,6 @@ then
 		then
 			print_warning $title `cat $T.seq`
 		fi
-		exit 2
 	fi
 fi | tee -a $file.diags
 
-- 
2.34.1

