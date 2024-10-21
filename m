Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531F1D1E74;
	Mon, 21 Oct 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513999; cv=none; b=L8mLEoKnz4CGvpAJ4LGaxQg2DN7aBAiBufqm3SEYL1LlWfaiB7BjrevGdRf0bYIAKhuVqlm00loC7cOU1HbdGe0Cm0YKqtOwD3g5t9V1rJIXBMa0fdnuzh3gBU5x9x2JNcUDVeUNUiTOwxZbgoiONdT3YhE2LwlFA6n0H13+fuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513999; c=relaxed/simple;
	bh=ejiqaAdhq5qfu9otvu22vewTVMeGi2U0wyEZsSO5aOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OijM4ep9lKIzERiqnI86aK9MZMbqFEWH7fmXAIo0E+F3BPSXUbR0UYo68MOOunFp3c1Bg1GnWiAX0O/elzj9g2i2eGp/ooYrAxlhw/MZb0XpBOO+/i4jJm5IsLUTub4PYLs0nDRf/4nhlNmWPoCTBHVv5XUu2qnofUmaGfZZV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5AMsEu/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5AMsEu/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c693b68f5so46650505ad.1;
        Mon, 21 Oct 2024 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729513997; x=1730118797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWr06tAJ0KdIua+ulYntzk6Q5W0gCnfB6uWlDXNeTVQ=;
        b=G5AMsEu/EDSeWEJibn7D4lqc96Hi6SU2VvfhEy0u9FF7tkwkAXUWpj3kS+u7lA6oK+
         tsZRwUl3qeQx2e8iRQikgHIAJVqz5M47ZHBZLqU7Ad73gC1QsHlwoqUYmwooz/VsHx0n
         U17kM1+lRzC58FdU23RkbRgE+H+Na/JEOZ+QIebA0bdZEYUk7nvYOOFooX5XAVifZWKM
         Ib/ocu2dzOsY1PV47MLliGgHnBsXvazEhYUyiTZwHb+KYUp+afJtVryOinNiK6mK4Jvi
         cKrw5D9CS10f5QKoZdWf+Rrp+8ggV/ev8AdZkZ0DfosR4adW/K+1my/NmxWE8ITs1fTQ
         /Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513997; x=1730118797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWr06tAJ0KdIua+ulYntzk6Q5W0gCnfB6uWlDXNeTVQ=;
        b=Yj5QbWoGsIa/JMJlwQFJFn9G/zxeE5Ch4uLUSBX7Uw6rBwRBN3+Jle//WeEnTu6aWK
         0IWeEBHBrNgx8wHWABSGnxSbP8jlJ7erCBrVTui5Sc5dirkyluWR7Bij5s14SWMIuAgO
         dzy0Gf7cTlBNI9SiiFg++ZRje2fW3t/ENDZB0w6N3uikVwlUDEMc/BW8iReAUlqC5skn
         MizCfkQbX9H4Ddt9136iCwTfeW08oGFp5IEYkILs0wWbohcB1CvgEZb9fDXCos3E1GO/
         U0r9aXKSonwt3uv1SASg1D9S5l+ECEtFI6yiiyvZ2oxQ7fXNiti/ZTFGCgg8AwiFxjkL
         MaEA==
X-Forwarded-Encrypted: i=1; AJvYcCVlN9owBHb8ZZRLrLZhOdtEscPNz5TmnPycLEgw39MeiI53sNdGQH1qOPLRlNRBnUFfxsFDbQAD35Caj7g=@vger.kernel.org, AJvYcCWIBD6WcnmMW0Z2JGIcs9H65l0PwsqJJDOHmWzj7GyGfb7dhEnkq9uDxBkox3hNtxbX99le@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5y3xXgIMooevhwRkvQEkllCgtSXhHjgIqkJWf/AixktUsXrh
	p18javLpkm3CAxzxjGyTXbCvSmRAiptM3Zy5U3g3SoNVG8bZo0a3vbwZLg9+2BBXqLvVb34sl/v
	WmiEjinpzz3iWl+3Sas4FqheWK3/7Q502
X-Google-Smtp-Source: AGHT+IEBKgxGvKxKhz/8CKojloZs/8eqrLK8r+hnT6vg5Dv+IIz17qH26yYr+zgPHEtfbKG/YvoIZB9ecYQYn0hxuC0=
X-Received: by 2002:a05:6a21:6b0b:b0:1d9:275b:4ee1 with SMTP id
 adf61e73a8af0-1d92c5089b5mr14316536637.24.1729513997341; Mon, 21 Oct 2024
 05:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020125119.14751-1-qiang.zhang1211@gmail.com>
 <ZxWO6BmRutOC0RnZ@pavilion.home> <CALm+0cW=1PAVhjHKM+aXLHHzsD0+7pbVDvmm+kxvff7r=Di2tA@mail.gmail.com>
 <CALm+0cV-s+gYDXKQV9dYWEr-ui6aJ6DZzvyNhW6H2T39WtPjWw@mail.gmail.com> <ZxY-jRKBf8672czT@localhost.localdomain>
In-Reply-To: <ZxY-jRKBf8672czT@localhost.localdomain>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 21 Oct 2024 20:33:05 +0800
Message-ID: <CALm+0cXwL2fjF9njuWDRX3cmnUqyPjNKAeWQaWZ6S+BedC3MXQ@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Fix the WARN_ON_ONCE() in rcu_nocb_rdp_deoffload()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Le Mon, Oct 21, 2024 at 07:01:02PM +0800, Z qiang a =C3=A9crit :
> > > For the non-nocb cpus set during boot, the corresponding
> > > rcuop kthread, we should park directly, otherwise
> > > WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp)) will be triggered.
>
> Ah but this case is different. kthread_park() is called on
> the kthread that is freshly created. In that case it is
> parked before the kthread even had a chance to call its handler
> (which is rcu_nocb_cb_kthread()).
>
> See these lines in kthread():
>
>         /* OK, tell user we're spawned, wait for stop or wakeup */
>         __set_current_state(TASK_UNINTERRUPTIBLE);
>         create->result =3D current;
>         /*
>          * Thread is going to call schedule(), do not preempt it,
>          * or the creator may spend more time in wait_task_inactive().
>          */
>         preempt_disable();
>         complete(done);
>         schedule_preempt_disabled();
>         preempt_enable();
>
>         ret =3D -EINTR;
>         if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
>                 cgroup_kthread_ready();
>                 __kthread_parkme(self);
>                 ret =3D threadfn(data);
>         }
>

Ah, Thanks!
get it, I ignored parkme in kthread(),
will update and resend.

Thanks
Zqiang


>
>
> So really rcu_rdp_is_offloaded() has to be true (but we can
> warn if it's not. Though we already have a test for this in
> nocb_cb_wait()).
>
> Thanks.
