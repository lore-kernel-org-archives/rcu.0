Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6FC2FFDEA
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789092772; cv=pass; b=T3Sa6artDFDQDdiZkTYRIkaK0ea1U/SLVKaI8tqR6kfRjfHw+/bLGvjnb/ja2kg47FMLS16OPwmbSfRWuIeNzbDvM4aKaaYpNThrm/Nb8GNTtDJO8KjYxw5/OqtFNpE7QZpby/eT6zuYWrJz7UipLuYbzMWdfOoN0tO3pEd7koA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789092772; c=relaxed/simple;
	bh=W8TGsM/T9bEot6PcFlfqO+Xuq7MZR+MtW3iaazVspZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIyBmmxKsPLKdWxcfgMkAW2xbeZ3eGgDR8H65l3CWldYuSW8eDzq+Su7hGDulrVUPRbs0NOmdn9zmWFvxUJB7AKXi5Inn4Fnbl6EMru7AEcp10I+VZnNv1XIB55FjGBLMuSbD/9tEcaaTxz4zmrgzSYYRtE1COgHNC4hGZaqXyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4OKw39c; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4OKw39c"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b94fce6e8so3243525e9.2
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 19:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789092770; cv=none;
        d=google.com; s=arc-20260327;
        b=Gsx5aSGF99jT0xlSPf1ki7RsCQQycK1I3vBm8nDE1qlwODhta20cr6LEtBsQ0wHqV9
         w2MU6xlP6Oolo6uPAuyRHuUBtOArozVijg8AZD82aoBhZaoSKYifYArcLEo0h0//kh4Q
         2TwsHtYhMmYS3hpSOjBLF7A6itEvu6tf1QHqBQ5i9C4TMjfPa8srIXi28YJZyTnKNmw8
         stjxqF/r49OyB8i5Kz0sUO0c4tVuE9m5nrpi6/zUagdwqhLNY7cm+G6YsJRNVCs9sGHX
         X1Ur7LpTeKfr9DVY2ue3Os2jylxYlHW2xP0DyAGFLlirqYVnFFqaGvppDlrHrFEdj1Dh
         6GRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8mOo+6Yi+Vdbpiw8piBG3s4SxJcYL8u3WjZfAF02iRQ=;
        fh=Gb+72wGxt7slJJ+fiTmerJbRVl+LHELOWGrqdBx+DFM=;
        b=RtqIGWQEJDmLsadownfZf2/xGMj4vRrIhuwzqkZON/9E4aIPR0sAfsZ7UQsITmVcS5
         Io4/COwqRKxU4EzeO6iTRBRzvmYiLzOrIk6YauBxAFjs42mAq8zw/68mo707kyhjUcXG
         i+MU+CYoDBPO+GyZviuu92udxJFwQQbDbp9mulQIRSJP3mnKNdcb3xvTQdvHwA+VjmYD
         FMMD6CviOF+KJFWgoSolpS43KMCtxMrz5rx4Byk0dJJHvs9b6LCukHPueydl+cb9mhak
         m2hMCBdIGw9LviLjd9n5ZBbq8hyK5+NAKtVpW637dMTgR1IURHy3DHrutYXXxCLmXfYy
         Q7tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789092770; x=1789697570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8mOo+6Yi+Vdbpiw8piBG3s4SxJcYL8u3WjZfAF02iRQ=;
        b=s4OKw39cO7ThIstQ/RUpBdz5fAzXES5IB9EKfXWknP+tL2gZgUTMl2xJ+vm5y3OD8b
         KPkZ9HGcfrcKPXS5RnLcTeDaQpRhATaQgYMUYUtXmjEJXDFjJMZFNR5HhwoEnBcv2wIz
         b7qqfxReTsfusE2A+PmFaxCyQu0ZkjQdkGn0jewXgO+xUPI3Apy2NU0Y+FKPCXLGN4Hp
         jndQpS/XdmbXJHNhiC7vkyaM2AB5YUh6bfadBonj+ouyCDLFqR43H7N15+UydLyTngIT
         D0gNmDQ/A/sLL3D8ODjRqbgqL5dizAMThEw6oYh+DLvb/+qmKu0T3yRpdyvfF3lL6LA9
         S+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789092770; x=1789697570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mOo+6Yi+Vdbpiw8piBG3s4SxJcYL8u3WjZfAF02iRQ=;
        b=K/LwbBpDuQ8gr90OKSR1QrsZQBvYRoOFI1rIFkGBWbP4c6pvQMT0ALFX00Ti0lplXd
         viGXa+dDlOP8MQKHgsqUBFYOKO8yvV02WtUgUg5Ac1vVflGcTLv9Bblmz7pnrUpdXWpl
         /zc8MKoOGcdwYImJlO/PQ2C1Zwo1g+d/xJfKN/2l5hiQ8R7HiVjYBu3QkC0llj2346Ug
         +Oj8MnZmXheMCdIaopKxnrouLeXU0Z+YMpuIjGgAztVmviOmfOSluS0lk5/6aiyuIPTF
         pr8nqEc7uQzMuHcP9V2SYiH73GNmv383AIqeDtJbXR78B6xeaPBNJAiow+/O0E4pm/yF
         VLHA==
