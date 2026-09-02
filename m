Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E674A483C
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369250; cv=pass; b=Fyn61ZJ7dfbVYYwCGIPsQwyURwomzi06RhTsZ0yVkYiyun9Fx4mqD5/LFZ5ndkmf2irpUJBBwRoXWg7U1wqecU0KpyNVGxAQg+00kuFGnOQZ0b7cce8VWn85ToNi6iwsqd0jG51TBxUCGqJxUxvrLR/ELwxht+9X7iT+RnDtpeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369250; c=relaxed/simple;
	bh=bfwhI9OAjh47z36flVQbjtzP7R5e2cBnzT6QQOuAGWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGjKgFhjusvnuxiKEa8A5NHBpdDsesRPHM1lagbDTlVZ90wVjgVQsgKbdOrtY29uTaM9BAHwMdVDbjG3u1Ut+YX/iWLTxwdCfz43bUK+CL0597ccC30lKmKCtPMbnvAVh4No5roTlrriivYiAEF+NoAhImMN83jEXOyeByuIhfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBRfNlDx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rAJzZXln; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBRfNlDx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rAJzZXln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788369248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvYdpnd0F7jdbeopoRK0pYiwAofYBMgVV1eQGD1lnc0=;
	b=bBRfNlDxoUoxFzdxl2WrllpPQZUCqBrn/VJ10GSHWNcZmBwmYQlGeY+NSJ6vgEwp8MXhe8
	Igtjz12j7fF9uH2J12Ovb9T8V+hiXxrl0zihIdflYtjFtUkbVesvA+sJgFwknD5E9ebAG3
	x2o4KMpfjT/y6N59WB24zvpvMzT7zt0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-KRgQz04oPRS6yltT80-ISw-1; Wed, 02 Sep 2026 13:14:04 -0400
X-MC-Unique: KRgQz04oPRS6yltT80-ISw-1
X-Mimecast-MFC-AGG-ID: KRgQz04oPRS6yltT80-ISw_1788369243
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b60bfcb6fcso621317e87.1
        for <rcu@vger.kernel.org>; Wed, 02 Sep 2026 10:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788369243; cv=none;
        d=google.com; s=arc-20260327;
        b=es2joNkPiFAiI7GoI+LLw7QELScl2xSVgitFAacx3qmTBWsszv8oyn4WZGdbGa+nz5
         rqN2d6K4ukwb4B7ntgIjEAflC6JARHP4KA3ieTPqWlT/0f9+UkJzMUvuG3q0dte9KOOs
         cQ4K/9YFMsscCB6WlQz/Qd0fp2cxoXxW0aeToE/Wt5kQRm2h2btrlXmvij4bwSIa2o4F
         zT49dAjbQWbVkCfHvTJ+9i4xfK9E/OU70HMILvfOl3WhOQKf6OoBIBqiqhaa3LNA99EA
         Qbmba1tvEL57sYDsOANoqBzdGLon2r4zkBAck2/6d0KwzSWIpwWujOrUHhIn84awiMYw
         IhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rvYdpnd0F7jdbeopoRK0pYiwAofYBMgVV1eQGD1lnc0=;
        fh=X9gWR6+/OsNN7Xxm0f3NbkX5M+lpm8xl0rMz/R9tTBY=;
        b=M8i8y/ZhZYj7Q5QzOTccs6rGqZj9WUCtMs9CJQpvzQBKVhJagIQfW1aHUDJrcXcTFC
         f36vWFmJngBC/D1cWC/Z/4ZBAj1lvDIXT2whi0M4P3XCqTzdMFhICI5iMPdtTfZN7HtG
         5zzZuWeZI6XXej380z+YQUVmyyaIim1qrwi2nzizphsvoIoWtJ+iDHFivirkgSa54u4d
         KvJSB5wdGVCVBbROMSVUj+rKkz9GFhf1Z4QDUUbdBNwWqbSNUi0AuvZgssKCVcWQ8ZB2
         MYICUDKUOF1yozWTlX7h0YoHYhHTTw/wgc4K3dI62+K1nk/3LmeqPfjGqLq8L+Y4qal1
         lf8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788369243; x=1788974043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rvYdpnd0F7jdbeopoRK0pYiwAofYBMgVV1eQGD1lnc0=;
        b=rAJzZXln1hNLzMKFjvutM5Hj3c0mIWd4+h75qLafK9MjC0wKBxTqbk8XI7P+1MwXHW
         7yL2HZRK4NX4gDBKcuh5jGipzKRwMPJ/eMcX+54h9kYgDsYX/Rt9iJNKl94GgCSBWHmI
         Hyh8H0IY+XBRRPBadJT+wTAKwOAP+9V6QTXq0XgFYZs1uuctqTJkDPLAqTvNPaB1/Zew
         ydfNunRLKk0vsxNV6kV9FBO1/uuGZqXPkZyfqguW3e1DzGVLT9IXPS4/xGG6VdIO1YOq
         JDv9b7xeZ8QsIocs1dMIn41b4WX3pXQRDLY2gp3WLsmMSiXtWOOgee4CxHZmageTZV7T
         Mrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369243; x=1788974043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rvYdpnd0F7jdbeopoRK0pYiwAofYBMgVV1eQGD1lnc0=;
        b=UJ/PQPi8oMn7LK/s6sZijfxGAvbSiQWGeXlQeagDPTkIAMdlgQGZyzvbtvaRjfea4p
         hYM2S0D1KZm9tdYN7yEVU0dj72z0AC3PMpdtMBhdZJ2jPjDiQFco6BOscghHKIeVI+xK
         pQytRiqKfLcoMV23uK9jaFWjNI9CMhdTWqsX68TzKsJVNsSnGE/EtgJF1p8fdGV47u3m
         7gvbKWcd7wWW7V0J+tJoGQseW+3pL+Gd+LysHK/DzkotNBKisWEWoJYn6sQJADSY6dqD
         ndeSV8fllXmy0UEd6d7H48Tnh9iUwf448jVjCrJMEvvs5lKYXordUCbjaZaook35tj8M
         v5RA==
