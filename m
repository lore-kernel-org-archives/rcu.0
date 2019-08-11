Return-Path: <SRS0=Ms3y=WH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2749C433FF
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84762147A
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 18:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sy+ZBu2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHKSeW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:34:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43957 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfHKSeW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 11 Aug 2019 14:34:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so72855646lfm.10
        for <rcu@vger.kernel.org>; Sun, 11 Aug 2019 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=f4muEiv+1VWpjBBpznBH8mkdBWWGv1TUJVQp9C2iCyE=;
        b=sy+ZBu2V/rgjeep9/8034bXTFBAAcxtl1W1rnunKlUKtw0HCQRqHTrqMFv1W8hep7V
         bEJ3/Q95ycZDYTN+nTgx1i08QEjgPnh1toi0K9VnqrUHBwkTE8t87/EDCHnL3blbUZDj
         hlLyyyYSEhIXzTHlIgIMWYIxB4W4r20AW/YAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=f4muEiv+1VWpjBBpznBH8mkdBWWGv1TUJVQp9C2iCyE=;
        b=mLA7oONPDOeJwjPF7e5t3qaFUFc6o+jJNNagZFvrjv3/G25Z+ibYcbs0tDsFM5Ij3A
         HKXaMl/ZAUrp/49Uq4lWvlDKknx28WqApXqQCgha2wo0jCJBHGqQCSDUvbbnA7ccI3J8
         wIoTGUkrKLk0pvqtFgRLIuKuAqC7orimHAX9u4kjYRbd+xiHE6vcRne+aXmBAEF5GgFO
         XMaaNIIHjao+ICof7sNuIDzmoAFsZlumhbpYRVPPMJCdRVbAsm+c/22yLKvHmGSc6Muj
         bh1ldvFbKIdrxL70R7SWkdbdVOf7B+OgxdmYuVsRC/zBstWaZM9eq6MuvNmnyVeJ9tjV
         tlIg==
X-Gm-Message-State: APjAAAUPofEZ3MupAQstzQRff0fGhJ7RpbqLgEEIRDmw8WhFJGjjEwk0
        2IrbFoQt8uQw1QLN/jAYw7f3aPka7AZ18ouZ15Vx3ISWIEo=
X-Google-Smtp-Source: APXvYqxL2xOhuqRQE4oNeixGVAMNWH27WYtz0VrxbECRK/tfpgXvO0DkEWIvE2BVW9eX8egmxYyuDA6HK+iavswcg54=
X-Received: by 2002:a19:f11a:: with SMTP id p26mr14143600lfh.160.1565548459944;
 Sun, 11 Aug 2019 11:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190811180852.GA128944@google.com>
In-Reply-To: <20190811180852.GA128944@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 11 Aug 2019 14:34:08 -0400
Message-ID: <CAEXW_YSbGCSLVrqD-_pDO5KJzLR2goYt8otOd65hWPQtZGkGUA@mail.gmail.com>
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
To:     rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 2:08 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Paul, everyone,
>
> I noticed on reading code that the need_heavy_qs check and
> rcu_momentary_dyntick_idle() is only called for !PREEMPT kernels. Don't we
> need to call this for PREEMPT kernels for the benefit of nohz_full CPUs?
>
> Consider the following events:
> 1. Kernel is PREEMPT=y configuration.
> 2. CPU 2 is a nohz_full CPU running only a single task and the tick is off.
> 3. CPU 2 is running only in kernel mode and does not enter user mode or idle.
> 4. Grace period thread running on CPU 3 enter the fqs loop.
> 5. Enough time passes and it sets the need_heavy_qs for CPU2.
> 6. CPU 2 is still in kernel mode but does cond_resched().
> 7. cond_resched() does not call rcu_momentary_dyntick_idle() because PREEMPT=y.
>
> Is 7. not calling rcu_momentary_dyntick_idle() a lost opportunity for the FQS
> loop to detect that the CPU has crossed a quiescent point?
>
> Is this done so that cond_resched() is fast for PREEMPT=y kernels?

Oh, so I take it this bit of code in rcu_implicit_dynticks_qs(), with
the accompanying comments, takes care of the scenario I describe?
Another way could be just call rcu_momentary_dyntick_idle() during
cond_resched() for nohz_full CPUs? Is that pricey?
        /*
         * NO_HZ_FULL CPUs can run in-kernel without rcu_sched_clock_irq!
         * The above code handles this, but only for straight cond_resched().
         * And some in-kernel loops check need_resched() before calling
         * cond_resched(), which defeats the above code for CPUs that are
         * running in-kernel with scheduling-clock interrupts disabled.
         * So hit them over the head with the resched_cpu() hammer!
         */
        if (tick_nohz_full_cpu(rdp->cpu) &&
                   time_after(jiffies,
                              READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
                resched_cpu(rdp->cpu);
                WRITE_ONCE(rdp->last_fqs_resched, jiffies);
        }
