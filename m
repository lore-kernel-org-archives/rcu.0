Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50822A4FC;
	Sat,  3 Jan 2026 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399864; cv=fail; b=k+p6OZI/FQursT7bw5ZpGGdSsZssTYU7UGkjtIsw1Lb5SrSkiLQXFn7v5LTj+KU04sKZwo2wIaOrPU+EAMo3UXH37kcEbri/d5e1iNh672yjNPwt3ACSsZ59rpCU8NHuJHMG5HFayzBgqfZRT7ypaJNe06YrnHApXKQAxnuJxB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399864; c=relaxed/simple;
	bh=7G4Df2BE8oQqTwqd5jiZu9xWFZJqsy7Eq6V7SOvDBa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VCVWrOLr39ah4rWwCqYUKw+D9yvBMEfTuDtVkFawlYXXjGeMM5pB6tSRPZiVLxctMypcU+x123I6hMkRIsZJEN3GuvXxwQ0k0CnK9gGXEaA1BjM4+0b/M3Chf9SNr8B+62XhotoqBnHYl1cfPPUJd1WWQFFlUkk7D349CukH28Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pmRpH5bR; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pmRpH5bR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRwwkIYFUxE6d6VjxD2lTMvi/LGaKDEWb3fgyTHZCfStbknlrGenMNjbtFWZ0tg5KUmDwzdKG+H1MUi4HsZ/zxsVeJTrXo1f75G7AT7goG1SKQEJTrjJa1g6ACqocr0E2xIZeCM7qyFhPI0Q+d8OdwNKXMUsOVSanlDMoNPKdgw1IUCWj0ebmInQh91biW3+np1DDJlnZ6XwiciVpluvLj+ti/E4bK++CP13TFGJTkGGN8/aZX8weNoWRutTR7XEel97PrPxmnD2EBrgIYqoh7m6sS3jNHP2ekmXaPpJkTMFWKIvHYaTfkdGWYyX98C8xDI9aiCQ4OtaGjzC5FDd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpyYOXXYxhw6wVA4IV8amj/dHk7al1UPtBbe5IGyY0Q=;
 b=MF7oQ79GOHCeTlnXGPjpA5n8McRz17OEF7SGu8AgjrfHEk9uE96WQ1LwJB2bGedxS+4bR2q08f2xsVgFa+XDKLJCS3e/TQoCuxsdLjAaq8OOPotoOqnnRHEdKj6KQvFiQQyDGFTMyjyM8dn7lKa+XjV+qoHpkxQv7mb+3M/pyaL5cJSvCD31lLey7OAzdYUzv5QfXtWROeaNq8M7xPrK1i/kNv3Shp0hhnhfXM7oDhKmU3HBwbtYZ7/ccc4UlB1pxpbdQ3VaDeh1DsK3RV1X2RMrSAcqYZHDQqwPD8D5ne7L3f31iZmQLntL+IDEih2VRFjAXTlYc4odeLmhTg4OZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpyYOXXYxhw6wVA4IV8amj/dHk7al1UPtBbe5IGyY0Q=;
 b=pmRpH5bRzPlsHH/9FRVGyYHiNwDzbpg/26F+7ctk/wrO3O6qxqvDAH1FM+H0f9ygCkxd3H2pXZtGuL/X0sh8puN/B5AWjx1XCXFuoRXiXVOYKKsAgeFsiB/3P3DTrLDOSMJMSJCnOLkPktTZ/hx2Wg5zGz2GEXzywsKjKcuToUcYIECoJd+gtaDWOSPztUXMTJJR+ZAXryO4gBpAC2fLy6GgC5vMfEttkY97kij5SWKOIHy29ffy1St/4oBcLkz9Ac8B4Dv/ik8PXerwYvThsjIb4LWqossFCKfftwPAMHdRwAYWk28xtMmLpFyi60HxLpuBHJQhfDGIztQvrknaYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:14 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:14 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>,
	joel@joelfernandes.org,
	rcu@vger.kernel.org
