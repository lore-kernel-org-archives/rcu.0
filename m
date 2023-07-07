Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F2DEB64DC
	for <rcu@archiver.kernel.org>; Fri,  7 Jul 2023 02:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjGGCHX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Jul 2023 22:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGGCHW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Jul 2023 22:07:22 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A7B1FD7;
        Thu,  6 Jul 2023 19:07:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qxxby1rwLz4f3mnF;
        Fri,  7 Jul 2023 10:07:10 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgBXshxKc6dkK7inMg--.21589S2;
        Fri, 07 Jul 2023 10:07:10 +0800 (CST)
Subject: Re: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
        andrii@kernel.org, void@manifault.com, paulmck@kernel.org
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-10-alexei.starovoitov@gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <fe733a7b-3775-947a-23c0-0dadacabdca2@huaweicloud.com>
Date:   Fri, 7 Jul 2023 10:07:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230706033447.54696-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgBXshxKc6dkK7inMg--.21589S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fJFy8Cryrtw48GFW3KFg_yoW8ZrW5pF
        4fGF1UJr1FvFW2va42gw4xCFZ5Xw4xta42gay2934Skr45Z34qqrWfGry5ur1ay3ySyrWa
        yrnY9Fn7ta1Uu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> alloc_bulk() can reuse elements from free_by_rcu_ttrace.
> Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary kmalloc().
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/memalloc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 9986c6b7df4d..e5a87f6cf2cc 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -212,6 +212,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>  	if (i >= cnt)
>  		return;
>  
> +	for (; i < cnt; i++) {
> +		obj = llist_del_first(&c->waiting_for_gp_ttrace);
> +		if (!obj)
> +			break;
> +		add_obj_to_free_list(c, obj);
> +	}
> +	if (i >= cnt)
> +		return;

I still think using llist_del_first() here is not safe as reported in
[1]. Not sure whether or not invoking enque_to_free() firstly for
free_llist_extra will close the race completely. Will check later.

[1]:
https://lore.kernel.org/rcu/957dd5cd-0855-1197-7045-4cb1590bd753@huaweicloud.com/
> +
>  	memcg = get_memcg(c);
>  	old_memcg = set_active_memcg(memcg);
>  	for (; i < cnt; i++) {
> @@ -295,12 +304,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  
>  	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
>  	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
> -		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
> -		 * It doesn't race with llist_del_all either.
> -		 * But there could be two concurrent llist_del_all(waiting_for_gp_ttrace):
> -		 * from __free_rcu() and from drain_mem_cache().
> -		 */
> -		__llist_add(llnode, &c->waiting_for_gp_ttrace);
> +		llist_add(llnode, &c->waiting_for_gp_ttrace);
>  
>  	if (unlikely(READ_ONCE(c->draining))) {
>  		__free_rcu(&c->rcu_ttrace);



