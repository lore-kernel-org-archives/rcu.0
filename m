Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E4C43217
	for <rcu@archiver.kernel.org>; Thu,  1 Dec 2022 13:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiLANy4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Dec 2022 08:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiLANy4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Dec 2022 08:54:56 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1AD1C403
        for <rcu@vger.kernel.org>; Thu,  1 Dec 2022 05:54:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so5285527pjc.3
        for <rcu@vger.kernel.org>; Thu, 01 Dec 2022 05:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQG0P8usI4HNem+ecjQJ3f51aYJXhxGs5688WQfKpkI=;
        b=oEXTNcgcOdsdm2oUv5BMvB2+TWmA31kF1w0Fo4fUWSqGSTzBH3SkI0sUo4OxtK3An8
         OYBlzSWX1GoPgBueZ1grmjQxeHWIAw/5W3pxUxUcOBk/XgN6foP9p/e9XCBnoq4aFfsc
         xudERrqS7hu1dgt/ZeglJsENgb8bM2X5wYCUAT8N7JEAK4nano12hHl0Z5D0c+O5HPtc
         y83ivmSeKsf0MYEv31+hmjMhHQlQ3yhffrBuDt4cKZEDJbzF1P3c4z/I+2ZHVaheCSZx
         aeqj6/7fyu2SWMHtVxf6vVN5rpbW/MOCL4zj0iYHJbpJJ1hF4INu+NDH3UUzsVsT0/Va
         DbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQG0P8usI4HNem+ecjQJ3f51aYJXhxGs5688WQfKpkI=;
        b=Vx5k4h2W01e3uDabKZ2MA2wp79TaCKwDld9L7+uEeqUf0fs9OFmGXgD8VOHhff2uj5
         xwlIZvXwSQR04YF7BhChrb4nfNEQzHgMEMV7lORlRM9ncKN+t3VP4MtnaB9asSg/6YD3
         hsZhKpuJdtlKHTFsXNeeoY+wSaPB2SBDS3fhmkmfOrufHvD57b+2U8mB+jSzfAp5RioV
         FRi3A8bZT2NMHzJklY+IVfzbyTtCofNbj7YatfFTDtfQYQISXwvRqlsf33pk7g8qSH5w
         t18m8ia+LJPvZ+qauEKbPXv4Ms3AXyS5lD/G4Oh+0Q46mN7opJgxl8DCfXe14imLKRvd
         vO+g==
X-Gm-Message-State: ANoB5pl0+uOg1XuIFsFwojRO0rtq3ewmlBjcTsQ02fIFfdzJ7YvK8bnZ
        KzsQhjuPJDNoDmhOhPkNpA==
X-Google-Smtp-Source: AA0mqf65atRDOSXed72gxrkAA53/+dGIAx0DAE1KP2RExtX90F7xrLpyqlOwU3D36JlcjD0xE0OWpw==
X-Received: by 2002:a17:902:6a86:b0:187:722:f4db with SMTP id n6-20020a1709026a8600b001870722f4dbmr48773029plk.87.1669902893980;
        Thu, 01 Dec 2022 05:54:53 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id oe12-20020a17090b394c00b002193db6f18dsm3062107pjb.13.2022.12.01.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:54:53 -0800 (PST)
Date:   Thu, 1 Dec 2022 21:54:45 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCH] srcu: switch work func to allow concurrent gp
Message-ID: <Y4iyJbqIqnMCv+RQ@piliu.users.ipa.redhat.com>
References: <Y4eKl2fCNDX2ka1g@boqun-archlinux>
 <0B944225-3E93-494D-A297-1B330735D44F@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0B944225-3E93-494D-A297-1B330735D44F@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 30, 2022 at 12:39:53PM -0500, Joel Fernandes wrote:
