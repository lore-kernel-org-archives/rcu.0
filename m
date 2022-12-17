Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69936C4332F
	for <rcu@archiver.kernel.org>; Sat, 17 Dec 2022 03:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLQDUP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Dec 2022 22:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLQDUN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Dec 2022 22:20:13 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F174821894
        for <rcu@vger.kernel.org>; Fri, 16 Dec 2022 19:20:11 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id v11so3967390ljk.12
        for <rcu@vger.kernel.org>; Fri, 16 Dec 2022 19:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yPWSIbPpk8JUMS08GnwDNw3f0ZxjbC4NVfdxBuEV0c=;
        b=QZmh8q0k1ws9RAJeA/EkB3aaxZP3lONxotKkK3jNDtHsOy0k/9VFgNcNBXff5VVzxn
         7ZlRBfDcl6pvOtDBJgaKAi1pme5WqWzTytstWoD6uzMLQeuHDZXI3pBtFkzlPEJfpm31
         9lMIvcr4mtZ/Ys0RIO35oEi5XJNUU69R2nw0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yPWSIbPpk8JUMS08GnwDNw3f0ZxjbC4NVfdxBuEV0c=;
        b=f3W5fDy04+bsjMj+orUyr62kTaXruuSO5ZIDHIdn1CGIS2/TvsrRK+eWrZ6RF1ekRT
         yV55+dJ9Q5/EhcAJ2ToFSm8Mn8iT1sccIzzVugPOL0ZFvlw2+58JknRPNHFyGSoaiQ/P
         qLGk069Rseb1yEYWR6EpS6PO8fGbNAcR7M/eslqOPivKc8LtcbG4pNzzf6vwBpZQCHWT
         8a1BrH5p8QnHAW+HYVdHtoYfRn7JIDiki7w+mgBkJ8f9fK3/uaOjk9wnFuvdUJ26Utl8
         Z3Tl6w9OoO5eXPe/V/IJ1mE6aQf+JirJBtrhqmV1oBzOqleplatqIx9P2oAdatM92lv9
         R7Rw==
X-Gm-Message-State: ANoB5plrFZmYJ6fSkhPkJPof3zBcxncill438S6hHTkvOOAaR2/53SDl
        imtNqyuaERBMnWPhZOzFZvWjV1QoucJGAehIeNnhag==
X-Google-Smtp-Source: AA0mqf41HYcWgxgtjNfCCH0dAQLPDoGdcp2gPdSgP791jDAwtNCuLgz/Qpl2TXCHwTHSqnuCu0XR4j29MduK0vt3UTg=
X-Received: by 2002:a05:651c:90a:b0:277:309:73cb with SMTP id
 e10-20020a05651c090a00b00277030973cbmr33835497ljq.371.1671247210196; Fri, 16
 Dec 2022 19:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20221216165144.GA4001@paulmck-ThinkPad-P17-Gen-1> <54F1102C-2577-4238-83B3-D38BA7ED9087@joelfernandes.org>
In-Reply-To: <54F1102C-2577-4238-83B3-D38BA7ED9087@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 16 Dec 2022 22:19:58 -0500
Message-ID: <CAEXW_YTkeGVJZQCJ-_3ez_BpeMJ0TOYONCv_g76MDh5=M+9x_Q@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,
On the related subject of this function, I drew a diagram for one of
the reasons why per-CPU unlock counts have to be scanned first, for a
particular index, before the per-CPU lock counts, and not the other
way. Otherwise, a reader that got preempted after reading the index,
can suddenly get scheduled during the inactive index's scan, and cause
the total lock and unlock counts to falsely match:
https://i.imgur.com/79fDWdQ.png

Cheers,

 - Joel



On Fri, Dec 16, 2022 at 11:54 AM Joel Fernandes <joel@joelfernandes.org> wr=
ote:
>
>
>
> > On Dec 16, 2022, at 11:51 AM, Paul E. McKenney <paulmck@kernel.org> wro=
te:
> >
> > =EF=BB=BFOn Fri, Dec 16, 2022 at 04:32:39PM +0000, Joel Fernandes wrote=
:
> >> On Thu, Dec 15, 2022 at 05:09:14PM -0800, Paul E. McKenney wrote:
> >> [...]
> >>>>>> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the rea=
der
> >>>>>> has no new smp_mb() that happens AFTER the flip happened. So it ca=
n
> >>>>>> totally sample the old idx again -- that particular reader will
> >>>>>> increment twice, but the next time, it will see the flipped one.
> >>>>>
> >>>>> I will let you transliterate both.  ;-)
> >>>>
> >>>> I think I see what you mean now :)
> >>>>
> >>>> I believe the access I am referring to is the read of idx on one sid=
e and
> >>>> the write to idx on the other. However that is incomplete and I need=
 to
