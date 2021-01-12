Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E50C433DB
	for <rcu@archiver.kernel.org>; Tue, 12 Jan 2021 18:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0482311D
	for <rcu@archiver.kernel.org>; Tue, 12 Jan 2021 18:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhALSIJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Jan 2021 13:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbhALSIJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Jan 2021 13:08:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E22F23123;
        Tue, 12 Jan 2021 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610474848;
        bh=yTAFqpXc+Md+lF+Ff90z1cw5WULdZyRpwhilKe7mroo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eVTzdC5dHvxyeFAsOHzcYfLlEfr5ump//qt35UpwE0yuwP/rohxdwtkbTapQ5B2kS
         Pm8PEpy7hZSqt8NdNv0T96XenBohiHqq1WqCC3VokLtsm8qwbHWSxMho0AU3H/1JXd
         A2XorXAtQQ1gAb9VJx94b/Ium2bpJInph1WQs+/cY12toeDTtXj/Z6DQP33Pyi5XEn
         T8TXBAo508UAblODSS18GTV9WIbkd48xMoiwZLXGGMDVwLyFa5Bs5UVa68RSojLAvJ
         KpsqgcAmR9/V9F5TUsYvjG2jS9UowrvCa9qnZehWlmnBmeZ8wH9nntL7/Or8nO9S1U
         F/xIlCY1jIrCA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1E8C33522AC3; Tue, 12 Jan 2021 10:07:28 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:07:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     rcu@vger.kernel.org
Subject: Re: [bug report] EXP rcuscale: Add crude tests for mem_dump_obj()
Message-ID: <20210112180728.GJ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <X/21KmJ1+jW+PJjC@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/21KmJ1+jW+PJjC@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 12, 2021 at 05:41:46PM +0300, Dan Carpenter wrote:
> Hello Paul E. McKenney,
> 
> The patch b3a539cc4d37: "EXP rcuscale: Add crude tests for
> mem_dump_obj()" from Dec 7, 2020, leads to the following static
> checker warning:
> 
> 	kernel/rcu/rcutorture.c:1888 rcu_torture_stats()
> 	warn: did you mean to pass the address of 'rhp'
> 
> kernel/rcu/rcutorture.c
>   1865          {
>   1866                  struct rcu_head *rhp;
>   1867                  struct kmem_cache *kcp;
>   1868                  static int z;
>   1869  
>   1870                  kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
>   1871                  rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
>   1872                  pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
>                                                                                                                                      ^^^^
> Hopefully the address of rhp doesn't change at all in this function 0_0!

One would hope!

The duplication makes it easier to check the output.  Without it,
it is necessary to get some information from the immediately preceding
pr_alert() and others of it from the first pr_alert().

							Thanx, Paul

>   1873                  pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
>   1874                  mem_dump_obj(ZERO_SIZE_PTR);
>   1875                  pr_alert("mem_dump_obj(NULL):");
>   1876                  mem_dump_obj(NULL);
>   1877                  pr_alert("mem_dump_obj(%px):", &rhp);
>   1878                  mem_dump_obj(&rhp);
>   1879                  pr_alert("mem_dump_obj(%px):", rhp);
>   1880                  mem_dump_obj(rhp);
>   1881                  pr_alert("mem_dump_obj(%px):", &rhp->func);
>   1882                  mem_dump_obj(&rhp->func);
>   1883                  pr_alert("mem_dump_obj(%px):", &z);
>   1884                  mem_dump_obj(&z);
>   1885                  kmem_cache_free(kcp, rhp);
>   1886                  kmem_cache_destroy(kcp);
>   1887                  rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
>   1888                  pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
>   1889                  pr_alert("mem_dump_obj(kmalloc %px):", rhp);
>   1890                  mem_dump_obj(rhp);
>   1891                  pr_alert("mem_dump_obj(kmalloc %px):", &rhp->func);
>   1892                  mem_dump_obj(&rhp->func);
>   1893                  kfree(rhp);
>   1894                  rhp = vmalloc(4096);
>   1895                  pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
>   1896                  pr_alert("mem_dump_obj(vmalloc %px):", rhp);
>   1897                  mem_dump_obj(rhp);
>   1898                  pr_alert("mem_dump_obj(vmalloc %px):", &rhp->func);
>   1899                  mem_dump_obj(&rhp->func);
>   1900                  vfree(rhp);
>   1901          }
> 
> regards,
> dan carpenter
