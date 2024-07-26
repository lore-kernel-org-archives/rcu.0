Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4F48CDD
	for <rcu@vger.kernel.org>; Fri, 26 Jul 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025285; cv=none; b=QcFZRGDa6wFT9whzR0MPTN8Lgd6gmkz3C9XcS3mH7XrSwJmt7nAwmiS7XzLONk+13ezVz86DKlzb6gwMPHWZXHWqRRNMwn5WBSpHpqXNqL/t1RMHe36RsEF67AFNJhPHnLnUq+VESUjEwN12urvyAcjCcnJjlbWMGETA5EGxCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025285; c=relaxed/simple;
	bh=a6ZXrkf9umHvV+1/O8eCn8GxbhlE+y6tqgq0uCwMQtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1nHydFtn5y/d+JKlRf3+0vtDb97o2Jq56Mu1ml79Bdzf1xZWVXoBTNkwh5NxBX30MJfrYl8Esyms9dvKSMQpqoNiD6b2qSv+frUlEKfd9YKhz85bGpBslL70aj09GU2s4LGgnzhEq5b4CX87iBMwCguvromj+95bu9c6wcTUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl2IvG2g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl2IvG2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C91C32782;
	Fri, 26 Jul 2024 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722025285;
	bh=a6ZXrkf9umHvV+1/O8eCn8GxbhlE+y6tqgq0uCwMQtw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kl2IvG2go7A2CNLpuLnCJy8A+dUc+kycpPX6OmPMmuAPzgiua03Y//MhHnuij7kU0
	 bmjkMXGilLNH7gxGdnQiJI5ZXz31qwrJxh5A/XnNOcck0bRZmjHgusyxZKPRCpBcF8
	 XJGXKndDU0XmBIH+k3XRMS16+mCVCqvihvDEbs0HWdYLEUQE9c6p74tVsLn6DKuZsC
	 CrO+dAE+s6unfRZBhbREez9/2sS3gt8tUnvKlIDZLt+D54XwmtXm1gHwlte3fzh+3Y
	 6e3mfI8xNnVTPTCbz7fwJ1vLfcB1CtsN8r15NtPh05l2Xp7d/O9P5MESoib/b2ifaO
	 +Xi0N21azCEdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38D5FCE0B34; Fri, 26 Jul 2024 13:21:25 -0700 (PDT)
Date: Fri, 26 Jul 2024 13:21:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	rcu@vger.kernel.org
Subject: Re: rcu_sync_dtor() warning question
Message-ID: <110a1014-f4b9-4f85-9ffa-49adb50dc3e6@paulmck-laptop>
Reply-To: paulmck@kernel.org
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

On Fri, Jul 26, 2024 at 08:43:01PM +0200, Mateusz Guzik wrote:
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
> 
> I think this thread can be abandoned. :)

Thank you for digging into this one!

							Thanx, Paul
