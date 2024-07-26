Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378453032A
	for <rcu@vger.kernel.org>; Fri, 26 Jul 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019198; cv=none; b=i2f08/z0G3FEvSpJaicchMgnCxoWMi2v4KEoOg+TgO+msRx2XTVpKHZLWdaWYwEA1kprpalmn4y298nD+3nWHObLRu3VppWnPEX21XW1AYRt1iS/ITTBuKyt/FRmGJd0p/Nfp46pIzOeAybPwHBVO0jrSiwsTu4jqbnLENnvrKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019198; c=relaxed/simple;
	bh=SHFZd/Wx2l8j5w9ho1f4NNrsFR7QIV2h8mZb/UfzE9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJP9YFbyYBvvWn8H+Fs6VoZsjqSqhDeXeAi1/bsg9TSxTSG2hJvItUrVZUpctKExnYGVRhP9R91hFmvhsuEOSXIDfrH83IV3WD7DNK9x4/5XKHfbPTyHF6x9x+k4mDnlFb5sz4PaklEskW6GoIZkR/NsbazeCdCAQUyvUxeGT5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjaXC++8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjaXC++8"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ed741fe46so1810318e87.0
        for <rcu@vger.kernel.org>; Fri, 26 Jul 2024 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722019195; x=1722623995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnij2KKvjcRGss5B0qb2BUr1AXLHGrtvgaaGU0/dLG0=;
        b=LjaXC++8ei/H+UoskkiDQvt9L4BB8VenKDVG7LG7WKBAGriWKpsVjdFNq8Mcw6a1v7
         i6lxCyionomnn1yPus0Um3EVpMyUU1bAeccJX7IsE5ReDPLEPJo9LWhDV0zuNMwsoAsR
         Aey1unyr4MIVlEnYRPSaQ1gUqm9BOuypkiLBdT0A5nQSKgvGBVenb2CQ89ydr0tgJHeL
         PEK92vpyN/fDlToeEV4PGNiMb9VB5IPjX5tJq0ZH5/WonqW1Mzyu7cYpzOX3SBgBawLw
         6+XUKKN30kujCNir570hfD710SVSYpjQIzVSLZ6qMqkN7l12elNsqZ1L702y4emcapPi
         qupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019195; x=1722623995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnij2KKvjcRGss5B0qb2BUr1AXLHGrtvgaaGU0/dLG0=;
        b=VWWSrH1HgCShnbGTlCFW/uazrs23/WigL327PPVohL+vqdcIMNOsAc9R8qppC0LV5M
         nC1BtnptfDeIISg+RC59DW8i+BAFg5e5pa4kijNxTvumahXog+yecuI+Qq74KF+JrQXF
         g2Ub9uEsTdS+xxH2+FApj4O171mDcCT5zhLLdyEv8ijgN0DBqFi95ijLMzL6YUEW7Crb
         QFALbYhc0XRWU35uiy26vTAQqrvZ3fb7WAv7LK1l1WjZ4DJbQcOaRgnAS2mXPGrYszP0
         h9PGL7u3bW2X2BFtGarqih/gs7nxzit6G5Zh5yUjt8TOE0VJRwTn1Y9d7v9VvmfGuLIv
         U4xw==
X-Forwarded-Encrypted: i=1; AJvYcCV5EXJ6Krd8mgLRIcqkHWcc6PX10qW40EekuVtz5osTsRQMeDW9AXGwfzkEyAWua5Ckx9YxLj8EIFou3cNWu5+pkH4V
X-Gm-Message-State: AOJu0Yz1X2by8719R5PXGo1qjXl3KUJSq4Q+5C5UtTKSkf4mwUXQGMVb
	IZEHL487J6h2BHL94Iy5YIWXMZgr5PD7uxgO6w/MglEFPAt+tDfDfaVRo6ScfdpdbmzxGSFBf2v
	VVSyTU7PGEPY/6eCnGe7IHWtsQdk=
