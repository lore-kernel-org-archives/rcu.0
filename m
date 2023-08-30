Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E46C83F14
	for <rcu@archiver.kernel.org>; Wed, 30 Aug 2023 21:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbjH3Vlo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Aug 2023 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbjH3Vlo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Aug 2023 17:41:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0618E10D4
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 14:41:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50078e52537so506915e87.1
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693431600; x=1694036400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5DJzy56A/nwYm3Fh8L0N2T0VZK9ewMIuVyotil1TqE=;
        b=aqnOLvCws+ZIXNGtjpG9FHpHcxFrRDz2iC9EcqiSMaLyVVNw4EIYAxRnztu5BgRT6v
         ZchWw9DbaYuBI5QeU7zvdjFG3ZlD7EXbtNaFtCt49MHLUVuQuw9+7UGkoTUgTtmzGJR5
         XJcKwu3bfYOflPF/0uw1aveUPCDfFUjDuhYe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693431600; x=1694036400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5DJzy56A/nwYm3Fh8L0N2T0VZK9ewMIuVyotil1TqE=;
        b=kNVlLvAqTkFWG3L7JiRQ3DY118ZnEe1eDOdBLioWR7dLOYdd1BThEMr6jRJB6x5qAX
         82npyFOm0tg6LNnuAx0j/46kKnRp3kw+0Y0pHmDDJi0VUMhbg61fy8AKxT11V50mO4Fs
         krATe6+xJqmQozma8dJ9TyxhX4OVFsgIj22b+C8NG1VFnOMNN8Y76oBMWPAarEsAZGRc
         Qwf9wboQAwNDTTPhYx01hLX2Bo8i1PQXPkZrDGOtzyIKPRA/+clTa2+TlriYEkfMaVx6
         vEEzUH0i6Abyf5cVnyxw24D+GwcB9xrH2tJODJ7o0Zjx1kqXijTJY2+HxNHQV5F1QwfB
         EIzQ==
X-Gm-Message-State: AOJu0YxwJxSNb0HpaBq5FgovVflZHs+w/Nc2XEiThE+xGrZzdrPP+xX5
        kVs+840oUAFRKqUYaKcsKOmcgvtm3rcQ7tE1V4NeZBaQyAYgAwK7zbE=
X-Google-Smtp-Source: AGHT+IH0q0mDwWYyHqx0XTJ/0WX+KbgZ/mMfiBziyqml/CVcnPVo81k3hfHqZRcz7ObX/cg2PXCEUpH12fZr0OZ+f+Q=
X-Received: by 2002:a2e:b6c2:0:b0:2bb:9781:1a4c with SMTP id
 m2-20020a2eb6c2000000b002bb97811a4cmr3108409ljo.27.1693430871551; Wed, 30 Aug
 2023 14:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230729142738.222208-1-joel@joelfernandes.org>
 <20230729142738.222208-5-joel@joelfernandes.org> <ZO4EdIM/JtelKHFH@lothringen>
In-Reply-To: <ZO4EdIM/JtelKHFH@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Aug 2023 17:27:43 -0400
Message-ID: <CAEXW_YS-0X7TEr0n4p1VYx0VvqVWVWRrm45ydaQkrcHhQ0uM2w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] tree/nocb: Improve readability of nocb_gp_wait()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        paulmck@kernel.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 29, 2023 at 10:45=E2=80=AFAM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> On Sat, Jul 29, 2023 at 02:27:34PM +0000, Joel Fernandes (Google) wrote:
> >  /*
> >   * No-CBs GP kthreads come here to wait for additional callbacks to sh=
ow up
> >   * or for grace periods to end.
> >   */
> >  static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  {
> > -     bool bypass =3D false;
> >       int __maybe_unused cpu =3D my_rdp->cpu;
> >       unsigned long cur_gp_seq;
> >       unsigned long flags;
> >       bool gotcbs =3D false;
> > -     unsigned long j =3D jiffies;
> > -     bool lazy =3D false;
> >       bool needwait_gp =3D false; // This prevents actual uninitialized=
 use.
> >       bool needwake;
> >       bool needwake_gp;
> > +     int defer_wake_type =3D RCU_NOCB_WAKE_NOT;
> >       struct rcu_data *rdp, *rdp_toggling =3D NULL;
> >       struct rcu_node *rnp;
> >       unsigned long wait_gp_seq =3D 0; // Suppress "use uninitialized" =
warning.
> > @@ -712,44 +758,24 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >        * won't be ignored for long.
> >        */
> >       list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) =
{
> > -             long bypass_ncbs;
> > -             bool flush_bypass =3D false;
> > -             long lazy_ncbs;
> > +             int defer_wake_type_one =3D RCU_NOCB_WAKE_NOT;
>
> No need to initialize it, nocb_gp_flush_wake() always returns a value, an=
d
> it will avoid mistakes in the future if nocb_gp_flush_wake() is moved and
> accidentally not called.

Compiler does not like that if it is not initialized:
tree_nocb.h:821:51: error: =E2=80=98defer_wake_type=E2=80=99 is used uninit=
ialized
[-Werror=3Duninitialized]

> > +             bool flushed;
> > +             bool empty;
> >
> > -             trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"=
));
> >               rcu_nocb_lock_irqsave(rdp, flags);
> > -             lockdep_assert_held(&rdp->nocb_lock);
> > -             bypass_ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > -             lazy_ncbs =3D READ_ONCE(rdp->lazy_len);
> > +             defer_wake_type_one =3D nocb_gp_flush_wake(rdp, &empty, &=
flushed);
> >
> > -             if (bypass_ncbs && (lazy_ncbs =3D=3D bypass_ncbs) &&
> > -                 (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + ji=
ffies_till_flush) ||
> > -                  bypass_ncbs > 2 * qhimark)) {
> > -                     flush_bypass =3D true;
> > -             } else if (bypass_ncbs && (lazy_ncbs !=3D bypass_ncbs) &&
> > -                 (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1)=
 ||
> > -                  bypass_ncbs > 2 * qhimark)) {
> > -                     flush_bypass =3D true;
> > -             } else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cbli=
st)) {
> > -                     rcu_nocb_unlock_irqrestore(rdp, flags);
> > -                     continue; /* No callbacks here, try next. */
> > -             }
> > +             // We may need to do a deferred wakeup later for bypass/l=
azy
> > +             // So note down what we learnt from the rdp.
> > +             defer_wake_type =3D max(defer_wake_type_one, defer_wake_t=
ype);
> >
> > -             if (flush_bypass) {
> > -                     // Bypass full or old, so flush it.
> > -                     (void)rcu_nocb_try_flush_bypass(rdp, j);
> > -                     bypass_ncbs =3D rcu_cblist_n_cbs(&rdp->nocb_bypas=
s);
> > -                     lazy_ncbs =3D READ_ONCE(rdp->lazy_len);
> > +             // Did we make any updates to main cblist? If not, no
> > +             // non-deferred wake up to do for this rdp.
> > +             if (!flushed && empty) {
>
> Can you ever have (flushed && empty) ? If not you should be able to remov=
e the
> flushed parameter.

We can return 3 different states from the new nocb_gp_flush_wake():
1. flushed =3D true and empty =3D false
2. flushed =3D false and empty =3D true
3. flushed =3D false and empty =3D false

I guess you mean, we don't care about case #1 and #3 ?

That's a good point. What I will do then is pass a single bool
"wakeup" and and set it for case #2 from within the
nocb_gp_flush_wake().

Thanks!

 - Joel
