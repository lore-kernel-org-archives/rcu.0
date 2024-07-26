Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40633D3B8
	for <rcu@vger.kernel.org>; Fri, 26 Jul 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019396; cv=none; b=ID0mRiqOQtJx4BK5uk7kXsUwkJJ91THmWZI+AHnSKtTXCj6T36OEeIxLx8jKRxq7LjWypF01Ut+ComtlqzZDqRR2OWP0ft/QJvRuBFLtftIXTNrho+Me9BgUcpFHblR90KweacqK0piU9HaSOzQPPi0C5JMwBf5X6A8P3WMgC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019396; c=relaxed/simple;
	bh=NjBwIbbu9X3IX0WxhC39yGj4qJ39lXos1elzyrliMjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUu4UUXVdFF8Boyr4By8mBTPrlkDf9qUu3JYKwyrYwTB9fiUecIv3aQb7628SJ5Z9iR8BsV8qZdUAGn7765LhPWnSZSpUsRkXOvFIoz/Kxsb1kDJjZ3T2Do/566Cvf5gTk8eiGe0TSPErC2a12E/KYcbqlgv/m/4xo4ei2NGagA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/T6LE0j; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/T6LE0j"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fd513f18bso235349166b.3
        for <rcu@vger.kernel.org>; Fri, 26 Jul 2024 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722019393; x=1722624193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYbBk7Ayap2OYO/fr4sc/2nDSe6720g6YnjfXDpllUs=;
        b=L/T6LE0joe6wpP6G0lvJRW08Ouq/mTTDmA9X1pL625fA8M05qMAjiYCFfBivBCMQVm
         1FyiPWYvlmz4gWk5Nazqrr9I/81/UzYtJ6Yo/ZkfvsTP/gWxM21rXGKJ65vOGatAldrm
         LcpizjPEkj5XVEQxD4fq1RyKWgfJvtKX+EFu0YXnHJTsxeNCPae1r3mZU0KY146tv0Iz
         pPWBRK1ULD3mHqn8nf7u3K+rmojr2UQSuxfBiYRnqGRiA3g2gbkpucazK8n1NjUVQGiC
         rAq2KRSWxXGZbfTBzu/q7oohg0v76QwjqyfLG4z11wS82dnQ5ItaIlWT3OvHtdojPNlS
         qraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019393; x=1722624193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYbBk7Ayap2OYO/fr4sc/2nDSe6720g6YnjfXDpllUs=;
        b=XKn/JTNypc/qRD4W8+EvRIlUMm8dP+nu8HduvuO4zQ8idc3JXkiJVZHct+Xftnj4uS
         wYZBIeFFyffHNF1y9h2bmnyhNIzfXa6x0w1vJpONsvb9G6WAT/Fp1h1kI3pn9zQOiDrG
         7PzT23R3qoCyIlkH/TUCdw5J/VMnCLwABmn1Q1d5i9Vs16g9ENvenp6XI7QQ0Yn/M4Rh
         bZlsOsUMhxCQN/fGxLOoblwzQTTUJUBCS2cX6k2NDepOhmXHor1LH+zK9R7ZhrKfWyxq
         11ydftwpKoVNIdoblqJOIGjnNTFwtE8N302ChuVMZlrBXZenSXV4PfsoxAkIqoF9E0ni
         9vGA==
X-Forwarded-Encrypted: i=1; AJvYcCXFAnk8drjCCWsVTzWv7eTZ76iIivqVw0PqXkPKETybnN6zea0xyqxOU62fF+CT4NJdx63DRaiSzzOtaVZvTMoFKjJw
X-Gm-Message-State: AOJu0Yx3V3YQxXc9IRoyetlxwOEBx1meQDSUK1AB8KWVzMF/TQbt6PvP
	t6pkkw1rgmveyXjva82LZKIYgfNNkqWn1WTF3x/Dyq4qzC9jSlokuxYkQrMkvzvpd2pLCnGWlxm
	meT3Tf7r4NGmRafmH5jzETl8teIEZiZ8A
X-Google-Smtp-Source: AGHT+IHve15Mnfn6fKerYIfK2L5yMwtQuFQBZWyHqWxInkskWcQJEX/ADKXq6gIDH4RxTq5G3Wjks4w+qGDIMy0CdDc=
X-Received: by 2002:a17:907:1c19:b0:a7a:b643:654b with SMTP id
 a640c23a62f3a-a7d40160ea5mr22287466b.50.1722019393117; Fri, 26 Jul 2024
 11:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-ansonsten-piste-c4f04d4909fc@brauner>
 <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop> <CAGudoHHn4bmdR0LetX_bJ1PMtuc6cEYd=hZFutXmqaMG1H+rCg@mail.gmail.com>
