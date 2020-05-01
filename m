Return-Path: <SRS0=yzHE=6P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADBEC47256
	for <rcu@archiver.kernel.org>; Fri,  1 May 2020 23:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D3921775
	for <rcu@archiver.kernel.org>; Fri,  1 May 2020 23:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588374053;
	bh=/VNzG6AkJ+SF4n242b/HlctCnNZjDVdY4zeOfMiCbSU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=2haH6M7xYm5VuuKZOpmirK1d+alLKrbZLU//FOOcPqyGRqHTXWgtHj9rqfL/p1eGJ
	 nlieEC+UgdLWPYPo5a9WEGgJtlL/Xi61PPtTGL2bjZ4XdSql/nnfjLnEpgl1s3G2i0
	 qdoBL9N6/vpeGJxFpEUidsdZP80R1YmXgNj5lI8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgEAXAx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 May 2020 19:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAXAx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 May 2020 19:00:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA22216FD;
        Fri,  1 May 2020 23:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588374052;
        bh=/VNzG6AkJ+SF4n242b/HlctCnNZjDVdY4zeOfMiCbSU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lWrP9NNeusUD0yK9zSglDcn3WrvF77Ru32i29rUQ2BVDLrenBfrSi+BLTAoOvlqFY
         ile7EkxM6bBouE8PxX60i/1rjJHagdEwEHZSiioF25nNFWwgHe0NGZolGZkdbD0CQK
         G+Llt52Ga4lVM7soTlu9h3lLGFZwPvWFqKd+szZw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 310B83522B72; Fri,  1 May 2020 16:00:52 -0700 (PDT)
Date:   Fri, 1 May 2020 16:00:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 20/24] rcu/tree: Make kvfree_rcu() tolerate any alignment
Message-ID: <20200501230052.GG7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-21-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428205903.61704-21-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 28, 2020 at 10:58:59PM +0200, Uladzislau Rezki (Sony) wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> Handle cases where the the object being kvfree_rcu()'d is not aligned by
> 2-byte boundaries.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 501cac02146d..649bad7ad0f0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2877,6 +2877,9 @@ struct kvfree_rcu_bulk_data {
>  #define KVFREE_BULK_MAX_ENTR \
>  	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
>  
> +/* Encoding the offset of a fake rcu_head to indicate the head is a wrapper. */
> +#define RCU_HEADLESS_KFREE BIT(31)

Did I miss the check for freeing something larger than 2GB?  Or is this
impossible, even on systems with many terabytes of physical memory?
Even if it is currently impossible, what prevents it from suddenly
becoming all too possible at some random point in the future?  If you
think that this will never happen, please keep in mind that the first
time I heard "640K ought to be enough for anybody", it sounded eminently
reasonable to me.

Besides...

Isn't the offset in question the offset of an rcu_head struct within
the enclosing structure?  If so, why not keep the current requirement
that this be at least 16-bit aligned, especially given that some work
is required to make that alignment less than pointer sized?  Then you
can continue using bit 0.

This alignment requirement is included in the RCU requirements
documentation and is enforced within the __call_rcu() function.

So let's leave this at bit 0.

							Thanx, Paul

>  /**
>   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
>   * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
> @@ -3078,9 +3081,9 @@ static void kfree_rcu_work(struct work_struct *work)
>  		next = head->next;
>  
>  		/* We tag the headless object, if so adjust offset. */
> -		headless = (((unsigned long) head - offset) & BIT(0));
> +		headless = !!(offset & RCU_HEADLESS_KFREE);
>  		if (headless)
> -			offset -= 1;
> +			offset &= ~(RCU_HEADLESS_KFREE);
>  
>  		ptr = (void *) head - offset;
>  
> @@ -3356,7 +3359,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  			 * that has to be freed as well as dynamically
>  			 * attached wrapper/head.
>  			 */
> -			func = (rcu_callback_t) (sizeof(unsigned long *) + 1);
> +			func = (rcu_callback_t)(sizeof(unsigned long *) | RCU_HEADLESS_KFREE);
>  		}
>  
>  		head->func = func;
> -- 
> 2.20.1
> 
