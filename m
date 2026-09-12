Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C23BE643
	for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789216669; cv=pass; b=IC1Gnafj9xxFbvoh/cR0NmEAQhx/6PjoXQaWUpx4mYHpYY1KOp1+MrwsJ3JJDKOk/wfIB3U5lznWBE94XfhpVm0jgFoE+LgLWLwXSHwh/Qo/psXQjNSIQudu54a3u90ao5GxX2HhOfNQ9qL5G+S6tS4G0XS6garsZ6Y81fN4Tmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789216669; c=relaxed/simple;
	bh=yeTMH9kFHpJvnqz5I7d+elC/gLVahWKunVAWMBOjsZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8wLlrL0h+2zsr70I/HsE6BOyE1rAGffXxb6Ddir7JenUMhgVDxGVdVT7CWMJL6WBjFnGzxMM4xkD1d5EKr4Jglx81QpZKWJYpkHJg6+N34/5GTGcIy24uSjMopdFXz8LxB61fkKI1ODbLuvGkh3vyTx67B9S2dUjgLshaa0c4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY1P5tnC; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY1P5tnC"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so2327665e9.1
        for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 05:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789216665; cv=none;
        d=google.com; s=arc-20260327;
        b=n+eFF80lhw449RbNtboknOEt7EiypSMdwNmPZuxajvZ5etgEBkg7K4iOcx0KdSS7KH
         Qxpt9jz25Y6POz2dIMbZZGu/nlBCd08LtbiK5eMXt1S0oO8EwYD2QMijN3SBY1MvMQNN
         UEFBbiopBgcXp2F4Uxul+R2+c+StUTWoIx4KgAzikx0UqTquqlLZFNnpVs2xqnXdhvMe
         k4anz0LQD8FQ0GgJqwwuGlO4Q4J+hLF68Ymp9gDzCrLMseeO3iROJ7EPn+lfjzP2xrTx
         l0xJH+JDx9+278F4ToJDXdp3rzBSWGbZB7wMrnoi2GqbbfOYT99RbCXU+fUeY5/foNA+
         Br9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOoVDEs7Uwz1aej+iBOpVf4z5QYFzaJI+ngfP48MEa4=;
        fh=R7A7RLvbOSHXZPVfT6UOeH75SGVhfNjPfwy79KRgyc8=;
        b=Zb8hzfpC/UAMLj98xnkgOpayWyHmqq3bs8lrkVSx+QKvBjXm2NYHmQ9IrkB3Tyvw6Q
         4lPD0EFPTfaHAQRCFsTcjIrDJP6akZfAkmR+FmqIxFsrkIdyJgvCcUP4lLmjqw2LNkqd
         7f+c3nsV/4DaJW+5GLXyNTHvnyptNecMEq9wwtx32N6V9OiQY53aGsp1m76QgZDtuxgI
         6WfBbyG5UEv1qg6I1abMbBr81qFW6Vyk4VL5y8KBj5Zmq7G0DlKy11qCjvGJD01L+oWR
         0QFEx1/cs3xVUx6PDK8mFJZhysTVxPIEeCWXoVIwMmq+0k3ICll/kgZ6cKJ+D3wij8C7
         3MaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789216665; x=1789821465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uOoVDEs7Uwz1aej+iBOpVf4z5QYFzaJI+ngfP48MEa4=;
        b=FY1P5tnCiXld4fbU9y3Wz+TFWrjMnudBnJbsO9yhH6MQWfxI+6UVT20XgG11e3k9Z9
         7xy2F3ppyuL/xXVJfgxCcPrd2E3x7ZSC8O9HVA62MJUKCFoDabOQbLbW7Vdv/oqDwqU0
         /rtGfo695ENBR5zUyfQW6QkhQ0rqK3Qa5LgscLWpOMENBeCg2aKQxzrrwyyR1wKniKRN
         cmZtmxc65s8OvO2arOulpfZhniiCXPmvmBE9lZxwDpAZDFLOVzk/upFucCy/GJi+Uh88
         JsoHnth1R/v+D9CYowYsY6fZNCDfvh13FnmFMz5SovaYXdFTCadMN5VBvrgupbdrC/4l
         YyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789216665; x=1789821465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOoVDEs7Uwz1aej+iBOpVf4z5QYFzaJI+ngfP48MEa4=;
        b=JNW/7G103kM3VDn9ysdH4uIrgbcIhf07Y+FCXK7kh42Y5b7LB+hgkuF+UmLkOfyh8w
         lywHwSaLxHUuyifUoRmRHxw87UATtVGgsAA03MF2VxKQqxKbCcExNeIPGpmZUHj72jRV
         GlHwpL73HDKD1Tg1SS2p0B4o0I4e+w/62MiaF/Vue3xos1jJCSthN9D+lbsbUTKYOSx8
         AgINno6RNKVOPdaa605s2GMmNzj1KLQHqk8Gg53KoFf4iMvYrdI4wqH6E5BCwoIXEMkv
         af0tVqsYxi5J5zPZjKP442GCfR1ShLGnnsR94OA7YjW1XGaGVYu8tNTnofrZaknNYdGA
         mlTg==
