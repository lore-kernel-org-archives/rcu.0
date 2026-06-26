Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239EC26059D;
	Fri, 26 Jun 2026 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434599; cv=fail; b=JyCrtXSxjY+6UXb8AjtEKwSMt7qDzP1ZGpiBTlmAGZz2jrq/ASgRQzNULGEN7INXFfkHlThtOSMtzee7KUbewh9SFVlv3ArbCNXjW/EkoGkfVxtaI1YShHiYLk3g6DPV6BH1S6HKmR5+53MHnv2aybp2c3zAhBFydt4DdBYW/bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434599; c=relaxed/simple;
	bh=x6XwJKZiJOplZBgc7Q2Srd7NkGvEmt2vZFixyFfgWdw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s7LbWFP5zpYdjMeLzFTS5H1tKEyIq8g8yTbM5ODp/sbEYVWFnvkFKmWkoQ8ZvK/maa5+5JQ27Y/ZBUdTvQzNrH1+ljHwAQijTY8/dhBYDCtOShOcsd/EOCkH7bPIAvOYTP8MA8T6Iw02mQrO4g5nUsnSgaZ5o/WYFVunrHgV4pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nXzBSPsC; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nXzBSPsC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8jNDbxsp5khrNp7kLKyJCgcZvRIIAVvW2y83G+9XIpS5yo3VdbybnWx2zhMbhegfKIxcYLanxjPcUS6atfzV8HfDSO+cgwkWOdg2Wv16NM4Xcxip0vPk56xKr3zG1RHqE92NMVH3aIW5xvZRV/ZRpJ3INWqDn1GufwbAMXXMtF4Ir/fzsp553y80cbVDGp5kCSOrMFnwy+NVVUOd4d7QHjCYNru3R8lm6rkykB3niSXBFn51U3R2zWTf2zgrZz3EVYSdxSPg+fGJHIm/loz4osaKbgUBbr4e3HQRo1kdlhuYmDh0FXPu79jFa8GWE7E6xWbFj+zu5cKDVgmS5XE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kArOZXWuO2ohsS2IQX/+kM8f3cUDEWoET9CRPfH/QZY=;
 b=lJKoCvacXFZj+MGlR6zFs8A08q6HPKlq7CijQtzux/7Bt0OYdEKbLWSwbF5ZpWJ4KDdytaXX55yKDij2IZeWGe0jDiiocH0GBjT9ujXh2IOVeuYyThOQzkCURcwFyHA4diiOGL6JxnH84GVAXC6tb+jeEryzbKY8JMFJCM4Pf9nkMIbQtZ9QyqQUEUdci2Sw90cWCBfAVQ4iNdo4s2zE47SdOf54V/2olOPMJvSoUY5/vh/5SFI+rVtPeVsEy/e3ru6ijilhsvAAOkldo1sfYEAhNXFA6HB+JCaiN8bjGIhfDIpvKf6BEp9PVJcUAzCMM4rc3KHe7mYMqWLWTEcm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kArOZXWuO2ohsS2IQX/+kM8f3cUDEWoET9CRPfH/QZY=;
 b=nXzBSPsCPQ+ySG3CCFhBlguLaTeBF+djukinTaBgXhekmE4pjJRyTiNdMIWL/TOwjOIQ+UOK/ALsMutoPEjuOSuc35z3Q/zAZQevPbwsuPHLp8oFmXKjbtUnru0lt0Agw3+Nk0/3ML8XeAM1AgRxiVR4c3jtztk6oKyXchq5wvHWfm/4AbN0A+9vqEQujShzcrPYk+0b7WMH088efxYHfFrO3VID8maHMeju3j3dhNCe12Ljk0rKbejLECa3gxzQwnPxXo1nNC9kasGgLn3dIlf6fhEe5Kme4q4JYKFcJwlkUi/xxokXgnriDLvYuZRxxnfPEuBAGhFheZOZURwqmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:43:06 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:43:06 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v4 0/8] rcu: fix stuck defer_qs_pending state and add rescue timer