In-Reply-To: <CAGudoHHn4bmdR0LetX_bJ1PMtuc6cEYd=hZFutXmqaMG1H+rCg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 26 Jul 2024 20:43:01 +0200
Message-ID: <CAGudoHGznS_Br2gxu=BWsDaCbHmMWRTCmoZDniyFFrDOs9VD5A@mail.gmail.com>
Subject: Re: rcu_sync_dtor() warning question
To: paulmck@kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:39=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Fri, Jul 26, 2024 at 8:02=E2=80=AFPM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> >
> > On Fri, Jul 26, 2024 at 03:54:28PM +0200, Christian Brauner wrote:
> > > Hey,
> > >
> > > I could use some help with understanding a bug related to rcu that wa=
s
> > > reported today. It first seems to have shown up on the 25th of July:
> > >
> > > https://syzkaller.appspot.com/bug?extid=3D20d7e439f76bbbd863a7
> > >
> > > We seem to be hitting the WARN_ON_ONCE() in:
> > >
> > > void rcu_sync_dtor(struct rcu_sync *rsp)
> > > {
> > >         int gp_state;
> > >
> > >         WARN_ON_ONCE(READ_ONCE(rsp->gp_state) =3D=3D GP_PASSED);
> > >
> > > from destroy_super_work() which gets called when a superblock is real=
ly freed.
> > >
> > > If the superblock has been visible in userspace we do it via call_rcu=
():
> > >
> > > static void destroy_super_work(struct work_struct *work)
> > > {
> > >         struct super_block *s =3D container_of(work, struct super_blo=
ck,
> > >                                                         destroy_work)=
;
> > >         fsnotify_sb_free(s);
> > >         security_sb_free(s);
> > >         put_user_ns(s->s_user_ns);
> > >         kfree(s->s_subtype);
> > >         for (int i =3D 0; i < SB_FREEZE_LEVELS; i++)
> > >                 percpu_free_rwsem(&s->s_writers.rw_sem[i]);
> > >         kfree(s);
> > > }
> > >
> > > static void destroy_super_rcu(struct rcu_head *head)
> > > {
> > >         struct super_block *s =3D container_of(head, struct super_blo=
ck, rcu);
> > >         INIT_WORK(&s->destroy_work, destroy_super_work);
> > >         schedule_work(&s->destroy_work);
> > > }
> > >
> > > And I'm really confused because I don't understand the details for sy=
nc
> > > rcu enough to come up with a clear problem statement even. Could some=
one
> > > please explain what the WARN_ON_ONCE() is about?
> >
> > If I am not too confused (and Oleg will correct me if I am), this is
> > checking a use-after-free error.  A given rcu_sync structure normally
> > transitions from GP_IDLE->GP_ENTER->GP_PASSED->GP_EXIT->GP_IDLE, with
> > possible side-trips from the GP_EXIT state through GP_REPLAY and back
> > to GP_EXIT in special cases such as during early boot.
> >
>
> use-after-free? In that case I have a candidate for a culprit.
>
> Code prior to any of my changes was doing the following in iget_locked():
>         spin_lock(&inode_hash_lock);
>         inode =3D find_inode_fast(sb, head, ino);
>         spin_unlock(&inode_hash_lock);
>         if (inode) {
>                 if (IS_ERR(inode))
>                         return NULL;
>                 wait_on_inode(inode);
>                 if (unlikely(inode_unhashed(inode))) {
>                         iput(inode);
>                         goto again;
>                 }
>                 return inode;
>         }
>
> My patch removed the spinlock acquire and made it significantly more
> likely for the code to end up doing the wait_on_inode + inode_unhashed
> combo when racing against inode teardown.
>
> Now that you bring up use-after-free I'm not particularly confident
> the stock code is correct.
>
> For example evict_inodes() -> evict() can mess with the inode and
> result in the iput() call in iget_locked(), which then will invoke
> evict() again. And I'm not particularly confident the routine +
> everything it calls is idempotent.
>
> That's from a quick poke around, maybe I missed something.
>
> syzkaller claims to have a reproducer. Trivial usage in my debug vm
> does not result in anything, so I may need to grab their entire setup
> to reproduce.
>
> I'm going to look into it.

Welp.

syzbot did the bisect, it's not any of the above, instead:

commit b62e71be2110d8b52bf5faf3c3ed7ca1a0c113a5
Author: Chao Yu <chao@kernel.org>
Date:   Sun Apr 23 15:49:15 2023 +0000

    f2fs: support errors=3Dremount-ro|continue|panic mountoption

https://lore.kernel.org/linux-fsdevel/0000000000004ff2dc061e281637@google.c=
om/T/#m90c03813e12e5cdff1eeada8f9ab581d5f039c76

That said, the stuff I mentioned still looks highly suspicious so I
have to something to investigate regardless.

I think this thread can be abandoned. :)
--=20
Mateusz Guzik <mjguzik gmail.com>