X-Forwarded-Encrypted: i=1; AKwUvBxpfSEAeskDCW2lQFPW6KB6VyqLnzCQ27g545Apg3H/aSfE8C3edTQcawQYx7ZJfgDRJZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mNbUa+tY5AAZ/LnvQ5x4vP4L1AYfzRjyO1haK452nmq/1f6fVr
	DZIY7nTGW5ro73xmddmmjYA5zbAfUbGpHrTGMwWfMpoTBjc4DBt/UYDAhz1uJmcC5bPPNOj1vzY
	/yzvWnTi2L/pCc5IcNEPxJTGQr7khBHycBooe
X-Gm-Gg: AYBFou2n10exhI2lJB1cdMe0JKYN/4XqRDnb6ognLQGjVugkJzULHeZgISh0WlKhOtV
	GH7nFKZbJelML23ejGW7+g/4bgwTynzHCwArRroNhWTtPkjYEgFiyPClgbqMn0I5DVpteZun9NV
	k+c0UDRHFOICAxuSNQDCOaGToTK2duPLKGSKnF9N+/TS7VyTvBxO2vHrvBk2HCTpkIwMcG/em1C
	NeKRM+9vLEvzPCgtO3XIiAAtptoulXGmQYdEA24FY/RECQ8Upm/f9ITPSZCSofunDmlLEOZp3Z7
	Enx/+hIw9gRIGKMK8XrKOX+XRDcBx+XtjmifmjX6BZuVulC8qkClewtYEI416LEJBLnUByBTJc4
	fLzEPpIo5ARgV+A==
X-Received: by 2002:a05:600d:6501:10b0:49c:fa21:e73b with SMTP id
 5b1f17b1804b1-49e619c0bc0mr66674725e9.17.1789216665157; Sat, 12 Sep 2026
 05:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911093515.2802551-1-kunwu.chan@gmail.com> <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop>
In-Reply-To: <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sat, 12 Sep 2026 20:37:33 +0800
X-Gm-Features: AcwNN1XEaUmULXfMYv71uEC_YjUFE0KO5ywjshlJVOo2yB1GNxlsDPPW2QEtODk
Message-ID: <CAN_Opa-uuim=aiOuAmHYUoD5S=vBREemj-dCvcunF-4zNdp1=A@mail.gmail.com>
Subject: Re: [PATCH] srcutree: Add lockdep and early-boot checks to synchronize_srcu_atomic()
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zqiang <qiang.zhang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 12:47=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Fri, Sep 11, 2026 at 05:35:15PM +0800, Kunwu Chan wrote:
> > Add the lockdep annotation, same-type SRCU nesting warning, and
> > early-boot check used by __synchronize_srcu().
> >
> > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> Queued for review and testing, thank you both!
>
> Interestingly enough, it is now the case that there is a grace-period
> wait that can be placed in a normal RCU read-side critical section.
> Does this mean that we should also adjust the --do-srcu-lockdep testing
> in tools/testing/selftests/rcutorture/bin/torture.sh?

Thanks, Paul. Good point.

I=E2=80=99ll check the current `--do-srcu-lockdep` coverage, including the
case where `synchronize_srcu_atomic()` is called from a normal RCU
read-side critical section, and follow up with the necessary torture
testing changes.

Thanks,
Kunwu

>
>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/srcutree.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 6a9c432a3bd0..6c729e805fb3 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -2123,6 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_struct =
*ssp)
> >       unsigned long rdm0, rdm1;
> >       unsigned long unlocks0, unlocks1;
> >
> > +     srcu_lock_sync(&ssp->dep_map);
> > +
> > +     RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> > +                      "Illegal synchronize_srcu_atomic() in same-type =
SRCU read-side critical section");
> > +
> > +     if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
> > +             return;
> > +
> >       // Initialize.  Either init_srcu_struct() was invoked or
> >       // DEFINE_SRCU() or similar was used.  Therefore, no allocation
> >       // will be done here.
> > --
> > 2.43.0
> >
