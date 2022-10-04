Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE2C433FE
	for <rcu@archiver.kernel.org>; Tue,  4 Oct 2022 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJDSFW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJDSFT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Oct 2022 14:05:19 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51B38A04
        for <rcu@vger.kernel.org>; Tue,  4 Oct 2022 11:05:12 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id o13so2537335ilc.7
        for <rcu@vger.kernel.org>; Tue, 04 Oct 2022 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sLLzbroKqpxLu0HQF1QulfhBmT3Qy5q0rRY0h0xXoW8=;
        b=QDTMRLES+3c9wfPuGJ1UDQsP5WFZWafybw40aij4Uchx9/VI8x77Kd6QQGUp4rZDOO
         3/3fX6+wZKuZrNtHh0ltXVCGpNk0UOYFcEz6UpMSSfhSkpR6ekbN+UBF1OA4kd7YVlW1
         cE7G13glkKpDJUHPZKXiZJs8gOv0PhBxlcVg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sLLzbroKqpxLu0HQF1QulfhBmT3Qy5q0rRY0h0xXoW8=;
        b=7yTxQrnnauNfV1yegpUJc2K280KvGBnDmAXEHpeHVyDgWrziEQN8HEzUdx+jesEnvc
         ovHkAILX94lcoFT1eXti5YnEvbA5vRRNJnoMM+i/09gq/wZSGOvcPlsA7qwXBnGNr5nW
         /xjEMlIZwc8HOzQrvBudc7sMz0TlQndX6lOv2NvfWk3h+yKAmUK6dGJh0gQJwYKIoZpI
         G2O0PydmzMHvUulzATPO1vgu0uQyIywNCaqsZoQGaMpaBA9J9lo/LLbJaGQBki5fCgUf
         b4zXxXz/qIqIFEGUlLacPiruSsgmYGiRv83gE/LWUIfYMh/pQEF9C4VhlbqltlE0UNZr
         p3wg==
X-Gm-Message-State: ACrzQf2qc6LmxJQAbZyW9TvugdkZHRTv/HXCO93I6vN4MoB4vGSi4/aI
        GBI/M9JxVkXHGJxJBVWYZw7UAdU6/Eqq0Cb4LdOqkg==
X-Google-Smtp-Source: AMsMyM7YKsigDeRdaCpRPiK9JEbG1nQ9TQCAOsAfj0pv6RhDXc9ZX8BR78UCcu98nemAHx9h6sIHVySYcDk0L3U2/yM=
X-Received: by 2002:a05:6e02:2191:b0:2f5:aade:9ea0 with SMTP id
 j17-20020a056e02219100b002f5aade9ea0mr12907928ila.79.1664906711403; Tue, 04
 Oct 2022 11:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org> <Yzwb8vgYhAvDJzK+@pc636>
In-Reply-To: <Yzwb8vgYhAvDJzK+@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 4 Oct 2022 14:05:01 -0400
Message-ID: <CAEXW_YScPPbZeCzidU8bwSKKm=pJjEwxNHnFK-XYfnzqSK7ShA@mail.gmail.com>
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 4, 2022 at 7:41 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> >               trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> >               rcu_nocb_lock_irqsave(rdp, flags);
> >               lockdep_assert_held(&rdp->nocb_lock);
> >               bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > -             if (bypass_ncbs &&
> > +             lazy_ncbs = READ_ONCE(rdp->lazy_len);
> > +
> > +             if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> > +                 (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> > +                  bypass_ncbs > 2 * qhimark)) {
> Do you know why we want double "qhimark" threshold? It is not only this
> place, there are several. I am asking because it is not expected by the
> user.

I am following the qhimark conventions in existing code. However
qhimark does not mean that your callbacks cannot exceed these many or
something, it is not a hard limit on queued callbacks.

qhimark (And Paul can correct me) was introduced to reduce the number
of callbacks after which RCU will not limit execution of callbacks to
a batch of them. That has nothing to do with limiting the maximum
number of callbacks, per-se. However, its usage certainly seems to
have grown since that introduction.

Maybe you are confusing it with blimit:

#define DEFAULT_RCU_QHIMARK 10000 // If this many pending, ignore blimit.
static long qhimark = DEFAULT_RCU_QHIMARK;
#define DEFAULT_RCU_QLOMARK 100   // Once only this many pending, use blimit.
static long qlowmark = DEFAULT_RCU_QLOMARK;

thanks,

 - Joel
