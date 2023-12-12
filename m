Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjhpNPQn"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F534D3
	for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 08:14:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-551d5cd1c42so4195a12.0
        for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 08:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702397683; x=1703002483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+KqdeA+ayPueTXRbDqPJvGB/NHejJMBX/m1tCj9sbw=;
        b=CjhpNPQnMdSfwXoXcKA+pIfjlo2kfAzCePL1rAlHfnlZoGF9HReaipOXValH1ZeqHU
         Tq8ZAu9PAsluboSaMIRbGk8i4kA4KUVuzfyWLCf57S/vf1b2qAnUqiJ6b/8gGh+3pOy+
         w2RQQmp7oqeVaCjIqOj/fITm21yhC86cD6LD6/Sd8EaUB3dJw7+STiKarpuC5c2WMIfo
         rg1VusBNmbNMfUoH5ZRWnRV0yOhSCdGL0Qs2yaTZhXJ7vL5uE2brXUtjgP6Xup+bBFHB
         zhqCPTLAqamOCgwOKky4dmcUYngdEMprU5hAmJqB2NsoZT6aU00H06YoEGKSv3yWYdkW
         WFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397683; x=1703002483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+KqdeA+ayPueTXRbDqPJvGB/NHejJMBX/m1tCj9sbw=;
        b=FHWtHCXMw1Ij9Msn5nugvbycZfGOinltfPsRHDlV1NbrI8ii6z/ZJ6XQO+m03cMAUA
         HAmZLgsQcom8kWYvKCKx1I1Uryy3CqeJUgb0y+CLAAhZnKDhccAcHymv3vFEiDDEHgoP
         BfZ7upJ/XqBygIZyBtBXsu+RIW8kcrq3caJYJGJkDzymS7c5UXAVc/ezsDeLoqedBn12
         JKgYZio/8IiMac7BTHABMzs6q3HUb6ME8tPtka6bdkfybIiQ10Na8TS6lWdjt6Autoyl
         O2GxOUw5I6fmuhzAen2Kjpmj8tv4CnCEofN2cMzmBFDSfHxShWi29twKblFdEYgUK06y
         gRdw==
X-Gm-Message-State: AOJu0YyqBNnsLY06NnMoID1m4n9wrcWn6z70GpmJ7g1UeoanVBR2lIcj
	JWmWfF/YxvGcIuDFk86xvqXlWGEuF4kvrt+BM/5Q4A==
X-Google-Smtp-Source: AGHT+IEOrbAlfEXGbCpnPiqNJ+5Bw4w9KX9cczd2NR+wukuJGlmQ8px0UPC+t5mIgp5TMKASOnLn23zvmKYPO/xzclI=
X-Received: by 2002:a50:c092:0:b0:543:fb17:1a8 with SMTP id
 k18-20020a50c092000000b00543fb1701a8mr336717edf.3.1702397683342; Tue, 12 Dec
 2023 08:14:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208220545.7452-1-frederic@kernel.org> <20231208220545.7452-5-frederic@kernel.org>
In-Reply-To: <20231208220545.7452-5-frederic@kernel.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 12 Dec 2023 11:14:31 -0500
Message-ID: <CAC_TJvfG_+iZP3O1mV1y9emMnZHgmfTq=mUAxPWc+fY=kx+=gg@mail.gmail.com>
Subject: Re: [PATCH 4/8] rcu/exp: Handle RCU expedited grace period kworker
 allocation failure
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria.behnsen@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 5:06=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Just like is done for the kworker performing nodes initialization,
> gracefully handle the possible allocation failure of the RCU expedited
> grace period main kworker.
>
> While at it perform a rename of the related checking functions to better
> reflect the expedited specifics.
>
> Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kt=
hread_worker")
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Thanks,
Kalesh

