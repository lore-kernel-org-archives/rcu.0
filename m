Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794496999;
	b=XG+fNHpYBc3FYLJ913W/sdCEyFcwsGqHG7U0fFIb3GTYRnnLY2cB9AGbl7+WahzXIC2v
	 IAQyqRwI6ibbIN8t2ImFQ6w+s/x1CsAk+6pQpX3idpJ+gSYYyoPwpEcpBt9iR/O+2ldZ9
	 kkLIdchW5EP4F/TvOnXjaArJYhZ1MQYqOZjxfbDlc8gv8Xk9rZLPsBvQ/9C6G9mhLLkyH
	 tNtCGmJLeIgPBIo39FL0oOr5mJeIMuUTygI7/9a7gdvUOJy8/d/7pKHP4hSqFLXiRK46v
	 BRAnxn1lF0B6FswArOEFAnzxuU0pLEBnZR86REZrkgjNKqXt69AqpqrpXMdNPHp4skw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/gWf9tRn8xdRTedV8zLP5Bk/WzXXZIsEniM+eU5R+pI=;
	b=U0LwOPcTJAiEQbIphJ9ExLVizswbH3fFWPLToJVonC4Maas68xfGU/01GJ32wT4CpvSk
	 dIIEpv8CazlQ4Apvpn9zSSnTiqGbBpbULLUKV9itsIYp+ktkmSdhZuDPSndypLxsIjkKz
	 xZ5eD4ozOQxd73aztk1mSE7XbCkBLlPsSzPHgGFieOPyxug1gVF0GtCvHikAJd0U2l0gf
	 AAtbqYzSsW4pKIHfhgSq+CqxJk9OyuyJTIIkRe1OfWzkklWUTmlFa63m9Bia8Ui/wY1nM
	 qvj1ZbYGzf+Egjlvh942zEyyMJZd+ilzbUQwiovaZk8D6MoD414FUBszkc80CzymNdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdHySA5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82560A5BDE
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 15:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA82560A5BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdHySA5y
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a215e64962so48661565e9.1
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 07:23:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794496997; cv=none;
        d=google.com; s=arc-20260327;
        b=hDXshS6qeszCm/AFZhR/h1r6N3UaWx7qxJzfvf7HnlMCefICHWMMj+5SP5Pu39gIR0
         jxiaRyjqVhKFbTtrfY/4S3Ga6UngSF/PoTSKjstHkG1aCoBlZ2PPkgcQeN5/jXNn4cey
         zk0vjrP4Y6FyzkXj3l4MW61y/bAv0snG+8CzuC4o0oa256t8a6zJPYgiwh7uiqX8MAvx
         mrBH4Qr1OTCHmRTs8bST9myG9hJUAzUuNqCtfMGWfojeCZcZ0vztRArr8SC2CFFH6nPS
         7mvSK0bIVZeaawuLs65hXECEh51gXUV4PUOUlr9CMq55Fuqnd8M4Lat2hlRcg9xw3Pjg
         bitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/gWf9tRn8xdRTedV8zLP5Bk/WzXXZIsEniM+eU5R+pI=;
        fh=OdzC7MfqSehIwM6KlaeZVha/8qBC/phsa1SREeGrFFs=;
        b=GaLjhvzNTm0cxCar/E+SCQ4pT50ihwljXE1B1UJTzuTW6MYgDN/r6gHmzfLgmeG4YL
         VUlyq+6kfCDYH9qeVPQp44TY0UuyPfTL7wbp5F31kfleIglDo4polxgcBX6N8ISweY2/
         DdWu5nuVsXmLaTPZ7fDjHtiSuLACEllyaEF9PocitkVkh0YiR/SbO6FdlNCwuW5Ac7JG
         f1vd1DKimYlEjNo4yJcgbLBTmSvBC5Dg6g38ZP8bnU28ka9caGj7zFX5Bf788Y0DIYaw
         NwFHA3UnOjm6+bl4BrUcK7PMFC+AysyblO+6V+U90EV5yDiFCcCWsMEnuaVL/9azNymQ
         2wbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794496997; x=1795101797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/gWf9tRn8xdRTedV8zLP5Bk/WzXXZIsEniM+eU5R+pI=;
        b=xdHySA5yJr8R3v1bJTdVJvaIGdetLFfLzfjuM+o7syK/yGeAzwWzFMxbWd/Ct+6rMK
         MVANAOQwCJNG35jAUcUyz4qb96VvSdxfmtWqtOhL07JUGI5YDqKmQrWanxsYe0RUh4zA
         h/f/rDCpmTn4mbz57neFPhvuuBN/Tq6CJYzLaR1BKKzGinJoy41is6MxKy1i9f9xSrkJ
         Eh+N8FqElCwLLQdbDMED3VH/oMYEJIZfp3JDX38AozVHqv61qQEQ8tJnfedJbuyUQKf3
         2G72UmsyJWQGEErAwHvQG+tY7G0eeC/0puJ2E95E1nXfJyAsX9FNegJ6m2ZoHeIHGgXM
         AMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496997; x=1795101797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gWf9tRn8xdRTedV8zLP5Bk/WzXXZIsEniM+eU5R+pI=;
        b=1ZPayc6GoYrtuWhfUG8mHJWdw6DUzPs7/xY5mWKlqB0iZsXsfnq7lyxMmpTG+7AX3n
         D/i0IL6RP4AGwt+1y0uLih1ofZIc56QGGEZSUrj4iPPf5Q2Brj91hjodY6chuv3l4HfM
         GrmDGMaPg/UHDZgW610rC293L4+uuhpc/w/54Pq++GtWvbcwdyoU5hf0t2rHdsUfL3jX
         JDl/T/p4tqKyrABfz7IDJwHQiHSqm0ss+KUxzU70j4225JTXR0KPOL9THbiFp65rareS
         dPhi+nctrKeNiQz1lh7mZtqOERRKuHVt7i8IW8pDo0KREgLy6Vvl1TOnBMp3rNoRE8Fp
         TsUw==