X-Forwarded-Encrypted: i=1; AKwUvBzVdBuvuab7p9GKKrRrath+5UdByGTDddjju+TG5rTSdXOFODhRQApwYQxJ4APCpOquuSo=@vger.kernel.org
X-Gm-Message-State: AFuF++kTvhHIweDc6hkMDYT2VM/hc+DVmTSfsa+N49gr9sOEaFyHz3cf
	77v92LKWrYYI9DFb4mbw5w2TAjza9rzMNIlgGemksMIG6KE+vc2czR/h27HAVseRbauG6Pch4SW
	vs5bBstu92xZfUouPb2yexIAsLucuMcYMLs/Y7bY+ZOa1H+JX9zlDKbOLdhQPIwDwtBM1tbvp8Z
	cUhhs2DYvDMKypNRJHxVxdTnzN+Ncu60r5xkg0Kz8=
X-Gm-Gg: AYBFou2cWpEC8GOjrDYYhzAiC2qq+hWlwFTk6tJXjGhfari7xYzA0qoacXAhw3gkMuj
	Ugxs99kBH2fYbU/1FbejxD0uLnr8VHcnrTUewJ3IdcoXPGOxSCURmojwRqzEt3mjJDk/CoIEPbk
	ALrDsOp1Mvf84yYC14nfQ4Az0Uecoe0z2nu1u/wAytJ4e0Pi9m6CQqNXbh
X-Received: by 2002:a05:6512:3050:b0:5ae:ba1e:c0ad with SMTP id 2adb3069b0e04-5b60832e38amr1893404e87.6.1788369243078;
        Wed, 02 Sep 2026 10:14:03 -0700 (PDT)
X-Received: by 2002:a05:6512:3050:b0:5ae:ba1e:c0ad with SMTP id
 2adb3069b0e04-5b60832e38amr1893389e87.6.1788369242614; Wed, 02 Sep 2026
 10:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev> <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev> <CAK-6q+hr12xynik0e5sm_s2z_W31F3X1rSovxHJ8R-4f42tSpQ@mail.gmail.com>
 <edf662bb-3c76-44c1-806d-43980d94a492@paulmck-laptop>
