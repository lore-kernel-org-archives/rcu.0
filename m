Return-Path: <SRS0=P+IJ=VJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7EBC742CA
	for <rcu@archiver.kernel.org>; Fri, 12 Jul 2019 15:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78AA21019
	for <rcu@archiver.kernel.org>; Fri, 12 Jul 2019 15:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d3vjeUDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfGLPeg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:34:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43681 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfGLPeg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jul 2019 11:34:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so4458729pfg.10
        for <rcu@vger.kernel.org>; Fri, 12 Jul 2019 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=plTISl7XRgKbWO6zw1c5j3WZeogtjYrXm6i/h/jyEdM=;
        b=d3vjeUDpa24Uc8U/u+S+d6BI2l6i7lglR9JIxg0XBVZioQ6X8zajrBKL90Iwon+bp0
         Us06yFpgUdXGq/Y8vA3j3OHHbl3hebXZ3RDMsWe4b6rrkItzStgF0An8jIkP/Tl8h/OT
         U/725+NKgUVLfEW1GmKhZefiD3RdoW+j1XQv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=plTISl7XRgKbWO6zw1c5j3WZeogtjYrXm6i/h/jyEdM=;
        b=FJCu7wJvFnGUiFamKofqHpF/3tR5FQdDvFbM8HaIjR7j7967b9CoALiGToPPpuInnE
         UxowJ1l4KpyZVw9Z8r188cU0Gx/0SoBYcWDdFSVe3cMV2EKxxUfuOJcJ2DHtyy1//kcz
         oHfz8xN8YFUtzAdWi/ftlgnBnpxzLod0W0fOW+jLCYV0ynuIIbXQ2L0vOPQQpMYdTJQ+
         B9PZ/M2pIg+KkVszlqOI3+APJLj7R1TzAnxooscpJ/GlevJ4MQJrSEQonvQbE/NmR0lO
         wo6rlwatxo4XQRdg8Vqn7X+RhNZ7f9in/1a+7aSR0ZtSXwWAkLbhjcNym0zNK9XZq1LF
         nShQ==
X-Gm-Message-State: APjAAAV6QOtlRAcy2l63edfcxPBHMnGF9YRkLioJT6S8k0dcO5UbYVez
        NjYFGRa/TQJ3DGR2Z+sw3aE=
X-Google-Smtp-Source: APXvYqwX2szxRvImPGUWPwCBB9Zx7iRJ2PX+9w9TRedou4r8JruFvsQRPwg13cuKgQnds8hoTD6mug==
X-Received: by 2002:a63:da52:: with SMTP id l18mr11572275pgj.131.1562945674764;
        Fri, 12 Jul 2019 08:34:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 1sm9736153pfe.102.2019.07.12.08.34.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 08:34:34 -0700 (PDT)
Date:   Fri, 12 Jul 2019 11:34:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@ozlabs.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH] treewide: Rename  rcu_dereference_raw_notrace to _check
Message-ID: <20190712153432.GC235410@google.com>
References: <20190711204541.28940-1-joel@joelfernandes.org>
 <20190712150107.GT26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712150107.GT26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 12, 2019 at 08:01:07AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 11, 2019 at 04:45:41PM -0400, Joel Fernandes (Google) wrote:
> > The rcu_dereference_raw_notrace() API name is confusing.
> > It is equivalent to rcu_dereference_raw() except that it also does
> > sparse pointer checking.
> > 
> > There are only a few users of rcu_dereference_raw_notrace(). This
> > patches renames all of them to be rcu_dereference_raw_check with the
> > "check" indicating sparse checking.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I queued this, but reworked the commit log and fixed a couple of
> irritating checkpatch issues that were in the original code.
> Does this work for you?

