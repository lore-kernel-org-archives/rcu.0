Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F93EFFAF
	for <rcu@vger.kernel.org>; Fri,  2 Oct 2026 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790922466; cv=pass; b=dQE0QubOOW06jex2t8k1JSfp35TCuab+8aGISQJ+eUyuzBzqtPtLqvcX5ZlMxKY4nGdtiIejfzfgQPvuu4dmBLbs4FB9cnFLj05wpY/bGQoP9ZBf6gjpNOLi0yq9XJ8yksYh3kSpjtIC6vMJ0uASjcpAbTDVtBO3KJ7W/NOn290=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790922466; c=relaxed/simple;
	bh=/FYQrLLEKu1WCn4ZAyOdyzqThHz/zHSktLaNFZyJeFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3F1MM4vrJlik+FCWCb2fiHfpdRe0VNCEpnWeyLyqWdjb3cElhSOmo1Ta9dgTuYZ57mbPnzQtJgS7UJwyqDKgQnepNYAy8cgky4k7l0fHPxkUJI34/6BNOI42LEW+kJWsykzZ9JJ5Wep85wFeT8EHHvbBpUblj2wsZDS3b12GMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oue1AURW; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oue1AURW"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so39940195e9.1
        for <rcu@vger.kernel.org>; Thu, 01 Oct 2026 23:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790922463; cv=none;
        d=google.com; s=arc-20260327;
        b=O6iyq0wY0nqo0pvUb2vvOPjSFnKkEtToFMCxn7cGi10TDKDdOn4kEeg1Y49FwCVztO
         Wx3GVLyS4q4wSj3+VhyfpEr6qFOzgVzRH0XP5Xhg6uVvD8fpBeHI3j0507gpsviFlGDA
         JODngpCK8r2gfO18RxLDb1io21fSWHgQNtP1+C73AxIy/lQjhG96ruVkw+TKCw0mdOcI
         lWsXmY/7YiFdO49bLGQAVTv5ZRb57jm7cxfHUTnhAcA4iaKlkPvMftfm7zv+dKs4HhRZ
         26N0c9WN8Slh9+zLOLKo2MbtKaqTrMoru+UHhpLE7uqmN+REjeq7muMJjz49ayDneXed
         u1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80Z1rGUaQhJXXmx09Qh/HQ1OTNdQHG2jNh8dgBpMYhI=;
        fh=H9U2DMAOmdlWBxtXQBPeCYymOvzLDMXvYnVrBUT1f/g=;
        b=Tq6WhVnyDq8SbxYqtxzwOqA/WPZA7vTX8TUQhRa/5SGq0qJZeO834gSjuU+e5n0SIf
         ghFhi9JAAlxDpsDEWY0NyXrrb22Zk5kDFJA//J+zrckunO35pYmHDrh/jsQjHqeSwssw
         iAAB7+ZEpcGZGiAPMSEMYSw5UnSuzlWtv6EieKFMHAO2g/FC6/nfMGfftnjUplSp3Avw
         IheRXh9T1qGtUE/uW8NwIdGhPtV3t4K8Ecq5lKpEifQ4IVZplACM71KbvzcObfPgS+2k
         H1IAHeydZvCmILR7Dod+IDGXuF0VHzTJ8N7igCKKqHycm77BA78uAQKN+OkTh1OIEuwu
         zhjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790922463; x=1791527263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=80Z1rGUaQhJXXmx09Qh/HQ1OTNdQHG2jNh8dgBpMYhI=;
        b=Oue1AURWv+b+3joV5WZlUcooG2wftluQXrn5HmsuGmhCpf5tzzeLJFS/JfG4jAuG6Q
         +YT9m5QlTnjB4lka5/Ac+52R3Fzg4gpLlzuvnzpXOqz25316Rw+bKS+wXTUbsjQQ8LA7
         w7DRHX+Mx74JcoYJ1/+4LmziFGuTZMwOP/feEorUW2smmJ+TqA/bQurBG/9dkQJlfTYy
         UR59Uxve8gNAsc3IjlHgRi/CtnKkHzGYFG2hEcbg/pmM/osXFjpW2iB2XfUNY0FhcqtR
         i/tdl95Nlqmz9ujnn2pAbG67MDzhERjMFbWdM706/t3OC7stXGj3q7SDBXeWsIZIc0lQ
         G5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790922463; x=1791527263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80Z1rGUaQhJXXmx09Qh/HQ1OTNdQHG2jNh8dgBpMYhI=;
        b=AcvfD8O+/7Mk+RNnTHSiDPnx5e0RoGoq2dXUZM9JN+SahreGJmFV3vBjsnNzd2zDHO
         SsBGCsnwgoKVyljZkgLzUHQXFEWMzGXZspivT3kc+X1iaGRG3Nx++xfezts9q35BOJwT
         xLW4r1FCwZ7cqk+A+YY0SAq1C5GGu05HoKrG9jRMkvqqrPA6tysxuhbFto8ctF8y4ja3
         FdfZSTgsHOIVIbRHAFqmxwRHlb1G0BREsKQ5AUyl4pKLndjGe5u7AfPvECXfAD86Jcil
         mja1J8w+7Qpx9BGdMMpr0yUVb8QRKtvEsx1A6vjv5XUeshmcRlh4NWqHcCsKd4y23gWs
         kIZA==