X-Forwarded-Encrypted: i=1; AL+hErEdCX8+GOvr3EWOVn14AK3Uem3N7im6u/mzJexB3UaHN6jkNCHaUdmPrT+y1Ivvciyelws=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RW44sLdfpfKyY13++gwU6qTTVX6FZf9BbSkXMBPT8WJpqrcR+
	JDi9NvK+KoIYHg5GGeg3r455QOiMYxwHMDcMZIBs2eTCq0MCm/iAuH0tC6TXJhjaRHjoGpM2P1q
	WNLFm88B634pVW4nTQPOnHTMk/RCgXgA=
X-Gm-Gg: AYBFou3X067aCOcNMb48toXV30QWTs8ChZHUU3dcRDVjd2A4oeNzDAlO5rCLG2QW3nb
	l6rmYo21fp1oj8VRBpB5qwwgACw9FbP8Ls18s9WSRQt2WelzjLsd7q0pyOqzZyIuBKMCVkl4Lcs
	sktZU6fZx8Whg4knZe/41pDprb5OeDz1+ipw5hYGQDpzL0/Fsuhn8Ycp//zew6ZteJbk1hV4ruW
	0Hm/K6Nw22mFKNG/Ac4xgTKDQpPnI2aFSayA0fKoISE8B4CvKCAzFgfjzO+8z0vE4aUR3cK540s
	Zh2XTjBI+tyd3laI8azF6+3LwVFWT8OOtUoZRnYOwQV2WLU/Ubnkkr6VfpnKuS67uTv3c+YdKDW
	RZgGNOWG7JLADzXU7SH5U7lrFPIB2tM256qTFxq/iFzDSrEFcQ5gm0lEE8XYrKgffNwGtXsvE6z
	cLhzFS9Ujd3RKIa7vA
X-Received: by 2002:a05:600c:1986:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4ba0937a886mr110753845e9.17.1794496996738; Thu, 12 Nov 2026
 07:23:16 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-27-kunwu.chan@gmail.com> <444c9bb1-fccc-44ff-8bcb-a04dd36eeecb@paulmck-laptop>
In-Reply-To: <444c9bb1-fccc-44ff-8bcb-a04dd36eeecb@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 12 Nov 2026 23:23:05 +0800
X-Gm-Features: AclHuK-Vxw-TWlfdg2rnJncie6E1-Z5rOKezLCml8xvtMgG1OEVJSy5iWLiq3yg
Message-ID: <CAN_Opa8-macEL323Tw3JUai3ETmq0CCt93ddCZ+Xqd1RF1Q5nA@mail.gmail.com>
Subject: Re: [PATCH 26/28] hazptrtorture: Add torture_type=none clean skip for
 rcuscale coexistence
To: paulmck@kernel.org
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 5:31=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:44AM +0800, Kunwu Chan wrote:
> > When both HAZPTR_TORTURE_TEST and RCU_SCALE_TEST are built into
> > the same kernel, hazptrtorture calls torture_init_begin() first
> > and rcuscale fails with -EBUSY.  torture_type=3Dnone makes
> > hazptrtorture return early without registering, allowing the
> > rcuscale hazptr scale type to run in the same boot.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>

 Thanks Paul for the detailed reply.

> You are only supposed to build one of them into the kernel at a time,
> so the intent of the torture_init_begin() failure paths is to enforce
> this rule.  If you want to run both in the same kernel, the way to do
> that is to build both as kernel modules, then do modprobe and then rmmod
> of the first one, followed by modprobe and rmmod of the second one.
>
> So please help me out here.  Why do we need to allow both rcuscale and
> hazptrtorture to be built into the same kernel?
>

You're right. I had incorrectly made rcuscale's hazptr scale ops
depend on CONFIG_HAZPTR_TORTURE_TEST.
That led me to enable both tests in the same kernel and add
torture_type=3Dnone to keep hazptrtorture from registering.

> If your desire is simply better handling of an error condition, an
> alternative is to force either a Kconfig or build failure when more than
> one of the modules invoking torture_init_begin() is built into the same
> kernel at the same time.
>

The hazptr core is available independently, so that dependency is
unnecessary. I'll remove the guard from patch 23, leave
HAZPTR_TORTURE_TEST disabled in the rcuscale configuration, and
drop the torture_type=3Dnone workaround.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > ---
> >  .../selftests/rcutorture/configs/rcuscale/HAZPTR    | 13 +++++++++++++
> >  .../rcutorture/configs/rcuscale/HAZPTR.boot         |  1 +
> >  2 files changed, 14 insertions(+)
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale=
/HAZPTR
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale=
/HAZPTR.boot
> >
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR=
 b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
> > new file mode 100644
> > index 000000000000..c5e9cf0184ae
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
> > @@ -0,0 +1,13 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D128
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_TORTURE_TEST=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > +CONFIG_HAZPTR_STALL_DETECTOR=3Dy
> > +CONFIG_HAZPTR_STALL_TIMEOUT=3D1000
> > +CONFIG_HAZPTR_DRAIN_ASSIST=3Dy
> > +CONFIG_RCU_SCALE_TEST=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR=
.boot b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
> > new file mode 100644
> > index 000000000000..e9cca4cf453b
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
> > @@ -0,0 +1 @@
> > +hazptrtorture.torture_type=3Dnone
> > --
> > 2.43.0
> >