Subject: [PATCH RFC 12/14] rcu: Skip per-CPU list addition when GP already started
Date: Fri,  2 Jan 2026 19:23:41 -0500
Message-Id: <20260103002343.6599-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 45399d8b-4b95-4210-ae16-08de4a5e6ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y3DyquioVm0LQq8AxTdT3OUSeSqursFoVGwsEwZ8AYyYC/Ua2sqYmkuaHdhx?=
 =?us-ascii?Q?eGZ10oRRNzUjqzmGeGbV/TzRG6XU09YR6gfOSThcpZ5sLKjcViF13FpF0fdM?=
 =?us-ascii?Q?4BYGzafJ2/fL4uoHe9yfm/2/og/L1BiNF70nDiYWxt4uaB/tqxckYmzEkEdK?=
 =?us-ascii?Q?qmpC41n8hgp85t6BoMrMveTYtPbgUiamj83fCfKkzvqKnhaYJLnAG4A/M01G?=
 =?us-ascii?Q?oS555wnDHdx5d35CX2S7Baj3j2UpwomwRQgtCm5AJLBZ/JU+z4LATyAH1M1O?=
 =?us-ascii?Q?expLwdfZUfRpOLP7IOdFwaNOmyiSizaOJogdxyZEpzrR0PbAJE+/EeDRikbg?=
 =?us-ascii?Q?EUIjh+xrbuBhYBxKVM+Wg/zSKXds8w0cJnEFIWpn/1sqmkQrKpY/BUjxnjxF?=
 =?us-ascii?Q?1oJOza0OSu5znnd3uTd9QlnnvGDAkDxQP7nlg0BPW9wvQM9r46gDzlwbRNF3?=
 =?us-ascii?Q?ED03OOAsYiPLOrd9QaERROKDWY9RmDJcKpE6OvIZ7eC2hF4SnFa0APap8Zjk?=
 =?us-ascii?Q?uzx+2DTd1GdqNYl+gbWvjVOuvPYSRc/zb8ghzodRra1yM1QtHi/+Jo/3GQjI?=
 =?us-ascii?Q?kiySYfnbf8pbHlDgKGYrcKdkQ8u5esc3n6+KlVhSyihpMTVZIP4rmkqEHpln?=
 =?us-ascii?Q?fgvZ41g0h+3MKZHXg/DMvLEFI/UVKuEl0O++al513olESMKnj0hzDtGtpu9Z?=
 =?us-ascii?Q?b4+SJLzY236mjLIuoIDLmzEEau2g68yjyObIafrbFe19rCHrWPhot59/krVr?=
 =?us-ascii?Q?lJNGFmQW7ivISF6i1akN/M6S2gHQgd6H8NX1sor+v8i4FucMynWZr9hO4z5U?=
 =?us-ascii?Q?0JkBcXrNH9dzSuJAE3zEnevSz2NrCul0IgKvy6XouSdf7lVBZwY1anpL1OEo?=
 =?us-ascii?Q?q/BtPudCeLmzwOefbl3JPI+rgTLkoKEihQm728XSisfF5ZgT2/F5Fsu6lrHt?=
 =?us-ascii?Q?VW33GVssQfhq+zkGtFpM2cXcJtejFZnBvw+hOviKamlHpCg6wd0fIz5SfPTV?=
 =?us-ascii?Q?uNwnfG/7lh7hIp2H9LZEAc0iORIFgf0h5zaFLP4l8FHxR4X73Nz5pS58s+YZ?=
 =?us-ascii?Q?vMg6zKz3QJEKsJuYyV+mBOteLEGNAL1JUt2D4BOFcQ0gzzTYqWryaR3LAoYF?=
 =?us-ascii?Q?lbwn1F0KGXa8HKsAALRiE/Ow5na0vAz171BxruW3jfP8gjQdHC1/YtomAybp?=
 =?us-ascii?Q?ICWqFCwu1w3Plwjk8sqpxKlQBcOu4b2OQ3PwFECc5A/OAvMw7ep+OIu1fWd4?=
 =?us-ascii?Q?5ANBId+ZX1N0YHP9O9DA50PO4g2WYKCK3xxozAh438hLEtNWg7vTRB/osMFs?=
 =?us-ascii?Q?kc/0Q9O9M2ROTYqT483d07sqReGe6YBpCDt8VEryvg18D2AQ7od65H8cEBeM?=
 =?us-ascii?Q?ZQGo1x0w1Gu997to8skOGj+5jMdH7L12H3ROVSnaY8ZqD4Gbsn47XY2XJ87a?=
 =?us-ascii?Q?dIg1TS/BoDIUv1jnsHoMIxiTQZQWEegf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mpsmgnIWNzfZl786VlXvzBm7NpHsViPSZxQF5JeLkUNB7gsqFJoTzJgpT0tC?=
 =?us-ascii?Q?qOr9Xe24TsOi7OVN5pYHAJOPYtZoPYVfxMpw93nSt5h3w5t4ia8QDpVuLWyD?=
 =?us-ascii?Q?nK0rHqKOCCct5DTmpnYpRIx1342PjA/2+mC5WRpp1oLYR354hf3SH1elc4tO?=
 =?us-ascii?Q?9hsC5S7986ya/G2rW1KWAgQOknz3jG+YghzHOFeeQYnwtRjhjbPEaFL6bbWE?=
 =?us-ascii?Q?pTr4qXY+CVZv/G20emcm1sk4VSZhA2x98R5kdj7r5wj8Q2mBjdfrNok1EOlM?=
 =?us-ascii?Q?VuqDdnrN5JW3hE4errBNYONY+HNevzeWVz2gztR6q8m+ELEKJ2CWMa0a1zhM?=
 =?us-ascii?Q?BdJIhwq3dG1eHnzKsMCr0mEm4om5Hj5TjUR6O6KHYBtx+EHR5f9Zzj+jhZJp?=
 =?us-ascii?Q?/7psSZl4WGObJ0WkfI8z7I19aqumqW4d7ajmmUq28NFE7Lagt/i1J12U0FY0?=
 =?us-ascii?Q?H/XmYsgBl15n96dSVcvV/z/gCEPNkPgPkC+yCw1P4SO+WRbInRKWXZhMCXen?=
 =?us-ascii?Q?Gs7UWn39ZbamSNc9bdzYlRMDCGbBIAXepaPH2i2DfeyeuT3puQ03N4OAqRUZ?=
 =?us-ascii?Q?IgLxoUbwHZTLCFEUkidwN5VSsp9oqAkxfhxi7MxXg8s+M9Su1dracUeBBxHL?=
 =?us-ascii?Q?rHaYz7bCOFdJJtOi9lC0hXUK4nA8WygaHyot+hR2HVovt1rtZhOjtKTYwntx?=
 =?us-ascii?Q?RQgvNBZbli8n2rfsuCknmUM1g0hr8nad2XZ8+HTF3vIIUFwr8wU16X8kMJx4?=
 =?us-ascii?Q?WeJ2IujsdzZT68H1tv5a60HGx3XOJFzIOB1NkzPWXlRUPpMXn96J3ALKhBXS?=
 =?us-ascii?Q?blPXjF3heXF1n7EQN1Uos44qr/P1A4Ng5iCmZck/TbIqvdPhcZ2MS89VCH+o?=
 =?us-ascii?Q?S2zVYVRpU6rKulyUX+O45u5ng1mSedg5pFzq2X7ZlZP1V9e0ZNtQw/nWVdhh?=
 =?us-ascii?Q?tif6srSmya1cSdGbV8u8/0/PIN4OVXRU7I9rs4IZ9Mhu0TxcOTPKGuqDHl3Q?=
 =?us-ascii?Q?PlSdA15r0GgfBocLnZ2iPWNYmL17amvvv9POwhLJqZiIXTEZkXmxWP+CmxE5?=
 =?us-ascii?Q?YhD+ADw9Uu6KSnsITnh7BgZyGl/XjnYLb4ZvQGYbk/iQdwhHH28506fy7Ak9?=
 =?us-ascii?Q?wT7/+d6VY6cUHl7WUKsjby6lZxnv6Pvi60b5wF2Rd3eDoqiAhSwxYDjGPbm6?=
 =?us-ascii?Q?B6gM1OwZYdAHPyRwxmvQ4JHhgODthvxUYBQ3xTjCaL/+6NgsqrGrTf8wmExs?=
 =?us-ascii?Q?40SL773g6rvQryF2zSuh/RYCNW0WRoY3PiM003z6uzGXsXg98nwtuxmFfcSl?=
 =?us-ascii?Q?8a4Xpi9kw0BDw07dGT9B+rrJB0PEEWEBo94GEF4Nn4S9GD103fZOKUP7SRpi?=
 =?us-ascii?Q?1i1TxbTx8JpNhCYDiwduRos9uff/DEQzMithesCJnoUiRQ7Yuw52mJrCv9Um?=
 =?us-ascii?Q?Nw6CstxOiXWDgp6nyZtMCLibhL6jSKV6OiNjlbU475jB9LqOJnb+n0hCiETZ?=
 =?us-ascii?Q?fjmcA2Auz4x5ZTmX47DkaWQCDa4pTPolwoESgACc3dJkO2/35X1ozsGkWPmI?=
 =?us-ascii?Q?I42lCaeS52nyscxashPYqIvzPMLENcjhdURkAsVQnA7EU68zOzpk6lgyjJPz?=
 =?us-ascii?Q?KewTaGBHdmR0DgtiLVJCkXRsBcf7xgo5jLPfqB3+3N3cQ07Hk9wVVGeSD+W5?=
 =?us-ascii?Q?Nh/1W6d/SjdFuCTAa3deuSBHat2RA0VUf3f5ui6wQl59TomZVeYynU1ZSuW/?=
 =?us-ascii?Q?5nvo37eJPw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45399d8b-4b95-4210-ae16-08de4a5e6ca3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:14.3827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSI/U5eqa3UtAwSqUgWUKE1MjTsUvvjuV/GqdjDGwdWft1AUJWiSEz4oJ/6gyj4SGH+V/lN7kbTaX18wy2WmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

