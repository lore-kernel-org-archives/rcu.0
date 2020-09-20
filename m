Return-Path: <SRS0=fWZm=C5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B9C43465
	for <rcu@archiver.kernel.org>; Sun, 20 Sep 2020 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE16320897
	for <rcu@archiver.kernel.org>; Sun, 20 Sep 2020 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600614399;
	bh=eF+JnFq4iVQVzHR+dMxoT/cJJg+WxK5PierVQVgRRow=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dWfXohUQYZg/AzcNsEGcOU2cVtGZyQF0BoPUgaaRsa1Eem90R+xnkP35qCFspK4Ab
	 QZk7Ko0oUSVMNdaMKh+X2H7r4eZ9Fbos0KdFpPwn87aNALyPnTvsIjvRRnNOcgsHP5
	 sRoSI5sLHxoaBd484+wVRXdIfnOSAIQHFv19wN1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgITPGj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Sep 2020 11:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgITPGj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Sep 2020 11:06:39 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88EB620870;
        Sun, 20 Sep 2020 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600614398;
        bh=eF+JnFq4iVQVzHR+dMxoT/cJJg+WxK5PierVQVgRRow=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n7OiQ5Ajr9+bxOXjvsZ6IMErGgjMDEFMnIM26xvZQnPPFS5bPusrTEDIBbMaWaf7O
         DDeVviN3WVgAWeqp8LC5sZgdSQpeBX268cpMAV6fmQGqVuZTyignednhIkIotoKuXh
         zUhfOeuO6i8cvW52oHTFVStN6UO71OdL8kJRwKMw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 587FC35227C1; Sun, 20 Sep 2020 08:06:38 -0700 (PDT)
Date:   Sun, 20 Sep 2020 08:06:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 4/4] rcu/tree: Use schedule_delayed_work() instead of
 WQ_HIGHPRI queue
Message-ID: <20200920150638.GA5453@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918194817.48921-5-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 18, 2020 at 09:48:17PM +0200, Uladzislau Rezki (Sony) wrote:
> Recently the separate worker thread has been introduced to
> maintain the local page cache from the regular kernel context,
> instead of kvfree_rcu() contexts. That was done because a caller
> of the k[v]free_rcu() can be any context type what is a problem
> from the allocation point of view.
> 
> >From the other hand, the lock-less way of obtaining a page has
> been introduced and directly injected to the k[v]free_rcu() path.
> 
> Therefore it is not important anymore to use a high priority "wq"
> for the external job that used to fill a page cache ASAP when it
> was empty.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

And I needed to apply the patch below to make this one pass rcutorture
scenarios SRCU-P and TREE05.  Repeat by:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --configs "SRCU-P TREE05" --trust-make

Without the patch below, the system hangs very early in boot.

Please let me know if some other fix would be better.

						Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce1ea4..2424e2a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3481,7 +3481,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
 		// Use delayed work, so we do not deadlock with rq->lock.
-		if (!atomic_xchg(&krcp->work_in_progress, 1))
+		if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
+		    !atomic_xchg(&krcp->work_in_progress, 1))
 			schedule_delayed_work(&krcp->page_cache_work, 1);
 
 		if (head == NULL)
