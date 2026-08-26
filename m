Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B44266581
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743159; cv=none; b=SmddRighhi24Kx8ase+D6PCXK41Pj1/rW1SNILuqhDetB4tAdG24irwutRHr7ppCevkHOiJDoqZFy34htQvzCTBmJnzN/Dz5qxvmHbplIq2zk3ZbBB2S3wbBbF2lJnX+KJTgRFqVKIsqLAGsfEsSQ96Dqn4GGyLmSCBSjUS+w8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743159; c=relaxed/simple;
	bh=PQMLkhN/IkH3jWiBYm58mX5TAA192/fMLQc1mdbfe4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6rV8b8OAiiu2wrBr2xZpei/xn2mRIyKkqssAXWsTYyg/x64EBaeUn9jJUmXw5aGJQM4QCjGLz51Md2fTPUV1YVlpEV2AmQEbrJTUouLsgSnNkwlfhOevuhUni5ug/gIuSA+5JVP0djqGzPSmaN/Lyfh5fUaqjdMw26XpsLRZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DfHnHFm6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DfHnHFm6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1449805a91.2
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787743157; x=1788347957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JxX9uHyVY+0Pbr+J5I8WnzTLf9nH8ealydFNcrYinJs=;
        b=DfHnHFm6CO2sKJOMmTlf+Jb4slVk2yWHFkQxOO+31lbp6NhYbEvVB8pml1VP65damy
         FMM48/L88IbBRSuyuazGcs8y8rRqQsySAwfNyR3XOvMJ+/czL+JpkHS6zlPBCZRpLkbr
         1vNhUpWo8vXkKIuwK8feNRb4DSjMbYTKrC8eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787743157; x=1788347957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxX9uHyVY+0Pbr+J5I8WnzTLf9nH8ealydFNcrYinJs=;
        b=XBsJYINaOCTmSeLFGLm4e9FP5TVY7Jxle42x94S46bGECLKZlIOhqiWp8X1iPD5e2H
         V9/rTl6RjLE1We1JNY72d3153Tn+qLMsozfRFZB614Fa/eE0KMo67m6T1q/RUOAu8ccW
         k5zgQ0WuwrgsUvr/5WCp4/+uuG1QMAYWFc5LRuXw9L9f2S6Q6ztlua+GOw/nyiDMB9iO
         3Xstm2X5rMTEpdCGdfnf9DheGrNtoytQ/plD0vE/dg9WsjlC78iAQhDg8iFUsCYEjiSr
         xPghORfY3fKtYNRknAXYf60AXtXDsNAJbkNyDQTvD5richvNy9+p7MRlBwz/97Np2Yny
         MinA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8k/SAD2nO60Vb9Z8P9L/wA8A6xnEHYUlMYCL96TDdoErbVskwCBdxmzAae9OuOtVCtR8=@vger.kernel.org
X-Gm-Message-State: AFuF++m6LdkPYMdIn0mlfTtnsu9IUHhh5kY+JZdZCSryTV/xuq2h/rXC
	vTgnTBH8g/5EgT83yVpvUI07tGO8KS14lxRKoi3Yzp4VR9tCPLmuhzM8yv0b4DAklSH0VkLBJ8N
	pnRPwnMo2
X-Gm-Gg: AR+sD13QUoh6a4AAVn2s863HwkHug4EHF3w1APankN1vdUR1Lp4IlnaeU/fGNckp1Ux
	oJDTSEfzR1Xw+TsMdjvqCmNgWPJ5k85T4/FlnqYDeJFMqcAgy2/QwZTM4Xn5e5nH5IgTrZW95N+
	uWBkUKQX0nZwyRl8DEhRXJD9KZomPc7kBUI9zOxYadxjoklP4EDBbeXNhlqOva2vJa/pRXNODi1
	SnMAhk/cf+ncwEwebT7PqR5LckOWf+2ejpsW8U13TRBGka1B8l6d0ABf9wHRwL+QdN8CQ8XmtWi
	eRl8h6AX1ug4mfcFGisugS2FZiNqyr8tMS8BUL59Lhc2ucR7qFu2thVbxY7YscJwWiyLd7Mghv5
	VlexsblLtLtCsKP+taVU2QnJTq8hfHI7fx/V+hGS6mbsvWiM5wlLraIjqe+GFFM2/Xph75dP/Gd
	ycUv9d7UheXLLIsDMJUVUZyWAWdUE7DXPfzuMT5LuXyzfURrVJz+LEvkH209BYf729+QkC61UDi
	vXMpAgdlgrAvokd7aDvcOgQyneR1Hf2fV+D2bN+
