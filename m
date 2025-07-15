Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586129E117;
	Tue, 15 Jul 2025 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609745; cv=fail; b=e+K1+uOhlOlaoCIJ2RAShXaGN8/MR7ae+mfltVXXxJVE8qKPwdIdoytmMhSRZpy7b66n6IUxiSH/QxiNIOgxAVp2/s2y7equJvjcNY10iYwope42ZS2l6smpCHzEnxFttu+cY0jq2t5hd63gaRHuBfg87Fb/PFiMuapEhNg1wy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609745; c=relaxed/simple;
	bh=62wqs9lEk7qVLS3PuRJrnX0g5GIMgcTMkutUcD7G2ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QOkPAWuz4aUbI0g6t1DZkqStlJeRNVh5lwHshI5eA1AikrlRrwoU1e3C9VA+piWRDG5F13v87CFlqmjOCCge9YMY0yMGYm7XEmUEqi+2KbIAjBt8Wa4qo95FcQz4nGqucxk67GBTH1IREAJuAHfGyGrZApYSWvIn5NZzUso+Eao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IIngfytH; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IIngfytH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUhRgErNDPBZd1RhZRBD4F6LT/HZ/53l2nYzkbNc3hyFOjvSnMkv2O7vEOuiMf7HLBYFEjYKI5GYjf12cO4pD8UKq4aZT52rne95cnxws9bWQM3gzevGZXYhKjTweivAXt50toR0S1x7I9HReQQU/FrUvJpIwtLk3UpupJGO8VM/RCDooSBCR9pIDwJmC5V454vy2V6ngOsi8Envxkx9kMVSFqmzNSigBEuWaKAQGvXXRLJVlaOsgsSFTek2/9X5Ouax1B2a8p+mAA9aUHcHXt/NMpeMmrLRMePPEIoQUfGueFvQnfiF4qjpJo9/oGSvEuzQRRbX6DKWC3ACeNkqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzR2MNprUba9v4Mj4LcwuICTYWRxry+qs4TRY3K5eRY=;
 b=v82E2afKkUwhKbHDEKsfOkPcXhtV2ILIU1KTeRhZLILGazeveA+KWVv8slLI9VJsAma8uAvm4wW9wvz0juTrYl6SvtswFySx2Hc8MVeYhm86Dhb71cnEb9fPu5zuc+pp6tSSwkdHGwBB11jGwDcSx3f4gzMnpvKf1uZeDut8UPnhS1HrDkXOSIz0dX9hBldr1rrHRUpB8HRgJFBEmd52jCIMObJuYp1NyFd6JC2wfQPToK5LVjpNB6cFjlUpXFD4rjBXpXjm0Usr/KWiz4qu7kQ0JrvTOzdgo3o0Qs2AHg9nEFPNJG7mgf8iRs9wNhDB2gHcUfuFolSOkfiQqzyyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzR2MNprUba9v4Mj4LcwuICTYWRxry+qs4TRY3K5eRY=;
 b=IIngfytHD6OC+Wscjg+4iN40HGQ/CzTpNgOLUr7ZxhL0uXTxygBMLz2ZAsM9cMOznRLdxUCy34vMS4ZsG7kufe4fHEhQQ1pDeb7fYznW5wfWh+IRYbSXWgecXKxTubPii8rFKMG0Gi013YL0mtW6gWmqYbW/QxvQ9SzcsXqisfCyIW0GR4UltQXeSaVdEcxEkwwWnddQcDO0qtzkZteTGbqFk85XdQLeOtBGOOP6pGGBStVwSbG0Ym1nFs/NgRgjKrmgCcSuufLCeTP8h+L0U0NMVY7pf9SMqO22Bn+EY8ly3X0fXsGWzpQRU+f4X8lFbhXe8ROE2LnxVYIU/PMPuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 20:02:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 20:02:19 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	neeraj.iitr10@gmail.com,
	paulmck@kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andrea Righi <arighi@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -next 1/6] smp: Document preemption and stop_machine() mutual exclusion
