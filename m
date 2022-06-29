Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF9FCCA47C
	for <rcu@archiver.kernel.org>; Wed, 29 Jun 2022 22:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiF2W0t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jun 2022 18:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiF2W0s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jun 2022 18:26:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D45E369CC
        for <rcu@vger.kernel.org>; Wed, 29 Jun 2022 15:26:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j7so444118wmp.2
        for <rcu@vger.kernel.org>; Wed, 29 Jun 2022 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84p0yb2pKb0/mlqhXXfPPXMLX3/ZN9/6y/XnIJNI1Kk=;
        b=WL71/59quyzcZwTzbjYVhH5ZnVQDEcpcw7ItbNXzShOn/THC8wO8YUbOkC7/+RvKqd
         zMa5eIP2AL9aRJ3CusxegyqJsSWM3Fiozd6GhJ+TIVqrZ1/KgTOr40oXmXWk5S//q3F5
         SPD7nYA6UFrb21/NRTIo2qzZLFKxMzObtdh+i0yZFtLfL+6sEyr1lUg8oO/v3A7I9R1z
         C4cJw/pN62tDh0RAGG8ffrNbX3Cj65jivvw1FmR4fnNJLQ9bWT5XdC6Pu41X7gchdIHm
         i3dyaRwk7+WAbRd9JFWNp5aBUIVaYeNhepc5GmF6MHnFvMVhnoStcXWLumeijLd1FCVQ
         8Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84p0yb2pKb0/mlqhXXfPPXMLX3/ZN9/6y/XnIJNI1Kk=;
        b=vQfKr9rI6Nf+n7KbK3ospWhMJH6VnSBIt5wrqBZBlsA9tLhCgkzQIe33ArfBBjaug0
         lnjeubbniUX8ewWoztyBRNpQdLoJSTy+F7Vf5pbc40Ug3+lFIFN6hd1B/3Edsi0KfCgq
         N4YPcttT+fzNGDbuyOkm/lyAJ3IX4tNhkCNqmOK7sMo7rq9f+XaitCf/Ymz1F3nfxERO
         CAx9uABxRbi4K+ORWr1wdQj2h42hOv2W2aunL4946F8IEc5VhpOo3VhcK8upGQLuh8Eo
         z+SeMauU9jT+Vg4NiE0C4yt2MA756iiRmJ4U1uFCJAmjpNuTe3bgFjVddJUrfREC32eY
         8WPA==
X-Gm-Message-State: AJIora/EYrQcI1E2c0IXf1QAJkkzN/VwxkZ4VmJbn5hajaDQsRZqMFwQ
        aRKSKI0yDWqUzcJ2AG4G+mQxPGbeXoByCWvJEqgopA==
X-Google-Smtp-Source: AGRyM1saKg+ielDtcLXxEB9pzGSzqFetxgZ4MJ0R9lsQ+QWXrQFJ1PPbu1xcp3shfOz8BNqDcnkw910kPR5ed0tYdAs=
X-Received: by 2002:a05:600c:4081:b0:3a0:47c4:8dd0 with SMTP id
 k1-20020a05600c408100b003a047c48dd0mr5951181wmh.178.1656541604449; Wed, 29
 Jun 2022 15:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150102.1582425-2-hch@lst.de> <Yrx5Lt7jrk5BiHXx@zx2c4.com>
 <20220629161020.GA24891@lst.de> <Yrx6EVHtroXeEZGp@zx2c4.com>
 <20220629161527.GA24978@lst.de> <Yrx8/Fyx15CTi2zq@zx2c4.com>
 <20220629163007.GA25279@lst.de> <Yrx/8UOY+J8Ao3Bd@zx2c4.com>
 <YryNQvWGVwCjJYmB@zx2c4.com> <Yryic4YG9X2/DJiX@google.com> <Yry6XvOGge2xKx/n@zx2c4.com>
In-Reply-To: <Yry6XvOGge2xKx/n@zx2c4.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 29 Jun 2022 15:26:33 -0700
Message-ID: <CAC_TJve_Jk0+XD7VeSJVvJq4D9ZofnH69B4QZv2LPT4X3KNfeg@mail.gmail.com>
Subject: Re: [PATCH] remove CONFIG_ANDROID
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, rcu <rcu@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, sultan@kerneltoast.com,
        android-kernel-team <android-kernel-team@google.com>,
        John Stultz <jstultz@google.com>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 29, 2022 at 1:47 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Kalesh,
>
> On Wed, Jun 29, 2022 at 12:05:23PM -0700, Kalesh Singh wrote:
> > Thanks for raising this.
> >
> > Android no longer uses PM_AUTOSLEEP, is correct. libsuspend is
> > also now deprecated. Android autosuspend is initiatiated from the
> > userspace system suspend service [1].
> >
> > A runtime config sounds more reasonable since in the !PM_AUTOSLEEP
> > case, it is userspace which decides the suspend policy.
> >
> > [1] https://cs.android.com/android/platform/superproject/+/bf3906ecb33c98ff8edd96c852b884dbccb73295:system/hardware/interfaces/suspend/1.0/default/SystemSuspend.cpp;l=265
>
> Bingo, thanks for the pointer. So looking at this, I'm trying to tease
> out some heuristic that wouldn't require any changes, but I don't really
> see anything _too_ perfect. One fragment of an idea would be that the
> kernel treats things in autosuspending mode if anybody is holding open a
> fd to /sys/power/state. But I worry this would interact with
> non-autosuspending userspaces that also hold open the file. So barring
> that, I'm not quite sure.
>
> If you also can't think of something, maybe we should talk about adding
> something that requires code changes. In that line of thinking, how
> would you feel about opening /sys/power/userspace_autosuspender and
> keeping that fd open. Then the kernel API would have
> `bool pm_has_userspace_autosuspender(void)` that code could check.
> Alternatively, if you don't want refcounting fd semantics for that, just
> writing a "1" into a similar file seems fine?
>
> Any strong opinions about it? Personally it doesn't make much of a
> difference to me. The important thing is just that it'd be something
> you're willing to implement in that SystemSuspend.cpp file.

Hi Jason,

Thanks for taking a look. I'm concerned holding the sys/power/state
open would have unintentional side effects. Adding the
/sys/power/userspace_autosuspender seems more appropriate. We don't
have a use case for the refcounting, so would prefer the simpler
writing '0' / '1' to toggle semantics.

Thanks,
Kalesh

>
> Jason
