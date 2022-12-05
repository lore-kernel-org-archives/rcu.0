Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E98C47089
	for <rcu@archiver.kernel.org>; Mon,  5 Dec 2022 07:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiLEHBL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Dec 2022 02:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiLEHAs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Dec 2022 02:00:48 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF413BF73
        for <rcu@vger.kernel.org>; Sun,  4 Dec 2022 23:00:46 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3b56782b3f6so108259087b3.13
        for <rcu@vger.kernel.org>; Sun, 04 Dec 2022 23:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=coRXOHRNz//WTvn8iz/sAzTb1yJBt0dUNQrHlt2mpPs=;
        b=cp2c4vLvpDWA0mcSMbgN+VRWTA9DqaDSNKkxVBxIu7MdTZray7sSNLrIl20bdFnlL0
         KuswNgOgKZuar9qFfg3zDSP4eB3V30hL4u4a+vthyZ1dLzDdOwLeqFzDA1SxC2oD2F/K
         c5K1UCDm42XTnU8MaTGaMgVCR9zjcLmPb/VNuXAGVsFac9utRPXA7IvkYQ1vxJtAhX/z
         PkdIujfBoBkGmeir5HfFGNu1a0u5KsmdQEUE0YEc2CvTj7XseBcUhWCeqaREWYmEz8Ow
         6Hivt5EJmmtmp6I60cJKxtybuRswUNjkPAK69gPiKXRrGAl++llFBfg3Fyh5/C2ZxsSz
         xquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=coRXOHRNz//WTvn8iz/sAzTb1yJBt0dUNQrHlt2mpPs=;
        b=Z5NKghpqo/LQupYXlo1/tk+5YAvTPcnxjB78sUcR+XxUCkJZpvquAPGZsTf/UFvZbM
         WzHo9ouEglKnIglT7qCryVH5+W9pjQNVpz37lGElvvdmBeXS7BktAz8/81ZKqugqpuZM
         d9k2JwfjPqzXEdmfnG3rJoCYHNQ1BkIcmYrN2mIKEbyfmUKcldQuOOxKmF8/6WpYUTmC
         1lk5JeTetILGiHWmmuQ9BpLIgR5SR1EKeMHP6HZCFh2zmzH5rpKrMN9Gqshg2qv4EVnA
         rHOSD0TCW5fIK2X9GcDwF2JnjR1b/MiEsZz1uHBk0qcy8rtTp29vkFkffOOq0IK3n9UI
         2PNw==
X-Gm-Message-State: ANoB5pkyFsYiq5a/CSK+WM7dRG5o7tBSGihhDmQM3mqPXD1nGm8iVZ2B
        xVRIKMbkPogN7XFUeiHuRjjpV46js45X//40k7PDug==
X-Google-Smtp-Source: AA0mqf4ZStaU2n0mz3tYU7jDd0FFF3gERFNnwStcE0ObpDr+z9rd9bCvhr7OcdlOgWqCo28NPuV1ZIRM2HRWjs21t78=
X-Received: by 2002:a81:1915:0:b0:3bf:9e45:1139 with SMTP id
 21-20020a811915000000b003bf9e451139mr39230763ywz.267.1670223645646; Sun, 04
 Dec 2022 23:00:45 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsK5WUxs6p9NaE4e3p7ew_+s0SdW0+FnBgiLWdYYOvoMg@mail.gmail.com>
 <CANpmjNOQxZ--jXZdqN3tjKE=sd4X6mV4K-PyY40CMZuoB5vQTg@mail.gmail.com>
 <CA+G9fYs55N3J8TRA557faxvAZSnCTUqnUx+p1GOiCiG+NVfqnw@mail.gmail.com>
 <Y4e3WC4UYtszfFBe@codewreck.org> <CA+G9fYuJZ1C3802+uLvqJYMjGged36wyW+G1HZJLzrtmbi1bJA@mail.gmail.com>
 <Y4ttC/qESg7Np9mR@codewreck.org> <CANpmjNNcY0LQYDuMS2pG2R3EJ+ed1t7BeWbLK2MNxnzPcD=wZw@mail.gmail.com>
 <Y4vW4CncDucES8m+@codewreck.org>
In-Reply-To: <Y4vW4CncDucES8m+@codewreck.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 5 Dec 2022 08:00:00 +0100
Message-ID: <CANpmjNPXhEB6GeMT70UT1e-8zTHf3gY21E3wx-27VjChQ0x2gA@mail.gmail.com>
Subject: Re: arm64: allmodconfig: BUG: KCSAN: data-race in p9_client_cb / p9_client_rpc
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        rcu <rcu@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 4 Dec 2022 at 00:08, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> Marco Elver wrote on Sat, Dec 03, 2022 at 05:46:46PM +0100:
> > > But I can't really find a problem with what KCSAN complains about --
> > > we are indeed accessing status from two threads without any locks.
> > > Instead of a lock, we're using a barrier so that:
> > >  - recv thread/cb: writes to req stuff || write to req status
> > >  - p9_client_rpc: reads req status || reads other fields from req
> > >
> > > Which has been working well enough (at least, without the barrier things
> > > blow up quite fast).
> > >
> > > So can I'll just consider this a false positive, but if someone knows
> > > how much one can read into this that'd be appreciated.
> >
> > The barriers only ensure ordering, but not atomicity of the accesses
> > themselves (for one, the compiler is well in its right to transform
> > plain accesses in ways that the concurrent algorithm wasn't designed
> > for). In this case it looks like it's just missing
> > READ_ONCE()/WRITE_ONCE().
>
> Aha! Thanks for this!
>
> I've always believed plain int types accesses are always atomic and the
> only thing to watch for would be compilers reordering instrucions, which
> would be ensured by the barrier in this case, but I guess there are some
> architectures or places where this isn't true?
>
>
> I'm a bit confused though, I can only see five places where wait_event*
> functions use READ_ONCE and I believe they more or less all would
> require such a marker -- I guess non-equality checks might be safe
> (waiting for a value to change from a known value) but if non-atomic
> updates are on the table equality and comparisons checks all would need
> to be decorated with READ_ONCE; afaiu, unlike usespace loops with
> pthread_cond_wait there is nothing protecting the condition itself.
>
> Should I just update the wrapped condition, as below?
>
> -       err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
> +       err = wait_event_killable(req->wq,
> +                                 READ_ONCE(req->status) >= REQ_STATUS_RCVD);

Yes, this looks good!

> The writes all are straightforward, there's all the error paths to
> convert to WRITE_ONCE too but that's not difficult (leaving only the
> init without such a marker); I'll send a patch when you've confirmed the
> read looks good.
> (the other reads are a bit less obvious as some are protected by a lock
> in trans_fd, which should cover all cases of possible concurrent updates
> there as far as I can see, but this mixed model is definitely hard to
> reason with... Well, that's how it was written and I won't ever have time
> to rewrite any of this. Enough ranting.)

If the lock-protected accesses indeed are non-racy, they should be
left unmarked. If some assumption here turns out to be wrong, KCSAN
would (hopefully) tell us one way or another.

Thanks!

-- Marco
