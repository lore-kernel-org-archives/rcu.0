Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48244EB64D9
	for <rcu@archiver.kernel.org>; Mon, 19 Jun 2023 14:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjFSOA0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFSOA0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Jun 2023 10:00:26 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E7B19C;
        Mon, 19 Jun 2023 07:00:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QlBH82SJkz4f4cBp;
        Mon, 19 Jun 2023 22:00:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCH77JtX5BkiIFAMA--.58229S6;
        Mon, 19 Jun 2023 22:00:21 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC PATCH bpf-next v5 2/2] bpf: Call rcu_momentary_dyntick_idle() in task work periodically
Date:   Mon, 19 Jun 2023 22:32:31 +0800
Message-Id: <20230619143231.222536-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230619143231.222536-1-houtao@huaweicloud.com>
References: <20230619143231.222536-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77JtX5BkiIFAMA--.58229S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZw47Cw1UCw43CrWfGFW5Awb_yoW5tw15pF
        Way345Ars8XFsFgw4ayws7AwsxJw4Fqa47Kay7uas8urWSqwnxKas7KFy2vry5urWrGr13
        AFWqyFyUu3y0kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

After doing reuse-after-RCU-GP in bpf memory allocator, if there are
intensive memory allocation and free in bpf memory allocator and RCU GP
is slow, the peak memory usage for bpf memory allocator will be high.

To reduce memory usage for bpf memory allocator, call
rcu_momentary_dyntick_idle() in task work periodically to accelerate the
expiration of RCU grace period.

The following benchmark results the memory usage reduce a lot after
applying the patch:

Before:
overwrite           per-prod-op 49.11 ± 1.30k/s, avg mem 313.09 ± 80.36MiB, peak mem 509.09MiB
batch_add_batch_del per-prod-op 76.06 ± 2.38k/s, avg mem 287.97 ± 63.59MiB, peak mem 496.81MiB
add_del_on_diff_cpu per-prod-op 18.75 ± 0.09k/s, avg mem  27.71 ±  4.92MiB, peak mem  44.54MiB

After:
overwrite           per-prod-op 51.17 ± 0.30k/s, avg mem 105.09 ±  7.74MiB, peak mem 143.60MiB
batch_add_batch_del per-prod-op 86.43 ± 0.90k/s, avg mem  85.82 ± 11.81MiB, peak mem 118.93MiB
add_del_on_diff_cpu per-prod-op 18.71 ± 0.08k/s, avg mem  26.92 ±  5.50MiB, peak mem  43.18MiB

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9b31c53fd285..c4b4cae04400 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -6,6 +6,7 @@
 #include <linux/irq_work.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
+#include <linux/task_work.h>
 #include <asm/local.h>
 
 /* Any context (including NMI) BPF specific memory allocator.
@@ -123,6 +124,16 @@ struct bpf_reuse_batch {
 	struct rcu_head rcu;
 };
 
+#define BPF_GP_ACC_RUNNING 0
+
+struct bpf_rcu_gp_acc_ctx {
+	unsigned long flags;
+	unsigned long next_run;
+	struct callback_head work;
+};
+
+static DEFINE_PER_CPU(struct bpf_rcu_gp_acc_ctx, bpf_acc_ctx);
+
 static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 {
 	struct llist_node *entry, *next;
@@ -347,12 +358,47 @@ static void dyn_reuse_rcu(struct rcu_head *rcu)
 	kfree(batch);
 }
 
+static void bpf_rcu_gp_acc_work(struct callback_head *head)
+{
+	struct bpf_rcu_gp_acc_ctx *ctx = container_of(head, struct bpf_rcu_gp_acc_ctx, work);
+
+	local_irq_disable();
+	rcu_momentary_dyntick_idle();
+	local_irq_enable();
+
+	/* The interval between rcu_momentary_dyntick_idle() calls is
+	 * at least 10ms.
+	 */
+	WRITE_ONCE(ctx->next_run, jiffies + msecs_to_jiffies(10));
+	clear_bit(BPF_GP_ACC_RUNNING, &ctx->flags);
+}
+
+static void bpf_mem_rcu_gp_acc(struct bpf_mem_cache *c)
+{
+	struct bpf_rcu_gp_acc_ctx *ctx = this_cpu_ptr(&bpf_acc_ctx);
+
+	if (atomic_read(&c->dyn_reuse_rcu_cnt) < 128 ||
+	    time_before(jiffies, READ_ONCE(ctx->next_run)))
+		return;
+
+	if ((current->flags & PF_KTHREAD) ||
+	    test_and_set_bit(BPF_GP_ACC_RUNNING, &ctx->flags))
+		return;
+
+	init_task_work(&ctx->work, bpf_rcu_gp_acc_work);
+	/* Task is exiting ? */
+	if (task_work_add(current, &ctx->work, TWA_RESUME))
+		clear_bit(BPF_GP_ACC_RUNNING, &ctx->flags);
+}
+
 static void reuse_bulk(struct bpf_mem_cache *c)
 {
 	struct llist_node *head, *tail;
 	struct bpf_reuse_batch *batch;
 	unsigned long flags;
 
+	bpf_mem_rcu_gp_acc(c);
+
 	head = llist_del_all(&c->free_llist_extra);
 	tail = head;
 	while (tail && tail->next)
-- 
2.29.2

