Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A3C74A4B
	for <rcu@archiver.kernel.org>; Mon, 13 Mar 2023 15:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCMPuN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Mar 2023 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCMPuM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Mar 2023 11:50:12 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC984390E
        for <rcu@vger.kernel.org>; Mon, 13 Mar 2023 08:50:10 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54184571389so100626287b3.4
        for <rcu@vger.kernel.org>; Mon, 13 Mar 2023 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678722609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iW9eWE9NBCqdF7gHlLZZ8u43ku6/ZzsHeKSlLd8JDp0=;
        b=F3CIhOjDkPVc+XmlQ/czoOX5hVBGuAHEACBeFs+UfSWienWD2LvcNlf5TA4tnI/mOS
         dffhWQjNYnFnafNUZldAe6zEcGmLrJmov05ZjMqSLlQKl0pv/hfTrDyEhV7E+g0sYIPl
         nJQvLRwY0lSa54PNb9/uYm3YF2N/hTE3s3T48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678722609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iW9eWE9NBCqdF7gHlLZZ8u43ku6/ZzsHeKSlLd8JDp0=;
        b=taNVWb8yLCmkjrweG82+BYk+DiFQDiwUKTgsMItpXDMSEFNtl8WhAeGQrajDPdrXEZ
         jabgGnyCcx0uPNhMPOCBAARlxY8kqsmDxc6cmRlrZ8Caf777EK3VKFX+yyeiz2xA53oD
         iHd8XUDK+N6m6ao3jCAgEK9m9gijmAWDEmvwBrf9KIYkL0wj7YGUcBxM7+6aNjmCfiSg
         4GFePZrnguBb4H6MAfQ0lLwlFnJji+ysLURz9QC/3aacN7H1GNPCdflp9LkkM+3UArTB
         JmN3/+TEErlquxIyLFMwkhj/YcsJqyRWhd7hfqcqrRwGPvoFd4sUFLKX85QM9x05wVXO
         9J6Q==
X-Gm-Message-State: AO0yUKUzuvZEJWK2bYCslk+bAyibJeUKdVkYgu4mFjyI2KArYz8T3AZj
        UpM/SOOQCXnkm6VvasWY/AjJ3YPQWBOWvGAUtnlcuA==
X-Google-Smtp-Source: AK7set93XnH7B7UWweZSF01icSoI1DL2P3OA/DvGdGm2LfcrW3o70OzGqcxrxveIAhkLwMW4FKyl66aAV2hhYM4tN5c=
X-Received: by 2002:a81:ad66:0:b0:52e:e8b1:d51e with SMTP id
 l38-20020a81ad66000000b0052ee8b1d51emr8123390ywk.1.1678722609593; Mon, 13 Mar
 2023 08:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <ZA7yK6iznHqiBu5i@pc636> <01559085-EB77-4962-B5EF-FF767F5A7353@joelfernandes.org>
 <ZA9B+sgrlK5yommJ@pc636>
In-Reply-To: <ZA9B+sgrlK5yommJ@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 13 Mar 2023 11:49:58 -0400
Message-ID: <CAEXW_YTgDM+47rfz0XNjeV8MMPnhyfCcXX+o74SqONvwd4wfzA@mail.gmail.com>
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 13, 2023 at 11:32=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com=
> wrote:
>
> On Mon, Mar 13, 2023 at 06:58:30AM -0700, Joel Fernandes wrote:
> >
> >
> > > On Mar 13, 2023, at 2:51 AM, Uladzislau Rezki <urezki@gmail.com> wrot=
e:
> > >
> > > =EF=BB=BFOn Fri, Mar 10, 2023 at 10:24:34PM -0800, Paul E. McKenney w=
rote:
> > >>> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> > >>> On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > >>>> On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > >>>> [..]
> > >>>>>>>>>> See this commit:
> > >>>>>>>>>>
> > >>>>>>>>>> 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > >>>>>>>>>> expedited RCU primitives")
> > >>>>>>>>>>
> > >>>>>>>>>> Antti provided this commit precisely in order to allow Andro=
id
> > >>>>>>>>>> devices to expedite the boot process and to shut off the
> > >>>>>>>>>> expediting at a time of Android userspace's choosing.  So An=
droid
> > >>>>>>>>>> has been making this work for about ten years, which strikes=
 me
