Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233816D322;
	Wed, 12 Jun 2024 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181875; cv=none; b=d3lrmrfyMgDxmP4A0KuPPB9ZRDjMl8Fq8oiebslkqkiXGLxl6OBlxuyVIZA3FV27aKFNgI0N/t/jbUKyGd7Ei75nm+2pf/OYlyok3SeayX+TdyAqGaDCg3chvr8Gm9sdL5dRq9Pfatqnf3rSSgoFtYog7Hr+B+YKJTT1CTWFqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181875; c=relaxed/simple;
	bh=VtnH5r07oHwCXgPKPUmmalAK4r10T2BQ53NAmBH4yzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6c+yx5RzmFnnf9Zu+pU6X/XipmFC5Br52x8OjnfK8IOvUPpdPGfW7giQC8ec4mOxHUmVqw0o/GUEZvzYdN2Hk21J2wGP1m39HQ74/PpoIjuosE+EmSGXc9xqIY7gYEh4Zq3+GmrZPr4s9Ap6vixEKYxhwDBvhe0PEHrdV7f1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSMB4G+n; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSMB4G+n"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c68c3f8adso2504080a12.1;
        Wed, 12 Jun 2024 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718181872; x=1718786672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R/crdg/bH5NOXHm4IuEIPF/jeUwqU5TAij5q8JMQEI=;
        b=BSMB4G+naCOi1OESM5tEgci6l09H1QUAeMbtvVObz5oib+saZLinxiOp9S/kNTNkXZ
         s22jgioomObCKSafQxkZ61CzYTK6+Utie0LjWY+INwuTvGtQB2vqgmWPuyyUyQ55vaWE
         Ua1e4OYxR0yFALrC+C9TuQ3dqpTSTYTlATEUPvJSbQdbcHW2eQtG9y+3WgqvSZ3g7JjU
         x47G2W1YTDcJ7/ird4v34EiYahZcS5/FXgTgXz0UMn7rlDx+WuFAvFCIH8qIZiGlhtl4
         Yz9gzSNGiFWnrM8DUAuzxrnDijLKL4BepvwvMLAEMoTG2S8mBYrhBhFULbz6YwvO9mH+
         qA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718181872; x=1718786672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R/crdg/bH5NOXHm4IuEIPF/jeUwqU5TAij5q8JMQEI=;
        b=GqU3F4AByYui6PuQC+wD8izz8LF4WXZXn8riO4mOIVDIlK6LJNd+Nk1yQNSL77RE9r
         VTs/ZMkeAKlQ1JQgE025P2l4J5xXxuky370JxvVddloebThKQ6hJh3R7WgKB8VAMceaN
         r5yuuETVpKXXZjeB7CQA5F3KSvB9uqpXR+aAvrOaA0fKhsu5bg3aXoU2a1W4RNgiCcF1
         hf3Ra7DWjXWDUks/LbeeRlLEgmyrT0BUBWaoTS6ZzE7B4RQiHwXV6sjudkLCZEgRWm6h
         DtSnsGnVOlTspMG7ozIbvBjREFDqUCmAzKi791IP+r7BhI6rK0xfcdZxsjwXsQNH+gqe
         k9ig==
X-Forwarded-Encrypted: i=1; AJvYcCU6+IrsxIwWHhiDCglmmnfOOSBqap3XZYeFfugQ5JL4rIaiGBLcGCQcRVfq8d3MUyRaTjImmDWHIWHF7Hv5QITYQQFJg/iO8i9Br7Pu
X-Gm-Message-State: AOJu0Yxt7BX8ahbGyhvm552bMN9Krmn8pXb95PdRWvktmjmcdmaBt7X5
	bcbsJqTaCVYW7iLCR+7FO0lZ/A7lVVJk4IUMcGrppOiAImr1ZBI/NO87AEuXj5J2IBQPM9HQP6q
	RAYspwgJyfoMcNWckUn4ZbRQ9nw/k4VnWTZk=
X-Google-Smtp-Source: AGHT+IGA+0ik2h1nxDzzkd7iE0W7VGJkTtRkZ1lPBcItOshN/drhpi+flXzCvmsgow2P9VffsB/NcvGeMfDZtWmcO2E=
X-Received: by 2002:a17:906:d8ab:b0:a6f:2d9a:c956 with SMTP id
 a640c23a62f3a-a6f47d4eefamr90803466b.3.1718181871598; Wed, 12 Jun 2024
 01:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop> <20240604222652.2370998-3-paulmck@kernel.org>
In-Reply-To: <20240604222652.2370998-3-paulmck@kernel.org>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Wed, 12 Jun 2024 14:14:14 +0530
Message-ID: <CAFwiDX_5BZ9e0odyJKTPJJ9BDkHJ6fcEzSwgs9rnjhuRk4qhhw@mail.gmail.com>
Subject: Re: [PATCH rcu 3/6] rcu/exp: Remove superfluous full memory barrier
 upon first EQS snapshot
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 3:58=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> From: Frederic Weisbecker <frederic@kernel.org>
>
> When the grace period kthread checks the extended quiescent state
> counter of a CPU, full ordering is necessary to ensure that either:
>
> * If the GP kthread observes the remote target in an extended quiescent
>   state, then that target must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it exits that extended quiescent state.
>
> or:
>
> * If the GP kthread observes the remote target NOT in an extended
>   quiescent state, then the target further entering in an extended
>   quiescent state must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it enters that extended quiescent state.
>
> This ordering is enforced through a full memory barrier placed right
> before taking the first EQS snapshot. However this is superfluous
> because the snapshot is taken while holding the target's rnp lock which
> provides the necessary ordering through its chain of
> smp_mb__after_unlock_lock().
>
> Remove the needless explicit barrier before the snapshot and put a
> comment about the implicit barrier newly relied upon here.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_exp.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 8a1d9c8bd9f74..bec24ea6777e8 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -357,7 +357,13 @@ static void __sync_rcu_exp_select_node_cpus(struct r=
cu_exp_work *rewp)
>                     !(rnp->qsmaskinitnext & mask)) {
>                         mask_ofl_test |=3D mask;
>                 } else {
> -                       snap =3D rcu_dynticks_snap(cpu);
> +                       /*
> +                        * Full ordering against accesses prior current G=
P and
> +                        * also against current GP sequence number is enf=
orced
> +                        * by current rnp locking with chained
> +                        * smp_mb__after_unlock_lock().

Again, worth mentioning the chaining sites sync_exp_reset_tree() and
this function?


Thanks
Neeraj

> +                        */
> +                       snap =3D ct_dynticks_cpu_acquire(cpu);
>                         if (rcu_dynticks_in_eqs(snap))
>                                 mask_ofl_test |=3D mask;
>                         else
> --
> 2.40.1
>
>