X-Received: by 2002:a17:90b:1e4f:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-3966d5f8eaamr12242965a91.10.1787743156967;
        Wed, 26 Aug 2026 04:19:16 -0700 (PDT)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com. [209.85.210.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3967582e855sm806316a91.2.2026.08.26.04.19.16
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 04:19:16 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487214ad2bso1179650b3a.1
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 04:19:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqR2RHx3BH/8Su3p4u+6q4CpCKLINTggZJbDs8AItJnY0VSWNzNq87wQzkTZCqNDVPE708=@vger.kernel.org
X-Received: by 2002:a17:90b:1e4f:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-3966d5f8eaamr12140191a91.10.1787742712750; Wed, 26 Aug 2026
 04:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
 <20260825-unqual-v1-2-7024fb81b4f9@chromium.org> <2a772433-b0b7-44ff-a655-f8c26ee54d0e@intel.com>
 <CANiDSCtP3krujoBo0Ai2xSrA5gkgmG5vNQuNXBDX5kK-kbRA7w@mail.gmail.com> <20260826105832.7f1a6cc5@pumpkin>
In-Reply-To: <20260826105832.7f1a6cc5@pumpkin>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 26 Aug 2026 13:11:37 +0200
X-Gmail-Original-Message-ID: <CANiDSCsMrULsrGQg76x28GRXLg+HSKFWhhA14Zcn8hdm4KyOVw@mail.gmail.com>
X-Gm-Features: AcwNN1WJz7iHQiQ4N5J4yFc2h6z1VMxHSsu0UWLWWVgnjleVetQxY_G6i1FjQSw
Message-ID: <CANiDSCsMrULsrGQg76x28GRXLg+HSKFWhhA14Zcn8hdm4KyOVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/uaccess: Fix casting in put_user
To: David Laight <david.laight.linux@gmail.com>, Dan Carpenter <error27@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David

On Wed, 26 Aug 2026 at 11:58, David Laight <david.laight.linux@gmail.com> w=
rote:
>
> On Tue, 25 Aug 2026 23:15:02 +0200
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > Hi Dave
> >
> > On Tue, 25 Aug 2026 at 23:06, Dave Hansen <dave.hansen@intel.com> wrote=
:
> > >
> > > On 8/25/26 13:02, Ricardo Ribalda wrote:
> > > > Recent versions of smatch preserved the address space qualifiers wi=
th
> > > > typeof()[1].
> > > >
> > > > This fix has discovered an invalid casting in put_user.
> > > >
> > > > This patch fixes tens of smatch errors like the following:
> > > > drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type i=
n argument 2 (different address spaces)
> > > > drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *f=
rom
> > > > drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __use=
r *
> > >
> > > Could we beef up the changelog here a bit, please?
> > >
> > > What _is_ the invalid casting?
> > >
> > > What is the fix?
> > >
> > > Why does it work?
> >
> > Something like this would be better? I will send a v2 if there are no
> > more comments.
> >
> >
> > Recent versions of smatch preserved the address space qualifiers with
> > typeof()[1].
> >
> > This fix has discovered an invalid casting in put_user.
> >
> > put_user is using a casting with __typeof__(*(ptr)), which keeps the
> > qualifiers (__user), instead it should use the macro TYPEOF_UNQUAL()
> > that will use __typeof_unqual__ where the compiler supports it.
> > __typeof_unqual__ copies the type but not the qualifiers.
>
> This is a spares 'bug'.
> You need to fix it without changing normal compiles.

It seems that Sparse is doing the right thing. From Dan [1]

```
The do_put_user_call() is doing this:

__typeof__(*(ptr)) __x =3D (x); /* eval x once */

And ptr is the __user pointer so Sparse is doing the correct thing.
We could change the __typeof__ to __typeof_unqual__
```

[1] https://lore.kernel.org/all/aS1RhxHtknHzZE3Z@stanley.mountain/

>
> There are enough put_user() calls that is will slow down compiles.

I tried a defconfig build with and without the patch to see the
impact. The build time is almost identical (the 0.6s difference in
mean time is within the standard deviation)

with the patch:
  Time (mean =C2=B1 =CF=83):     69.958 s =C2=B1  1.072 s    [User: 2601.77=
2 s,
System: 386.266 s]
  Range (min =E2=80=A6 max):   69.028 s =E2=80=A6 71.517 s    5 runs

without the patch:
  Time (mean =C2=B1 =CF=83):     69.326 s =C2=B1  0.718 s    [User: 2552.06=
8 s,
System: 378.156 s]
  Range (min =E2=80=A6 max):   68.268 s =E2=80=A6 70.055 s    5 runs

$ gcc --version
gcc (Debian 15.2.0-8) 15.2.0


(  Benchmark: git clean -fxd; make defconfig; make -j >/tmp/out )


>
> David
>
> >
> >
> > This patch fixes tens of smatch errors like the following:
> > drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in
> > argument 2 (different address spaces)
> > drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
> > drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *
> >
> > [1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83=
c09e4a94c1cb8f
> >
> >
>


--=20
Ricardo Ribalda
