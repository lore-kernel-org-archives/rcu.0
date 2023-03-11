Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A9C74A4B
	for <rcu@archiver.kernel.org>; Sat, 11 Mar 2023 17:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCKRT2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCKRTZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 11 Mar 2023 12:19:25 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E27E1F905
        for <rcu@vger.kernel.org>; Sat, 11 Mar 2023 09:19:23 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id o199so6275603ybc.7
        for <rcu@vger.kernel.org>; Sat, 11 Mar 2023 09:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678555162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY4Nnb0Wm17pmRtek+pRIUbI9xNdyf7/b38X9mFqiVY=;
        b=mqxt3zYBqBmZBz7V2UEZC+hclvmRZ9nR3J7/kt0M6cEeTZLIl25CVQE/XuuCwz+CyD
         9CZu0HtWmWhyg1pbtvzW1AEYbbboLidD29GBAtPDvWM58/4faniajIXuFH8MiXCV1dfl
         2nx7Q4Ih3S5IRd4yc+6S/CY4GH11mKwz4HiTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678555162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gY4Nnb0Wm17pmRtek+pRIUbI9xNdyf7/b38X9mFqiVY=;
        b=NTaPA3LfCE2JEUoC0D6tplqpmCo48iRMOv8UDps5fr9avX7eXZdO9ZniUjqlBBqF4M
         C9w0ZMFmWF/YPHZCNYinTY/HaK3WNcuva/vOoDvtiiys/BN2O64PPn+i8WQjNy2wOYf0
         Gmpm3CDga4JA6myq4PQdltV0Ci2/GxOCYwNRWQyYrsdwGI0YAm0Y+j9pC++TTmb1hir3
         oR5CnYz8a9bf4HLGyAxTI+bOPgiefwca/2cIFYmtEWPQSdzs0WVz6ixemoWYK9Oxz5aL
         fcY8G8ob6kUujpw/2OQdusC0qaCte1knNkMegba/GPAEX73xJDQtIhvKnsxD+QV4yjHL
         0N8A==
X-Gm-Message-State: AO0yUKUqTMlVMBqYIB/Tm3ocFCAqKpMKW//P17+aPv73zyn9OJbewGHl
        AeQ03b3dZfNkO26Dsc2xzE3jfZpFZt1StI2if9GG/Q==
X-Google-Smtp-Source: AK7set9f7UqmAgWrVofu69pWV1FamP8q6UKz3+HaEOpUb8rSZbgjPiXkY5b+zhqhseNF5U4AgkdFZ/U2/MntwljHVdY=
X-Received: by 2002:a25:e90b:0:b0:9fc:e3d7:d60f with SMTP id
 n11-20020a25e90b000000b009fce3d7d60fmr14047854ybd.5.1678555162265; Sat, 11
 Mar 2023 09:19:22 -0800 (PST)
MIME-Version: 1.0
References: <ZAc+vVZUhXdhpSki@pc636> <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
 <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1> <20230307185443.GA516865@google.com>
 <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1> <ZAhYP9a8u05hzsOn@pc636>
 <20230308144528.GR1301832@paulmck-ThinkPad-P17-Gen-1> <ZAnXxr9OyFT63xSx@pc636>
 <20230309221056.GB148448@google.com> <ZArwZjcEYXAYwmqi@pc636> <8f8a40cd-8b1f-4121-98f7-7a1bdbcaf6a6@paulmck-laptop>
In-Reply-To: <8f8a40cd-8b1f-4121-98f7-7a1bdbcaf6a6@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 11 Mar 2023 12:19:11 -0500
Message-ID: <CAEXW_YSyJeMY+LGJLrZWJakdr19HyFA+AJEMzXhrwZDBia9HfA@mail.gmail.com>
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
To:     paulmck@kernel.org
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Mar 11, 2023 at 1:24=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> > On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > > On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > > [..]
> > > > > > > > > See this commit:
> > > > > > > > >
> > > > > > > > > 3705b88db0d7cc ("rcu: Add a module parameter to force use=
 of
> > > > > > > > > expedited RCU primitives")
> > > > > > > > >
> > > > > > > > > Antti provided this commit precisely in order to allow An=
droid
> > > > > > > > > devices to expedite the boot process and to shut off the
> > > > > > > > > expediting at a time of Android userspace's choosing.  So=
 Android
> > > > > > > > > has been making this work for about ten years, which stri=
kes me
> > > > > > > > > as an adequate proof of concept.  ;-)
> > > > > > > >
> > > > > > > > Thanks for the pointer. That's true. Looking at Android sou=
rces, I
> > > > > > > > find that Android Mediatek devices at least are setting
> > > > > > > > rcu_expedited to 1 at late stage of their userspace boot (w=
hich is
> > > > > > > > weird, it should be set to 1 as early as possible), and
> > > > > > > > interestingly I cannot find them resetting it back to 0!.  =
Maybe
> > > > > > > > they set rcu_normal to 1? But I cannot find that either. Vl=
ad? :P
> > > > > > >
> > > > > > > Interesting.  Though this is consistent with Antti's commit l=
og,
> > > > > > > where he talks about expediting grace periods but not unexped=
iting
> > > > > > > them.
> > > > > > >
> > > > > > Do you think we need to unexpedite it? :))))
> > > > >
> > > > > Android runs on smallish systems, so quite possibly not!
> > > > >
> > > > We keep it enabled and never unexpedite it. The reason is a perform=
ance.  I
> > > > have done some app-launch time analysis with enabling and disabling=
 of it.
> > > >
> > > > An expedited case is much better when it comes to app launch time. =
It
> > > > requires ~25% less time to run an app comparing with unexpedited va=
riant.
> > > > So we have a big gain here.
> > >
> > > Wow, that's huge. I wonder if you can dig deeper and find out why tha=
t is so
> > > as the callbacks may need to be synchronize_rcu_expedited() then, as =
it could
> > > be slowing down other usecases! I find it hard to believe, real-time
> > > workloads will run better without those callbacks being always-expedi=
ted if
> > > it actually gives back 25% in performance!
> > >
> > I can dig further, but on a high level i think there are some spots
> > which show better performance if expedited is set. I mean synchronize_r=
cu()
> > becomes as "less blocking a context" from a time point of view.
> >
> > The problem of a regular synchronize_rcu() is - it can trigger a big la=
tency
> > delays for a caller. For example for nocb case we do not know where in =
a list
> > our callback is located and when it is invoked to unblock a caller.
>
> True, expedited RCU grace periods do not have this callback-invocation
> delay that normal RCU does.
>
> > I have already mentioned somewhere. Probably it makes sense to directly=
 wake-up
> > callers from the GP kthread instead and not via nocb-kthread that invok=
es our callbacks
> > one by one.
>
> Makes sense, but it is necessary to be careful.  Wakeups are not fast,
> so making the RCU grace-period kthread do them all sequentially is not
> a strategy to win.  For example, note that the next expedited grace
> period can start before the previous expedited grace period has finished
> its wakeups.

The kthreads could be undergoing scheduler contention too especially
since the workload is launching an app if I understand Vlad's usecase.
Hence my desire for a rcutop one-stop tool which shows all these
things (rcu kthread scheduler delays, callback latencies, etc etc).
;-) The more and more I run into issues, the more that tool becomes
urgent which I'm working on...

thanks,

 - Joel
