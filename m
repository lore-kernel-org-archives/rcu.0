Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABB3DFC94;
	Thu, 18 Jun 2026 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808679; cv=fail; b=e9tyXA3ClnWbwOn65Rm3DNJQA8k6NWWq+6uHsxBbYjQ28+l1/vZosr53Ci2szgUnpQl66qYALCS63XDwHXaMICXejjprsajUFTQPi2dnChlpDZL53c4sq4RPO8jULiZVHs3xn8ikmIDGszQDJccyeY5uE0G1nNeCQvCFyRxyLq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808679; c=relaxed/simple;
	bh=8kGTqGav49dIVJxARJ1qYrm/JY4o2RpsnsxzSDGciKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IRF+xoDjRFdhDkSkHOqQtLpfRMhgeiJtY17iurN+q43U+HizBGKJ9QiFN8W551kgRmJdQvPEm8hkc0WauYmP84i9yAsQO5CTJo08CxL8kZdORrTcDSbaTK9mf8g5zEMAKstqlhBbwcguFiykopBA5a8mc5umC8Rxr6gyKtfDNmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M11gsSDu; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M11gsSDu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM9abjYGZdpzBRqIqNSE+WrQv/Tt2ZK3Cxr6y6qnOWOvW79R1Amf6DiTCkb09IpscckO54L0VXbgeRJPCyZi8OFWnY7pSMmdkcXpBQ1L1snkpRggEecE/aqL7BlmSMwHAaI4BVOYeura5u6YU0CkMHdlR5YBM3OMGMQ7bIJn39QPvQWDdYr7qrn68jOpTRGr05v4Vy23LI5ZJaiCJyIHU93LLXlRWIZAN6Pk/sxEslNxnceUxfxvHGj8lOeB0D6WiNtrYKwwoSnn2A0cEMK3pQpeM766IYJssdhnfqXf8JM+9mrPAtnBgC0iteQqqUZkIPpTDEfOrMNRmfgqji1vcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euoGfAgrXhqx3dyFVXrAZdGg4O+KCE5vKpUPK6J/6Ng=;
 b=e+GKsOfbkUDoY9J42Zk0rxiNBjMH/JjsGzjOZRKpl7n8RnDcX/BaHNlaqiM2yYXOPlwMys4/dPOcrhkx5sB7vNDmzUXr1whYCkrpI6WK5QDmZgYtl/IQs3B2I61kSAZpvt3CbVswJNNcKHsmJDas6isS2zROTb53/4npaP876h/1wNXph5Ngr3ymfSb5zqmbFQV49aKryxxopBx/RExgB0jK5/D6ab/be2nGD1w6lQbU9236+xj7sz0+QyKg4iN3/Y5RscBPI88+RoaYCm3C47TVo178oANDU+gdbww+7oskwxhG/xQNLH6x+2BvBnqdy7qxqSU7deOXSkrW1Foauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euoGfAgrXhqx3dyFVXrAZdGg4O+KCE5vKpUPK6J/6Ng=;
 b=M11gsSDutcsIXfMZuijXjXDYgHLKXHWe/9AFA/MG8wTvlXrtm1QXpCvJn02xZiJNNqivlQmuA88Y57kzHxaGm1IXj30boq4RxPgGjtn4/UDj1zBCgv+V3yFBxLjWwJEFcuKbKbTulL8IRm7s0hs9BbTesSJkmFEyDEK3o0ZLFX+I+63F1qG1TtOItYmMOAdkfEpYk9mhnT9Rp4WwhvdH6Wzi1ge9vwdresKhaEjir63lRYkNLGNvsBaSQzf9/tqKpQoCdrC/wyAz+Q8aVAGaorXoTclIP8yv909+XCecSFHM2XQHCoqk9j0jZ5FhLgFE0wYZgAkqbn4af3Hd0xTqDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF49208036B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:51:12 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:51:10 +0000
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
	Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org
