Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99D2222C5;
	Sat,  3 Jan 2026 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399853; cv=fail; b=HwX5ZmWg7mk42g/U9+eIoGDR1vTieAUWFpw5M/Wox2mxmAI+kgdI8I5++TzeQicWwdIhjKyYuNVhksGHPtL7JiLrMqWDt1uCjUm0AD2c035+97LFYuAtwSKCjXyvH54EibGPEdS1V9Xit4ud+dq0ZXnyel8va/nT2Qk83hrpVLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399853; c=relaxed/simple;
	bh=DuF4SS0S7fuJ+G/0CP1smmshLYwknJrtBOCz3NO7BEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7oCATHfg8uTqNVIj9YiOtHagenbW9lzPcTAszM3ywTgmCga/dYTWE0C8QwRr+fP9NJ8mSTv4mUsfmonvHaqEYufJ4uU4n324MRYl/D96YNiu5kGDOT7OFXc9EsTHIOWi/ocRQ2b+0V5cGeBi3xgngC6SQ96LJk131yo9FLrlr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tEtjxeVJ; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tEtjxeVJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCcJj0LKU48+4BuabRBddGsRCHkYlNrK+zny5GKhfSdxbn5co4tVAOgVEonHNqnZRi1ePVPxJCzdH7pZ8VSfduQGyheoFkRC6dbwzb0dGEqf/UxJAp5abPCyafojb6Z/0WvKv6aKssaQiOeipfIBX72PtpC3t+04lpnuDJdRk3S4Vk2C9tc3h69axDIHuWRsUii36oY66Nr5EGUATeH/A+hDc4oSR3M+LEgvNFAsXOIZ4EWa1If6vGJDCYp/WOyGxL8iRuS216Ugp27McFFzMpb1mGQxBvl76P6K+9vbrep5S9eUEuNnE6LJtQ5eoJvICbmxYiSBX/UQKCUj53urLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIXXk4W5M2aE04XrkKAC21LgHUjioYhSRCnjUEwGpW4=;
 b=x8wpd40ZDQfJHYGNJi+TS9B77EdIyNTsCbBlbZi0Gfy81HyM5rr10rIN0sGZoiDdI/epPhr7pS2wryKoKJFMmbnp36Wzg2bLX8R71qRuhMIUxcI0Man5aucKPyBXE0keZYi30b1D1rifB0BtS4rZcwKfspmVVNY1TorSWSunv4vl/nLapIvfLBQMjQmq/XNl1GD5vdb633vAzmVeGy5m4Xp7/AmoDkgtwnH9gGbgOhSVA40tWzo9DwXMJ4Y4CEz0qJB2SDrs4euoz1SXozQyPzElGi6hVtqkLkUcCXLOdkEqfT1ck5HtL9E+YwDtYas+98LQZxDOiaReuprgQ9srCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIXXk4W5M2aE04XrkKAC21LgHUjioYhSRCnjUEwGpW4=;
 b=tEtjxeVJbu662kzT4lzhqh0TeBT5AAYmJsIwe/hFZ1srahQJ8vDgd7PbzE9YFseuVkHXNqeMvokfxUmlJ7c33Bu+u5Gp3VH3YZo68h5zEqTpnjx8LTUhl/RExNhVASRXU8lHqEP7IO4beccahs102Pm4sVsdwLVbzIHH5P6Rzb09oMDR1FmNYl+sWf+wMHwW3R3eGH0Ghp3+prjorHH2c1C6fiAOXxXYFBf/iB7eJMzKDBxWYG2DzKNypl6ILorZmvofuP0PBs9ZOwLWXG9V5IVCIq5XG6jfjtUS3aMmtvPNGlXxbOgQRRWt3DNL8F2we2qXL5M1GWywtqc5/VRgBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 00:24:07 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 00:24:04 +0000
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
Subject: [PATCH RFC 07/14] rcu: Promote late-arriving blocked tasks before reporting QS
Date: Fri,  2 Jan 2026 19:23:36 -0500
Message-Id: <20260103002343.6599-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103002343.6599-1-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:52f::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5c3356-8848-4ab9-6558-08de4a5e66fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xFZqCDtxACXk02hKiVpED5O87oWOYGb/5PIzg5gdwyxO+W6V024sXZ+cAJlV?=
 =?us-ascii?Q?p6JHFT9pVKjnA+YC70ypBYv7JCuPbX+fM2HHEVbbxQPdRhhbu5aHGfuhMPUp?=
 =?us-ascii?Q?hnpNgWMk6jcayvqZv3227D7An1hVRqRy/y5QNLCqTbgHaYQefr541z5UavJn?=
 =?us-ascii?Q?XGN5SL8dCdctkrA+oNgEZ/Nyn4efsF8/kRylnV9ZmnVyXiDY8mBXv9/eUvDY?=
 =?us-ascii?Q?1drYZ4cAuGGhtpclMvd4l426Cg503CsHSqPTp0qaqt+xdqYMtMX86k9rRTxf?=
 =?us-ascii?Q?a7uVbex+L9h64j4qfZR+CQlowIamsoZeMKGRwo6I0DH9t1vlaRWXiag2uj/P?=
 =?us-ascii?Q?Ro2VmgGWrMHz1H4Poo0SpqIJ0uZiGunkUoBngBiRnINWQrl0Juu9vPNvryH8?=
 =?us-ascii?Q?KZ9nSzpaczrIiCDG41/4/1l2gHw9r6Agk6Efie8ixxdh0/evlvbyYjdfIIpt?=
 =?us-ascii?Q?HtDLo4gXyktDdXOHPv6XpRSWlpqheelzfXG5FiqH9v4JQ1+GKIB5JpCAKzAc?=
 =?us-ascii?Q?tHFQNjQKaEowUsbH1FkeMSf/WNUmKdegU9afrl4bMD58WgVM2RSALRyfq1Zg?=
 =?us-ascii?Q?BiL4++rTYQl6ECiOqikrfknzUu/6i2DE2b1PDJBoo8y+KNzfHJunAQZ/fwsS?=
 =?us-ascii?Q?sUuG9DXi4XUYFxWRC0DQ+b9ZuRoQ8afVP8w9M3rzg7whef4y6BfTDA8K+dVi?=
 =?us-ascii?Q?pDZ5+NPAgFxBp/bBCfqScL1ImhRpBxwslrlzaHj9lbgMbjtJEM14A3P+TTGc?=
 =?us-ascii?Q?t8UawBkMoUQWst2Ed5z+IhFdZCNTqyLuT+d7G3CPxEbQBY9V9ollmHvbNA31?=
 =?us-ascii?Q?kotQH2dRDuJZDs+JhaNAbC2Vud0n3m9yg1EIsLI8j4BXExay+B6IjMEFfON5?=
 =?us-ascii?Q?9xkcX0Gnk8RQGiDcYU4WOdPMmiuBgFILGVFT2IkGUfymD+LSe4DnlySQ+U7p?=
 =?us-ascii?Q?DSw36gns7R3GOClPAdZKnGLtxO+T2ordaqD4oBrfYJIfG2J+L0mFzTDcNN6/?=
 =?us-ascii?Q?vWGFInwD56JVB4kalPp6x8zBUAQeU7BMTQKiH5vhMn4BdbJMx6On2mOD2lvW?=
 =?us-ascii?Q?qVMvfGUeYOaNouiuY6KNfiXafsuy8YmDwbrzMC8Pq8IEhxrmURpRycuvGFvs?=
 =?us-ascii?Q?WrfsCYncOtRaz0EIKYc1IbIfuxBvmKO1nrwBSMznGUy3mONy6lF/ZiXNCXrB?=
 =?us-ascii?Q?Utc9GMJKqNGJqCXb88l+9NtVLVwOIGaPd0KrrN0EJsTJtAtqBRK8VjJC1kmX?=
 =?us-ascii?Q?i1l931uBrNJ5ME/jZ9K1xm17tKJbW4JYCzXDXHdO1zhMP43IfDl+I6eo5opJ?=
 =?us-ascii?Q?nFy56zYY4M8PkDAh2WlwcoMijA2i9WtFK1ZpFYva4imRD2sV2bpGGFs6X0Cx?=
 =?us-ascii?Q?3PDtf4n5DvCnTZ6rlVKxmSaMNVsfzz8RsL+2D/JIFWNVJjqiB+AeJtxzeLAg?=
 =?us-ascii?Q?xgPctjdHVGj6Kaxm3E1mwxgh8RINf7UZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tJzV7XdqVyRcbWVxWYvXBazpyp5GI5JNgIkWyIsucuYHL3EGjSDlFn7eN39q?=
 =?us-ascii?Q?tin0I2TIyFjZyI1OC3aVLiav90EaNnuDj5epyy4MRqtJXVwlmJMeybOzG2Ma?=
 =?us-ascii?Q?kN9nAZZuBj6+BpNtVon+Y8E07NWq/EoqxA++TX/QmGxoeR9aIgH5G9KNARAb?=
 =?us-ascii?Q?F9GK+K/w5399v/OvTBE1v1B0YOz/69VC//IY7A7w3sRsiY3isFFmEsBYypo+?=
 =?us-ascii?Q?mmX6i1ZewDcrKGdOvC2Drn/UdkmA4kGsjLcOPqZkXgS/aoP83AMH8c+ykxLh?=
 =?us-ascii?Q?3/LYtUw0kPgIyqyJu9FkJOQCvhrJHSy/QeGQWEZ4JvRtnRTEhUu0Fiq6ah6W?=
 =?us-ascii?Q?0VGPVifLr7B/q3GInmZnZop9fXyY+9rIR/U+IDYelsFz+JLtb0PoSA4uFfGD?=
 =?us-ascii?Q?mzN52KNWAH0olrdYyZ0Wb09pV2/8x9CSiDqW/zNkJlgNB9zrBcGiL+8FAcKO?=
 =?us-ascii?Q?PTDlJBiFvsmpIZ72MbfeVWQHebwCVW8qLujtUO0hfvpjJQj6OXjyYS8JH3MY?=
 =?us-ascii?Q?uY/qXn8DU6sALj5FzUeOpvYiaHsYUokPcKtdffpb+TY5wQdEfTjahbrwJQuG?=
 =?us-ascii?Q?X3EZ0q1hzkuAN9ObgB1YMrnTDqf6dfrVxOh1kpgvSrguxyKcKF2Om+g4YCDq?=
 =?us-ascii?Q?x8/IXZuPo6ZbsYoUmqF9dyo3cp5DhzPbxO9bRBb4SayLfrdAhyfkXIjP9g4s?=
 =?us-ascii?Q?ZCX8m5trbpuzKBgqi3jq4gePBUg+JP3PMt4LYaWR7D8DrQlG2aszC31LjhO8?=
 =?us-ascii?Q?wr8Uk310XYVVgB8pcMQqlS5t8qMBTlBPB7o5Q7cdaNW/9xQI2mkQ7lPrCLkn?=
 =?us-ascii?Q?rZRfWeHRkr7LBr0NTQUaul2uD3q8w0pjlzeJc8KKH1mPcPakT94BygLMNIBk?=
 =?us-ascii?Q?eXhnQekf3vGObRP2QUHEejTR4aP3Q5ZQm8WYVnEF0t0BrHkkUjg2hVBRleAh?=
 =?us-ascii?Q?I4STFs95KEvTpaHUKXXfZvXVFdEJO9YzGu7YRUa+mgQfMkXFEYRpxySAXAe2?=
 =?us-ascii?Q?JnTugDjIiwgeSILeTbxrs2JqPkAn7uCjSDzYS0rtNRdNLQH0kMMXPuoXZehE?=
 =?us-ascii?Q?mhXcAcagHX93D0HCWAZmParJ/Gnb6RY9bQn+GC8Kb/m/ujPayAVr2mSM4p+r?=
 =?us-ascii?Q?eg65LTKgmuiId1/phixkvPfhgypSG15oyDpVGErxtCF7sjmfAUdxAJksw2Mq?=
 =?us-ascii?Q?Kno4JHvkCIUK7IQnd3yYyrIdz/PpQt9cGpiU9vXad7yS/rssf/8AKC0o1DdA?=
 =?us-ascii?Q?nxBLiRSEWXtBzI3FjaIizYPT71bapAKWlixsH2yhIlRaoThiUaCpF3GG95a7?=
 =?us-ascii?Q?YZ9lJ0YrNYxxPewOveDv3oQF0XAj1F/67llT8qU087C1Uun54bid2DBLU6lu?=
 =?us-ascii?Q?i4FMFDVwDlptTySC6NCafuzeeV8Uuz1o/saqbBgpjZO4l+Cw8SsUPbQhFRap?=
 =?us-ascii?Q?HCfeR8HILBWP2pNo9UhGB6WceGKAONEh4TS/8VwNPr4AfLxASNjLUU4onSv3?=
 =?us-ascii?Q?wpzJtik06rGuDJary7Boe2xfQD0M3IqIJkFwEMK8rZLRsTEZTlBKLXkIBqjw?=
 =?us-ascii?Q?YRA4EB0Uac23TiTCgupYl39+A0rr4Hy7TKzs8vBXMn35f+Ze6/wxFEgIFkow?=
 =?us-ascii?Q?5T6FSOthEJUgtUik97x/UavmxLE6tDh93PET5LM+K+Q66Xa/B9R0xJHI9Wf9?=
 =?us-ascii?Q?qh8PduiXGZFrWNkOmbT7RPBLywA2IMquujXxWGlccclZumDMJmFSnh5xe3q9?=
 =?us-ascii?Q?JWP0z/tXWQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5c3356-8848-4ab9-6558-08de4a5e66fa
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 00:24:04.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoqvFrBb+f84a/uq+DiAOaQq8fVXSXXUiWFVD3iQtkw6y5fa09mbBfhXOI2h9jrXdTMtwa8B/0GLq7Cd2gx/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

Blocked tasks need to be promoted before rdp QS reporting, so that the
QS reporting infrastructure considers this and does not prematurely end
the GP.

Therefore, this patch adds support for the same.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c | 7 +++++++
 kernel/rcu/tree.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f8f43f94adbb..2a20b1a8c5d3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2500,6 +2500,13 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
 		}
 
+		/*
+		 * Promote any late-arriving blocked tasks before reporting QS.
+		 * This handles the case where a task blocks just as a GP is
+		 * starting, missing the initial promotion in rcu_gp_init().
+		 */
+		rcu_promote_blocked_tasks_rdp(rdp, rnp);
+
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 25eb9200e6ef..809aa77f57f8 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -502,6 +502,8 @@ static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static void rcu_promote_blocked_tasks(struct rcu_node *rnp);
+static void rcu_promote_blocked_tasks_rdp(struct rcu_data *rdp,
+					  struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
-- 
2.34.1

