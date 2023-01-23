Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E657AC38142
	for <rcu@archiver.kernel.org>; Mon, 23 Jan 2023 15:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjAWPXo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjAWPXb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Jan 2023 10:23:31 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5E29414
        for <rcu@vger.kernel.org>; Mon, 23 Jan 2023 07:22:34 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id g14so13446186ljh.10
        for <rcu@vger.kernel.org>; Mon, 23 Jan 2023 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlQ4uFJF8luICaZz9X8rsfnPJTK43Q09mIidIvdivig=;
        b=eGzk9GshCU7cFcuCxU4wS13X3ucoFt2bijXDYi7cpQFXb1i5pbtaTFdh2tAo3ktz7B
         /E5y+EfEppTO62lNGUoqDDMB1QR9Ql6lxmPW9WQQCQ2apqofcaZIRqjJcI0Nd6Tsd1nz
         URLLlNS2VJaW3e9vktdvBv634wmzQHST+ZGF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlQ4uFJF8luICaZz9X8rsfnPJTK43Q09mIidIvdivig=;
        b=dbaSzwtb145cltHcN424zn2PxwjYK+iSx6JfH6nDL23oyUTyRxJT5NwpONXPZ9Niia
         SZtZer0Tj5ZX4Akt8TGzqYmYouwrM4OwdzCWeUPDGOqaSSBxIwi03QHzzIDjUuD/7a9I
         OKHibqjo48VwufU72ktMHyD1nNS7fAOsy/WWPvSc4IyUxsHFb8GE4YiVK/nG9DbL0Iu/
         HZGH1o4xvOazURZXHABN2nGZauPopcR70MZQnp/1xiG95WnAah+9Or4tNGUvFr1Lx9gO
         nClGoN3+vSVw2UPRkENWN6Ulju4rXzfZCFEpW7QILUnj+1ezOFt26I1/5Qi8hiQkj550
         W/dg==
X-Gm-Message-State: AFqh2koFlsVqiL9uQiU5GB3QoSQyuZquuTSOwt/LVk0l77FB5UX7imTg
        SS8jXPhFnyMTArWisC+UsO7CTJPomMz5J7fku7tfGQ==
X-Google-Smtp-Source: AMrXdXsOBFPqVmUsprncB4I98OFPJNh7h2zhsGDwtNxEsEMk1Pe4AQgHpa0VNMJ3KrWKDOsIJwYLTUJ0EhSfNIA0uvM=
X-Received: by 2002:a2e:2e08:0:b0:28b:8253:1a32 with SMTP id
 u8-20020a2e2e08000000b0028b82531a32mr1676771lju.483.1674487350784; Mon, 23
 Jan 2023 07:22:30 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR11MB5880A16045A842AB80A25C4BDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org> <Y8seE8Tr1w0UWf+m@lothringen>
In-Reply-To: <Y8seE8Tr1w0UWf+m@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 23 Jan 2023 10:22:19 -0500
Message-ID: <CAEXW_YTTk_zETWy=xpL-8wF8vh6s_U5z9UyS17uBMda1BYpvug@mail.gmail.com>
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Frederic,

On Fri, Jan 20, 2023 at 6:04 PM Frederic Weisbecker <frederic@kernel.org> w=
rote:
>
> On Fri, Jan 20, 2023 at 08:27:03AM -0500, Joel Fernandes wrote:
> >
> > Sure, I know what the code currently does, I am asking why and it feels=
 wrong.
> >
> > I suggest you slightly change your approach to not assuming the code sh=
ould be bonafide correct and then fixing it (which is ok once in a while), =
and asking higher level questions to why things are the way they are in the=
 first place (that is just my suggestion and I am not in a place to provide=
 advice, far from it, but I am just telling you my approach =E2=80=94 I car=
e more about the code than increasing my patch count :P).
> >
> > If you are in an intermediate state, part way to a !nocb state =E2=80=
=94 you may have
> > missed a nocb-related accel and wake, correct? Why does that matter? On=
ce we
> > transition to a !nocb state, we do not do a post-qs-report accel+wake a=
nyway
> > as we clearly know from the discussion.
>
> I'm confused. We are doing that acceleration on qs report for !nocb CPU, =
right?
>
> > So why do we need to do it if we
> > missed it for the intermediate stage? So, I am not fully sure yet what =
that
> > needac is doing and why it is needed.
>
> To summarize:
>
> * If the CPU is NOCB, all the callbacks advance and acceleration is perfo=
rmed
>   by the rcuo/rcuog kthreads.
>
> * If the CPU is not NOCB, all the callbacks acceleration is performed by =
the
>   CPU, such as in the case of rcu_report_qs_rdp().
>
> * If the CPU is transitionning from NOCB to !NOCB or from !NOCB to NOCB, =
the
>   kthreads may not be available to do the advance/acceleration, so we mus=
t do
>   it locally. That's the needacc path.

Sure, I agree it "must be done locally" for the benefit of the
half-way transition.

> What am I missing?

That the acceleration is also done by __note_gp_changes() once the
grace period ends anyway, so if any acceleration was missed as you
say, it will be done anyway.

Also it is done by scheduler tick raising softirq:

rcu_pending() does this:
        /* Has RCU gone idle with this CPU needing another grace period? */
        if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
            !rcu_rdp_is_offloaded(rdp) &&
            !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
                return 1;

and rcu_core():
        /* No grace period and unregistered callbacks? */
        if (!rcu_gp_in_progress() &&
            rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
                rcu_nocb_lock_irqsave(rdp, flags);
                if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_T=
AIL))
                        rcu_accelerate_cbs_unlocked(rnp, rdp);
                rcu_nocb_unlock_irqrestore(rdp, flags);
        }

So, I am not sure if you need needacc at all. Those CBs that have not
been assigned grace period numbers will be taken care off :)

Thanks!

  -Joel
