Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5ABC433EF
	for <rcu@archiver.kernel.org>; Thu, 14 Apr 2022 21:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiDNVkt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Apr 2022 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345578AbiDNVks (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Apr 2022 17:40:48 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FBF6A406
        for <rcu@vger.kernel.org>; Thu, 14 Apr 2022 14:38:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k25so6813226iok.8
        for <rcu@vger.kernel.org>; Thu, 14 Apr 2022 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vjvP29V/cFqUdkJgRLiS9RCulFECIEe87jpWaiKnE8=;
        b=kGchXCzuPqcm64c8h7PRwwC6F+tfdnXZ6/IyASSf40fbn3Tqf3qG5EAdVyPKC2iSlX
         AUTns2MrUlpXZ/edP9xOA5Yc5hVsp3sUXGke2VvB+gyowxy62Yn15CTayuZ3A+n4Nez5
         /wZhh7/SvfC6/nlVhh43acS9tZ18HeJzQasPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vjvP29V/cFqUdkJgRLiS9RCulFECIEe87jpWaiKnE8=;
        b=cSFiCfXhSFyOA0vyUxnQOG0VOSV32GkFc5DtXBc2U8xD7W1L3Ynw4pdqmIpS2IoudB
         OAztSS59S4UuI++MlhhF72ZUhuOOxFXfuJ6RGKcTx+TrbqmuIHsUmAHzWZ4HH+6KlSIz
         +BgyH4tWw6JZqyBKeDUWL5mNuRWTgzM+hp3EqAKyWQMB9ANh5FEjS2LTZtYp28I5e11c
         9d4TLsh4H6fuV0g2QNYNY9pO31HG1NvG4zUl7OdbyKTUDOPY6MsmcmyemA6Ampy8DtFz
         t1XBz9U2cOeHxEOke07sN1k7hXrWCSwRTx6EP3FACiwPKP36aHfe7vXVAQPjknpxvoLp
         7fQw==
X-Gm-Message-State: AOAM531vKYbb9CUQBjntLsrMAtvsqWsPKljXJrDVIIPbYvq23WGI+Ukx
        HGu0JTQ6Lmwu5vDkv4UJTon97ZxTE62c7x78jozliA==
X-Google-Smtp-Source: ABdhPJznYxJkpvQhWhXDRPr6u5oaNzmu7nYRQJySx96Cq6egJUfrtOdT9dqLU+zYkHMJNr8sxgb2Hl2JD6NUuIFlAII=
X-Received: by 2002:a5d:94c2:0:b0:60b:bd34:bb6f with SMTP id
 y2-20020a5d94c2000000b0060bbd34bb6fmr1982584ior.32.1649972298793; Thu, 14 Apr
 2022 14:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
 <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1> <Ylhz1LOIf+JyjH7n@google.com>
 <20220414194204.GU4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YS5b_51tqmdf27QqQHqsgJKbTys1V3h+Bek3XN4FjBmbw@mail.gmail.com>
 <20220414210933.GW4285@paulmck-ThinkPad-P17-Gen-1> <YliOnZC6gva5WZrG@google.com>
 <20220414213156.GZ4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220414213156.GZ4285@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 14 Apr 2022 17:38:08 -0400
Message-ID: <CAEXW_YT0CDp7kqKVeqGRT8YfXiCYuL0ZgRwz05MQrmns2Yp+2Q@mail.gmail.com>
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

On Thu, Apr 14, 2022 at 5:31 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Apr 14, 2022 at 09:14:05PM +0000, Joel Fernandes wrote:
> > On Thu, Apr 14, 2022 at 02:09:33PM -0700, Paul E. McKenney wrote:
> > > On Thu, Apr 14, 2022 at 03:49:16PM -0400, Joel Fernandes wrote:
> > > > On Thu, Apr 14, 2022 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Thu, Apr 14, 2022 at 07:19:48PM +0000, Joel Fernandes wrote:
> > > > > > On Mon, Apr 11, 2022 at 08:41:09AM -0700, Paul E. McKenney wrote:
> > > > > > [..]
> > > > > > > > > [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > > > > > > > >         and offloaded at runtime.  This is the same behavior that
> > > > > > > > >         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > > > > > > > >         rcu_nocbs=0-N.
> > > > > > > >
> > > > > > > > Yes, this is the behavior I intend. So then there would not be a need
> > > > > > > > to pass a mask (and I suspect for a large number of users, it
> > > > > > > > simplifies boot params).
> > > > > > >
> > > > > > > Very good, and from what I can see, this should work for everyone.
> > > > > >
> > > > > > Just to clarify, what I am going to do is, if this new option =y, then
> > > > > > rcu_nocbs effectively wont do anything. i.e. All CPUs are offloaded at boot.
> > > > > > Let me know if we are not on the same page about it though. I do feel that is
> > > > > > a sensible choice given =y. If we are on same page, please ignore my comment.
> > > > >
> > > > > I was assuming that the rcu_nocbs=??? for non-empty "???" would override
> > > > > the CONFIG_RCU_NOCB_CPU_ALL=y.  If you choose not to do that, shouldn't
> > > > > you at least issue some sort of diagnostic?  After all, the sysadmin
> > > > > gave a kernel-boot parameter asking the code to do something and the
> > > > > code is choosing not to do that something.
> > > > >
> > > > > Of course, such a sysadmin might want the CONFIG_RCU_NOCB_CPU_ALL=y
> > > > > Kconfig option to affect only the default, that is, when no rcu_nocbs
> > > > > kernel boot parameter is specified.  This would change the second "[4]"
> > > > > in my original table to "[2]".
> > > > >
> > > > > Thoughts?
> > > >
> > > > I thought about that. I feel that since we are defaulting the new
> > > > config option to =n , it is a conscious choice by the distro to set it
> > > > to =y.  In such a case, they should be Ok with offloading all CPUs. If
> > > > they decide to selectively offload some CPUs in the future, then they
> > > > could revisit the config option at that time.
> > > >
> > > > I feel the kernel config should override the boot parameter behavior.
> > > > It is the same effect as a sysadmin passing kernel parameter X
> > > > assuming the kernel does something but the CONFIG option might not
> > > > even build code corresponding to X.
> > > >
> > > > I feel to address your concern, we can document in kernel command line
> > > > documentation that rcu_nocbs= does not have an effect if
> > > > CONFIG_RCU_NOCB_CPU_ALL=y, would that work for you?
> > >
> > > Not me so much, because I would just set CONFIG_RCU_NOCB_CPU_ALL=n so
> > > as to not worry about it.
> > >
> > > But I am not at all looking forward to complaints about rcu_nocbs not
> > > working the way people expect.  So let's take some time to think more
> > > carefully about this.
> >
> > That's a fair concern. But we are defaulting it to 'n' so I think if it is
> > unconsciously enabled without someone reading documentation, then that's a
> > slightly different issue.
>
> Suppose that one group decides to change to CONFIG_RCU_NOCB_CPU_ALL=y,
> and some other group on some other continent happens to be using the
> rcu_nocbs boot parameter (having read the documentation).  And suppose
> that the level of communication between the two groups is typical,
> that is to say, nonexistent.
>
> Sure, we can argue that groups should communicate, but our making that
> argument won't necessarily prevent the group using rcu_nocbs from taking
> us to task in the course of their debugging effort.
>
> > On the other hand, I can also make it such that if rcu_nocbs= is passed, then
> > the CONFIG does not take effect. That's quite a bit weird/quirky IMHO.
>
> Not at all.  We can simply say that CONFIG_RCU_NOCB_CPU_ALL controls
> only the default situation, that is, when rcu_nocbs is not specified.

Then it should be called: CONFIG_RCU_NOCB_CPU_DEFAULT_ALL , or
something. Otherwise I can tell you that I will be the first one to be
confused by menuconfig unless I also read the code :-D

thanks,

- Joel
