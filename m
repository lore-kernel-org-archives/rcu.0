Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B393EB64D7
	for <rcu@archiver.kernel.org>; Thu, 29 Jun 2023 02:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjF2CYf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jun 2023 22:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjF2CYf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jun 2023 22:24:35 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8232684;
        Wed, 28 Jun 2023 19:24:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs2Mc5XCnz4f3lX7;
        Thu, 29 Jun 2023 10:24:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgAH7QpZ65xk_a9cLw--.61696S2;
        Thu, 29 Jun 2023 10:24:29 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH v3 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
        andrii@kernel.org, void@manifault.com, paulmck@kernel.org
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-13-alexei.starovoitov@gmail.com>
Message-ID: <57ceda87-e882-54b0-057a-2767c4395122@huaweicloud.com>
Date:   Thu, 29 Jun 2023 10:24:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230628015634.33193-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgAH7QpZ65xk_a9cLw--.61696S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4fuFWrCF4DAr1DJr4fKrg_yoW5CF45pF
        WxJryDGryUAF4Sy34qqr48JFZ7Ar4jqa47Gay8XF9xtr15X34YqFyxuryjgFyfAw48C343
        tr1q9ryxZr4UZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 6/28/2023 9:56 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
> objects into free_by_rcu_ttrace list where they are waiting for RCU
> task trace grace period to be freed into slab.
>
> The life cycle of objects:
> alloc: dequeue free_llist
> free: enqeueu free_llist
> free_rcu: enqueue free_by_rcu -> waiting_for_gp
> free_llist above high watermark -> free_by_rcu_ttrace
> after RCU GP waiting_for_gp -> free_by_rcu_ttrace
> free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
SNIP
>  
> +static void __free_by_rcu(struct rcu_head *head)
> +{
> +	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> +	struct bpf_mem_cache *tgt = c->tgt;
> +	struct llist_node *llnode;
> +
> +	llnode = llist_del_all(&c->waiting_for_gp);
> +	if (!llnode)
> +		goto out;
> +
> +	llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu_ttrace);
> +
> +	/* Objects went through regular RCU GP. Send them to RCU tasks trace */
> +	do_call_rcu_ttrace(tgt);

I still got report about leaked free_by_rcu_ttrace without adding any
extra hack except using bpf_mem_cache_free_rcu() in htab.

When bpf ma is freed through free_mem_alloc(), the following sequence
may lead to leak of free_by_rcu_ttrace:

P1: bpf_mem_alloc_destroy()
    P2: __free_by_rcu()

    // got false
    P2: read c->draining

P1: c->draining = true
P1: llist_del_all(&c->free_by_rcu_ttrace)

    // add to free_by_rcu_ttrace again
    P2: llist_add_batch(..., &tgt->free_by_rcu_ttrace)
        P2: do_call_rcu_ttrace()
            // call_rcu_ttrace_in_progress is 1, so xchg return 1
            // and it doesn't being moved to waiting_for_gp_ttrace
            P2: atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)

// got 1
P1: atomic_read(&c->call_rcu_ttrace_in_progress)
// objects in free_by_rcu_ttrace is leaked

I think the race could be fixed by checking c->draining in
do_call_rcu_ttrace() when atomic_xchg() returns 1 as shown below:

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 2bdb894392c5..9f41025560bd 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -303,8 +303,13 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
        struct llist_node *llnode, *t;

-       if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1))
+       if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
+               if (READ_ONCE(c->draining)) {
+                       llnode = llist_del_all(&c->free_by_rcu_ttrace);
+                       free_all(llnode, !!c->percpu_size);
+               }
                return;
+       }

