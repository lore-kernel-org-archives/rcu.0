Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433E130A7D
	for <rcu@vger.kernel.org>; Mon, 29 Jul 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241688; cv=none; b=cCKeLpce+yRg6L+c++tTorrPiAY9nKSMm3CKXXvkjPwY4R6xtUrPOXOsEdQnf0PUCz0Ybw7aFotA/HWY+PEqlX/XhVBeeQMxrstSj7wLnelpmEiNfOFmE/EQwFJtAQrnHcG34Ovpji6IFgSUUot2mFdj+/cf1pYQ1XWKaWbV0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241688; c=relaxed/simple;
	bh=kEIAHE+1zNG2fxIXg0V96b/zU5D7wc7578eXAWr2oz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDTQ3qysqIwtk6SiGoCX7ndPyv2FJCpmXFVclquf5tjuih8fWwiAnlC0DZMOc+dQpR3jhc0lhHAGQu9pvDrg0CDuZ7LP0O70UCohAHNoJS+kq/ykKwRa1CUQAQ7BgaBn3TmW27nAlKuVGApLbasYyFW/kpBG2/fHvyt6tZchsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DByehIzN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DByehIzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D311FC32786;
	Mon, 29 Jul 2024 08:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722241687;
	bh=kEIAHE+1zNG2fxIXg0V96b/zU5D7wc7578eXAWr2oz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DByehIzN9RY2aJj2PhK6eAgdDBcat7lsk/5hVUjBsCiK7iiHm+JnxTBnDZ0LUf8Wo
	 0OFrijY6bDUxE5z8JP/lW1LdNC0TxBDhxxJBxSryvWs/Y/plsTi0MQXfDiwzcADwbQ
	 pLbwYjb6Y1KGCqIQd3zX22bW23w9+1qfe1ud099q9I1sGTDRG/DKr1NEeG2OpNtFaR
	 S8tSp8F1hvcjdc657AWgZazoPvkrPP+byLfBzXF5tv5fnwWlTI2jeAvyYyiD01oN/N
	 Jhot7hvrplCNCygpfaG+NtLLMunlgnEKpd/PgaA/lCKvFKAvb6xNyNO4DTs6boUBhK
	 7CKIf6awu5TWA==
Date: Mon, 29 Jul 2024 10:28:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paulmck@kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	rcu@vger.kernel.org
Subject: Re: rcu_sync_dtor() warning question
Message-ID: <20240729-atelier-einreden-aac41d1211bf@brauner>
References: <20240726-ansonsten-piste-c4f04d4909fc@brauner>
 <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop>
 <CAGudoHHn4bmdR0LetX_bJ1PMtuc6cEYd=hZFutXmqaMG1H+rCg@mail.gmail.com>
 <CAGudoHGznS_Br2gxu=BWsDaCbHmMWRTCmoZDniyFFrDOs9VD5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGznS_Br2gxu=BWsDaCbHmMWRTCmoZDniyFFrDOs9VD5A@mail.gmail.com>

On Fri, Jul 26, 2024 at 08:43:01PM GMT, Mateusz Guzik wrote:
> On Fri, Jul 26, 2024 at 8:39 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Fri, Jul 26, 2024 at 8:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Jul 26, 2024 at 03:54:28PM +0200, Christian Brauner wrote:
> > > > Hey,
> > > >
> > > > I could use some help with understanding a bug related to rcu that was
> > > > reported today. It first seems to have shown up on the 25th of July:
> > > >
> > > > https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
> > > >
> > > > We seem to be hitting the WARN_ON_ONCE() in:
> > > >
> > > > void rcu_sync_dtor(struct rcu_sync *rsp)
> > > > {
> > > >         int gp_state;
> > > >
> > > >         WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
> > > >
> > > > from destroy_super_work() which gets called when a superblock is really freed.
> > > >
> > > > If the superblock has been visible in userspace we do it via call_rcu():
> > > >
> > > > static void destroy_super_work(struct work_struct *work)
> > > > {
> > > >         struct super_block *s = container_of(work, struct super_block,
> > > >                                                         destroy_work);
> > > >         fsnotify_sb_free(s);
> > > >         security_sb_free(s);
> > > >         put_user_ns(s->s_user_ns);
> > > >         kfree(s->s_subtype);
> > > >         for (int i = 0; i < SB_FREEZE_LEVELS; i++)
> > > >                 percpu_free_rwsem(&s->s_writers.rw_sem[i]);
> > > >         kfree(s);
> > > > }
> > > >
> > > > static void destroy_super_rcu(struct rcu_head *head)
> > > > {
> > > >         struct super_block *s = container_of(head, struct super_block, rcu);
> > > >         INIT_WORK(&s->destroy_work, destroy_super_work);
> > > >         schedule_work(&s->destroy_work);
> > > > }
> > > >
> > > > And I'm really confused because I don't understand the details for sync
> > > > rcu enough to come up with a clear problem statement even. Could someone
> > > > please explain what the WARN_ON_ONCE() is about?
> > >
> > > If I am not too confused (and Oleg will correct me if I am), this is
> > > checking a use-after-free error.  A given rcu_sync structure normally
> > > transitions from GP_IDLE->GP_ENTER->GP_PASSED->GP_EXIT->GP_IDLE, with
> > > possible side-trips from the GP_EXIT state through GP_REPLAY and back
> > > to GP_EXIT in special cases such as during early boot.
> > >
> >
> > use-after-free? In that case I have a candidate for a culprit.
> >
> > Code prior to any of my changes was doing the following in iget_locked():
> >         spin_lock(&inode_hash_lock);
> >         inode = find_inode_fast(sb, head, ino);
> >         spin_unlock(&inode_hash_lock);
> >         if (inode) {
> >                 if (IS_ERR(inode))
> >                         return NULL;
> >                 wait_on_inode(inode);
> >                 if (unlikely(inode_unhashed(inode))) {
> >                         iput(inode);
> >                         goto again;
> >                 }
> >                 return inode;
> >         }
> >
> > My patch removed the spinlock acquire and made it significantly more
> > likely for the code to end up doing the wait_on_inode + inode_unhashed
> > combo when racing against inode teardown.
> >
> > Now that you bring up use-after-free I'm not particularly confident
> > the stock code is correct.
> >
> > For example evict_inodes() -> evict() can mess with the inode and
> > result in the iput() call in iget_locked(), which then will invoke
> > evict() again. And I'm not particularly confident the routine +
> > everything it calls is idempotent.
> >
> > That's from a quick poke around, maybe I missed something.
> >
> > syzkaller claims to have a reproducer. Trivial usage in my debug vm
> > does not result in anything, so I may need to grab their entire setup
> > to reproduce.
> >
> > I'm going to look into it.
> 
> Welp.
> 
> syzbot did the bisect, it's not any of the above, instead:
> 
> commit b62e71be2110d8b52bf5faf3c3ed7ca1a0c113a5
> Author: Chao Yu <chao@kernel.org>
> Date:   Sun Apr 23 15:49:15 2023 +0000
> 
>     f2fs: support errors=remount-ro|continue|panic mountoption
> 
> https://lore.kernel.org/linux-fsdevel/0000000000004ff2dc061e281637@google.com/T/#m90c03813e12e5cdff1eeada8f9ab581d5f039c76
> 
> That said, the stuff I mentioned still looks highly suspicious so I
> have to something to investigate regardless.

Thanks for looking into this! 