Date: Thu, 25 Jun 2026 20:42:53 -0400
Message-Id: <20260626004301.1632168-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d6bbe6-072a-4d7b-453c-08ded31be308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	7RgaUaZCSyjjkeR7PLsfOsV5pRpoxhIT1IXro7hsnRJOCH290JI6PKbhYGsznz/HcJEnwT9DBcsuJBCHik3b6aWCSrJ8TRNcywHO4NBE1AUlmwctn2OzLOSES2dNwDIusQHxris3VBStG5HCP2tt1jTwToZ5H8xQcpVgXjFOmfSAoRump94bS1x/VIkKSC9VAevQuSPBtLFgBDYaJVkd2RqgRQqIOYiVCmBpS8nIf9vOPFvBoiZ85/6EaM7bsVjDmke8z60KxbIfBq4jnWARnfXSReh4LPG4mHYt4hLUDvpeKEWsKPrP7pkwZ+rt3ClPIpQXqFaj6Hc2zYyDpm+e+T9q4Z4xQpEdpRxr+oS80IEL7WmiP+pR1v5YKlNPM5GTk7PGhy7JKfvjNGhXF/W7lL0Ib90KrlVMyBt/IxqrkxBsk7+JFSgZuWuViYpF4826bm3OGxExxga7cz+hx75oUe/N77HgL18Xs3pgAZMlIIUzEKhp816P97Pf1et33VlCsejih1oru1Wz4CbOKj2EoHY8gkn+vhqvdOBXt+T317SkPqCtY8Iy6LAlMXgk/kUnJf1w/voCqpxZz8khprJ2nI4gUxyiLlbUyhtp55lGm4M5nqplr0xC3VyubHTTO21zQoeSqmEZEbt6WXI3kX6XYv9G4/HRGWGSbrFy3OeuouU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wt1hO31O4s4s4qI85Z/GLbKGxsxMvdYy8YD9XglRQwq2XEp8m00ufpZIbF/F?=
 =?us-ascii?Q?MNaarg8569CpeT4IwxHAYQ1azpzhHmpYjw0IzY7yfxU/jWLqDHJJuB+4AFMR?=
 =?us-ascii?Q?Kz5LeyvXIr1+YaEssqmvXuKF5nWE6NoI07RjuccJt7QPx/NDwfTCaZm6KXxb?=
 =?us-ascii?Q?8I/eg4S+AdGTrXrXNJKhQzDt7YtLMJWDcEoNwtRfn9HM9BE4dJwmoWiYgYuD?=
 =?us-ascii?Q?Zx6c+9lC56Y9K/rfeO2aqsO+t/y5afnIDNm7KTZvo30wg4XKhsmj+HHyIxU7?=
 =?us-ascii?Q?Sb9sryAuprPJacuLh+08q9YUvc5dueyDG3acMkcd6ek3s+5vYIQwsN0q6qjD?=
 =?us-ascii?Q?Vn2TKs5R01q8loS51rDCVhxK9Mau7YjXPEFewz20uW3jllVOZV83diyFo5BC?=
 =?us-ascii?Q?Nx8UHK+QNRjYMOP/EdLjCQIcGdFO0W3nFnFiUaUnbW0QT9g9B0cZTWLM8tvW?=
 =?us-ascii?Q?t+MVj9/I8WCA0O5J5CJqXAJB1xLUSHBALt71d2LobzEan8yRyAM9k4yy2ENb?=
 =?us-ascii?Q?Bhbiv7tIy2ESa/4owFqkZEkkH5CgEBtlXN9EJZtu5omNzi2YWZVwFcf+cv4d?=
 =?us-ascii?Q?bqFjLpp6GzTCUEG0aMjIoA1iru30my8vr6i3bXgzwu6hBfsPc1bITtsG1Qep?=
 =?us-ascii?Q?iBcoX88doTDc9LiIF+U/zUiB1y3FUj+a4gKB49WRGqRA9SzVa9VBgE+UgsV4?=
 =?us-ascii?Q?3prm7YiyNhUSjoXwDOWWea+3RuSp68+vc2Y0FeBr+73S7QtmM2IyYglRxBZy?=
 =?us-ascii?Q?kFvgElUXRIUgcG1GctJtx+1OFoDer8/Z9OuhFKz1Br+SrGL9FU9YughVelpf?=
 =?us-ascii?Q?3glJMjgNNKhTx890xBDr8VjlaBUmDxwxy7ERNEgvFC2VDDSOa8KUeIS+9Kkc?=
 =?us-ascii?Q?9TMvHK3d02NcxSZDAXmdhYVW59UFU4BsVWajfI+6LnE/3L9qNu0bp9Bm7hM2?=
 =?us-ascii?Q?P6hzJ/3tPhtEPClZt9VDVy0AvsErbJDr4nMkMAR5lkZrZe1af/XALNwch2Gn?=
 =?us-ascii?Q?mwjJ0BPDcfxMsHUQXkSmQEFHJqYKoQG9xEhXfa9YIRSwgKJFgID86URXPIYH?=
 =?us-ascii?Q?/n8x6tbgkdOQo4GQFv0cT4vCaLjYqSOZnipryIW/J0sFWgc7zyP7NRFJgW4i?=
 =?us-ascii?Q?7YGcXezcF3yzv3uL5ncDDYLab1fRIMmHFX7aOq2tlaeoWSm+/bWpx/vljSF1?=
 =?us-ascii?Q?s97ZP6N0OmVbi1UVhSEOFOBrCrRy2+6GAPqiFEYUdbJGccNpESg7nefTzQK2?=
 =?us-ascii?Q?e0wiSSwcCg6xUgB3SNzdfmL0mK0SDjoO73soS6Hdk+UFRPitiu4IAdxah7ut?=
 =?us-ascii?Q?sdyAJkt36KcS7Q27oZDMgPkkqAQSEULZu6iiWFj/vib8Wiuz5TZpZuFsObEu?=
 =?us-ascii?Q?y9p/Irj4qOriaqsJaLmkVASr/x07pP1OpusbaNAEq9/wFFA4xa/qOUD9ISgf?=
 =?us-ascii?Q?u+4nOodQsqeRFknLpSZqofMlsFwbyIGw/tw6AE5C/xp0FbDV6IDdw4EK+UVb?=
 =?us-ascii?Q?1u4L8ahAoUxz5zY7z5qlsEmjjAx0fl4051JBeRW//mdzBI7xUpEdqX8/tbeR?=
 =?us-ascii?Q?0l8C8OSj5naDKytU8NpD7w2psu3UCJrzEjUGk9eHegLCGdol1jXSq2O1NN0u?=
 =?us-ascii?Q?yZGbgYpkcV4u94Ixx8/2yUjDlaw1/IoAmW3ENTai3LjQ2vL9mpOyAjW6lrsJ?=
 =?us-ascii?Q?Lfa0/OY7J9O7YnmDEmr08VolnMY0HaK+nX1frDS9jxvVwk0Mx9js8e0VYx42?=
 =?us-ascii?Q?kPKnoFQiCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d6bbe6-072a-4d7b-453c-08ded31be308
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:43:06.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePgW68qfuY6UGr3nZayTVSpHXrB0+2Ap5Q0V5YdgO3WMJiL5An1Xo3/Nz2KFJ5J3hgI/AN1aiIQptTWQXS/bKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

