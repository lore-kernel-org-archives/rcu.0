Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="w3+nC2sT"
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BCCB7
	for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 12:11:44 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d9f4eed60eso3463085a34.1
        for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 12:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702411903; x=1703016703; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSpKT6X5vMJAjLjsDkyxKCkmYJugXH+FCSpfLk33Dag=;
        b=w3+nC2sTKUpst0pdzpvnIoV5kGTc2uRE4Vuucg0vS69vjlRpsXz0aJGS24K3QieTcZ
         AX9R6d64JHIu8S1PcneYvxO6oFzpINvvOXRAhJ/+171kDih5Refpp1etlZjPuvzsJwff
         1rlXMJT+PwFDzGn7/pbnWluAuBNGCXHc9VDVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411903; x=1703016703;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSpKT6X5vMJAjLjsDkyxKCkmYJugXH+FCSpfLk33Dag=;
        b=YwPSmrN0foZq+YYrs1VXmzwQUVzmT0qId5FY5+kNscQUDSDiyTfV1gzVtYvKKQsVge
         ECriKsdLrZZaJHVdvft8qGLPB632mvgCp8h3r0ois75J8e6bVIEh9GNruQqfowrtniIv
         kRW5VIv9QWmZ8VmKl2pWLELUklcxgilUUGEkWiG8lLLcwS40bc5dczsfmOPsytbeMYML
         a9GvuxWpB5hrvr5SzfJ1S2AjcyssaNECxSlGVuubk9FFlMm9AWJ4OtZLAyk7EDrUyWWn
         DozSh7CPK7YKAZ1dMsOK30FaluckWpIe1UFkz54JiK3aa3I5eBNWUukg+PVJAJEcdgNd
         6/gw==
X-Gm-Message-State: AOJu0YzV9RL4szmqxMSBLYILt7HnF2VJe/1atvDdcGmt6KVScaHtAXbC
	lxLQoRDQ0sDDAX54m7nY6aOZlg==
X-Google-Smtp-Source: AGHT+IE5S1fvGPn9EKUZ+1JtyTMNdFA2PaNO7RccXcSqXTbQmBN/G2PQajwXlMyvPoZxXyZvUGQNfw==
X-Received: by 2002:a9d:7384:0:b0:6d8:567d:ed18 with SMTP id j4-20020a9d7384000000b006d8567ded18mr6200200otk.7.1702411903442;
        Tue, 12 Dec 2023 12:11:43 -0800 (PST)
Received: from smtpclient.apple ([185.189.25.71])
        by smtp.gmail.com with ESMTPSA id da15-20020a0568306a8f00b006ce28044207sm118360otb.58.2023.12.12.12.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:11:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] srcu: Improve comments about acceleration leak
Date: Tue, 12 Dec 2023 15:11:30 -0500
Message-Id: <48B36383-8849-4F52-8882-3B98AD0B9AF7@joelfernandes.org>
References: <20231211015717.1067822-1-joel@joelfernandes.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
In-Reply-To: <20231211015717.1067822-1-joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: iPhone Mail (20B101)



> On Dec 10, 2023, at 8:57 PM, Joel Fernandes (Google) <joel@joelfernandes.o=
rg> wrote:
>=20
> =EF=BB=BFThe comments added in commit 1ef990c4b36b ("srcu: No need to
> advance/accelerate if no callback enqueued") are a bit confusing to me.
> The comments are describing a scenario for code that was moved and is
> no longer the way it was (snapshot after advancing). Improve the code
> comments to reflect this and also document by acceleration can never
> fail.
>=20
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Do we want to quick review and put it in Neeraj PR?

Or next merge window ok with me. Just that then I have to keep track of it ;=
-)

Thanks,

- Joel=20



> ---
> v1->v2: Fix typo in change log.
>=20
> kernel/rcu/srcutree.c | 24 ++++++++++++++++++++----
> 1 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0351a4e83529..051e149490d1 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1234,11 +1234,20 @@ static unsigned long srcu_gp_start_if_needed(struc=
t srcu_struct *ssp,
>    if (rhp)
>        rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
>    /*
> -     * The snapshot for acceleration must be taken _before_ the read of t=
he
> -     * current gp sequence used for advancing, otherwise advancing may fa=
il
> -     * and acceleration may then fail too.
> +     * It's crucial to capture the snapshot 's' for acceleration before
> +     * reading the current gp_seq that is used for advancing. This is
> +     * essential because if the acceleration snapshot is taken after a
> +     * failed advancement attempt, there's a risk that a grace period may=

> +     * conclude and a new one may start in the interim. If the snapshot i=
s
> +     * captured after this sequence of events, the acceleration snapshot '=
s'
> +     * could be excessively advanced, leading to acceleration failure.
> +     * In such a scenario, an 'acceleration leak' can occur, where new
> +     * callbacks become indefinitely stuck in the RCU_NEXT_TAIL segment.
> +     * Also note that encountering advancing failures is a normal
> +     * occurrence when the grace period for RCU_WAIT_TAIL is in progress.=

>     *
> -     * This could happen if:
> +     * To see this, consider the following events which occur if
> +     * rcu_seq_snap() were to be called after advance:
>     *
>     *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num =3D X + 4) and t=
he
>     *     RCU_NEXT_READY_TAIL also has callbacks (gp_num =3D X + 8).
> @@ -1264,6 +1273,13 @@ static unsigned long srcu_gp_start_if_needed(struct=
 srcu_struct *ssp,
>    if (rhp) {
>        rcu_segcblist_advance(&sdp->srcu_cblist,
>                      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> +        /*
> +         * Acceleration can never fail because the state of gp_seq used
> +         * for advancing is <=3D the state of gp_seq used for
> +         * acceleration. This means that RCU_NEXT_TAIL segment will
> +         * always be able to be emptied by the acceleration into the
> +         * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
> +         */
>        WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
>    }
>    if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> --=20
> 2.43.0.472.g3155946c3a-goog
>=20