Subject: [PATCH v3 00/14] rcu: fix stuck defer_qs_pending state, add rescue timer and torture tests
Date: Thu, 18 Jun 2026 14:50:16 -0400
Message-Id: <20260618185030.376450-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF49208036B:EE_
X-MS-Office365-Filtering-Correlation-Id: 148c05d1-a18c-425b-5c5e-08decd6a8ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NUFHixT3gu6hXSKyWRxQf8Ge/FrIkiYcb6km/DLSA2QrLxWo7eXmE81lGNUaegcr+zOGt8VBZQdJ9KxJZw3GCZYEnxEa0NLcXxiqFUVX4HYh9F8HsWa72ZPi0WpuuUIdVGtb/nAxYake5WvUUZDbZt8ZVE07YlXG5i+G5Z56oarkVJhtW4aiZ2FuPFWA46+LNXQ2s36xLySkGhe3llM9Vk2d0fgCTlTmd8xssyu+VMkKpvkJ+9Weybn3JfALlQII9HrPoID7rf6AFDgrLzZwz9V5rHavWQUv6fTbmm6glFb4SNI53vNKeaHmpTJjALnl/YUAfXdzcr1KvJcF0j0U8+MNy2h0K5BCMxeasBd9nVRoUa1SCm3k0d/IOOqFy8xUaXX+2YR+YnifacXnjH5jEz4hgPgcsARoMaREiw2UcBcc0QTHY6XpszPJW6XbAzMjP2dQgVoGMtJ9+SLqwTzpVh3bciDmnFPsDHjileFnEeiVOCkEp32etO2fMxhTbhiQTT2M7dOUKlDBWqNKCkw2lQKmy09ks8RuN3nq1pK2I6BCpJ+4pxc206Fp64i8o465EKR6+zXGsbspSej0WJ4Eo7pBrEzckoIJKBnB5nmEv6HUoPneouBSzZFUFog4rKxKylZ3R/x/VW2aqRZAaA6JpElcZ9luOziUwh+4qE3/+TeGlK0fucQTy6ytawmcHeCXJ2Gwbza4S0feLHGuORojrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWlZYms0K0lad0NJN1lWdUJ6UmV6bmJDeTFaZXFrK0dmRk8rNGFaOFA1bWRz?=
 =?utf-8?B?SnVXbVNRQUhIcFVjMkxyUHZnRWY4Zm9SZjBEclgwejdOYjY0RllsVE5yZVJ4?=
 =?utf-8?B?bE9RL3M5ZHNwY01WcXY5em9WZCs0YTdjaTNrZWtZSXh3U1pkeXpNVUpkOTF5?=
 =?utf-8?B?UUpMdzB1cTFlOUUwRXNmYTFmNzZzTytlZ0pUeGFpbzFBdDkrb29ldk54SWVq?=
 =?utf-8?B?VTNVQzVWOUt1WU9QUlE4bUJSdndid1RjdmlJd3Vad05leG81dkFpZWVrcGVs?=
 =?utf-8?B?Zi93cFlkNUt2TjU0bFV4SWx3QlBROUZYT1Q2WHBEZFlhS3ZlV2hzNTcrd3lL?=
 =?utf-8?B?RytXVWpYWlhGKzgyOVZvYUl2ZkwvVTZNUlU2bVZMZkJsSC9iT3A1MjlCZHRw?=
 =?utf-8?B?Rk1nUlU5dW10dEZoQ20vS3AreXN1aFpJc1NITUdRanJhM0ZQTEhHMXIvZ0Fr?=
 =?utf-8?B?VE1HL25RTFVHMDB1dmZucTBXMzBPd0FkcjdZeE1Pby9hT3RrOFRmdkNiNHFq?=
 =?utf-8?B?RG9vT01TeXNUcXBhMmhTcFJLUURyVmRxelE4UzQrN0pEMGtJeXowQlQ5ZWpL?=
 =?utf-8?B?MUorbDUwRkRBdmRrY1BQMjlnYmFzbnZXdWV0MjR5N29rUjRrd1VIZzhZOCt6?=
 =?utf-8?B?MVEzRmNNWU1ydFpjcjQwdnpSd1JkNk5UcEI1aktTU3dFOXZxenJnUEg3NmZo?=
 =?utf-8?B?YnBkOVNkc3FVVW5NeU0xK3IvcWtaeGtyME91Nk9ObUxHVHNPTVllcHVzeE50?=
 =?utf-8?B?UldwNlpKNDBxdlZtQmw0NFJKZ29BUDg0dUljZGRKWEM0SCt1S0Z4QzBkR0kw?=
 =?utf-8?B?d3ArNkJpb3pkK3JQMk1ienZzaUc4aWVVNDhNb2dqdllJVlJSYncxSUlndlR0?=
 =?utf-8?B?STc5aEk4YjBFSzY1N3RNYmV3YzJFbHQ2ZlZjUDljWE4vTCtoSTB5azJia1do?=
 =?utf-8?B?Ukc0NklKU3pTWGc3T3dvUSs1cHgwd1lVZW52RG5ldC8wWjczSUtxWndISGZT?=
 =?utf-8?B?RjhkQ3FwWWdQdFRReUN3T2w3eEtMWGFxamszQXFGQlErOVJUdUlmT3Jjc084?=
 =?utf-8?B?dDEyYkN0djA0Njh2MzI5VlltMTRPVExHYXBlRnpLZGFsZkNZR2VFUzh2OWJ4?=
 =?utf-8?B?cEgxb1dScnhhbURuNWF2RFRPNnRRamdhak8yOVVwSmNreDJQVmJ4ZGh0NEU1?=
 =?utf-8?B?bzRzbzJTYXpCYy9MSklEamVzQ0hhSjhueHE5dEg0ak1xbjZKcTZBbWh6elFG?=
 =?utf-8?B?Q25YTjNRU0VhTm8rdC9IckhGcXlFNmZYMEdQTDJLTmwxK3VxUFQwbzlTbDlt?=
 =?utf-8?B?SlcwM25FRUd1bWVZVjZzQTZ2UUtqTVgySThlRjVWOWZXSlBrSEhOTUNDYTZ3?=
 =?utf-8?B?dzBqNlFHUnJiT1RNU0tBRnR3UXVWcmdzZ0VhZ2tEd3JBS0hoRWoxQWs3NWZv?=
 =?utf-8?B?aEVleFZzSnZYOGRCTVh2ZFVyaUlETGx1NGFURFdsRXRkUnZUMnREU01POCtt?=
 =?utf-8?B?UFRCQkVjOFE3Zk1WNGN6YUpzcE5UYlQxdDUzWmJuTGVGS2I1NlJpMWFWbkVK?=
 =?utf-8?B?MG9jcXZITVRPanYvMzNzdmdZNGEzMUg0RktRRXBYcjYrN1lCS3N4d05iYnFU?=
 =?utf-8?B?STdrTEt5M0RxMmJPRUtvcWFGcCtNNnU5dTFyYVRrWVg3Z1FVczhveWdpeHhn?=
 =?utf-8?B?UW52dWJSdWI2WXhYK2djNWdWK0lGNVp3aXE5YmxVSHZoRGhLZ0dGb0NBU2pC?=
 =?utf-8?B?Y0ROOU4ycjVBTGt5R3NYNHg1R0NZelZ2N1JPd2t0YkxIeUJrdFB4U3lqaXVo?=
 =?utf-8?B?WENtdUxFTm5sd0FjZ04rbE9UZ0kwWStsNUZrK0FHVmMzWStkVzFlTjZtKzZJ?=
 =?utf-8?B?WTZLNXppVjJIeTU4Q2JhcEZGTEgzM0tLQUliaHZCOEljQzZxUloxL0ZKVWpu?=
 =?utf-8?B?djl3c1RiQmZjOUFheWRWUEx5OW9NNmtBbHZUL2ZWUHEwMnFPNVN1Nnl5Vjhv?=
 =?utf-8?B?U2hxODVlUnJlV3EzMFBNMkxXd1JoVXNYYkV2UXhHWk14R211VTNraGhDekpj?=
 =?utf-8?B?YnRVQXUvb2FEOGNxZi9JWW1TZWRrVUdwMEZ1WFh6Wm9NSUFRSWlTRkUyb3Yv?=
 =?utf-8?B?bXFQVEh0clAwcXhzZHIzSGRFTEpTYVo5UVpwb3A1cDZLclZQOHRXL1BqU0lF?=
 =?utf-8?B?U0xoNzVtMndDM0JGQnNOcVcyTG1ZN01jVFBRb3hzRHRkbDluMHN2Snh0WUk0?=
 =?utf-8?B?OXpmRWdCbkNLck5YSDhpT0ZWczFoSDRTUWpLRENHVUV2eGNqNHViTWwwWU9F?=
 =?utf-8?B?QTFEOXlrVFVULzNjUkJEQ3hheWFJVXdscWtCcXR4Wng5OWZUdWI5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148c05d1-a18c-425b-5c5e-08decd6a8ff6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:51:10.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awLDcBVPSShlKgwSmGBziN014/yXakpYqHkR29o5U/+x9m9ZudEa3bgieNXTEJMDhtfUJE6OSAd6HwWqbIhl2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B

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
without depending on the scheduler.