This series fixes a bug where rdp->defer_qs_pending can remain stuck in
PENDING when a preempted reader's quiescent state is reported up-tree via
a path other than the deferred-QS irq-work handler (FQS scan, hotplug
transition, expedited GP IPI, context switch). Once stuck, the pending
gate in rcu_read_unlock_special() silently suppresses all future arming
attempts on that CPU. The series adds PENDING -> IDLE transitions at the
missing sites (patches 1-7), including the case where the deferred-QS
irq-work handler may run between segments of a compound section (per Paul
McKenney's counter-example) and the softirq deferred-QS arming path.

Patch 8 adds a per-CPU rescue hrtimer that bounds the worst-case
deferred-QS reporting latency: when the irq-work handler lands in a clean
(non-reader, non-compound) context it reports the quiescent state directly
via the new rcu_preempt_deferred_qs_try_report() helper, and the rescue timer
reuses the same helper so that, under preempt=none, the QS report is quick
without depending on the scheduler.  The rescue timer is cancelled from the
normal deferred-QS report path so it does not fire once the quiescent state
has already been reported.

This version is rebased on top of Paul's latest rcu/dev branch. The
rcutorture reader-end deboost test patches that were folded into v3 are now
in rcu/dev and have been dropped here. The git tree below additionally
carries two debug-only commits on top of the series ([TEST COMMIT], not for
merge): a detector that WARNs if defer_qs_pending is stuck at GP cleanup,
and an rcutorture tweak that gives the async deboost mechanisms up to 500us
before warning. Applied alone on unmodified mainline, the detector reliably
fires within 5 minutes under TREE03 rcutorture; with the full fix applied I
could not reproduce the issue.

The git tree with all patches can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: rcu-dqs-stuck-v4-20260625)

