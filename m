Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAD0C4332F
	for <rcu@archiver.kernel.org>; Sun, 18 Dec 2022 21:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiLRVat (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Dec 2022 16:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiLRVas (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Dec 2022 16:30:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A9A25CE
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 13:30:46 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bf43so11115495lfb.6
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 13:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tn4rQjGQE4F2w5zAfUAbUUjhc9QUg0oaUSmUi2xx9M=;
        b=tXBlq3ZbJVtEkMb+4WNJTrayFU2u+Mp81ndpU7nJkBwkXh+yLzGGznERsG9MvuWU+H
         lvXoOXU5zt6S4c0Be95uK9at1y+DKszWLMN4EbG09R2SfixFRC2M7D3tOJOePSqtBryv
         MjMhc4Qq1yRheRk28x6YqUDf4BuaCD7+qZCP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tn4rQjGQE4F2w5zAfUAbUUjhc9QUg0oaUSmUi2xx9M=;
        b=cZ97ETO5QB4JCxYNBDnNzFuXwICrRVpJdTz3F7/cV2mB6Q6lZVneQ9+7oT2ttigVQt
         cEdpJVVXK7A5MHDJdy3LGQbXg2Up9obuc2Ae6aHuHgwLUnf1uuQNaR751sToFnH+C4cb
         gaHqQPXBTP8hEzwWIU0s/kh231xWgX8+EFiGaeL1NP6oas+CL/Hw+mXPgdm7tLgVQ2/L
         MJtmyclg+TGxHHaQgWx3d3yTHrYA54RY9R6huCDkB2/R3lMhBoaXyyah+/UdRJA45AkR
         4uxM3I/S/ik/i8i/XNx5ctBI9OihIVfNy+C1wI5J4YMB7XbkHjm8E4RzpFIsJrbo0Jtc
         FHNQ==
X-Gm-Message-State: ANoB5pkiOxeVLkXZjkBIrl6zv8mUKIU0kf5tmVCTL0hqSxcXZgPdqzPe
        evQNNv1z2j0nqcxw9qNIKuAzNpV15RHiq02UbjX+kg==
X-Google-Smtp-Source: AA0mqf4GUwjr2MjyB2dINXrnDS4QDmgfXIfOhAmL7j00lduo95kzujD2CNUQuFo+ydQvOahXJtG4fvvGzc+cgGwo1g0=
X-Received: by 2002:ac2:4347:0:b0:4a4:782a:42ac with SMTP id
 o7-20020ac24347000000b004a4782a42acmr31546237lfl.468.1671399045022; Sun, 18
 Dec 2022 13:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org> <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
In-Reply-To: <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Dec 2022 16:30:33 -0500
Message-ID: <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Mathieu,

On Sun, Dec 18, 2022 at 3:56 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> > Hello, I believe the pre-flip memory barrier is not required. The only reason I
> > can say to remove it, other than the possibility that it is unnecessary, is to
> > not have extra code that does not help. However, since we are issuing a fully
> > memory-barrier after the flip, I cannot say that it hurts to do it anyway.
> >
> > For this reason, please consider these patches as "informational", than a
> > "please merge". :-) Though, feel free to consider merging if you agree!
> >
> > All SRCU scenarios pass with these, with 6 hours of testing.
>
> Hi Joel,
>
> Please have a look at the comments in my side-rcu implementation [1, 2].
> It is similar to what SRCU does (per-cpu counter based grace period
> tracking), but implemented for userspace. The comments explain why this
> works without the memory barrier you identify as useless in SRCU.
>
> Following my implementation of side-rcu, I reviewed the SRCU comments
> and identified that the barrier "/* E */" appears to be useless. I even
> discussed this privately with Paul E. McKenney.
>
> My implementation and comments go further though, and skip the period
> "flip" entirely if the first pass observes that all readers (in both
> periods) are quiescent.

Actually in SRCU, the first pass scans only 1 index, then does the
flip, and the second pass scans the second index. Without doing a
flip, an index cannot be scanned for forward progress reasons because
it is still "active". So I am curious how you can skip flip and still
scan both indexes? I will dig more into your implementation to learn more.

> The most relevant comment in side-rcu is:
>
>   * The grace period completes when it observes that there are no active
>   * readers within each of the periods.
>   *
>   * The active_readers state is initially true for each period, until the
>   * grace period observes that no readers are present for each given
>   * period, at which point the active_readers state becomes false.
>
> So I agree with the clarifications you propose here, but I think we can
> improve the grace period implementation further by clarifying the SRCU
> grace period model.

Thanks a lot, I am curious how you do the "detection of no new
readers" part without globally doing some kind of synchronization. I
will dig more into your implementation to learn more.

Thanks,

 - Joel



>
> Thanks,
>
> Mathieu
>
>
> [1] https://github.com/efficios/libside/blob/master/src/rcu.h
> [2] https://github.com/efficios/libside/blob/master/src/rcu.c
>
> >
> > thanks,
> >
> >   - Joel
> >
> > Joel Fernandes (Google) (2):
> > srcu: Remove comment about prior read lock counts
> > srcu: Remove memory barrier "E" as it is not required
> >
> > kernel/rcu/srcutree.c | 10 ----------
> > 1 file changed, 10 deletions(-)
> >
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
