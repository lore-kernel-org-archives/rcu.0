Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447202153C1;
	Fri, 16 May 2025 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383338; cv=none; b=tNxw380yWF9dQZrMVxmhtGr73NEctwnkWIhK1ol9QOh37KQgaSyoHDehdIIYNb7UUp89ob9GMft4ldPf33mB0SnJ1DNpKTYm3dZJDjwJcM37sDitigoLzsD8ZklNTzcv3BzG0S37aljfQuZ2eXIn9v84wl+NeHuVv9BxlDvq14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383338; c=relaxed/simple;
	bh=t4d1YWEWv97JuDN1ERQNZh9D5QrQwW6QgPRLvu08c+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaecRtEMWei0679uY+cPqCrdI4fxmVH65sh5erOsAKWIY9jTe6GVhSizSSoI0Ytw8+2jM1SM38ntM3C0SvdTSZafm9TeZ91N4Kzo3MOre+Q+BH6O+b4iozmD0qmWzWjhV/teKJVCN1QSG3zqoxt5hMIy6zGM4jhWN0J/M/a1phs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWrQHcAn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWrQHcAn"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736c277331eso2684319b3a.1;
        Fri, 16 May 2025 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747383336; x=1747988136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A69Hh6vhoEvKeSfl8x3ah1eX3eHY2j1XiOvW34UiL1E=;
        b=iWrQHcAnk+HVOMFSHPHJrGv9txorwhppYCKW72iDNX7tbTdOSoxnZi3Xi36Kp2sNc7
         aAkGX0/NXF1sTd3ifF0P7SdQOowFL8yKQpbk1GkrjJdJ6C3n6wweH2FDCxPKz/4ulToM
         oxX398KeNUBGewaL6rrYXm20BTR27NXGLCRQl662S6pyC3E0AL8Zb9FDEDt9jaatjS9R
         ziFTMW/yqTyPvgRn2Q/0mEIbw6nx5+vxef/L5LwPcUsSJjd7jYzVpj6tWCz3C1a4f0zh
         xCv+IxbxPHqyHzM93RDkrWGWagMxtUTdrOVhoe7SPZbo4bEXBF/pnKug3l5RtJnxMzv1
         5Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747383336; x=1747988136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A69Hh6vhoEvKeSfl8x3ah1eX3eHY2j1XiOvW34UiL1E=;
        b=MhRCuKKh1gU1plf3bcGyH7IkdXHQDeKt6CGTsh7JPTyP1iq03nBx00srTq3KVDRn9J
         nUdnqOqtHchPhZQWyXgM+IawxxIeIEbA7smfEcDMwVq+Mi3k9k1MZIlXR5M/Elu2Ze2u
         cznvRGv5YrS3GCxHeI8XU3YaruzNWEF6Kvzq8RStXHVrv+jeuOOtzirLyZAjyEDpjTMq
         AXdSYAkGrnr7VBZIeYGZmm/HcKxzo5XV6mu4lQqo1IihHB3DEyvyhOAHvOdnMPm6LWVV
         xYYWUpvtPEgwHF+lcRNlmPMor0E3IYDE+NLq2ay3i8HGlQpzFblj8kBJjR+A5rwBWX5G
         PYyA==
X-Forwarded-Encrypted: i=1; AJvYcCXMoF+DIYlCaRgP6Rjz3vc9tfNznCPxkpXzDV7RuFf/c7lCGjRePszChsnYGpQEU6yQL0SP@vger.kernel.org, AJvYcCXVWSvvAx5hQL8kYBSs4r2iXXnlIfM69tjJDhdDJM7Z1gEI+dCjWVJVWxgIrypU/nm/e9dNtOK4F1H+Drc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5OmL5+QvmtXtoEMC1ekxjoexWfU5X5oBJLhmXm4OArnW1B5L
	jyuuClgC8EKDSv/YzrwjJnSFepZoJp5VRbcc0MyPgWClPbd2p+piw99oDOwrLrWIcALgXALIe+A
	YaKP6K3ijMCtKho8ovdpAK+BOqN++/Bo=
X-Gm-Gg: ASbGncvmb/yvFxvVlGFgGSCieS/g8stFg28tIs7Gs4+PGsMccmkcDL5yqtieL7q6/ZI
	QLhJbZVim1uwgsU16QV2dElqubW7eeIxLl2tbklPl90biJrAmnL+7oSGX+5pacXQCp5O6hC052l
	Osd+6X9+IbC1k7DE02eJVABLA6et3nU4T7/w==
X-Google-Smtp-Source: AGHT+IHQgx9NdhOovGr9J/DpHORM2Sko8QiPy2j8745V0+60mXqNB5AhZkOSnxnYkRrUgxllgRNOr7GipJmFHGpskOQ=
X-Received: by 2002:a05:6a20:7d8b:b0:1f3:2e7a:7320 with SMTP id
 adf61e73a8af0-2160d932afcmr8733872637.19.1747383336346; Fri, 16 May 2025
 01:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-3-qiang.zhang1211@gmail.com> <23f488d7-d369-46f2-8da6-c5fd2af0f9d7@nvidia.com>
 <7581b542-e591-422b-acc3-0c154161ab34@nvidia.com>
