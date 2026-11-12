Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501749;
	b=qbGNRqLCmVcIbEO4ILxo86kee4+o/yicRjGfYlQOf3uI9DcX1cUW4jGSqbdCtWVZa94E
	 R8gWJZuXlNm/jOjZBz3eC3WJWckqFFYZrDOZ4yjFb1TKbLbJHc+/sFLWsa5GBRnOtWeGN
	 c0VOGvNNL6BKiwiwNH+r7yWhwVrb42+I/otY6VhEMt3o/xxzmG/L4y1rBvHalEzrIkhcf
	 TMp6TL+f8DaUR7nl9nd8+fjR544sdzA3GfkSF9eeCt9+gghJx/iLGafiBJymqEMM82B7W
	 z6TSWxOuedj/V1DO/Sl05hci962ylUIRqSWYORn1hHJWK6rxK7VC0X/p3RNNf5yXy3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vb58UL1JBDT0YchS0QVq3Od5hTwaDV5G0mFqoEfJZkE=;
	b=xVmEN3a3ezDup8duvmKD0ppXtULF5Qp3pblVKGXe2+B/vFBx87tvsok1aWSGt+eiZ5ck
	 w9pXOHQS9BCWhqy0A3wq3Dzcw8BzVHZgaQ1b3S2Jkz+HYpzPB2D4udVKSvhF1nKy1BMyU
	 +COycr6lbIIis1Beq2syXNGnripJc3L/qc9UZxAD3ZA+jfmYqOv/oWpBbewsekkYRvVRy
	 3TjECpVRaNmmg6MzFAVilcmPFhyRBLVXXp4XdisRxA76WUinVTvECbJnIU+8ZH7H/1bQD
	 a0Jp7kqnvwHUdrVtd6j/fWKo2Bs4dgerfUQDn82DG3mT7Gh1fJ/SybIpwtgb1kPg2Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=etvsK4IG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07F606A32E
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 16:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD07F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=etvsK4IG
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4918c2d727fso2548926f8f.3
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 08:42:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794501747; cv=none;
        d=google.com; s=arc-20260327;
        b=J6PcrfCq2s+Ue+UuSWKLrczMRLw9eV6SgLjwqxLSaw2uzd+37W+Sjk0+NrE1vXHK+h
         67bEPzxPNhC1dpPHWIqJ2+d6Wg0qFsMV8KJNPV4rLPE2YECJpTgQg8ZUupvA5pAXyAw2
         iWSq0NxHzg5wAyaJHANwC+19LvMoa4D0V1wV1GBTVgnPK7MBdeUs5JCylgRI34tL2szH
         FQf4Jh66ymWF9rp4EcAKM3H4hg+8SX9yz7wiMnZA+pCRPyr++F3t3z1jTiXrrYOJQlVa
         HNyr7ciR9TCzkZSQuMGQ+MdShAtSABh9h2OGK4gtF3VVPQ2kU39ZVQllRbxCrymhAN60
         tZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vb58UL1JBDT0YchS0QVq3Od5hTwaDV5G0mFqoEfJZkE=;
        fh=Av6dOHjjSgmQYO+xGiuwVWfdcIjMJLhQQF/mILdw74U=;
        b=HhfUN3+EtDMs0dF8RS03VB1Wu4s2BZosTYy4JgRkW+OI9RKCojLAHXe2ZcRfF8yJYy
         sSxi1Cu9Qa4O5Cke6pi68BtabHNrqqyTaRzmffj1T6Vk3HPY7DhHCWG80JRR5s1AiBIt
         GdXcExHyxU7vlojs0f9iEJ1y9puu8RciQmNGz0qy9nSQ3SE3/7RyX47HLr7s7CfdfIuo
         fsBWvzrz/7bfo0yQo1pHDB267jvnACjQcfTMEToVY9p+1GLjqG5Pgd0eeU1MpV/VoeKM
         8f8N86xWfGhrw9ByXhaD/pjfEIQwor33NjZ1Hh229H/w3iocFIYNuK4de+2yJ33Bby01
         Frfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501747; x=1795106547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vb58UL1JBDT0YchS0QVq3Od5hTwaDV5G0mFqoEfJZkE=;
        b=etvsK4IGKtC1tmmWAGvlMBJDCobivzoekXoqFKuVsVWyGu8lShV/ecQ/M5I17JaUlL
         GIgJYMp8UmzWyFSoNcGMefWzA368T6y84Dl1UkNYt0uoWQZgdBdZG/Aiwpc7CVTIhAF/
         0JQFaTCfa2V+RNlaKbkn7+i4NAyorYBX8ybqJH3XjzPN9VMak9jeuoTXVavcz/TXTb21
         FaF8VhxNqyxbBZju9qp2Ln/N+5T7gJZ/RicqGc8poLGUIGAlMT1edOhRdpffMJ38j6/6
         qtsYNESSzPCd2ar5kLu/sN0j0+3cPO20UPb5V2eBQ/lZWth2IIrqyP4VOjINWfuUb+5N
         qDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501747; x=1795106547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vb58UL1JBDT0YchS0QVq3Od5hTwaDV5G0mFqoEfJZkE=;
        b=kBpHYr8vkMlqBHFSG9vBlbm9OoJIAzSA7Qe1B1XAg+/OLgkunK6mZcmjt6Srj9Ezhl
         HeyouGA7kvy49t6ZgHb1mlTSe3DSIMvj/f9ORMd0fUPifY7p8rjSxxOAHb1kgXE+EDrC
         LfBMhq1T5WoCzviszFpg08TbUS9YIqifAHstRigS00nEPJsHkcqtdX6yRNO4nKjqHsSN
         5A4RBXgEzcyQZZSlIK70f93vd2zT+Zovr+ptkExbY2L1cbsDz8a41iR9R8YOFTND9IHz
         VfWWu4qQzDVbi6W4Zc/WZdBtvdOk2PmpzBjIanzMyRS7NHARNtYs4YQTab2+SfeIw9V6
         amhA==