X-Forwarded-Encrypted: i=1; AKwUvBxILNvZmjKFZtqWPhortZP9ArWlFfQQ33am/YMkr6ETRT4W7YDWPODc3ZBdLuoAQAZH2lc=@vger.kernel.org
X-Gm-Message-State: AFuF++lU4CRFJBPcQ4D0kQdmXTWhBYNjLfpjEuiEo7KOX3UOCPYZ4+pW
	au1vFgcLyv6GLdmwUPLd3VAPST+nD7XnYKc4h483+GAz0r/oexFKd8KBwhjZ6f6GJYsVagcjdv9
	XVmB6W8VT9xCFUBXOeibahkk4nFQbkUY=
X-Gm-Gg: AYBFou0xMoFrKSpt2nS/eK3kUrDyFkRnz0yAKF5fzMhxyJNh2Mr1BMNlgTC8rEDcYd2
	UbYKxkyNR7sYW5S8EZaAgicIske0fBSON8l6kfhPDQvGJ3DcdFlgpq7CjLUm65ZGiJvPcTHlsVy
	4mjpCZ9KxAMMsD4Nt+pJ8dGY2xT7mLEJh2pawlbVbPF1USw9qmbKKTj4qtI0S0b95oGdbE/Xn3I
	O5nppwQIqUzrGyqVlmY8hRsC4NzzPSaqwFE/KebWhAix5lL/3S66eZu5CEBjTQhgNCmshkm9m8v
	HuWAEcUgk7TRZLFaesTiuf0gAnc3yTmNCVgikApV1/LW0tVw6f2EI8muFGtglG9Kvrm7x/zwIN0
	CfaPw1cyXl994KA==
X-Received: by 2002:a05:600c:8b88:b0:4a0:1a7f:2abb with SMTP id
 5b1f17b1804b1-4a0276a225amr31848395e9.11.1790922462319; Thu, 01 Oct 2026
 23:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927100359.3903688-1-kunwu.chan@gmail.com> <6bafffd8-d253-47d4-a698-b6ee22fbdc3d@paulmck-laptop>
In-Reply-To: <6bafffd8-d253-47d4-a698-b6ee22fbdc3d@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 2 Oct 2026 14:27:30 +0800
X-Gm-Features: AclHuK__JzSd2auzRC6Kl5EH6Yr6XD2l_97F_ntgRZ47TX6-mnBm6P8o4StLfkM
Message-ID: <CAN_Opa_xJyvf7DuPpUqqqRpqV+ZsntqNfDMpGvqy_Bi-HbjfuQ@mail.gmail.com>
Subject: Re: [PATCH] rcuscale: add srcu_atomic scale type
To: paulmck@kernel.org
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, boqun@kernel.org, 
	urezki@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Paul for the review and suggestions!

On Thu, Oct 1, 2026 at 12:42=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sun, Sep 27, 2026 at 06:03:59PM +0800, Kunwu Chan wrote:
> > Add support for scaling atomic SRCU grace periods using
> > srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
> > synchronize_srcu_atomic().
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> Nice, thank you!!!
>
> Some suggestions below.
>
>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/rcuscale.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 5aca31c3c01d..86f1a912ebee 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -264,6 +264,51 @@ static struct rcu_scale_ops srcu_ops =3D {
> >       .name           =3D "srcu"
> >  };
> >
> > +static struct srcu_struct srcu_atomic_ctlp;
>
> The trailing "p" suggests that this is a pointer, for example, see the
> difference between srcu_ctl_scale and srcu_ctlp.  You could make this
> consistent with "srcud" and save a few lines of code as follows:
>
> static struct srcu_struct srcua;
>