Thanks, yes it looks good to me.

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit bd5c0fea6016c90cf7a9eb0435cd0c373dfdac2f
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Thu Jul 11 16:45:41 2019 -0400
> 
>     treewide: Rename rcu_dereference_raw_notrace() to _check()
>     
>     The rcu_dereference_raw_notrace() API name is confusing.  It is equivalent
>     to rcu_dereference_raw() except that it also does sparse pointer checking.
>     
>     There are only a few users of rcu_dereference_raw_notrace(). This patches
>     renames all of them to be rcu_dereference_raw_check() with the "_check()"
>     indicating sparse checking.
>     
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     [ paulmck: Fix checkpatch warnings about parentheses. ]
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
> index f04c467e55c5..467251f7fef6 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.html
> +++ b/Documentation/RCU/Design/Requirements/Requirements.html
> @@ -2514,7 +2514,7 @@ disabled across the entire RCU read-side critical section.
>  <p>
>  It is possible to use tracing on RCU code, but tracing itself
>  uses RCU.
> -For this reason, <tt>rcu_dereference_raw_notrace()</tt>
> +For this reason, <tt>rcu_dereference_raw_check()</tt>
>  is provided for use by tracing, which avoids the destructive
>  recursion that could otherwise ensue.
>  This API is also used by virtualization in some architectures,
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
> index 21b1ed5df888..53388a311967 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -546,7 +546,7 @@ static inline void note_hpte_modification(struct kvm *kvm,
>   */
>  static inline struct kvm_memslots *kvm_memslots_raw(struct kvm *kvm)
>  {
> -	return rcu_dereference_raw_notrace(kvm->memslots[0]);
> +	return rcu_dereference_raw_check(kvm->memslots[0]);
>  }
>  
>  extern void kvmppc_mmu_debugfs_init(struct kvm *kvm);
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index e91ec9ddcd30..932296144131 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -622,7 +622,7 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
>   * as long as the traversal is guarded by rcu_read_lock().
>   */
>  #define hlist_for_each_entry_rcu(pos, head, member)			\
> -	for (pos = hlist_entry_safe (rcu_dereference_raw(hlist_first_rcu(head)),\
> +	for (pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
>  			typeof(*(pos)), member);			\
>  		pos;							\
>  		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
> @@ -642,10 +642,10 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
>   * not do any RCU debugging or tracing.
>   */
>  #define hlist_for_each_entry_rcu_notrace(pos, head, member)			\
> -	for (pos = hlist_entry_safe (rcu_dereference_raw_notrace(hlist_first_rcu(head)),\
> +	for (pos = hlist_entry_safe(rcu_dereference_raw_check(hlist_first_rcu(head)),\
>  			typeof(*(pos)), member);			\
>  		pos;							\
> -		pos = hlist_entry_safe(rcu_dereference_raw_notrace(hlist_next_rcu(\
> +		pos = hlist_entry_safe(rcu_dereference_raw_check(hlist_next_rcu(\
>  			&(pos)->member)), typeof(*(pos)), member))
>  
>  /**
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 0c9b92799abc..e5161e377ad4 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -478,7 +478,7 @@ do {									      \
>   * The no-tracing version of rcu_dereference_raw() must not call
>   * rcu_read_lock_held().
>   */
> -#define rcu_dereference_raw_notrace(p) __rcu_dereference_check((p), 1, __rcu)
> +#define rcu_dereference_raw_check(p) __rcu_dereference_check((p), 1, __rcu)
>  
>  /**
>   * rcu_dereference_protected() - fetch RCU pointer when updates prevented
> diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
> index 0515a2096f90..0456e0a3dab1 100644
> --- a/kernel/trace/ftrace_internal.h
> +++ b/kernel/trace/ftrace_internal.h
> @@ -6,22 +6,22 @@
>  
>  /*
>   * Traverse the ftrace_global_list, invoking all entries.  The reason that we
> - * can use rcu_dereference_raw_notrace() is that elements removed from this list
> + * can use rcu_dereference_raw_check() is that elements removed from this list
>   * are simply leaked, so there is no need to interact with a grace-period
> - * mechanism.  The rcu_dereference_raw_notrace() calls are needed to handle
> + * mechanism.  The rcu_dereference_raw_check() calls are needed to handle
>   * concurrent insertions into the ftrace_global_list.
>   *
>   * Silly Alpha and silly pointer-speculation compiler optimizations!
>   */
>  #define do_for_each_ftrace_op(op, list)			\
> -	op = rcu_dereference_raw_notrace(list);			\
> +	op = rcu_dereference_raw_check(list);			\
>  	do
>  
>  /*
>   * Optimized for just a single item in the list (as that is the normal case).
>   */
>  #define while_for_each_ftrace_op(op)				\
> -	while (likely(op = rcu_dereference_raw_notrace((op)->next)) &&	\
> +	while (likely(op = rcu_dereference_raw_check((op)->next)) &&	\
>  	       unlikely((op) != &ftrace_list_end))
>  
>  extern struct ftrace_ops __rcu *ftrace_ops_list;
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2c92b3d9ea30..1d69110d9e5b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2642,10 +2642,10 @@ static void ftrace_exports(struct ring_buffer_event *event)
>  
>  	preempt_disable_notrace();
>  
> -	export = rcu_dereference_raw_notrace(ftrace_exports_list);
> +	export = rcu_dereference_raw_check(ftrace_exports_list);
>  	while (export) {
>  		trace_process_export(export, event);
> -		export = rcu_dereference_raw_notrace(export->next);
> +		export = rcu_dereference_raw_check(export->next);
>  	}
>  
>  	preempt_enable_notrace();
