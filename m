Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BA2FA3741
	for <rcu@archiver.kernel.org>; Mon, 31 Oct 2022 18:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJaSPt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Oct 2022 14:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaSPr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Oct 2022 14:15:47 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977B611C1C
        for <rcu@vger.kernel.org>; Mon, 31 Oct 2022 11:15:46 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id t26so5869434uaj.9
        for <rcu@vger.kernel.org>; Mon, 31 Oct 2022 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/nznu592QecLrPw8CafP0xh5EXfjZ+sQg+B1NGtxhZY=;
        b=oPh/dMCiE+bm1dCTeQbPmsoIIQFSr3txBEeoAJnjUjV96S3kFHI0x5JQ50Iy2zTMzz
         m+5b9wgk3aQjgWqH59jA6OoJkdyYMc1KAjqL93qGUkO9fBHXjoWQfIa9oZ67Czn89jIT
         6fds2aUqV88BluVe9V+Mw79zWcqgVDmivXgNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nznu592QecLrPw8CafP0xh5EXfjZ+sQg+B1NGtxhZY=;
        b=th4wLmzWnCm3NLgpgQnU+sW6RvNEFno80qNh9UggFKXQ6Jy9j3W1MMVOxNukEtAmNd
         E7xkxRMQsOh373LOjO8KlhsCCS8mlH2rlSBjzsgpkDeYjgQIvLi5xbme3I/4uv7EPrDu
         fhNX5WZYW25E9UnND+G79L4BmOP5O3UXlalGDWWZ+IJCfTqMRZ0vx+FMZ5Bj9xJq7Nah
         ZOBIBDttDYIDKJoSa7GdP51dFOk4CRaIAGEw85L4iJF8Sg1mRqscVgOaEkeBocMxtLDi
         irybHFPmfAdNa58tSBNgOA71L1sSpvus07GbFBf5UH1EOxYgmcvdWJOUq0IA+OYqUVEa
         UOOA==
X-Gm-Message-State: ACrzQf1MB4x00AuJg2932QCphiFZNKcgrNtg8du5yBl8SLfcromD4KP2
        qxiwVZFAS/yPDqZeMqo0fR4DZCw+e6u9JVDp2SZR8Q==
X-Google-Smtp-Source: AMsMyM4g8phefyWmQkFPh5wyolVyCwQB9wiryhWSP7vHR8z1ezS2B89Dyn5mCi2eh4wItY1zhe8cXlZe6F7Q8Pr6dyM=
X-Received: by 2002:ab0:6918:0:b0:3ea:cad4:4de2 with SMTP id
 b24-20020ab06918000000b003eacad44de2mr3993951uas.46.1667240145574; Mon, 31
 Oct 2022 11:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221019225144.2500095-13-paulmck@kernel.org> <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1> <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636> <Y1ahs83258Lok9+O@google.com> <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636> <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1xIY77sFTyxgAsU@google.com> <Y1/LwKz60iU2izOZ@pc636>
In-Reply-To: <Y1/LwKz60iU2izOZ@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 31 Oct 2022 14:15:33 -0400
Message-ID: <CAEXW_YTmtm2yb0MVvNV9C1jPEs=5K9PaEFsWEG7pAmPAyWJ_qQ@mail.gmail.com>
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use call_rcu_flush()
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 31, 2022 at 9:21 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Fri, Oct 28, 2022 at 09:23:47PM +0000, Joel Fernandes wrote:
> > On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> > > On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > > > >
> > > > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > > > understand the differences in your respective platforms' definitions of
> > > > > "good".  ;-)
> > > > >
> > > > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > > > workload a can detect a power delta and power gain. Anyway, below is a new
> > > > trace where i do not use "flush" variant for the kvfree_rcu():
> > > >
> > > > <snip>
> > > > 1. Home screen swipe:
[...]
> > > > 2. App launches:
[...]
> > > > <snip>
> > > >
> > > > it is much more better. But. As i wrote earlier there is a patch that i have submitted
> > > > some time ago improving kvfree_rcu() batching:
> > > >
> > > > <snip>
> > > > commit 51824b780b719c53113dc39e027fbf670dc66028
> > > > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Date:   Thu Jun 30 18:33:35 2022 +0200
> > > >
> > > >     rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
> > > >
> > > >     Currently the monitor work is scheduled with a fixed interval of HZ/20,
> > > >     which is roughly 50 milliseconds. The drawback of this approach is
> > > >     low utilization of the 512 page slots in scenarios with infrequence
> > > >     kvfree_rcu() calls.  For example on an Android system:
> > > > <snip>
> > > >
> > > > The trace that i posted was taken without it.
> > >
> > > And if I am not getting too confused, that patch is now in mainline.
> > > So it does make sense to rely on it, then.  ;-)
> >
> > Vlad's patch to change the KFREE_DRAIN_JIFFIES to 5 seconds seems reasonable
> > to me. However, can we unify KFREE_DRAIN_JIFFIES and LAZY_FLUSH_JIFFIES ?
> >
> This is very good.
>
> Below is a plot that i have taken during one use-case. It is about three
> apps usage in parallel. It was done by running "monkey" test:
>
> wget ftp://vps418301.ovh.net/incoming/monkey_3_apps_slab_usage_5_minutes.png
>
> i set up three apps as usage scenario: Google Chrome, YoTube and Camera.
> I logged the Slab metric from the /proc/meminfo. Sampling rate is 0.1 second.
>
> Please have a look at results. It reflects what i am saying. non-flush
> kvfree RCU variant makes a memory usage higher. What is not acceptable
> for our mobile devices and workloads.

That does look higher, though honestly about ~5%. But that's just the
effect of more "laziness". The graph itself does not show a higher
number of shrinker invocations, in fact I think shrinker invocations
are not happening much that's why the slab holds more memory. The
system may not be under memory pressure?

Anyway, I agree with your point of view and I think my concern does
not even occur with the latest patch on avoiding RCU that I posted
[1], so I come in peace.

[1] https://lore.kernel.org/rcu/20221029132856.3752018-1-joel@joelfernandes.org/

I am going to start merging all the lazy patches to ChromeOS 5.10 now
including your kfree updates, except for [1] while we discuss it.
