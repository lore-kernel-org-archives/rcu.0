Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FDEC4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 02:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiLaC7T (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 21:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiLaC7S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 21:59:18 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72242192BD
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:59:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f34so34086183lfv.10
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v367mAlBHykHAA7k+OTW6sKXw/MdzIyAs0a7+UFe4pM=;
        b=a3CLnM0q8YIRnEeYCq1IwABdjd8aVVhqyCv5DDXkp2eo7G3KM2Jo0DXctlBFaBGFR9
         zmXRp5MpBU0wZnm1PQK6hMj+aqhi39DblJ84QqjysyMg8VYL+bsFle60yK1CHFkSL010
         +Y4l6uZa0lZwKVYaISVAi5HV5QQ/ppCFiml4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v367mAlBHykHAA7k+OTW6sKXw/MdzIyAs0a7+UFe4pM=;
        b=q/YL2MvZb4+zNvEwNYrPmI7ZWjFd9xSehnLp+jAGjh5wXP/K8Sb64D9f3v+9qXFcsZ
         1K6VV1wkm+xkNfqClaoz5kWOKzfgb7JSs/f2xxzvzq+Qgmil5869+TpL2qzAVaE36PoU
         oTF6rR2KbJAI1ygujD6fLN6+KIW5zAZ7hKOn21Ogyzxy8QLm6iXjsNKEu84NnKLbdWQx
         LN9XU4tD1yb6V0o0bLUykWHyINjvxP+c2Fay2+x8i22fOVQYGdS51CmQWsUBfZBJ+Y9k
         of1FGoCcIP1rgvu9KWvk6EahzEBgYf5ke4RJ/4HHwF5vGtUS1Q807JntEKjBGBV0htBH
         oqPA==
X-Gm-Message-State: AFqh2koKerluvx+5l/yWFWIDy6REvaB4QewLkUpNpixg78hSj8Z4bSbZ
        /TlXJ/jeLoFTprx7BwMAFfj+AqYSr2tDahhqDvPaWzYaRgNaBXVK
X-Google-Smtp-Source: AMrXdXtel6nIIGvun9YFkFQVQm+FMSG9Ygs7b6thREIdZINMt3BfM8MQ+x2LpYjZWi2eQWKLVIqc2LdSK1dZLZ/Xtfw=
X-Received: by 2002:ac2:5985:0:b0:4ca:fa1b:ebc7 with SMTP id
 w5-20020ac25985000000b004cafa1bebc7mr1019528lfn.169.1672455555770; Fri, 30
 Dec 2022 18:59:15 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <CAABZP2xNJoR2ABsQ6uPEHrK-KU2WO3gRt46==n10yMZ7fNZ6mA@mail.gmail.com>
 <CAEXW_YT3ZGANz2w7M=WiPO6diUYz0PTkV9U14=8NssqZQa6boA@mail.gmail.com> <CAABZP2yfVztwWEFFgCxXZwt0X81s7h4z=K33m6UXKuuywOJOvQ@mail.gmail.com>
In-Reply-To: <CAABZP2yfVztwWEFFgCxXZwt0X81s7h4z=K33m6UXKuuywOJOvQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 31 Dec 2022 02:59:04 +0000
Message-ID: <CAEXW_YQhoNqiaUX+BTdb5-tUhViErjF6gHBbfBROKBy++fk9pQ@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 2:41 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> On Sat, Dec 31, 2022 at 10:14 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Dec 30, 2022 at 9:04 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > >
> > > Hi Joel
> > >
> > > As a beginner, I am interested and I have time, could you tell me
> > > where to download 6.0.16-rc2-g50f737b34ede when you are convenient?
> > > And could you tell me which torture command you are invoking? I may
> > > help to do some tests ;-)
> >
> > Sure Zhouyi, You can checkout linux-6.0.y from the stable tree [1] and
> > easily reproduce it via:
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5
> > --configs "25*TREE07"
> > This will take 2 hours to run a total of 25 tests of TREE07. The main
> > interest is in the shutdown stage.
> >
> > If you want to collect traces when the RCU stall triggers, you can do
> > something like:
> >
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5
> > --configs 20*TREE07 --bootargs
> > "trace_event=sched:sched_switch,sched:sched_waking,sched:sched_wakeup,rcu:rcu_callback,rcu:rcu_fqs,rcu:rcu_grace_period
> > ftrace_dump_on_oops panic_on_warn=1 sysctl.kernel.panic_on_rcu_stall=1
> > sysctl.kernel.max_rcu_stall_to_panic=1" trace_buf_size=300K --kconfig
> > "CONFIG_RCU_TRACE=y CONFIG_DEBUG_INFO_DWARF5=y
> > CONFIG_RANDOMIZE_BASE=n"
> >
> > You can see these traces in a link in my last email. Refer to that
> > email for the special trace_printk() patch as well if you fancy,
> > though that is optional.
> Thank Joel for your guidance! Your instruction is clear and easy to
> follow! I will do it. I may report my testing result tomorrow.

Sure! Glad to see your interest and let me/us know how it goes!

> > As a suggestion, also avoid top-posting to mailing lists [2]
> Thank Joel for your guidance! Thank you for correcting my mistake,
> which I have been doing like this for years.
> Without your guidance, I may continue my inappropriate behavior forever.

Thank you, I appreciate that!

thanks,

  - Joel