In-Reply-To: <edf662bb-3c76-44c1-806d-43980d94a492@paulmck-laptop>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 13:13:50 -0400
X-Gm-Features: AcwNN1Uj-u9Sbn4q5EAK66MbAySJOC2taxXheyrOAkTZX6yUFqfWPab-4oh3oiU
Message-ID: <CAK-6q+geOEoHBAJdJ3ZdYF3WSLP9bbsY=6uxiJOY8a=qgiHZmQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: paulmck@kernel.org
Cc: Zqiang <qiang.zhang@linux.dev>, teigland@redhat.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 2, 2026 at 12:50=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Sep 02, 2026 at 10:30:15AM -0400, Alexander Aring wrote:
> > Hi,
> >
> > On Wed, Sep 2, 2026 at 10:16=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> =
wrote:
> > >
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrote=
:
> > > >
> > > > >
> > > > > The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> > > > >  srcu protected connection and node hash tables and hand each
> > > > >  element to call_srcu() for deferred freeing (connection_release(=
)
> > > > >  and midcomms_node_release()). call_srcu() is asynchronous: the
> > > > >  callbacks are invoked only after an SRCU grace period, which may
> > > > >  happen after the exit function has already returned.
> > > > >
> > > > >  These exit functions are reached from exit_dlm() on module unloa=
d.
> > > > >  Once they return, module teardown continues and the module text
> > > > >  may be unloaded while call_srcu() callbacks are still pending. W=
hen
> > > > >  such a callback finally runs, it executes freed module code and
> > > > >  touches the static SRCU domains that are being torn down, result=
ing
> > > > >  in a use-after-free.
> > > > >
> > > > I thought again about this and in my opinion this is not possible a=
s
> > > > it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
> > > > handling when the module is unloaded.
> > >
> > > When the moudle unload, the srcu_module_going() will call cleanup_src=
u_struct()
> > > and free_percpu(ssp->sda) to release resource. but we not call srcu_b=
arrier(),
> > > the srcu_barrier() should be called before cleanup_srcu_struct().
> > >
> > >
> > > > I know that srcu subsystem does a lot of magic with modules init/ex=
it
> > > > functionality to call init_srcu_struct() and cleanup_srcu_struct().
> > > > See
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/kernel/module/main.c?h=3Dv7.3-rc1#n2711
> > > >
> > > > so this patch should be reverted. If they don't use a barrier there=
,
> > > > the fix should be in the SRCU subsystem, but I believe the current
> > > > SRCU implementation already handles this.
> > >
> > > The srcu_barrier() need to be called, there are some description
> > > from Documentation/RCU/rcubarrier.rst:
> > >
> > > rcu_barrier()
> > > -------------
> > >
> > > This situation can be handled by the rcu_barrier() primitive.  Rather
> > > than waiting for a grace period to elapse, rcu_barrier() waits for al=
l
> > > outstanding RCU callbacks to complete.  Please note that rcu_barrier(=
)
> > > does **not** imply synchronize_rcu(), in particular, if there are no =
RCU
> > > callbacks queued anywhere, rcu_barrier() is within its rights to retu=
rn
> > > immediately, without waiting for anything, let alone a grace period.
> > >
> > > Pseudo-code using rcu_barrier() is as follows:
> > >
> > >    1. Prevent any new RCU callbacks from being posted.
> > >    2. Execute rcu_barrier().
> > >    3. Allow the module to be unloaded.
> > >
> > > There is also an srcu_barrier() function for SRCU, and you of course
> > > must match the flavor of srcu_barrier() with that of call_srcu().
> > > If your module uses multiple srcu_struct structures, then it must als=
o
> > > use multiple invocations of srcu_barrier() when unloading that module=
.
> > > For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
> > > call_srcu() on srcu_struct_2, then the following three lines of code
> > > will be required when unloading::
> > >
> > >   1  rcu_barrier();
> > >   2  srcu_barrier(&srcu_struct_1);
> > >   3  srcu_barrier(&srcu_struct_2);
> > > ....
> >
> > yes, I can see this makes problems when there is kmem_cache involved
> > and you need to be sure it's being done before you destroy the
> > kmem_cache.
> >
> > This is not the case here.
> >
> > I looked more into srcu functionality "cleanup_srcu_struct()"
> > (srcutiny) and it does "flush_work(&ssp->srcu_work)", workfn is
> > "srcu_drive_gp()" and the comment states "Workqueue handler to drive
> > one grace period and invoke any callbacks that become ready as a
> > result."
> >
> > In my opinion "cleanup_srcu_struct()" should be sure there are no
> > pending operations.
>
> If the user never passed this srcu_struct structure to call_srcu(),
> then there would be nothing to clean up.  Now, maybe all SRCU use cases
> are OK with the extra srcu_barrier() overhead at cleanup_srcu_struct()
> time, but as far as I know, that is still a "maybe".
>

Okay, I agree with the "maybe" argument, then maybe we add a comment
to "cleanup_srcu_struct()" that there must be a "srcu_barrier()"
called before. Except "call_srcu()" is never being used.

> And of course, cleanup_srcu_struct() has no ability to prevent the
> user from doing a (buggy!) concurrent call to synchronize_srcu() or
> call_srcu(), which would defeat any attempt by cleanup_srcu_struct()
> to do this pending-operation cleanup.
>
> Or am I missing your point?

I use "DEFINE_STATIC_SRCU()" that does the srcu cleanup for me and I
was confused I need to care about "srcu_barrier()" before module exit.
Then "DEFINE_STATIC_SRCU()" needs a comment as well to call
"srcu_barrier()" before module exit functionality as my initial
thought would be it would do that for me as I am even not a caller of
"cleanup_srcu_struct()".

All of this, of course, should happen in a safe context. Wheras for
"DEFINE_STATIC_SRCU()" I would assume after users module exit function
there is nothing going on anymore.

- Alex

