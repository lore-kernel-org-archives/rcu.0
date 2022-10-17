Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA40C433FE
	for <rcu@archiver.kernel.org>; Mon, 17 Oct 2022 13:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJQNrN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJQNrN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Oct 2022 09:47:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8152816
        for <rcu@vger.kernel.org>; Mon, 17 Oct 2022 06:47:12 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d142so9050135iof.7
        for <rcu@vger.kernel.org>; Mon, 17 Oct 2022 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tp5Hh6O/9A3srRlAZuCsYvFyaZFl+pX5X5HoG/4ElAU=;
        b=BkU5qF0dzUpUIC9KulmtP0BV02i/Hc+ZIukXmznU6DSFGPncHSk5xOwsfVBE12TSjy
         BP2RcKTW68QFdfFkoEMiYIh45Lnr0sNlqCMJNSceCwDypaKdo22u9xFM3kexofmLH/zg
         xq37h5vc/v60b2DbaTlJKTLBcbmcCkr0I1L40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tp5Hh6O/9A3srRlAZuCsYvFyaZFl+pX5X5HoG/4ElAU=;
        b=2dkA9rsfJzgs+LnEinvBx/exUYe0/XUanBftJQYUQjB6AhZ/wkF2dmIUv0I7rG3uMC
         jadzFgD4A2JvIQXlVpFb1fB7/5KF62vgxXoHIDD4XlFfz7UAG92T8qffEfIEPZ18lYuW
         H4OkEK3z02F2PnloTMZBsrVNDQjJZEJOlnBDfYi74E58ORFJrgF3L88rRI0imcSPyJ3k
         v2yK7B/9bXP3bymPhn3HychFEYk75e5xcdZX2pfRxQHOkb7NI8PTwky0IvFn+TwFXOqc
         yw+2Za8o+kGD7Jov7siSm2GNiKV0E6P8KJPtWKI0IrlyA+fSVhuzWFzqw1FjrUnwqJJi
         XWxQ==
X-Gm-Message-State: ACrzQf2QOfDZee92Mn8q85x+hnQmkX7B6YeWZiL+EnXKBTj8I1oqdlWH
        Vjaxudg+pJyiL3RVgin7a1lR7lWhAr4LeGbfn+oWW74nY9g=
X-Google-Smtp-Source: AMsMyM47AVWwcAp7qkyKwstKtc+LVH7Vc9Mv6/Oad//okiRD3lriys+APzVwh5TYSft0aMfQYHPP0jnatDn0qJf/4EE=
X-Received: by 2002:a05:6638:408b:b0:364:768:e8c2 with SMTP id
 m11-20020a056638408b00b003640768e8c2mr5433037jam.107.1666014431529; Mon, 17
 Oct 2022 06:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221016162305.2489629-1-joel@joelfernandes.org> <20221017133738.GE5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221017133738.GE5600@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 17 Oct 2022 09:47:00 -0400
Message-ID: <CAEXW_YS8TkqX8acJESE54woR2adyiBOQq0ZRZKTLTqLGkkHPuQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/13] rcu: call_rcu() power improvements
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 17, 2022 at 9:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Oct 16, 2022 at 04:22:52PM +0000, Joel Fernandes (Google) wrote:
> > v9 version of RCU lazy patches based on rcu/next branch.
> >  Only change since v8 is this discussion:
> >  https://lore.kernel.org/rcu/20221011180142.2742289-1-joel@joelfernandes.org/T/#m8eff15110477f3430b3b02561b66f7b0d34a73b0
> >
> > To facilitate easier merge, I dropped tracing and other patches and just
> > implemented the new changes. I will post the tracing patches later along with
> > rcutop as I need to add new tracepoints that Frederic suggested.
> >
> > Main recent changes:
> > 1. rcu_barrier() wake up only for lazy bypass list.
> > 2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
> > 3. Take care of some callers using call_rcu_flush() API.
> > 4. Several refactorings suggested by Paul/Frederic.
> > 5. New call_rcu() to call_rcu_flush() conversions by Joel/Vlad/Paul.
> >
> > I am seeing good performance and power with these patches on real ChromeOS x86
> > asymmetric hardware.
> >
> > Earlier cover letter with lots of details is here:
> > https://lore.kernel.org/all/20220901221720.1105021-1-joel@joelfernandes.org/
> >
[...]
>
> Very good, thank you all!
>
> I have pulled these in for further review and testing.
>
> I am holding off on the last one ("rcu/debug: Add wake-up debugging for
> lazy callbacks") for the immediate future, but let's see how it goes.

Thanks! And nice timing with RCU just turning 20 years old ;-)

 - Joel




>
>                                                         Thanx, Paul
>
> > Frederic Weisbecker (1):
> > rcu: Fix missing nocb gp wake on rcu_barrier()
> >
> > Joel Fernandes (Google) (9):
> > rcu: Make call_rcu() lazy to save power
> > rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
> > rcuscale: Add laziness and kfree tests
> > percpu-refcount: Use call_rcu_flush() for atomic switch
> > rcu/sync: Use call_rcu_flush() instead of call_rcu
> > rcu/rcuscale: Use call_rcu_flush() for async reader test
> > rcu/rcutorture: Use call_rcu_flush() where needed
> > rxrpc: Use call_rcu_flush() instead of call_rcu()
> > rcu/debug: Add wake-up debugging for lazy callbacks
> >
> > Uladzislau Rezki (2):
> > scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
> > workqueue: Make queue_rcu_work() use call_rcu_flush()
> >
> > Vineeth Pillai (1):
> > rcu: shrinker for lazy rcu
> >
> > drivers/scsi/scsi_error.c |   2 +-
> > include/linux/rcupdate.h  |   7 ++
> > kernel/rcu/Kconfig        |  15 +++
> > kernel/rcu/lazy-debug.h   | 154 +++++++++++++++++++++++++++
> > kernel/rcu/rcu.h          |   8 ++
> > kernel/rcu/rcuscale.c     |  70 +++++++++++-
> > kernel/rcu/rcutorture.c   |  16 +--
> > kernel/rcu/sync.c         |   2 +-
> > kernel/rcu/tiny.c         |   2 +-
> > kernel/rcu/tree.c         | 149 ++++++++++++++++++--------
> > kernel/rcu/tree.h         |  12 ++-
> > kernel/rcu/tree_exp.h     |   2 +-
> > kernel/rcu/tree_nocb.h    | 217 ++++++++++++++++++++++++++++++++------
> > kernel/workqueue.c        |   2 +-
> > lib/percpu-refcount.c     |   3 +-
> > net/rxrpc/conn_object.c   |   2 +-
> > 16 files changed, 565 insertions(+), 98 deletions(-)
> > create mode 100644 kernel/rcu/lazy-debug.h
> >
> > --
> > 2.38.0.413.g74048e4d9e-goog
> >
