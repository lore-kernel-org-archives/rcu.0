Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKioxMmz"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF68DB
	for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 08:10:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-551d5cd1c42so4078a12.0
        for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702397456; x=1703002256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGe9rh3iyOih908rL0TnFfunkKRWZYAoojOQ7LaRSwM=;
        b=fKioxMmzJ8tiUgCHhM8xDWJTInyvYAEJJ26ZkXWijGMUkfuD9wRZ0FIG3naTuy1J0H
         EypFcKvY+c1b5XCtr4RWJulyS1tNu0GBPk4ekbO/Zii2pT2cbg6P88vYRazGN2bHsarM
         QM+gB1mpfFsU3i/VZXuKpLu/ZVOjmMiEsUdi7dKn0+r3zX5kmEAHeAS49zwdCcKbnWBu
         kijC4pj/L1syWS3uSwIVYdto2YKxHdaCRYNE5scboTxMktyZvuIxYD3v7alDPhN9dNX5
         nfKc4ptweOn45+7V22C9eQ2QJcZz4TN+zm9m7kKHVv1yEnvoIwuOE4Dm1tr3QOtkBQZQ
         ueUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397456; x=1703002256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGe9rh3iyOih908rL0TnFfunkKRWZYAoojOQ7LaRSwM=;
        b=UB4EdnHbE12fWcxha1k7oYz6KT8TxCbKao6c0Yd4CEpqGLlpFSPMWJLNAkCTP0nUlr
         y+hF9cfqbZu+wPzkPviyfJNJxQkXeqUSwcyd+0vD751y5SnNQPBnGFzcOGPJAvu1G3XV
         lxwTU3uHLA7Ugs9tXg56HIMZ6QphXVfryTNXVaFjulwnzoZS5HyqYpPa6biqVv4gS9Tp
         0WYQAEpoBfHxAzlnZgB7YSbynDcYTuq0hjk7TSZsdoZC5gFXPKx/NPQCOeDrYakPNWQt
         9ZbwtOQ5ERVUsFnouMqptijsQplm63gzUH2m+SycpTXfc/BGTr/R71ofYAfSNm/65v/w
         mMsA==
X-Gm-Message-State: AOJu0YwUWMRp0AozU14x+H0bRRFtRBP/QACAszhq9iQvuZ3CoMEx/DlA
	S2F3qUB1ziLzwHXmwAvYLFjO89KP8qwwJ87m6/h7Kw==
X-Google-Smtp-Source: AGHT+IGeKk2l6Ov4MzRznzZLG+lC3zMBWw8LCtVinpfDUBwQ1ZqZ72cwgls+0MvCCsO8or9gSnE2OolAo5MAqdXzlrg=
X-Received: by 2002:aa7:d4d6:0:b0:551:d490:2748 with SMTP id
 t22-20020aa7d4d6000000b00551d4902748mr32260edr.5.1702397456151; Tue, 12 Dec
 2023 08:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208220545.7452-1-frederic@kernel.org> <20231208220545.7452-4-frederic@kernel.org>
 <CAC_TJvcODXd71icqTLs5fkCKswML5huK-2V2=R2-D9-Fc0R1MA@mail.gmail.com>
In-Reply-To: <CAC_TJvcODXd71icqTLs5fkCKswML5huK-2V2=R2-D9-Fc0R1MA@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 12 Dec 2023 11:10:44 -0500
Message-ID: <CAC_TJveW=UqdqrDJhDPdY8AmzXtkp+wX8p93MwDFwf=jVzJSwg@mail.gmail.com>
Subject: Re: [PATCH 3/8] rcu/exp: Fix RCU expedited parallel grace period
 kworker allocation failure recovery
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria.behnsen@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:04=E2=80=AFAM Kalesh Singh <kaleshsingh@google.c=
om> wrote:
>
> On Fri, Dec 8, 2023 at 5:06=E2=80=AFPM Frederic Weisbecker <frederic@kern=
el.org> wrote:
> >
> > Under CONFIG_RCU_EXP_KTHREAD=3Dy, the nodes initialization for expedite=
d
> > grace periods is queued to a kworker. However if the allocation of that
> > kworker failed, the nodes initialization is performed synchronously by
> > the caller instead.
> >
> > Now the check for kworker initialization failure relies on the kworker
> > pointer to be NULL while its value might actually encapsulate an
> > allocation failure error.
> >
> > Make sure to handle this case.
> >
> > Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT =
kthread_worker")
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 82f8130d3fe3..055f4817bc70 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4723,6 +4723,7 @@ static void __init rcu_start_exp_gp_kworkers(void=
)
> >         rcu_exp_par_gp_kworker =3D kthread_create_worker(0, par_gp_kwor=
ker_name);
> >         if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
> >                 pr_err("Failed to create %s!\n", par_gp_kworker_name);
> > +               rcu_exp_par_gp_kworker =3D NULL;
> >                 kthread_destroy_worker(rcu_exp_gp_kworker);
>
> Hi Frederic,
>
> Thanks for catching this. I think we need to remove the
> kthread_destroy_worker() in this case too.

Ahh sorry, that's the other kworker. LGTM. Thanks.

>
> Otherwise,
>
> Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
>
> --Kalesh
>
> >                 return;
> >         }
> > --
> > 2.42.1
> >
