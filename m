Return-Path: <SRS0=3e4L=6U=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F8C28CBC
	for <rcu@archiver.kernel.org>; Wed,  6 May 2020 18:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B335420735
	for <rcu@archiver.kernel.org>; Wed,  6 May 2020 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588790749;
	bh=gigegsw9Oj8TIYgU47530V44T98t2OPVL9trxrvvp2M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=E1v882vypZrnorKN1A1OK2cqJoUf960stvc8tYqmgMTLqbmJMxUr2WH5k0sOZfDPH
	 xuaNnf9QsMiXVT81ifp/UPfnRSo8ZmrGiylUSM/78hzQlhpEu+IpYlqzo14O+6UsWb
	 Mjj74rhaJgQKAkn4Ea9c2B+NHIwy+G/n7PQowY4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbgEFSpt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 May 2020 14:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbgEFSpt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 May 2020 14:45:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC2520708;
        Wed,  6 May 2020 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588790748;
        bh=gigegsw9Oj8TIYgU47530V44T98t2OPVL9trxrvvp2M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Zh8rGp7exfpuWXwr7XwnPrHVTETtgSr7bqT7m4Z/r7W2Mu+9R+/XZ/MMRN8wnwda1
         Xz3yfCschfOlBqh8qNPY7jUmpm6G0vwd+WAH1GIwtNlf4Oj0MF4Plqr9lM2OtG7qIA
         cUWfHS3O6z9mKxrdMz5sfCl9zGowQEHy0YVOs5nk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4457E352306C; Wed,  6 May 2020 11:45:48 -0700 (PDT)
Date:   Wed, 6 May 2020 11:45:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 21/24] rcu/tiny: move kvfree_call_rcu() out of header
Message-ID: <20200506184548.GE2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-22-urezki@gmail.com>
 <20200501230359.GH7560@paulmck-ThinkPad-P72>
 <20200506182902.GA2570@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506182902.GA2570@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 06, 2020 at 08:29:02PM +0200, Uladzislau Rezki wrote:
> Hello, Paul, Joel.
> 
> > > Move inlined kvfree_call_rcu() function out of the
> > > header file. This step is a preparation for head-less
> > > support.
> > > 
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  include/linux/rcutiny.h | 6 +-----
> > >  kernel/rcu/tiny.c       | 6 ++++++
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > index 0c6315c4a0fe..7eb66909ae1b 100644
> > > --- a/include/linux/rcutiny.h
> > > +++ b/include/linux/rcutiny.h
> > > @@ -34,11 +34,7 @@ static inline void synchronize_rcu_expedited(void)
> > >  	synchronize_rcu();
> > >  }
> > >  
> > > -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > -{
> > > -	call_rcu(head, func);
> > > -}
> > > -
> > > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> > >  void rcu_qs(void);
> > >  
> > >  static inline void rcu_softirq_qs(void)
> > > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > > index aa897c3f2e92..508c82faa45c 100644
> > > --- a/kernel/rcu/tiny.c
> > > +++ b/kernel/rcu/tiny.c
> > > @@ -177,6 +177,12 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  }
> > >  EXPORT_SYMBOL_GPL(call_rcu);
> > >  
> > > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +{
> > > +	call_rcu(head, func);
> > > +}
> > > +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> > 
> > This increases the size of Tiny RCU.  Plus in Tiny RCU, the overhead of
> > synchronize_rcu() is exactly zero.  So why not make the single-argument
> > kvfree_call_rcu() just unconditionally do synchronize_rcu() followed by
> > kvfree() or whatever?  That should go just fine into the header file.
> > 
> Seems it does not go well if i do it in header file:
> 
> <snip>
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 0c6315c4a0fe..76b7ad053218 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -13,6 +13,7 @@
>  #define __LINUX_TINY_H
>  
>  #include <asm/param.h> /* for HZ */
> +#include <linux/mm.h>
>  
>  /* Never flag non-existent other CPUs! */
>  static inline bool rcu_eqs_special_set(int cpu) { return false; }
> @@ -36,7 +37,15 @@ static inline void synchronize_rcu_expedited(void)
>  
>  static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -       call_rcu(head, func);
> +       if (head) {
> +               call_rcu(head, func);
> +               return;
> +       }
> +
> +       // kvfree_rcu(one_arg) call.
> +       might_sleep();
> +       synchronize_rcu();
> +       kvfree((void *) func);
>  }
> <snip> 
> 
> kvfree() is defined in <linux/mm.h> as extern void kvfree(const void *addr); 
> If i just include <linux/mm.h> i get many errors related to "implicit declaration
> of function" like:
> 
> <snip>
> rcu_read_lock()
> compound_mapcount_ptr()
> rcu_assign_pointer()
> ...
> <snip>
> 
> and many other messages like:
> 
> <snip>
> warning: returning ‘int’ from a function with return type
> error: unknown type name ‘vm_fault_t’; did you mean ‘pmdval_t’?
> error: implicit declaration of function ‘RB_EMPTY_ROOT’
> ...
> <snip>
> 
> Please see full log here: ftp://vps418301.ovh.net/incoming/include_mm_h_output.txt
> 
> I can fix it by adding the kvfree() declaration to the rcutiny.h also:
> extern void kvfree(const void *addr);
> 
> what seems wired to me? Also it can be fixed if i move it to the tiny.c
> so it will be aligned with the way how it is done for tree-RCU.

If the mm guys are OK with the kvfree() declaration, that is the way
to go.  With the addition of a comment saying something like "Avoid
#include hell".

The compiler will complain if the definition changes given that there
has to be somewhere that sees both the above and the real declaration,
so this should not cause too much trouble.

> Any valuable proposals?

Otherwise, yes, the function would need to move to tiny.c and thus add
bloat.  :-(

							Thanx, Paul
