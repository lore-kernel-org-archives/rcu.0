Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C75CA0EDF
	for <rcu@archiver.kernel.org>; Mon, 11 Sep 2023 22:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbjIKV6r (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242778AbjIKQSd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Sep 2023 12:18:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBCFCC3
        for <rcu@vger.kernel.org>; Mon, 11 Sep 2023 09:18:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso75802621fa.1
        for <rcu@vger.kernel.org>; Mon, 11 Sep 2023 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694449107; x=1695053907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxqkzXGdJRSSdKxmHrLYYUfH6sMkTrkETk9cQkFIOkI=;
        b=v+NYd/JPusmqByEtgvSocOIoJNDWBN92Orz/me+deUq56N/OMdJKbWmHvkgJRb8gsy
         XenBA7PnndeK4wxFtlSC4x4Zx/SbsU3au0gfG2f1Fjd7Ma/nhVNqcPp3kQzxib/uabIb
         s5ynKunEJv5vLJOkBE5Mv57rmgFrN1lj7bKNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694449107; x=1695053907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxqkzXGdJRSSdKxmHrLYYUfH6sMkTrkETk9cQkFIOkI=;
        b=YEcEFwXGsmP9akvZBsCTM/ERiSrQXAZK12pMr9aQvbvlNH4xoAovjlhuM1OvP3r+p4
         Cl7MJNDKa28ThwWLYE9D/3Bk37e/RNwuHBfLQGCNXKNVeP/1HsGiLO+arEMZNOTyL8Lb
         Jw7hoZkJTmMPtEAyJRsnIPM7zsfbujGmYObo5dQRknS5OATov/diePB5b01NGmepCu3N
         CyZ0+0iR/HYEoBS5coKeqkD3OMzs6NznRKLR/uhV80q3c0nlhOJ0Uohb4PS5klpuSwrz
         o3eHKyINhxBPTbLdVHGanPR/S6s3VtfvhiwG+sMGGV6UwHzJWWbPGcRLPFIRpZaF4WkD
         kCZw==
X-Gm-Message-State: AOJu0YyYVI4uInhiH5suNHmPg9MKE6USHydFvR01EIMP7l1pLu/1JZEu
        8lxayKLxHY/gtayE5snDg7Duq5ZIXF4LwDaxxxR2Zg==
X-Google-Smtp-Source: AGHT+IFZvmefUkG8Hg5A3gLjEuzm9CK876JACqnLSYrJQofROH+X81JIX6p/UzD1F3pmKCXk/x9sILhiqlv9AjEwvCA=
X-Received: by 2002:a05:651c:1994:b0:2bf:789e:b5dd with SMTP id
 bx20-20020a05651c199400b002bf789eb5ddmr6647548ljb.53.1694449107110; Mon, 11
 Sep 2023 09:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230910201445.GA1605059@google.com> <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com> <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
 <20230911131730.GA2291108@google.com> <8abef7d3-db8f-4a18-a72d-d23c1adb310d@paulmck-laptop>
In-Reply-To: <8abef7d3-db8f-4a18-a72d-d23c1adb310d@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 11 Sep 2023 12:18:16 -0400
Message-ID: <CAEXW_YSoy38WOxySWn=n_bx=T9MdBsRTx2myuRohm2h70ac9Gg@mail.gmail.com>
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 11, 2023 at 9:49=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Sep 11, 2023 at 01:17:30PM +0000, Joel Fernandes wrote:
> > On Mon, Sep 11, 2023 at 01:16:21AM -0700, Paul E. McKenney wrote:
> > > On Mon, Sep 11, 2023 at 02:27:25AM +0000, Joel Fernandes wrote:
> > > > On Sun, Sep 10, 2023 at 07:37:13PM -0400, Joel Fernandes wrote:
> > > > > On Sun, Sep 10, 2023 at 5:16=E2=80=AFPM Paul E. McKenney <paulmck=
@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, Sep 10, 2023 at 08:14:45PM +0000, Joel Fernandes wrote:
> > > > > [...]
> > > > > > > >  I have been running into another intermittent one as well =
which
> > > > > > > > is the boost failure and that happens once in 10-15 runs or=
 so.
> > > > > > > >
> > > > > > > > I was thinking of running the following configuration on an=
 automated
> > > > > > > > regular basis to at least provide a better clue on the luck=
y run that
> > > > > > > > catches an issue. But then the issue is it would change tim=
ing enough
> > > > > > > > to maybe hide bugs. I could also make it submit logs automa=
tically to
> > > > > > > > the list on such occurrences, but one step at a time and al=
l that.  I
> > > > > > > > do need to add (hopefully less noisy) tick/timer related tr=
ace events.
> > > > > > > >
> > > > > > > > # Define the bootargs array
> > > > > > > > bootargs=3D(
[...]
> > > > > > > So some insight on this boost failure. Just before the boost =
failures are
> > > > > > > reported, I see the migration thread interferring with the rc=
u_preempt thread
> > > > > > > (aka GP kthread). See trace below. Of note is that the rcu_pr=
eempt thread is
> > > > > > > runnable while context switching, which means its execution i=
s interferred.
> > > > > > > The rcu_preempt thread is at RT prio 2 as can be seen.
> > > > > > >
> > > > > > > So some open-ended questions: what exactly does the migration=
 thread want,
> > > > > > > this is something related to CPU hotplug? And if the migratio=
n thread had to
> > > > > > > run, why did the rcu_preempt thread not get pushed to another=
 CPU by the
> > > > > > > scheduler? We have 16 vCPUs for this test.
> > > > > >
> > > > > > Maybe we need a cpus_read_lock() before doing a given boost-tes=
t interval
> > > > > > and a cpus_read_unlock() after finishing one?  But much depends=
 on
> > > > > > exactly what is starting those migration threads.
> > > > >
> > > > > But in the field, a real RT task can preempt a reader without doi=
ng
> > > > > cpus_read_lock() and may run into a similar boost issue?
> > >
> > > The sysctl_sched_rt_runtime should prevent a livelock in most
> > > configurations.  Here, rcutorture explicitly disables this.
> >
> > I see. Though RT throttling will actually stall the rcu_preempt thread =
as
> > well in the real world. RT throttling is a bit broken and we're trying =
to fix
> > it in scheduler land. Even if there are idle CPUs, RT throttling will s=
tarve
> > not just the offending RT task, but all of them essentially causing a
> > priority inversion between running RT and CFS tasks.
>
> Fair point.  But that requires that the offending runaway RT task hit bot=
h
> a reader and the grace-period kthread.  Keeping in mind that rcutorture
> is provisioning one runaway RT task per CPU, which in the real world is
> hopefully quite rare.  Hopefully.  ;-)

You are right, I exaggerated a bit. Indeed in the real world, RT
throttling can cause a prio inversion with CFS only if all other CPUs
are also RT throttled. Otherwise it tries to migrate the RT task to
another CPU. That's a very great point.

> Sounds like good progress!  Please let me know how it goes!!!

Thanks! Will do,

 - Joel
