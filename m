Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6A0EB64DD
	for <rcu@archiver.kernel.org>; Sat, 24 Jun 2023 07:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjFXHyO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 24 Jun 2023 03:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjFXHyJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 24 Jun 2023 03:54:09 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D193294B;
        Sat, 24 Jun 2023 00:53:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qp5vn1TBjz4f3m8V;
        Sat, 24 Jun 2023 15:53:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDHJyICoZZke6P2Lg--.39952S2;
        Sat, 24 Jun 2023 15:53:42 +0800 (CST)
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
Message-ID: <019fe889-34c1-04eb-31a7-50b3cd40b83c@huaweicloud.com>
Date:   Sat, 24 Jun 2023 15:53:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230624031333.96597-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDHJyICoZZke6P2Lg--.39952S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWUGF1rGw4fGr15trWxXrb_yoW8CF1rpF
        W5GryUGryrJF1fZ34kJanaywn7Zr4fXw1agayrur9Fkr43Xr4FqF9Fkr1Uur93Cw4xCw1S
        vr48Wr9rG3y0vFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
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
>
SNIP
> +static void check_free_by_rcu(struct bpf_mem_cache *c)
> +{
> +	struct llist_node *llnode, *t;
> +
> +	if (llist_empty(&c->free_by_rcu) && llist_empty(&c->free_llist_extra_rcu))
> +		return;
> +
> +	/* drain free_llist_extra_rcu */
> +	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra_rcu))
> +		if (__llist_add(llnode, &c->free_by_rcu))
> +			c->free_by_rcu_tail = llnode;

Just like add_obj_to_free_list(),  we should do conditional
local_irq_save(flags) and local_inc_return(&c->active) as well for
free_by_rcu, otherwise free_by_rcu may be corrupted by bpf program
running in a NMI context.
> +
> +	if (atomic_xchg(&c->call_rcu_in_progress, 1)) {
> +		/*
> +		 * Instead of kmalloc-ing new rcu_head and triggering 10k
> +		 * call_rcu() to hit rcutree.qhimark and force RCU to notice
> +		 * the overload just ask RCU to hurry up. There could be many
> +		 * objects in free_by_rcu list.
> +		 * This hint reduces memory consumption for an artifical
> +		 * benchmark from 2 Gbyte to 150 Mbyte.
> +		 */
> +		rcu_request_urgent_qs_task(current);
> +		return;
> +	}
> +
> +	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
> +
> +	WRITE_ONCE(c->waiting_for_gp.first, __llist_del_all(&c->free_by_rcu));
> +	c->waiting_for_gp_tail = c->free_by_rcu_tail;
> +	call_rcu_hurry(&c->rcu, __free_by_rcu);

The same protection is needed for c->free_by_rcu_tail as well.