X-Forwarded-Encrypted: i=1; AKwUvByTNQxwXnsrxhwvJcbiXYeR+9fnSZr0y35V4O8rCAi8nyG8VzR2/rnzq81CHGlAuY97p5M=@vger.kernel.org
X-Gm-Message-State: AFuF++nESDHEcWvPr7aEdx5dAPqPKCAY2FiOSg5gM0CgWJ9d2OXtFWYI
	cL8ItCI4j9PBKb5A2H5EVQaiKoDgA8DvJjLM7EUfHh8uiLFb1opfxTlYoGAhVCoDYf+LblZK+fE
	e0H/Pj/834WKLNU1ObZK1hOsnqHc/uns=
X-Gm-Gg: AYBFou0gK+tns6DkBI1zlCiwGSaLMIPNjHcaSE60pmIUELcG/edGGd68HsgUNbm+d6+
	2UAdh01cphNVp4JsjtyRcmBXBKwWe69HZmix53L4uUPNJ7Es4FlCBp1Wuo6/H89qe1caxttWMxa
	kGZSII/8dN5wkvRIZd7TJjkh6QsUrTOrmtghONp00lFSiBiZ9zOeq4RVycf8iv02UTOqPZ0UDdG
	R/qhvt3+GK5MDIT9xfU3RwpvHGmGBSQlroewJ+YJcDk4gWLzPK0vdJHAL1YkEzZBiE4urFrPpZj
	wYRB5muWpLUlJ/oN+awE5s6J0QSfaIadjOUqjD+tziamsLdOBcSYgDhgCetLI8tJvB6bS0hGRVk
	E0FVFJsmJpRk4Yw==
X-Received: by 2002:a05:600c:b96:b0:49d:1916:59c7 with SMTP id
 5b1f17b1804b1-49e619831a9mr19159215e9.7.1789092768884; Thu, 10 Sep 2026
 19:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910041427.3579817-1-kunwu.chan@gmail.com> <8d55847a-9e4d-4f1e-95bc-4dc77bea73c3@paulmck-laptop>
In-Reply-To: <8d55847a-9e4d-4f1e-95bc-4dc77bea73c3@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 11 Sep 2026 10:12:37 +0800
X-Gm-Features: AcwNN1V14Y3VGCOr55XZJ1Ue8Iw5GojN4B1xvmAJNoEM2UoU3zWAXHkGGTlTvRo
Message-ID: <CAN_Opa-jjwUOds2QqCbgozKjzYT=wzQV+k7ak0Wpk3Un78aq3g@mail.gmail.com>
Subject: Re: [PATCH] srcutree: Skip torture to-big transition for atomic SRCU
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:53=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Thu, Sep 10, 2026 at 12:14:27PM +0800, Kunwu Chan wrote:
> > Atomic SRCU does not use the srcu_node combining tree.  Exclude it
> > from the SRCU_SIZING_IS_TORTURE() transition in
> > srcu_torture_stats_print().
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  kernel/rcu/srcutree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index d462102c6bb6..99d11fb4123a 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -2421,7 +2421,7 @@ void srcu_torture_stats_print(struct srcu_struct =
*ssp, char *tt, char *tf)
> >               }
> >               pr_cont(" T(%ld,%ld)\n", s0, s1);
> >       }
> > -     if (SRCU_SIZING_IS_TORTURE())
> > +     if (SRCU_SIZING_IS_TORTURE() && ssp->srcu_reader_flavor !=3D SRCU=
_READ_FLAVOR_ATOMIC)
> >               srcu_transition_to_big(ssp);
> >  }
>
> Much better, thank you!
>
> Could you also please add an "else" clause with a WARN_ON_ONCE()
> for ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_ATOMIC?
>
> This is after all a user error where someone said to torture atomic SRCU
> but also said to transition to big.

Thanks, Paul.
Agreed. I'll add the warning in the next version:
if (SRCU_SIZING_IS_TORTURE()) {
        if (WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D
                         SRCU_READ_FLAVOR_ATOMIC))
                return;
        srcu_transition_to_big(ssp);
}

This keeps atomic SRCU out of the to-big transition while exposing
the invalid torture configuration.

Thanks,
Kunwu

>
>                                                         Thanx, Paul
>
> >  EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
> > --
> > 2.43.0
> >