Change log:

Changes from v3 to v4:
- Rebased on top of Paul's latest rcu/dev branch.
- Dropped the rcutorture reader-end deboost test patches.
- Reclassified "rcutorture: give async deboost mechanisms up to 500us before
  WARN" as a debug-only [TEST COMMIT] (not for merge).
- "rcu: add per-CPU rescue hrtimer for deferred-QS reporting": cancel the
  rescue hrtimer from rcu_preempt_deferred_qs_irqrestore() via
  hrtimer_try_to_cancel() so it no longer fires after a normal report path
  has already reported the QS -- about a 90% reduction in rescue-timer fires
  under TREE03 with rcutorture.gp_exp=1.
- Patches 1-7 are unchanged from v3.

Changes from v2 to v3:
- Folded in the rcutorture "reader-end deboost testing" patches (three from
  Paul, two from me), previously posted separately as an RFC, so the fix
  and its test coverage can be reviewed together:
  https://lore.kernel.org/all/20260616222622.2981876-1-joelagnelf@nvidia.com/
- New patch "rcu: add per-CPU rescue hrtimer for deferred-QS reporting" to
  bound the worst-case deferred-QS reporting latency.
- New patch "rcu: clear defer_qs_pending in deferred-QS bail when nesting > 0".
- Reworked "rcu: clear defer_qs_pending in handler for compounded sections":
  the irq-work handler now reports the deferred QS directly via the new
  rcu_preempt_deferred_qs_try_report() helper when it lands in a clean
  context, instead of only nudging the scheduler.

Changes from v1 to v2:
- Dropped RFC tag now that softirq paths have been investigated.
- Added new patch "rcu: set need_resched on softirq deferred-QS arming
  path" to handle the softirq arming case that was deferred in v1.

Link to v3: https://lore.kernel.org/all/20260618185030.376450-1-joelagnelf@nvidia.com/
Link to v2: https://lore.kernel.org/all/20260526225014.314734-1-joelagnelf@nvidia.com/
Link to v1: https://lore.kernel.org/all/20260522142342.1536533-1-joelagnelf@nvidia.com/

Joel Fernandes (8):
  rcu: introduce rcu_defer_qs_clear() helper
  rcu: clear defer_qs_pending when notifying GP changes
  rcu: clear defer_qs_pending in handler for compounded sections
  rcu: drop redundant defer_qs_pending clear in irqrestore handler
  rcu: clear defer_qs_pending at expedited IPI entry
  rcu: set need_resched on softirq deferred-QS arming path
  rcu: clear defer_qs_pending in deferred-QS bail when nesting > 0
  rcu: add per-CPU rescue hrtimer for deferred-QS reporting

 kernel/rcu/tree.c        |   3 +
 kernel/rcu/tree.h        |   6 ++
 kernel/rcu/tree_exp.h    |   6 ++
 kernel/rcu/tree_plugin.h | 149 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 147 insertions(+), 17 deletions(-)


base-commit: 47e26f0fd70890ddd810887a043303a365a8bf03
-- 
2.34.1

