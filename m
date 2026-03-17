Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3039150E;
	Tue, 17 Mar 2026 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782584; cv=fail; b=TsT/SwAuS2m16Q1dGibJD+vveDY6bvGD0Y9MY2hqaLjT97KgnAlcAzp6FTUBEXhi8mspZ0Y71wiO9qeD4v8TyCy1Aaz3VY9Rng16Jv3mcnlwijhLuFbNhhbSC2cOSWVexRmNNYjuUQT5LDb66sz2M0ECgqOmfVpJDXEIekV0KZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782584; c=relaxed/simple;
	bh=iTUw8Fmdz3jsd/+eK9u6YlfBSftiGk3AD4Nc06XF6MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbojZnVGMAE3ZfJO30sEuR1MprkAhd4PypqNV90rvxj1CC8vTfa2xwLg6K2sqGdzESe97R8cbXrf9UfAD3QSart0ohdhki/gLBrNiurh+cYaJp+VIUgKVPkpZuYSDsiYbMxhf/6Wo9E3NqbuD1BBM4bj4DbKkRwB+d4j1Qsw6MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qWXL3rSj; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qWXL3rSj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCfa6jitBtoa9CFyJMEBWQhTXaPBY0qWuZ532rsjKJnHgrnnIfhIy07R61bZztiD8ZygC1Fpw3+5o4GQ2t6x9/84K4203bKPuGoXV1tLXn1QwRGqJuU/cmAVEKstM5AmeYxGI55+hETEo8B967APdx+9BM+lsww/S+xi/QZ3SVSkx2jLgIAUMLwVleQmPhWpZDPe/YGRl0bxlY0xmvTuW3bMC98RonJOff3hLtoosSwuhNBxHQz6onBTZAt/Pm+77XMeTvGr+Axg6Zc8ycmFqAvXsbnRF+sTelU27yW2Qk/3y3xMtndX6MPIRBMkpgpChuEXlD9nsVhpwfdTJgOpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DleS07rq7NveSD/CEtAWYuWF62/ZtWrDf/4vntCjark=;
 b=AQ+kCa5NvNrNB14APO6dxqRvV/GyBhWvSjMLGUQQK00hlEq/L//SQhHjFNVExPva5Neesu9V33d6/OAHqdjk5H+XxbXNbVjT7VwW4trhYjGb1xSKcCW3Pu9CTWiHuS/Jgenz8KNvkHC3zGq7AXYHP00VAJ7jodOF7UkW770DLLngkOg92X0QeABWppCgf6c8TebqzJcJXb68FAe70zCL+xFqoBfPxCMmvRMTGO/ZO2e6N2rm/damUR1lBuuP3EwcWvnevOUvo79H2fj4L5z72pAC5l++irta0P41EFJi0OAKO7epPVbW8P7ZqRRMrZG+qm47+EhBFmfQlw1KRYeEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DleS07rq7NveSD/CEtAWYuWF62/ZtWrDf/4vntCjark=;
 b=qWXL3rSjRFM0IA9RJDRzgZK/lnOon5ztk5ChJWKflAXWIz5FOVf40i8IhdggbLj5qppO+A/vSw4tTWG01pC7FX3pF2hKt1BcP5ptFoXU8BQvJX7teg9MDbKTeT6h98b/XM3tVeiqjvgInYo8O46dLD10zCMV4LY48f2CkvIxXiaXvKtlqdqzziRpzRHrDfGuyEr9yiLO7rExHFbfTnJjrfaFA2l11VdxX3mkHlwGCwhhCzCUShGKbC9kuU3ehC2KlmGe7CQZPTCRp+HCTq0K7ietmuzNRUO0/f24ZsUekVIgRO0P1qb/1CRADHbAHOuK+RHu7ym38sg6p+eTr+vcyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:22:59 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:22:59 +0000
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
Subject: [PATCH -next v1 05/16] rcutorture: Fix numeric "test" comparison in srcu_lockdep.sh
Date: Tue, 17 Mar 2026 17:22:06 -0400
Message-Id: <20260317212217.1527644-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 042ba2c3-8e4a-42f1-5835-08de846b5d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ngW7GUSkgpwqkgxa/qy2mOu+2U0tM0Cr20VunnW7omx9ta9IOWCqqVyaBaFmduhNUIxFvN/Gt6mRFMBZWs7OATU2XScuWWgLmjdnEwCQ09ObhyrISY5w/UGrJNLhBAVYMLnko2e2HuJsnlgRtrkyU0jeFirtxopOQe6pyqRCSIGlEG96jqO5Sa70odFvBKFIbLR+wS0ftOMtwCh/74dl9bXo0VVDZQ2TNYvWigRlmsf6XrRD2ORtNoNEOcIKiDgUcL5j/u3P27z4PHZ7TovX7Z/GI9d+U0nM0Q83onkHtxNFVsaL6DTe0eCqA/3dzIqXlIBGrU6UwFlU1ZDbtmXVK31HS1DECaEZCTwdT3gzRyIOv2bEpreOGX1BadUwdGgdeldkzRXljmsoEfepx4l0YGuqJYfQeIrZ9j1c1iV3wmd1fU8tFQqRv5NR+mJQ374A46AIvCH0WwyDJLPu6ZMIELvPTX0ozTPfSSCVpCA3eEPYE8qEZ9joahCv5MeYoD5SGMju0NmrFnNfqNEzdi4wRcnFE/1LVA4+ro7Q3uJX/Ul4DwzUmUgynZBabsN/lGVjy8b3uPebqoepsYiFUOUEgX1KcjlZ40cTrLLhDb3pRojRN9BRaDyatnoK9zZUpUsbEagoq3Pspa2aj4UpfCKQ22ma/Ukqgd4g2KL30+C+LQ24rAsQRqqEb7i5yVlcuDb6HL53QRYBaz+Oy5yBUIndCi5m14iR+Ww6IwhKh+cGXW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqi+6lhyHfx7qn8RkXmE0pxZvQTu5+d9UsEw06X0yPl2m0M2ZGM7GyqmpFqZ?=
 =?us-ascii?Q?y9eFwn5axCcl1Nt0pkl68bafb16Seu0305c9t0L76xZ3+gvt/9w+oVVLCmPZ?=
 =?us-ascii?Q?9zVnfE/ZURX8fsElflP9iMC1akWaETOf3OygTn9WbKYkS0mw8cyRQSH0K/Fj?=
 =?us-ascii?Q?I2J+X5UG+5D9zQ4ST7VmClxT9qZnLeBZdQ9h6JVXUVn/QboZC9ul9xiN8eDE?=
 =?us-ascii?Q?G6FrxvYKIhuAXP4TfsghcLbX7YbVVQyjUd3Ui6GWSSD/1rFykg1ApYmlzdWJ?=
 =?us-ascii?Q?tbLjDqC87DFcNyGXF3S4m+yzEHol5qWAy/ZkKmrafedxHuJ3V+OTo8rjbE5l?=
 =?us-ascii?Q?LPMiKDBFm8u25ZNiJWegvUtjpzAKJG4F0JLG3Bk6FREYqj5b32pNRSa91MQJ?=
 =?us-ascii?Q?kwfh1blr1r0nOcSk+881opqwPoWsnQQMy9k5N3axRrSVIlYLy7ilNNyv9axU?=
 =?us-ascii?Q?1Kdv0PQGOfQC2gPxWWZONJMROKDOzRNbQrbjxYOT/1TTiOqt2yOpTrNs8IyG?=
 =?us-ascii?Q?K5fAjAnUs8Unipwrr5JYTImi0oN6jc8oD+ZaFO3nJ2IiAKTZdsI8EBxgr06p?=
 =?us-ascii?Q?t0+h1GlMCxqx/CpDkMOF9uSjreocTJUk9znXCi2ysrILispgAGBuqXIP4RrC?=
 =?us-ascii?Q?EaGWX4Xa+yBJL0ZnrRCBMcaSdpzudt8dbM5yU6TXULYXFIcMkq6Sp7+065JS?=
 =?us-ascii?Q?Gs4y7pr862hZyMqIDHicgK2pPY9kWsr/hg+c8nVGWs1QXMECN0H1VxNqSK00?=
 =?us-ascii?Q?juIuu/7NGrJGHn/R/duM0bOl1GwrzFbr/1lvG6OMejMYn8ErmNtRzlgJv1DA?=
 =?us-ascii?Q?Nl1IF0UeplUc7hyfEdceqsZvluH9YUtJJVSePr/Dt0K8Yl9w81dD3VLTMFla?=
 =?us-ascii?Q?zgFIIRhSuT7+Y6R5Ujgp4ujxswFmMn5xUEXakXx5bG1ezVFlGB8XN1xy4NGl?=
 =?us-ascii?Q?HdUMqKVvCJpehXMwQklimz9pio43S+FRyGYVOGff+qV1JSdBk4i0TfUZEOVE?=
 =?us-ascii?Q?i80gggC19FQto2Haw1ERtnDZR0W6LoyxfornRXlU5vva5Jz3BUuwiFRVfyev?=
 =?us-ascii?Q?PZx6Z2bauxQYrgoWoiFcI9QLgFmA+w7l0cKIBgm2TvMhyHlJ6VIj23unr1D5?=
 =?us-ascii?Q?AelVkXb1g9llaNOrzEhcdgeXJFmJBfI48I0lrdSog+0FFGaQibQK5/L9loYb?=
 =?us-ascii?Q?atbx6/Vjnq17qrXYMWIpkLQHUKt8RlSEYqwaqbRokYUiCPAJBNOex5swYvhj?=
 =?us-ascii?Q?tHzDMslG85KiUTok2iFht3PuuHFjtv6NQL6kyVEmf0FqGoLp4S9py2G2nROV?=
 =?us-ascii?Q?W4//agEhpQTOhhzk9Qd5K3H20c0aTaiLXnF8Q/vUTxe3IQsVureo3FZ7jDZz?=
 =?us-ascii?Q?IRh4r7Xw4cSJUeN7qVmKk9GQikPqGNqPfFEL9oOM//BK55Dg8e6XrqklbdwD?=
 =?us-ascii?Q?sKur5BW0LbDxQDTVP9PLacuVNIhl1qPCyF0HVmgQNJKiVpatDWqVsRLBnGol?=
 =?us-ascii?Q?nif1enrfZ9iWS3x7HcxCwUPp2wlodMyyoajJMhQltHm6s04PLwkQ0/Cmzruo?=
 =?us-ascii?Q?t6dDWnxhCdrLDuNeyIMYtkqCChbOMYmztB+8va3U4Z0b2baQ4VCbkxnNy1q/?=
 =?us-ascii?Q?Lt2DlhMtOoUQDP71LfnQPOcA+/1t4Cbb+Sw3LAQt2Bxgm8KNE3MPnWV8vwdb?=
 =?us-ascii?Q?l6C8eTZ1L2IDHrTn4w3K/S9zJIUYPqMPXquf8gWyYApcpC5OdQNlEPOxSjsa?=
 =?us-ascii?Q?TxE26bKzxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042ba2c3-8e4a-42f1-5835-08de846b5d32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:22:59.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3Hn+o+mwP0Ywm4ZYebjG4rcCFYsWqglQ9rhjfF2+3AOO1XHbDcwdfSGq/W9AxfYXLqptijUC7XjeNxjBH0a/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit switches from "-eq" to "=" to handle the non-numeric
comparisons in srcu_lockdep.sh.  While in the area, adjust SRCU flavor
to improve coverage.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 208be7d09a61..4e98c697def4 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -50,7 +50,7 @@ do
 		do
 			err=
 			val=$((d*1000+t*10+c))
-			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.test_srcu_lockdep=$val rcutorture.reader_flavor=0x2" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
+			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.test_srcu_lockdep=$val rcutorture.reader_flavor=0x4" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
 			ret=$?
 			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
 			if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
@@ -92,12 +92,12 @@ do
 		nerrs=$((nerrs+1))
 		err=1
 	fi
-	if test "$val" -eq 0xf && test "$ret" -eq 0
+	if test "$val" = 0xf && test "$ret" -eq 0
 	then
 		err=1
 		echo -n Unexpected success for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
 	fi
-	if test "$val" -eq 0x1 && test "$ret" -ne 0
+	if test "$val" = 0x1 && test "$ret" -ne 0
 	then
 		err=1
 		echo -n Unexpected failure for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
-- 
2.34.1