> >>>> pair that with some of other access on both sides.
> >>>>
> >>>> So perhaps this:
> >>>>
> >>>> Writer does flip + smp_mb + read unlock counts [1]
> >>>>
> >>>> Reader does:
> >>>> read idx + smp_mb() + increment lock counts [2]
> >>>>
> >>>> And subsequently reader does
> >>>> Smp_mb() + increment unlock count. [3]
> >>>>
> >>>> So [1] races with either [2] or [2]+[3].
> >>>>
> >>>> Is that fair?
> >>>
> >>> That does look much better, thank you!
> >>
> >> Perhaps a comment with an ASCII diagram will help?
> >>
> >>
> >> Case 2:
> >> Both the reader and the updater see each other's writes too late, but =
because
> >> of memory barriers on both sides, they will eventually see each other'=
s write
> >> with respect to their own. This is similar to the store-buffer problem=
. This
> >> let's a single reader contribute a maximum (unlock minus lock) imbalan=
ce of 2.
> >>
> >> The following diagram shows the subtle worst case followed by a simpli=
fied
> >> store-buffer explanation.
> >>
> >> READER                  UPDATER
> >> -------------           ----------
> >>                           // idx is initially 0.
> >> read_lock() {
> >>  READ(idx) =3D 0;
> >>  lock[0]++; --------------------------------------------,
> >>                           flip() {                      |
> >>                              smp_mb();                  |
> >>  smp_mb();                                              |
> >> }                                                        |
> >>                                                         |
> >> // RSCS                                                  |
> >>                                                         |
> >> read_unlock() {                                          |
> >>  smp_mb();                                              |
> >>                              idx++;  // P               |
> >>                              smp_mb();                  |
> >>                           }                             |
> >>                                                         |
> >>                           scan_readers_idx(0) {         |
> >>                               count all unlock[0];      |
> >>                                   |                     |
> >>                                   |                     |
> >>  unlock[0]++; //X <--not-counted--`-----,               |
> >>                                         |               |
> >> }                                        V               `------,
> >>                               // Will make sure next scan      |
> >>                               // will not miss this unlock (X) |
> >>                               // if other side saw flip (P) ,--`
> >>                               // Call this MB [1]           |
> >>                               // Order write(idx) with      |
> >>                               // next scan's unlock.        |
> >>                               smp_mb();                 ,---`
> >> read_lock() {                                            |
> >>  READ(idx)=3D0;                                           |
> >>  lock[0]++; ----------------> count all lock[0];        |
> >>  smp_mb();         |     }                              |
> >> }     |             |                                    V
> >>      |             `---> // Incorrect contribution to lock counting
> >>      |                   // upto a maximum of 2 times.
> >>      |
> >>       `---> // Pairs with MB [1]. Makes sure that
> >>             // the next read_lock()'s' idx read (Y) is ordered
> >>             // with above write to unlock[0] (X).
> >>                            |
> >> rcu_read_unlock() {         |
> >>  smp_mb(); <---------------`
> >>  unlock[0]++;
> >> }
> >>
> >> read_lock() {
> >>  READ(idx) =3D 1; //Y
> >>  lock[1]++;
> >>  ...
> >> }
> >>                           scan_readers_idx(0) {
> >>                               count all unlock[0]; //Q
> >>                               ...
> >>
> >>
> >> thanks,
> >>
> >> - Joel
> >>
> >>                          }
> >>
> >> This makes it similar to the store buffer pattern. Using X, Y, P and Q
> >> annotated above, we get:
> >>
> >> READER                    UPDATER
> >> X (write)                 P (write)
> >>
> >> smp_mb();                 smp_mb();
> >>
> >> Y (read)                  Q (read)
> >
> > Given that this diagram is more than 50 lines long, it might go better =
in
> > a design document describing this part of RCU.  Perhaps less detail or
> > segmented, but the same general idea as this guy:
> >
> > Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
>
> Yes, this sounds like a good place to add it and perhaps we refer to it f=
rom the C source file? I can take this up to do over the holidays, if you p=
refer.
>
> Thanks,
>
>   - Joel
>
>
> >
> > Thoughts?
> >
> >                        Thanx, Paul
