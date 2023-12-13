Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="T+yT1UNp"
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2F899
	for <rcu@vger.kernel.org>; Wed, 13 Dec 2023 11:01:38 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9f4bb2e5eso101312211fa.1
        for <rcu@vger.kernel.org>; Wed, 13 Dec 2023 11:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702494096; x=1703098896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk7jO9SMIKHUyFnn0B2awK+sOxOmjadDlSFGy0G4gN0=;
        b=T+yT1UNpiYK7SC5UahJEMuPESFl8dIoAbPqPr7pdXrl6pqSv1/qprMxRSk5PLtMLU/
         SAJftnuILQVwbapDZRRl6loUKC+Y+mKI0qg1pTnyH/lNqucDLu8TN2P1nR+QXWUM8VBG
         yZus09WIQBTen3JZE5GPA/qe5vOrGvlDywiT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494096; x=1703098896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jk7jO9SMIKHUyFnn0B2awK+sOxOmjadDlSFGy0G4gN0=;
        b=VCKjaO6GbG2UKOjq8jVrZW81zzqOhSAKJi6jFkaI7896JJ0IQMmGVieLJE8Ip9VRut
         zwF66S6I9miv14/Pod8cqE8HYU++uByQitpEFreTz2oPkfLeWhcCigbOIkg71p2dNMVY
         o0rhTdYVZ6aLDu7X/MHYzpsT/ytYIhhzrtS8dVy6ACCCub2pG1ynq7UIjehGZjG+sh7F
         rm/i/xE4H3tY0sqM0GB+rAwK5820K4/Tp6XP/MyncWZSaWH8RHs3xzqxmBasXKoJN9sk
         mzvSZP2upo+0l2oMEwYZggnnQ9Ux1TIgcmFpdiGPinJghBhh0rsK/6xsIDy7YdbWQoBJ
         ADRA==
X-Gm-Message-State: AOJu0YyGlnMu1f2rNChV/FwOg2YqPaHP+dn9Eo7V4GoCrtQOLt5BW36+
	iQv6Cp1hz3ltRoi4kT8g/uaCpPwW4LARg2kb3UY6vw==
X-Google-Smtp-Source: AGHT+IHUiBGmGmCDZkgJjMjAbv/88SjIy7e4LsWylDCnb8btk33H2n/M/m26XAoHjbSnD8TspXoKRlbo+V3F7FbXBX8=
X-Received: by 2002:a2e:3909:0:b0:2cc:1fc1:e209 with SMTP id
 g9-20020a2e3909000000b002cc1fc1e209mr2704810lja.88.1702494096410; Wed, 13 Dec
 2023 11:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212174750.GA11886@neeraj.linux> <20231212174817.11919-3-neeraj.iitr10@gmail.com>
 <CAEXW_YRHjdM+NA3CqNuwaRNXkRWbtypmt5Ov=YXnrpn3Eo-==Q@mail.gmail.com>
 <2b2c1573-337d-409b-a8ee-daeff096c7f4@paulmck-laptop> <CAEXW_YQnR51F9xnODZd3iE+S5Jpd2NHRBTk6Jt2WHTSdB9H8kA@mail.gmail.com>
 <9109c700-a353-4b12-a7c5-2f67e9ab4e86@paulmck-laptop>
In-Reply-To: <9109c700-a353-4b12-a7c5-2f67e9ab4e86@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 13 Dec 2023 14:01:24 -0500
Message-ID: <CAEXW_YRhf71h7_jwYAYLFXN=B6_cK7AMoGgWFXAUQfkUjkmiXA@mail.gmail.com>
Subject: Re: [PATCH rcu 3/3] srcu: Explain why callbacks invocations can't run concurrently
To: paulmck@kernel.org
Cc: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	Neeraj.Upadhyay@amd.com, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:55=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Dec 13, 2023 at 01:35:22PM -0500, Joel Fernandes wrote:
> > On Wed, Dec 13, 2023 at 12:52=E2=80=AFPM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 09:27:09AM -0500, Joel Fernandes wrote:
> > > > On Tue, Dec 12, 2023 at 12:48=E2=80=AFPM Neeraj Upadhyay (AMD)
> > > > <neeraj.iitr10@gmail.com> wrote:
> > > > >
> > > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > > >
> > > > > If an SRCU barrier is queued while callbacks are running and a ne=
w
> > > > > callbacks invocator for the same sdp were to run concurrently, th=
e
> > > > > RCU barrier might execute too early. As this requirement is non-o=
bvious,
> > > > > make sure to keep a record.
> > > > >
> > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> > > > > ---
> > > > >  kernel/rcu/srcutree.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > index 2bfc8ed1eed2..0351a4e83529 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -1715,6 +1715,11 @@ static void srcu_invoke_callbacks(struct w=
ork_struct *work)
> > > > >         WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, R=
CU_NEXT_TAIL));
> > > > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > > > >                               rcu_seq_current(&ssp->srcu_sup->src=
u_gp_seq));
> > > > > +       /*
> > > > > +        * Although this function is theoretically re-entrant, co=
ncurrent
> > > > > +        * callbacks invocation is disallowed to avoid executing =
an SRCU barrier
> > > > > +        * too early.
> > > > > +        */
> > > >
> > > > Side comment:
> > > > I guess even without the barrier reasoning, it is best not to allow
> > > > concurrent CB execution anyway since it diverges from the behavior =
of
> > > > straight RCU :)
> > >
> > > Good point!
> > >
> > > But please do not forget item 12 on the list in checklist.rst.  ;-)
> > > (Which I just updated to include the other call_rcu*() functions.)
> >
> > I think this is more so now with recent kernels (with the dynamic nocb
> > switch) than with older kernels right? I haven't kept up with the
> > checklist recently (which is my bad).
>
> You are quite correct!  But even before this, I was saying that
> lack of same-CPU callback concurrency was an accident of the current
> implementation rather than a guarantee.  For example, there might come
> a time when RCU needs to respond to callback flooding with concurrent
> execution of the flooded CPU's callbacks.  Or not, but we do need to
> keep this option open.

Got it, reminds me to focus on requirements as well along with implementati=
on.

> > My understanding comes from the fact that the RCU barrier depends on
> > callbacks on the same CPU executing in order with straight RCU
> > otherwise it breaks. Hence my comment. But as you pointed out, that's
> > outdated knowledge.
>
> That is still one motivation for ordered execution of callbacks.  For the
> dynamic nocb switch, we could have chosen to make rcu_barrier() place
> a callback on both lists, but we instead chose to exclude rcu_barrier()
> calls during the switch.

Right!

> > I should just shut up and hide in shame now.
>
> No need for that!  After all, one motivation for Requirements.rst was
> to help me keep track of all this stuff.

Thanks!

 - Joel
