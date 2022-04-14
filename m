Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A5FC433EF
	for <rcu@archiver.kernel.org>; Thu, 14 Apr 2022 19:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbiDNTv4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Apr 2022 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbiDNTvy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Apr 2022 15:51:54 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A97526F5
        for <rcu@vger.kernel.org>; Thu, 14 Apr 2022 12:49:28 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p21so6540889ioj.4
        for <rcu@vger.kernel.org>; Thu, 14 Apr 2022 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvS4UKc1UXDGBX9an4EfNISe6+FbRhkIbjWtPqPFv18=;
        b=xB0zOcmw5eHWZ38NbVe/qlAyI4fzr7LrS4U9yAuITELvOPLRxJNAF8j1ZKR7ef2TP0
         MUqzEGVdqwQtJ8cN6wfT1jW//Fy1fIu8ubHL9U92BP1MbUix0jPD242Todc4WRPjOquD
         3UYP6L12lt67t/ik8TkMNw2tAkyhONFSnrihA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvS4UKc1UXDGBX9an4EfNISe6+FbRhkIbjWtPqPFv18=;
        b=xt9FknnCeu7joH3eyfwVRjjfnZlb/rJxe0tq7ZtVDSAyCk695xtZhiAFHxUIrtAPJ2
         DvsFY4WnbMsbllAKxNWtHK0OI0porTHHljXRJ0qPE3E4hQAJarcskP5Pz8FVSZ52igJ7
         ijAFqR6DzQKcsHEvE7cqH+DdQc0eB1dFNVhDiRmH2cAeWa598Kd+aRhrm17cUeDJpKb9
         LGTgdRi93TT8roJVVkpiS2yLayItrpOye0CKxnobbmah3CR8OA3OafE7C5BfThLDHZKX
         o88fNZFAFfwSm35e6Tlojz2yltS+LuGukaX7bmY4tmkMimp500gQfLa0Rhd5m83Sygi9
         iw4A==
X-Gm-Message-State: AOAM533sK7oaJgEg10bexj2npvbrxOZzHcNMoH7hGZVjQWi3nC+n9cDW
        jPkdbccND8dAS4VKqeHehssNh9JdTe7dZm4kfghTDvuQ0UU=
X-Google-Smtp-Source: ABdhPJwBIl7sP30f279qizGY5SiJg2wcX805Nne6d9U8shybsSmtrslBWYjl1CfAZqe4vmRgSl/e5yir/379QDKyApg=
X-Received: by 2002:a5d:8855:0:b0:651:fe8:47a8 with SMTP id
 t21-20020a5d8855000000b006510fe847a8mr622410ios.84.1649965767824; Thu, 14 Apr
 2022 12:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
 <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1> <Ylhz1LOIf+JyjH7n@google.com>
 <20220414194204.GU4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220414194204.GU4285@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 14 Apr 2022 15:49:16 -0400
Message-ID: <CAEXW_YS5b_51tqmdf27QqQHqsgJKbTys1V3h+Bek3XN4FjBmbw@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for RCU_NOCB_CPU=y
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 14, 2022 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Apr 14, 2022 at 07:19:48PM +0000, Joel Fernandes wrote:
> > On Mon, Apr 11, 2022 at 08:41:09AM -0700, Paul E. McKenney wrote:
> > [..]
> > > > > [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > > > >         and offloaded at runtime.  This is the same behavior that
> > > > >         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > > > >         rcu_nocbs=0-N.
> > > >
> > > > Yes, this is the behavior I intend. So then there would not be a need
> > > > to pass a mask (and I suspect for a large number of users, it
> > > > simplifies boot params).
> > >
> > > Very good, and from what I can see, this should work for everyone.
> >
> > Just to clarify, what I am going to do is, if this new option =y, then
> > rcu_nocbs effectively wont do anything. i.e. All CPUs are offloaded at boot.
> > Let me know if we are not on the same page about it though. I do feel that is
> > a sensible choice given =y. If we are on same page, please ignore my comment.
>
> I was assuming that the rcu_nocbs=??? for non-empty "???" would override
> the CONFIG_RCU_NOCB_CPU_ALL=y.  If you choose not to do that, shouldn't
> you at least issue some sort of diagnostic?  After all, the sysadmin
> gave a kernel-boot parameter asking the code to do something and the
> code is choosing not to do that something.
>
> Of course, such a sysadmin might want the CONFIG_RCU_NOCB_CPU_ALL=y
> Kconfig option to affect only the default, that is, when no rcu_nocbs
> kernel boot parameter is specified.  This would change the second "[4]"
> in my original table to "[2]".
>
> Thoughts?

I thought about that. I feel that since we are defaulting the new
config option to =n , it is a conscious choice by the distro to set it
to =y.  In such a case, they should be Ok with offloading all CPUs. If
they decide to selectively offload some CPUs in the future, then they
could revisit the config option at that time.

I feel the kernel config should override the boot parameter behavior.
It is the same effect as a sysadmin passing kernel parameter X
assuming the kernel does something but the CONFIG option might not
even build code corresponding to X.

I feel to address your concern, we can document in kernel command line
documentation that rcu_nocbs= does not have an effect if
CONFIG_RCU_NOCB_CPU_ALL=y, would that work for you?

Thanks,

- Joel

>
> > > > > I believe that Steve Rostedt's review would carry weight for ChromeOS,
> > > > > however, I am suffering a senior moment on the right person for Android.
> > > >
> > > > I think for Android, Kalesh Singh is in the kernel team and Tim Murray
> > > > is the performance lead. They could appropriately represent their RCU
> > > > needs.
> > >
> > > Sounds good!  Please collect a Reviewed-by from one or both of them.
> >
> > Ok.
>
>                                                         Thanx, Paul
