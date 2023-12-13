Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qv7D4Gyg"
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7CEAB
	for <rcu@vger.kernel.org>; Wed, 13 Dec 2023 10:35:35 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2cc3facf0c0so2012661fa.0
        for <rcu@vger.kernel.org>; Wed, 13 Dec 2023 10:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702492534; x=1703097334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv+5XsUdJVuk8GOh1DuytA+yuMqTKKF6sR66teLcGMU=;
        b=qv7D4Gyg7PjuBe8+/3qFwd8oRLfSAXelbFfnSkV+PDSmr9rJ7sypzaGeFiVb4vmwjn
         03zTxKHs4E8X3uQuKChdTGFeX7Dki0eaW6/7Ta5q1dVpVI4NUaipTWv8a/5rccMowBC8
         1LzzFvgm9bWC0anuRpGLRQj4yP4SwAReNcT88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492534; x=1703097334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv+5XsUdJVuk8GOh1DuytA+yuMqTKKF6sR66teLcGMU=;
        b=K52Peu3BOt5sjWFH9bZnUvZ6t91GFJNFDY99K1VcUuxI5x5JU1l+kPuizNco9CcOhj
         x/qT01a3eBfkh+HqicL+Pl0g1xbVD83gQc1oeE0YA+qbSNJUA9CjeKhPlIkrGK1ues09
         du4vtYLoFGYoyfvwehPHAQ80v4WUGit4j3MXiou1Bm2B/dEDFkPCufqMA/OuOw43hNd5
         edoeXZ/re6X6yek4Zaw1K2jZ+mpWMCL898WnmMG3rJoHClrrp3IPRwpJNC8UbWZ741mc
         rXHPTEcEJEX8PABgt9VKclTIzio7Z8BynyXjgiC0IuAveodBXUjyQ7YQ1wkCbtws3MmJ
         z0Mw==
X-Gm-Message-State: AOJu0YzftsmdZUmsGd7nx7K+AjpslbgEepfAIejkfYLK4Lxh4q1BB6VZ
	G2fAvk9pjuaNzx00xPzHLVMvgo/r3f2YlC86bHK2Vg==
X-Google-Smtp-Source: AGHT+IF98/Eb//7DFZtThhYC5gn2eqT/lGOfRQfhM6QVrDzFFDAch/dR4KHz4VQs4C66M1mY9YscTVbF02261clQEW0=
X-Received: by 2002:a2e:9f4a:0:b0:2cc:3dac:2e8 with SMTP id
 v10-20020a2e9f4a000000b002cc3dac02e8mr351771ljk.26.1702492534092; Wed, 13 Dec
 2023 10:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212174750.GA11886@neeraj.linux> <20231212174817.11919-3-neeraj.iitr10@gmail.com>
 <CAEXW_YRHjdM+NA3CqNuwaRNXkRWbtypmt5Ov=YXnrpn3Eo-==Q@mail.gmail.com> <2b2c1573-337d-409b-a8ee-daeff096c7f4@paulmck-laptop>
In-Reply-To: <2b2c1573-337d-409b-a8ee-daeff096c7f4@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 13 Dec 2023 13:35:22 -0500
Message-ID: <CAEXW_YQnR51F9xnODZd3iE+S5Jpd2NHRBTk6Jt2WHTSdB9H8kA@mail.gmail.com>
Subject: Re: [PATCH rcu 3/3] srcu: Explain why callbacks invocations can't run concurrently
To: paulmck@kernel.org
Cc: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	Neeraj.Upadhyay@amd.com, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:52=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Dec 13, 2023 at 09:27:09AM -0500, Joel Fernandes wrote:
> > On Tue, Dec 12, 2023 at 12:48=E2=80=AFPM Neeraj Upadhyay (AMD)
> > <neeraj.iitr10@gmail.com> wrote:
> > >
> > > From: Frederic Weisbecker <frederic@kernel.org>
> > >
> > > If an SRCU barrier is queued while callbacks are running and a new
> > > callbacks invocator for the same sdp were to run concurrently, the
> > > RCU barrier might execute too early. As this requirement is non-obvio=
us,
> > > make sure to keep a record.
> > >
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> > > ---
> > >  kernel/rcu/srcutree.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 2bfc8ed1eed2..0351a4e83529 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1715,6 +1715,11 @@ static void srcu_invoke_callbacks(struct work_=
struct *work)
> > >         WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_N=
EXT_TAIL));
> > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp=
_seq));
> > > +       /*
> > > +        * Although this function is theoretically re-entrant, concur=
rent
> > > +        * callbacks invocation is disallowed to avoid executing an S=
RCU barrier
> > > +        * too early.
> > > +        */
> >
> > Side comment:
> > I guess even without the barrier reasoning, it is best not to allow
> > concurrent CB execution anyway since it diverges from the behavior of
> > straight RCU :)
>
> Good point!
>
> But please do not forget item 12 on the list in checklist.rst.  ;-)
> (Which I just updated to include the other call_rcu*() functions.)

I think this is more so now with recent kernels (with the dynamic nocb
switch) than with older kernels right? I haven't kept up with the
checklist recently (which is my bad).

My understanding comes from the fact that the RCU barrier depends on
callbacks on the same CPU executing in order with straight RCU
otherwise it breaks. Hence my comment. But as you pointed out, that's
outdated knowledge.

I should just shut up and hide in shame now.

:-/

 - Joel
