Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430239151B;
	Tue, 17 Mar 2026 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782582; cv=fail; b=Hh8p/137ifEhQRORAwLYWkJ+ESlDiVQAvyVdGlAV7OxI6R8K0XNdv4zguJfdj2GGn3WusxxQoxlqU6XRZ/PmC5ucZtkWZudj1G2yWfVpIwrdDbTNcOAg//FggMXX0YXZSYFUSkrv1tO3qxLMEE6eNR6o0hxR9N162Q2eVwL8zns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782582; c=relaxed/simple;
	bh=jruc/9Sp0FE9nCvqjikf+6rgzZj8MHZjVdBkg172NSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OqgQtlW67oCbiFIB/lntdMC3rrDnMMcgkkwK3ktp362/pLciVnbRr3EpV3tVVGIehZnOHukbelQHB/UKapxOd9lXVwhOhgdCdRXUSRL9zoM7OSDdjEXblWEuCjzaxuUVXcr4lmxiXN0CCGsTwQKuF8FKwpl/Izf9h7UvQAaxJ4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4dRYjo7; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4dRYjo7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzS2GMpBT5ESVANWz87C/J430EB4dGMW0GZEKEVT4HtSNaFIJEYfsekQGiAW8NNtT7X+tE3pZUaHrEd3H43M3W+nLgKFbG2I2fSmjZ2ibGSuWBarrn70fhT+Umf83dt5j3S/Q9oU4RLPRC9nKaBxNoYWMoFSPYhbOuZ/KotG1FlAgm7Yxi4agW3ECXOWQ+PMvcjXTa2ZhOB2dmr8eVngoDtNe4JM6uSY5TrQ3QvlbEq6cnEB3PWt6BY2a6aNShq+xn6dzcVxc3FWR405wgfTqU+g1GPsqb0nFCu3jk5qOPXAIgOzc9GtfIYEGtqxtvTIliEEzdMkiFnM88HOxkXTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSrWiDk7tYGikVgXQ2fwHl5l0H01KrR1hJKB0WXQdbk=;
 b=xwZiebQMMheqJuI7vrFkoWj4I03s4k7gLemZpoYFFCWOH+e42npnyQ7itEC9VptKe1jzSgHtsqhYCranBBjjxEmvxHtw6M4sJ8pxskYC9BKSKR22/NFD4R7Lh1ipOIV1AaujIrZExsSLmF5RrYe0jrKJxsxgf3Qw4hc+ncdkaMs/jsHLkDE7qUaUmluhqeLc2qtXEgxRgGgO/DMRY+XiQYW42/mqj6mhYOA1DaPIj1RvZ6rWRX0u65RDjOODl0mzaO3xI24i7nHH9MecofoRkAq7y/L9Q1tv1MvvKsfZs2MBhcU2reEamEtKFcOOEzJmG92N5YxTfWCkssY+g3KyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSrWiDk7tYGikVgXQ2fwHl5l0H01KrR1hJKB0WXQdbk=;
 b=O4dRYjo7QYztOpmV0IRy0OKkNIz/ob7BD01sxVTr4xvhDl+imqYmhphvYxl79jGfIG2ZiE1q/jyF8FYNGag2NUqZAG2fZnERqsb+IL+tzWEJnvGVsJARfcLUqy6mnvCdHJU53AHbv6hpo0gjM3ymcKnB8OSvdrpWY3K1PFknKmguXKE4SEfWfdDT3OO8dxEFvW4Osc2SfQnUQMF5OrgrZvURzamfKfkCyOLvZMxI+GF0Zo68xpoxp8iCtxDz28JGmoDqxSwp7gAJI+2Sg5JIL/tK5hRcKZE+PivuYg6rO1pAzJY5aJ+ikqiulCDXFBmgg6o917OArF8AjmQccLiBKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:22:58 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:22:58 +0000
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
Subject: [PATCH -next v1 04/16] torture: Print informative message for test without recheck file
Date: Tue, 17 Mar 2026 17:22:05 -0400
Message-Id: <20260317212217.1527644-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::9) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 80310a04-707b-454f-7856-08de846b5c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mqHEc07HiGSu6bTXGKpEYdviMBSgug9jKVlpO5IBoO1iceaHwtBN9L+YIZAhi8QqzRvp42U29c+ErBatLoXp17CVZCT45uK+tgo/Wsn/dBGqr735PTdLcAdHFe1W+NsxiIoc2EE9QmjvGfxtrGL1dXJGHXcR0DOKTv87yLvQRjaPiP0Qr/JHtpbtBq0+09S+VOCizajrCxBM8EsUdMgDbrMGAee1L1JyPnKSxhXSMf4lkZEDzElyiKATQ6zgkkMSFPooarYft+ETggjvy78BBy9J4K6qls/TIUrStlEOXPhFIBARcUOgLY5NfhdNdeTbPCGRNhErOIUheJX6FP8KJ0mj6jUVwgfMzxaDUbwer/tQ2uAqYWp3lwEbDDgFEGt/+TbQjcXnSdg3Yy7qTozttVFkkO94ljbPLclioUeRvn9g3YwVYy25Dd90ECWvQs+nZtkLUwaR8+6I+TOW9Iiu1r3odDynaNaPB3cluREbUWtLsB0XZ0qQI1VQgTJzE6FVd4gKzQSATcVvlVfqloNjGr0jYeAvwSCxYcivb210qxlfs9fSsm2BpHm5GON576CzZ58pPuz3Y0Gak7YkzDbKA5sytfmzakf4gUFcvYzpkKQ5crZPJvfCpZHPFe3JIAcg3WPcZ4g5HrWndSrFlYKZWdW3rF1toWxWi8++/Gd0DNUXgfZIWiY6nNMXTrNyS1aVK5oV09VuDLJaTDaOMNdjxj0CZf2RM4LCv4O81PLETnQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?neKrDFniUpP7103iROmH8Csxhn5kOqJ2z7aluuofNMnILvqM7jLir3uu1+0E?=
 =?us-ascii?Q?LKzoRqrrLyImiI79B9LXDemvgjiV8SVq4x22BwBLdDINXvs+IC9MwSEa7iv9?=
 =?us-ascii?Q?cm5I5gR1FgXd1NaaHjuWURlDCpnGAOKh+kMRI7vO/SsVKbofSUSDt63khois?=
 =?us-ascii?Q?Elk5uUDmMkf7+9XmC5F8G85Ea9CPtg5lP6DYNqQcyzSEcq1cAzkSiqzUcg+x?=
 =?us-ascii?Q?IUw7NttyA8tbdxnGSRSdljK48yyTnB3GqjeZ+TVGa5ywYS2xgQSrz/JYNCz9?=
 =?us-ascii?Q?Jtndt6fnodDb4EvUw6wKtAPYTXTKWmaUo2UZ01K1eAaYCwNttQOFiwluwbz2?=
 =?us-ascii?Q?c8xyuiYh8iG+9aMipJqV471QM/v4xEWx4mvsTjd09Dtx0sLRN+zyrVEKwMfs?=
 =?us-ascii?Q?7CLK2AWVliU3OXJdWj3vAQde9MIEusPeaIY/LVv//N/2O9UckOgtBJyDT8Hm?=
 =?us-ascii?Q?nIN9/S4EMYl07AV+GwFWY7kT5s8GH0QNLq+KlHdzTgLbsUKwHKrgHu+lIW2o?=
 =?us-ascii?Q?6OuIxl3rZ6I3WvF2dV6st/aalCWenkJ7obfl3F+Tro9NWhLhxA1s8F3cPgN+?=
 =?us-ascii?Q?s4m43gH77FX0/JuAvqqGBMu85aenF31atXRsLqbBER6JgMtUoUIqyGe61qTr?=
 =?us-ascii?Q?aWfU1g4mz8pZtlpR/KpSW+H5lg80fbexMoeOwUfw3JDg3QRfoahRXL/+ZfTu?=
 =?us-ascii?Q?PS/dmT5+MiC0V9XR7sKEjKPhfBgLF9zi27qzDalRZDdt5wX8N6mei+CbCnLn?=
 =?us-ascii?Q?q/EiXOzjGauCR1sJ3Xu3gZE9ixFhBx0jYjC3BWMYQrIMd77K8QCfDy1qBy9D?=
 =?us-ascii?Q?yQmTIXtFwbcLxdEmmxgrT7+I0/wLaE88UEZeIFzmkWETq0jSfZ1Vh3XG1V3g?=
 =?us-ascii?Q?RhOTa5bhDV/vtLCqKTISO0eg64FeKTrCBG3gAh+N1MxNZ8+TOuRXtWWmJ4Ld?=
 =?us-ascii?Q?zCdbFU9eWflZQzvSJqDk3VsqLmx+cEANBMibhwZI+5kdcqj9m66gE9Bf+fn0?=
 =?us-ascii?Q?yWrl3XmD2hHXycNOuPkOrW83euSM2G/CQbA6dJo+e5jY72inba3IBHXueIne?=
 =?us-ascii?Q?PFVDyWu5PkraJnf+IvzCVsJ/m4cEiVIKZIgiMwWZY0CrCK9/Hgdw7TrzDVWO?=
 =?us-ascii?Q?mMY3Ntb2HC58C0HR6J7MFGujtQAdKNjKfuF4dLx6FDePAZPGW9zhe0NVCGOb?=
 =?us-ascii?Q?E4T37mheVE+W8EtkVlGjnRjpFyt0g7xJvEC55s20L4aVC8Xxc0dlWRm/rhB0?=
 =?us-ascii?Q?N3gWDSMIHEd7JpZKkIJANZZxkidkScpG/U/FwQ+9pC0OGI8vI5inYG+yF3od?=
 =?us-ascii?Q?lMrkH7NuhwcrUvZFJ7jgbgIlUMmdOGeiWc79f1VeuUY1RVCQcqLgFyrxRF8z?=
 =?us-ascii?Q?Zr44zHOqZwIoe1gGTg+UpXJe/d5y8TkTDeshvLmW4968pXMn9MyxJbz5QQIs?=
 =?us-ascii?Q?JREVi2PF3mtWl/oiGqTEpiuVuDRaQB/MFoDqzCJ7ISQaZY2HX9dsGIJcp5tl?=
 =?us-ascii?Q?UscCIDSomel2YPQKixU8r00NNUKo08922aRhEPULH0O6nDzgurf2BH9xpJC+?=
 =?us-ascii?Q?hsNlogPsO3r8kTg5u6w0u5HN3k0eq6iyv/ho/8FC7zQGZfGj0MAbdkGAR1YT?=
 =?us-ascii?Q?CO4qPvplRY8ifUstdM/pDGCeCDWKE2h8ayG+Ea0VYwGTrgaUyIM8C5CciNpX?=
 =?us-ascii?Q?CFuiTFnMfpupHiMvBBQWCtKW0sHvZHWXO5uHUgoRHw1mrSZEPqGetupbZkQ5?=
 =?us-ascii?Q?2Q+bwh0MFQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80310a04-707b-454f-7856-08de846b5c16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:22:57.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLH7p+zVeRcr/0mPPa895lxsA2P8b4eB8pmCoBIQPJl+N8WyAAPSZwVEOCPM6+YhUIgUFo3B3/7ar+uY0+23lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

If a type of torture test lacks a recheck file, a bash diagnostic is
printed, which looks like a torture-test bug.  This commit gets rid of
this false positive by explicitly checking for the file, invoking it if
it exists, otherwise printing an informative non-diagnostic message.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 4791774b8485..63bbbdd5f4ef 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -39,7 +39,12 @@ do
 		X*)
 			;;
 		*)
-			kvm-recheck-${TORTURE_SUITE}.sh $i
+			if test -f tools/testing/selftests/rcutorture/bin/kvm-recheck-${TORTURE_SUITE}.sh
+			then
+				kvm-recheck-${TORTURE_SUITE}.sh $i
+			else
+				echo No kvm-recheck-${TORTURE_SUITE}.sh, so no ${TORTURE_SUITE}-specific analysis.
+			fi
 		esac
 		if test -f "$i/qemu-retval" && test "`cat $i/qemu-retval`" -ne 0 && test "`cat $i/qemu-retval`" -ne 137
 		then
-- 
2.34.1

