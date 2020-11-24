Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ADDC2D0E4
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 19:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0048208FE
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 19:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVXOuOVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgKXTzw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbgKXTzw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Nov 2020 14:55:52 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974DB208DB;
        Tue, 24 Nov 2020 19:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606247751;
        bh=QWJMRYst4kE9lGBPVgMbOCT9k/Qf7AupdsfaOxljRBo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fVXOuOVf9LmNcZYiZRqscO4BcbOYgVdT5AWB0jzjMODpdrzJLHyUoePPsLtEEVrKY
         aC1SyUz6rXVQVSRiWW/hyy607udJ5203hvV121fKtutue0sc5ZqtF9ToFzf1ZXOvSB
         p7C3aOl2Fw+0kT4JDIVDYP3CDLpFuyTB/uYYK97M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3B75C352265F; Tue, 24 Nov 2020 11:55:51 -0800 (PST)
Date:   Tue, 24 Nov 2020 11:55:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] rcu: eliminate the __kvfree_rcu() macro
Message-ID: <20201124195551.GL1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201120114917.5263-1-urezki@gmail.com>
 <20201120114917.5263-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120114917.5263-2-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 12:49:17PM +0100, Uladzislau Rezki (Sony) wrote:
> Make the kvfree_rcu_arg_2() to be open-coded, so readability
> and review look better from the first glance. Moreover, that
> makes it clear that both kvfree_rcu_arg_1/2() use one single
> interface.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

I queued both with the usual editing, thank you!

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index b1e75648d402..6d56dd7e6a30 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -842,15 +842,6 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>   */
>  #define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
>  
> -/*
> - * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
> - */
> -#define __kvfree_rcu(head, offset) \
> -	do { \
> -		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
> -		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
> -	} while (0)
> -
>  /**
>   * kfree_rcu() - kfree an object after a grace period.
>   * @ptr: pointer to kfree(both for single argument and double one)
> @@ -868,7 +859,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>   * Because the functions are not allowed in the low-order 4096 bytes of
>   * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
>   * If the offset is larger than 4095 bytes, a compile-time error will
> - * be generated in __kvfree_rcu(). If this error is triggered, you can
> + * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
>   * either fall back to use of call_rcu() or rearrange the structure to
>   * position the rcu_head structure into the first 4096 bytes.
>   *
> @@ -914,8 +905,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  do {									\
>  	typeof (ptr) ___p = (ptr);					\
>  									\
> -	if (___p)							\
> -		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> +	if (___p) {									\
> +		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
> +		kvfree_call_rcu(&((___p)->rhf), (rcu_callback_t)(unsigned long)		\
> +			(offsetof(typeof(*(ptr)), rhf)));				\
> +	}										\
>  } while (0)
>  
>  #define kvfree_rcu_arg_1(ptr)					\
> -- 
> 2.20.1
> 
