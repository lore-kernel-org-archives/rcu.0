Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11526ACB;
	Thu, 10 Apr 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293299; cv=fail; b=oe5zgIZ5pqfksyvqGLThSW3wvz62CUmSBkPkSuEfEOex2N7GQsxgUayauyu4d25wZzl0BKl99UPD3uQhRI33yPr4A6EoBAkgne6DyS1SAv4Mma8Ux8iuWzPopCS2KjGrjrrzPZktI0c0RPXWWTm9xNM9DfSDVY2os0Mzu06tyQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293299; c=relaxed/simple;
	bh=KFZtVHntZ0vXDGzpmUX/TukBAxqa8RjpbON8FVvUIyg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ODpV5dBd0jmeBVfe2EyBKsmQ5zlrEYcKGyZGPN7PJjHydpOIRXbrI6XAqRvRIJzLiI8otw1gkcePY1i/ys2HZGFOxLFzjTgOv9rveBRcvV97/8mod772Z0VkZELCQFn0HZkPaZPjoOaFgO7MY4WqsnUOu+JR27yjz/sRCibnNzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UOb7ufVp; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UOb7ufVp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jV1gVb3VM1eq8vaiL5Sr7V74Es4+u3QcmVGvCGc2asX8eEU8RVR8Vn02Rm507nOeTVsxG7FgWciId6sBeRkza9P17cM6xxBQWZvC99D16EnjDuzoKbznAGws8LeSbueCa2Iy004y9seHFyOZ1GKE9Oh80uP2U+2o0NA/j8z9bgKhjzo1rUhRtMxUSy8uvNvGpUmzEdWi1DT8JPHjU5rktuj/2lD4aP8TYPIF4JHDxX4Xl5GWS9//YdYNNFOAa4iflAO4EY81EyEn6vYrs2CYegyTwXOEAf4tlFO6AiARhOe4FFNwzP1YxgkZoFk3Gk8VWp9i/yc03HJaFioAbu7cNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6Vnfo0mddi5/1s9EDUVGcU2lTnqG4aVu/lDL4Oymd4=;
 b=g/VeIm+K7rA2bvmelZNkb4fjdFNW3tVOSmG3w8bofQR/RuM+R/D9xLbI0biHsKQV0Y5OrWdwYWptsrEHIz0JbTR0bmYQzipkD5qt5WtzyuRJj7XPe+WTqk20i+NrAZOZ2w26dUYtzZJi42EzALkLQUvUHZanVOTEAtmKU+MC6atRWjDLMymjo9VtCZ3pTwku020geeRXxCOxDuza0D5JFrDk8uVuLywgNLCmBBF5iQWvD7IDr9Ti01oRsIv3yXGqNvaYcKRhfq6IJ63WkYiqGfD5v+dpAtCtuc4ji48Nn8V3ZEvZTFXhPt+c7UglwbE9L5cHfSKV/17WYU1g2zipvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6Vnfo0mddi5/1s9EDUVGcU2lTnqG4aVu/lDL4Oymd4=;
 b=UOb7ufVpQjQBFNTZa+Tjta86DLscQwnhF0Ccr4GO98X/ooVMKkvSjWzVDyJkA7dHdJIss8ykUmufpTHsLsHtTkdjezr+zuo+TaJiksbi9kRFlpKmErfivIHzOJPe4f+kFCcoLHoOEHz0J/OO8N6jv8jiD+ZqNVSc3R4vmcwvzpFG0Ou4h9z2lKL5BMQZuxF1B8c/aSqHwbcl1OYZGCxe1to+PvUkFB9b/FiO5EgSC6FJclFIlXo6/HRNDiTTgSjs1eqk12+BWl/wv45zQFK0GrBsNHM6iHudz/dMaYpqdXYdLxA43j3Z4I3chF5dvIsszxw9TmOArJ2bDhloez5wcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.40; Thu, 10 Apr
 2025 13:54:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 13:54:50 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH v2] rcutorture: Perform more frequent testing of ->gpwrap