The `srcu_ctlp` reuse approach looks good. I will switch to a separate
`srcua` instance, assign `srcu_ctlp` during init, and reuse the existing
SRCU helpers.

> > +static int srcu_scale_atomic_read_lock(void)
> > +{
> > +     return srcu_read_lock_atomic(&srcu_atomic_ctlp);
> > +}
> > +
> > +static void srcu_scale_atomic_read_unlock(int idx)
> > +{
> > +     srcu_read_unlock_atomic(&srcu_atomic_ctlp, idx);
> > +}
> > +
> > +static void srcu_scale_atomic_synchronize(void)
> > +{
> > +     synchronize_srcu_atomic(&srcu_atomic_ctlp);
> > +}
> > +
> > +static void srcu_atomic_scale_init(void)
> > +{
>         srcu_ctlp =3D &srcua;
> > +     init_srcu_struct_atomic(srcu_ctlp);
> > +}
> > +
> > +static void srcu_atomic_scale_cleanup(void)
> > +{
> > +     cleanup_srcu_struct(&srcu_atomic_ctlp);
> > +}
>
> You can then drop srcu_atomic_scale_cleanup() and just use the existing
> srcu_sync_scale_cleanup().
>
> > +static unsigned long srcu_atomic_scale_completed(void)
> > +{
> > +     return srcu_batches_completed(&srcu_atomic_ctlp);
> > +}
>
> You can also drop srcu_atomic_scale_completed() and just use the existing
> srcu_scale_completed().  Of course, both this and the above require
> adjusting the srcu_atomic_ops initializer.
>

That makes sense. I will drop `srcu_atomic_scale_cleanup()` and
`srcu_atomic_scale_completed()`, and adjust the ops initializer
accordingly.

> > +static struct rcu_scale_ops srcu_atomic_ops =3D {
> > +     .ptype          =3D SRCU_FLAVOR,
> > +     .init           =3D srcu_atomic_scale_init,
> > +     .cleanup        =3D srcu_atomic_scale_cleanup,
> > +     .readlock       =3D srcu_scale_atomic_read_lock,
> > +     .readunlock     =3D srcu_scale_atomic_read_unlock,
> > +     .get_gp_seq     =3D srcu_atomic_scale_completed,
> > +     .gp_diff        =3D rcu_seq_diff,
> > +     .exp_completed  =3D srcu_atomic_scale_completed,
> > +     .sync           =3D srcu_scale_atomic_synchronize,
>
> You can also then do this to get more debug data:
>
>         .stats          =3D srcu_scale_stats,

I will add .stats =3D srcu_scale_stats as suggested.

>
> > +     .name           =3D "srcu_atomic"
>
> Then this could be "srcua".  Or maybe more typing on the rcuscale
> scale_type module parameter is OK.  If so, maybe we should change
> "srcud" to "srcu_dynamic", but this would require quite a few other
> changes as well.  (At least if we want the rcutorture names to be
> consistent.)
>
> Thoughts?
>

For the name, I will use `srcua` to stay consistent with the existing
`srcud` naming style.
If we want to improve readability without renaming the existing scale
types, we could also
add a short comment or update the test scripts to mention that `srcua`
refers to atomic SRCU.

If we prefer more descriptive names such as `srcu_atomic` and `srcu_dynamic=
`,
I can help with a follow-up cleanup to rename the existing `srcud` as
well and keep
the related rcutorture and rcuscale names consistent.

Thanks,
Kunwu

> > +};
> > +
> >  static struct srcu_struct srcud;
> >
> >  static void srcu_sync_scale_init(void)
> > @@ -1176,7 +1221,7 @@ rcu_scale_init(void)
> >       long i;
> >       long j;
> >       static struct rcu_scale_ops *scale_ops[] =3D {
> > -             &rcu_ops, &srcu_ops, &srcud_ops,
> > +             &rcu_ops, &srcu_ops, &srcu_atomic_ops, &srcud_ops,
> >               TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> >               HAZPTR_SCALE_OPS
> >       };
> > --
> > 2.43.0
> >
