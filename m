Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642315AAD1;
	Wed, 29 May 2024 02:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948813; cv=none; b=SRV+bRoB9UPucdbHcMPsmdtz4GUfTRuK19oi8/zKrO40NHkKQBwGIXyQYoSLiUetDIlUGB998S0vVtqWnFkxvSv0K4Ed0Z8YUA2NZSsQUnuhKt0OEE94/Ec3qnvcfGdlbldXYU4+c4xSlw3kax8KD1JpFdbkucDNUa1IrqgVMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948813; c=relaxed/simple;
	bh=fRmKL97jCVnuhOiBjDTdG6991F8Se0tI2EqwVSGt9+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbQCiw+XvwPJRbBvvsvWINktU0ZflxQCLY1rIa/obc90IaQyAdo3NNb7AVVpIb9sPIP2XNpRGNbHvll+Kcj7nh/kflhfBmJzxNHkmU4dJXY9WAQQ4oa2nInZQlX5evTv6RgB5zXlr445DdMdJJJqN1nu3LKI6Wp78VbTt2aJ7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ/jcpaF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ/jcpaF"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2bde007cc57so1231077a91.2;
        Tue, 28 May 2024 19:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716948812; x=1717553612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NuLrPrHjIynazzegpdQ4US6OLS1P3+gvAlmYCriGiGI=;
        b=OJ/jcpaF2M2B7ZpcfXeBjFjONyIxS8D6DEyonWel6U9wY0d9nz16N+P0kt/eFNGtiU
         1MbROljC3RqhF5w0oc3N47kNa1oJzGgGwAoHJVzSvTtBXSG78BB6LD9zUUJfoI3xaKTb
         1zpmpqJMsGSW1j/Mg+e9E8GWaKKlERoAdiaK6xxTrqBueRNHzpgIXbqEXnlug93pq2TF
         hW+GDvO5oN6UGn7cp44ifyWradePNP/gJHhRywwIAadtbqYZ9cSpwZX0wDXdZb0M1RxZ
         zukVNkOcu/i/huvoXvDAfZCkGJTIIUKx+AuMTwD170yeLtreR2Yz36i0xYY1Bl3kw9mq
         m/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716948812; x=1717553612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuLrPrHjIynazzegpdQ4US6OLS1P3+gvAlmYCriGiGI=;
        b=sOAreIM+apR0lMDJ4dear8BGmuwBAvTA1SAWXkEdMO/OyII6pbQYu3PgxR9RkEBiuZ
         FcWpSkCnBy2f/yzuIkC+tkjLVLeZuRrTqorzMcczoH4kgYUB+PfoRshnmy2BY02RAZjT
         gt9CdRYysTxJ5RSyFMCpP9RoTJjdsyhSQk11eNPIaLj01Ivmm3c4gI9coNwnpqVc5kYh
         yYpphaozkWeSjvzLXpjOx8xaL87zExg1YSFz9+RNkqitRkp/oxkAFvJfQFfkTYZHI3kB
         Y3iADfWf5msy4Tyo7RGslyDk7eFdG3UxjIULgUs1PNIIvhhms6IExrqKU1aGfL936kTF
         oIig==
X-Forwarded-Encrypted: i=1; AJvYcCUk+iOAHKmM4thmqD1TJGZA7Utbqg/nNJNkPA3czw6sl8mpopXbaOOEsqxvP2wJQai9rb0FUdYbIwKRs/mNwWlLKRpuwc/o5ZvYWHdoAKaGONfq4g5H+nEYhpF4MYb9T5eI
X-Gm-Message-State: AOJu0Yzfykd9Zr7Y4AWoSJBSsYq81aCSen5oe/+xGYT9cCDjrDOYZrvF
	MJ0qNeqUjP3OeRde6rnMTulukmNdonwjzV80Q+5T9RUN4cnZJnXRMIkNHmelWGw6JAFY1r8+iZd
	hcs0bk+13fGzaJTeemHVlVAoAHe4=
X-Google-Smtp-Source: AGHT+IEMBFmXy0UoQfNxKbQvbsq4lAJ6OsHHFfNUGwIAtLKFWy7hW1B5cLJDBIIVSgPV22u+VHDdWU97UI05ZwHRMN0=
X-Received: by 2002:a17:90a:fb52:b0:2bd:db8b:ca78 with SMTP id
 98e67ed59e1d1-2bf5f715405mr13010723a91.33.1716948811675; Tue, 28 May 2024
 19:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528030054.4525-1-qiang.zhang1211@gmail.com> <1195a9a3-db87-465d-a3b0-ee92d67da954@paulmck-laptop>
In-Reply-To: <1195a9a3-db87-465d-a3b0-ee92d67da954@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 29 May 2024 10:13:20 +0800
Message-ID: <CALm+0cVZ7GQC+v4Xe7nArh0DHKeax+ok_tYsKaB=JtG-BVgUag@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Skip debug object testing for cur_ops without
 ->debug_objects set
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, May 28, 2024 at 11:00:54AM +0800, Zqiang wrote:
> > This commit make rcu_test_debug_objects() early return when the
> > specified cur_ops not set the ->debug_objects.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/rcutorture.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 08bf7c669dd3..9b8c277ab91a 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -3495,8 +3495,9 @@ static void rcu_test_debug_objects(void)
> >               return;
> >       }
> >
> > -     if (WARN_ON_ONCE(cur_ops->debug_objects &&
> > -                     (!cur_ops->call || !cur_ops->cb_barrier)))
> > +     if (!cur_ops->debug_objects ||
> > +                     WARN_ON_ONCE(cur_ops->debug_objects &&
>
> You lost me here.  Given that we have "!cur_ops->debug_objects" before
> that WARN_ON_ONCE(), why do we need "cur_ops->debug_objects" inside of it?
>
> Also, we don't get here unless the rcutorture.object_debug kernel boot
> parameter is specified, don't we really want to WARN_ON_ONCE if the
> current flavor does not support that?

Hi, Paul

The rcutorture.object_debug is set true, but the tasks-tracing does not support
duplicate cur_ops->call check, but the debug_objects test was still done.

insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
n_barrier_cbs=4 object_debug=1

[  106.082416] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
[  106.082533] tasks-tracing-torture: rcu_torture_read_exit: Start of test
[  106.082543] tasks-tracing-torture: rcu_torture_read_exit: Start of episode
[  106.105552] rcutorture: duplicated callback was invoked.
[  106.105567] rcutorture: duplicated callback was invoked.
[  106.111269] rcutorture: WARN: Duplicate call_tasks-tracing() test complete.

Thanks
Zqiang

>
> Or do you have a use case that needs to silence these warnings?
>
>                                                         Thanx, Paul
>
> > +                             (!cur_ops->call || !cur_ops->cb_barrier)))
> >               return;
> >
> >       struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> > --
> > 2.17.1
> >
