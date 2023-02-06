Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A182C05027
	for <rcu@archiver.kernel.org>; Mon,  6 Feb 2023 17:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBFRT5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjBFRTt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Feb 2023 12:19:49 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26E22A157
        for <rcu@vger.kernel.org>; Mon,  6 Feb 2023 09:19:47 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v17so18654466lfd.7
        for <rcu@vger.kernel.org>; Mon, 06 Feb 2023 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8DYLLe9GRN/tqZPTDwiVkFGsCxKSy6LXftek5tXzGQ=;
        b=VU0+CaXHVO2K7ShJ98vTMhg2nM5DWNGNDtZ1Q7wL9SBlA2JO2N5lOm6xMn4ccyp9t2
         5qtKZDCxRhEfz1Mkl2rqZD4uQda4aZNaxPmpuQDmKU4m6Igz0453QxKlP52i4O2AUI3h
         NiFbxJVb6uEXfl6zRb4nCQDVAGkeUGZrAWbyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8DYLLe9GRN/tqZPTDwiVkFGsCxKSy6LXftek5tXzGQ=;
        b=GXjnT9MIwXJxoofl1OKOLxXbB6il/P7YFc2NEjUQkUWktekmnReaHPWKIGbGCw9vI0
         HE3uRtU0v2lBopQWjzXsPgvuJRFA7FZ8oeR0f1VLA+CMEls6bdWo4FScRyraCKj4WgQE
         C/jDPs7FivPtFr3+Gt0Sbsy7RVbbffD7xYDdALKLcPWS1ZLzsaI+XdtKpcRsPskWFQM9
         M/vAN6veDXgq3fAVKNbsVXOUUxXyg9SOigzWek5q7lnylUn1TfD/xPf4M4RQMsNMqnuc
         DniwciGX5gXibvmz3417uk0ag6x7i50DWO0utfVFkcm4Zde5po5x2xMU9RQm1ASpAZ1J
         x50A==
X-Gm-Message-State: AO0yUKWCNuRhjMa1Cmyc137cTGZ0pvfCLFS/owMR2qmvqBRRJLYmAOP2
        5udeKnG1VVlv5qm8iCnAFj+kEzV/3JJyUJuc6tvZGQ==
X-Google-Smtp-Source: AK7set+0XGVNSUsoZMSzdyMhZk1MudMyLm/D01kbQJrtDpJbIAl7AB2s51FB6iEEQdQd/rqXrCJ5uWAj7WZOjQpIRUc=
X-Received: by 2002:ac2:4295:0:b0:4d2:47be:11fe with SMTP id
 m21-20020ac24295000000b004d247be11femr3073919lfh.196.1675703986066; Mon, 06
 Feb 2023 09:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20230204022051.2737724-1-joel@joelfernandes.org> <PH0PR11MB58800C6FD1C0DDF8EC67DB5DDADA9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58800C6FD1C0DDF8EC67DB5DDADA9@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 6 Feb 2023 12:19:34 -0500
Message-ID: <CAEXW_YRwe781s1faLQcRBvL5pBWv9WmRuhcP=PmqHUJcm9Rphg@mail.gmail.com>
Subject: Re: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Feb 5, 2023 at 10:09 PM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
>
>
> >Recent discussion triggered due to a patch linked below, from Qiang,
> >shed light on the need to accelerate from QS reporting paths.
> >
> >Update the comments to capture this piece of knowledge.
> >
> >Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@intel.com/
> >Cc: Qiang Zhang <Qiang1.zhang@intel.com>
> >Cc: Frederic Weisbecker <frederic@kernel.org>
> >Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> >---
> > kernel/rcu/tree.c | 13 ++++++++++++-
> > 1 file changed, 12 insertions(+), 1 deletion(-)
> >
> >diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >index 93eb03f8ed99..713eb6ca6902 100644
> >--- a/kernel/rcu/tree.c
> >+++ b/kernel/rcu/tree.c
> >@@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> >       } else {
> >               /*
> >                * This GP can't end until cpu checks in, so all of our
> >-               * callbacks can be processed during the next GP.
> >+               * callbacks can be processed during the next GP. Do
> >+               * the acceleration from here otherwise there may be extra
> >+               * grace period delays, as any accelerations from rcu_core()
>
>
> Does the extra grace period delays means that if not accelerate callback,
> the grace period will take more time to end ? or refers to a delay in the
> start time of a new grace period?

Yes, so IMO it is like this if we don't accelerate:
1. Start GP 1
2. CPU1 queues callback C1 (not accelerated yet)
3. CPU1 reports QS for GP1 (not accelerating anything).
4. GP1 ends
5. CPU1's note_gp_changes() is called, accelerate happens, now the CB
will execute after GP3 (or alternately, rcu_core() on CPU1 does
accelerate).
6. GP2 ends.
7. GP3 starts.
8. GP3 ends.
9. CB is invoked

Instead, what we will get the following thanks to the acceleration here is:
1. Start GP 1
2. CPU1 queues callback C1 (not accelerated yet)
3. CPU1 reports QS for GP1 and acceleration happens as done by the
code this patch adds comments for.
4. GP1 ends
5. CPU1's note_gp_changes() is called
6. GP2 ends.
7. CB is invoked

Does that make sense or is there a subtlety I missed?

Thanks,

 - Joel


>
> Thanks
> Zqiang
>
> >+               * or note_gp_changes() may happen only after the GP after the
> >+               * current one has already started. Further, rcu_core()
> >+               * only accelerates if RCU is idle (no GP in progress).
> >                *
> >                * NOCB kthreads have their own way to deal with that...
> >                */
> >@@ -1993,6 +1998,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> >                       /*
> >                        * ...but NOCB kthreads may miss or delay callbacks acceleration
> >                        * if in the middle of a (de-)offloading process.
> >+                       *
> >+                       * Such missed acceleration may cause the callbacks to
> >+                       * be stranded until RCU is fully de-offloaded, as
> >+                       * acceleration from rcu_core() and note_gp_changes()
> >+                       * cannot happen for fully/partially offloaded mode due
> >+                       * to ordering dependency between rnp lock and nocb_lock.
> >                        */
> >                       needacc = true;
> >               }
> >--
> >2.39.1.519.gcb327c4b5f-goog
> >