> 
> 
> > On Nov 30, 2022, at 11:55 AM, Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > ﻿On Wed, Nov 30, 2022 at 04:39:02PM +0800, Pingfan Liu wrote:
> >> ssp->srcu_cb_mutex is introduced to allow the other srcu state machine
> >> to advance as soon as possible. But according to the implement of
> >> workqueue, the same work_struct is serialized and can not run
> >> concurrently in fact.
> >> 
> >> Quoting from Documentation/core-api/workqueue.rst
> >> "
> >> Non-reentrance Conditions
> >> =========================
> >> 
> >> Workqueue guarantees that a work item cannot be re-entrant if the following
> >> conditions hold after a work item gets queued:
> >> 
> >>        1. The work function hasn't been changed.
> >>        2. No one queues the work item to another workqueue.
> >>        3. The work item hasn't been reinitiated.
> >> "
> >> 
> >> To allow the concurrence to some extent, it can be achieved by changing
> >> the work function to break the conditions. As a result, when
> >> srcu_gp_end() releases srcu_gp_mutex, a new state machine can begin.
> >> 
> >> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Frederic Weisbecker <frederic@kernel.org>
> >> Cc: Josh Triplett <josh@joshtriplett.org>
> >> Cc: Steven Rostedt <rostedt@goodmis.org>
> >> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> >> To: rcu@vger.kernel.org
> >> ---
> >> kernel/rcu/srcutree.c | 19 +++++++++++++++++++
> >> 1 file changed, 19 insertions(+)
> >> 
> >> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >> index 1c304fec89c0..56dd9bb2c8b8 100644
> >> --- a/kernel/rcu/srcutree.c
> >> +++ b/kernel/rcu/srcutree.c
> >> @@ -75,6 +75,7 @@ static bool __read_mostly srcu_init_done;
> >> static void srcu_invoke_callbacks(struct work_struct *work);
> >> static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
> >> static void process_srcu(struct work_struct *work);
> >> +static void process_srcu_wrap(struct work_struct *work);
> >> static void srcu_delay_timer(struct timer_list *t);
> >> 
> >> /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
> >> @@ -763,6 +764,11 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> >>        cbdelay = 0;
> >> 
> >>    WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
> >> +    /* Change work func so work can be concurrent */
> >> +    if (ssp->work.work.func == process_srcu_wrap)
> >> +        ssp->work.work.func = process_srcu;
> >> +    else
> >> +        ssp->work.work.func = process_srcu_wrap;
> > 
> > This looks really hacky ;-) It would be good that workqueue has an API
> > to allow "resetting" a work.
> > 
> > Do you have any number of the potential performance improvement?
> 
> 
> Agreed. Another question - have you verified the workqueue behavior after this change (say using tracing), regardless of what the workqueue documentation says?
> 

I will try to answer this question after figuring out a test case.

Thanks,

	Pingfan

> Thanks,
> 
> - Joel 
> 
> 
> 
> > 
> > Regards,
> > Boqun
> > 
> >>    rcu_seq_end(&ssp->srcu_gp_seq);
> >>    gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
> >>    if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
> >> @@ -1637,6 +1643,19 @@ static void process_srcu(struct work_struct *work)
> >>    srcu_reschedule(ssp, curdelay);
> >> }
> >> 
> >> +/*
> >> + * The ssp->work is expected to be concurrent to some extent, but the current
> >> + * workqueue does not support the concurrence on the same work. (Refer to the
> >> + * section "Non-reentrance Conditions" in the file workqueue.rst)
> >> + * Resolving it by changing the work func.
> >> + *
> >> + * Prevent compilering from optimizing out it.
> >> + */
> >> +static __used void process_srcu_wrap(struct work_struct *work)
> >> +{
> >> +    process_srcu(work);
> >> +}
> >> +
> >> void srcutorture_get_gp_data(enum rcutorture_type test_type,
> >>                 struct srcu_struct *ssp, int *flags,
> >>                 unsigned long *gp_seq)
> >> -- 
> >> 2.31.1
> >> 
