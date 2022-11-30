Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F1C4167B
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 03:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiK3DhC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Nov 2022 22:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiK3Dg7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Nov 2022 22:36:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314AA73B99
        for <rcu@vger.kernel.org>; Tue, 29 Nov 2022 19:36:58 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z17so10841435pff.1
        for <rcu@vger.kernel.org>; Tue, 29 Nov 2022 19:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QESocfV/jPJ3nevgOuf+fj4+H7y0Mt1/5gpvnK+JUI=;
        b=TxjB+VqLDovZNh2bOJNIjlKWhf8qb8Pl4nREyemYVs5NnKVuwyNU4ZXwQuI62Xx3Qt
         CxN0i4Nx5l8qWzOfp6bTX+n1oV9Zj9EKuP7MOiQ/csdPmfUgdLM4Q7Ove4bvHGjzFpEx
         EwIR//E9wIDFnDwcHAIr3FtjlaKGcq2/qIniBpH54076M2KUF9u+UfIyrHydtheS2tYE
         RCbKof1CrRzgDJE5XhGt0lfKdE0k+twLdNoCmSALxhl3f+FT08eRRVzqqCz3pEj50/k3
         u9mejFzzRevRig9Tsnpu453t5hVMAPtdHbXJrF8lKQ0OM9LlmqwfMeOT4C/+lUGC4hnF
         mJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QESocfV/jPJ3nevgOuf+fj4+H7y0Mt1/5gpvnK+JUI=;
        b=3I3ztJ7voWqmQfaAz3npI8OsRBMwUr1n0HPW8ub4tS92fDMemseeAcxRYeLOHqX0z0
         WN2Ex5D628mQMs7GrJZvP4MY/2Ndv2mRYCi2MQ83ggZY1s7soh20z/gNer2GRK3hve9N
         UnSRip+TOiySTWjHgs2Q7vn+VsCZL1SNDxr8i9IqieSVw+FFr9qDfPb5U7xzEAaXYgwm
         2sYnYEw2kYRwQi49t6n+Qr23ZIHcHwYREFUuA+fLs576Csf5zFkjKCbwFtykxeQN2LfU
         23zMAQ2z/qnzam03BFEDVLPQt5Jyrfbb8NweQ9gp+4K7bhE8uCd/HI9NUXi4vdf+zrIt
         poPw==
X-Gm-Message-State: ANoB5pl+ZUfPZh9z/ua2N9ZwFIpqV1lkM4kgOWIYsh7SkPk+PiN4aOne
        Vdv4GvSEkMZwKqWOEoqnMg==
X-Google-Smtp-Source: AA0mqf6q6yK65yW0AWhR9quxjiozNOGrzXJjRauP66Oki6+0CtQGqhk1puvJIOyYUObJgylyObi/Rg==
X-Received: by 2002:aa7:8250:0:b0:56b:fe1d:5735 with SMTP id e16-20020aa78250000000b0056bfe1d5735mr60371363pfn.24.1669779417645;
        Tue, 29 Nov 2022 19:36:57 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b00188fdae6e0esm95039plg.44.2022.11.29.19.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 19:36:57 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:36:50 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
Message-ID: <Y4bP0v7WZfKzpF6i@piliu.users.ipa.redhat.com>
References: <20221128082816.28518-1-kernelfans@gmail.com>
 <20221128082816.28518-3-kernelfans@gmail.com>
 <PH0PR11MB5880585607E73B0228D77946DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y4THX7G73KbIFi5z@piliu.users.ipa.redhat.com>
 <PH0PR11MB58803CCA382FC4A50E53CBDBDA139@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58803CCA382FC4A50E53CBDBDA139@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 28, 2022 at 02:47:46PM +0000, Zhang, Qiang1 wrote:
> On Mon, Nov 28, 2022 at 09:20:18AM +0000, Zhang, Qiang1 wrote:
> > >Subject: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
> > >
> > >At present, the code chunk "Transition to big if needed" is out of the
> > >lock srcu_cb_mutex, which allows the following scene:
> > >
> > >    srcu_gp_end() on cpu1                srcu_gp_end() on cpu2
> > >
> > >    init_srcu_struct_nodes()
> > >    ^^  scheduled out in the middle
> > >                                         init_srcu_struct_nodes()
> > >                                         ^^ overwrite the context set up by cpu1
> > 
> > Hi Pingfan
> > 
> > This scenario shouldn't happen.
> > The srcu_gp_end() is invoked only in process_srcu() workfn.
> > for the same ssp->work, workqueue can guaranteed that the 
> > process_srcu() workfn is executed serially. (view __queue_work () details)
> > 
> 
> >
> >How about this:
> >
> >In process_one_work()
> >
> >  set_work_pool_and_clear_pending(work, pool->id);
> >                                               -----> another ssp->work
> >					       can be queued, which can raise the
> >					       scenario mentioned above
> >					       
> >  worker->current_func(work);
> >
> 
> 
> Hi Pingfan
> 
> The following two code snippets ensure that this scenario  does not happen
> 
> __queue_work(): 
> 
> last_pool = get_work_pool(work);
>         if (last_pool && last_pool != pwq->pool) {
>                 struct worker *worker;
> 
>                 raw_spin_lock(&last_pool->lock);
> 
>                 worker = find_worker_executing_work(last_pool, work);
> 
>                 if (worker && worker->current_pwq->wq == wq) {
>                         pwq = worker->current_pwq;
> 
> and 
> process_one_work():
> 
> collision = find_worker_executing_work(pool, work);
>         if (unlikely(collision)) {
>                 move_linked_works(work, &collision->scheduled, NULL);
>                 return;
>         }
> 

Appreciate for pointing out this. It is helpful.

And I will send out a new patch about it.

Thanks,

	Pingfan

> Thanks
> Zqiang
> 
> >
> >Thanks,
> >
> 	Pingfan
> > 
> > Thanks
> > Zqiang
> > 
> > 
> > >
> > >Squashing out the race window by putting the code chunk under the
> > >protection of srcu_cb_mutex.
> > >
> > >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > >Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > >Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > >Cc: Frederic Weisbecker <frederic@kernel.org>
> > >Cc: Josh Triplett <josh@joshtriplett.org>
> > >Cc: Steven Rostedt <rostedt@goodmis.org>
> > >Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > >Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > >To: rcu@vger.kernel.org
> > >---
> > > kernel/rcu/srcutree.c | 14 +++++++-------
> > > 1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > >index fe0759d89c2d..281cd69fe804 100644
> > >--- a/kernel/rcu/srcutree.c
> > >+++ b/kernel/rcu/srcutree.c
> > >@@ -811,6 +811,13 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > > 			spin_unlock_irqrestore_rcu_node(sdp, flags);
> > > 		}
> > > 
> > >+	/* Transition to big if needed. */
> > >+	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> > >+		if (ss_state == SRCU_SIZE_ALLOC)
> > >+			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> > >+		else
> > >+			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
> > >+	}
> > > 	/* Callback initiation done, allow grace periods after next. */
> > > 	mutex_unlock(&ssp->srcu_cb_mutex);
> > > 
> > >@@ -826,13 +833,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > > 		spin_unlock_irq_rcu_node(ssp);
> > > 	}
> > > 
> > >-	/* Transition to big if needed. */
> > >-	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> > >-		if (ss_state == SRCU_SIZE_ALLOC)
> > >-			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> > >-		else
> > >-			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
> > >-	}
> > > }
> > > 
> > > /*
> > >-- 
> > >2.31.1
> > >