X-Google-Smtp-Source: AGHT+IEEV3xk8aMhkulLOAYA0hKpM+6b1KCYOSOzA5pJgQTSUhYD+IVzrwEVoIhpR9ZBsldxCMqrLC7TIdmIq/g2N+w=
X-Received: by 2002:ac2:568e:0:b0:52c:dcea:86e2 with SMTP id
 2adb3069b0e04-5309b269906mr552274e87.1.1722019194886; Fri, 26 Jul 2024
 11:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-ansonsten-piste-c4f04d4909fc@brauner> <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop>
In-Reply-To: <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 26 Jul 2024 20:39:43 +0200
Message-ID: <CAGudoHHn4bmdR0LetX_bJ1PMtuc6cEYd=hZFutXmqaMG1H+rCg@mail.gmail.com>
Subject: Re: rcu_sync_dtor() warning question
To: paulmck@kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:02=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Jul 26, 2024 at 03:54:28PM +0200, Christian Brauner wrote:
> > Hey,
> >
> > I could use some help with understanding a bug related to rcu that was
> > reported today. It first seems to have shown up on the 25th of July:
> >
> > https://syzkaller.appspot.com/bug?extid=3D20d7e439f76bbbd863a7
> >
> > We seem to be hitting the WARN_ON_ONCE() in:
> >
> > void rcu_sync_dtor(struct rcu_sync *rsp)
> > {
> >         int gp_state;
> >
> >         WARN_ON_ONCE(READ_ONCE(rsp->gp_state) =3D=3D GP_PASSED);
> >
> > from destroy_super_work() which gets called when a superblock is really=
 freed.
> >
> > If the superblock has been visible in userspace we do it via call_rcu()=
:
> >
> > static void destroy_super_work(struct work_struct *work)
> > {
> >         struct super_block *s =3D container_of(work, struct super_block=
,
> >                                                         destroy_work);
> >         fsnotify_sb_free(s);
> >         security_sb_free(s);
> >         put_user_ns(s->s_user_ns);
> >         kfree(s->s_subtype);
> >         for (int i =3D 0; i < SB_FREEZE_LEVELS; i++)
> >                 percpu_free_rwsem(&s->s_writers.rw_sem[i]);
> >         kfree(s);
> > }
> >
> > static void destroy_super_rcu(struct rcu_head *head)
> > {
> >         struct super_block *s =3D container_of(head, struct super_block=
, rcu);
> >         INIT_WORK(&s->destroy_work, destroy_super_work);
> >         schedule_work(&s->destroy_work);
> > }
> >
> > And I'm really confused because I don't understand the details for sync
> > rcu enough to come up with a clear problem statement even. Could someon=
e
> > please explain what the WARN_ON_ONCE() is about?
>
> If I am not too confused (and Oleg will correct me if I am), this is
> checking a use-after-free error.  A given rcu_sync structure normally
> transitions from GP_IDLE->GP_ENTER->GP_PASSED->GP_EXIT->GP_IDLE, with
> possible side-trips from the GP_EXIT state through GP_REPLAY and back
> to GP_EXIT in special cases such as during early boot.
>

use-after-free? In that case I have a candidate for a culprit.

Code prior to any of my changes was doing the following in iget_locked():
        spin_lock(&inode_hash_lock);
        inode =3D find_inode_fast(sb, head, ino);
        spin_unlock(&inode_hash_lock);
        if (inode) {
                if (IS_ERR(inode))
                        return NULL;
                wait_on_inode(inode);
                if (unlikely(inode_unhashed(inode))) {
                        iput(inode);
                        goto again;
                }
                return inode;
        }

My patch removed the spinlock acquire and made it significantly more
likely for the code to end up doing the wait_on_inode + inode_unhashed
combo when racing against inode teardown.

Now that you bring up use-after-free I'm not particularly confident
the stock code is correct.

For example evict_inodes() -> evict() can mess with the inode and
result in the iput() call in iget_locked(), which then will invoke
evict() again. And I'm not particularly confident the routine +
everything it calls is idempotent.

That's from a quick poke around, maybe I missed something.

syzkaller claims to have a reproducer. Trivial usage in my debug vm
does not result in anything, so I may need to grab their entire setup
to reproduce.

I'm going to look into it.
--=20
Mateusz Guzik <mjguzik gmail.com>