Date: Thu, 10 Apr 2025 09:54:38 -0400
Message-ID: <20250410135439.3718363-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0418.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd6f2db-8318-47d4-93a3-08dd78374387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W99Zcz612toc1qfqtpCcsjYRJGqI0OIqUN1wtRfL122JpbX/GMzl43wy8695?=
 =?us-ascii?Q?zcdpptUX8dhBwXg/JW2RBuGbkJlnPOhULW0UB7PgY5c01KMpZAJanvpBywdU?=
 =?us-ascii?Q?plwukZ4v237Xdm3Q9SJpeVIod5W1BmUATkGwHN1FgHO0BUwvoRl78Pt85uX3?=
 =?us-ascii?Q?Gts82M9aM4bwlsBMxaa9Bi6VWHv3eXUV+LvR0BZsPausHxcyIdcpSpQzg3Lu?=
 =?us-ascii?Q?PvGSr70jdW7JmpYhlLmoUFf0JliRFDMsTosJ4E1FDVaGpml1S/+gS43v694T?=
 =?us-ascii?Q?vNIN+AXgbn3rUjNAomjwAKiMcESRQf8/+a0d/I3dMVCxgFq8yc+e8MeK3nnN?=
 =?us-ascii?Q?bm4B15aHxmRSsdjejthzDXpPj1dXuzrnl+q3cqePgTaNo7q8nyk7kGMjpXEB?=
 =?us-ascii?Q?T5guBR4VbF2Kfs3KCAgA3XqsWb3JKrUTQl8T45sNx0yve1S3SDgsN2bWKTke?=
 =?us-ascii?Q?5C+6HXpKfUCq07av8Al7KWyWiJ5RX1LCt2FgpY9wuvUIKa7eMnbZAcj2hB4v?=
 =?us-ascii?Q?fnd883TxEKdwzMh/PFfuY4UgUtpw4qpfGRzDlTSSRsgFoQErkm0hAiORVzD0?=
 =?us-ascii?Q?p1Af8gJqJoKF+CSei+5OpxI8oaiI7iqUU08VHQdMaYwYGgEKIdnmL4hI+YwK?=
 =?us-ascii?Q?dBNfCzDKl2YWd+nhwvaBKP5C+CDBXVZpBuWSi5vbnmcPxWG4kagkgJ4sg+Df?=
 =?us-ascii?Q?0AxwqFAFH6SnNerQKU1Knz9fRd+t+ixAWbo4xlK6lOUQiwutNhJwhIGfJa7/?=
 =?us-ascii?Q?2ruSW6AYJCn8eyr5VJfRB+Qm6P4fgmiWDpXbxh5rjfa1zpGPdWqAnzJIr1aa?=
 =?us-ascii?Q?8DPlHgsqOj7/JBY0w/4ftuPczDkWM/NB41j1yZB3wxdsV85BKp/1JA7fAej3?=
 =?us-ascii?Q?MH3DFi3wCEq+0OBC17TLPEpyjK2q659m/RYt/s2FCAXalSX0hDudQu9rW+S4?=
 =?us-ascii?Q?HBDJsrXVX1LclvN+YSbWiIae1kuX3PhSc1Sjk5jxMIzSpOUHo27gtkiDbCba?=
 =?us-ascii?Q?WGpRzZGXEJfDoIn8zzPMUskpqb5qMOOXdU/yx7kEvZSV2bx/gF/B8MLG9w8A?=
 =?us-ascii?Q?h6rlHforavMreaRm7SioISmTU4NfXYOXL5oqzVt7Mhq35uYNbrwgGCPuY9cN?=
 =?us-ascii?Q?v55y6h2mFa2DRzDtK+gTi7/gYesQb1i2y9LIZpneTVfrrT+QZNNvdFubtSzT?=
 =?us-ascii?Q?fqwsV53qCLY5IXtwnIhzWHKLEQtSEqi3SQg8vMx4cIicHVb7bZoIOR4whDJL?=
 =?us-ascii?Q?dRF93nnZ6QvdYYTFtiTFn60Jaf10JroKtkbIyieaB/tdcinexcCkmPuWeAvz?=
 =?us-ascii?Q?cVWYI8XRO09mKBiZ2Fkj60pdJ+eO18ZcBkFPSj34JJ56H/qLXY4IaibKxBse?=
 =?us-ascii?Q?FDLMqhHgQAgwuToUbNR3wrYuKpPZOPMnqcQq986CLd0v6jpSIrqccUc/1lqo?=
 =?us-ascii?Q?PKRDpQV2Kv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iSwi3dWaGSLn0OV/mG8NHiSsi3LoMH9N5jqkZqX2rX7WIXawQc40UwlPeng+?=
 =?us-ascii?Q?HavTb7dtY8GZUaUR53lChmzvbEufYVX0463pCbgaz2caWXHNrVcnszsLuGKq?=
 =?us-ascii?Q?A0e6Nx4j4ePZLlewCMp6k4/6g8s2XljgbTbt0ZTcR8LWXIxvAL+CMkWW8wrh?=
 =?us-ascii?Q?9l+9/PlSeAKVU/ILPbJmshzGOePDbclmtXuguWo6w9VYiI0s/EGCfdOWmw6O?=
 =?us-ascii?Q?Tlepl9iOpEP9lzPkN9sfzbO6DhLqOweBwfERVePdcgtUbjQGRqUTL69/DpMV?=
 =?us-ascii?Q?r1gXUU5yTZX9Nmjvw49TtDFqDYP1U10CWs0uFUUAIEVxAvkDLe2UFa18gzcD?=
 =?us-ascii?Q?ij2eGoX4jYpAp6xzJs2pRVcXCVAxMhybAKiDxAXPcNbPWTYyOkoXP9XoIqFb?=
 =?us-ascii?Q?M4P/cgRC0ITf32rK1JfgWF72BHuwvGrqi1tgw8rxLnkFxre7L5B73kvv74VI?=
 =?us-ascii?Q?CgWTdnddK1qxoX70eNuN8L8zCwyHxj2WMNksdTJgYAHQ2l+I1W+lxn1BknH1?=
 =?us-ascii?Q?xOeyXWPfwMTqPqohbhPMW7I+hn09r870LVwSCgqK2OWM3/MHVkGQMMDhP3LC?=
 =?us-ascii?Q?Rvbn6wu1s6ZnypPwy8EgShgrclz/crUZpupUWhuVL/54Syk+SgJ6DbAfJwRW?=
 =?us-ascii?Q?ljbMNO5DOZ4a6zEoVQc7Poctxe7Y535+485gGkg+FNGhjg+MG5F7LoAuZWKi?=
 =?us-ascii?Q?zMk5HhyzD9VRrF+VKZGZ1uPlpzMXny/q7e0A4NniinqbCqJY69TxD+m33rKU?=
 =?us-ascii?Q?jTaIewSX3v+UcE7hPWEo/d22aEkIjfPwyFImzpobvHzRQSCl5sVssmkHid53?=
 =?us-ascii?Q?1IcQaeAxBbkEHApDmP6qM3kMwTzrhIcXu9jtWGnHhzAn8K2ePe5QISDi7d7C?=
 =?us-ascii?Q?JJKfEnMv177irMDi5JEc0rUnxKPzbvSYmH52FeP498xsavFw/hr9xCbLWjfv?=
 =?us-ascii?Q?/u+4Vd6ojs0Tni2MWKdpnem/D1tf/zogr7bsN2Jxm6uE3Sh/yfii/WUoD0HP?=
 =?us-ascii?Q?JD6w3boGLFdUh2vmoeOx93rSf/6LRu6KZKbm1Fr27N82ZuKgYQRVykABwhDd?=
 =?us-ascii?Q?pCsq/4F1jXsWfokupFKXfvsJ/lQHzGxS41S3yTyuF3M2QZ2sH87KQE0SVRkv?=
 =?us-ascii?Q?m7RMLsfjXbPqt+9NjyhQXBnuxc5q24XA3i59a/dSdGJE8BgGRw4i4Kguixdd?=
 =?us-ascii?Q?E/R2HrV1xHd16eZ8R94m06IJz2zjmGBVl3snSpskjjbJEgP4d+zMwYyPfHzN?=
 =?us-ascii?Q?N3vyJDcfDHAPe6Lbgyg+R3pLoaeMM4XjXEoTE0WqYIjrpuBUQ6C8M2pBAuTU?=
 =?us-ascii?Q?qLMAE7rHy2k/ZNh/xS2dNoccKKmhY2zD+tO3I+ZcQk7wsBfDdEk+IogJdDzc?=
 =?us-ascii?Q?2zDWZoeOjgJZBQL2Tg6tu6DpDwn12swUdo8TqyOICER/oUa6knCcgGiMk4oa?=
 =?us-ascii?Q?FknyoXO3uoBP9FocME1yFZPu38T5Z+KhtvCHNU1s2Q6GiR2zrTCy9aOwqERr?=
 =?us-ascii?Q?IElMVZjjrL3ugssPpp8qzA4flsYGuHt+D6Amcx7wJvxL5yJp/IBpkLoWsJ74?=
 =?us-ascii?Q?XxyYIel8KEJnBm3pQ2J21aOBs8MwXyQGARp6w1+11TQpttp5+Md25mvX2SBN?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd6f2db-8318-47d4-93a3-08dd78374387
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 13:54:50.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hmYMbSWeFaiMbkskMHM4kOl6g21MwOt+pIZpxSFKlS3jTDu0X9AWAAN6SVIDi1r8rcSKhOcijPX89hrbLRgtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781

