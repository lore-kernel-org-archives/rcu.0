Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KZ11MPuq"
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B924CF
	for <rcu@vger.kernel.org>; Wed, 13 Dec 2023 06:27:22 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so88185681fa.1
        for <rcu@vger.kernel.org>; Wed, 13 Dec 2023 06:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702477641; x=1703082441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2tUcIBSYXXfAdv/AVfpRmmC9S7RY2jXn+X6NSmZ8AA=;
        b=KZ11MPuq44aMOtWEpezE+8BgwdGQFRdMsFC5TBVE+SAnPtWRaAwJxR+0UPbfveY8oW
         HvA9GctCp/UtSJpb6tJIMROZZpUPLpZuLXdX8PvlnIbrnR2RTWC+enX/SlVmjqjK9Ufw
         goz/TJTMuctiWLv8ehkKfYNNUKJZtX0wq2LFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477641; x=1703082441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2tUcIBSYXXfAdv/AVfpRmmC9S7RY2jXn+X6NSmZ8AA=;
        b=oI/XycsSVSnSvJ8VQXFGdId7aUk7x2tfiajxIc97fcIGZqFP84DWq3iYecFkw3rtM6
         mA4kAQhC3zDmrngL46KaXah0rq9tZjBEPPrSCVRvXwE/pNyoOM6IeCkRLxjpJupzcyur
         kTb/X59MR/eCJyQKN83UlDIiCYaCFh3hJsCEvEbct9nFw8ie2tBXoQ4dBhwCARr375sP
         daKDY71Ri0WLvq+E+P6UGr8clTTwW+2dlk/eevLjbLZ7E605tCAs/kXCeO6ghDEyERtN
         5bVNcnX0/ahrE2SULDt7TyJmCZMQUqx8nVLuqF6XWlHudNOUyMo/pLVC8Qs6utACha+l
         lbxQ==
X-Gm-Message-State: AOJu0Yw2vSTSQ7TknxQ6eku6vFHcmNv3BcCXa5/mbev0ivPZ/+n+HF3m
	dLHnKDr6LS9uipGTN8XrUtDL9UBImGqzRDhDcn6zMoI7uZTzlkOa
X-Google-Smtp-Source: AGHT+IHT03d1DXLukck9LtNvbDpns22/gtml49FfERt7jVvq4qDj15BjHeoMGvO+xT+KBOvtfaDXuKNTV+10Lpue9es=
X-Received: by 2002:a05:651c:b23:b0:2cb:2c27:593c with SMTP id
 b35-20020a05651c0b2300b002cb2c27593cmr2670296ljr.20.1702477640535; Wed, 13
 Dec 2023 06:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212174750.GA11886@neeraj.linux> <20231212174817.11919-3-neeraj.iitr10@gmail.com>
In-Reply-To: <20231212174817.11919-3-neeraj.iitr10@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 13 Dec 2023 09:27:09 -0500
Message-ID: <CAEXW_YRHjdM+NA3CqNuwaRNXkRWbtypmt5Ov=YXnrpn3Eo-==Q@mail.gmail.com>
Subject: Re: [PATCH rcu 3/3] srcu: Explain why callbacks invocations can't run concurrently
To: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com, 
	Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:48=E2=80=AFPM Neeraj Upadhyay (AMD)
<neeraj.iitr10@gmail.com> wrote:
>
> From: Frederic Weisbecker <frederic@kernel.org>
>
> If an SRCU barrier is queued while callbacks are running and a new
> callbacks invocator for the same sdp were to run concurrently, the
> RCU barrier might execute too early. As this requirement is non-obvious,
> make sure to keep a record.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> ---
>  kernel/rcu/srcutree.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2bfc8ed1eed2..0351a4e83529 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1715,6 +1715,11 @@ static void srcu_invoke_callbacks(struct work_stru=
ct *work)
>         WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_=
TAIL));
>         rcu_segcblist_advance(&sdp->srcu_cblist,
>                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq=
));
> +       /*
> +        * Although this function is theoretically re-entrant, concurrent
> +        * callbacks invocation is disallowed to avoid executing an SRCU =
barrier
> +        * too early.
> +        */

Side comment:
I guess even without the barrier reasoning, it is best not to allow
concurrent CB execution anyway since it diverges from the behavior of
straight RCU :)

  - Joel