In-Reply-To: <7581b542-e591-422b-acc3-0c154161ab34@nvidia.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Fri, 16 May 2025 16:15:25 +0800
X-Gm-Features: AX0GCFvRdoYepyn2IwhdzNzdBriWBJdd1MLj4-tqIYHyrSbZmH-yboMkBEH8qxI
Message-ID: <CALm+0cX+hZSO8S+kZ1K1E4mhXuWaFvZrXKzrbb7-jt-Q73mCCQ@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread
 pointer access
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, urezki@gmail.com, boqun.feng@gmail.com, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On 5/9/2025 3:07 PM, Joel Fernandes wrote:
> >
> >
> > On 5/7/2025 7:26 AM, Zqiang wrote:
> >> In the preparation stage of CPU online, if the corresponding
> >> the rdp's->nocb_cb_kthread does not exist, will be created,
> >> there is a situation where the rdp's rcuop kthreads creation fails,
> >> and then de-offload this CPU's rdp, does not assign this CPU's
> >> rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
> >> rdp's->rdp_gp->nocb_gp_kthread is still valid.
>
> Maybe I mixed up what you're doing but this commit message is a bit hard =
to
> parse. You're saying in the problematic scenario, "rdp's->nocb_gp_rdp" is=
 valid,
> but in the patch below you're checking for "rdp's->nocb_gp_rdp". So I am =
a bit
> confused, why you would not run into the same problematic scenario. I thi=
nk I
> agree with your patch but it would be good to refine and clarify the prob=
lematic
> condition, the commit message, and also please add some comments to the c=
ode :).

Hello, Joel

Maybe my description is not clear enough.
The scenario I want to describe is:

This is a small probability event=EF=BC=8Cthe rdp->nocb_cb_kthread creation
may fail in rcu_spawn_cpu_nocb_kthread(), this rdp->nocb_cb_kthread
will not set=EF=BC=8Cis null pointer.  but this rdp->rdp_gp->nocb_gp_kthrea=
d
and rdp->nocb_gp_rdp pointer is valid.

but in rcu_nocb_rdp_offload(),  we only check rdp->nocb_gp_rdp and
rdp->rdp_gp->nocb_gp_kthread,  this will cause kthread_unpark() access
null rdp->nocb_cb_kthread pointer.

so I use rdp->nocb_gp_kthread condition to make a judgment,
if the rdp->nocb_gp_kthread is valid,  this means that rdp->nocb_cb_kthread
is also valid and there is no kthreads creation failure in
rcu_spawn_cpu_nocb_kthread()

Thanks
Zqiang

>
> Do you have a reproducer for this? If not, maybe we can work on some test=
 cases
> Both CPU hotplug and offload is tested by rcutorture, so I'd expect we ru=
n into
> it. But perhaps not, because it requires kthread creation to fail?
>
> thanks,
>
>  - Joel
>
>
> >>
> >> This will cause the subsequent re-offload operation of this offline
> >> CPU, which will pass the conditional check and the kthread_unpark()
> >> will access invalid rdp's->nocb_cb_kthread pointer.
> >>
> >> This commit therefore use rdp's->nocb_gp_kthread instead of
> >> rdp_gp's->nocb_gp_kthread for safety check.
> >>
> >> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> >
> > Is it possible that rdp_gp->nocb_gp_kthread is valid, but  rdp->nocb_cb=
_kthread
> > is still invalid (because its creation failed?). This seems a bit fragi=
le to me
> > to assume that if rdp_gp->nocb_gp_kthread then rdp->nocb_cb_kthread is =
valid. Or
> > is there a path that makes sure this invariant is always satisfied? If =
so, can
> > we add additional warnings for checking this invariant?
> >
> > Also from the other thread, it sounds like there is more work to do her=
e
> > (related patches so I'd like to defer this to 6.17 - feel free to keep =
posting
> > patches for this work though).
> >
> > Thanks!
> >
> >  - Joel
> >
> >> ---
> >>  kernel/rcu/tree_nocb.h | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> >> index 1596812f7f12..6679140bb0b5 100644
> >> --- a/kernel/rcu/tree_nocb.h
> >> +++ b/kernel/rcu/tree_nocb.h
> >> @@ -1146,7 +1146,6 @@ static bool rcu_nocb_rdp_offload_wait_cond(struc=
t rcu_data *rdp)
> >>  static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
> >>  {
> >>      int wake_gp;
> >> -    struct rcu_data *rdp_gp =3D rdp->nocb_gp_rdp;
> >>
> >>      WARN_ON_ONCE(cpu_online(rdp->cpu));
> >>      /*
> >> @@ -1156,7 +1155,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data =
*rdp)
> >>      if (!rdp->nocb_gp_rdp)
> >>              return -EINVAL;
> >>
> >> -    if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
> >> +    if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
> >>              return -EINVAL;
> >>
> >>      pr_info("Offloading %d\n", rdp->cpu);
> >> @@ -1166,7 +1165,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data =
*rdp)
> >>
> >>      wake_gp =3D rcu_nocb_queue_toggle_rdp(rdp);
> >>      if (wake_gp)
> >> -            wake_up_process(rdp_gp->nocb_gp_kthread);
> >> +            wake_up_process(rdp->nocb_gp_kthread);
> >>
> >>      swait_event_exclusive(rdp->nocb_state_wq,
> >>                            rcu_nocb_rdp_offload_wait_cond(rdp));
> >
>
