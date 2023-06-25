Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EE9EB64DC
	for <rcu@archiver.kernel.org>; Sun, 25 Jun 2023 11:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFYLPg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 25 Jun 2023 07:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFYLPf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 25 Jun 2023 07:15:35 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306F88F;
        Sun, 25 Jun 2023 04:15:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QppLB0q0mz4f41wG;
        Sun, 25 Jun 2023 19:15:30 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgA3yDLPIZhkZbNJLw--.20709S2;
        Sun, 25 Jun 2023 19:15:30 +0800 (CST)
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
Message-ID: <bfb3cbff-2837-156c-c240-5cf0a046ed38@huaweicloud.com>
Date:   Sun, 25 Jun 2023 19:15:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230624031333.96597-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgA3yDLPIZhkZbNJLw--.20709S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWUGF1rXryrKF47Gr47CFg_yoW8JFW5pF
        Wxtr1kJFWrAF48K3WfXw4xAaykAw4Fqr13Ka48Wryj9Fyrtr90vFsrZry5ur1F9395Zasr
        ZrsIkrnxAw1qqa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
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
SNIP
>  
>  static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
> @@ -498,8 +566,8 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
>  
>  static void free_mem_alloc(struct bpf_mem_alloc *ma)
>  {
> -	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
> -	 * still execute. Wait for it now before we freeing percpu caches.
> +	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
> +	 * might still execute. Wait for them.
>  	 *
>  	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
>  	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
I think an extra rcu_barrier() before rcu_barrier_tasks_trace() is still
needed here, otherwise free_mem_alloc will not wait for inflight
__free_by_rcu() and there will oops in rcu_do_batch().