Currently, the ->gpwrap is not tested (at all per my testing) due to the
requirement of a large delta between a CPU's rdp->gp_seq and its node's
rnp->gpseq.

This results in no testing of ->gpwrap being set. This patch by default
adds 5 minutes of testing with ->gpwrap forced by lowering the delta
between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
configurable, including the active time for the setting and a full
testing cycle.

By default, the first 25 minutes of a test will have the _default_
behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
this is reasonable since we at least add a little bit of testing for
usecases where ->gpwrap is set.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcu.h        |  4 +++
 kernel/rcu/rcutorture.c | 68 ++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree.c       | 34 +++++++++++++++++++--
 kernel/rcu/tree.h       |  1 +
 4 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index eed2951a4962..516b26024a37 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c_old,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
+void rcu_set_gpwrap_lag(unsigned long lag);
+int rcu_get_gpwrap_count(int cpu);
 #else
 static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
@@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 	do { } while (0)
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
+static inline void rcu_set_gpwrap_lag(unsigned long lag) { }
+static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
 #endif
 unsigned long long rcutorture_gather_gp_seqs(void);
 void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 895a27545ae1..c64cb5498401 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -118,6 +118,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, gpwrap_lag_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
+torture_param(int, gpwrap_lag_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
+torture_param(int, gpwrap_lag_gps, 8, "Value to set for set_gpwrap_lag during an active testing period.");
 torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
 torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
@@ -418,6 +421,8 @@ struct rcu_torture_ops {
 	bool (*reader_blocked)(void);
 	unsigned long long (*gather_gp_seqs)(void);
 	void (*format_gp_seqs)(unsigned long long seqs, char *cp, size_t len);
+	void (*set_gpwrap_lag)(unsigned long lag);
+	int (*get_gpwrap_count)(int cpu);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -625,6 +630,8 @@ static struct rcu_torture_ops rcu_ops = {
 				  : NULL,
 	.gather_gp_seqs		= rcutorture_gather_gp_seqs,
 	.format_gp_seqs		= rcutorture_format_gp_seqs,
+	.set_gpwrap_lag		= rcu_set_gpwrap_lag,
+	.get_gpwrap_count	= rcu_get_gpwrap_count,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -2629,6 +2636,7 @@ rcu_torture_stats_print(void)
 	int i;
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	long n_gpwraps = 0;
 	struct rcu_torture *rtcp;
 	static unsigned long rtcv_snap = ULONG_MAX;
 	static bool splatted;
@@ -2639,6 +2647,7 @@ rcu_torture_stats_print(void)
 			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
 			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
+		n_gpwraps += cur_ops->get_gpwrap_count(cpu);
 	}
 	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
 		if (pipesummary[i] != 0)
@@ -2670,8 +2679,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
 	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
-	pr_cont("nocb-toggles: %ld:%ld\n",
+	pr_cont("nocb-toggles: %ld:%ld ",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
+	pr_cont("gpwraps: %ld\n", n_gpwraps);
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -3842,6 +3852,55 @@ static int rcu_torture_preempt(void *unused)
 
 static enum cpuhp_state rcutor_hp;
 
+static struct hrtimer gpwrap_lag_timer;
+static bool gpwrap_lag_active;
+
+/* Timer handler for toggling RCU grace-period sequence overflow test lag value */
+static enum hrtimer_restart rcu_gpwrap_lag_timer(struct hrtimer *timer)
+{
+	ktime_t next_delay;
+
+	if (gpwrap_lag_active) {
+		pr_alert("rcu-torture: Disabling ovf lag (value=0)\n");
+		cur_ops->set_gpwrap_lag(0);
+		gpwrap_lag_active = false;
+		next_delay = ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0);
+	} else {
+		pr_alert("rcu-torture: Enabling ovf lag (value=%d)\n", gpwrap_lag_gps);
+		cur_ops->set_gpwrap_lag(gpwrap_lag_gps);
+		gpwrap_lag_active = true;
+		next_delay = ktime_set(gpwrap_lag_active_mins * 60, 0);
+	}
+
+	if (torture_must_stop())
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward_now(timer, next_delay);
+	return HRTIMER_RESTART;
+}
+
+static int rcu_gpwrap_lag_init(void)
+{
+	if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
+		pr_alert("rcu-torture: lag timing parameters must be positive\n");
+		return -EINVAL;
+	}
+
+	hrtimer_init(&gpwrap_lag_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	gpwrap_lag_timer.function = rcu_gpwrap_lag_timer;
+	gpwrap_lag_active = false;
+	hrtimer_start(&gpwrap_lag_timer,
+		      ktime_set((gpwrap_lag_cycle_mins - gpwrap_lag_active_mins) * 60, 0), HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+static void rcu_gpwrap_lag_cleanup(void)
+{
+	hrtimer_cancel(&gpwrap_lag_timer);
+	cur_ops->set_gpwrap_lag(0);
+	gpwrap_lag_active = false;
+}
 static void
 rcu_torture_cleanup(void)
 {
@@ -4015,6 +4074,9 @@ rcu_torture_cleanup(void)
 	torture_cleanup_end();
 	if (cur_ops->gp_slow_unregister)
 		cur_ops->gp_slow_unregister(NULL);
+
+	if (cur_ops->set_gpwrap_lag)
+		rcu_gpwrap_lag_cleanup();
 }
 
 static void rcu_torture_leak_cb(struct rcu_head *rhp)
@@ -4508,6 +4570,10 @@ rcu_torture_init(void)
 	torture_init_end();
 	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
 		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
+
+	if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
+		goto unwind;
+
 	return 0;
 
 unwind:
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b77ccc55557b..95913764af73 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -80,6 +80,15 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *);
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.gpwrap = true,
 };
+
+int rcu_get_gpwrap_count(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return READ_ONCE(rdp->gpwrap_count);
+}
+EXPORT_SYMBOL_GPL(rcu_get_gpwrap_count);
+
 static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
 	.gp_state = RCU_GP_IDLE,
@@ -778,6 +787,25 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
 }
 
+/**
+ * rcu_set_gpwrap_lag - Set RCU GP sequence overflow lag value.
+ * @lag_gps: Set overflow lag to this many grace period worth of counters
+ * which is used by rcutorture to quickly force a gpwrap situation.
+ * @lag_gps = 0 means we reset it back to the boot-time value.
+ */
+static unsigned long seq_gpwrap_lag = ULONG_MAX / 4;
+
+void rcu_set_gpwrap_lag(unsigned long lag_gps)
+{
+	unsigned long lag_seq_count;
+
+	lag_seq_count = (lag_gps == 0)
+			? ULONG_MAX / 4
+			: lag_gps << RCU_SEQ_CTR_SHIFT;
+	WRITE_ONCE(seq_gpwrap_lag, lag_seq_count);
+}
+EXPORT_SYMBOL_GPL(rcu_set_gpwrap_lag);
+
 /*
  * When trying to report a quiescent state on behalf of some other CPU,
  * it is our responsibility to check for and handle potential overflow
@@ -788,9 +816,11 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + ULONG_MAX / 4,
-			 rnp->gp_seq))
+	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + seq_gpwrap_lag,
+			 rnp->gp_seq)) {
 		WRITE_ONCE(rdp->gpwrap, true);
+		WRITE_ONCE(rdp->gpwrap_count, READ_ONCE(rdp->gpwrap_count) + 1);
+	}
 	if (ULONG_CMP_LT(rdp->rcu_iw_gp_seq + ULONG_MAX / 4, rnp->gp_seq))
 		rdp->rcu_iw_gp_seq = rnp->gp_seq + ULONG_MAX / 4;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..63bea388c243 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -183,6 +183,7 @@ struct rcu_data {
 	bool		core_needs_qs;	/* Core waits for quiescent state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
+	unsigned int	gpwrap_count;	/* Count of GP sequence wrap. */
 	bool		cpu_started;	/* RCU watching this onlining CPU. */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
-- 
2.43.0