Patches 9-13 add rcutorture coverage for the reader-end deboost behavior
(three from Paul, two from me). These were previously posted on their own
as an RFC; they are folded in here so the fix and its test coverage can be
reviewed together.

The last patch is a debug-only detector (CONFIG_RCU_GP_CLEANUP_STALE_CHECK,
marked [TEST COMMIT], not for merge) -- applied alone on unmodified
mainline without the fixes it reliably fires a WARN within 5 minutes under
TREE03 rcutorture, confirming the bug exists and the detector catches it;
with the full fix applied, I could not reproduce the issue.

The git tree with all patches can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: rcu-dqs-stuck-v3-20260618)

Change log:

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

Link to v2: https://lore.kernel.org/all/20260526225014.314734-1-joelagnelf@nvidia.com/
Link to v1: https://lore.kernel.org/all/20260522142342.1536533-1-joelagnelf@nvidia.com/

Joel Fernandes (11):
  rcu: introduce rcu_defer_qs_clear() helper
  rcu: clear defer_qs_pending when notifying GP changes
  rcu: clear defer_qs_pending in handler for compounded sections
  rcu: drop redundant defer_qs_pending clear in irqrestore handler
  rcu: clear defer_qs_pending at expedited IPI entry
  rcu: set need_resched on softirq deferred-QS arming path
  rcu: clear defer_qs_pending in deferred-QS bail when nesting > 0
  rcu: add per-CPU rescue hrtimer for deferred-QS reporting
  rcutorture: tighten boost-WARN to exclude any implicit-reader context
  rcutorture: give async deboost mechanisms up to 500us before WARN
  [TEST COMMIT] rcu: detect stuck defer_qs_pending at GP cleanup

Paul E. McKenney (3):
  rcutorture: Abstract reader-segment dump into
    rcu_torture_dump_read_segs()
  rcutorture: Check for immediate deboosting at reader end
  rcutorture: Test RCU readers from hardware interrupt handlers

 kernel/rcu/Kconfig.debug |  11 ++
 kernel/rcu/rcu.h         |   7 ++
 kernel/rcu/rcutorture.c  | 257 +++++++++++++++++++++++++++------------
 kernel/rcu/tree.c        |  50 ++++++++
 kernel/rcu/tree.h        |  14 +++
 kernel/rcu/tree_exp.h    |   6 +
 kernel/rcu/tree_plugin.h | 169 ++++++++++++++++++++++---
 7 files changed, 419 insertions(+), 95 deletions(-)


base-commit: 95c7d025cc8c3c6c41206e2a18332eb04878b7ef
-- 
2.34.1

