Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8D19E;
	Mon,  3 Jun 2024 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717390544; cv=none; b=cwPEUF8HAFUtXqM7DTCfG4/1366ZksFQKaGI9j+OI9n7bX+BeCr7uFjr2hLbFMluIP3omAXELgfLbA4zu3zc6bxQe5CgREBYtNsfjDjMgrh8s6oRM2iV3F1jX6S6M8WnTiLxhFmKg9TSnmxCdlhSNNidQGN0hmJgNtFTGVABQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717390544; c=relaxed/simple;
	bh=AV2KrnFWAFUsRY9ZYLITcITNmLoIydafWAFTUt+9/Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDpC0nRUNYH3cVACkGPkWuAgyfOTHaMcDwPomDnULRRGKqLVoIut6Xoy2YXC/A+t5hRbhCTjFm6+Q4VU+EiPqaiCYzXOjvYBlZCJbkO07zOBJaMMiyyQYXcWJXWSCeHB/JdrVAIDDNIFs+t6lSxeOICoqD/e56miHAzZMzTphtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzer7bcA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzer7bcA"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c1a99b75d8so2842129a91.3;
        Sun, 02 Jun 2024 21:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717390542; x=1717995342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vgpl2pvD+ZoEuT/KfaO9NrRSypVlYGw9oery+TBtf0=;
        b=Gzer7bcAU0tgF3wrhGydTV2OYeqTTQhdiyOPXcIpODfGVpfqwe8vfOKwdZtbDP4xMK
         HVWBnVv8VJVsZy0kq7ROuUBJMJt1zpmNNpGcR9ypA11IORvT4fQiF8RsiWHw5F7AqWiO
         lGknG9Cd9Yoxx1c6A9Ju8FDfK4FDqy70s87T7Zxq4+jVvwgHsq2/O5bipA+BzZS79lYh
         c3IsY9naAWLIv5rBFXi1VCJP/uZvmW9RMtMuGu1foSTFoZaToyDzJovgEDSOHxSP5dIZ
         7XKeyrOFSdsuZqzmajkKua4AJMDWtnmEfGgfh+CG1tEY+VpYXW4Wl9us2CcjNJvH6jtN
         6fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717390542; x=1717995342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vgpl2pvD+ZoEuT/KfaO9NrRSypVlYGw9oery+TBtf0=;
        b=HBpFCuwbBe5CJH37QjlAUyTvK6djVcO76OjcTOUWTk9fzEVmvNPwuive838dUo0zQy
         TBUXvVKwA2nj/RznmfmZatm3O5f7AeP8xv3e4t4PCsgFlyMkPLOew2SJ/mgpCPqSVrCB
         yVKgH0n4xFmmcIvPgwCIfbrFMW2xlpdCoz1NxksSS9zGiM6athD9TaxjH7mxyO+w/3ma
         yNNg39zFrDJLXdAi7XYRO4hqPpvs8HU3u1uJilcrBUtvrbEaywP2a7hi0tSdDqQRfvXi
         mPbA6oTrNVkgjqMa/v45K5DZpLihBeu4R/+ZUdQAfSvcJWV1jLNg4IkrDwiDe+vrFqk4
         z1AA==
X-Forwarded-Encrypted: i=1; AJvYcCUS+2zJwjG4xAdiDRNvkT60cergkZJrvPIXdNVXevvXQMn/+6rdzKy+BvpND28U2PAloUp/LDcFa6kSjv40KCx5fVF4KJL18eEDmotehH3O1SWjz34SwByEk2NjlLN5GJjg
X-Gm-Message-State: AOJu0Yw7n09vpSaRUu9AbL8hBywKIUFFfLwUm2ClM5s7xDeSjPYMEVoD
	1SJJr2ZH+foqoK4a/Vyal34akt5YyEFrNXvNujKb4l+orjGC8B+q10eKfxsOC9Y6UMizYks/cSA
	woaT8auh2Izo+qXj6F+HMd6B425A=
X-Google-Smtp-Source: AGHT+IHEyhaKsUK+k+X1cL0Tk2qMW5U0nA+oNE9TF97gEWvQ5ZDWKnHGufLeOwv7OOeJRXFVuGKAObYwr/xULukjTkg=
X-Received: by 2002:a17:90b:612:b0:2c1:aa8e:3ca6 with SMTP id
 98e67ed59e1d1-2c1dc588b81mr8514194a91.23.1717390542031; Sun, 02 Jun 2024
 21:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528030054.4525-1-qiang.zhang1211@gmail.com>
 <1195a9a3-db87-465d-a3b0-ee92d67da954@paulmck-laptop> <CALm+0cVZ7GQC+v4Xe7nArh0DHKeax+ok_tYsKaB=JtG-BVgUag@mail.gmail.com>
In-Reply-To: <CALm+0cVZ7GQC+v4Xe7nArh0DHKeax+ok_tYsKaB=JtG-BVgUag@mail.gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 3 Jun 2024 12:55:30 +0800
Message-ID: <CALm+0cUQuZDb6nrng+CnOXNGyy6gUWNGq9VoreU98KNkyTw_CQ@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Skip debug object testing for cur_ops without
 ->debug_objects set
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> >
> > On Tue, May 28, 2024 at 11:00:54AM +0800, Zqiang wrote:
> > > This commit make rcu_test_debug_objects() early return when the
> > > specified cur_ops not set the ->debug_objects.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/rcutorture.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index 08bf7c669dd3..9b8c277ab91a 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -3495,8 +3495,9 @@ static void rcu_test_debug_objects(void)
> > >               return;
> > >       }
> > >
> > > -     if (WARN_ON_ONCE(cur_ops->debug_objects &&
> > > -                     (!cur_ops->call || !cur_ops->cb_barrier)))
> > > +     if (!cur_ops->debug_objects ||
> > > +                     WARN_ON_ONCE(cur_ops->debug_objects &&
> >
> > You lost me here.  Given that we have "!cur_ops->debug_objects" before
> > that WARN_ON_ONCE(), why do we need "cur_ops->debug_objects" inside of it?
> >
> > Also, we don't get here unless the rcutorture.object_debug kernel boot
> > parameter is specified, don't we really want to WARN_ON_ONCE if the
> > current flavor does not support that?

Maybe I didn't describe it clearly enough, this
modification is mainly to filter out test types that do not support
double call_rcu*() checking, for example tasks, tasks-rudes,
 task-tracing  ;) .

Thanks
Zqiang

>
> Hi, Paul
>
> The rcutorture.object_debug is set true, but the tasks-tracing does not support
> duplicate cur_ops->call check, but the debug_objects test was still done.
>
> insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> n_barrier_cbs=4 object_debug=1
>
> [  106.082416] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
> [  106.082533] tasks-tracing-torture: rcu_torture_read_exit: Start of test
> [  106.082543] tasks-tracing-torture: rcu_torture_read_exit: Start of episode
> [  106.105552] rcutorture: duplicated callback was invoked.
> [  106.105567] rcutorture: duplicated callback was invoked.
> [  106.111269] rcutorture: WARN: Duplicate call_tasks-tracing() test complete.
>
> Thanks
> Zqiang
>
> >
> > Or do you have a use case that needs to silence these warnings?
> >
> >                                                         Thanx, Paul
> >
> > > +                             (!cur_ops->call || !cur_ops->cb_barrier)))
> > >               return;
> > >
> > >       struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> > > --
> > > 2.17.1
> > >
