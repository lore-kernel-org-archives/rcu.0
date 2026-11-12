Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499201;
	b=bp7SDdjdX+4GPBPnyTkGrj722NFWV/JSF9XFh3fEB1E+aQ7pPaiOJhpxW55/3or8ocMg
	 mWTh+FpdM2gIyrckYMhR67P0QQ3gt71yI4eQiedKTjU08QXFa66MXD+qkNewABSgA/zsV
	 z+iZXbv98eDkZ2Im/YP+g0YXSGrbUbXcjERsmar6Fkb2vS6GwP6qpR/P+ZCgEDxfiGTV8
	 AZ2hsu/9VKL2EslD6IkC707DJq3BU9SEReqX6bcFEdQXKlp0XGdl3FNfU8bFyORnRp2S4
	 VD7osravimGV+fLTD3lFK2+tM3djIKRB2Olt5igfMtIaUu+ljRI1i2V2Rg5+gh9PteQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o1Dliguz4u44qwi4R1eK834/qPlvvb9pc8ymG3pNfYo=;
	b=LqUnw7Bp8XDW2ihikoWnCDLlpRNV5cj7854G23rsMel/KGpClGBXfyT0T/4clVCYkjSs
	 5Q1x2UITCCb4UP/CCxoH7egxDP6BxR9zwSWVHGCSqq+iCXiiMqQb+RcTGEp1UG08RGrAz
	 YVgK4t8DEBV8qcV/eW8mGiP2GSjK7eJqiXRkEyVmlJayQoX+Me+q+T+xVYU1f+CWX/kAz
	 cPC3csyPGNiKp6N/+sa/xD2OZjMqxl+kU/DM/Ff6EY3LRE7VhgHhcBp7Gye55aQtZvGtL
	 cAYQpl2di1Cr7wwPOuYkBKqGI//mXH//4Ng3N5fYPWP2527G4LQ1ERkwobIs94IH8+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VNq/TS9Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A065606A323
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 16:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A065606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VNq/TS9Y
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a215e64962so49173515e9.1
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 08:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794499199; cv=none;
        d=google.com; s=arc-20260327;
        b=IdazB9jexhf/TqMlN4KzytGVAEvla+tkT+bWU7N5U23HQqUy5JKCAX7SOWM7psmuNw
         Ld+2i322KV5DjEJ9iSjVIrBV957jus+Z92UBtuLRuE2rmkEoWHLSwmX3n1K/32xcoU2D
         e1wVtNkfQlhGxGumYNHDbP4IOGLZswzhBCedPSn0AwnCxJfX4KhO2ssUiGFwTJgsHD+y
         jQmFi7EgMYeQIoaSl54AA1Cy0DCxIiqTWDOL/8tW9Z6jOgR8HjI6LtS1+tJlSWACYKui
         ROEclVKFRpBKHW4bZZZb7hlDh0wTenTlqhQl/rb4QVUeCt7IP1m/pNJHXn9mC5DGX1vI
         blQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o1Dliguz4u44qwi4R1eK834/qPlvvb9pc8ymG3pNfYo=;
        fh=IjGiBNYkGHEwzd6jrQkp3uacKKfw47r6l5K74lmQ3Ps=;
        b=k3srWTradQ/rL+M+/9iIw827f+Fw5ZteFy6zuqZRjonNeygwdIqJQXIw5uc1oEtncx
         SaBks6T6Qi5/tUolMA7EzTxVoMPzf7F3JfW2NmGACfxwHWspmGKf9/UDpBHRguvFwtUS
         Agbz1R6JwALe1SU6KWqB/iAeZB1kTJebztQ8/PhULBPdiGGnSF53X2zVlsdVu7134+PP
         4gKw8Ye0nZ1/8YbN61PvNgTHLkUKUjrKUv+yfhll1TGaZO6F4qd2aF7BzZ3sZtg/68g3
         TcpPKZtR+5QLLigrEQOdL6QWnfvkVknxkTQC4J0fqjw5tvIDAP+eXGtwTuXMS1x6l9x+
         zAQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499199; x=1795103999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o1Dliguz4u44qwi4R1eK834/qPlvvb9pc8ymG3pNfYo=;
        b=VNq/TS9YxMxpbxP3+3LmkMowYv8beN+AZb3BYPOxmeYCeq9+wN7D+1Kyz71UyEdZF4
         IkvZSUOob95mNXALzE8xn3UgGVvP1eilHuH2U+u79e5E6ebphwRqn0mF6VRmKlKbGuJV
         tX0doJRuOkq2kcmCTLV6p8qoCbmNRJKe+nDaeE5VHBDXVlMDcguz4kusAP5WttG8yNL9
         3VO7sjdZKkPWklzSyO1jeUoz0ev96lP1NhlgObkTjbJ0pR8NLBKYy+7KOmYJ4U2CmPlt
         2g4GlHdLb9s+LAr08FGs3b8IRKIIoVRwlbqGIrwvA4w3PCfbmNbrUIrHWx1ydZ4pSl2y
         z6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499199; x=1795103999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1Dliguz4u44qwi4R1eK834/qPlvvb9pc8ymG3pNfYo=;
        b=JwGQHQbJm9ql1O8CGnR+v0CmXWbM1M9g/1ND/A7/LqBL278VosFO6rpEXuqBsU6BYk
         dt0hQPuVNCHESqI8kyQub6KQPGM/zicALOokX1avz95qPgnr4eTW1maWBEaWIb+WQOGc
         z727A5iMw8I3uVnl+Y5mLhK/Iwwgku9RMchz7IRvgSuaciGFa/St1AsBOt5pMXVkpQSk
         9iN/stmMIA//1Qu0/t8rizTViiTdmbHm9YVr3BY/XMsi1CwD2ecz89/ZmZtbCWjk7D1b
         PzzALGzjB8fmPesJHEaQM3OetE6WqgzKvr4+LwIsiXRfocHWmf0VZHIAREK4SS7L2LCZ
         841Q==