> ---
>  kernel/rcu/tree.c     |  2 ++
>  kernel/rcu/tree_exp.h | 25 +++++++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 055f4817bc70..39679cf66c3a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4717,6 +4717,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
>         rcu_exp_gp_kworker =3D kthread_create_worker(0, gp_kworker_name);
>         if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
>                 pr_err("Failed to create %s!\n", gp_kworker_name);
> +               rcu_exp_gp_kworker =3D NULL;
>                 return;
>         }
>
> @@ -4725,6 +4726,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
>                 pr_err("Failed to create %s!\n", par_gp_kworker_name);
>                 rcu_exp_par_gp_kworker =3D NULL;
>                 kthread_destroy_worker(rcu_exp_gp_kworker);
> +               rcu_exp_gp_kworker =3D NULL;
>                 return;
>         }
>
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 6d7cea5d591f..cb31f4fb4b36 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -429,7 +429,12 @@ static void sync_rcu_exp_select_node_cpus(struct kth=
read_work *wp)
>         __sync_rcu_exp_select_node_cpus(rewp);
>  }
>
> -static inline bool rcu_gp_par_worker_started(void)
> +static inline bool rcu_exp_worker_started(void)
> +{
> +       return !!READ_ONCE(rcu_exp_gp_kworker);
> +}
> +
> +static inline bool rcu_exp_par_worker_started(void)
>  {
>         return !!READ_ONCE(rcu_exp_par_gp_kworker);
>  }
> @@ -479,7 +484,12 @@ static void sync_rcu_exp_select_node_cpus(struct wor=
k_struct *wp)
>         __sync_rcu_exp_select_node_cpus(rewp);
>  }
>
> -static inline bool rcu_gp_par_worker_started(void)
> +static inline bool rcu_exp_worker_started(void)
> +{
> +       return !!READ_ONCE(rcu_gp_wq);
> +}
> +
> +static inline bool rcu_exp_par_worker_started(void)
>  {
>         return !!READ_ONCE(rcu_par_gp_wq);
>  }
> @@ -542,7 +552,7 @@ static void sync_rcu_exp_select_cpus(void)
>                 rnp->exp_need_flush =3D false;
>                 if (!READ_ONCE(rnp->expmask))
>                         continue; /* Avoid early boot non-existent wq. */
> -               if (!rcu_gp_par_worker_started() ||
> +               if (!rcu_exp_par_worker_started() ||
>                     rcu_scheduler_active !=3D RCU_SCHEDULER_RUNNING ||
>                     rcu_is_last_leaf_node(rnp)) {
>                         /* No worker started yet or last leaf, do direct =
call. */
> @@ -957,7 +967,7 @@ static void rcu_exp_print_detail_task_stall_rnp(struc=
t rcu_node *rnp)
>   */
>  void synchronize_rcu_expedited(void)
>  {
> -       bool boottime =3D (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INIT=
);
> +       bool can_queue;
>         unsigned long flags;
>         struct rcu_exp_work rew;
>         struct rcu_node *rnp;
> @@ -968,6 +978,9 @@ void synchronize_rcu_expedited(void)
>                          lock_is_held(&rcu_sched_lock_map),
>                          "Illegal synchronize_rcu_expedited() in RCU read=
-side critical section");
>
> +       can_queue =3D (rcu_scheduler_active !=3D RCU_SCHEDULER_INIT) &&
> +                   rcu_exp_worker_started();
> +
>         /* Is the state is such that the call is a grace period? */
>         if (rcu_blocking_is_gp()) {
>                 // Note well that this code runs with !PREEMPT && !SMP.
> @@ -997,7 +1010,7 @@ void synchronize_rcu_expedited(void)
>                 return;  /* Someone else did our work for us. */
>
>         /* Ensure that load happens before action based on it. */
> -       if (unlikely(boottime)) {
> +       if (unlikely(!can_queue)) {
>                 /* Direct call during scheduler init and early_initcalls(=
). */
>                 rcu_exp_sel_wait_wake(s);
>         } else {
> @@ -1015,7 +1028,7 @@ void synchronize_rcu_expedited(void)
>         /* Let the next expedited grace period start. */
>         mutex_unlock(&rcu_state.exp_mutex);
>
> -       if (likely(!boottime))
> +       if (likely(can_queue))
>                 synchronize_rcu_expedited_destroy_work(&rew);
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
> --
> 2.42.1
>