> > >>>>>>>>>> as an adequate proof of concept.  ;-)
> > >>>>>>>>>
> > >>>>>>>>> Thanks for the pointer. That's true. Looking at Android sourc=
es, I
> > >>>>>>>>> find that Android Mediatek devices at least are setting
> > >>>>>>>>> rcu_expedited to 1 at late stage of their userspace boot (whi=
ch is
> > >>>>>>>>> weird, it should be set to 1 as early as possible), and
> > >>>>>>>>> interestingly I cannot find them resetting it back to 0!.  Ma=
ybe
> > >>>>>>>>> they set rcu_normal to 1? But I cannot find that either. Vlad=
? :P
> > >>>>>>>>
> > >>>>>>>> Interesting.  Though this is consistent with Antti's commit lo=
g,
> > >>>>>>>> where he talks about expediting grace periods but not unexpedi=
ting
> > >>>>>>>> them.
> > >>>>>>>>
> > >>>>>>> Do you think we need to unexpedite it? :))))
> > >>>>>>
> > >>>>>> Android runs on smallish systems, so quite possibly not!
> > >>>>>>
> > >>>>> We keep it enabled and never unexpedite it. The reason is a perfo=
rmance.  I
> > >>>>> have done some app-launch time analysis with enabling and disabli=
ng of it.
> > >>>>>
> > >>>>> An expedited case is much better when it comes to app launch time=
. It
> > >>>>> requires ~25% less time to run an app comparing with unexpedited =
variant.
> > >>>>> So we have a big gain here.
> > >>>>
> > >>>> Wow, that's huge. I wonder if you can dig deeper and find out why =
that is so
> > >>>> as the callbacks may need to be synchronize_rcu_expedited() then, =
as it could
> > >>>> be slowing down other usecases! I find it hard to believe, real-ti=
me
> > >>>> workloads will run better without those callbacks being always-exp=
edited if
> > >>>> it actually gives back 25% in performance!
> > >>>>
> > >>> I can dig further, but on a high level i think there are some spots
> > >>> which show better performance if expedited is set. I mean synchroni=
ze_rcu()
> > >>> becomes as "less blocking a context" from a time point of view.
> > >>>
> > >>> The problem of a regular synchronize_rcu() is - it can trigger a bi=
g latency
> > >>> delays for a caller. For example for nocb case we do not know where=
 in a list
> > >>> our callback is located and when it is invoked to unblock a caller.
> > >>
> > >> True, expedited RCU grace periods do not have this callback-invocati=
on
> > >> delay that normal RCU does.
> > >>
> > >>> I have already mentioned somewhere. Probably it makes sense to dire=
ctly wake-up
> > >>> callers from the GP kthread instead and not via nocb-kthread that i=
nvokes our callbacks
> > >>> one by one.
> > >>
> > >> Makes sense, but it is necessary to be careful.  Wakeups are not fas=
t,
> > >> so making the RCU grace-period kthread do them all sequentially is n=
ot
> > >> a strategy to win.  For example, note that the next expedited grace
> > >> period can start before the previous expedited grace period has fini=
shed
> > >> its wakeups.
> > >>
> > > I hove done a small and quick prototype:
> > >
> > > <snip>
> > > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_w=
ait.h
> > > index 699b938358bf..e1a4cca9a208 100644
> > > --- a/include/linux/rcupdate_wait.h
> > > +++ b/include/linux/rcupdate_wait.h
> > > @@ -9,6 +9,8 @@
> > > #include <linux/rcupdate.h>
> > > #include <linux/completion.h>
> > >
> > > +extern struct llist_head gp_wait_llist;
> > > +
> > > /*
> > >  * Structure allowing asynchronous waiting on RCU.
> > >  */
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index ee27a03d7576..50b81ca54104 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -113,6 +113,9 @@ int rcu_num_lvls __read_mostly =3D RCU_NUM_LVLS;
> > > int num_rcu_lvl[] =3D NUM_RCU_LVL_INIT;
> > > int rcu_num_nodes __read_mostly =3D NUM_RCU_NODES; /* Total # rcu_nod=
es in use. */
> > >
> > > +/* Waiters for a GP kthread. */
> > > +LLIST_HEAD(gp_wait_llist);
> > > +
> > > /*
> > >  * The rcu_scheduler_active variable is initialized to the value
> > >  * RCU_SCHEDULER_INACTIVE and transitions RCU_SCHEDULER_INIT just bef=
ore the
> > > @@ -1776,6 +1779,14 @@ static noinline void rcu_gp_cleanup(void)
> > >                on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > > }
> > >
> > > +static void rcu_notify_gp_end(struct llist_node *llist)
> > > +{
> > > +       struct llist_node *rcu, *next;
> > > +
> > > +       llist_for_each_safe(rcu, next, llist)
> > > +               complete(&((struct rcu_synchronize *) rcu)->completio=
n);
> >
> > This looks broken to me, so the synchronize will complete even
> > if it was called in the middle of an ongoing GP?
> >
> Do you mean before replacing the list(and after rcu_gp_cleanup()) a new
> GP sequence can be initiated?

I guess I mean rcu_notify_gp_end() is called at the end of the current
grace period, which might be the grace period which started _before_
the synchronize_rcu() was called. So the callback needs to be invoked
after the end of the next grace period, not the current one.

Did I miss some part of your patch that is handling this?

thanks,

 - Joel