X-Forwarded-Encrypted: i=1; AL+hErHjv5oi4479L7Jrkgkp87d9AJOWRw6SgjPw7ppMIH/+CZ6rfuJwLVmf4NGlvp9b/JWndqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ldkSXNciuVuyXgmZ3WhQnmBW6uteMtSmhB4ODxPzdH8hz++c0
	1fmUtE0AoAMNBzVZhRWT1KnlVFCiVn3qMHqLUD6SZrjcCBi0c54Zz3WjnEMOQcNQWBocJ3WMVTn
	ls/5ppSyTrZX965TWPPNXwyM70otFTZ0=
X-Gm-Gg: AYBFou16GBaKT1AqJ3eVOrX5AYWCVrWZ1+7brR8ajJPM8Ot/kB9Hfetp7oI96uZx9Dl
	FRsAD4Q/hHLFpu48rNOdBKFn4LMZvfZhj/mPi9cHXfVsejX/H/xxVCQu7Pn9KDv9M3W16EGhc7q
	QVKuuovGnNnOc7SU8elPQFjeFXfr1HOylcVyt0X9oGVFJ6ySKS/3obMufj4Kbuv15Kx6uaZUZ+u
	cGbMKYMsbezon8Ecm3UdNEPkDCuonZQi00aVx8CzXArrWwFXbjTgFE43e0Gr1FUVq1F7DZuGhhq
	NE4jacxe2AA37AQ9kb4MTnC37pZt8oj1bR8OjmQVl6iAE9TSlecf1/0Mf6GVbSu5+FqNAl0H3ex
	IXVwFLc1eUEifW70iT+Zc77Tv+14XAc+5fUd7/AeDGsq/BbgC+8D6Q+938XBYMWDUcK+szA==
X-Received: by 2002:a05:600c:e558:20b0:4bb:4b30:8042 with SMTP id
 5b1f17b1804b1-4bb4b308088mr61967275e9.19.1794499199056; Thu, 12 Nov 2026
 07:59:59 -0800 (PST)
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
 <20261104165504.2430480-11-kunwu.chan@gmail.com> <83463788-5e18-4932-99c9-4cbf4148a213@paulmck-laptop>
In-Reply-To: <83463788-5e18-4932-99c9-4cbf4148a213@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 12 Nov 2026 23:59:47 +0800
X-Gm-Features: AclHuK-mTFCsu5EzH21jY8YFD-8az2xhySVKCOowInql9XH_2VCFG8c3gHLmBa8
Message-ID: <CAN_Opa-bdkVQWNHm1N7Kk-sD36SM8Z99odPkCTngcnkWwU8tpw@mail.gmail.com>
Subject: Re: [PATCH 10/28] hazptrtorture: Add 128- and 256-CPU configs
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

On Wed, Nov 11, 2026 at 5:35=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:28AM +0800, Kunwu Chan wrote:
> > Add CPU128 and CPU256 configs for hazptr-stack torture testing.
> > These configs exercise the shared-scan path at larger CPU counts.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> For these, why not instead add '--kconfig "CONFIG_NR_CPUS=3D128"' to a
> run in torture.sh?  Ditto for 256 CPUs.  These will override the values
> given in the hazptr Kconfig files.
>

Hi Paul,

Agreed. I added these to keep the 128- and 256-CPU cases explicit
and repeatable, but the configurations duplicate PREEMPT. I'll
drop the separate configs and retain the cases as scripted PREEMPT
runs using --cpus N and --kconfig "CONFIG_NR_CPUS=3DN".

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > Acked-by: Bradley Morgan <brads@mainlining.org>
> > ---
> >  .../selftests/rcutorture/configs/hazptr/CPU128   | 16 ++++++++++++++++
> >  .../rcutorture/configs/hazptr/CPU128.boot        |  1 +
> >  .../selftests/rcutorture/configs/hazptr/CPU256   | 16 ++++++++++++++++
> >  .../rcutorture/configs/hazptr/CPU256.boot        |  1 +
> >  4 files changed, 34 insertions(+)
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/C=
PU128
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/C=
PU128.boot
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/C=
PU256
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/C=
PU256.boot
> >
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128 b=
/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
> > new file mode 100644
> > index 000000000000..079b463607e8
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D128
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.b=
oot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
> > new file mode 100644
> > index 000000000000..1d09a6446080
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
> > @@ -0,0 +1 @@
> > +hazptrtorture.torture_type=3Dhazptr-stack
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256 b=
/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
> > new file mode 100644
> > index 000000000000..b00a984977f3
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D256
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.b=
oot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
> > new file mode 100644
> > index 000000000000..1d09a6446080
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
> > @@ -0,0 +1 @@
> > +hazptrtorture.torture_type=3Dhazptr-stack
> > --
> > 2.43.0
> >