When a grace period is already started or waiting on this CPU, skip
adding the blocked task to the per-CPU rdp->blkd_list. The task goes
directly to rnp->blkd_tasks via rcu_preempt_ctxt_queue(), which is the
same behavior as before per-CPU lists were added.

When no GP is waiting, add the task to BOTH lists as before this patch. This
maintains the existing behavior while preparing for the next patch which will
skip rnp blocked list addition when no GP is waiting.

Because the rnp->blkd_tasks handling remains unchanged (tasks still go
through rcu_preempt_ctxt_queue() in all cases), this work same as
before this patch.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8622e79660ed..d43dd153c152 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -339,10 +339,18 @@ void rcu_note_context_switch(bool preempt)
 		t->rcu_read_unlock_special.b.blocked = true;
 		t->rcu_blocked_node = rnp;
 #ifdef CONFIG_RCU_PER_CPU_BLOCKED_LISTS
-		t->rcu_blocked_cpu = rdp->cpu;
-		raw_spin_lock(&rdp->blkd_lock);
-		list_add(&t->rcu_rdp_entry, &rdp->blkd_list);
-		raw_spin_unlock(&rdp->blkd_lock);
+		/*
+		 * If no GP is waiting on this CPU, add to per-CPU list as well
+		 * so promotion can find it if a GP starts later. If GP waiting,
+		 * skip per-CPU list - task goes only to rnp->blkd_tasks (same
+		 * behavior as before per-CPU lists were added).
+		 */
+		if (!rcu_gp_in_progress() && !rdp->cpu_no_qs.b.norm && !rdp->cpu_no_qs.b.exp) {
+			t->rcu_blocked_cpu = rdp->cpu;
+			raw_spin_lock(&rdp->blkd_lock);
+			list_add(&t->rcu_rdp_entry, &rdp->blkd_list);
+			raw_spin_unlock(&rdp->blkd_lock);
+		}
 #endif
 
 		/*
-- 
2.34.1

