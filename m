Return-Path: <SRS0=1n6r=WY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F1C3A5A1
	for <rcu@archiver.kernel.org>; Wed, 28 Aug 2019 14:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081CB2064A
	for <rcu@archiver.kernel.org>; Wed, 28 Aug 2019 14:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LTsE2TEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfH1OCV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:02:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45636 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1OCV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Aug 2019 10:02:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so1515544pgp.12
        for <rcu@vger.kernel.org>; Wed, 28 Aug 2019 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sm8uUWc7t4LJLgsQULbihUhF9V5jwzZ1lbrcWrp+6/Y=;
        b=LTsE2TEAEu36pNiCf5zLFUWz7duzQrtYjrLmIUx2ZbVSZOCITzducoib1LMjg/BIf4
         oJqx15OYLZFXgr7KzRetLbcjfICBjA01bw54V3junFR6MfHddSC7P1eBrBfJfMNi+SBf
         mORsTDF51mM0TBQtpQ8w5eCBI9FqSNvxHzaPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sm8uUWc7t4LJLgsQULbihUhF9V5jwzZ1lbrcWrp+6/Y=;
        b=DByZP7f8Q2GbET0mrEyHV7WFLKjnYzPlLz+aD0wX037hwFZM5OlZT38LWWN7HCe8sk
         gXz835jgDmrv5YfP8sXkNtfkXH1cr02qUROYwyAvWI63gAwZQqoLWA1e1D864c/cI2mm
         1BdWP+ZB1pk6DWt4ORbSg/RQr2hWtkRjKA+uSD8RSZXEvB/Vzfi5UB/lvAZNq27Cerm4
         U9Q7JprcgDJWKQ5xuwgsD1dqvfL/jK/HCym3RJB0f+BvtHnYbzeHz8S7U2LAgNIdyP1t
         dgP8jb5EJxzG/K+e0fzcJXMCoQYt1+7cMM7gfDcoXCnxrZsizqlcOG6JpQw0PykP9fqk
         //TA==
X-Gm-Message-State: APjAAAWmEuN9bcF9VI/JEBbdV7AYQ5/LvWap2INxzhGHKdB6kd/z89LQ
        2p048o7KihQvoZv0rncdh0hxZA==
X-Google-Smtp-Source: APXvYqzXCFvpg5AYsMC9v6QuYVpE0bSIdWbYXYKu8unBPaJtbRdq/x5GWtvrYcZsFRUY3Zo34auRbQ==
X-Received: by 2002:a17:90a:734a:: with SMTP id j10mr4413753pjs.63.1567000940536;
        Wed, 28 Aug 2019 07:02:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z63sm2865783pfb.163.2019.08.28.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:02:19 -0700 (PDT)
Date:   Wed, 28 Aug 2019 10:02:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 2/5] rcu/tree: Add multiple in-flight batches of
 kfree_rcu work
Message-ID: <20190828140218.GB230957@google.com>
References: <5d657e35.1c69fb81.54250.01de@mx.google.com>
 <20190827235253.GB30253@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827235253.GB30253@tardis>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 28, 2019 at 07:52:53AM +0800, Boqun Feng wrote:
> Hi Joel,
> 
> On Tue, Aug 27, 2019 at 03:01:56PM -0400, Joel Fernandes (Google) wrote:
> > During testing, it was observed that amount of memory consumed due
> > kfree_rcu() batching is 300-400MB. Previously we had only a single
> > head_free pointer pointing to the list of rcu_head(s) that are to be
> > freed after a grace period. Until this list is drained, we cannot queue
> > any more objects on it since such objects may not be ready to be
> > reclaimed when the worker thread eventually gets to drainin g the
> > head_free list.
> > 
> > We can do better by maintaining multiple lists as done by this patch.
> > Testing shows that memory consumption came down by around 100-150MB with
> > just adding another list. Adding more than 1 additional list did not
> > show any improvement.
> > 
> > Suggested-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 64 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 45 insertions(+), 19 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 4f7c3096d786..9b9ae4db1c2d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2688,28 +2688,38 @@ EXPORT_SYMBOL_GPL(call_rcu);
> >  
> >  /* Maximum number of jiffies to wait before draining a batch. */
> >  #define KFREE_DRAIN_JIFFIES (HZ / 50)
> > +#define KFREE_N_BATCHES 2
> > +
> > +struct kfree_rcu_work {
> > +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> > +	 * is done after a grace period.
> > +	 */
> > +	struct rcu_work rcu_work;
> > +
> > +	/* The list of objects that have now left ->head and are queued for
> > +	 * freeing after a grace period.
> > +	 */
> > +	struct rcu_head *head_free;
> > +
> > +	struct kfree_rcu_cpu *krcp;
> > +};
> > +static DEFINE_PER_CPU(__typeof__(struct kfree_rcu_work)[KFREE_N_BATCHES], krw);
> >  
> 
> Why not
> 
> 	static DEFINE_PER_CPU(struct kfree_rcu_work[KFREE_N_BATCHES], krw);
> 
> here? Am I missing something?

Yes, that's better.

> Further, given "struct kfree_rcu_cpu" is only for defining percpu
> variables, how about orginazing the data structure like:
> 
> 	struct kfree_rcu_cpu {
> 		...
> 		struct kfree_rcu_work krws[KFREE_N_BATCHES];
> 		...
> 	}
> 
> This could save one pointer in kfree_rcu_cpu, and I think it provides
> better cache locality for accessing _cpu and _work on the same cpu.
> 
> Thoughts?

Yes, that's better. Thanks, Boqun! Following is the diff which I will fold
into this patch:

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b3259306b7a5..fac5ae96d8b1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2717,7 +2717,6 @@ struct kfree_rcu_work {
 
 	struct kfree_rcu_cpu *krcp;
 };
-static DEFINE_PER_CPU(__typeof__(struct kfree_rcu_work)[KFREE_N_BATCHES], krw);
 
 /*
  * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
@@ -2731,7 +2730,7 @@ struct kfree_rcu_cpu {
 	struct rcu_head *head;
 
 	/* Pointer to the per-cpu array of kfree_rcu_work structures */
-	struct kfree_rcu_work *krwp;
+	struct kfree_rcu_work krw_arr[KFREE_N_BATCHES];
 
 	/* Protect concurrent access to this structure and kfree_rcu_work. */
 	spinlock_t lock;
@@ -2800,8 +2799,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 
 	lockdep_assert_held(&krcp->lock);
 	while (i < KFREE_N_BATCHES) {
-		if (!krcp->krwp[i].head_free) {
-			krwp = &(krcp->krwp[i]);
+		if (!krcp->krw_arr[i].head_free) {
+			krwp = &(krcp->krw_arr[i]);
 			break;
 		}
 		i++;
@@ -3780,13 +3779,11 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-		struct kfree_rcu_work *krwp = &(per_cpu(krw, cpu)[0]);
 		int i = KFREE_N_BATCHES;
 
 		spin_lock_init(&krcp->lock);
-		krcp->krwp = krwp;
 		while (i--)
-			krwp[i].krcp = krcp;
+			krcp->krw_arr[i].krcp = krcp;
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 	}
 }
