Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBEBC77B73
	for <rcu@archiver.kernel.org>; Tue,  6 Jun 2023 03:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjFFDVC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Jun 2023 23:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjFFDU7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Jun 2023 23:20:59 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15881B6;
        Mon,  5 Jun 2023 20:20:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QZwjH1Hz1z4f3jM9;
        Tue,  6 Jun 2023 11:20:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LMRpn5kcOYrLA--.7742S5;
        Tue, 06 Jun 2023 11:20:52 +0800 (CST)
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
Subject: [RFC PATCH bpf-next v4 1/3] bpf: Factor out a common helper free_all()
Date:   Tue,  6 Jun 2023 11:53:08 +0800
Message-Id: <20230606035310.4026145-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230606035310.4026145-1-houtao@huaweicloud.com>
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LMRpn5kcOYrLA--.7742S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW3CrW5ZrW5Aw1DuF1fCrg_yoW5Ww1UpF
        y3Gry8JF4kZFsrua1xtrn7uwn8Xr1Fqa43K3yUu34Fkr13Zw1DtFZ2kr1IgFy5urW8tw43
        ArnYgF1xCr48JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Factor out a common helper free_all() to free all normal elements or
per-cpu elements on a lock-less list.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 410637c225fb..0668bcd7c926 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -211,9 +211,9 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	mem_cgroup_put(memcg);
 }
 
-static void free_one(struct bpf_mem_cache *c, void *obj)
+static void free_one(void *obj, bool percpu)
 {
-	if (c->percpu_size) {
+	if (percpu) {
 		free_percpu(((void **)obj)[1]);
 		kfree(obj);
 		return;
@@ -222,14 +222,19 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
 	kfree(obj);
 }
 
-static void __free_rcu(struct rcu_head *head)
+static void free_all(struct llist_node *llnode, bool percpu)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
-	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
 	struct llist_node *pos, *t;
 
 	llist_for_each_safe(pos, t, llnode)
-		free_one(c, pos);
+		free_one(pos, percpu);
+}
+
+static void __free_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+
+	free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
 	atomic_set(&c->call_rcu_in_progress, 0);
 }
 
@@ -432,7 +437,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	bool percpu = !!c->percpu_size;
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
@@ -441,14 +446,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist))
-		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist_extra))
-		free_one(c, llnode);
+	free_all(__llist_del_all(&c->free_by_rcu), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	free_all(__llist_del_all(&c->free_llist), percpu);
+	free_all(__llist_del_all(&c->free_llist_extra), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
-- 
2.29.2

