Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD35EB64DA
	for <rcu@archiver.kernel.org>; Sat, 24 Jun 2023 09:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjFXJFb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 24 Jun 2023 05:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjFXJFa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 24 Jun 2023 05:05:30 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C5A19B;
        Sat, 24 Jun 2023 02:05:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qp7VV65WKz4f3tNr;
        Sat, 24 Jun 2023 17:05:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgDXzhzPsZZkEU0JLg--.18410S2;
        Sat, 24 Jun 2023 17:05:23 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-13-alexei.starovoitov@gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <b002f2c3-7a5b-591c-8aa1-75b4dbedcf23@huaweicloud.com>
Date:   Sat, 24 Jun 2023 17:05:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230624031333.96597-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgDXzhzPsZZkEU0JLg--.18410S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW3tF1kJr48GF1DGFyUJrb_yoW7XFyUpF
        48Jr1DJryUAF4IyrnrJr1UJ348Ar1jq34UJ348JFnxtr15G34jgF12gr1jgF1rGr48A343
        tr1DZr1UZr1UZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
> objects into free_by_rcu_ttrace list where they are waiting for RCU
> task trace grace period to be freed into slab.
SNIP
> +static void __free_by_rcu(struct rcu_head *head)
> +{
> +	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> +	struct bpf_mem_cache *tgt = c->tgt;
> +	struct llist_node *llnode;
> +
> +	if (unlikely(READ_ONCE(c->draining)))
> +		goto out;
Because the reading of c->draining and list_add_batch(...,
free_by_rcu_ttrace) is lockless, so checking draining here could not
prevent the leak of objects in c->free_by_rcu_ttrace() as show below
(hope the formatting is OK now). A simple fix is to drain
free_by_rcu_ttrace twice as suggested before. Or checking c->draining
again in __free_by_rcu() when atomic_xchg() returns 1 and calling
free_all(free_by_rcu_ttrace) if draining is true.

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

c->draining also can't guarantee bpf_mem_alloc_destroy() will wait for
the inflight call_rcu_tasks_trace() callback as shown in the following
two cases (these two cases are the same as reported in v1 and I only
reformatted these two diagrams). And I suggest to do
bpf_mem_alloc_destroy as follows:

        if (ma->cache) {
                rcu_in_progress = 0;
                for_each_possible_cpu(cpu) {
                        c = per_cpu_ptr(ma->cache, cpu);
                        irq_work_sync(&c->refill_work);
                        drain_mem_cache(c);
                        rcu_in_progress +=
atomic_read(&c->call_rcu_in_progress);
                }
                for_each_possible_cpu(cpu) {
                        c = per_cpu_ptr(ma->cache, cpu);
                        rcu_in_progress +=
atomic_read(&c->call_rcu_ttrace_in_progress);
                }


Case 1:

P1: bpf_mem_alloc_destroy()
            P2: __free_by_rcu()

            // got false
            P2: c->draining
P1: c->draining = true

// got 0
P1: atomic_read(&c->call_rcu_ttrace_in_progress)

            P2: do_call_rcu_ttrace()
                // return 0
                P2: atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)
                P2: call_rcu_tasks_trace()
            P2: atomic_set(&c->call_rcu_in_progress, 0)

// also got 0
P1: atomic_read(&c->call_rcu_in_progress)
// won't wait for the inflight __free_rcu_tasks_trace

Case 2:

P1: bpf_mem_alloc_destroy
                P2: __free_by_rcu for c1

                P2: read c1->draing
P1: c0->draining = true
P1: c1->draining = true

// both of in_progress counter is 0
P1: read c0->call_rcu_in_progress
P1: read c0->call_rcu_ttrace_in_progress

                // c1->tgt is c0
                // c1->call_rcu_in_progress is 1
                // c0->call_rcu_ttrace_in_progress is 0
                P2: llist_add_batch(..., c0->free_by_rcu_ttrace)
                P2: xchg(c0->call_rcu_ttrace_in_progress, 1)
                P2: call_rcu_tasks_trace(c0)
                P2: c1->call_rcu_in_progress = 0

// both of in_progress counter is 0
P1: read c1->call_rcu_in_progress
P1: read c1->call_rcu_ttrace_in_progress

// BAD! There is still inflight tasks trace RCU callback
P1: free_mem_alloc_no_barrier()

> +
> +	llnode = llist_del_all(&c->waiting_for_gp);
> +	if (!llnode)
> +		goto out;
> +
> +	if (llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu_ttrace))
> +		tgt->free_by_rcu_ttrace_tail = c->waiting_for_gp_tail;
> +
> +	/* Objects went through regular RCU GP. Send them to RCU tasks trace */
> +	do_call_rcu_ttrace(tgt);
> +out:
> +	atomic_set(&c->call_rcu_in_progress, 0);
> +}
> +