Date: Tue, 15 Jul 2025 16:01:51 -0400
Message-Id: <20250715200156.2852484-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715200156.2852484-1-joelagnelf@nvidia.com>
References: <20250715200156.2852484-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 939d9e58-ec39-45ca-0b29-08ddc3da815f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EyAf9B8ujA/3Q+pcKbdaOdTLt4eWyWihecVquT3uqnrWtMOg/OEa0K2VJCTs?=
 =?us-ascii?Q?UZ7Iiw6JgCDWyg66uyBWKCFwyayT52ijJaijglZBMbiKesGkBy6eq0ZBNhj9?=
 =?us-ascii?Q?Bs45ppD5yJZC3vIhgq+nLqNtNqBpZIZZiaTMELIi3XAb9ixcPMeu4ULkFfw1?=
 =?us-ascii?Q?4/PpJyP6K9gCYmgrU2Cou8R6zGpqnSsFrOCPppSC5gTtlhuQ9JYJ5YbaTPDd?=
 =?us-ascii?Q?W3LpMeZB1wGZGXmH+JQUM/k6d5YAI2LrFBhqENCjF9PfmGEGNybKRIJACqkN?=
 =?us-ascii?Q?OglyrorPMeAIhOL+DfBWQVt4TTABX0JIaG59cP0CO7Q1BpkwjdGV4KWoaKfw?=
 =?us-ascii?Q?JIP7sQP1gZk5hI8BxcDHHyQT9VOZT+quEnTm2oyS64UbBo6LJj5N2IjJeNsL?=
 =?us-ascii?Q?jUrYvfm/Zwc/pKrxgV7ZOJNJHjOQhWGJpPpR6/0Wcv0cfZngECOVkPyd2ga+?=
 =?us-ascii?Q?KMgUzDUCeJqAk2b/JN5dyO9WXXkHnk09CAlLZ1BcK9eppjpKQ/93yxMOASIX?=
 =?us-ascii?Q?ChIwTmptsEFK4z6BbzVIJzlqnczPbO8ZVhfmEZuDB1Qx4THdcIhdT4Qth3eG?=
 =?us-ascii?Q?kna0ws/X3ArkM41Q3opkao1hdVqlF/idjztHASZhXsgUA63+94fRTNyoJCsm?=
 =?us-ascii?Q?x6i5ZT5G9VfK+4JyHCFdo6u8BsJhopBocahrjET6bglR5t2khQhYiQreUBTm?=
 =?us-ascii?Q?Z1CRhICO7ov0TZU+DIl9/aMp+/eHcdCa98ARj6cCY2DcFwHuVJdFqqvkM3cd?=
 =?us-ascii?Q?J6ZF56+qJ61sz88h1sXR7cEHhD78QfjRKtMv3idXDJORInR5KrH6fI57baf8?=
 =?us-ascii?Q?LsHGo1YTY7hxLR2C+n8oyRkA/GXI4a1N0A281TjeuI95zZ8K9f+qdyLvZ8bI?=
 =?us-ascii?Q?Azx/U6oUGvmIvha/Oj5zZYGKevCXjL4hqJai3N/u7EvVvMo7Q4QFniZHkEL6?=
 =?us-ascii?Q?MEhwxt0CxSJotcY8UCq2KlEnFRfdp5WwdDt3isgZakBiZPqmT+NPnNui+5lH?=
 =?us-ascii?Q?T2s3LfrPzNcJZxMKgb7W4qfNiSOxnKSMt9wDL7m1E30S+BvE6yB8gSVs0dEH?=
 =?us-ascii?Q?Q0lAPgUK43ytTHsCNTT/gzx5aXtAmMwFl5CvFbv0SU+n8iafrFupqPXM05Jz?=
 =?us-ascii?Q?U7cmxEtwfOiBPdGqvmHjCvsU+tt+CSpBBbEX7AQr302KY1HN/Vauh9Jqx0yS?=
 =?us-ascii?Q?uV40nR4dsiIOW03WgDl/pRk4XEyTtYWgMSnvu9ZXAnW44SrTYT8wNpSQOlCc?=
 =?us-ascii?Q?li7lhTishkqmqubmtqNrxUO+mkNMMp5O017BoRhMBnQ7m8RDd/CS2PjehPq1?=
 =?us-ascii?Q?ioEzmio7bm9iFL5W3r108RKgcp7PIuppU+CHy1gKbPxgAWnJByAM4W87dBb7?=
 =?us-ascii?Q?U3H1uebsv4dR2JFslBB3mlwKh7Tvu9pptY8r3j0QH5xKFhz+k1hPhv/nYxgl?=
 =?us-ascii?Q?RVs9tf/E0I0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DOowyFfaCDGtr+ylbX3CNFShHj/UsDiYaTatfnHhOQN/5dUAygfxeOmhV52Q?=
 =?us-ascii?Q?RDO3uJu9k1P+FDVz/NTTqR0il9B/Lkr71GOmwDk1IhCrsceqomHwXBSaN0Jd?=
 =?us-ascii?Q?+KIYINFBTXLTHdh1QU047KapGg11H8uUVkR6xVFn6ux7zRZrC4RlegMpgyfA?=
 =?us-ascii?Q?LDH1BFfMhYMdb7zYxfVM7OOZDAvNXmYlfNcyRN7djELElzZlU5SSgWPDISS+?=
 =?us-ascii?Q?e4eS78ZThTB/YhIhufhXPg1Bu0O5qAkXK/7MjXzRyVliUj/I0tpmqJmxmXqZ?=
 =?us-ascii?Q?5kNrdmuhshAIwnabHqxIlyGtwLJ+tJ9yKkNMfiSwf7VX1dYa4Jq7RYxVGwUR?=
 =?us-ascii?Q?2fulpNQVOzclCg/VAMSkGYJWwo/iBnQRk9QbSo7wh1OMTabkJbtpRCdsP4ry?=
 =?us-ascii?Q?EU+nOk7PU12mT8B7XbKqLGqdNMXwhXEiJd8RQq1gkceAr4EVPpW3plXIiXEm?=
 =?us-ascii?Q?cXygeL1BIGabWtkSAiTTtclQ67pXPv4mBQti1j4BdBT3gjBkQPYY3oTW6x3k?=
 =?us-ascii?Q?/rHl0h8LP+SAcZNcGUPK+fFF9l7c2dPwaQqH1aLHpzu2UCkqmrw3rTPHty7D?=
 =?us-ascii?Q?2FtpfbIRgzjT+BsVj8GKc/XA8JNNhR5EjV51ki9HWkHPlWg3FB+xDao8ojQ9?=
 =?us-ascii?Q?h7uk3Gwqh569Us/qxMh1YiIlUFYsZ5qdOTBE7C1GA7+saK8OQ7V2I6BPtcTn?=
 =?us-ascii?Q?obKaYgVbJEi93/LUdA5kpYyTu2LPldSXnXYupNpsA7fANsa7NUuVSEiL25zb?=
 =?us-ascii?Q?UfiZBe2OJRWYdDl3WE72mjna0VNaKDybHccumHmLE1mZrGlADQyt93gwzxUB?=
 =?us-ascii?Q?2wuxD6aP1cuiMoXLU4ZAHepaV7MZ4PaqfEYdmDiPpyDWJXfeVqYn8BS65PXi?=
 =?us-ascii?Q?Hl2pGg5LNCZ0AtBsTvzzWtVY130G0t8feyjKV4/qpt0NqqkQVZYqxR4MMDGz?=
 =?us-ascii?Q?iWK0V6SqTzofBHqyxas244ZiY8ZnsGWj0Si9HCX0f1WgH7WDbJOtFiA+ZJJj?=
 =?us-ascii?Q?hCc3ZsBEmdgn5KsUkqvZc7lJI9KgyN/j3yZUwaGg2SBLesIV5fv4NE9O1O4I?=
 =?us-ascii?Q?KZGmZQwymj5DVWDoySY5+tTYqTemwQ1eIQ+U9xs6w/lpZMtoOpLrdDGDlj5X?=
 =?us-ascii?Q?GNJvDyfK8FzO4yd6Z//B0KPYIAc7trkT+nFV3uUK9KGLabDZQvg2/ACWShrt?=
 =?us-ascii?Q?E18f4YEgAoK3C7919mzmEtyw7kHkNI4D9cjZhh84VmnJZnEUksXwlwtfz5cG?=
 =?us-ascii?Q?4ZN+OBO2pmLPW5g1cY9gCN7bUNWQfbJ25BLHkBylkK8cLijlH6Vxi4Uw3vzm?=
 =?us-ascii?Q?5ic3jUhFXQvHKB1g4CL9LvsyPvu66ezw0KoHn4inxcl6ll36JQ9yRcIaXPGU?=
 =?us-ascii?Q?2TODSHuEAlbzJDXipiD3ODqbNhyKVCcKBeVYw0ZIyZVbx4gkJRtgNwWNtwbD?=
 =?us-ascii?Q?evg+FvtSEkR8m2vXSYvxOMzepHSEydjoLLNIL41Xy0qnzgSjMDKFdMO+uBYh?=
 =?us-ascii?Q?pDdkLvmR0Dv2yvMIzaIBDuJnk2WBEwxZRlZC0EcnevRJZGyfAETzYlCX/e8l?=
 =?us-ascii?Q?yJDWPftty1H9QV2Mpnq78x8Dh+dXYQY85pJrB59R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939d9e58-ec39-45ca-0b29-08ddc3da815f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 20:02:19.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xteihHaVtmVijvrsKHusAOTGuxmaPYC7WeC7K8pdaMPNgmcPV8tDg73MUxOYGarXkfVM5vQajRioaDMSUqgeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

