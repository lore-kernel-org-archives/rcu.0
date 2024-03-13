Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF54B481AA
	for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345723; cv=none; b=JjIzLgkATJG7Z6ySPQmOZC+VDGhDfSiuGxza1J4gO3b0ke6TxFVW9v1nr1sxIjXujxf/nsLqdlXOowsmHqnobnZm52lYby/cax7Wfa/uazBT5nKXymDSjHeKub+EcQinO4hBCjdJE4gHlMbECgKUTBd1f0TEcaO+wHmnWKG9oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345723; c=relaxed/simple;
	bh=skEFlYVRbGKrwaoRI9SBnK72i4qW8cNFfPFUKmMt/V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/3JOSkXX+YpOXXnNBXNY/b0T4NzVijX4+O9VJ/2zPexJUZKTSbl/u3b+fJXRYpI5LB3s2KLGFpHTZgg2j44cVmC4cLlDaAjGRUbPvcsog0Rag3zKSYt4QxHQGtqJy5aZlLo725rKSv1SxLJX+KSyHG6Lav39c3P2c2aKMtjqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=QnkD+bn7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QnkD+bn7"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d2505352e6so15675651fa.3
        for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710345719; x=1710950519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhI7fuOW7O94CdymJJXoJUrg+PQKoUQdDuMwFu4gOLk=;
        b=QnkD+bn71GHRBfgc2+oSSOVxJjg7U9yLCwoek6EifD2I2yLHdXnWMA/utDeelZjPVS
         3wBbvzkX+2tI82+N4Y2GQ4/JUz2q0VA9k5sLZ61XoZmid8cfkRR1QOAzQM1/xTwsDk6P
         19ZqznP79EZXH9VUbFd/XBScIXpM7kSFSNdME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710345719; x=1710950519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhI7fuOW7O94CdymJJXoJUrg+PQKoUQdDuMwFu4gOLk=;
        b=u7inuAY7PvEdkK3pbuACsJ4llZN3U577Vv+uNWBsoFWNV56utxtdFG6AZ0BtF0Dtt3
         /mhmAFN+ZgGXAgZvppIzstJAjl4flH0kPCci0Cv5YOBxNJj/+iqWOhuUDW8endBI5HD+
         Zj8mYorfStNv66Ms/JuMM5NiZ7Yjk/KoUESjjuuFW3A9RAJ3WwRtRkARQaZfTxhe+Ybo
         bTHyhZVn566zVajVJRnpxLtTSYlIMs64B5DyH63Cu2jn4nHtdNdSDFaisyWWJnyyoNtt
         4w7OaTX8qdsLPPQGP1XaJS6PNXmZ6/KnhZ1RuD8dnF1PgOvhZZS6jaum7JJYINAYSytr
         /KUA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ89N2eCOrMhMjUwqTbhPoiy3rueuNDNsfGufMP0l1G0eCKWLRkoa0b8lSjiYfucaoICSZ712VfceUdFxO5z2W6/jO
X-Gm-Message-State: AOJu0Yy6B7yTNeySbLlhzv5HRBVr1UjXh44EccmyU89GGsFAN8wAc66W
	eAk477wqeP5rRYgJ+hsewA6BexeMoTIf6C0BP2drnX6shtHyMPWLXsygIi5w+SQQvfdfpN/na1L
	RvMt8MA19Tk8f0zLrp/vBzgeqXd92jlVv0OLgYA==
X-Google-Smtp-Source: AGHT+IEB+ypKw1227kSwoEpCb58giwsbWQ7T3kqHZKNM52jxhQC6RiCthXFaTfppDX19xNPkqW1S/iblz4CA4LMGbpA=
X-Received: by 2002:a05:651c:3c9:b0:2d4:6e5:2cd6 with SMTP id
 f9-20020a05651c03c900b002d406e52cd6mr2361699ljp.25.1710345718592; Wed, 13 Mar
 2024 09:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZetHwrCb0KXE0xFI@tardis> <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux> <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com> <ZfDptafiK0jns050@boqun-archlinux>
In-Reply-To: <ZfDptafiK0jns050@boqun-archlinux>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 13 Mar 2024 12:01:45 -0400
Message-ID: <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for v6.9]
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org, 
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, 
	neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	frederic@kernel.org, bigeasy@linutronix.de, anna-maria@linutronix.de, 
	chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Florian,

On Tue, Mar 12, 2024 at 7:48=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Mar 12, 2024 at 02:44:14PM -0700, Linus Torvalds wrote:
> > On Tue, 12 Mar 2024 at 14:34, Florian Fainelli <f.fainelli@gmail.com> w=
rote:
> > >
> > > and here is a log where this fails:
> > >
> > > https://gist.github.com/ffainelli/ed08a2b3e853f59343786ebd20364fc8
> >
> > You could try the 'initcall_debug' kernel command line.
> >
>
> Right, that'll be helpful.
>
> Besides I took a look at the config Florian shared, no TASKS_RCU,
> RCU_LAZY or RCU nocb is enabled. So probably the only left changes in
> the PR are around RCU expedited. Florian, could you see if you can build
> and test with CONFIG_PROVE_RCU=3Dy (you need to select
> CONFIG_PROVE_LOCKING for that)? That'll call synchronize_rcu() +
> synchronize_rcu_expedited() before and after we switch
> rcu_scheduler_active, and it may provide more information. Thanks!

Adding to everyone's suggestions, could you also try booting with
"rcupdate.rcu_normal=3D1" ? This will disable expedited RCU and help us
further confirm that it is indeed expedited RCU (and then we can look
into fixing that).

Also there are 2 additional users of expedited RCU in this release I notice=
d:

78c3253f27e5 ("net: use synchronize_rcu_expedited in cleanup_net()")
1ebb85f9c03d ("netfilter: conntrack: expedite rcu in
nf_conntrack_cleanup_net_list")

Could you also try reverting those patches as well, and see if the
issue goes away?

thanks,

 - Joel

On Tue, Mar 12, 2024 at 7:48=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Mar 12, 2024 at 02:44:14PM -0700, Linus Torvalds wrote:
> > On Tue, 12 Mar 2024 at 14:34, Florian Fainelli <f.fainelli@gmail.com> w=
rote:
> > >
> > > and here is a log where this fails:
> > >
> > > https://gist.github.com/ffainelli/ed08a2b3e853f59343786ebd20364fc8
> >
> > You could try the 'initcall_debug' kernel command line.
> >
>
> Right, that'll be helpful.
>
> Besides I took a look at the config Florian shared, no TASKS_RCU,
> RCU_LAZY or RCU nocb is enabled. So probably the only left changes in
> the PR are around RCU expedited. Florian, could you see if you can build
> and test with CONFIG_PROVE_RCU=3Dy (you need to select
> CONFIG_PROVE_LOCKING for that)? That'll call synchronize_rcu() +
> synchronize_rcu_expedited() before and after we switch
> rcu_scheduler_active, and it may provide more information. Thanks!
>
> Regards,
> Boqun
>
> > It will make the above *much* noisier, but it might - thanks to all
> > the new noise - show exactly *what* is being crazy slow to initialize.
> >
> > Because right now it's just radio silence in between those
> >
> >   [    1.926435] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
> >   [  162.148135] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> >
> > things, and that's presumably because some random initcall there just
> > takes forever to time out.
> >
> >              Linus
