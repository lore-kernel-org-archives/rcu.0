Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E916CC4332F
	for <rcu@archiver.kernel.org>; Fri, 14 Oct 2022 15:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJNPTo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJNPTn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Oct 2022 11:19:43 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A01147E
        for <rcu@vger.kernel.org>; Fri, 14 Oct 2022 08:19:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y17so2668885ilq.8
        for <rcu@vger.kernel.org>; Fri, 14 Oct 2022 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2zvPqb25LaKvgJw1g+vrVj2+cczSny1mletatYObzpQ=;
        b=pGN7A8z2tVKu/9djyxLPPM6NThRzrQuFMaCSF53ai3awSgyLsrvfjZQWtkmFszlD6X
         8YaNxkQbdXaYJrBk6HYL3NezbiSSCIhQVwdfe+S+7Oluy3RyN9jhr5K3g5maVVBJgPxv
         OBEkDJ5C5seL1uz+rQ8n+HMIhaSH3fi0feOYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zvPqb25LaKvgJw1g+vrVj2+cczSny1mletatYObzpQ=;
        b=XmA6fwulnHwj89iQUA4Lhl+fNeK8H7zL4edfNWqI2p1oU8Xm+eoVcHRZuz2LniZZAn
         sUrjr2WcOSJq55zfJdP+0PLKPyb36imQfDvEilsXTqvF4nRkI5ttl6MvUTwzlwrA+9Pb
         wxvGmOyAyduehMNFWyHpzFIKTMP1re3ZcfP4eehFIKvGZsbg6rLmFf2c1554cR9e63DQ
         inCiMc+kflGRuORC6DvZFeTQnzhtTE+IssKADpgJw/lBMVv7BG3II/0/CGqOjVz/SEiX
         bpKRMp9nOjno8G+xaQCIiEypXiUxVJ0GC3AnCJ/JmFG5WRrJUxc2D5pI//PFaN7bfUJ3
         G8rw==
X-Gm-Message-State: ACrzQf1zqbEc0TKM2vZV+xgDWcXgLYyBrGDDbqumGvT2OP2+LT2pm5io
        57jH73VU4BcB0Q5NJtHdd1SffVlRD9x0gRocQbjJkA==
X-Google-Smtp-Source: AMsMyM4MPJ3hUAgGaXpcMx8mi1ofWAiMYLpJVm8UYufNwcdwxssquPI8MKQC8suZe3ACqXwf5KjyBRNN6Uz1wnV3SnU=
X-Received: by 2002:a92:d686:0:b0:2fa:6226:6247 with SMTP id
 p6-20020a92d686000000b002fa62266247mr2813891iln.79.1665760779944; Fri, 14 Oct
 2022 08:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221011180142.2742289-1-joel@joelfernandes.org>
 <20221011180142.2742289-2-joel@joelfernandes.org> <20221014142127.GE4221@paulmck-ThinkPad-P17-Gen-1>
 <20221014144019.GB1108603@lothringen> <20221014150344.GG4221@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221014150344.GG4221@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 14 Oct 2022 11:19:28 -0400
Message-ID: <CAEXW_YQoRUJ=0_GJG6JunR58yASmehPanp14zbR3Y+KAGL1TDA@mail.gmail.com>
Subject: Re: [PATCH v8 01/13] rcu: Fix missing nocb gp wake on rcu_barrier()
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 14, 2022 at 11:03 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Oct 14, 2022 at 04:40:19PM +0200, Frederic Weisbecker wrote:
> > On Fri, Oct 14, 2022 at 07:21:27AM -0700, Paul E. McKenney wrote:
> > > On Tue, Oct 11, 2022 at 06:01:30PM +0000, Joel Fernandes (Google) wrote:
> > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > >
> > > > Upon entraining a callback to a NOCB CPU, no further wake up is
> > > > issued on the corresponding nocb_gp kthread. As a result, the callback
> > > > and all the subsequent ones on that CPU may be ignored, at least until
> > > > an RCU_NOCB_WAKE_FORCE timer is ever armed or another NOCB CPU belonging
> > > > to the same group enqueues a callback on an empty queue.
> > > >
> > > > Here is a possible bad scenario:
> > > >
> > > > 1) CPU 0 is NOCB unlike all other CPUs.
> > > > 2) CPU 0 queues a callback
> > >
> > > Call it CB1.
> > >
> > > > 2) The grace period related to that callback elapses
> > > > 3) The callback is moved to the done list (but is not invoked yet),
> > > >    there are no more pending callbacks for CPU 0
> > >
> > > So CB1 is on ->cblist waiting to be invoked, correct?
> > >
> > > > 4) CPU 1 calls rcu_barrier() and sends an IPI to CPU 0
> > > > 5) CPU 0 entrains the callback but doesn't wake up nocb_gp
> > >
> > > And CB1 must still be there because otherwise the IPI handler would not
> > > have entrained the callback, correct?  If so, we have both CB1 and the
> > > rcu_barrier() callback (call it CB2) in ->cblist, but on the done list.
> > >
> > > > 6) CPU 1 blocks forever, unless CPU 0 ever queues enough further
> > > >    callbacks to arm an RCU_NOCB_WAKE_FORCE timer.
> > >
> > > Except that -something- must have already been prepared to wake up in
> > > order to invoke CB1.  And that something would invoke CB2 along with CB1,
> > > given that they are both on the done list.  If there is no such wakeup
> > > already, then the hang could occur with just CB1, without the help of CB2.
> >
> > Heh good point. I was confused with CB1 on RCU_DONE_TAIL and the possibility
> > for CB2 to be entrained on RCU_WAIT_TAIL. But that's indeed not supposed to
> > happen. Ok so this patch indeed doesn't make sense outside lazy.
>
> Whew!!!  ;-)
>
> > > > This is also required to make sure lazy callbacks in future patches
> > > > don't end up making rcu_barrier() wait for multiple seconds.
> > >
> > > But I do see that the wakeup is needed in the lazy case, and if I remember
> > > correctly, the ten-second rcu_barrier() delay really did happen.  If I

Yes it did happen. Real world device testing confirmed it.

> > > understand correctly, for this to happen, all of the callbacks must be
> > > in the bypass list, that is, ->cblist must be empty.
> > >
> > > So has the scenario steps 1-6 called out above actually happened in the
> > > absence of lazy callbacks?
> >
> > Nope, so I guess we can have the pending check around rcu_nocb_flush_bypass()
> > only...
>
> OK, sounds good.
>
> I have put this series on branch lazy.2022.10.14a and am testing it.

I agree with the discussion, though if all CBs are in the bypass list,
the patch will also save 2 jiffies.

So just commit messages that need rework then? This one can be taken instead:
https://lore.kernel.org/rcu/21ECDA9F-81B1-4D22-8B03-020FB5DADA4F@joelfernandes.org/T/#m14d21fbce23539a521693a4184b28ddc55d7d2c5

Thanks!

 - Joel
