Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B55C433F5
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 14:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349888AbhKXPBR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhKXPBQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 10:01:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6536260C3F;
        Wed, 24 Nov 2021 14:58:05 +0000 (UTC)
Date:   Wed, 24 Nov 2021 09:58:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 5/9] x86/mm: Switch to kvfree_rcu() API
Message-ID: <20211124095803.2702bc89@gandalf.local.home>
In-Reply-To: <20211124110308.2053-6-urezki@gmail.com>
References: <20211124110308.2053-1-urezki@gmail.com>
        <20211124110308.2053-6-urezki@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 24 Nov 2021 12:03:04 +0100
"Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
> index 933a2ebad471..e75137a06c32 100644
> --- a/arch/x86/mm/mmio-mod.c
> +++ b/arch/x86/mm/mmio-mod.c
> @@ -307,10 +307,8 @@ static void iounmap_trace_core(volatile void __iomem *addr)
>  
>  not_enabled:
>  	spin_unlock_irq(&trace_lock);
> -	if (found_trace) {
> -		synchronize_rcu(); /* unregister_kmmio_probe() requirement */
> -		kfree(found_trace);
> -	}
> +	if (found_trace)
> +		kvfree_rcu(found_trace); /* unregister_kmmio_probe() requirement */
>  }
>  

This is the first I've seen kvfree_rcu() (that I actually noticed/remember,
I'm sure I probably was Cc'd on some patches). And I find the comment
around it very confusing:

Specifically:


 *     kvfree_rcu(ptr);
 *
 * where @ptr is a pointer to kvfree().

The above suggests that you should pass a pointer to the actual function
kvfree to kvfree_rcu(), which is not what I believe is to be done.

  i.e.  kvfree_rcu(kvfree) ???

Perhaps rewrite that to say:

 * where @ptr is the pointer to be freed by kvfree().

?

Other than that, the patch looks fine to me.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