X-Forwarded-Encrypted: i=1; AL+hErGBYezlrsQozlFVPv7SNsGVVDNALlbwBQIyd1UGP/sB1ybujRvVaXbGfj3VS0VVMUt7ryU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BieV2k/8xe1u3ZroLP5GOuj/DYkNVVNgCUL98yV4PVDxs4kKP
	Bt3l/4LZkMCtq4Jujn9CHnex56kw03gFVau3jV7LqZwIwzI8WrU/V1mB5SbKEg2765TG+gmUqhM
	Q8QAQjIgmrZG6V5r7VjpSkWhx2DjPnxs=
X-Gm-Gg: AYBFou02JuODPYmYC6ILYPEIQWuKZsyBa94zt7xKpub7v7NYzzbZkwZ7y/BwlLv1UDG
	dNxXecA/ZPbZ/QV5E/RSwLLnSjTu6xQkhC0IYTokzVdfZXwGCwNYXScZ4HX7rXcjciILCGp7BXV
	eppUHk/nFaDOfPzxZ33yQ7Cnj9F6YCsP77g/VQSP7xYk1RpX4wrNh3AJybgbZGyhFJmCXChmk1S
	RBmUCpIHko1t8fnLZH8noyUEXepGKcFhZ+cunsvef4ov2CGqzlbNTdOLmiXQwx2FrlgzPGDXQm4
	fBPv0nTBgBMpxEXjJeBko8IjULYaneRS4J4HWmb+u1iurnd+hgIYcpUvTrpXptBOrAs/HHJonw5
	seMGyZGij24AWTqdfqZ0r/I8pujZPW2SRLKaXEN0oT2LYWQmpStsSml3hi5Bf+94UgOYGMw==
X-Received: by 2002:a05:600c:310e:b0:4a2:c9b:9b98 with SMTP id
 5b1f17b1804b1-4ba0936d857mr116824585e9.17.1794501746962; Thu, 12 Nov 2026
 08:42:26 -0800 (PST)
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
 <20261104165504.2430480-26-kunwu.chan@gmail.com> <1c2eff9d-213b-4ea2-9905-a054c6d40d97@paulmck-laptop>
In-Reply-To: <1c2eff9d-213b-4ea2-9905-a054c6d40d97@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 13 Nov 2026 00:42:13 +0800
X-Gm-Features: AclHuK_5dn6ii1XkN_5ubWft1GmD866Yv1veX15FudsEky0EOAdtZ7tnwYRl5R4
Message-ID: <CAN_Opa-RGS=5kTnMVsj6KE=xCLS8aB=dYSqee7DuFeQ=uvDHKA@mail.gmail.com>
Subject: Re: [PATCH 25/28] hazptr: Select TRACING for HAZPTR_TORTURE_TEST to
 enable tracepoint
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

On Wed, Nov 11, 2026 at 5:50=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:43AM +0800, Kunwu Chan wrote:
> > The hazptr torture test registers the hazptr_waiter_enqueue
> > tracepoint for its hot-address scenario; select TRACING so
> > that the register_trace_*() API is available.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> It is useful to run the torture tests without CONFIG_TRACING=3Dy in order
> to quickly isolate RCU bugs that tracing related.  Is there a way to do
> this so that people wanting to register tracing can do so, but so that
> it is still easy to run the tests without tracing?
>

Agreed. Only the HOTADDR and LONGHOLD scenarios need the enqueue
tracepoint; the other hazptrtorture scenarios should remain usable
without tracing.

I'll drop the select TRACING changes, make the tracepoint-dependent
scenarios conditional on CONFIG_TRACING, and enable tracing
explicitly in their scripted runs.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/Kconfig.debug | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > index b500e96ea1c1..8fc6434a05d1 100644
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -27,6 +27,7 @@ config RCU_SCALE_TEST
> >       tristate "performance tests for RCU"
> >       depends on DEBUG_KERNEL
> >       select TORTURE_TEST
> > +     select TRACING
> >       default n
> >       help
> >         This option provides a kernel module that runs performance
> > @@ -42,6 +43,7 @@ config RCU_TORTURE_TEST
> >       tristate "torture tests for RCU"
> >       depends on DEBUG_KERNEL
> >       select TORTURE_TEST
> > +     select TRACING
> >       default n
> >       help
> >         This option provides a kernel module that runs torture tests
> > @@ -102,6 +104,7 @@ config RCU_REF_SCALE_TEST
> >       tristate "Scalability tests for read-side synchronization (RCU an=
d others)"
> >       depends on DEBUG_KERNEL
> >       select TORTURE_TEST
> > +     select TRACING
> >       default n
> >       help
> >         This option provides a kernel module that runs performance test=
s
> > @@ -117,6 +120,7 @@ config HAZPTR_TORTURE_TEST
> >       tristate "Torture tests for hazard pointers"
> >       depends on DEBUG_KERNEL
> >       select TORTURE_TEST
> > +     select TRACING
> >       default n
> >       help
> >         This option provides in-kernel hazard-pointer stress tests.
> > --
> > 2.43.0
> >
