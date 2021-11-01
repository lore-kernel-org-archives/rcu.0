Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F91C433EF
	for <rcu@archiver.kernel.org>; Mon,  1 Nov 2021 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDC660FE8
	for <rcu@archiver.kernel.org>; Mon,  1 Nov 2021 10:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhKAKfk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Nov 2021 06:35:40 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:1808 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231841AbhKAKfj (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 1 Nov 2021 06:35:39 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A1ANnta022483;
        Mon, 1 Nov 2021 10:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=jIthWs2yOjomKmwJNRRPmPYpLQcPKFd4/jgJ2dffF1w=;
 b=N9go/+QK5EqZ8IfsqZdZlBFYHIgvKYKgUoVaHZj6KuEFRYUovq0tSE8ZfP5cnHkq0Z4b
 NR7/mjE7rXkw0NFurC4RKtseVZch6xiEVUr5qLqr33WwflgH4GpXXO0ksguThmXHSpPF
 vu0gcXLpQtCgvB21rwa9mCup+ZndH3sXtkU13YzYkJZzhg1yx+ajQvYdOBLeeKqj5STU
 ZWWqGlqfYEWpntyaxmzf9ZZHVvr8KUKqqlnOIqsydCVQBrzsfdQZ2Z1J3rXgok4DoTXD
 XTd8S7YQE1eL3Qwen+qHGOYIjmvI0RmqDZGuIkKzOo2RAgTrt3CC+OqQMpHFATlp5zSP Fg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3c2b7jr4cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 10:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqkGUsBWgQRfEp+4KDO5FufS9aVQa1h1kbJPCn5kaCrcJo50zuIYELn0tMKqtBnY2cP4BCi8M1A9lvx6bHJ1TilfD+EPgY7q3/18FWsEiFc6usdy28zu2FrX9C3Y8Oc1jIvB1G7w+pmW4IEPEM/7QdQWkBPUIPsbL40vAGwqodswVC2nU8RiByxSe8ICOsBtszp9B3/1j0HkSyETH84i/fsn/5yGwrnUeISB9N4IVSNawcPpsD3XhFFY394Z2nrFEQKp5oxLmgHC5KdXfmtf6DxbXm9X/2WOLNwf/Qid/4a9lFaNsKeXrbHWc/3iooM/L3fxLe3iQDiTlknLLjQviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIthWs2yOjomKmwJNRRPmPYpLQcPKFd4/jgJ2dffF1w=;
 b=TMukx+uZ9nPI1ytZ5+NDa5rz0Q1Oqy0S0N2tjhrkt/jVn20VPxcHFrqiAQcHjbUbTskLPBNKJLVCkWwRx6noAwEWs+LtTExTmDVJwDQSJ85zQ+E6fKHkJnNYB0V/BYX/rN/yEErbuj79RJulw/NvrCaFwFWhXP6fKwqWJLPDI7AkZGTFbPkQAU6F61G/M+bsHhquOxV2d63e2MUQFyviyoByUunZggsGqxw/5mIOaG1A39CBbrikbEmUmZ5jh7H9z1RQX5NAGHg93M7Mm5VWw771NkTru1akNsphKjSpdpfSwibLGcriZOucwmWZ83s7xBRKpPVwJv23G47teklrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB3035.namprd11.prod.outlook.com (2603:10b6:5:69::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Mon, 1 Nov 2021 10:32:14 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::3558:2607:4c64:8f5c]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::3558:2607:4c64:8f5c%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 10:32:14 +0000
From:   Jun Miao <jun.miao@windriver.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, dvyukov@google.com
Cc:     urezki@gmail.com, qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, miaojun0823@163.com,
        jianwei.hu@windriver.com
Subject: [PATCH] rcu: avoid alloc_pages() when recording stack
Date:   Mon,  1 Nov 2021 18:31:58 +0800
Message-Id: <20211101103158.3725704-1-jun.miao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HKAPR04CA0015.apcprd04.prod.outlook.com (2603:1096:203:d0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 10:32:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05c0f44d-622e-4ea9-ae6c-08d99d22def3
X-MS-TrafficTypeDiagnostic: DM6PR11MB3035:
X-Microsoft-Antispam-PRVS: <DM6PR11MB303568050597C5745370F5F18E8A9@DM6PR11MB3035.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNQBDIvIBNEqXZA/L62ZYTzwl8OQTJ3m3AZyU5im7fredwcEeu9sENjYhiMarc5WMwPUCklDjlSRDqXZHUhWs0qZYZxUGlAqdGT2RdlLcWDRLIc2p0BpX8KFMEU2nFDtrZX5m50CRTZn3l2C7Mjoj9/H8YtmIJl/aYWbUZWcA1+6MiOjQmIW8uUdjaquVHwYWh0Ij4IALVikqmO/tsTuH47PoDKMEGZyI7BYvq7vMaNzwEq2DdH5ylz5FgywMSkq3qWmIIwJaXjqmke99iKKV76Ya+KUok9ogWxtnWNAvLLoXkkFulB3hAW2bAzVqAVZDFdLOJ510Ed2Ik2/3PuC/pszVn4hL8QRRPaOhKwMpRdoYs0pIUYMYUgyKMhZz06lI9U+w90RcSswiZJX8QnwOA5seqoKNoF5I89FJPVxV/0cJ2ZjDe0AJllgR1xPGG7ndGilH7l5iL2zj4GNDutoZx/D+M8+towEOJGRNP9QMbhF53/QGCD0l98TbKc97X56QR2JkP2ZTBTeSSfxVG3ijIVudCc2pcF9Dw+eyMADwDzG79ZjdmHWpKEOo7d4Vi+esZAViWpUk/C8MgmIuvFSr5KDN3NtaJKWMQpdwiozzAce/kkfl2XC9dWQ22dqV50h9h/gRwRLR4fH9hWom6gzvJMDd4/nDukAUdjeSe7nohH1Ene7Z9gFCJcMMYH61Q5dZOxa8y6pksfNADf8Hhpx/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(5660300002)(26005)(6506007)(66574015)(2906002)(66476007)(66556008)(86362001)(66946007)(4326008)(956004)(2616005)(6486002)(107886003)(44832011)(8936002)(508600001)(52116002)(186003)(1076003)(7416002)(38350700002)(6512007)(36756003)(8676002)(316002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/uvYK+niSR/Df6rUXi0xQjNwclqxrYq30MDWwdIN+94EjRf4TyMC9Qcmh65s?=
 =?us-ascii?Q?vOcPtdqfEb7BpDF5vdJrn8qgB7bpdbvh2Z8AVTEOd7Hs5snVbaWx7qy6SFjU?=
 =?us-ascii?Q?K9mSPfi0vfqF6FcSY56oLMAfpJw+a8GSb+7JHzLp7TiqBC9qd3egBS6E90C0?=
 =?us-ascii?Q?OFiEtMwSmiDkq3GUepEZnkfUJ7MsDJsS7ftND99XkWUVHIK+fDM2ZhsvkBjA?=
 =?us-ascii?Q?7oN1vGtDXqwFPn1EjpFPiRpuwRc0Lv0x8HTyjScgORndqXygf167mkCyBMPO?=
 =?us-ascii?Q?ZcJw81dzZpeFoGUvPS4KZZi36FFUkRH/rcUUWmKtFL7j3Jo0Ui3Xf2UJF0T1?=
 =?us-ascii?Q?HwQU1yIzUX/+TbMxrcV0RH9FNu2Ku1hWpnpjO0VsuJeUyDPs0w2dgZiGkYKy?=
 =?us-ascii?Q?r0SjBVAei1RCuV79t1vxTpajCYWrSzGdI+2wbfXDV61zmJJeUUXRPwl8ERHk?=
 =?us-ascii?Q?41GIx0OsTqQqJ/55tQ42tkkaDcrXINxnm0ozecpgIAdT+5YRnSqSI9C5+MiV?=
 =?us-ascii?Q?AYn2NRluqPCeWRcgNZ7K/KUK0QnmiuXJc2IFm+VsXCHhWOWNA74BW9naH1+M?=
 =?us-ascii?Q?dLKPkL07fyHceHAF5x4wjZ4wbbIFDZjuPu+/lZkkQAnBY6QkXFJSA+sBKHXn?=
 =?us-ascii?Q?nN02DyL1sA9Vvln+75jinrT9Jk+78Pt2aIw84jyyXByfIgcxy2MJR9+AoV2C?=
 =?us-ascii?Q?OVp7YWpPYGFBdNYXD4YmfwJPDwmhBHQNlN1WC/CCXM4daPP2954qbWBH5RRq?=
 =?us-ascii?Q?23TIIuzBdNSms5s9ml4xGZ2xI0zAO0e3e1X2OZE7ccdkCZksIlHlBTELCkRG?=
 =?us-ascii?Q?GsIqCAl4Ha0brgVXJ8NHceduqHHaHT6MBKyY0iFmUP5CR99E7JikyoVReWVe?=
 =?us-ascii?Q?ZMZxpFVIjg96p4KSrTNcoiwa9bkbpA+lJhb15N3iu0MoXc1QGn6CBCHB0Bgi?=
 =?us-ascii?Q?d9erg3l8H6V4YN4h4gExZ+YwbcwnWZ/VjX1SD/q5ef8N2LhJOs0oTpNQAb0C?=
 =?us-ascii?Q?6O7Hx5elN18VPegk1NKv4mvRT3bR1pA1YRNL79G8DygLM/CYnJAiKOENGxWf?=
 =?us-ascii?Q?eqFIIg6GRhIH4WKm6fO2pqPi3jOJUl1Z0WR2K065WR+AD3xxs9MNgjPXeuYB?=
 =?us-ascii?Q?ZUh0O+U/j2StDY+CRWoYCqz6CjwLkRYtbDEtarLdNBYRYQnea5jcCz7Npkdh?=
 =?us-ascii?Q?mlnxxf9+WLl3+f1sQAxnONlEAS3+rP5fyMGj/96Sxk/Cq7aBCTlmFvMtdSIy?=
 =?us-ascii?Q?m3qQXXudEe9gWBj7AzFTUFI2Kb7M6X1qbuxkXuqXBFC/b25NXFWML46kxvE8?=
 =?us-ascii?Q?cioMQXnIWj6JTeE4l4NVkwhidjtLZFmEFL7h1Lb0in+Au7WdN7y52/hiAiw8?=
 =?us-ascii?Q?qUe9rmrV1LU9Yxye4K/WLg+FCnn3QcRFisLrLgWRUM7Eykg+puUvBOkCPcB8?=
 =?us-ascii?Q?5BNH6vIXizTJxoN8DNtf5QTOWXHlBBeykeYp8WGbQZdFe8ujQqO4f5s1D9d3?=
 =?us-ascii?Q?CPaSxJH56/jEn2EJI6c5sPNMkCkX4EYErqLoQGmGZtLlKJbsfYJiVYWB+Wyy?=
 =?us-ascii?Q?vHkCQ82x1X+89pYZkFFSrBlMwDRtFDc9alYbe0xQREI+OOP2Do7bKLg+sBb4?=
 =?us-ascii?Q?gDa1gq8xSbUiQxBjfm98L38=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c0f44d-622e-4ea9-ae6c-08d99d22def3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 10:32:14.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSH/MRXg3n8iUEJ5R8M+Bv09RMI2e5YZn9SuN8z/bO48uo8SCyjuhC04K+Lb19TAHgXwBULwz1xXyh7iNktwCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3035
X-Proofpoint-GUID: 9tR1urxwLLNRHYqairJMsUV9XpBn0bcm
X-Proofpoint-ORIG-GUID: 9tR1urxwLLNRHYqairJMsUV9XpBn0bcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_04,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010060
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The default kasan_record_aux_stack() calls stack_depot_save() with GFP_NOWAIT,
which in turn can then call alloc_pages(GFP_NOWAIT, ...).  In general, however,
it is not even possible to use either GFP_ATOMIC nor GFP_NOWAIT in certain
non-preemptive contexts/RT kernel including raw_spin_locks (see gfp.h and ab00db216c9c7).

Fix it by instructing stackdepot to not expand stack storage via alloc_pages()
in case it runs out by using kasan_record_aux_stack_noalloc().

Jianwei Hu reported:
 BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
 in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15319, name: python3
 INFO: lockdep is turned off.
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
 softirqs last  enabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  O 5.15-rc7-preempt-rt #1
 Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1b 12/17/2018
 Call Trace:
  show_stack+0x52/0x58
  dump_stack+0xa1/0xd6
  ___might_sleep.cold+0x11c/0x12d
  rt_spin_lock+0x3f/0xc0
  rmqueue+0x100/0x1460
  rmqueue+0x100/0x1460
  mark_usage+0x1a0/0x1a0
  ftrace_graph_ret_addr+0x2a/0xb0
  rmqueue_pcplist.constprop.0+0x6a0/0x6a0
   __kasan_check_read+0x11/0x20
   __zone_watermark_ok+0x114/0x270
   get_page_from_freelist+0x148/0x630
   is_module_text_address+0x32/0xa0
   __alloc_pages_nodemask+0x2f6/0x790
   __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
   create_prof_cpu_mask+0x30/0x30
   alloc_pages_current+0xb1/0x150
   stack_depot_save+0x39f/0x490
   kasan_save_stack+0x42/0x50
   kasan_save_stack+0x23/0x50
   kasan_record_aux_stack+0xa9/0xc0
   __call_rcu+0xff/0x9c0
   call_rcu+0xe/0x10
   put_object+0x53/0x70
   __delete_object+0x7b/0x90
   kmemleak_free+0x46/0x70
   slab_free_freelist_hook+0xb4/0x160
   kfree+0xe5/0x420
   kfree_const+0x17/0x30
   kobject_cleanup+0xaa/0x230
   kobject_put+0x76/0x90
   netdev_queue_update_kobjects+0x17d/0x1f0
   ... ...
   ksys_write+0xd9/0x180
   __x64_sys_write+0x42/0x50
   do_syscall_64+0x38/0x50
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call stack for KASAN")
Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_rcu() call stack")
Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
Signed-off-by: Jun Miao <jun.miao@windriver.com>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8270e58cd0f3..2c1034580f15 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3026,7 +3026,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	head->func = func;
 	head->next = NULL;
 	local_irq_save(flags);
-	kasan_record_aux_stack(head);
+	kasan_record_aux_stack_noalloc(head);
 	rdp = this_cpu_ptr(&rcu_data);
 
 	/* Add the callback to our list. */
@@ -3591,7 +3591,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		return;
 	}
 
-	kasan_record_aux_stack(ptr);
+	kasan_record_aux_stack_noalloc(ptr);
 	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
-- 
2.33.0