Recently while revising RCU's cpu online checks, there was some discussion
around how IPIs synchronize with hotplug.

Add comments explaining how preemption disable creates mutual exclusion with
CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
atomically updates CPU masks and flushes IPIs with interrupts disabled, and
cannot proceed while any CPU (including the IPI sender) has preemption
disabled.

[ Apply peterz feedback. ]

Cc: Andrea Righi <arighi@nvidia.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: rcu@vger.kernel.org
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/smp.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 974f3a3962e8..23d51a8e582d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -86,13 +86,15 @@ int smpcfd_dead_cpu(unsigned int cpu)
 int smpcfd_dying_cpu(unsigned int cpu)
 {
 	/*
-	 * The IPIs for the smp-call-function callbacks queued by other
-	 * CPUs might arrive late, either due to hardware latencies or
-	 * because this CPU disabled interrupts (inside stop-machine)
-	 * before the IPIs were sent. So flush out any pending callbacks
-	 * explicitly (without waiting for the IPIs to arrive), to
-	 * ensure that the outgoing CPU doesn't go offline with work
-	 * still pending.
+	 * The IPIs for the smp-call-function callbacks queued by other CPUs
+	 * might arrive late, either due to hardware latencies or because this
+	 * CPU disabled interrupts (inside stop-machine) before the IPIs were
+	 * sent. So flush out any pending callbacks explicitly (without waiting
+	 * for the IPIs to arrive), to ensure that the outgoing CPU doesn't go
+	 * offline with work still pending.
+	 *
+	 * This runs with interrupts disabled inside the stopper task invoked by
+	 * stop_machine(), ensuring mutually exclusive CPU offlining and IPI flush.
 	 */
 	__flush_smp_call_function_queue(false);
 	irq_work_run();
@@ -418,6 +420,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  */
 static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
+	/*
+	 * Preemption already disabled here so stopper cannot run on this CPU,
+	 * ensuring mutually exclusive CPU offlining and last IPI flush.
+	 */
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
 		void *info = csd->info;
@@ -638,8 +644,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	int err;
 
 	/*
-	 * prevent preemption and reschedule on another processor,
-	 * as well as CPU removal
+	 * Prevent preemption and reschedule on another CPU, as well as CPU
+	 * removal. This prevents stopper from running on this CPU, thus
+	 * providing mutual exclusion of the below cpu_online() check and
+	 * IPI sending ensuring IPI are not missed by CPU going offline.
 	 */
 	this_cpu = get_cpu();
 
-- 
2.34.1

